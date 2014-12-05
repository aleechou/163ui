-- Confused about mix of CamelCase and_underscores?
-- Camel case comes from copypasta of how Blizzard calls returns/fields in their code and deriveates
-- Underscore are my own variables

local dump = DevTools_Dump
local tinsert = table.insert
local tsort = table.sort
local wipe = wipe
local next = next
local pairs = pairs
local GARRISON_CURRENCY = GARRISON_CURRENCY
local GarrisonMissionFrame = GarrisonMissionFrame
local GarrisonLandingPage = GarrisonLandingPage
local GarrisonRecruitSelectFrame = GarrisonRecruitSelectFrame
local MissionPage = GarrisonMissionFrame.MissionTab.MissionPage
local AddFollowerToMission = C_Garrison.AddFollowerToMission
local GetPartyMissionInfo = C_Garrison.GetPartyMissionInfo
local RemoveFollowerFromMission = C_Garrison.RemoveFollowerFromMission
local GARRISON_FOLLOWER_IN_PARTY = GARRISON_FOLLOWER_IN_PARTY
local GetFramesRegisteredForEvent = GetFramesRegisteredForEvent

local _, _, garrison_currency_texture = GetCurrencyInfo(GARRISON_CURRENCY)
garrison_currency_texture = "|T" .. garrison_currency_texture .. ":0|t"
local time_texture = "|TInterface\\Icons\\spell_holy_borrowedtime:0|t"

local top_for_mission = {}
local top_for_mission_dirty = true

local filtered_followers = {}
local filtered_followers_count
local filtered_followers_dirty = true

local event_frame = CreateFrame("Frame")
local events_filtered_followers_dirty = {
   GARRISON_FOLLOWER_LIST_UPDATE = true,
   GARRISON_FOLLOWER_XP_CHANGED = true,
   GARRISON_FOLLOWER_REMOVED = true,
}
local events_top_for_mission_dirty = {
   GARRISON_MISSION_NPC_OPENED = true,
   GARRISON_MISSION_LIST_UPDATE = true,
}
event_frame:SetScript("OnEvent", function(self, event)
   -- if events_top_for_mission_dirty[event] then top_for_mission_dirty = true end
   -- if events_filtered_followers_dirty[event] then filtered_followers_dirty = true end
   -- Let's clear both for now, or else we often miss one follower state update when we start mission
   if events_top_for_mission_dirty[event] or events_filtered_followers_dirty[event] then
      top_for_mission_dirty = true
      filtered_followers_dirty = true
   end
end)
for event in pairs(events_top_for_mission_dirty) do event_frame:RegisterEvent(event) end
for event in pairs(events_filtered_followers_dirty) do event_frame:RegisterEvent(event) end

local gmm_buttons = {}
local mission_page_pending_click

function GMM_dumpl(pattern, ...)
   local names = { strsplit(",", pattern) }
   for idx = 1, select('#', ...) do
      local name = names[idx]
      if name then name = name:gsub("^%s+", ""):gsub("%s+$", "") end
      print(GREEN_FONT_COLOR_CODE, idx, name, FONT_COLOR_CODE_CLOSE)
      dump((select(idx, ...)))
   end
end

