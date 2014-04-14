-- Finish rewrite for Cataclysm

--[[
	Cataclysm Stuff:
	
	local prof1, prof2, arch, fish, cook, firstAid = GetProfessions();
		- prof1: first profession
		- prof2: second profession
		- arch: archaeology
		- fish: fishing
		- cook: cooking
		- firstAid: first aid
	local ProfessionName, ProfessionTexture, CurrentProfessionSkill, MaxProfessionSkill, NumSpells, SpellOffset = GetProfessionInfo(Index)
		- Args: Index: index returned by GetProfessions()
		- ProfessionName: Name of the profession
		- ProfessionTexture: texture of the profession
		- CurrentProfessionSkill: current skill level in the profession
		- MaxProfessionSkill: maximum skill level for your profession rank
		- NumSpells: 1 if the profession doesn't have any sub spells like milling, or disenchanting; 2 if the profession does have subskills
		- SpellOffset: used in calculating subskill information
	PROFESSION_RANKS = {
		[1] = { 75, "Apprentice" },
		[2] = { 150, "Journeyman" },
		[3] = { 225, "Expert" },
		[4] = { 300, "Artisan" },
		[5] = { 375, "Master" },
		[6] = { 450, "Grand Master" },
		[7] = { 525, "Illustrious" },
	}
	
	local SpellIndex = NumSpells + SpellOffset
	local Name, Rank = GetSpellName(SpellIndex, "profession") -- returns information on the subskill (milling, disenchant, basic campfire, etc)
	local Texture = GetSpellTexture(SpellIndex, "profession")
	
--]]

local ProfessionTabs = CreateFrame("Frame", "ProfessionTabs")
ProfessionTabs:SetScript("OnEvent", function(self, Event, ...) self[Event](self, Event, ...) end)
ProfessionTabs:RegisterEvent("TRADE_SKILL_SHOW")
ProfessionTabs:RegisterEvent("TRADE_SHOW")
ProfessionTabs:RegisterEvent("SKILL_LINES_CHANGED")
ProfessionTabs:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")

local __TradeSkillFrame
local format = string.format
local IsCurrentSpell = IsCurrentSpell
local Cache, TradeSkillFrameTabs, TradeFrameTabs = {}, {}, {}
local TradeSkillFrameTabIndex, TradeFrameTabIndex = 1, 1
local Professions = {
	[1] = { 2259, 3101, 3464, 11611, 28596, 51304, 80731, 105206 }, -- Alchemy
	[2] = { 2018, 3100, 3538, 9785, 29844, 51300, 76666, 110396 }, -- Blacksmithing
	[3] = { 7411, 7412, 7413, 13920, 28029, 51313, 74258, 110400 }, -- Enchanting
	[4] = { 4036, 4037, 4038, 12656, 30350, 51306, 82774, 110403 }, -- Engineering
	[5] = { 45357, 45358, 45359, 45360, 45361, 45363, 86008, 110417 }, -- Inscription
	[6] = { 25229, 25230, 28894, 28895, 28897, 51311, 73318, 110420 }, -- Jewelcrafting
	[7] = { 2108, 3104, 3811, 10662, 32549, 51302, 81199, 110423 }, -- Leatherworking
	[8] = { 3908, 3909, 3910, 12180, 26790, 51309, 75156, 110426 }, -- Tailoring
	[9] = { 2550, 3102, 3413, 18260, 33359, 51296, 88053, 104381 }, -- Cooking
	[10] = { 3273, 3274, 7924, 10846, 27028, 45542, 74559, 110406 }, -- First Aid
    [11] = { 78670, 88961, 89718, 89719, 89720, 89721, 89722, 110393 }, -- Archaeology
	[12] = { 53428 }, -- Runeforging
	[13] = { 2656 }, -- Smelting
	[14] = { 13262 }, -- Disenchant
	[15] = { 51005 }, -- Milling
	[16] = { 31252 }, -- Prospecting
	[17] = { 818 }, -- Basic Campfire
	[18] = { 1804 }, -- Pick Lock
    [19] = { 80451 }, -- Survey
}

