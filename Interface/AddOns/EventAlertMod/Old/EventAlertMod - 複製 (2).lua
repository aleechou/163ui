-- Prevent tainting global _.
local _
local _G = _G
		
local EA_ActionButton_ShowOverlayGlow = ActionButton_ShowOverlayGlow ;
local EA_ActionButton_HideOverlayGlow = ActionButton_HideOverlayGlow ;
--local EA_ActionButton_ShowOverlayGlow = function(...) return end
--local EA_ActionButton_HideOverlayGlow = function(...) return end



EA_Config = { DoAlertSound, AlertSound, AlertSoundValue, LockFrame, ShareSettings, ShowFrame, ShowName, 
	ShowFlash, ShowTimer, TimerFontSize, StackFontSize, SNameFontSize, ChangeTimer, Version, AllowESC, 
	AllowAltAlerts, Target_MyDebuff,IsUseFloat,IsKeepSCD,IsKeepGlowSCD };
EA_Position = { Anchor, relativePoint, xLoc, yLoc, xOffset, yOffset, RedDebuff, GreenDebuff, Tar_NewLine, 
	TarAnchor, TarrelativePoint, Tar_xOffset, Tar_yOffset, ScdAnchor, Scd_xOffset, Scd_yOffset, Execution, 
	PlayerLv2BOSS, SCD_UseCooldown };

-- �ҥ�/�����S���O���ˬd����	
EA_SpecCheckPower = { CheckMana, CheckRage, CheckFocus, CheckEnergy, CheckRunes, CheckRunicPower, CheckSoulShards, 
	CheckEclipse, CheckHolyPower, CheckDarkForce, CheckLightForce, CheckShadowOrbs, CheckBurningEmbers, 
	CheckDemonicFury, CheckComboPoint, CheckLifeBloom };
-- �ˬd�ثe�ѽ��ƭ��ǯS���O
EA_SpecHasPower = { HasMana, HasRage, HasFocus, HasEnergy, HasRunes, HasRunicPower, HasSoulShards,
	HasEclipse, HasHolyPower, HasDarkForce, HasLightForce, HasShadowOrbs, HasBurningEmbers,
	HasDemonicFury, HasComboPoint, HasLifeBloom };
	
EA_Pos = { };

EA_SPELLINFO_SELF = { };
EA_SPELLINFO_TARGET = { };
EA_SPELLINFO_SCD = { };
EA_ClassAltSpellName = { };
GC_IndexOfGroupFrame = { };

local EA_DEBUGFLAG1 = false;
local EA_DEBUGFLAG2 = false;
local EA_DEBUGFLAG3 = false;
local EA_DEBUGFLAG11 = false;
local EA_DEBUGFLAG21 = false;
local EA_LISTSEC_SELF = 0;
local EA_LISTSEC_TARGET = 0;
local EA_SPEC_expirationTime1 = 0;
local EA_SPEC_expirationTime2 = 0;

local EA_CurrentBuffs = { };
local EA_TarCurrentBuffs = { };
local EA_ScdCurrentBuffs = { };
local EA_ShowScrollSpells = { };
local EA_ShowScrollSpell_YPos = 25;

local EA_SpecFrame_Self = false;
local EA_SpecFrame_Target = false;
local EA_SpecFrame_LifeBloom = { UnitID = "", UnitName = "", ExpireTime = 0, Stack = 0 };

local EA_FormType_FirstTimeCheck = true;

-- The first event of this UI
function EventAlert_OnLoad(self)
	self:RegisterEvent("COMBAT_TEXT_UPDATE");
	self:RegisterEvent("UNIT_AURA");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN");
	self:RegisterEvent("SPELL_UPDATE_CHARGES");
	-- self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	-- self:RegisterEvent("UNIT_SPELLCAST_CAST");
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	self:RegisterEvent("UNIT_DISPLAYPOWER");
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM");
	self:RegisterEvent("PLAYER_TALENT_UPDATE");
	self:RegisterEvent("PLAYER_TALENT_WIPE");
	-- self:RegisterEvent("ACTIVE_SPEC_GROUP_CHANGED");

	self:RegisterEvent("UNIT_COMBO_POINTS");
	self:RegisterEvent("UNIT_HEALTH");
	self:RegisterEvent("UNIT_POWER");

	self:RegisterEvent("PLAYER_LOGIN");
	self:RegisterEvent("PLAYER_ENTERING_WORLD");
	self:RegisterEvent("PLAYER_DEAD");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");

	SlashCmdList["EVENTALERTMOD"] = EventAlert_SlashHandler;
	SLASH_EVENTALERTMOD1 = "/eventalertmod";
	SLASH_EVENTALERTMOD2 = "/eam";

	EA_SPELLINFO_SELF = { };
	EA_SPELLINFO_TARGET = { };

	EA_CurrentBuffs = { };
	EA_TarCurrentBuffs = { };
end

local iEAEXF_AlreadyAlert = false;
local iEAEXF_FrameCount = 0;
local iEAEXF_Prefraction = 0;
local function EAEXF_AnimAlpha(self, fraction)
	if iEAEXF_Prefraction == 0 then iEAEXF_Prefraction = fraction end;
	local iAlpha = self:GetAlpha();
	if iEAEXF_Prefraction >= fraction + 0.05 then
		iEAEXF_FrameCount = iEAEXF_FrameCount + 1;
		if iEAEXF_FrameCount >= 19 then iEAEXF_FrameCount = 19 end;
		self:SetBackdrop({bgFile = "Interface\\AddOns\\EventAlertMod\\Images\\Seed"..iEAEXF_FrameCount});
		iAlpha = iAlpha - 0.02;
		iEAEXF_Prefraction = fraction;
	end
	return iAlpha;
end
local EAEXFrameAnimTable = {
	totalTime = 1,
	updateFunc = "SetAlpha",
	getPosFunc = EAEXF_AnimAlpha,
}
function EAEXF_AnimateOut(self)
	SetUpAnimation(self, EAEXFrameAnimTable, EAEXF_AnimFinished, true);
end
function EAEXF_AnimFinished(self)
	self:Hide();
end