local min, max = {}, {}
local top = {{}, {}, {}, {}}
local function FindBestFollowersForMission(mission, followers)
   local followers_count = #followers

   for idx = 1, 3 do
      wipe(top[idx])
   end

   local slots = mission.numFollowers
   if slots > followers_count then return end

   local event_handlers = { GetFramesRegisteredForEvent("GARRISON_FOLLOWER_LIST_UPDATE") }
   for idx = 1, #event_handlers do event_handlers[idx]:UnregisterEvent("GARRISON_FOLLOWER_LIST_UPDATE") end

   local mission_id = mission.missionID
   if C_Garrison.GetNumFollowersOnMission(mission_id) > 0 then
      for idx = 1, #followers do
         RemoveFollowerFromMission(mission_id, followers[idx].followerID)
      end
   end

   for idx = 1, slots do
      max[idx] = followers_count - slots + idx
      min[idx] = nil
   end
   for idx = slots+1, 3 do
      max[idx] = followers_count + 1
      min[idx] = followers_count + 1
   end

   local currency_rewards
   local xp_only_rewards
   for _, reward in pairs(mission.rewards) do
      if reward.currencyID == GARRISON_CURRENCY then currency_rewards = true end
      if reward.followerXP and xp_only_rewards == nil then xp_only_rewards = true end
      if not reward.followerXP then xp_only_rewards = false end
   end

   for i1 = 1, max[1] do
      local follower1 = followers[i1]
      local follower1_id = follower1.followerID
      local follower1_maxed = follower1.levelXP == 0 and 1 or 0
      for i2 = min[2] or (i1 + 1), max[2] do
         local follower2_maxed = 0
         local follower2 = followers[i2]
         local follower2_id
         if follower2 then
            follower2_id = follower2.followerID
            if follower2.levelXP == 0 then follower2_maxed = 1 end
         end
         for i3 = min[3] or (i2 + 1), max[3] do
            local follower3 = followers[i3]
            local followers_maxed = follower1_maxed + follower2_maxed + ((follower3 and follower3.levelXP == 0) and 1 or 0)
            -- On follower XP-only missions throw away any team that is completely filled with maxed out followers
            if xp_only_rewards and slots == followers_maxed then break end
            local follower3_id = follower3 and follower3.followerID

            -- Assign followers to mission
            if not AddFollowerToMission(mission_id, follower1_id) then --[[ error handling! ]] end
            if follower2 and not AddFollowerToMission(mission_id, follower2_id) then --[[ error handling! ]] end
            if follower3 and not AddFollowerToMission(mission_id, follower3_id) then --[[ error handling! ]] end

            -- Calculate result
            local totalTimeString, totalTimeSeconds, isMissionTimeImproved, successChance, partyBuffs, isEnvMechanicCountered, xpBonus, materialMultiplier = GetPartyMissionInfo(mission_id)
            isEnvMechanicCountered = isEnvMechanicCountered and 1 or 0
            local buffCount = #partyBuffs
            for idx = 1, 3 do
               local current = top[idx]
               local found
               repeat -- Checking if new candidate for top is better than any top 3 already sored
                  -- TODO: risk lower chance mission if material multiplier gives better average result
                  if not current[1] then found = true break end

                  local cSuccessChance = current.successChance
                  if cSuccessChance < successChance then found = true break end
                  if cSuccessChance > successChance then break end

                  if currency_rewards then
                     local cMaterialMultiplier = current.materialMultiplier
                     if cMaterialMultiplier < materialMultiplier then found = true break end
                     if cMaterialMultiplier > materialMultiplier then break end
                  end

                  if xp_only_rewards then
                     local c_followers_maxed = current.followers_maxed
                     if c_followers_maxed > followers_maxed then found = true break end
                     if c_followers_maxed < followers_maxed then break end
                  end

                  if slots ~= followers_maxed then -- only care about XP multiplier if team is not full of maxed followers
                     local cXpBonus = current.xpBonus
                     if cXpBonus < xpBonus then found = true break end
                     if cXpBonus > xpBonus then break end
                  end

                  local cTotalTimeSeconds = current.totalTimeSeconds
                  if cTotalTimeSeconds > totalTimeSeconds then found = true break end
                  if cTotalTimeSeconds < totalTimeSeconds then break end

                  local cBuffCount = current.buffCount
                  if cBuffCount > buffCount then found = true break end
                  if cBuffCount < buffCount then break end

                  local cIsEnvMechanicCountered = current.isEnvMechanicCountered
                  if cIsEnvMechanicCountered > isEnvMechanicCountered then found = true break end
                  if cIsEnvMechanicCountered < isEnvMechanicCountered then break end
               until true
               if found then
                  local new = top[4]
                  new[1] = follower1
                  new[2] = follower2
                  new[3] = follower3
                  new.successChance = successChance
                  new.materialMultiplier = materialMultiplier
                  new.currency_rewards = currency_rewards
                  new.xpBonus = xpBonus
                  new.totalTimeSeconds = totalTimeSeconds
                  new.isMissionTimeImproved = isMissionTimeImproved
                  new.followers_maxed = followers_maxed
                  new.buffCount = buffCount
                  new.isEnvMechanicCountered = isEnvMechanicCountered
                  tinsert(top, idx, new)
                  top[5] = nil
                  break
               end
            end

            -- Unasssign
            RemoveFollowerFromMission(mission_id, follower1_id)
            if follower2 then RemoveFollowerFromMission(mission_id, follower2_id) end
            if follower3 then RemoveFollowerFromMission(mission_id, follower3_id) end
         end
      end
   end
   -- dump(top[1])

   for idx = 1, #event_handlers do event_handlers[idx]:RegisterEvent("GARRISON_FOLLOWER_LIST_UPDATE") end

   -- dump(top)
   -- local location, xp, environment, environmentDesc, environmentTexture, locPrefix, isExhausting, enemies = C_Garrison.GetMissionInfo(missionID);
   -- /run GMM_dumpl("location, xp, environment, environmentDesc, environmentTexture, locPrefix, isExhausting, enemies", C_Garrison.GetMissionInfo(GarrisonMissionFrame.MissionTab.MissionPage.missionInfo.missionID))
   -- /run GMM_dumpl("totalTimeString, totalTimeSeconds, isMissionTimeImproved, successChance, partyBuffs, isEnvMechanicCountered, xpBonus, materialMultiplier", C_Garrison.GetPartyMissionInfo(GarrisonMissionFrame.MissionTab.MissionPage.missionInfo.missionID))
