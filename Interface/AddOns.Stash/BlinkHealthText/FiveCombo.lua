--------------------------------------------------------------------------------
-- FiveCombo.lua
-- 作者：盒子哥
-- 日期：2012-05-07
-- 描述：盗贼、德鲁伊的5星技能提示
-- 版权所有（c）多玩游戏网
--------------------------------------------------------------------------------

--[[
刺骨 2098
毒伤 32645
破甲 8647
切割 5171
肾击 408
致命投掷 26679
割裂 1943
恢复 73651

野蛮咆哮 52610
割裂 1079
割碎      22570
凶猛撕咬 22568
]]
local enaleAlert = true;
local OverlayedSpellID = {};
-- 盗贼
OverlayedSpellID["ROGUE"] = {
	2098,
	32645,
	8647,
	5171,
	408,
	26679,
	1943,
	73651,
};

-- 德鲁伊
OverlayedSpellID["DRUID"] = {
	52610,
	1079,
	22568,
	22570,
};


local function IsOverlayedSpell(spellID)
	local _, class = UnitClass("player");
	if (not OverlayedSpellID[class]) then return false end

	for i, id in ipairs(OverlayedSpellID[class]) do
		if (id == spellID) then
			return true;
		end
	end

	return false;
end

local function comboEventFrame_OnUpdate(self, elapsed)
	local countTime = self.countTime - elapsed;
	if (countTime <= 0) then
		local parent = self:GetParent();
		local points = GetComboPoints(PlayerFrame.unit, "target");
		if (self.isAlert and points ~= 5) then
			self:SetScript("OnUpdate", nil);
			ActionButton_HideOverlayGlow(parent);
			self.countTime = 0;
		end		

		self.countTime = TOOLTIP_UPDATE_TIME;
	end
end

local function comboEventFrame_OnEvent(self, event, ...)
	local parent = self:GetParent();
	local points = GetComboPoints(PlayerFrame.unit, "target");	
	local spellType, id, subType  = GetActionInfo(parent.action);

	-- 如果是系统自身的提示，就不再处理
	if ( spellType == "spell" and IsSpellOverlayed(id) ) then
		return;
	elseif (spellType == "macro") then
		local _, _, spellId = GetMacroSpell(id);
		if ( spellId and IsSpellOverlayed(spellId) ) then
			return;
		end		
	end

	if (points == 5 and enaleAlert) then		
		if ( spellType == "spell" and IsOverlayedSpell(id) ) then
			ActionButton_ShowOverlayGlow(parent);
			self.isAlert = true;
			self:SetScript("OnUpdate", comboEventFrame_OnUpdate);
		elseif ( spellType == "macro" ) then
			local _, _, spellId = GetMacroSpell(id);
			if ( spellId and IsOverlayedSpell(spellId) ) then
				ActionButton_ShowOverlayGlow(parent);
				self.isAlert = true;
				self:SetScript("OnUpdate", comboEventFrame_OnUpdate);
			else
				ActionButton_HideOverlayGlow(parent);
			end
		else
			ActionButton_HideOverlayGlow(parent);
		end
	else
		ActionButton_HideOverlayGlow(parent);
	end	
end

local function myActionButton_OnUpdate(self, elapsed)
	if (self.comboAlert) then return end

	self.comboAlert = true;

	self.comboEventFrame = CreateFrame("Frame", nil, self);
	self.comboEventFrame.countTime = 0;
	self.comboEventFrame:RegisterEvent("UNIT_COMBO_POINTS");
	self.comboEventFrame:RegisterEvent("PLAYER_TARGET_CHANGED");

	self.comboEventFrame:SetScript("OnEvent", comboEventFrame_OnEvent);
end

hooksecurefunc("ActionButton_OnUpdate", myActionButton_OnUpdate);

function FiveCombo_Toggle(switch)
	if (switch) then
		enaleAlert = true;
	else
		enaleAlert = false;
	end
end
