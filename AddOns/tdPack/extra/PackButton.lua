
local tdPack = tdCore(...)
local L = tdPack:GetLocale()

local PackButton = tdPack:NewModule('PackButton', CreateFrame('Button'))
tdCore('GUI'):Embed(PackButton, 'UIObject')

function PackButton:New(parent)
    local obj = self:Bind(CreateFrame('Button', nil, parent))
    obj:RegisterForClicks('anyUp')

    obj:SetScript('OnClick', self.OnClick)
	obj:SetScript('OnEnter', function(self)
		local tooltip = GameTooltip
		if not tooltip or not tooltip.AddLine then return end
		GameTooltip:SetOwner(self, self:GetRight() > (GetScreenWidth() / 2) and 'ANCHOR_LEFT' or 'ANCHOR_RIGHT')
		
		tooltip:AddLine('|cff32cd32tdPack|r')
		tooltip:AddDoubleLine(L['Sequence'], tdPack:IsReversePack() and L['desc'] or L['asc'], 1, 1, 0, 1, 1, 1)
		
		tooltip:AddLine(' ')
		tooltip:AddDoubleLine(L['<Left Click> '], L['Pack bags'], 0, 1, 0, 0, 1, 0)
		tooltip:AddDoubleLine(L['Shift + Left-Click'], L['Save to bank'], 0, 1, 0, 0, 1, 0)
		tooltip:AddDoubleLine(L['Ctrl + Left-Click'], L['Load from bank'], 0, 1, 0, 0, 1, 0)
		tooltip:AddDoubleLine(L['Shift + Right-Click'], L['Pack asc'], 0, 1, 0, 0, 1, 0)
		tooltip:AddDoubleLine(L['Ctrl + Right-Click'], L['Pack desc'], 0, 1, 0, 0, 1, 0)
		tooltip:AddDoubleLine(L['<Right Click> '], L['Open tdPack config frame'], 0, 1, 0, 0, 1, 0)

		GameTooltip:Show()
	end)

    return obj
end

function PackButton:OnClick(button)
    if button == 'LeftButton' then
		if IsShiftKeyDown() then
			tdPack:Pack('save')
		elseif IsControlKeyDown() then
			tdPack:Pack('load')
		else
			tdPack:Pack()
		end
    elseif button == 'RightButton' then
		if IsShiftKeyDown() then
			tdPack:Pack('asc')
		elseif IsControlKeyDown() then
			tdPack:Pack('desc')
		else
			tdPack:ToggleOption()
		end
    end
end

function PackButton:GetPackButton(parent)
    if not parent.tdPackButton then
        parent.tdPackButton = self:New(parent)
        parent.tdPackButton:Init()
    end
    return parent.tdPackButton
end

function PackButton:Init()
end