end

local function SortFollowersByLevel(a, b)
   local a_level = a.level
   local b_level = b.level
   if a_level ~= b_level then return a_level > b_level end
   return a.iLevel > b.iLevel
end

local function GetFilteredFollowers()
   if not filtered_followers_dirty then
      return filtered_followers, filtered_followers_count
   end

   local followers = C_Garrison.GetFollowers()
   wipe(filtered_followers)
   filtered_followers_count = 0
   for idx = 1, #followers do
      local follower = followers[idx]
      repeat
         if not follower.isCollected then break end
         local status = follower.status
         if status and status ~= GARRISON_FOLLOWER_IN_PARTY then break end

         filtered_followers_count = filtered_followers_count + 1
         filtered_followers[filtered_followers_count] = follower
      until true
   end

   tsort(filtered_followers, SortFollowersByLevel)

   -- dump(filtered_followers)
   filtered_followers_dirty = false
   top_for_mission_dirty = true
   return filtered_followers, filtered_followers_count
end

local function SetTeamButtonText(button, top_entry)
   if top_entry.successChance then
      button:SetFormattedText(
         "%d%%\n%s%s%s",
         top_entry.successChance,
         top_entry.xpBonus > 0 and top_entry.xpBonus .. " |TInterface\\Icons\\XPBonus_Icon:0|t" or "",
         (top_entry.currency_rewards and top_entry.materialMultiplier > 1) and garrison_currency_texture or "",
         top_entry.isMissionTimeImproved and time_texture or ""
      )
   else
      button:SetText("")
   end
end

