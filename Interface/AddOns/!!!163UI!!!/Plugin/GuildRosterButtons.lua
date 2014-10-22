local VIEWS = {
	"playerStatus",
	"guildStatus",
	"weeklyxp",
	"totalxp",
	"achievement",
	"tradeskill",
	"roles"
}

local f = CreateFrame("frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self,event,...)
	local arg1, arg2 = ...
	if event == "ADDON_LOADED" and arg1 == "Blizzard_GuildUI" then
		
		self:UnregisterEvent("ADDON_LOADED")
		
		GuildRosterViewDropdown:Hide()
		
		-- 6.0 前夕开始已经取消公会等级
		--[[
		local function OnUpdate(self, elapsed)
			if GetGuildLevel() > 0 then
				GuildFrame_UpdateLevel()
				self:SetScript("OnUpdate", nil)
			end
		end
		
		local g = CreateFrame("Frame")
		g:SetScript("OnUpdate", OnUpdate)	
		]]	
		
		if not tContains(VIEWS, GetCVar("guildRosterView")) then
			SetCVar("guildRosterView", "playerStatus")
		end
		
		local recent
	
		local b1 = CreateFrame("Button", "GRB_tradeskill", GuildRosterFrame, "UIMenuButtonStretchTemplate")
		b1:SetSize(80,18)
		b1.value = "tradeskill"
		b1:SetText(TRADE_SKILLS)
		b1:SetPoint("TOPRIGHT",-25,-26)

		local b2 = CreateFrame("Button", "GRB_guildStatus", b1, "UIMenuButtonStretchTemplate")
		b2:SetSize(80,18)
		b2.value = "guildStatus"
		b2:SetText(GUILD_STATUS)
		b2:SetPoint("TOPRIGHT", b1, "TOPLEFT", -2, 0)

		local b3 = CreateFrame("Button", "GDB_playerStatus", b2, "UIMenuButtonStretchTemplate")
		b3:SetSize(80,18)
		b3.value = "playerStatus"
		b3:SetText(PLAYER_STATUS)
		b3:SetPoint("TOPRIGHT", b2, "TOPLEFT", -2, 0)
		
		local b4 = CreateFrame("Button", "GRB_totalxp", b1, "UIMenuButtonStretchTemplate")
		b4:SetSize(80,20)
		b4.value = "totalxp"
		b4:SetText("全部活跃值")
		b4:SetPoint("TOPRIGHT", b1, "BOTTOMRIGHT", 0, -2)

		local b5 = CreateFrame("Button", "GRB_weeklyxp", b2, "UIMenuButtonStretchTemplate")
		b5:SetSize(80,20)
		b5.value = "weeklyxp"
		b5:SetText("周活跃值")
		b5:SetPoint("TOPRIGHT", b2, "BOTTOMRIGHT", 0, -2)

		local b6 = CreateFrame("Button", "GRB_achievement", b3, "UIMenuButtonStretchTemplate")
		b6:SetSize(80,20)
		b6.value = "achievement"
		b6:SetText(ACHIEVEMENTS)
		b6:SetPoint("TOPRIGHT", b3, "BOTTOMRIGHT", 0, -2)
		
		if IsAddOnLoaded("GuildRoles") then
			local b7 = CreateFrame("Button", "GRB_roles", b4, "UIMenuButtonStretchTemplate")
			b4:SetSize(40,20)
			b7:SetSize(40,20)
			b7.value = "roles"
			b7:SetText("职责")
			b7:SetPoint("TOPRIGHT", b4, "TOPLEFT", -0, 0)		
		end
		
		local function OnLoad()
			if not tContains(VIEWS, GetCVar("guildRosterView")) then
				SetCVar("guildRosterView", "playerStatus")
			end
			recent = _G["GRB_"..GetCVar("guildRosterView")]
			if recent then
				recent:LockHighlight()
			end			
		end
		
		local function Update(self)
			if not recent then
				OnLoad()
			end
			
			GuildRosterViewDropdown_OnClick(self)
			
			if recent then
				recent:UnlockHighlight()
				self:LockHighlight()
			end
			
			recent = self			
		end
		
		b1:SetScript("OnClick", Update)
		b2:SetScript("OnClick", Update)
		b3:SetScript("OnClick", Update)
		b4:SetScript("OnClick", Update)
		b5:SetScript("OnClick", Update)
		b6:SetScript("OnClick", Update)
		if GRB_roles then
			GRB_roles:SetScript("OnClick", Update)
		end
		OnLoad()
	end
end)