-- The procedures of events
function EventAlert_OnEvent(self, event, ...)
	if (event == "PLAYER_ENTERING_WORLD") then
		-- �����ثe���⪺�ѽ�ίS���O
		EventAlert_PlayerSpecPower_Update();
	end

	if (event == "ADDON_LOADED") then
		local arg1, arg2 = ...;
		if (arg1 == "EventAlertMod") then
			--'// 1. Load the Default Spell Arrays, but not apply to this player now.
			EventAlert_LoadSpellArray();
			localizedPlayerClass, EA_playerClass = UnitClass("player");
			-- EA_playerClass = EA_CLASS_DK;
			-- EA_playerClass = EA_CLASS_DRUID;
			-- EA_playerClass = EA_CLASS_HUNTER;
			-- EA_playerClass = EA_CLASS_MAGE;
			-- EA_playerClass = EA_CLASS_PALADIN;
			-- EA_playerClass = EA_CLASS_PRIEST;
			-- EA_playerClass = EA_CLASS_ROGUE;
			-- EA_playerClass = EA_CLASS_SHAMAN;
			-- EA_playerClass = EA_CLASS_WARLOCK;
			-- EA_playerClass = EA_CLASS_WARRIOR;
			-- EA_playerClass = EA_CLASS_MONK;
					
			--'// 2. Check EAM version. If version isn't match. Load Default Spells automatically.
			EventAlert_VersionCheck();
			DEFAULT_CHAT_FRAME:AddMessage(EA_XLOAD_LOAD..EA_Config.Version.."\124r");
			
			--'// 3. Start to check the savedvariables
			if EA_Config.AlertSound == nil then EA_Config.AlertSound = "Sound\\Spells\\ShaysBell.wav" end;
			if EA_Config.AlertSoundValue == nil then EA_Config.AlertSoundValue = 1 end;
			if EA_Config.DoAlertSound == nil then EA_Config.DoAlertSound = true end;
			if EA_Config.LockFrame == nil then EA_Config.LockFrame = false end;
			if EA_Config.ShareSettings == nil then EA_Config.ShareSettings = true end;
			if EA_Config.ShowFrame == nil then EA_Config.ShowFrame = true end;
			if EA_Config.ShowName == nil then EA_Config.ShowName = true end;
			if EA_Config.ShowFlash == nil then EA_Config.ShowFlash = false end;
			if EA_Config.ShowTimer == nil then EA_Config.ShowTimer = true end;
			if EA_Config.IconSize == nil then EA_Config.IconSize = 60 end;

			if EA_Config.TimerFontSize == nil then EA_Config.TimerFontSize = 14 end;	

			if EA_Config.IsUseFloat == nil then EA_Config.IsUseFloat = false end;		
			if EA_Config.IsKeepSCD == nil then EA_Config.IsKeepSCD = true end;		
			if EA_Config.IsKeepGlowSCD == nil then EA_Config.IsKeepGlowSCD = true end;		

			if EA_Config.StackFontSize == nil then EA_Config.StackFontSize = 16 end;
			if EA_Config.SNameFontSize == nil then EA_Config.SNameFontSize = 20 end;
			if EA_Config.ChangeTimer == nil then EA_Config.ChangeTimer = true end;
			if EA_Config.AllowESC == nil then EA_Config.AllowESC = false end;
			if EA_Config.AllowAltAlerts == nil then EA_Config.AllowAltAlerts = false end;
			if EA_Config.Target_MyDebuff == nil then EA_Config.Target_MyDebuff = true end;

			if EA_Position.Anchor == nil then EA_Position.Anchor = "CENTER" end;
			if EA_Position.relativePoint == nil then EA_Position.relativePoint = "CENTER" end;
			if EA_Position.xLoc == nil then EA_Position.xLoc = 0 end;
			if EA_Position.yLoc == nil then EA_Position.yLoc = -140 end;
			if EA_Position.xOffset == nil then EA_Position.xOffset = -25 end;
			if EA_Position.yOffset == nil then EA_Position.yOffset = 0 end;
			if EA_Position.RedDebuff == nil then EA_Position.RedDebuff = 0.5 end;
			if EA_Position.GreenDebuff == nil then EA_Position.GreenDebuff = 0.5 end;
			if EA_Position.Tar_NewLine == nil then EA_Position.Tar_NewLine = true end;
			if EA_Position.TarAnchor == nil then EA_Position.TarAnchor = "CENTER" end;
			if EA_Position.TarrelativePoint == nil then EA_Position.TarrelativePoint = "CENTER" end;
			if EA_Position.Tar_xOffset == nil then EA_Position.Tar_xOffset = 0 end;
			if EA_Position.Tar_yOffset == nil then EA_Position.Tar_yOffset = -220 end;
			if EA_Position.ScdAnchor == nil then EA_Position.ScdAnchor = "CENTER" end;
			if EA_Position.Scd_xOffset == nil then EA_Position.Scd_xOffset = 0 end;
			if EA_Position.Scd_yOffset == nil then EA_Position.Scd_yOffset = 80 end;
			if EA_Position.Execution == nil then EA_Position.Execution = 0 end;
			if EA_Position.PlayerLv2BOSS == nil then EA_Position.PlayerLv2BOSS = true end;
			if EA_Position.SCD_UseCooldown == nil then EA_Position.SCD_UseCooldown = false end;

			if EA_Pos == nil then EA_Pos = { } end;
			if EA_Pos[EA_CLASS_DK] == nil then EA_Pos[EA_CLASS_DK] = EA_Position end;
			if EA_Pos[EA_CLASS_DRUID] == nil then EA_Pos[EA_CLASS_DRUID] = EA_Position end;
			if EA_Pos[EA_CLASS_HUNTER] == nil then EA_Pos[EA_CLASS_HUNTER] = EA_Position end;
			if EA_Pos[EA_CLASS_MAGE] == nil then EA_Pos[EA_CLASS_MAGE] = EA_Position end;
			if EA_Pos[EA_CLASS_PALADIN] == nil then EA_Pos[EA_CLASS_PALADIN] = EA_Position end;
			if EA_Pos[EA_CLASS_PRIEST] == nil then EA_Pos[EA_CLASS_PRIEST] = EA_Position end;
			if EA_Pos[EA_CLASS_ROGUE] == nil then EA_Pos[EA_CLASS_ROGUE] = EA_Position end;
			if EA_Pos[EA_CLASS_SHAMAN] == nil then EA_Pos[EA_CLASS_SHAMAN] = EA_Position end;
			if EA_Pos[EA_CLASS_WARLOCK] == nil then EA_Pos[EA_CLASS_WARLOCK] = EA_Position end;
			if EA_Pos[EA_CLASS_WARRIOR] == nil then EA_Pos[EA_CLASS_WARRIOR] = EA_Position end;
			if EA_Pos[EA_CLASS_MONK] == nil then EA_Pos[EA_CLASS_MONK] = EA_Position end;

			if (EA_Config.ShareSettings ~= true) then
				EA_Position = EA_Pos[EA_playerClass];
				if EA_Position.Tar_NewLine == nil then EA_Position.Tar_NewLine = true end;
				if EA_Position.Execution == nil then EA_Position.Execution = 0 end;
				if EA_Position.PlayerLv2BOSS == nil then EA_Position.PlayerLv2BOSS = true end;
			end

			if EA_SpecCheckPower.CheckHolyPower == nil then EA_SpecCheckPower.CheckHolyPower = true end;
			if EA_SpecCheckPower.CheckRunicPower == nil then EA_SpecCheckPower.CheckRunicPower = true end;
			if EA_SpecCheckPower.CheckSoulShards == nil then EA_SpecCheckPower.CheckSoulShards = true end;
			if EA_SpecCheckPower.CheckEclipse == nil then EA_SpecCheckPower.CheckEclipse = true end;
			if EA_SpecCheckPower.CheckComboPoint == nil then EA_SpecCheckPower.CheckComboPoint = true end;
			if EA_SpecCheckPower.CheckLifeBloom == nil then EA_SpecCheckPower.CheckLifeBloom = true end;
			
			--�[�J������Focus,���Rage,��qEnergy,�Z���u��LightForce,�t�v�_�]ShadowOrbs	
			if EA_SpecCheckPower.CheckRage == nil then EA_SpecCheckPower.CheckRage = true end;
			if EA_SpecCheckPower.CheckFocus == nil then EA_SpecCheckPower.CheckFocus = true end;
			if EA_SpecCheckPower.CheckEnergy == nil then EA_SpecCheckPower.CheckEnergy = true end;
			if EA_SpecCheckPower.CheckLightForce == nil then EA_SpecCheckPower.CheckLightForce = true end;
			if EA_SpecCheckPower.CheckShadowOrbs == nil then EA_SpecCheckPower.CheckShadowOrbs = true end;
			
			--�[�J�U���l�u,�c�]����
			if EA_SpecCheckPower.CheckBurningEmbers == nil then EA_SpecCheckPower.CheckBurningEmbers = true end;
			if EA_SpecCheckPower.CheckDemonicFury == nil then EA_SpecCheckPower.CheckDemonicFury = true end;
			
			EventAlert_Options_Init();
			EventAlert_Icon_Options_Frame_Init();
			-- EventAlert_Class_Events_Frame_Init();
			-- EventAlert_Other_Events_Frame_Init();
			-- EventAlert_Target_Events_Frame_Init();
			-- EventAlert_SCD_Events_Frame_Init();
			-- EventAlert_Group_Events_Frame_Init();
			EventAlert_CreateFrames();		
			
			EAFun_HookTooltips();
		end
	end

	if (event == "PLAYER_TARGET_CHANGED") then
		EventAlert_TarChange_ClearFrame();
		if UnitName("player") ~= UnitName("target") then
			EventAlert_TarBuffs_Update();
			if (EA_SpecCheckPower.CheckComboPoint and EA_SpecHasPower.HasComboPoint) then 
				EventAlert_UpdateComboPoint();
			end;
			EventAlert_CheckExecution();
		end
	end

	-- if (event == "UNIT_SPELLCAST_SUCCEEDED" or event == "UNIT_SPELLCAST_START")  then
	--  local arg1, arg2, arg3, arg4, arg5 = ...;
	--  -- /ea showc will also display in this function
	--  -- EventAlert_ScdBuffs_Update(arg1, arg2, arg5);
	-- end

	if (event == "COMBAT_LOG_EVENT_UNFILTERED")   then
		-- WOW 4.1
		-- local timestp, event, hideCaster, surGUID, surName, surFlags, dstGUID, dstName, dstFlags, spellID, spellName = ...;
		-- WOW 4.2
		local timestp, event, hideCaster, surGUID, surName, surFlags, surRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellID, spellName = ...;
		spellID = tonumber(spellID);
		if (dstName ~= nil) then dstName = strsplit("-", dstName, 2) end;
		if ((spellID ~= nil) and (spellID > 0 and spellID < 1000000)) then
			-- "/ea showc" will also display in this function
			EventAlert_ScdBuffs_Update(surName, spellName, spellID); -- WOW 4.1 Change with spellID
			local iUnitPower = UnitPower("player", 8);
			if (EA_playerClass == EA_CLASS_DRUID and EA_SpecCheckPower.CheckLifeBloom and iUnitPower == 0) then
				local EA_PlayerName = UnitName("player");

				if (surName == EA_PlayerName and spellID == 33763 and dstName ~= nil) then
					-- print ("tar="..arg8.." /spid="..arg10);
					local EA_UnitID = "";
					if (dstName == EA_PlayerName) then
						EA_UnitID = "player";
					elseif dstName == EA_SpecFrame_LifeBloom.UnitName then
						EA_UnitID = EA_SpecFrame_LifeBloom.UnitID;
					else
						EA_UnitID = EAFun_GetUnitIDByName(dstName);
					end

					EventAlert_UpdateLifeBloom(EA_UnitID);
				end
			end
		end
	end

	if (event == "UNIT_AURA") then
		local arg1 = ...;
		if arg1 == "player" then
			EventAlert_Buffs_Update();
		elseif arg1 == "target" then
			EventAlert_TarBuffs_Update();
		end
	end

	if (event == "COMBAT_TEXT_UPDATE") then
		local arg1, arg2 = ...;
		if (arg1 == "SPELL_ACTIVE") then
			EventAlert_COMBAT_TEXT_SPELL_ACTIVE(arg2);
		end
	end

	if (event == "UNIT_COMBO_POINTS") then
		if (EA_SpecCheckPower.CheckComboPoint and EA_SpecHasPower.HasComboPoint) then 
			EventAlert_UpdateComboPoint();
		end
	end

	if (event == "UNIT_HEALTH") then
		local arg1 = ...;
		if arg1 == "target" then
			EventAlert_CheckExecution();
		end
	end

	if (event == "UNIT_POWER") then
		local arg1, arg2 = ...;
		if arg1 == "player" then
			--if (arg2 ~= nil) then
			--	DEFAULT_CHAT_FRAME:AddMessage("EVENT(UNIT_POWER) = ("..arg1..","..arg2..")");
			--else
			--	DEFAULT_CHAT_FRAME:AddMessage("EVENT(UNIT_POWER) = ("..arg1..",".."NULL"..")");
			--end
			
			-- �H�U��s�S���O�ɡA�u�ˬd�O�_�ҥκʱ��\��A�H�Υثe�ѽ�O�_�֦��o�دS���O

			if (arg2 == "COMBO_POINTS") then
				if (EA_SpecCheckPower.CheckComboPoint and EA_SpecHasPower.HasComboPoint) then 
					EventAlert_UpdateComboPoint();
				end
			end
			-- ���
			if ((arg2 == "RAGE") and EA_SpecCheckPower.CheckRage and EA_SpecHasPower.HasRage) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_RAGE);
				--�p�G�i�H��ܯ�q�]�P����ܯ�q
				if (EA_SpecCheckPower.CheckEnergy and EA_SpecHasPower.HasEnergy) then
					EventAlert_UpdateSinglePower(EA_SPELL_POWER_ENERGY);
				end
			end 

			-- ������
			if ((arg2 == "FOCUS") and EA_SpecCheckPower.CheckFocus and EA_SpecHasPower.HasFocus) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_FOCUS);
			end
			
			-- ��q
			if ((arg2 == "ENERGY") and EA_SpecCheckPower.CheckEnergy and EA_SpecHasPower.HasEnergy) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_ENERGY);

				--�p�G�i�H��ܯu��]�P����ܯu��
				if (EA_SpecCheckPower.CheckLightForce and EA_SpecHasPower.HasLightForce) then
					EventAlert_UpdateSinglePower(EA_SPELL_POWER_LIGHT_FORCE);
				end

				--�p�G�i�H��ܫ��]�P����ܫ��
				if (EA_SpecCheckPower.CheckRage and EA_SpecHasPower.HasRage) then
					EventAlert_UpdateSinglePower(EA_SPELL_POWER_RAGE);				
				end 
			end

			-- �Ť��q
			if ((arg2 == "RUNIC_POWER") and EA_SpecCheckPower.CheckRunicPower and EA_SpecHasPower.HasRunicPower) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_RUNIC_POWER);
			end
			
			-- �F��H��
			if ((arg2 == "SOUL_SHARDS") and EA_SpecCheckPower.CheckSoulShards and EA_SpecHasPower.HasSoulShards) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_SOUL_SHARDS);
			end 
			
			-- ���k��
			if ((arg2 == "ECLIPSE") and EA_SpecCheckPower.CheckEclipse and EA_SpecHasPower.HasEclipse) then
				EventAlert_UpdateEclipse();
			end
			
			-- �t��
			if ((arg2 == "HOLY_POWER") and EA_SpecCheckPower.CheckHolyPower and EA_SpecHasPower.HasHolyPower) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_HOLY_POWER);
			end
			
			-- �u��
			if ((arg2 == "CHI") and EA_SpecCheckPower.CheckLightForce and EA_SpecHasPower.HasLightForce) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_LIGHT_FORCE);
				--�p�G�i�H��ܯ�q�]�P����ܯ�q
				if (EA_SpecCheckPower.CheckEnergy and EA_SpecHasPower.HasEnergy) then
					EventAlert_UpdateSinglePower(EA_SPELL_POWER_ENERGY);
				end
			end
			
			-- �t�v�_�]
			if ((arg2 == "SHADOW_ORBS") and EA_SpecCheckPower.CheckShadowOrbs and EA_SpecHasPower.HasShadowOrbs) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_SHADOW_ORBS);
			end
			
			-- �c�]����
			if ((arg2 == "DEMONIC_FURY") and EA_SpecCheckPower.CheckDemonicFury and EA_SpecHasPower.HasDemonicFury) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_DEMONIC_FURY);
			end
			
			-- �U���l�u
			if ((arg2 == "BURNING_EMBERS") and EA_SpecCheckPower.CheckBurningEmbers and EA_SpecHasPower.HasBurningEmbers) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_BURNING_EMBERS);
			end
		end
	end
	
	if (event == "PLAYER_DEAD" or event == "PLAYER_ENTERING_WORLD") then
		-- �H�U��s�S���O�ɡA�u�ˬd�O�_�ҥκʱ��\��A�H�Υثe�ѽ�O�_�֦��o�دS���O
		
		-- ���
		if (EA_SpecCheckPower.CheckRage and EA_SpecHasPower.HasRage) then
			EventAlert_UpdateSinglePower(EA_SPELL_POWER_RAGE);
		-- ������
		elseif (EA_SpecCheckPower.CheckFocus and EA_SpecHasPower.HasFocus) then
			EventAlert_UpdateSinglePower(EA_SPELL_POWER_FOCUS);
		-- ��q
		elseif (EA_SpecCheckPower.CheckEnergy and EA_SpecHasPower.HasEnergy) then
			EventAlert_UpdateSinglePower(EA_SPELL_POWER_ENERGY);
			--�p�G�����ίu��]�P�����
			if (EA_SpecCheckPower.CheckRage and EA_SpecHasPower.HasRage) then
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_RAGE);
			end
			if (EA_SpecCheckPower.CheckLightForce and EA_SpecHasPower.HasLightForce) then 
				EventAlert_UpdateSinglePower(EA_SPELL_POWER_LIGHT_FORCE);
			end
		-- �Ť��q
		elseif (EA_SpecCheckPower.CheckRunicPower and EA_SpecHasPower.HasRunicPower) then
			EventAlert_UpdateSinglePower(EA_SPELL_POWER_RUNIC_POWER);
		-- �F��H��
		elseif (EA_SpecCheckPower.CheckSoulShards and EA_SpecHasPower.HasSoulShards) then
			EventAlert_UpdateSinglePower(EA_SPELL_POWER_SOUL_SHARDS);
		-- �U���l�u
		elseif (EA_SpecCheckPower.CheckBurningEmbers and EA_SpecHasPower.HasBurningEmbers) then
			EventAlert_UpdateSinglePower(EA_SPELL_POWER_BURNING_EMBERS);
		-- �c�]����
		elseif (EA_SpecCheckPower.CheckDemonicFury and EA_SpecHasPower.HasdDemonicFury) then
			EventAlert_UpdateSinglePower(EA_SPELL_POWER_DEMONIC_FURY);
		-- ���k��
		elseif (EA_SpecCheckPower.CheckEclipse and EA_SpecHasPower.HasEclipse) then
			EventAlert_UpdateEclipse();
		-- �t��
		elseif (EA_SpecCheckPower.CheckHolyPower and EA_SpecHasPower.HasHolyPower) then
			EventAlert_UpdateSinglePower(EA_SPELL_POWER_HOLY_POWER);
		-- �u��
		elseif (EA_SpecCheckPower.CheckLightForce and EA_SpecHasPower.HasLightForce) then
			EventAlert_UpdateSinglePower(EA_SPELL_POWER_LIGHT_FORCE);
		-- �t�v�_�]
		elseif (EA_SpecCheckPower.CheckShadowOrbs and EA_SpecHasPower.HasShadowOrbs) then
			EventAlert_UpdateSinglePower(EA_SPELL_POWER_SHADOW_ORBS);
		end
			
		local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...;
		local v = table.foreach(EA_CurrentBuffs, function(i, v) if v==arg9 then return v end end)
		if v then
			local f = _G["EAFrame_"..v];
			f:Hide();
			EA_CurrentBuffs = table.wipe(EA_CurrentBuffs);
		end

		EA_ClassAltSpellName = { };
		for i,v in pairs(EA_AltItems[EA_playerClass]) do
			local name, rank = GetSpellInfo(i);
			EA_ClassAltSpellName[name] = tonumber(i);
		end
	end
	
	if ((event == "ACTIVE_TALENT_GROUP_CHANGED") or (event == "UNIT_DISPLAYPOWER") or (event== "UPDATE_SHAPESHIFT_FORM") ) then
		-- �����ثe���⪺�ѽ�ίS���O
		EventAlert_PlayerSpecPower_Update();
        RemoveAllScdCurrentBuff();

	end

	if ((event=="PLAYER_TALENT_UPDATE") or (envet=="PLAYER_TALENT_WIPE")) then
		
		EventAlert_PlayerSpecPower_Update();
		RemoveAllScdCurrentBuff();
	end
	if ((event=="SPELL_UPDATE_COOLDOWN") or (envet=="SPELL_UPDATE_CHARGES")) then
		

	--	EventAlert_ScdPositionFrames();	
	end


	
	if (event == "UNIT_AURA") then
		-- �ثe���S���O���� �]�p�pD�ܧΡB�Z���������ա^
		-- UNIT_AURA�u����@���N�n�A�᭱���UNIT_DISPLAYPOWER���ˬd
		if (EA_FormType_FirstTimeCheck) then
			--DEFAULT_CHAT_FRAME:AddMessage("First time check FormType");
			EventAlert_PlayerSpecPower_Update();
			EA_FormType_FirstTimeCheck = false;
		end
	end		
end


local function EAFun_CheckSpellConditionMatch(EA_count, EA_unitCaster, EAItems)
	local ifAdd_buffCur, orderWtd = true, 1;
	local SC_Stack, SC_Self = 1, false;
	if (EAItems ~= nil) then
		if (EAItems.stack ~= nil) then SC_Stack = EAItems.stack end;
		if (EAItems.self ~= nil) then SC_Self = EAItems.self end;
		if (EAItems.orderwtd ~= nil) then orderWtd = EAItems.orderwtd end;
	end
	if (SC_Stack ~= nil and SC_Stack > 1) then
		if (EA_count < SC_Stack) then ifAdd_buffCur = false end;
	end
	if (SC_Self ~= nil and SC_Self) then
		if (EA_unitCaster ~= "player") then ifAdd_buffCur = false end;
	end

	return ifAdd_buffCur, orderWtd;
end

local function EAFun_GetSpellItemEnable(EAItems)
	local SpellEnable = false;
	if (EAItems ~= nil) then
		if (EAItems.enable) then SpellEnable = true end;
	end
	return SpellEnable;
end

local function EAFun_CheckSpellConditionOverGrow(EA_count, EAItems)
	local isOverGrow = false;
	local SC_OverGrow = 0;
	if (EAItems ~= nil) then
		if (EAItems.overgrow ~= nil) then SC_OverGrow = EAItems.overgrow end;
	end
	if (EA_count <= 0) then EA_count = 1 end;
	if (SC_OverGrow ~= nil and SC_OverGrow > 0) then
		if (SC_OverGrow <= EA_count) then isOverGrow = true end;
	end
	return isOverGrow;
end

local function EAFun_GetSpellConditionRedSecText(EAItems)
	local SC_RedSecText = -1;
	if (EAItems ~= nil) then
		if (EAItems.redsectext ~= nil) then SC_RedSecText = EAItems.redsectext end;
		if (SC_RedSecText < 1) then SC_RedSecText = -1 end;
	end
	return SC_RedSecText;
end

function EventAlert_Buffs_Update()
	local buffsCurrent = {};
	local buffsToDelete = {};
	local SpellEnable, OtherEnable = false, false;
	local ifAdd_buffCur = false;
	local orderWtd = 1;
	-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buffs_Update");
	-- if (EA_DEBUGFLAG1) then
	--  DEFAULT_CHAT_FRAME:AddMessage("----"..EA_XCMD_SELFLIST.."----");
	-- end

	if (EA_DEBUGFLAG11 or EA_DEBUGFLAG21) then
		CreateFrames_EventsFrame_ClearSpellList(3);
	end

	for i=1,40 do
		local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId , canApplyAura, isBossDebuff, value1, value2, value3= UnitBuff("player", i)
		if (not spellId) then
			break;
		end

		if (spellId == 71601) then EA_SPEC_expirationTime1 = expirationTime end;
		if (spellId == 71644) then EA_SPEC_expirationTime2 = expirationTime end;

		if (EA_DEBUGFLAG1) then
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				EAFun_AddSpellToScrollFrame(spellId, " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
					" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				-- DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellId..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
			end
		end

		ifAdd_buffCur = false;
		SpellEnable = EAFun_GetSpellItemEnable(EA_Items[EA_playerClass][spellId]);
		OtherEnable = EAFun_GetSpellItemEnable(EA_Items[EA_CLASS_OTHER][spellId]);
		if (SpellEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_playerClass][spellId]);
		elseif (OtherEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_CLASS_OTHER][spellId]);
		elseif (EA_DEBUGFLAG11 or EA_DEBUGFLAG21) then
			-- ifAdd_buffCur = true;
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				-- DEFAULT_CHAT_FRAME:AddMessage("spellId="..spellId.." /unitCaster="..unitCaster);
				if EA_DEBUGFLAG11 or (EA_DEBUGFLAG21 and (not (UnitInRaid(unitCaster) or UnitInParty(unitCaster)))) then
					if EA_Items[EA_CLASS_OTHER][spellId] == nil then EA_Items[EA_CLASS_OTHER][spellId] = {enable=true,} end;
					CreateFrames_CreateSpellFrame(spellId, 1);
					ifAdd_buffCur = true;
				end
			end
		end

		if (ifAdd_buffCur) then
			-- if EA_SPELLINFO_SELF[spellId] == nil then EA_SPELLINFO_SELF[spellId] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
			-- EA_SPELLINFO_SELF[spellId].name = name;
			-- EA_SPELLINFO_SELF[spellId].rank = rank;
			-- EA_SPELLINFO_SELF[spellId].icon = icon;
			EA_SPELLINFO_SELF[spellId].count = count;
			EA_SPELLINFO_SELF[spellId].duration = duration;
			EA_SPELLINFO_SELF[spellId].expirationTime = expirationTime;
			EA_SPELLINFO_SELF[spellId].unitCaster = unitCaster;
			EA_SPELLINFO_SELF[spellId].isDebuff = false;
			EA_SPELLINFO_SELF[spellId].orderWtd = orderWtd;
			EA_SPELLINFO_SELF[spellId].value1 = value1;
			EA_SPELLINFO_SELF[spellId].value2 = value2;
			EA_SPELLINFO_SELF[spellId].value3 = value3;
			table.insert(buffsCurrent, spellId);
		end
	end

	for i=41,80 do
		name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId, canApplyAura, isBossDebuff, value1, value2, value3 = UnitDebuff("player", i-40)
		if (not spellId) then
			break;
		end

		if (EA_DEBUGFLAG1) then
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				EAFun_AddSpellToScrollFrame(spellId, " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
					" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				-- DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellId..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
			end
		end

		ifAdd_buffCur = false;
		SpellEnable = EAFun_GetSpellItemEnable(EA_Items[EA_playerClass][spellId]);
		OtherEnable = EAFun_GetSpellItemEnable(EA_Items[EA_CLASS_OTHER][spellId]);
		if (SpellEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_playerClass][spellId]);
		elseif (OtherEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_CLASS_OTHER][spellId]);
		elseif (EA_DEBUGFLAG11 or EA_DEBUGFLAG21) then
			-- ifAdd_buffCur = true;
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				-- DEFAULT_CHAT_FRAME:AddMessage("spellId="..spellId.." /unitCaster="..unitCaster);
				if EA_DEBUGFLAG11 or (EA_DEBUGFLAG21 and (not (UnitInRaid(unitCaster) or UnitInParty(unitCaster)))) then
					if EA_Items[EA_CLASS_OTHER][spellId] == nil then EA_Items[EA_CLASS_OTHER][spellId] = {enable=true,} end;
					CreateFrames_CreateSpellFrame(spellId, 1);
					ifAdd_buffCur = true;
				end
			end
		end

		if (ifAdd_buffCur) then
			-- if EA_SPELLINFO_SELF[spellId] == nil then EA_SPELLINFO_SELF[spellId] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
			-- EA_SPELLINFO_SELF[spellId].name = name;
			-- EA_SPELLINFO_SELF[spellId].rank = rank;
			-- EA_SPELLINFO_SELF[spellId].icon = icon;
			EA_SPELLINFO_SELF[spellId].count = count;
			EA_SPELLINFO_SELF[spellId].duration = duration;
			EA_SPELLINFO_SELF[spellId].expirationTime = expirationTime;
			EA_SPELLINFO_SELF[spellId].unitCaster = unitCaster;
			EA_SPELLINFO_SELF[spellId].isDebuff = true;
			EA_SPELLINFO_SELF[spellId].orderWtd = orderWtd;
			EA_SPELLINFO_SELF[spellId].value1 = value1;
			EA_SPELLINFO_SELF[spellId].value2 = value2;
			EA_SPELLINFO_SELF[spellId].value3 = value3;		
			table.insert(buffsCurrent, spellId);
		end
	end

	-- Check: Buff dropped
	local v1 = table.foreach(EA_CurrentBuffs,
		function(i, v1)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-check: "..i.." id: "..v1);
			SpellEnable = false;
			SpellEnable = EAFun_GetSpellItemEnable(EA_AltItems[EA_playerClass][v1]);
			if (not SpellEnable) then
				local v2 = table.foreach(buffsCurrent,
					function(k, v2)
						if (v1==v2) then
							return v2;
						end
					end
				)
				if(not v2) then
					-- Buff dropped
					table.insert(buffsToDelete, v1);
				end
			end
		end
	)

	-- Drop Buffs
	table.foreach(buffsToDelete,
		function(i, v)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropped: id: "..v);
			EventAlert_Buff_Dropped(v);
		end
	)

	-- Check: Buff applied
	local v1 = table.foreach(buffsCurrent,
		function(i, v1)
			local v2 = table.foreach(EA_CurrentBuffs,
				function(k, v2)
					if (v1==v2) then
					return v2;
					end
				end
			)
			if(not v2) then
				-- Buff applied
				EventAlert_Buff_Applied(v1);
			end
		end
	)
	EventAlert_PositionFrames();

	if (EA_DEBUGFLAG11 or EA_DEBUGFLAG21) then
		CreateFrames_EventsFrame_RefreshSpellList(3);
	end
