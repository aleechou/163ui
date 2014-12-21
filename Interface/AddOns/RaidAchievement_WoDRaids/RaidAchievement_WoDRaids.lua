function wodrraonload()

SetMapToCurrentZone()
if GetCurrentMapAreaID()==9999999 then
	RaidAchievement_wodrra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	RaidAchievement_wodrra:RegisterEvent("UNIT_POWER")
	RaidAchievement_wodrra:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end
	RaidAchievement_wodrra:RegisterEvent("PLAYER_REGEN_DISABLED")
	RaidAchievement_wodrra:RegisterEvent("ZONE_CHANGED_NEW_AREA")
	RaidAchievement_wodrra:RegisterEvent("ADDON_LOADED")
	
	local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
	if select(3,GetInstanceInfo())==17 then
		lfrenable=1
  else
    lfrenable=nil
  end


wodrraspisokach25={




}



if (wodrraspisokon==nil) then
wodrraspisokon={}
end


end


function wodrra_OnUpdate(curtime)




if rpradelayzonech and curtime>rpradelayzonech then
rpradelayzonech=nil
SetMapToCurrentZone()
if GetCurrentMapAreaID()==9999999 then
RaidAchievement_wodrra:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
RaidAchievement_wodrra:RegisterEvent("UNIT_POWER")
RaidAchievement_wodrra:RegisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
else
RaidAchievement_wodrra:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
RaidAchievement_wodrra:UnregisterEvent("UNIT_POWER")
RaidAchievement_wodrra:UnregisterEvent("CHAT_MSG_RAID_BOSS_EMOTE")
end
end




--после 10 сек после ачивки чек
if ratrackgoodattack2 and curtime>ratrackgoodattack2+10 then

    ratrackgoodattack2=nil
    --собираем инфо по тем кто в рейде!
    local taball={}
    local _, instanceType, pppl, _, maxPlayers, dif = GetInstanceInfo()
    if pppl and (pppl==4 or pppl==6 or pppl==7 or pppl==14) then
      psdifflastfight=25
    end
		local psgroup=2
		if psdifflastfight==25 then
			psgroup=5
		end
		for i = 1,GetNumGroupMembers() do
			local name, _, subgroup, _, _, _, _, online, isDead = GetRaidRosterInfo(i)
			if subgroup<=psgroup then
				table.insert(taball,name)
			end
		end
		--если 75% игроков нанесло атаку...
		if #taball>0 then
      if #ratrackgoodattack1<#taball then
        if #ratrackgoodattack1>=#taball*0.01 then
          --поиск ников что не сделали свое дело!
          for k=1,#ratrackgoodattack1 do
             if ratrackgoodattack1[k] then
               if #taball>0 then
                 for j=1,#taball do
                   if taball[j] and taball[j]==ratrackgoodattack1[k] then
                     table.remove(taball,j)
                   end
                 end
               end
             end
          end
          if #taball<7 and #taball>0 then
            --вывод списка фейлеров
            local text=""
            for v=1,#taball do
              text=text..taball[v]
              if v~=#taball then
                text=text..", "
              end
            end
            raplaysound(3,wodrraspisokach25[4])
            if (wherereportraidach=="sebe") then
              DEFAULT_CHAT_FRAME:AddMessage("- "..achlinnk.." NO DAMAGE: "..text)
            else
            if (UnitIsGroupAssistant("player")==nil and UnitIsGroupLeader("player")==nil) and wherereportraidach=="raid_warning" then
              razapuskanonsa("raid", "{rt8} "..achlinnk.." NO DAMAGE: "..text)
            else
              razapuskanonsa(wherereportraidach, "{rt8} "..achlinnk.." NO DAMAGE: "..text)
            end
            end
          end
        end
      end
    end
    ratrackgoodattack1=nil
    ratrackgoodattack2=nil
    ratrackgoodattack3=nil
end



end


function wodrraonevent(self,event,...)

local arg1, arg2, arg3,arg4,arg5,arg6 = ...



if event == "PLAYER_REGEN_DISABLED" then
if (rabilresnut and GetTime()<rabilresnut+3) or racheckbossincombat then
else
--обнулять все данные при начале боя тут:
raramapwidth=nil
raramapheight=nil
psranormgolong=nil

rababahcount=nil

ramariotrack=nil
ramariotableguid=nil
ratableforgaroshach1=nil
ratableforgaroshach2=nil


	if UnitGUID("boss1") and UnitName("boss1")~="" then
		local id2=UnitGUID("boss1")
		local id=raGetUnitID(id2)

	else
		racrtimerbossrecheck=GetTime()+3
	end
end

end


if event == "CHAT_MSG_RAID_BOSS_EMOTE" then



end


if event == "ZONE_CHANGED_NEW_AREA" then

rpradelayzonech=GetTime()+2

	local _, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo()
	if select(3,GetInstanceInfo())==17 then
		lfrenable=1
  else
    lfrenable=nil
  end

end

if event == "ADDON_LOADED" then
	if arg1=="RaidAchievement_PandaRaids" then

for i=1,#wodrraspisokach25 do
if wodrraspisokon[i]==nil then wodrraspisokon[i]=1 end
end
	end