local available_missions = {}
local function BestForCurrentSelectedMission()
   local missionInfo = MissionPage.missionInfo
   local mission_id = missionInfo.missionID

   -- print("Mission ID:", mission_id)

   local filtered_followers, filtered_followers_count = GetFilteredFollowers()

   C_Garrison.GetAvailableMissions(available_missions)
   local mission
   for idx = 1, #available_missions do
      if available_missions[idx].missionID == mission_id then
         mission = available_missions[idx]
         break
      end
   end

   -- dump(mission)

   FindBestFollowersForMission(mission, filtered_followers)

   for idx = 1, 3 do
      local button = gmm_buttons['MissionPage' .. idx]
      local top_entry = top[idx]
      button[1] = top_entry[1] and top_entry[1].followerID or nil
      button[2] = top_entry[2] and top_entry[2].followerID or nil
      button[3] = top_entry[3] and top_entry[3].followerID or nil
      if top_entry.successChance then
         button:SetFormattedText(
            "%d%%\n%s%s%s",
            top_entry.successChance,
            top_entry.xpBonus > 0 and top_entry.xpBonus .. " |TInterface\\Icons\\XPBonus_Icon:0|t" or "",
            (top_entry.currency_rewards and top_entry.materialMultiplier > 1) and garrison_currency_texture or "",
            top_entry.isMissionTimeImproved and time_texture or ""
         )
      else
         button:SetText("")
      end
   end

   if mission_page_pending_click then
      gmm_buttons['MissionPage' .. mission_page_pending_click]:Click()
      mission_page_pending_click = nil
   end
end

local function MissionPage_PartyButtonOnClick(self)
   if self[1] then
      event_frame:UnregisterEvent("GARRISON_FOLLOWER_LIST_UPDATE")
      local MissionPageFollowers = GarrisonMissionFrame.MissionTab.MissionPage.Followers
      for idx = 1, #MissionPageFollowers do
         GarrisonMissionPage_ClearFollower(MissionPageFollowers[idx])
      end

      for idx = 1, #MissionPageFollowers do
         local followerFrame = MissionPageFollowers[idx]
         local follower = self[idx]
         if follower then
            local followerInfo = C_Garrison.GetFollowerInfo(follower)
            GarrisonMissionPage_SetFollower(followerFrame, followerInfo)
         end
      end
      event_frame:RegisterEvent("GARRISON_FOLLOWER_LIST_UPDATE")
   end

   GarrisonMissionPage_UpdateMissionForParty()
end

local function MissionList_PartyButtonOnClick(self)
   -- mission_page_pending_click = 1
   return self:GetParent():Click()
end

-- Add more data to mission list over Blizzard's own
-- GarrisonMissionList_Update
local function GarrisonMissionList_Update_More()
   local self = GarrisonMissionFrame.MissionTab.MissionList
   local scrollFrame = self.listScroll
   local buttons = scrollFrame.buttons
   local numButtons = #buttons

   if self.showInProgress then
      for i = 1, numButtons do
         gmm_buttons['MissionList' .. i]:Hide()
         buttons[i]:SetAlpha(1)
      end
      return
   end

   local missions = self.availableMissions
   local numMissions = #missions
   if numMissions == 0 then return end

   if top_for_mission_dirty then
      wipe(top_for_mission)
      top_for_mission_dirty = false
   end

   local missions = self.availableMissions
   local offset = HybridScrollFrame_GetOffset(scrollFrame)

   local filtered_followers, filtered_followers_count = GetFilteredFollowers()
   local more_missions_to_cache

   for i = 1, numButtons do
      local button = buttons[i]
      local alpha = 1
      local index = offset + i
      if index <= numMissions then
         local mission = missions[index]
         local gmm_button = gmm_buttons['MissionList' .. i]
         if mission.numFollowers > filtered_followers_count then
            button:SetAlpha(0.3)
            gmm_button:SetText("")
         else
            local top_for_this_mission = top_for_mission[mission.missionID]
            if not top_for_this_mission then
               if more_missions_to_cache then
                  more_missions_to_cache = more_missions_to_cache + 1
               else
                  more_missions_to_cache = 0
                  FindBestFollowersForMission(mission, filtered_followers)
                  local top1 = top[1]
                  top_for_this_mission = {}
                  top_for_this_mission.successChance = top1.successChance
                  if top_for_this_mission.successChance then
                     top_for_this_mission.materialMultiplier = top1.materialMultiplier
                     top_for_this_mission.currency_rewards = top1.currency_rewards
                     top_for_this_mission.xpBonus = top1.xpBonus
                     top_for_this_mission.isMissionTimeImproved = top1.isMissionTimeImproved
                  end
                  top_for_mission[mission.missionID] = top_for_this_mission
               end
            end

            if top_for_this_mission then
               SetTeamButtonText(gmm_button, top_for_this_mission)
            else
               gmm_button:SetText("...")
            end
            button:SetAlpha(1)
         end
         gmm_button:Show()
      end
   end

   if more_missions_to_cache and more_missions_to_cache > 0 then
      -- print(more_missions_to_cache, GetTime())
      C_Timer.After(0.001, GarrisonMissionList_Update_More)
   end