end


function EventAlert_TarBuffs_Update()
	local buffsCurrent = {};
	local buffsToDelete = {};
	local SpellEnable = false;
	local ifAdd_buffCur = false;
	local orderWtd = 1;
	-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buffs_Update");
	-- if (EA_DEBUGFLAG2) then
	--  DEFAULT_CHAT_FRAME:AddMessage("--------"..EA_XCMD_TARGETLIST.."--------");
	-- end

	for i=1,40 do
		name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId , canApplyAura, isBossDebuff, value1, value2, value3= UnitDebuff("target", i)
		if (not spellId) then
			break;
		end

		if (EA_DEBUGFLAG2) then
			if (EA_LISTSEC_TARGET == 0 or (0 < duration and duration <= EA_LISTSEC_TARGET)) then
				EAFun_AddSpellToScrollFrame(spellId, " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
					" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				-- DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellId..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
			end
		end

		ifAdd_buffCur = false;
		SpellEnable = EAFun_GetSpellItemEnable(EA_TarItems[EA_playerClass][spellId]);
		if (SpellEnable) then
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_TarItems[EA_playerClass][spellId]);
			if (ifAdd_buffCur) then
				-- if EA_SPELLINFO_TARGET[spellId] == nil then EA_SPELLINFO_TARGET[spellId] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
				-- EA_SPELLINFO_TARGET[spellId].name = name;
				-- EA_SPELLINFO_TARGET[spellId].rank = rank;
				-- EA_SPELLINFO_TARGET[spellId].icon = icon;
				EA_SPELLINFO_TARGET[spellId].count = count;
				EA_SPELLINFO_TARGET[spellId].duration = duration;
				EA_SPELLINFO_TARGET[spellId].expirationTime = expirationTime;
				EA_SPELLINFO_TARGET[spellId].unitCaster = unitCaster;
				EA_SPELLINFO_TARGET[spellId].isDebuff = true;
				EA_SPELLINFO_TARGET[spellId].orderWtd = orderWtd;
				EA_SPELLINFO_TARGET[spellId].value1 = value1;
				EA_SPELLINFO_TARGET[spellId].value2 = value2;
				EA_SPELLINFO_TARGET[spellId].value3 = value3;
				table.insert(buffsCurrent, spellId);
			end
		end
	end

	for i=41,80 do
		name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, shouldConsolidate, spellId, canApplyAura, isBossDebuff, value1, value2, value3= UnitBuff("target", i-40)
		if (not spellId) then
			break;
		end

		if (EA_DEBUGFLAG2) then
			if (EA_LISTSEC_TARGET == 0 or (0 < duration and duration <= EA_LISTSEC_TARGET)) then
				EAFun_AddSpellToScrollFrame(spellId, " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
					" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				-- DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellId..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
			end
		end

		ifAdd_buffCur = false;
		SpellEnable = EAFun_GetSpellItemEnable(EA_TarItems[EA_playerClass][spellId]);
		if (SpellEnable) then
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_TarItems[EA_playerClass][spellId]);
			if (ifAdd_buffCur) then
				-- if EA_SPELLINFO_TARGET[spellId] == nil then EA_SPELLINFO_TARGET[spellId] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
				-- EA_SPELLINFO_TARGET[spellId].name = name;
				-- EA_SPELLINFO_TARGET[spellId].rank = rank;
				-- EA_SPELLINFO_TARGET[spellId].icon = icon;
				EA_SPELLINFO_TARGET[spellId].count = count;
				EA_SPELLINFO_TARGET[spellId].duration = duration;
				EA_SPELLINFO_TARGET[spellId].expirationTime = expirationTime;
				EA_SPELLINFO_TARGET[spellId].unitCaster = unitCaster;
				EA_SPELLINFO_TARGET[spellId].isDebuff = false;
				EA_SPELLINFO_TARGET[spellId].orderWtd = orderWtd;
				EA_SPELLINFO_TARGET[spellId].value1 = value1;
				EA_SPELLINFO_TARGET[spellId].value2 = value2;
				EA_SPELLINFO_TARGET[spellId].value3 = value3;
				table.insert(buffsCurrent, spellId);
			end
		end
	end

	-- Check: Buff dropped
	local v1 = table.foreach(EA_TarCurrentBuffs,
		function(i, v1)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-check: "..i.." id: "..v1);
			local v2 = table.foreach(buffsCurrent,
				function(k, v2)
					-- DEFAULT_CHAT_FRAME:AddMessage("=== buff-check: "..i.." /v2 id: "..v1);
					if (v1==v2) then
						return v2;
					end
				end
			)
			if(not v2) then
				-- Buff dropped
				-- DEFAULT_CHAT_FRAME:AddMessage("=== add to Delete /v1 id: "..v1);
				table.insert(buffsToDelete, v1);
			end
		end
	)

	-- Drop Buffs
	table.foreach(buffsToDelete,
		function(i, v)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropped: id: "..v);
			EventAlert_TarBuff_Dropped(v);
		end
	)

	-- Check: Buff applied
	local v1 = table.foreach(buffsCurrent,
		function(i, v1)
			local v2 = table.foreach(EA_TarCurrentBuffs,
				function(k, v2)
					if (v1==v2) then
					return v2;
					end
				end
			)
			if(not v2) then
				-- Buff applied
				-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buff_Applied("..v1..")");
				EventAlert_TarBuff_Applied(v1);
			end
		end
	)
	EventAlert_TarPositionFrames();
end


function EventAlert_TarChange_ClearFrame()
	local ibuff = #EA_TarCurrentBuffs;
	for i=1,ibuff do
		EventAlert_TarBuff_Dropped(EA_TarCurrentBuffs[1]);
	end
end


function EventAlert_ScdBuffs_Update(EA_Unit, EA_SpellName, EA_SpellID)
		local spellId = tonumber(EA_SpellID);
		local sSpellLink = "";
		local SpellEnable = false;
		-- DEFAULT_CHAT_FRAME:AddMessage("spellId="..spellId.." / EA_SpellName="..EA_SpellName);
		-- DEFAULT_CHAT_FRAME:AddMessage("EA_Unit="..EA_Unit);
		if ((EA_Unit == UnitName("player")) and (spellId ~= 0)) then
			-- print (EA_SpellID.." /"..EA_SpellName.." /"..EA_Unit);
		-- if ((EA_Unit == "player") and (spellId ~= 0)) then
			if (EA_DEBUGFLAG3) then
				sSpellLink = GetSpellLink(EA_SpellID);
				if (sSpellLink ~= nil) then
					-- DEFAULT_CHAT_FRAME:AddMessage("\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r="..EA_SpellID.." / \124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r="..sSpellLink);
					EAFun_AddSpellToScrollFrame(EA_SpellID, "");
				end
			end

			--if (spellId==47666 or spellId==47750) then spellId=47540 end;   -- Priest Penance
			--if (spellId==73921 or spellId==98887) then spellId=73920 end;   -- Shaman Healing Rain
			--if (spellId==61391) then spellId=50516 end;   			-- Druid Typhoon
			SpellEnable = EAFun_GetSpellItemEnable(EA_ScdItems[EA_playerClass][spellId]);
			if (SpellEnable) then
				-- DEFAULT_CHAT_FRAME:AddMessage("spellId="..spellId.." / EA_ScdItems[EA_playerClass][spellId]=true");
				local strSpellId = tostring(spellId);
				local eaf = _G["EAScdFrame_"..strSpellId];
				insertBuffValue(EA_ScdCurrentBuffs, spellId);
				if eaf ~= nil then
					eaf:Hide();
					if not eaf:IsVisible() then
						local gsiIcon = EA_SPELLINFO_SCD[spellId].icon;
						eaf:SetBackdrop({bgFile = gsiIcon});
						eaf:SetWidth(EA_Config.IconSize);
						eaf:SetHeight(EA_Config.IconSize);
						eaf:SetAlpha(1);
						eaf:SetScript("OnUpdate", function()
							EventAlert_OnSCDUpdate(spellId);
						end);
					end
					EventAlert_ScdPositionFrames();
				end
			end
		end
end



function EventAlert_Buff_Dropped(spellId)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropping: id: "..spellId);
	local eaf = _G["EAFrame_"..spellId];
	if eaf~= nil then
		EA_ActionButton_HideOverlayGlow(eaf);
		eaf.overgrow = false;
		eaf:Hide();
		eaf:SetScript("OnUpdate", nil);
	end
	removeBuffValue(EA_CurrentBuffs, spellId);
	EventAlert_PositionFrames();
end


function EventAlert_Buff_Applied(spellId)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-applying: id: "..spellId);
	table.insert(EA_CurrentBuffs, spellId);
	EventAlert_PositionFrames();
	EventAlert_DoAlert();
end


function EventAlert_TarBuff_Dropped(spellId)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropping: id: "..spellId);
	local eaf = _G["EATarFrame_"..spellId];
	if eaf~= nil then
		EA_ActionButton_HideOverlayGlow(eaf);
		eaf.overgrow = false;
		eaf:Hide();
		eaf:SetScript("OnUpdate", nil);
	end
	removeBuffValue(EA_TarCurrentBuffs, spellId);
	EventAlert_TarPositionFrames();
end


function EventAlert_TarBuff_Applied(spellId)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-applying: id: "..spellId);
	table.insert(EA_TarCurrentBuffs, spellId);
	EventAlert_TarPositionFrames();
end


function EventAlert_COMBAT_TEXT_SPELL_ACTIVE(spellName)
	local SpellEnable = false;
	if (EA_Config.AllowAltAlerts==true) then
		-- DEFAULT_CHAT_FRAME:AddMessage("spell-active: "..spellName);
		-- searching for the spell-id, because we only get the name of the spell
		local spellId = table.foreach(EA_ClassAltSpellName,
		function(i, spellId)
			-- DEFAULT_CHAT_FRAME:AddMessage("EA_ClassAltSpellName("..spellId..")");
			if i==spellName then
				return spellId
			end
		end)

		if spellId then
			spellId = tonumber(spellId);
			SpellEnable = EAFun_GetSpellItemEnable(EA_AltItems[EA_playerClass][spellId]);
			if (SpellEnable) then
				local v2 = table.foreach(EA_CurrentBuffs,
				function(i2, v2)
					if v2==spellId then
						return v2
					end
				end)

				if (not v2) then
					-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buff_Applied("..spellId..")");
					EventAlert_Buff_Applied(spellId);
					EventAlert_PositionFrames();
				end
			end
		end
	end
end


