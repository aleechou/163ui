local PlayerName = UnitName("player");
local _, playerClass = UnitClass("player");
local alreadyOT = "?";
local anotherTank = nil;
local lastTarget = nil;
local SHOW_INFO = 0;
local manualShowHideMoving = nil;

TOTxpAggroMode = {};
TOTxpIgnoreWarriorOT = 1;
TOTxp_SHOW_TOTOT = 0;

function TOTxpFrame_OnLoad(self)
	self.attackModeCounter = 0;
	self.attackModeSign = -1;
	CombatFeedback_Initialize(self, TOTxpHitIndicator, 16);
	self:RegisterEvent("UNIT_COMBAT");
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	self:RegisterEvent("VARIABLES_LOADED");

    TargetFrameToT:SetMovable(true)
    TargetFrameToT:RegisterForDrag("LeftButton")
    TargetFrameToT:SetScript("OnDragStart", function(self) if IsShiftKeyDown() then self:StartMoving() end end)
    TargetFrameToT:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() self:SetUserPlaced(false) end) --用Cfg来调整位置
    TargetFrameToTHealthBar:EnableMouse(false)
    TargetFrameToTManaBar:EnableMouse(false)
    TargetFrameToT:SetScript("OnEnter", function(self) UnitFrame_OnEnter(self) if GameTooltip:IsVisible() then GameTooltip:AddLine(" ") GameTooltip:AddLine("|cff00d100SHIFT左键拖动可以调整位置|r") GameTooltip:Show() end end)
    TargetFrameToT:SetScript("OnLeave", UnitFrame_OnLeave)

	--hooksecurefunc("TargetofTarget_Update", TOTxp_TargetofTarget_Update);
end