end
hooksecurefunc("GarrisonMissionList_Update", GarrisonMissionList_Update_More)
hooksecurefunc(GarrisonMissionFrame.MissionTab.MissionList.listScroll, "update", GarrisonMissionList_Update_More)

local function MissionPage_ButtonsInit()
   local prev
   for idx = 1, 3 do
      if not gmm_buttons['MissionPage' .. idx] then
         local set_followers_button = CreateFrame("Button", nil, GarrisonMissionFrame.MissionTab.MissionPage, "UIPanelButtonTemplate")
         set_followers_button:SetText(idx)
         set_followers_button:SetWidth(100)
         set_followers_button:SetHeight(50)
         if not prev then
            set_followers_button:SetPoint("TOPLEFT", GarrisonMissionFrame.MissionTab.MissionPage, "TOPRIGHT", 0, 0)
         else
            set_followers_button:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, 0)
         end
         set_followers_button:SetScript("OnClick", MissionPage_PartyButtonOnClick)
         set_followers_button:Show()
         prev = set_followers_button
         gmm_buttons['MissionPage' .. idx] = set_followers_button
      end
   end
end

local function MissionList_ButtonsInit()
   local level_anchor = GarrisonMissionFrame.MissionTab.MissionList.listScroll
   local blizzard_buttons = GarrisonMissionFrame.MissionTab.MissionList.listScroll.buttons
   for idx = 1, #blizzard_buttons do
      if not gmm_buttons['MissionList' .. idx] then
         local blizzard_button = blizzard_buttons[idx]

         -- move first reward to left a little, rest are anchored to first
         local reward = blizzard_button.Rewards[1]
         for point_idx = 1, reward:GetNumPoints() do
            local point, relative_to, relative_point, x, y = reward:GetPoint(point_idx)
            if point == "RIGHT" then
               x = x - 60
               reward:SetPoint(point, relative_to, relative_point, x, y)
               break
            end
         end

         local set_followers_button = CreateFrame("Button", nil, blizzard_button, "UIPanelButtonTemplate")
         set_followers_button:SetText(idx)
         set_followers_button:SetWidth(80)
         set_followers_button:SetHeight(40)
         set_followers_button:SetPoint("LEFT", blizzard_button, "RIGHT", -65, 0)
         set_followers_button:SetScript("OnClick", MissionList_PartyButtonOnClick)
         gmm_buttons['MissionList' .. idx] = set_followers_button
      end
   end
   -- GarrisonMissionFrame.MissionTab.MissionList.listScroll.scrollBar:SetFrameLevel(gmm_buttons['MissionList1']:GetFrameLevel() - 3)
end

MissionPage_ButtonsInit()
MissionList_ButtonsInit()
hooksecurefunc("GarrisonMissionPage_ShowMission", BestForCurrentSelectedMission)
-- local count = 0
-- hooksecurefunc("GarrisonFollowerList_UpdateFollowers", function(self) count = count + 1 print("GarrisonFollowerList_UpdateFollowers", count, self:GetName(), self:GetParent():GetName()) end)

-- Globals deliberately exposed for people outside
function GMM_Click(button_name)
   local button = gmm_buttons[button_name]
   if button then button:Click() end
end

-- /dump GarrisonMissionFrame.MissionTab.MissionList.listScroll.buttons
-- /dump GarrisonMissionFrame.MissionTab.MissionList.listScroll.scrollBar