-- function EventAlert_OnUpdate()
function EventAlert_OnUpdate(spellId)
	local timerFontSize = 0;
	local SC_RedSecText, isOverGrow = -1, false;

	local v = tostring(spellId);
	local eaf = _G["EAFrame_"..v];
	spellId = tonumber(v);
	local name = EA_SPELLINFO_SELF[spellId].name;
	local rank = EA_SPELLINFO_SELF[spellId].rank;

	if (EA_Config.AllowAltAlerts == true) then
		local SpellEnable = EAFun_GetSpellItemEnable(EA_AltItems[EA_playerClass][spellId]);
		if (SpellEnable) then
			local EA_usable, EA_nomana = IsUsableSpell(name);
			if EA_usable  then
				-- local _,_,_,EAA_count,_,_,EAA_expirationTime,_,_ = UnitAura("player", name, rank);
				EA_SPELLINFO_SELF[spellId].count = 0;
				EA_SPELLINFO_SELF[spellId].expirationTime = 0;
				EA_SPELLINFO_SELF[spellId].isDebuff = false;
				
			 else
			 
				EventAlert_Buff_Dropped(spellId);
				EventAlert_PositionFrames();
				return;
			end
		end
	end

	if eaf ~= nil then
		--eaf:SetCooldown(1, 0);
		if (EA_Config.ShowTimer) then
			-- local _,_,_,_,_,_,EA_expirationTime,_,_ = UnitAura("player", name, rank);
			-- local EA_Name,_,_,EA_count,_,_,EA_expirationTime,_,_ = UnitAura("player", name, rank);
			local EA_Name = EA_SPELLINFO_SELF[spellId].name;
			local EA_count = EA_SPELLINFO_SELF[spellId].count;
			local EA_expirationTime = EA_SPELLINFO_SELF[spellId].expirationTime;
			local IfIsDebuff = EA_SPELLINFO_SELF[spellId].isDebuff;
			local EA_currentTime = 0;
			local EA_timeLeft = 0;

			-- eaf:SetCooldown(EA_start, EA_duration);
			if (EA_expirationTime ~= nil) then
				EA_currentTime = GetTime();
				EA_timeLeft = 0 + EA_expirationTime - EA_currentTime;
			end
			
			--5.1�ץ�:���abuff�ج[���
			--eaf:SetCooldown(EA_currentTime, EA_timeLeft);

			SC_RedSecText = EAFun_GetSpellConditionRedSecText(EA_Items[EA_playerClass][spellId]);
			if (SC_RedSecText <= -1) then
				SC_RedSecText = EAFun_GetSpellConditionRedSecText(EA_Items[EA_CLASS_OTHER][spellId]);
			end
			EAFun_SetCountdownStackText(eaf, EA_timeLeft, EA_count, SC_RedSecText);

			isOverGrow = EAFun_CheckSpellConditionOverGrow(EA_count, EA_Items[EA_playerClass][spellId]);
			if (not isOverGrow) then
				isOverGrow = EAFun_CheckSpellConditionOverGrow(EA_count, EA_Items[EA_CLASS_OTHER][spellId]);
			end
			if (isOverGrow) then
				if (not eaf.overgrow) then
					EA_ActionButton_ShowOverlayGlow(eaf);
					eaf.overgrow = true;
				end
			else
				if (eaf.overgrow) then
					EA_ActionButton_HideOverlayGlow(eaf);
					eaf.overgrow = false;
				end
			end
		else
			eaf.spellTimer:SetText("");
			eaf.spellStack:SetText("");
		end
	end
end


-- function EventAlert_OnTarUpdate()
function EventAlert_OnTarUpdate(spellId)
	local SC_RedSecText, isOverGrow = -1, false;

	local v = tostring(spellId);
	local eaf = _G["EATarFrame_"..v];
	local name, rank = GetSpellInfo(v);
	spellId = tonumber(v);

	if eaf ~= nil then
		--eaf:SetCooldown(1, 0);
		if (EA_Config.ShowTimer) then
			--local EA_Name,_,_,EA_count,_,EA_duration,EA_expirationTime,_,_ = UnitAura("target", name, rank, "HELPFUL|HARMFUL");
			local EA_Name = EA_SPELLINFO_TARGET[spellId].name;
			local EA_count = EA_SPELLINFO_TARGET[spellId].count;
			local EA_expirationTime = EA_SPELLINFO_TARGET[spellId].expirationTime;
			local EA_value2 = EA_SPELLINFO_TARGET[spellId].value2;
			local IfIsDebuff = EA_SPELLINFO_TARGET[spellId].isDebuff;
			local EA_currentTime = 0;
			local EA_timeLeft = 0;
			
			
			if (EA_expirationTime ~= nil) then
				EA_currentTime = GetTime();
				EA_timeLeft = 0 + EA_expirationTime - EA_currentTime;
			end
			
			--5.1�ץ�:�ؼ�buff�ج[���
			--eaf:SetCooldown(EA_currentTime, EA_timeLeft);

			SC_RedSecText = EAFun_GetSpellConditionRedSecText(EA_TarItems[EA_playerClass][spellId]);

			EAFun_SetCountdownStackText(eaf, EA_timeLeft, EA_count, SC_RedSecText);

			isOverGrow = EAFun_CheckSpellConditionOverGrow(EA_count, EA_TarItems[EA_playerClass][spellId]);
			if (isOverGrow) then
				if (not eaf.overgrow) then
					EA_ActionButton_ShowOverlayGlow(eaf);
					eaf.overgrow = true;
				end
			else
				if (eaf.overgrow) then
					EA_ActionButton_HideOverlayGlow(eaf);
					eaf.overgrow = false;
				end
			end
		else
			eaf.spellTimer:SetText("");
			eaf.spellStack:SetText("");
		end
	end
end


local function EASCDFrame_AnimSize(self, fraction)
	local iAlpha = self:GetAlpha();
	local iSize = self:GetWidth();
	self:SetSize(iSize+1, iSize+1);
	return iAlpha-0.02;
end


local EASCDFrameAnimTable = {
	totalTime = 0.5,
	updateFunc = "SetAlpha",
	getPosFunc = EASCDFrame_AnimSize,
}


function EASCDFrame_AnimateOut(self)
	SetUpAnimation(self, EASCDFrameAnimTable, EASCDFrame_AnimFinished, true)
end


function EASCDFrame_AnimFinished(self)
end


function EventAlert_OnSCDUpdate(spellId)
	local iShift = 0;
	local eaf = _G["EAScdFrame_"..spellId];

	local EA_start, EA_duration, EA_Enable = GetSpellCooldown(spellId);								--���o�ޯ�N�o
	local EA_ChargeCurrent, EA_ChargeMax, EA_ChargeStart,EA_ChargeDuration = GetSpellCharges(spellId);				--���o�ޯ�R��
		
	local flag_usable,flag_nomana =IsUsableSpell(spellId)			

	if (eaf ~= nil) then
		local gsiIcon = EA_SPELLINFO_SCD[spellId].icon;
		eaf:SetBackdrop({bgFile = gsiIcon});
		eaf:SetWidth(EA_Config.IconSize);
		eaf:SetHeight(EA_Config.IconSize);		

		if EA_ChargeCurrent then
			local EA_timeLeft=EA_ChargeStart + EA_ChargeDuration - GetTime();
			if EA_ChargeCurrent > 0 then 			
				FrameGlowShowOrHide(eaf,flag_usable and EA_Config.IsKeepGlowSCD)				
				if EA_ChargeCurrent == EA_ChargeMax then
					EAFun_SetCountdownStackText(eaf,  0,EA_ChargeCurrent,0, 1);	
					
				else
					EAFun_SetCountdownStackText(eaf,  EA_timeLeft,EA_ChargeCurrent,0, 1);
				end
			else
				EA_ActionButton_HideOverlayGlow(eaf)
				EAFun_SetCountdownStackText(eaf, EA_timeLeft , EA_ChargeCurrent, -1);								
			end
		else

			if (EA_Enable == 1) then
								
				local EA_timeLeft = EA_start + EA_duration - GetTime();				
				local EA_GCD=1.5/((100+UnitSpellHaste("player"))/100)
				
				if EA_GCD < 1 then EA_GCD = 1 end
				
				--local EA_GCD=1.5
				
				if (EA_start > 0 and EA_duration > EA_GCD )  then					
					 --DEFAULT_CHAT_FRAME:AddMessage("[spellId="..spellId.." / EA_timeLeft="..EA_timeLeft.."]");	
					EA_ActionButton_HideOverlayGlow(eaf)						
					if (EA_Config.ShowTimer) then 
						EAFun_SetCountdownStackText(eaf, EA_timeLeft ,0, -1);						
					end
				else	
						
					eaf.spellTimer:SetText("")						
					FrameGlowShowOrHide(eaf,flag_usable and EA_Config.IsKeepGlowSCD)
					
				end			
			end
		end
		
		-- eaf:SetAlpha(1);		
		EventAlert_ScdPositionFrames();				
	end
end


function EventAlert_DoAlert()
	if (EA_Config.ShowFlash == true) then
		UIFrameFadeIn(LowHealthFrame, 1, 0, 1);
		UIFrameFadeOut(LowHealthFrame, 2, 1, 0);
	end
	if (EA_Config.DoAlertSound == true) then
		PlaySoundFile(EA_Config.AlertSound);
	end
end


function EventAlert_PositionFrames(event)
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local prevFrame2 = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;

		EA_CurrentBuffs = EAFun_SortCurrBuffs(1, EA_CurrentBuffs);

		for k,v in ipairs(EA_CurrentBuffs) do
			local eaf = _G["EAFrame_"..v];
			local spellId = tonumber(v);
			local gsiName = EA_SPELLINFO_SELF[spellId].name;
			local gsiValue1 = EA_SPELLINFO_SELF[spellId].value1;
			local gsiValue2 = EA_SPELLINFO_SELF[spellId].value2;
			local gsiValue3 = EA_SPELLINFO_SELF[spellId].value3;
			local gsiIcon = EA_SPELLINFO_SELF[spellId].icon;
			local gsiIsDebuff = EA_SPELLINFO_SELF[spellId].isDebuff;

			if eaf ~= nil then
				eaf:ClearAllPoints();
				if EA_Position.Tar_NewLine then
					if gsiIsDebuff then
						if (prevFrame2 == "EA_Main_Frame" or prevFrame2 == eaf) then
							prevFrame2 = "EA_Main_Frame";
							if EA_SpecFrame_Self then
								eaf:SetPoint(EA_Position.Anchor, prevFrame2, EA_Position.Anchor, -2 * xOffset, -2 * yOffset);
							else
								eaf:SetPoint(EA_Position.Anchor, prevFrame2, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);
							end
						else
							eaf:SetPoint("CENTER", prevFrame2, "CENTER", -1 * xOffset, -1 * yOffset);
						end
						prevFrame2 = eaf;
					else
						if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
							prevFrame = "EA_Main_Frame";
							eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, 0, 0);
						else
							eaf:SetPoint("CENTER", prevFrame, "CENTER", xOffset, yOffset);
						end
						prevFrame = eaf;
					end
				else
					if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
						prevFrame = "EA_Main_Frame";
						eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, 0, 0);
					else
						eaf:SetPoint("CENTER", prevFrame, "CENTER", xOffset, yOffset);
					end
					prevFrame = eaf;
				end;

				eaf:SetWidth(EA_Config.IconSize);
				eaf:SetHeight(EA_Config.IconSize);
				eaf:SetBackdrop({bgFile = gsiIcon});
				if gsiIsDebuff then eaf:SetBackdropColor(1.0, EA_Position.RedDebuff, EA_Position.RedDebuff) end;
				if (EA_Config.ShowName == true) then
					eaf.spellName:SetText(gsiName);
					SfontName, SfontSize = eaf.spellName:GetFont();
					eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf.spellName:SetText("");
				end
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
				eaf.spellStack:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.StackFontSize, "OUTLINE");
				eaf:SetScript("OnUpdate", function()
					EventAlert_OnUpdate(spellId)
				end);
				eaf:Show();
			end
		end
	end
end


function EventAlert_TarPositionFrames(event)
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local prevFrame2 = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;

		EA_TarCurrentBuffs = EAFun_SortCurrBuffs(2, EA_TarCurrentBuffs);

		for k,v in ipairs(EA_TarCurrentBuffs) do
			local eaf = _G["EATarFrame_"..v];
			local spellId = tonumber(v);
			local gsiName = EA_SPELLINFO_TARGET[spellId].name;
			local gsiIcon = EA_SPELLINFO_TARGET[spellId].icon;
			local gsiValue1 = EA_SPELLINFO_TARGET[spellId].value1;
			local gsiValue2 = EA_SPELLINFO_TARGET[spellId].value2;
			local gsiValue3 = EA_SPELLINFO_TARGET[spellId].value3;
			local gsiIsDebuff = EA_SPELLINFO_TARGET[spellId].isDebuff;

			if eaf ~= nil then
				eaf:ClearAllPoints();
				if EA_Position.Tar_NewLine then
					if gsiIsDebuff then
						if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
							prevFrame = "EA_Main_Frame";
							eaf:SetPoint(EA_Position.TarAnchor, UIParent, EA_Position.TarAnchor, EA_Position.Tar_xOffset, EA_Position.Tar_yOffset);
						else
							eaf:SetPoint("CENTER", prevFrame, "CENTER", xOffset, yOffset);
						end
						prevFrame = eaf;
					else
						if (prevFrame2 == "EA_Main_Frame" or prevFrame2 == eaf) then
							prevFrame2 = "EA_Main_Frame";
							if EA_SpecFrame_Target then
								eaf:SetPoint(EA_Position.TarAnchor, UIParent, EA_Position.TarAnchor, EA_Position.Tar_xOffset - 2 * xOffset, EA_Position.Tar_yOffset - 2 * yOffset);
								-- eaf:SetPoint(EA_Position.TarAnchor, prevFrame2, EA_Position.TarAnchor, -2 * xOffset, -2 * yOffset);
							else
								eaf:SetPoint(EA_Position.TarAnchor, UIParent, EA_Position.TarAnchor, EA_Position.Tar_xOffset - xOffset, EA_Position.Tar_yOffset - yOffset);
								-- eaf:SetPoint(EA_Position.TarAnchor, prevFrame2, EA_Position.TarAnchor, -1 * xOffset, -1 * yOffset);
							end
						else
							eaf:SetPoint("CENTER", prevFrame2, "CENTER", -1 * xOffset, -1 * yOffset);
						end
						prevFrame2 = eaf;
					end
				else
					if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
						prevFrame = "EA_Main_Frame";
						eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);
					else
						eaf:SetPoint("CENTER", prevFrame, "CENTER", -1 * xOffset, -1 * yOffset);
					end
				end

				eaf:SetWidth(EA_Config.IconSize);
				eaf:SetHeight(EA_Config.IconSize);
				eaf:SetBackdrop({bgFile = gsiIcon});
				if gsiIsDebuff then eaf:SetBackdropColor(EA_Position.GreenDebuff, 1.0, EA_Position.GreenDebuff) end;
				local tmp;
				if (EA_Config.ShowName == true) then
					tmp=gsiName
					-- print(tmp,gsiValue1,gsiValue2,gsiValue3)
					--if gsiValue1 and (gsiValue1 > 0) then  tmp=tmp.."("..gsiValue1..")" end
					--if gsiValue2 and (gsiValue2 > 0)then  tmp=tmp.."("..gsiValue2..")" end
					--if gsiValue3 and (gsiValue3 > 0)then  tmp=tmp.."("..gsiValue3..")" end
					
					eaf.spellName:SetText(tmp);
					SfontName, SfontSize = eaf.spellName:GetFont();
					eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf.spellName:SetText("");
				end
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
				eaf.spellStack:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.StackFontSize, "OUTLINE");
				eaf:SetScript("OnUpdate", function()
					EventAlert_OnTarUpdate(spellId)
				end);
				eaf:Show();
			end
		end
	end
end

function EventAlert_ScdPositionFrames()
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;

		for k,v in ipairs(EA_ScdCurrentBuffs) do
			local eaf = _G["EAScdFrame_"..v];
			local spellId = tonumber(v);
			local gsiName = EA_SPELLINFO_SCD[spellId].name;

			if eaf ~= nil then
				eaf:ClearAllPoints();
				if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
					prevFrame = "EA_Main_Frame";
					eaf:SetPoint("CENTER", UIParent, EA_Position.ScdAnchor, EA_Position.Scd_xOffset, EA_Position.Scd_yOffset);
				else
					eaf:SetPoint("CENTER", prevFrame, "CENTER", xOffset, yOffset);
				end

				if (EA_Config.ShowName == true) then
					eaf.spellName:SetText(gsiName);
					SfontName, SfontSize = eaf.spellName:GetFont();
					eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf.spellName:SetText("");
				end
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
				eaf.spellStack:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.StackFontSize, "OUTLINE");
				prevFrame = eaf;
				--FrameShowOrHide(eaf,(eaf:IsShown() and EA_Config.IsKeepSCD))
				eaf:Show();
			end
		end
	end
end