end


if event == "UNIT_POWER" then
if UnitName("boss1") and UnitName("boss1")~="" then



end
end




if event == "COMBAT_LOG_EVENT_UNFILTERED" and lfrenable==nil then

local arg1, arg2, arg3,arg4,arg5,arg6,argNEW1,arg7,arg8,arg9,argNEW2,arg10,arg11,arg12,arg13,arg14, arg15,arg16,arg17,arg18,arg19 = ...


--ТУТ АЧИВЫ







end
end --КОНЕЦ ОНЕВЕНТ

function wodrra_closeallpr()
wodrramain6:Hide()
end


function wodrra_button2()
PSFea_closeallpr()
wodrramain6:Show()
openmenureportwodrra()



if (wodrranespamit==nil) then

wodrraspislun= # wodrraspisokach25
wodrracbset={}

for i=1,wodrraspislun do

if i>14 then
l=280
j=i-14
else
l=0
j=i
end

if GetAchievementLink(wodrraspisokach25[i]) then

local _, wodrraName, _, completed, _, _, _, Description, _, wodrraImage = GetAchievementInfo(wodrraspisokach25[i])

if completed then
wodrraName="|cff00ff00"..wodrraName.."|r"
else
--no more red
end



--текст
local f = CreateFrame("Frame",nil,wodrramain6)
f:SetFrameStrata("DIALOG")
f:SetWidth(248)
f:SetHeight(24)




f:SetScript("OnEnter", function(self) Raiccshowtxt(self,Description) end )
f:SetScript("OnLeave", function(self) Raiccshowtxt2() end )
f:SetScript("OnMouseDown", function(self) if IsShiftKeyDown() then if ChatFrame1EditBox:GetText() and string.len(ChatFrame1EditBox:GetText())>0 then ChatFrame1EditBox:SetText(ChatFrame1EditBox:GetText().." "..GetAchievementLink(wodrraspisokach25[i])) else ChatFrame_OpenChat(GetAchievementLink(wodrraspisokach25[i])) end end end )

--картинка
local t = f:CreateTexture(nil,"OVERLAY")
t:SetTexture(wodrraImage)
t:SetWidth(24)
t:SetHeight(24)
t:SetPoint("TOPLEFT",0,0)

local t = f:CreateFontString()
t:SetFont(GameFontNormal:GetFont(), rafontsset[2])
t:SetWidth(548)
if i==3 then
  t:SetText(wodrraName.." - |cffff0000"..raspectext.."|r")
else
  t:SetText(wodrraName)
end
t:SetJustifyH("LEFT")
t:SetPoint("LEFT",27,0)


f:SetPoint("TOPLEFT",l+45,-14-j*30)
f:Show()

end

--чекбатон
local c = CreateFrame("CheckButton", nil, wodrramain6, "UICheckButtonTemplate")
c:SetWidth("25")
c:SetHeight("25")
c:SetPoint("TOPLEFT", l+20, -14-j*30)
c:SetScript("OnClick", function(self) wodrragalka(i) end )
table.insert(wodrracbset, c)


end --for i
wodrranespamit=1
end --nespam


wodrragalochki()




end --конец бутон2

function Raiccshowtxt(self,i)
	GameTooltip:SetOwner(self or UIParent, "ANCHOR_TOP")
	GameTooltip:SetText(i)
end

function Raiccshowtxt2(i)
GameTooltip:Hide()
end


function wodrragalochki()
for i=1,#wodrraspisokach25 do
if(wodrraspisokon[i]==1)then wodrracbset[i]:SetChecked(true) else wodrracbset[i]:SetChecked(false) end
end
end

function wodrragalka(nomersmeni)
if wodrraspisokon[nomersmeni]==1 then wodrraspisokon[nomersmeni]=0 else wodrraspisokon[nomersmeni]=1 end
end

function wodrra_buttonchangeyn(yesno)
wodrraspislun= # wodrraspisokach25
for i=1,wodrraspislun do
wodrraspisokon[i]=yesno
end
wodrragalochki()
end

function wodrra_button1()
wodrraspislun= # wodrraspisokach25
for i=1,wodrraspislun do
if wodrraspisokon[i]==1 then wodrraspisokon[i]=0 else wodrraspisokon[i]=1 end
end
wodrragalochki()
end


function openmenureportwodrra()
if not DropDownMenureportwodrra then
CreateFrame("Frame", "DropDownMenureportwodrra", wodrramain6, "UIDropDownMenuTemplate")
end
rachatdropm(DropDownMenureportwodrra,5,7)
end



function raGetMapSize()
	-- try custom map size first
	local mapName = GetMapInfo()
	local floor, a1, b1, c1, d1 = GetCurrentMapDungeonLevel()

	--Blizzard's map size
	if not (a1 and b1 and c1 and d1) then
		local zoneIndex, a2, b2, c2, d2 = GetCurrentMapZone()
		a1, b1, c1, d1 = a2, b2, c2, d2
	end

	if not (a1 and b1 and c1 and d1) then return end
	return abs(c1-a1), abs(d1-b1)
end