function ProfessionTabs:CacheProfessions()
	wipe(Cache)
	
	for Index = 1, #Professions do
		for NewIndex = 1, #Professions[Index] do
			local Profession = Professions[Index][NewIndex]
			if IsSpellKnown(Profession) then
				Cache[#Cache+1] = Profession
				break
			end
		end
	end	
end

function ProfessionTabs:TriggerEvents()
	if TradeFrame and TradeFrame:IsShown() then
		self:TRADE_SHOW()
	end
	
	if __TradeSkillFrame and __TradeSkillFrame:IsShown() then
		self:TRADE_SKILL_SHOW()
	end	
end

local function Tab_OnEnter(self)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT") 
	GameTooltip:AddLine(self.SpellRank ~= "" and format("%s (%s)", self.SpellName, self.SpellRank) or self.SpellName, 1, 1, 1)
	GameTooltip:Show()
end

local function Tab_OnLeave(self)
	GameTooltip:Hide()
end

function ProfessionTabs:CreateTab(Table, Parent)
	local Tab = CreateFrame("CheckButton", nil, Parent, "SpellBookSkillLineTabTemplate SecureActionButtonTemplate")

    if(Parent == ATSWFrame) then
        Tab:SetPoint("TOPLEFT", Parent, "TOPRIGHT", -32, -32 - 44 * #Table)
    elseif(Parent == TradeFrame) then
        Tab:SetPoint("TOPLEFT", Parent, "TOPRIGHT", 0, -32 - 44 * #Table)
    else
        Tab:SetPoint("TOPLEFT", Parent, "TOPRIGHT", 0, -24 - 44 * #Table)
    end

	Tab:SetScript("OnEnter", Tab_OnEnter)
	Tab:SetScript("OnLeave", Tab_OnLeave)
	
	Table[#Table + 1] = Tab
	return Tab
end

function ProfessionTabs:UpdateTabs(Table)
	local Combat = InCombatLockdown()
	
	for Index = 1, #Table do
		local Tab = Table[Index]
		
		if Index > #Cache then
			if not Combat then Tab:Hide() end
		else
			if not Combat then Tab:Show() end
			Tab:SetChecked(IsCurrentSpell(Tab.SpellName))
		end
	end	
end

function ProfessionTabs:EventHandler(Table, Parent)
	if InCombatLockdown() then
		self:RegisterEvent("PLAYER_REGEN_ENABLED")
	else
		self:CacheProfessions()
		
		for Index = 1, #Cache do
			local SpellName, SpellRank, SpellTexture = GetSpellInfo(Cache[Index])
			local Tab = Table[Index] or self:CreateTab(Table, Parent)
			
			Tab.SpellName = SpellName
			Tab.SpellRank = SpellRank
			Tab:SetNormalTexture(SpellTexture)
			Tab:SetAttribute("type", "spell")
			Tab:SetAttribute("spell", SpellName)
		end
	end
	
	self:UpdateTabs(Table)
end

function ProfessionTabs:TRADE_SKILL_SHOW()
	__TradeSkillFrame = __TradeSkillFrame or MRTSkillFrame or ATSWFrame or SkilletFrame or TradeSkillFrame
	self:EventHandler(TradeSkillFrameTabs, __TradeSkillFrame)
	
	if TradeFrame:IsShown() then
		self:EventHandler(TradeFrameTabs, TradeFrame)
	end
end

function ProfessionTabs:TRADE_SHOW()
	self:EventHandler(TradeFrameTabs, TradeFrame)
end

function ProfessionTabs:SKILL_LINES_CHANGED()
	self:TriggerEvents()
end

function ProfessionTabs:PLAYER_REGEN_ENABLED(Event)
	self:UnregisterEvent(Event)
	self:TriggerEvents()
end

function ProfessionTabs:CURRENT_SPELL_CAST_CHANGED()
	if TradeSkillFrameTabs and TradeSkillFrameTabs[1] and TradeSkillFrameTabs[1]:IsVisible() then
		self:UpdateTabs(TradeSkillFrameTabs)
	end
end