-- The command parser
function EventAlert_SlashHandler(msg)
	local F_EA = "\124cffFFFF00EventAlertMod\124r";
	local F_ON = "\124cffFF0000".."[ON]".."\124r";
	local F_OFF = "\124cff00FFFF".."[OFF]".."\124r";
	local RtnMsg = "";
	local MoreHelp = false;

	msg = string.lower(msg);
	local cmdtype, para1 = strsplit(" ", msg)
	local listSec = 0;
	if para1 ~= nil then
		listSec = tonumber(para1);
	end

	if (cmdtype == "options" or cmdtype == "opt") then
		if not EA_Options_Frame:IsVisible() then
			-- ShowUIPanel(EA_Options_Frame);
			EA_Options_Frame:Show();
		else
			-- HideUIPanel(EA_Options_Frame);
			EA_Options_Frame:Hide();
		end

	-- elseif (cmdtype == "version" or cmdtype == "ver") then
	--  DEFAULT_CHAT_FRAME:AddMessage(F_EA..EA_XCMD_VER..EA_Config.Version);

	elseif (cmdtype == "show") then
		EA_DEBUGFLAG11 = false;
		EA_DEBUGFLAG21 = false;
		EA_LISTSEC_SELF = 0;
		if (EA_DEBUGFLAG1) then
			EA_DEBUGFLAG1 = false;
			RtnMsg = F_EA..EA_XCMD_SELFLIST..F_OFF;
		else
			EA_DEBUGFLAG1 = true;
			EA_LISTSEC_SELF = listSec;
			RtnMsg = F_EA..EA_XCMD_SELFLIST..F_ON;
			if EA_LISTSEC_SELF > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_SELF.." secs)" end;
			EAFun_ClearSpellScrollFrame();
			EA_Version_Frame:Show();
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showtarget" or cmdtype == "showt") then
		EA_DEBUGFLAG11 = false;
		EA_DEBUGFLAG21 = false;
		EA_LISTSEC_TARGET = 0;
		if (EA_DEBUGFLAG2) then
			EA_DEBUGFLAG2 = false;
			RtnMsg = F_EA..EA_XCMD_TARGETLIST..F_OFF;
		else
			EA_DEBUGFLAG2 = true;
			EA_LISTSEC_TARGET = listSec;
			RtnMsg = F_EA..EA_XCMD_TARGETLIST..F_ON;
			if EA_LISTSEC_TARGET > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_TARGET.." secs)" end;
			EAFun_ClearSpellScrollFrame();
			EA_Version_Frame:Show();
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showcast" or cmdtype == "showc") then
		EA_DEBUGFLAG11 = false;
		EA_DEBUGFLAG21 = false;
		if (EA_DEBUGFLAG3) then
			EA_DEBUGFLAG3 = false;
			RtnMsg = F_EA..EA_XCMD_CASTSPELL..F_OFF;
		else
			EA_DEBUGFLAG3 = true;
			RtnMsg = F_EA..EA_XCMD_CASTSPELL..F_ON;
			EAFun_ClearSpellScrollFrame();
			EA_Version_Frame:Show();
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showautoadd" or cmdtype == "showa") then
		EA_DEBUGFLAG1 = false;
		EA_DEBUGFLAG2 = false;
		EA_DEBUGFLAG3 = false;
		EA_DEBUGFLAG21 = false;
		EA_LISTSEC_SELF = 60;
		if (EA_DEBUGFLAG11) then
			EA_DEBUGFLAG11 = false;
			RtnMsg = F_EA..EA_XCMD_AUTOADD_SELFLIST..F_OFF;
		else
			EA_DEBUGFLAG11 = true;
			RtnMsg = F_EA..EA_XCMD_AUTOADD_SELFLIST..F_ON;
			if listSec > 0 then EA_LISTSEC_SELF = listSec end;
			if EA_LISTSEC_SELF > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_SELF.." secs)" end;
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showenvadd" or cmdtype == "showe") then
		EA_DEBUGFLAG1 = false;
		EA_DEBUGFLAG2 = false;
		EA_DEBUGFLAG3 = false;
		EA_DEBUGFLAG11 = false;
		EA_LISTSEC_SELF = 60;
		if (EA_DEBUGFLAG21) then
			EA_DEBUGFLAG21 = false;
			RtnMsg = F_EA..EA_XCMD_ENVADD_SELFLIST..F_OFF;
		else
			EA_DEBUGFLAG21 = true;
			RtnMsg = F_EA..EA_XCMD_ENVADD_SELFLIST..F_ON;
			if listSec > 0 then EA_LISTSEC_SELF = listSec end;
			if EA_LISTSEC_SELF > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_SELF.." secs)" end;
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "lookup") or (cmdtype == "l")then
		EventAlert_Lookup(para1, false);

	elseif (cmdtype == "lookupfull") or (cmdtype == "lf") then
		EventAlert_Lookup(para1, true);

	elseif (cmdtype == "list") then
		EA_Version_Frame_HeaderText:SetText(EA_XCMD_DEBUG_P0);
		EA_Version_ScrollFrame_EditBox:Hide();
		EA_Version_Frame:Show();

	elseif (cmdtype == "print") then
		-- table.foreach(EA_ClassAltSpellName,
		-- function(i, v)
		--  if v == nil then v = "nil" end;
		--  DEFAULT_CHAT_FRAME:AddMessage("["..i.."]EA_ClassAltSpellName["..i.."]="..EA_ClassAltSpellName[i].." v="..v);
		-- end
		-- )
		-- EAFun_CreateVersionFrame_ScrollEditBox();
		-- EA_Version_Frame_HeaderText:SetText("Test");
		-- EA_Version_Frame:Show();
		-- print ("go print");
		-- for  i, v in pairsByKeys(EA_Items) do
		--  print (i);
		--  --if v.enable then
		--  --  print ("enable T");
		--  --else
		--  --  print ("enable F");
		--  --end
		-- end

	-- elseif (cmdtype == "play") then
	--  EventAlert_ExecutionFrame:SetAlpha(1);
	--  EventAlert_ExecutionFrame:Show();
	--  iEAEXF_FrameCount = 0;
	--  iEAEXF_Prefraction = 0;
	--  EAEXF_AnimateOut(EventAlert_ExecutionFrame);

	else
		if cmdtype == "help" then MoreHelp = true end;
		DEFAULT_CHAT_FRAME:AddMessage(F_EA..EA_XCMD_VER..EA_Config.Version);
		DEFAULT_CHAT_FRAME:AddMessage(EA_XCMD_CMDHELP.TITLE);
		DEFAULT_CHAT_FRAME:AddMessage(EA_XCMD_CMDHELP.OPT);
		DEFAULT_CHAT_FRAME:AddMessage(EA_XCMD_CMDHELP.HELP);

		for i, v in ipairs(EA_XCMD_CMDHELP["SHOW"]) do
			if i == 1 then
				if EA_DEBUGFLAG1 then v = v..EA_XCMD_SELFLIST..F_ON else v = v..EA_XCMD_SELFLIST..F_OFF end;
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["SHOWT"]) do
			if i == 1 then
				if EA_DEBUGFLAG2 then v = v..EA_XCMD_TARGETLIST..F_ON else v = v..EA_XCMD_TARGETLIST..F_OFF end;
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["SHOWC"]) do
			if i == 1 then
				if EA_DEBUGFLAG3 then v = v..EA_XCMD_CASTSPELL..F_ON else v = v..EA_XCMD_CASTSPELL..F_OFF end;
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["SHOWA"]) do
			if i == 1 then
				if EA_DEBUGFLAG11 then v = v..EA_XCMD_AUTOADD_SELFLIST..F_ON else v = v..EA_XCMD_AUTOADD_SELFLIST..F_OFF end;
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["SHOWE"]) do
			if i == 1 then
				if EA_DEBUGFLAG21 then v = v..EA_XCMD_ENVADD_SELFLIST..F_ON else v = v..EA_XCMD_ENVADD_SELFLIST..F_OFF end;
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["LIST"]) do
			if i == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["LOOKUP"]) do
			if i == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["LOOKUPFULL"]) do
			if i == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
	end
end


-- The URLs of update
function EventAlert_ShowVerURL(SiteIndex)
	local VerUrl = "";
	VerUrl = EA_XOPT_VERURL1;
	if SiteIndex ~= 1 then 
		VerUrl = "http://forum.gamer.com.tw/Co.php?bsn=05219&sn=5125122&subbsn=0";
	end

	-- WOW API�T����Ұ��s�����s�����A�u�����URL�b��ܵ������C
	DEFAULT_CHAT_FRAME:AddMessage(VerUrl);
end


function EAFun_CreateVersionFrame_ScrollEditBox()
	local framewidth = EA_Version_Frame:GetWidth()-45;
	local frameheight = EA_Version_Frame:GetHeight()-70;
	local panel3 = _G["EA_Version_ScrollFrame"];
	if panel3 == nil then
		panel3 = CreateFrame("ScrollFrame", "EA_Version_ScrollFrame", EA_Version_Frame, "UIPanelScrollFrameTemplate");
	end
	local scc = _G["EA_Version_ScrollFrame_List"];
	if scc == nil then
		scc = CreateFrame("Frame", "EA_Version_ScrollFrame_List", panel3);
		panel3:SetScrollChild(scc);
		panel3:SetPoint("TOPLEFT", EA_Version_Frame, "TOPLEFT", 15, -30);
		scc:SetPoint("TOPLEFT", panel3, "TOPLEFT", 0, 0);
		panel3:SetWidth(framewidth);
		panel3:SetHeight(frameheight);
		scc:SetWidth(framewidth);
		scc:SetHeight(frameheight);
		panel3:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
		panel3:SetScript("OnVerticalScroll", function()  end);
		panel3:EnableMouse(true);
		panel3:SetVerticalScroll(0);
		panel3:SetHorizontalScroll(0);
	end
	local etb1 = _G["EA_Version_ScrollFrame_EditBox"];
	if etb1 == nil then
		etb1 = CreateFrame("EditBox", "EA_Version_ScrollFrame_EditBox", scc);
		etb1:SetPoint("TOPLEFT",0,0);
		etb1:SetFontObject(ChatFontNormal);
		etb1:SetWidth(framewidth);
		etb1:SetHeight(frameheight);
		etb1:SetMultiLine();
		etb1:SetMaxLetters(0);
		etb1:SetAutoFocus(false);
	end
end

local function EAFun_ExtendExecution_4505(EAItems)
	for index1, value1 in pairsByKeys(EAItems) do
		if EAItems[index1] ~= nil then EAItems[index1].Execution = 0 end;
	end
	return EAItems;
end
local function EAFun_ChangeSavedVariblesFormat_4505(EAItems, EASelf)
	if EAItems == nil then EAItems = { } end;
	for index1, value1 in pairsByKeys(EAItems) do
		for index2, value2 in pairsByKeys(EAItems[index1]) do
			if (EASelf) then
				EAItems[index1][index2] = {enable=value2, self=true,};
			else
				EAItems[index1][index2] = {enable=value2,};
			end
		end
	end
	return EAItems;
end

function EventAlert_VersionCheck()
	local EA_TocVersion = GetAddOnMetadata("EventAlertMod", "Version");
	-- local F_EA = "\124cffFFFF00EventAlertMod\124r";

	EAFun_CreateVersionFrame_ScrollEditBox();
	EA_Version_Frame_Okay:SetText(EA_XOPT_OKAY);

	if (EA_Config.Version ~= EA_TocVersion and EA_Config.Version ~= nil) then
		if (EA_Config.Version < "4.5.01" and EA_TocVersion < "4.5.04") then
			-- Ver 4.5.01 is For WOW 4.0.1+
			-- Many WOW 3.x spells are canceled or integrated,
			-- so the saved-spells should be clear, and to load the new spells.
			EA_Items = { };
			EA_AltItems = { };
			EA_TarItems = { };
			EA_ScdItems = { };
			EA_GrpItems = { };
		end
		if (EA_Config.Version < "4.5.05" and EA_TocVersion <= "4.7.02") then
			-- EventAlert SpellArray Format Change, from true/false values to parameters values
			-- so, it should formate old parameters to new
			EA_Pos = EAFun_ExtendExecution_4505(EA_Pos);
			EA_Items = EAFun_ChangeSavedVariblesFormat_4505(EA_Items, false);
			EA_AltItems = EAFun_ChangeSavedVariblesFormat_4505(EA_AltItems, false);
			EA_TarItems = EAFun_ChangeSavedVariblesFormat_4505(EA_TarItems, true);
			EA_ScdItems = EAFun_ChangeSavedVariblesFormat_4505(EA_ScdItems, false);
			EA_GrpItems = { };
		end
		EA_Config.Version = EA_TocVersion;
		-- if (EA_XLOAD_NEWVERSION_LOAD ~= "") then
		-- 	EA_Version_ScrollFrame_EditBox:SetText(F_EA..EA_XCMD_VER..EA_Config.Version.."\n\n\n"..EA_XLOAD_NEWVERSION_LOAD);
		-- 	EA_Version_Frame:Show();
		-- end
		EventAlert_LoadClassSpellArray(9);
	elseif (EA_Config.Version == nil) then
		EA_Items = { };
		EA_AltItems = { };
		EA_TarItems = { };
		EA_ScdItems = { };
		EA_GrpItems = { };
		EA_Config.Version = EA_TocVersion;
		-- if (EA_XLOAD_FIRST_LOAD ~= "") then
		-- 	EA_Version_ScrollFrame_EditBox:SetText(F_EA..EA_XCMD_VER..EA_Config.Version.."\n\n\n"..EA_XLOAD_FIRST_LOAD..EA_XLOAD_NEWVERSION_LOAD)
		-- 	EA_Version_Frame:Show();
		-- end
		EventAlert_LoadClassSpellArray(9);
	elseif (EAFun_GetCountOfTable(EA_Items[EA_playerClass]) <= 0) then
		EventAlert_LoadClassSpellArray(9);
	end

	if EA_Items[EA_playerClass] == nil then EA_Items[EA_playerClass] = {} end;
	if EA_AltItems[EA_playerClass] == nil then EA_AltItems[EA_playerClass] = {} end;
	if EA_Items[EA_CLASS_OTHER] == nil then EA_Items[EA_CLASS_OTHER] = {} end;
	if EA_TarItems[EA_playerClass] == nil then EA_TarItems[EA_playerClass] = {} end;
	if EA_ScdItems[EA_playerClass] == nil then EA_ScdItems[EA_playerClass] = {} end;
	if EA_GrpItems[EA_playerClass] == nil then EA_GrpItems[EA_playerClass] = {} end;
	-- EventAlert_LoadClassSpellArray(6);
	-- After confirm the version, set the VersionText in the EA_Options_Frame.
	EA_Options_Frame_VersionText:SetText("Ver:\124cffFFFFFF"..EA_Config.Version.."\124r");
end


function insertBuffValue(tab, value)
	local isExist = false;
	for pos, name in ipairs(tab) do
		if (name == value) then
			isExist = true;
		end
	end
	if not isExist then table.insert(tab, value) end;
end

function removeBuffValue(tab, value)
	for pos, name in ipairs(tab) do
		if (name == value) then
			table.remove(tab, pos)
		end
	end
end

function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0 -- iterator variable
	local iter = function () -- iterator function
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	return iter
end

function EAFun_GetFormattedTime(timeLeft)
	local formattedTime = "";
	if timeLeft <= 60 then
		if EA_Config.IsUseFloat or (timeLeft < 1.5) then
			formattedTime = tostring(format("%.1f",timeLeft));
		else	
			--formattedTime = tostring(floor(timeLeft));
			formattedTime = tostring(format("%d",timeLeft));
		end 
	else
		formattedTime = format("%d:%02d", floor(timeLeft/60), timeLeft % 60);
	end
	return formattedTime;
end

function MyPrint(info)
	DEFAULT_CHAT_FRAME:AddMessage(info);
end

function EAFun_SetCountdownStackText(eaf, EA_timeLeft, EA_count, SC_RedSecText)
	eaf.spellTimer:ClearAllPoints();
	if ((SC_RedSecText == nil) or (SC_RedSecText <= 0)) then SC_RedSecText = -1 end;
	if (EA_timeLeft > 0) then
		if (EA_Config.ChangeTimer == true) then
			eaf.spellTimer:SetPoint("CENTER", 0, 0);
		else
			eaf.spellTimer:SetPoint("TOP", 0, EA_Config.TimerFontSize);
		end
		if (EA_timeLeft < SC_RedSecText + 1) then
			if (not eaf.redsectext) then
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize*1.1+5, "OUTLINE");
				eaf.spellTimer:SetTextColor(1, 0, 0);
				eaf.redsectext = true;
				eaf.whitesectext = false;
			end
		else
			if (not eaf.whitesectext) then
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize*1.1, "OUTLINE");
				eaf.spellTimer:SetTextColor(1, 1, 1);
				eaf.redsectext = false;
				eaf.whitesectext = true;
			end
		end
		eaf.spellTimer:SetText(EAFun_GetFormattedTime(EA_timeLeft));
	else
		eaf.spellTimer:SetText("");
	end

	eaf.spellStack:ClearAllPoints();
	if (EA_count > 0) then
		eaf.spellStack:SetPoint("CENTER", EA_Config.TimerFontSize/3*2, -EA_Config.TimerFontSize/3*2);
		eaf.spellStack:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.StackFontSize*1.05, "OUTLINE");
		eaf.spellStack:SetFormattedText("%d", EA_count);
	else
		eaf.spellStack:SetFormattedText("");
	end
end

-- Speciall Frame: UpdateComboPoint, for watching the combopoint of player
function EventAlert_UpdateComboPoint()
	local iComboPoint = GetComboPoints("player", "target");
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;
		local eaf = _G["EAFrameSpec_10000"];

		if (eaf ~= nil) then
			if (iComboPoint > 0) then
				EA_SpecFrame_Target = true;
				eaf:ClearAllPoints();
				eaf:SetPoint(EA_Position.TarAnchor, UIParent, EA_Position.TarAnchor, EA_Position.Tar_xOffset - xOffset, EA_Position.Tar_yOffset - yOffset);

				if (EA_Config.ShowName) then
					eaf.spellName:SetText(EA_XSPECINFO_COMBOPOINT);
					SfontName, SfontSize = eaf.spellName:GetFont();
					eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf.spellName:SetText("");
				end

				EAFun_SetCountdownStackText(eaf, iComboPoint, 0, -1);
				eaf:Show();
				if (iComboPoint >= 5) then 
					EA_ActionButton_ShowOverlayGlow(eaf)
				else
					EA_ActionButton_HideOverlayGlow(eaf)
				end;
			else
				EA_ActionButton_HideOverlayGlow(eaf);
				EA_SpecFrame_Target = false;
				eaf:Hide();
			end
			EventAlert_TarPositionFrames();
		end
	end
end