function TOTxp_Command(cmd)
	if (cmd) then
		cmd = string.lower(cmd);
        if cmd == "1" then
            cmd = "m" TOTxpAggroMode[PlayerName] = 0;
        elseif cmd == "2" then
            cmd = "m" TOTxpAggroMode[PlayerName] = 1;
        elseif cmd == "0" then
            cmd = "m" TOTxpAggroMode[PlayerName] = 2;
        end
        if (cmd == "mode" or cmd == "m") then
			if (TOTxpAggroMode[PlayerName] == 0) then       -- DPS Mode
				TOTxpAggroMode[PlayerName] = 1;
				DEFAULT_CHAT_FRAME:AddMessage("TOTxp 已切换至 Tanker 模式",1,0.5,0.5);    
			elseif (TOTxpAggroMode[PlayerName] == 1) then   -- Tank Mode
				TOTxpAggroMode[PlayerName] = 2;
				DEFAULT_CHAT_FRAME:AddMessage("TOTxp 已切换至 Healer 模式",0,1,0);    
			elseif (TOTxpAggroMode[PlayerName] == 2) then
				TOTxpAggroMode[PlayerName] = 0;
				DEFAULT_CHAT_FRAME:AddMessage("TOTxp 已切换至 DPSer 模式",0.5,0.5,1);
			end
		elseif(cmd == "info" or cmd == "i") then
			SHOW_INFO = 1 - SHOW_INFO;
			if(SHOW_INFO == 0) then
				DEFAULT_CHAT_FRAME:AddMessage("怪物目标切换提示已经关闭",1,0.5,0.5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("怪物目标切换提示已经开启",0,1,0);
			end
		elseif(cmd == "reset" or cmd == "r") then --重置目标位置
            if InCombatLockdown() then
                DEFAULT_CHAT_FRAME:AddMessage("战斗中无法执行此操作",1,0.5,0.5);
            else
                TargetFrameToT:ClearAllPoints()
                TargetFrameToT:SetPoint("BOTTOMRIGHT", TargetFrame, "BOTTOMRIGHT", -35, -10)
            end
		elseif(cmd == "rr") then --重置目标位置(人物左上)
            if InCombatLockdown() then
                DEFAULT_CHAT_FRAME:AddMessage("战斗中无法执行此操作",1,0.5,0.5);
            else
                TargetFrameToT:ClearAllPoints()
                TargetFrameToT:SetPoint("CENTER","UIParent","CENTER",-180,55);
            end
		elseif(cmd == "ttt" ) then
			TOTxp_SHOW_TOTOT = 1 - TOTxp_SHOW_TOTOT;
			if(TOTxp_SHOW_TOTOT == 0) then
				DEFAULT_CHAT_FRAME:AddMessage("目标的目标的目标显示已经关闭",1,0.5,0.5);
			else
				DEFAULT_CHAT_FRAME:AddMessage("目标的目标的目标显示已经开启",0,1,0);
            end
		else
			DEFAULT_CHAT_FRAME:AddMessage("可用 TOTxp 命令:",1,1,0);
			DEFAULT_CHAT_FRAME:AddMessage("/tot mode  - 切换 仇恨警告 模式: DPS ,Tank, Healer.",1,1,0);
			DEFAULT_CHAT_FRAME:AddMessage("/tot info  - 切换 目标自动报警功能.",1,1,0);
			DEFAULT_CHAT_FRAME:AddMessage("/tot ttt   - 切换 目标的目标的目标.",1,1,0);
			--DEFAULT_CHAT_FRAME:AddMessage("/tot lock  - 隐藏/显示拖动块.",1,1,0);
			DEFAULT_CHAT_FRAME:AddMessage("/tot reset - 重置 目标的目标显示位置.",1,1,0);
		end        
	end
end

function TOTxpFrame_OnEvent(self, event, ...)
	local arg1,arg2,arg3,arg4,arg5 = ...;

	if( event == "PLAYER_TARGET_CHANGED" ) then
		alreadyOT = "?";
	end

	if ( event == "UNIT_COMBAT" ) then
		if ( UnitIsUnit(arg1, "targettarget") ) then
			CombatFeedback_OnCombatEvent(self, arg2, arg3, arg4, arg5);
		end
		TOTxp_AnalyseAggro();

	elseif ( event == "PLAYER_TARGET_CHANGED" ) then
		TOTxp_AnalyseAggro();

	elseif ( event =="UNIT_AURA" ) then
		if ( UnitIsPlayer("targettarget") and UnitIsUnit(arg1, "targettarget") ) then
			TOTxpFrame_RefreshBuffs();
		end
	elseif ( event == "VARIABLES_LOADED" ) then
		if (TOTxpAggroMode == nil) then
			TOTxpAggroMode = {};
		end
		
		if (TOTxpAggroMode[PlayerName] == nil) then
			if( playerClass == "WARRIOR" ) then
				TOTxpAggroMode[PlayerName] = 1;
			else 
				TOTxpAggroMode[PlayerName] = 0;
			end
		end

        --[[
		if (TOTxpAggroMode[PlayerName] == 0) then
			DEFAULT_CHAT_FRAME:AddMessage("仇恨警告已设置为|cFFFF80FF伤害输出者(DPSer)|r模式. /tot mode 切换模式");
		elseif (TOTxpAggroMode[PlayerName] == 1) then
			DEFAULT_CHAT_FRAME:AddMessage("仇恨警告已设置为|cFFFF80FF坦克(Tanker)|r模式. /tot mode 切换模式");
		elseif (TOTxpAggroMode[PlayerName] == 2) then
			DEFAULT_CHAT_FRAME:AddMessage("仇恨警告已设置为|cFFFF80FF治疗者(Healer)|r模式. /tot mode 切换模式");
		end
		]]
					
		SLASH_TOTXP1 = "/totxp";
		SLASH_TOTXP2 = "/tot";
		SlashCmdList["TOTXP"] = TOTxp_Command;
	end

end

function TOTxp_AnalyseAggro()
	
	if ( not UnitExists("target") or not UnitExists("targettarget") ) then TOTxpFrameDangerTexture:Hide(); LowHealthFrame:Hide(); return; end

	if( UnitIsUnit("player", "targettarget") ) then
		TOTxpFrameDangerTexture:Show();
	else
		TOTxpFrameDangerTexture:Hide();
	end		

	if ( UnitPlayerControlled("target") ) then
		if (TOTxpAggroMode[PlayerName] == 2) then 
			if ( not UnitIsUnit("player","target") and UnitIsFriend("player","target") and UnitExists("targettargettarget") ) then
				--治疗的在瞄准自己的队友
				if ( not UnitPlayerControlled("targettarget") and UnitCanAttack("targettarget", "player") ) then
					if ( UnitIsUnit("targettargettarget", "player") ) then
						--队友抗的boss在看治疗
						if(UnitClassification("targettarget") == "worldboss") then
							TOTxp_VeryDangerInfo("OT!!! ("..UnitName("targettarget")..")");
						else 
							TOTxp_DangerInfo("OT! ("..UnitName("targettarget")..")");
							--ChatFrame1:AddMessage(UnitName("target").." ->"..UnitName("targettarget").." -> "..UnitName("targettargettarget"));
						end
					else
						TOTxp_SafeInfo("仇恨消退 ("..UnitName("targettargettarget")..")");
					end
				end
			end
		else 
			alreadyOT="?";
			LowHealthFrame:Hide();
		end
		return;
	end

	if (UnitCanAttack("target", "player")) then
		if( UnitName("targettarget") and ( lastTarget == nil or UnitName("targettarget")~=lastTarget) ) then
			if (SHOW_INFO == 1) then
				SendChatMessage("  ("..format("%.1f", UnitHealth("target")*100/UnitHealthMax("target")).."%)"..UnitName("target").." -> "..UnitName("targettarget").."", "RAID");
			end
			lastTarget = UnitName("targettarget");
			--TOTxpFrame_RefreshBuffs();
		end
	end

	if (TOTxpAggroMode[PlayerName] == 0 or TOTxpAggroMode[PlayerName] == 2) then  -- DPS Mode

		if ( UnitIsUnit("targettarget", "player") and UnitCanAttack("player", "target") ) then
			-- DPSer挨打,危险
			if(UnitClassification("target") == "worldboss") then
				TOTxp_VeryDangerInfo("OT!!! ("..UnitName("target")..")");
			else 
				TOTxp_DangerInfo("OT! ("..UnitName("target")..")");
			end
		else
			-- DPSer不挨打,安全
			TOTxp_SafeInfo("仇恨消退 ("..UnitName("targettarget")..")");
		end

	elseif (TOTxpAggroMode[PlayerName] == 1) then  -- Tank mode

		if ( UnitIsUnit("targettarget", "player") ) then
			-- 坦克挨打,安全
			TOTxp_SafeInfo("仇恨重建 ("..UnitName("target")..")");
			if( TOTxpIgnoreWarriorOT ) then
				anotherTank = nil;
			end
		else
			-- 坦克不挨打,危险
			if( TOTxpIgnoreWarriorOT ) then
				local _, cls = UnitClass("targettarget");
				if ( cls == "WARRIOR" ) then
					anotherTank = 1;
					if(alreadyOT~="?") then 
						TOTxpFrame_Info:AddMessage("仇恨->"..UnitName("targettarget"), 1, 1, 0);
					end
					alreadyOT = "?";
					LowHealthFrame:Hide();
				else
					anotherTank = nil;
					TOTxp_DangerInfo("OT!! ("..UnitName("targettarget")..")");
				end					
			else					
				TOTxp_DangerInfo("OT!! ("..UnitName("targettarget")..")");
			end
		end
	end
end

function TOTxp_DangerInfo(msg)
	if (alreadyOT == "no" or alreadyOT == "?") then
		TOTxpFrame_Info:AddMessage(msg, 1, 0.2, 0);
		--LowHealthFrame:Show();
		PlaySoundFile("Sound\\Doodad\\BellTollNightElf.wav");
	end
	alreadyOT = "yes";
end

function TOTxp_VeryDangerInfo(msg)
	if (alreadyOT == "no" or alreadyOT == "?") then
		TOTxpFrame_Info:AddMessage(msg, 1, 0.2, 0);
		LowHealthFrame:Show();
		PlaySound("igQuestFailed");
	end
	alreadyOT = "yes";
end

function TOTxp_SafeInfo(msg)
	if (alreadyOT == "yes" or anotherTank) then
		LowHealthFrame:Hide();
		TOTxpFrame_Info:AddMessage(msg, 0, 1, 0);
	end
	anotherTank = nil;
	alreadyOT = "no";
end

local updateTimer = 0;
function TOTxpFrame_OnUpdate(self, elapsed)
	updateTimer = updateTimer + elapsed;
	if(updateTimer < 0.1) then return end;
	TOTxp_TargetofTarget_Update();
	if ( TOTxpFrameDangerTexture:IsVisible() or LowHealthFrame:IsVisible()) then
		local alpha = 255;
		local counter = self.attackModeCounter + updateTimer;
		local sign    = self.attackModeSign;

		if ( counter > 0.5 ) then
			sign = -sign;
			self.attackModeSign = sign;
		end
		counter = mod(counter, 0.5);
		self.attackModeCounter = counter;

		if ( sign == 1 ) then
			alpha = (55  + (counter * 400)) / 255;
		else
			alpha = (255 - (counter * 400)) / 255;
		end
		if TOTxpFrameDangerTexture:IsVisible() then TOTxpFrameDangerTexture:SetVertexColor(1.0, 1.0, 1.0, alpha); end
		if LowHealthFrame:IsVisible() then LowHealthFrame:SetAlpha(alpha); end
	end
	CombatFeedback_OnUpdate(self, updateTimer);
	updateTimer = 0;
end

function TOTxp_TargetofTarget_Update()
	TOTxp_AnalyseAggro();

	if ( TargetFrameToT:IsShown() ) then
        --[[
		if(UnitIsPlayer("targettarget")) then
			local class, _ = UnitClass("targettarget");
			if( not class ) then 
				TargetofTargetClass:SetText("");
			else
				class = strsub(class,1,3);
				if(TargetofTargetClass:GetText() ~= class) then
					TargetofTargetClass:SetText(class);
				end
			end
		else
			TargetofTargetClass:SetText("");
        end
        TargetofTargetClass:Hide();
        --]]

        --[[
		local pp = UnitHealth("targettarget");
		if(pp and UnitHealthMax("targettarget") ==100) then
			pp = pp.."%";
		end

		if(pp) then TargetofTargetHealthPercent:SetText(pp); end;
		--]]

		local isTanking, status, threatpct, rawthreatpct, threatvalue;
		if(UnitCanAttack("player","target")) then
			isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "target");
		elseif(UnitCanAttack("player","targettarget")) then 
			isTanking, status, threatpct, rawthreatpct, threatvalue = UnitDetailedThreatSituation("player", "targettarget");
		end;

		if(threatpct) then 
			local colorCode = "|cFFAAAAAA";
			if(threatpct > 99.5) then
				colorCode = "|cFFFF0000";
			elseif(threatpct > 80) then
				colorCode = "|cFFFFFF00";
			end
			TOTxpThreatText:SetText(colorCode..math.floor(threatpct).."%|r");
		else
			TOTxpThreatText:SetText(" "); 
		end

		local ttt = UnitName("targettargettarget");
		if(TOTxp_SHOW_TOTOT==1 and ttt ) then --and not UnitPlayerControlled("targettarget")) then
			if(UnitIsUnit("player","targettargettarget") and UnitCanAttack("targettarget","player")) then
				TargetofTargetofTargetName:SetText("你!!");
				TargetofTargetofTargetName:SetTextColor(1,0,0);
			else
				TargetofTargetofTargetName:SetText(ttt);
				TargetofTargetofTargetName:SetTextColor(0,1,1);
			end
		else
			TargetofTargetofTargetName:SetText("");
		end
	end

end

function TOTxp_GetShowInfo()
    return SHOW_INFO;
end