-- Speciall Frame: UpdateEclipse, for watching the eclipse of player
function EventAlert_UpdateEclipse()
	local iUnitPower = UnitPower("player", 8);
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;
		local eaf1 = _G["EAFrameSpec_10081"];
		local eaf2 = _G["EAFrameSpec_10082"];

		if ((eaf1 ~= nil) and (eaf2 ~= nil)) then
			if (iUnitPower > 0) then
				EA_ActionButton_HideOverlayGlow(eaf1);
				EA_SpecFrame_Self = true;
				eaf1:ClearAllPoints();
				eaf2:ClearAllPoints();
				eaf1:Hide();
				eaf2:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);

				if (EA_Config.ShowName == true) then
					eaf2.spellName:SetText(EA_XSPECINFO_ECLIPSEORG);
					SfontName, SfontSize = eaf2.spellName:GetFont();
					eaf2.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf2.spellName:SetText("");
				end

				eaf2.spellTimer:ClearAllPoints();
				if (EA_Config.ChangeTimer == true) then
					eaf2.spellTimer:SetPoint("CENTER", 0, 0);
				else
					eaf2.spellTimer:SetPoint("TOP", 0, EA_Config.TimerFontSize*1.1);
				end
				eaf2.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
				eaf2.spellTimer:SetText(iUnitPower);
				eaf2:Show();
				if (iUnitPower >= 100) then EA_ActionButton_ShowOverlayGlow(eaf2) end;
			elseif (iUnitPower < 0) then
				EA_ActionButton_HideOverlayGlow(eaf2);
				EA_SpecFrame_Self = true;
				eaf1:ClearAllPoints();
				eaf2:ClearAllPoints();
				eaf1:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);
				eaf2:Hide();

				if (EA_Config.ShowName == true) then
					eaf1.spellName:SetText(EA_XSPECINFO_ECLIPSE);
					SfontName, SfontSize = eaf1.spellName:GetFont();
					eaf1.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf1.spellName:SetText("");
				end

				eaf1.spellTimer:ClearAllPoints();
				if (EA_Config.ChangeTimer == true) then
					eaf1.spellTimer:SetPoint("CENTER", 0, 0);
				else
					eaf1.spellTimer:SetPoint("TOP", 0, EA_Config.TimerFontSize*1.1);
				end
				eaf1.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
				eaf1.spellTimer:SetText(-1 * iUnitPower);
				eaf1:Show();
				if (iUnitPower <= -100) then EA_ActionButton_ShowOverlayGlow(eaf1) end;
			else
				EA_ActionButton_HideOverlayGlow(eaf1);
				EA_ActionButton_HideOverlayGlow(eaf2);
				EA_SpecFrame_Self = false;
				eaf1:Hide();
				eaf2:Hide();
			end
			EventAlert_PositionFrames();
		end
	end
end

-- Speciall Frame: UpdateSinglePower(holy power, runic power, soul shards), for watching the power of player
function EventAlert_UpdateSinglePower(iPowerType)
	local iUnitPower = UnitPower("player", iPowerType);
	local iPowerName = "";
	local iFrameIndex = 10000 + iPowerType * 10;
	local iGrowPower = EA_SPELL_POWER_ENERGY;
	if (iPowerType == EA_SPELL_POWER_RUNIC_POWER) then iPowerName = EA_XSPECINFO_RUNICPOWER end;
	if (iPowerType == EA_SPELL_POWER_SOUL_SHARDS) then iPowerName = EA_XSPECINFO_SOULSHARDS end;
	if (iPowerType == EA_SPELL_POWER_HOLY_POWER) then iPowerName = EA_XSPECINFO_HOLYPOWER end;
	
	--5.1�s�W by ZYF:�[�J��t�v�_�],��� ������ ��q���䴩
	if (iPowerType == EA_SPELL_POWER_SHADOW_ORBS) then iPowerName = EA_XSPECINFO_SHADOWORBS end;
	if (iPowerType == EA_SPELL_POWER_RAGE) then iPowerName = EA_XSPECINFO_RAGE end;
	if (iPowerType == EA_SPELL_POWER_FOCUS) then iPowerName = EA_XSPECINFO_FOCUS end;	
	if (iPowerType == EA_SPELL_POWER_ENERGY) then iPowerName = EA_XSPECINFO_ENERGY end;
	
	-- �䴩�Z���u��
	if (iPowerType == EA_SPELL_POWER_LIGHT_FORCE) then iPowerName = EA_XSPECINFO_LIGHTFORCE end;
	
	-- �䴩�U���l�u,�c�]����
	if (iPowerType == EA_SPELL_POWER_BURNING_EMBERS) then iPowerName = EA_XSPECINFO_BURNINGEMBERS end;
	if (iPowerType == EA_SPELL_POWER_DEMONIC_FURY) then iPowerName = EA_XSPECINFO_DEMONICFURY end;
	
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;
		local eaf = _G["EAFrameSpec_"..iFrameIndex];

		if (eaf ~= nil) then
			if (iUnitPower > 0) then
				EA_SpecFrame_Self = true;
				eaf:ClearAllPoints();
				
				--5.1�s�W by ZYF:�N���P��q�ج[���}��m�H�Q�w�|�����
				if (iPowerType==3) then				--�Y�O��q���O�N�N�ج[�A�������ʤ@��
					eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -2 * xOffset, -1 * yOffset);
				else
					eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);
				end 

				if (EA_Config.ShowName == true) then
					eaf.spellName:SetText(iPowerName);
					SfontName, SfontSize = eaf.spellName:GetFont();
					eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf.spellName:SetText("");
				end

				eaf.spellTimer:ClearAllPoints();
				if (EA_Config.ChangeTimer == true) then
					eaf.spellTimer:SetPoint("CENTER", 0, 0);
				else
					eaf.spellTimer:SetPoint("TOP", 0, EA_Config.TimerFontSize*1.1);
				end
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
				eaf.spellTimer:SetText(iUnitPower);
				eaf:Show();

				-- �t��3�h�ɰ��G�סA����3�h�������G��
				if (iPowerType == EA_SPELL_POWER_HOLY_POWER) then
					if (iUnitPower >=3) then 
						EA_ActionButton_ShowOverlayGlow(eaf);
					else
						EA_ActionButton_HideOverlayGlow(eaf);
					end
				end
				
				-- �t�v�_�]3�h�ɰ��G�סA����3�h�������G��
				if (iPowerType == EA_SPELL_POWER_SHADOW_ORBS) then
					if (iUnitPower >=3) then 
						EA_ActionButton_ShowOverlayGlow(eaf);
					else
						EA_ActionButton_HideOverlayGlow(eaf);
					end
				end

				-- �u��4�h�ɰ��G�סA����4�h�������G��
				if (iPowerType == EA_SPELL_POWER_LIGHT_FORCE) then
					if (iUnitPower >=4) then 
						EA_ActionButton_ShowOverlayGlow(eaf);
					else
						EA_ActionButton_HideOverlayGlow(eaf);
					end
				end
			else
				EA_ActionButton_HideOverlayGlow(eaf);
				EA_SpecFrame_Self = false;
				eaf:Hide();
			end
			EventAlert_PositionFrames();
		end
	end
end

-- Speciall Frame: UpdateLifeBloom & OnLifeBloomUpdate, for watching the currently(max-stack) lifebloom of player
function EventAlert_OnLifeBloomUpdate()
	local iFrameIndex = 33763;
	local eaf = _G["EAFrameSpec_"..iFrameIndex];
	if (eaf ~= nil) then
		local EA_timeLeft = 0;
		if (EA_SpecFrame_LifeBloom.ExpireTime ~= nil) then
			EA_timeLeft = EA_SpecFrame_LifeBloom.ExpireTime - GetTime();
		end

		if (EA_timeLeft > 0) then
			if (EA_Config.ShowTimer) then
				EAFun_SetCountdownStackText(eaf, EA_timeLeft, EA_SpecFrame_LifeBloom.Stack, -1);
				if EA_timeLeft < 4 then 
				 	eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize+5, "OUTLINE");
					eaf.spellTimer:SetTextColor(1, 0, 0);
				else
				 	eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
					eaf.spellTimer:SetTextColor(1, 1, 1);
				end
			end
		else
			EA_SpecFrame_LifeBloom.UnitID = "";
			EA_SpecFrame_LifeBloom.UnitName = "";
			EA_SpecFrame_LifeBloom.ExpireTime = 0;
			EA_SpecFrame_LifeBloom.Stack = 0;
			EA_SpecFrame_Self = false;
			eaf:SetScript("OnUpdate", nil);
			if eaf:IsVisible() then eaf:Hide() end;
			EventAlert_PositionFrames();
		end
	end
end
function EventAlert_UpdateLifeBloom(EA_Unit)
	local iFrameIndex = 33763;
	local fNewToShow = false;
	local eaf = _G["EAFrameSpec_"..iFrameIndex];

	if (eaf ~= nil) then
		if (EA_Unit ~= "") then
			if (EA_Config.ShowFrame == true) then
				EA_Main_Frame:ClearAllPoints();
				EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
				local prevFrame = "EA_Main_Frame";
				local xOffset = 100 + EA_Position.xOffset;
				local yOffset = 0 + EA_Position.yOffset;
				local SfontName, SfontSize = "", 0;
	
				for i=1,40 do
					local _, _, _, count, _, _, expirationTime, unitCaster, _, _, spellId = UnitBuff(EA_Unit, i)
					if (not spellId) then
						break;
					end
					if (spellId == iFrameIndex and unitCaster == "player") then
						local iShiftFormID = GetShapeshiftFormID();
						fNewToShow = false;
						if (iShiftFormID == nil) then
							fNewToShow = true;	-- Non-Lift of tree, single lifebloom
						elseif (iShiftFormID == 2) then -- Life of tree form, multi lifebloom
							if (count > EA_SpecFrame_LifeBloom.Stack) then
								fNewToShow = true;
							elseif (count == EA_SpecFrame_LifeBloom.Stack and expirationTime >= EA_SpecFrame_LifeBloom.ExpireTime) then
								fNewToShow = true;
							end
						end
						if (fNewToShow) then
							EA_SpecFrame_LifeBloom.UnitID = EA_Unit;
							EA_SpecFrame_LifeBloom.UnitName = UnitName(EA_Unit);
							EA_SpecFrame_LifeBloom.ExpireTime = expirationTime;
							EA_SpecFrame_LifeBloom.Stack = count;
						end
						break;
					end
				end

				if (fNewToShow) then
					EA_SpecFrame_Self = true;
					eaf:ClearAllPoints();
					eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);
					eaf:SetWidth(EA_Config.IconSize);
					eaf:SetHeight(EA_Config.IconSize);

					if (EA_Config.ShowName == true) then
						eaf.spellName:SetText(EA_SpecFrame_LifeBloom.UnitName);
						SfontName, SfontSize = eaf.spellName:GetFont();
						eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
					else
						eaf.spellName:SetText("");
					end
					eaf:SetScript("OnUpdate", EventAlert_OnLifeBloomUpdate);
					eaf:Show();
				end
				EventAlert_PositionFrames();
			end
		else
			-- print ("fNewToShow = false 1");
			EA_SpecFrame_LifeBloom.UnitID = "";
			EA_SpecFrame_LifeBloom.UnitName = "";
			EA_SpecFrame_LifeBloom.ExpireTime = 0;
			EA_SpecFrame_LifeBloom.Stack = 0;
			EA_SpecFrame_Self = false;
			eaf:SetScript("OnUpdate", nil);
			if eaf:IsVisible() then eaf:Hide() end;
			EventAlert_PositionFrames();
		end
	end
end

-- Speciall Frame: CheckExecution, for checking the health percent of the current target
function EventAlert_CheckExecution()
	if (EA_Position.Execution > 0) then
		local iDead = UnitIsDeadOrGhost("target");
		local iEnemy = UnitIsEnemy("player", "target");
		local iLevel = 3;
		if EA_Position.PlayerLv2BOSS then iLevel = 2 end;
		if ((iDead ~= 1) and (iEnemy == 1)) then
			local iLvPlayer, iLvTarget = UnitLevel("player"), UnitLevel("target");
			if ((iLvTarget == -1) or (iLvTarget - iLvPlayer >= iLevel)) then
				local iHppTarget = (UnitHealth("target") * 100) / UnitHealthMax("target");
				if (iHppTarget <= EA_Position.Execution) then
					if (not iEAEXF_AlreadyAlert) then
						EventAlert_ExecutionFrame:SetAlpha(1);
						EventAlert_ExecutionFrame:Show();
						iEAEXF_FrameCount = 0;
						iEAEXF_Prefraction = 0;
						EAEXF_AnimateOut(EventAlert_ExecutionFrame);
						iEAEXF_AlreadyAlert = true;
					end
				else
					iEAEXF_AlreadyAlert = false;
				end
			end
		else
			iEAEXF_AlreadyAlert = false;
		end
	end
end


function EventAlert_Lookup(para1, fullmatch)
	local sFMatch = "";
	local sName = "";
	local iCount = 0;
	local sSpellLink = "";
	local fGoPrint = false;
	
	if (para1 == nil) then 
		for i, v in ipairs(EA_XCMD_CMDHELP["LOOKUP"]) do
			if i == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["LOOKUPFULL"]) do
			if i == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		return; 
	end;
	
	if fullmatch then sFMatch = " / "..EA_XLOOKUP_START2 end;
	DEFAULT_CHAT_FRAME:AddMessage(EA_XLOOKUP_START1..": [\124cffFFFF00"..para1.."\124r]"..sFMatch);
	EAFun_ClearSpellScrollFrame();
	for i=1,249999 do
		sName = GetSpellInfo(i);
		fGoPrint = false;
		if (sName ~= nil) then
			if (fullmatch) then
				if (sName == para1) then fGoPrint = true end;
			else
				if (strfind(sName, para1)) then fGoPrint = true end;
			end
			if (fGoPrint) then
				sSpellLink = GetSpellLink(i);
				if (sSpellLink ~= nil) then
					iCount = iCount + 1;
					-- DEFAULT_CHAT_FRAME:AddMessage("["..tostring(iCount).."]\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r="..tostring(i).." / \124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r="..sSpellLink);
					EAFun_AddSpellToScrollFrame(i, "");
				end
			end
		end
	end
	EA_Version_Frame:Show();
	DEFAULT_CHAT_FRAME:AddMessage(EA_XLOOKUP_RESULT1..": \124cffFFFF00"..tostring(iCount).."\124r"..EA_XLOOKUP_RESULT2);
end


function EAFun_AddSpellToScrollFrame(SpellID, OtherMessage)
	SpellID = tonumber(SpellID);
	if OtherMessage == nil then OtherMessage = "" end;
	if EA_ShowScrollSpells[SpellID] == nil then
		EA_ShowScrollSpells[SpellID] = true;
		local EA_name, EA_rank, EA_icon = GetSpellInfo(SpellID);
		if EA_name == nil then EA_name = "" end;
		if EA_rank == nil then EA_rank = "" end;

		local f1 = _G["EA_Version_ScrollFrame_Icon_"..SpellID];
		if f1 == nil then
			EA_ShowScrollSpell_YPos = EA_ShowScrollSpell_YPos - 25;
			local ShowScrollIcon = CreateFrame("Frame", "EA_Version_ScrollFrame_Icon_"..SpellID, EA_Version_ScrollFrame_List);
			ShowScrollIcon:SetWidth(25);
			ShowScrollIcon:SetHeight(25);
			ShowScrollIcon:SetPoint("TOPLEFT", 0, EA_ShowScrollSpell_YPos);
			ShowScrollIcon:SetBackdrop({bgFile = EA_icon});
		else
			if (not f1:IsShown()) then
				EA_ShowScrollSpell_YPos = EA_ShowScrollSpell_YPos - 25;
				f1:SetPoint("TOPLEFT", 0, EA_ShowScrollSpell_YPos);
				f1:Show();
			end
		end

		local framewidth = EA_Version_Frame:GetWidth()+50;
		local f2 = _G["EA_Version_ScrollFrame_EditBox_"..SpellID];
		if f2 == nil then
			local ShowScrollEditBox = CreateFrame("EditBox", "EA_Version_ScrollFrame_EditBox_"..SpellID, EA_Version_ScrollFrame_List);
			ShowScrollEditBox:SetPoint("TOPLEFT", 30, EA_ShowScrollSpell_YPos);
			ShowScrollEditBox:SetFontObject(ChatFontNormal);
			ShowScrollEditBox:SetWidth(framewidth);
			ShowScrollEditBox:SetHeight(25);
			ShowScrollEditBox:SetMaxLetters(0);
			ShowScrollEditBox:SetAutoFocus(false);
			if (EA_rank == "") then
				-- ShowScrollEditBox:SetText(EA_name.." ["..SpellID.."]1".." ["..SpellID.."]2".." ["..SpellID.."]3".." ["..SpellID.."]4".." ["..SpellID.."]5".." ["..SpellID.."]6".." ["..SpellID.."]7".." ["..SpellID.."]8".." ["..SpellID.."]9"..OtherMessage);
				ShowScrollEditBox:SetText(EA_name.." ["..SpellID.."]"..OtherMessage);
			else
				ShowScrollEditBox:SetText(EA_name.."("..EA_rank..") ["..SpellID.."]"..OtherMessage);
			end
			local function ShowScrollEditBoxGameToolTip()
				ShowScrollEditBox:SetTextColor(0, 1, 1);
				GameTooltip:SetOwner(ShowScrollEditBox, "ANCHOR_TOPLEFT");
				GameTooltip:SetSpellByID(SpellID);
			end
			local function HideScrollEditBoxGameToolTip()
				ShowScrollEditBox:SetTextColor(1, 1, 1);
				ShowScrollEditBox:HighlightText(0,0);
				ShowScrollEditBox:ClearFocus();
				GameTooltip:Hide();
			end
			ShowScrollEditBox:SetScript("OnEnter", ShowScrollEditBoxGameToolTip);
			ShowScrollEditBox:SetScript("OnLeave", HideScrollEditBoxGameToolTip);
		else
			if (not f2:IsShown()) then
				f2:SetPoint("TOPLEFT", 30, EA_ShowScrollSpell_YPos);
				f2:Show();
			end
		end
	end
end


function EAFun_ClearSpellScrollFrame()
	EA_Version_Frame_HeaderText:SetText(EA_XCMD_DEBUG_P0);
	-- EA_Version_ScrollFrame_EditBox:SetText("");
	EA_Version_ScrollFrame_EditBox:Hide();
	table.foreach(EA_ShowScrollSpells,
	function(i, v)
		-- MyPrint ("Clear:["..i.."]");
		local f1 = _G["EA_Version_ScrollFrame_Icon_"..i];
		if f1 ~= nil then
			f1:Hide();
			f1 = nil;
		end
		local f2 = _G["EA_Version_ScrollFrame_EditBox_"..i];
		if f2 ~= nil then
			f2:Hide();
			f2 = nil;
		end
	end)
	EA_ShowScrollSpells = { };
	EA_ShowScrollSpell_YPos = 25;
end


function EAFun_GetCountOfTable(EAItems)
	local iCount = 0;
	if (EAItems ~= nil) then
		for i, v in pairsByKeys(EAItems) do
			iCount = iCount + 1;
		end
	end
	return iCount;
end

function EAFun_GetUnitIDByName(EA_UnitName)
	local fNotFound, iIndex = true, 1;
	local sUnitID, sUnitName = "", "";

	if UnitInRaid("player") then
		iIndex = 1;
		while (fNotFound and iIndex <= 40) do
			sUnitID = "raid"..iIndex;
			sUnitName = UnitName(sUnitID);
			if EA_UnitName == sUnitName then fNotFound = false end;
			iIndex = iIndex + 1;
		end
	-- 5.1�ק�G�NGetNumPartyMembers()����GetNumSubgroupMembers()
	elseif GetNumSubgroupMembers() > 0 then
		iIndex = 1;
		while (fNotFound and iIndex <= 4) do
			sUnitID = "party"..iIndex;
			sUnitName = UnitName(sUnitID);
			if EA_UnitName == sUnitName then fNotFound = false end;
			iIndex = iIndex + 1;
		end
	end

	if (fNotFound) then
		local UnitType={"mouseover","target","focus"}
		for i=1,#UnitType do
			if UnitName(UnitType[i])==EA_UnitName then
				return UnitType[i];
			end	
		end
		return "";
	else
		return sUnitID;
	end
	
end

function EAFun_HookTooltips()
	hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
		local id = select(11,UnitBuff(...))
		if id then
			self:AddDoubleLine(EX_XCLSALERT_SPELL,id)
			self:Show()
		end
	end)

	hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
		local id = select(11,UnitDebuff(...))
		if id then
			self:AddDoubleLine(EX_XCLSALERT_SPELL,id)
			self:Show()
		end
	end)

	hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
		local id = select(11,UnitAura(...))
		if id then
			self:AddDoubleLine(EX_XCLSALERT_SPELL,id)
			self:Show()
		end
	end)

	hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
		if string.find(link,"^spell:") then
			local id = string.sub(link,7)
			ItemRefTooltip:AddDoubleLine(EX_XCLSALERT_SPELL,id)
			ItemRefTooltip:Show()
		end
	end)

	GameTooltip:HookScript("OnTooltipSetSpell", function(self)
		local id = select(3,self:GetSpell())
		if id then
			self:AddDoubleLine(EX_XCLSALERT_SPELL,id)
			self:Show()
		end
	end)
end

-- For OrderWtd, to sort the order of the buffs/debuffs.
function EAFun_SortCurrBuffs(TypeIndex, EACurrBuffs)
	local TempArray = {};
	local SortArray = {};
	local OrderWtd = 1;
	for Loopi=1, #EACurrBuffs do
		if (TypeIndex == 1) then 
			OrderWtd = EA_SPELLINFO_SELF[EACurrBuffs[Loopi]].orderWtd;
		elseif (TypeIndex == 2) then
			OrderWtd = EA_SPELLINFO_TARGET[EACurrBuffs[Loopi]].orderWtd;
		end
		if (OrderWtd == nil) then OrderWtd = 1 end;
		
		if TempArray[OrderWtd] == nil then TempArray[OrderWtd] = {} end;
		table.insert(TempArray[OrderWtd], EACurrBuffs[Loopi]);
	end
	
	for Loopi=20,1,-1 do
		if TempArray[Loopi] ~= nil then
			for Loopj=1,#TempArray[Loopi] do
				if TempArray[Loopi][Loopj] ~= nil then
					table.insert(SortArray, TempArray[Loopi][Loopj]);
				end
			end
		end
	end
	
	return SortArray;
end


-- GroupEvent: FireEventCheckHide, Check if to hide this GroupEvent
function EAFun_FireEventCheckHide(self)
	if self.GC.GroupResult then
		self:SetWidth(0);
		self:SetHeight(0);
		self.GC.GroupIconID = 0;
		self.GC.GroupResult = false;
		self.spellName:SetText("");
		self:Hide();
	end
end

-- GroupEvent: FireEventSubCheckResult. The Subcheck changes, so check back to upper level to conclude the final result.
function EAFun_FireEventSubCheckResult(self, iSpells, iChecks)
	local fGroupResult, fSpellResult, fCheckResult = false, true, true;
	local sGroupSpellName, iGroupIconID, sGroupIconPath = "", 0, "";
	local SfontName, SfontSize = "", 0;
	
	-- SubCheck
	for iIndex,aValue in ipairs(self.GC.Spells[iSpells].Checks[iChecks].SubChecks) do
		if aValue.SubCheckAndOp then
			-- first subcheck must be "AND" operation
			fCheckResult = fCheckResult and aValue.SubCheckResult;
		else
			fCheckResult = fCheckResult or aValue.SubCheckResult;
		end
	end
	self.GC.Spells[iSpells].Checks[iChecks].CheckResult = fCheckResult;

	-- Check
	for iIndex,aValue in ipairs(self.GC.Spells[iSpells].Checks) do
		if aValue.CheckAndOp then
			-- first check must be "AND" operation, too.
			fSpellResult = fSpellResult and aValue.CheckResult;
		else
			fSpellResult = fSpellResult or aValue.CheckResult;
		end
	end
	self.GC.Spells[iSpells].SpellResult = fSpellResult;

	-- Spell
	for iIndex,aValue in ipairs(self.GC.Spells) do
		if aValue.SpellResult then
			fGroupResult = true;
			sGroupSpellName = aValue.SpellName;
			iGroupIconID = aValue.SpellIconID;
			sGroupIconPath = aValue.SpellIconPath;
			break;
		end
	end
	
	-- Group
	if (fGroupResult) then
		if ((not self.GC.GroupResult) or (self.GC.GroupResult and (self.GC.GroupIconID ~= iGroupIconID)))then
			self.GC.GroupIconID = iGroupIconID;
			self:SetBackdrop({bgFile = sGroupIconPath});
			if (self.GC.IconAlpha ~= nil) then self:SetAlpha(self.GC.IconAlpha) end;
			self:SetPoint(self.GC.IconPoint, UIParent, self.GC.IconRelatePoint, self.GC.LocX, self.GC.LocY);	-- 0, -100
			self:SetWidth(self.GC.IconSize);
			self:SetHeight(self.GC.IconSize);
			self.GC.GroupResult = true;
			if (EA_Config.ShowName == true) then
				self.spellName:SetText(sGroupSpellName);
				SfontName, SfontSize = self.spellName:GetFont();
				self.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
			else
				self.spellName:SetText("");
			end
			self:Show();
		end
	else
		EAFun_FireEventCheckHide(self);
	end
end

-- GroupEvent: GroupFrameUnitDie. If target/focus Unit is died, then notice all UNIT_HEALTH event with this target/focus Unit.
function EventAlert_GroupFrameUnitDie_OnEvent(self, event, ...)
	local iSpells, iChecks, iSubChecks = 0, 0, 0;
	local iGroupIndex = self.GC.GroupIndex;
	local SubCheck = {};
	-- if (event == "UNIT_HEALTH") then
	local sUnitType = ...;
	-- SPEC EVENT FIRED, To check all INDEXD-EVENTCFG about this frame(by GroupIndex).
	if (GC_IndexOfGroupFrame[event] ~= nil) then
		if (GC_IndexOfGroupFrame[event][iGroupIndex] ~= nil) then
			for iIndex, aValue in ipairs(GC_IndexOfGroupFrame[event][iGroupIndex]) do
				iSpells = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Spells;
				iChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Checks;
				iSubChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].SubChecks;
				SubCheck = self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks];
				if (sUnitType == SubCheck.UnitType) then -- "player"
					self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks].SubCheckResult = false;
					EAFun_FireEventSubCheckResult(self, iSpells, iChecks);
				end
			end
		end
	end
	-- end
end

-- GroupEvent: CurrValueCompCfgValue. The 5 ways of comparison.
function EAFun_CurrValueCompCfgValue(CompType, CurrValue, CfgValue)
	local fResult = falase;
	if (CompType == 1) then		-- Curr < Cfg
		if (CurrValue < CfgValue) then fResult = true end;
	elseif (CompType == 2) then	-- Curr <= Cfg
		if (CurrValue <= CfgValue) then fResult = true end;
	elseif (CompType == 3) then	-- Curr = Cfg
		if (CurrValue == CfgValue) then fResult = true end;
	elseif (CompType == 4) then	-- Curr >= Cfg
		if (CurrValue >= CfgValue) then fResult = true end;
	elseif (CompType == 5) then	-- Curr > Cfg
		if (CurrValue > CfgValue) then fResult = true end;
	end
	return fResult;
end

-- GroupEvent: GroupFrameCheck. The core checking routine for GroupEvent Conditions.
function EventAlert_GroupFrameCheck_OnEvent(self, event, ...)
	local iSpells, iChecks, iSubChecks = 0, 0, 0;
	local iGroupIndex = self.GC.GroupIndex;
	local SubCheck = {};
	local iActiveTalentGroup = 0;
	local fAllUnitMonitor = false;
	local fShowResult = true;

	-- If this GroupCheck is Enabled / Disabled
	if (self.GC.enable ~= nil) then
		if (not self.GC.enable) then
			fShowResult = false;
		end
	end
	-- If the Active-Talent should be checked
	if (fShowResult) then
		if (self.GC.ActiveTalentGroup ~= nil) then
			--5.1�ץ�:GetActiveTalentGroup() -> GetActiveSpecGroup()
			iActiveTalentGroup = GetActiveSpecGroup();
			if (iActiveTalentGroup ~= self.GC.ActiveTalentGroup) then
				fShowResult = false;
			end
		end
	end
	-- If the Hide-On-Leave-of-Combat should be checked
	if (fShowResult) then
		if (self.GC.HideOnLeaveCombat ~= nil) then
			if (self.GC.HideOnLeaveCombat) then
				if (not UnitAffectingCombat("player")) then
					fShowResult = false;
				end
			end
		end
	end
	-- If the Hide-On-Lost-Target should be checked
	if (fShowResult) then
		if (self.GC.HideOnLostTarget ~= nil) then
			if (self.GC.HideOnLostTarget) then
				if (not UnitExists("target")) then
					fShowResult = false;
				end
			end
		end
	end
	local sTempUnitType = "target";
	if ((not UnitExists(sTempUnitType)) or UnitIsCorpse(sTempUnitType) or UnitIsDeadOrGhost(sTempUnitType)) then
		EventAlert_GroupFrameUnitDie_OnEvent(self, "UNIT_HEALTH", sTempUnitType);
	end
	sTempUnitType = "focus";
	if ((not UnitExists(sTempUnitType)) or UnitIsCorpse(sTempUnitType) or UnitIsDeadOrGhost(sTempUnitType)) then
		EventAlert_GroupFrameUnitDie_OnEvent(self, "UNIT_HEALTH", sTempUnitType);
	end

	if (not fShowResult) then
		EAFun_FireEventCheckHide(self);
	else
		--5.1�ץ�"ACTIVE_TALENT_GROUP_CHANGED" -> "ACTIVE_SPEC_GROUP_CHANGED"
		--5.3�����W�z�ץ�
		if (event == "ACTIVE_TALENT_GROUP_CHANGED") then
			-- If the Active-Talent should be checked
			--5.1�ץ�:GetActiveTalentGroup() -> GetActiveSpecGroup()
			iActiveTalentGroup = GetActiveSpecGroup();
			if (iActiveTalentGroup ~= self.GC.ActiveTalentGroup) then
				fShowResult = false;
				EAFun_FireEventCheckHide(self);
			end
		elseif (event == "PLAYER_REGEN_ENABLED") then
			-- If the Hide-On-Leave-of-Combat should be checked
			if (self.GC.HideOnLeaveCombat ~= nil) then
				if (self.GC.HideOnLeaveCombat) then
					if (UnitAffectingCombat("player")) then
						fShowResult = false;
						EAFun_FireEventCheckHide(self);
					end
				end
			end
		elseif (event == "PLAYER_TARGET_CHANGED") then
			-- If the Hide-On-Lost-Target should be checked
			if (self.GC.HideOnLostTarget ~= nil) then
				if (self.GC.HideOnLostTarget) then
					if (not UnitExists("target")) then
						fShowResult = false;
						EAFun_FireEventCheckHide(self);
					end
				end
			end
		elseif (event == "UNIT_POWER") then
			local sUnitType, sPowerType = ...;

			-- SPEC EVENT FIRED, To check all INDEXD-EVENTCFG about this frame(by GroupIndex).
			-- GC_IndexOfGroupFrame["UNIT_POWER"] = {[1]={Spells=1,Checks=1,SubChecks=1,},};
			for iIndex, aValue in ipairs(GC_IndexOfGroupFrame[event][iGroupIndex]) do
				iSpells = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Spells;
				iChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Checks;
				iSubChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].SubChecks;
				SubCheck = self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks];
				if (sUnitType == SubCheck.UnitType or SubCheck.UnitType == "all") then -- "player"
					if (sPowerType == SubCheck.PowerType) then
						fShowResult = true;
						if (fShowResult) then
							if (SubCheck.CheckCD ~= nil) then
								local iStart, iDuration, iEnable = GetSpellCooldown(SubCheck.CheckCD);
								if (iStart <= 0) or (iStart >= 0 and iDuration <= 1.5) then 
									fShowResult = true;
								else
									fShowResult = false;
								end
							end
						end
						if (fShowResult) then
							local iCurrPowerValue, iCheckPowerValue = 0;
							if SubCheck.PowerLessThanValue ~= nil then
								iCurrPowerValue = UnitPower(sUnitType, SubCheck.PowerTypeNum);
								iCheckPowerValue = SubCheck.PowerLessThanValue;
							elseif SubCheck.PowerLessThanPercent ~= nil then
								iCurrPowerValue = (UnitPower(sUnitType, SubCheck.PowerTypeNum) * 100) / UnitPowerMax(sUnitType, SubCheck.PowerTypeNum);
								iCheckPowerValue = SubCheck.PowerLessThanPercent;
							end
							fShowResult = EAFun_CurrValueCompCfgValue(SubCheck.PowerCompType, iCurrPowerValue, iCheckPowerValue);
						end
						self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks].SubCheckResult = fShowResult;
						EAFun_FireEventSubCheckResult(self, iSpells, iChecks);
					end
				end
			end
	
		elseif (event == "UNIT_HEALTH") then
			local sUnitType = ...;

			-- SPEC EVENT FIRED, To check all INDEXD-EVENTCFG about this frame(by GroupIndex).
			for iIndex, aValue in ipairs(GC_IndexOfGroupFrame[event][iGroupIndex]) do
				iSpells = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Spells;
				iChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Checks;
				iSubChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].SubChecks;
				SubCheck = self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks];
				if (sUnitType == SubCheck.UnitType or SubCheck.UnitType == "all") then -- "player"
					fShowResult = true;
					if (fShowResult) then
						if (SubCheck.CheckCD ~= nil) then
							local iStart, iDuration, iEnable = GetSpellCooldown(SubCheck.CheckCD);
							if (iStart <= 0) or (iStart >= 0 and iDuration <= 1.5) then 
								fShowResult = true;
							else
								fShowResult = false;
							end
						end
					end
					if (fShowResult) then
						local iCurrHealthValue, iCheckHealthValue = 0;
						if SubCheck.HealthLessThanValue ~= nil then
							iCurrHealthValue = UnitHealth(sUnitType);
							iCheckHealthValue = SubCheck.HealthLessThanValue;
						elseif SubCheck.HealthLessThanPercent ~= nil then
							iCurrHealthValue = (UnitHealth(sUnitType) * 100) / UnitHealthMax(sUnitType);
							iCheckHealthValue = SubCheck.HealthLessThanPercent;
						end
						fShowResult = EAFun_CurrValueCompCfgValue(SubCheck.HealthCompType, iCurrHealthValue, iCheckHealthValue);
					end
					self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks].SubCheckResult = fShowResult;
					EAFun_FireEventSubCheckResult(self, iSpells, iChecks);
				end
			end
	
		elseif (event == "UNIT_AURA") then
			local sUnitType = ...;
			local sAuraFilter = "";

			-- SPEC EVENT FIRED, To check all INDEXD-EVENTCFG about this frame(by GroupIndex).
			for iIndex, aValue in ipairs(GC_IndexOfGroupFrame[event][iGroupIndex]) do
				iSpells = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Spells;
				iChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Checks;
				iSubChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].SubChecks;
				SubCheck = self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks];
				if (sUnitType == SubCheck.UnitType or SubCheck.UnitType == "all") then -- "player"
					fShowResult = true;
					if (fShowResult) then
						if (SubCheck.CheckCD ~= nil) then
							local iStart, iDuration, iEnable = GetSpellCooldown(SubCheck.CheckCD);
							if (iStart <= 0) or (iStart >= 0 and iDuration <= 1.5) then 
								fShowResult = true;
							else
								fShowResult = false;
							end
						end
					end
					if (fShowResult) then
						sAuraFilter = "";
						if (SubCheck.CastByPlayer ~= nil) then
							if (SubCheck.CastByPlayer) then
								sAuraFilter = "PLAYER";
							end
						end
						if (SubCheck.CheckAuraExist ~= nil) then
							fShowResult = false;
							local sSpellName, sSpellRank = GetSpellInfo(SubCheck.CheckAuraExist);
							local sCurrSpellName, _, _, iStack, _, _, iExpireTime = UnitBuff(sUnitType, sSpellName, sSpellRank, sAuraFilter);
							if sCurrSpellName ~= nil then
								fShowResult = true;
							else
								sCurrSpellName, _, _, iStack, _, _, iExpireTime = UnitDebuff(sUnitType, sSpellName, sSpellRank, sAuraFilter);
								if sCurrSpellName ~= nil then 
									fShowResult = true;
								end
							end
							-- ToDo: If Exists, Then Check seconds, stacks
							if (fShowResult) then
								if (SubCheck.StackCompType ~= nil) then
									fShowResult = EAFun_CurrValueCompCfgValue(SubCheck.StackCompType, iStack, SubCheck.StackLessThanValue);
								end
							end
							if (fShowResult) then
								if (SubCheck.TimeCompType ~= nil) then
									local iLeftTime = iExpireTime - GetTime();
									fShowResult = EAFun_CurrValueCompCfgValue(SubCheck.TimeCompType, iLeftTime, SubCheck.TimeLessThanValue);
								end
							end
						end
						if (SubCheck.CheckAuraNotExist ~= nil) then
							fShowResult = false;
							local sSpellName, sSpellRank = GetSpellInfo(SubCheck.CheckAuraNotExist);
							local sCurrSpellName = UnitBuff(sUnitType, sSpellName, sSpellRank, sAuraFilter);
							if sCurrSpellName == nil then 
								sCurrSpellName = UnitDebuff(sUnitType, sSpellName, sSpellRank, sAuraFilter);
								if sCurrSpellName == nil then 
									fShowResult = true;
								end
							end
						end
					end
					self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks].SubCheckResult = fShowResult;
					EAFun_FireEventSubCheckResult(self, iSpells, iChecks);
				end
			end
		elseif (event == "UNIT_COMBO_POINTS") then
			local sUnitType, iComboPoints = "target", 0;

			-- SPEC EVENT FIRED, To check all INDEXD-EVENTCFG about this frame(by GroupIndex).
			for iIndex, aValue in ipairs(GC_IndexOfGroupFrame[event][iGroupIndex]) do
				iSpells = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Spells;
				iChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Checks;
				iSubChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].SubChecks;
				SubCheck = self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks];
				if (sUnitType == SubCheck.UnitType or SubCheck.UnitType == "all") then -- "player"
					iComboPoints = GetComboPoints("player", sUnitType);
					fShowResult = true;
					if (fShowResult) then
						if (SubCheck.CheckCD ~= nil) then
							local iStart, iDuration, iEnable = GetSpellCooldown(SubCheck.CheckCD);
							if (iStart <= 0) or (iStart >= 0 and iDuration <= 1.5) then 
								fShowResult = true;
							else
								fShowResult = false;
							end
						end
					end
					if (fShowResult) then
						fShowResult = EAFun_CurrValueCompCfgValue(SubCheck.ComboCompType, iComboPoints, SubCheck.ComboLessThanValue);
					end
					self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks].SubCheckResult = fShowResult;
					EAFun_FireEventSubCheckResult(self, iSpells, iChecks);
				end
			end
		end
	end
end

-- �ˬd�ثe�ҥΪ�¾�~�ѽ�A�ó]�w�ثe�֦����S���O�]���B�����ȡB��q�B�Ť��q ...�^
--[[
	Death Knight ���`�M�h
	250 - Blood ��z
	251 - Frost �B��
	252 - Unholy ©��
	Druid �w�|��
	102 - Balance ���� (��D)
	103 - Feral Combat ���ʾ԰� (��D)
	104 - Guardian �u�@ (��D)
	105 - Restoration (��D)
	Hunter �y�H
	253 - Beast Mastery �~��
	254 - Marksmanship �g��
	255 - Survival �ͦs
	Mage �k�v
	62 - Arcane ���k
	63 - Fire ���k
	64 - Frost �B�k
	Monk �Z��
	268 - BrewMaster �C�s (�Z)
	269 - WindWalker �s�� (DD)
	270 - MistWeaver ´�� (��)
	Paladin �t�M�h
	65 - Holy ���t (��)
	66 - Protection ���@ (�Z)
	70 - Retribution �g�� (DD)
	Priest ���v
	256 Discipline �٫� (��)
	257 Holy ���t (��)
	258 Shadow �t�v (DD)
	Rogue �s��
	259 - Assassination ���
	260 - Combat �԰�
	261 - Subtlety �ӾU
	Shaman �ĺ�
	262 - Elemental ���� (���{DD)
	263 - Enhancement �W�j (���DD)
	264 - Restoration ��_ (��)
	Warlock �N�h
	265 - Affliction �h�W
	266 - Demonology �c�]����
	267 - Destruction ����
	Warrior 
	71 - Arms �Z�� (DD)
	72 - Furry �g�� (DD)
	73 - Protection ���@ (�Z)
--]]
function EventAlert_PlayerSpecPower_Update()
	-- /dump GetSpecializationInfo(GetActiveSpecGroup());
	-- /dump GetSpecializationInfoForClassID(classID, specNum);

	-- ��l�ƥ�����false
	EA_SpecHasPower.HasRage				= false;
	EA_SpecHasPower.HasFocus 			= false;
	EA_SpecHasPower.HasEnergy			= false;
	EA_SpecHasPower.HasRunicPower		= false;
	EA_SpecHasPower.HasSoulShards		= false;
	EA_SpecHasPower.HasEclipse			= false;
	EA_SpecHasPower.HasHolyPower		= false;
	EA_SpecHasPower.HasLightForce		= false;
	EA_SpecHasPower.HasShadowOrbs		= false;
	EA_SpecHasPower.HasComboPoint		= false;
	EA_SpecHasPower.HasLifeBloom		= false;
	EA_SpecHasPower.HasBurningEmbers	= false;
	EA_SpecHasPower.HasDemonicFury		= false;
	

	-- �����ثe�ҥΪ��ѽ�ӳ]�w�i�H�ʱ����S���O
	--local id,_,_,icon,_,_ = GetSpecializationInfo(GetActiveSpecGroup());
		
	local id = 0;
	local icon = "NONE";
	local powerType = 0;
	local powerTypeString = "NONE";
	local pClass = "NONE";
	
	-- �P�_�ثe�O�_��¾�~�M��
	local HasSpecCode = true;	
	local CurrentSpecCode = GetSpecialization();
	if (CurrentSpecCode == nil) then
		HasSpecCode = false;
	end
	
	-- �p�G�ثe���S�M��N��P�_¾�~�W��(�^��)
	if (HasSpecCode) then
		id,_,_,icon,_,_ = GetSpecializationInfo(CurrentSpecCode);
	end
	powerType, powerTypeString = UnitPowerType("player");
	_,pClass = UnitClass("player");					
	
	-- �w�|��M�Z���n�t�~�P�_�ثe���������ܨ����A�A��i�J�C���ɰ����|�����D�A����������~�|���T������
	local shapeindex = GetShapeshiftForm();
	local shapeID = GetShapeshiftFormID();
	--[[
	DEFAULT_CHAT_FRAME:AddMessage("Current shape = "..shapeindex);
	if ((shapeindex > 0) and (shapeindex <= GetNumShapeshiftForms())) then
		local shapeicon, shapename, shapeactive = GetShapeshiftFormInfo(shapeindex);
		if (shapeactive ~= nil) then
			DEFAULT_CHAT_FRAME:AddMessage("icon("..shapeicon.."), name("..shapename.."), active(YES)");
		else
			DEFAULT_CHAT_FRAME:AddMessage("icon("..shapeicon.."), name("..shapename.."), active(NO)");
		end	
	end
	--]]

	-- ���: �Ԥh/�w�|�캵���A
	if (pClass == EA_CLASS_WARRIOR) then
		EA_SpecHasPower.HasRage = true;
	elseif (pClass == EA_CLASS_DRUID) then
		--if (shapeindex == 1)	then 	-- ��D(1)
		if (shapeID == 5)	then 	-- ��D(5), ��D(1)
			EA_SpecHasPower.HasRage = true;			
		end
	end
	
	-- ������: �y�H
	if (pClass == EA_CLASS_HUNTER) then
		EA_SpecHasPower.HasFocus = true;
	end

	-- ��q: �s��/�C�s�Z��/�s���Z��/�u�@�̼w�|��/���ʼw�|��
	if (pClass == EA_CLASS_ROGUE) then
		EA_SpecHasPower.HasEnergy = true;
	elseif (pClass == EA_CLASS_DRUID) then
		if ((shapeID == 5) or (shapeID == 1)) then 	-- ��D(5), ��D(1)
			EA_SpecHasPower.HasEnergy = true;
		end
	elseif (pClass == EA_CLASS_MONK) then
		--�p�G���O´���Z���N����q
		if (id ~= 270) then			

			EA_SpecHasPower.HasEnergy = true;
		end
	end
	
	-- �Ť��q: ���`�M�h
	if (pClass == EA_CLASS_DK) then
		EA_SpecHasPower.HasRunicPower = true;
	end

	-- �N�h�S��k��PowerType�P�_�A�u��H�ѽ�ӧP�_
	-- �F��H��: �h�W�N�h
	if (id == 265) then
		EA_SpecHasPower.HasSoulShards = true;
	-- �c�]����: �c�]�N�h
	elseif (id == 266) then
		EA_SpecHasPower.HasDemonicFury = true;
	-- �U���l�u: �����N�h
	elseif (id == 267) then
		EA_SpecHasPower.HasBurningEmbers = true;
	end
	
	-- ���k��: ��D
	if (id == 102) then
		EA_SpecHasPower.HasEclipse = true;
	end	
	
	-- �t��: �t�M�h
	if (pClass == EA_CLASS_PALADIN) then
		EA_SpecHasPower.HasHolyPower = true;
	end
	
	-- �u��: �Z��
	if (pClass == EA_CLASS_MONK) then
		EA_SpecHasPower.HasLightForce = true;
	end
	
	-- �s����: �s��/��D
	if (pClass == EA_CLASS_ROGUE) then
		EA_SpecHasPower.HasComboPoint = true;
	elseif (pClass == EA_CLASS_DRUID) then
		--if (shapeID == 3) then 	-- ��D(1), ��D(3)
			EA_SpecHasPower.HasComboPoint = true;
		--end
	end
	
	-- �ͩR����: ��D
	if (id == 105) then
		EA_SpecHasPower.HasLifeBloom = true;
	end
	
	-- �t�v�_�]: �t��
	if (id == 258) then
		EA_SpecHasPower.HasShadowOrbs = true;
	end
	
	EventAlert_SpecialFrame_Update();
end

-- �ھڥثe���ѽ�ӫإߩ����ïS���O���ج[
function EventAlert_SpecialFrame_Update()
	-- ���
	if (EA_SpecCheckPower.CheckRage and EA_SpecHasPower.HasRage) then
		CreateFrames_SpecialFrames_Show(10010);
	else
		CreateFrames_SpecialFrames_Hide(10010);
	end

	-- ������
	if (EA_SpecCheckPower.CheckFocus and EA_SpecHasPower.HasFocus) then
		CreateFrames_SpecialFrames_Show(10020);
	else
		CreateFrames_SpecialFrames_Hide(10020);
	end
	
	-- ��q
	if (EA_SpecCheckPower.CheckEnergy and EA_SpecHasPower.HasEnergy) then
		CreateFrames_SpecialFrames_Show(10030);
	else
		CreateFrames_SpecialFrames_Hide(10030);
	end
	
	-- �Ť��q
	if (EA_SpecCheckPower.CheckRunicPower and EA_SpecHasPower.HasRunicPower) then
		CreateFrames_SpecialFrames_Show(10060);
	else
		CreateFrames_SpecialFrames_Hide(10060);
	end

	-- �F��H��
	if (EA_SpecCheckPower.CheckSoulShards and EA_SpecHasPower.HasSoulShards) then
		CreateFrames_SpecialFrames_Show(10070);
	else
		CreateFrames_SpecialFrames_Hide(10070);
	end
	
	-- ���k��
	if (EA_SpecCheckPower.CheckEclipse and EA_SpecHasPower.HasEclipse) then
		CreateFrames_SpecialFrames_Show(10081);
		CreateFrames_SpecialFrames_Show(10082);
	else
		CreateFrames_SpecialFrames_Hide(10081);
		CreateFrames_SpecialFrames_Hide(10082);
	end
	
	-- �t��
	if (EA_SpecCheckPower.CheckHolyPower and EA_SpecHasPower.HasHolyPower) then
		CreateFrames_SpecialFrames_Show(10090);
	else
		CreateFrames_SpecialFrames_Hide(10090);
	end

	-- �u��
	if (EA_SpecCheckPower.CheckLightForce and EA_SpecHasPower.HasLightForce) then
		CreateFrames_SpecialFrames_Show(10120);
	else
		CreateFrames_SpecialFrames_Hide(10120);
	end
	
	-- �t�v�_�]
	if (EA_SpecCheckPower.CheckShadowOrbs and EA_SpecHasPower.HasShadowOrbs) then
		CreateFrames_SpecialFrames_Show(10130);
	else
		CreateFrames_SpecialFrames_Hide(10130);
	end

	-- �U���l�u
	if (EA_SpecCheckPower.CheckBurningEmbers and EA_SpecHasPower.HasBurningEmbers) then
		CreateFrames_SpecialFrames_Show(10140);
	else
		CreateFrames_SpecialFrames_Hide(10140);
	end
	
	-- �c�]����
	if (EA_SpecCheckPower.CheckDemonicFury and EA_SpecHasPower.HasDemonicFury) then
		CreateFrames_SpecialFrames_Show(10150);
	else
		CreateFrames_SpecialFrames_Hide(10150);
	end
	
	-- �s����
	if (EA_SpecCheckPower.CheckComboPoint and EA_SpecHasPower.HasComboPoint) then
		CreateFrames_SpecialFrames_Show(10000);
	else
		CreateFrames_SpecialFrames_Hide(10000);
	end
		
	-- �ͩR����
	if (EA_SpecCheckPower.CheckLifeBloom and EA_SpecHasPower.HasLifeBloom) then
		CreateFrames_SpecialFrames_Show(33763);  -- Durid LifeBloom
	else
		CreateFrames_SpecialFrames_Hide(33763);
	end

	EventAlert_PositionFrames();	
end
function RemoveAllScdCurrentBuff()

	for k,v in ipairs(EA_ScdCurrentBuffs) do
		local SpellName,SpellIcon=GetSpellInfo(v)
		local HasSpell=GetSpellInfo(SpellName)
		if HasSpell==nil then

			local eaf = _G["EAScdFrame_"..v];
			local spellId = tonumber(v);
			eaf:Hide();
			removeBuffValue(EA_ScdCurrentBuffs,v);
			eaf:SetScript("OnUpdate", nil);
			removeBuffValue(EA_ScdCurrentBuffs, spellId);			
		end
					
	end
	
	EventAlert_ScdPositionFrames();
end
function FrameShowOrHide(f,boolShow)
	if boolShow then
		f:Show()
	else
		f:Hide()
	end 
end 
function FrameGlowShowOrHide(f,boolShow)
	if boolShow then
		EA_ActionButton_ShowOverlayGlow(f)
	else
		EA_ActionButton_HideOverlayGlow(f)
	end 
end 
