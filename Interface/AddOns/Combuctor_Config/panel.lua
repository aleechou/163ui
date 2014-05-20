--[[
	panel.lua
		An options panel class
--]]

local Panel = LibStub('Classy-1.0'):New('Frame')
local min = math.min
local max = math.max

local ADDON, Addon = ...
Addon.Panel = Panel


--[[ API ]]--

function Panel:New(name, title, subtitle, icon, parent, sideTitle)
	local f = self:Bind(CreateFrame('Frame', name, UIParent))
	f.name = sideTitle or title
	f.parent = parent
	
	local text = f:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
	text:SetPoint('TOPLEFT', 16, -16)
	if icon then
		text:SetFormattedText('|T%s:%d|t %s', icon, 32, title)
	else
		text:SetText(title)
	end

	local subtext = f:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
	subtext:SetHeight(32)
	subtext:SetPoint('TOPLEFT', text, 'BOTTOMLEFT', 0, -8)
	subtext:SetPoint('RIGHT', f, -32, 0)
	subtext:SetNonSpaceWrap(true)
	subtext:SetJustifyH('LEFT')
	subtext:SetJustifyV('TOP')
	subtext:SetText(subtitle)
	
	InterfaceOptions_AddCategory(f)
	return f
end


--[[ Widgets ]]--

function Panel:NewCheckButton(name, tooltip)
	local b = CreateFrame('CheckButton', self:GetName() .. name, self, 'InterfaceOptionsCheckButtonTemplate')
	_G[b:GetName() .. 'Text']:SetText(name)

  if tooltip then
    b:SetScript('OnEnter', function()
      GameTooltip:SetOwner(b, 'ANCHOR_RIGHT')
      GameTooltip:SetText(tooltip)
    end)

    b:SetScript('OnLeave', function()
      if GameTooltip:IsOwned(b) then
        GameTooltip:Hide()
      end
    end)
  end

	return b
end

function Panel:NewDropdown(name)
	local f = CreateFrame('Frame', self:GetName() .. name, self, 'UIDropDownMenuTemplate')

	local text = f:CreateFontString(nil, 'BACKGROUND', 'GameFontNormalSmall')
	text:SetPoint('BOTTOMLEFT', f, 'TOPLEFT', 21, 0)
	text:SetText(name)

	return f
end

function Panel:NewButton(name, width, height)
	local b = CreateFrame('Button', self:GetName() .. name, self, 'UIPanelButtonTemplate')
	b:SetText(name)
	b:SetWidth(width)
	b:SetHeight(height or width)

	return b
end

--basic slider
do
  local function Slider_OnMouseWheel(self, arg1)
    local step = self:GetValueStep() * arg1
    local value = self:GetValue()
    local minVal, maxVal = self:GetMinMaxValues()

    if step > 0 then
      self:SetValue(min(value+step, maxVal))
    else
      self:SetValue(max(value+step, minVal))
    end
  end

  function Panel:NewSlider(text, low, high, step)
    local name = self:GetName() .. text
    local f = CreateFrame('Slider', name, self, 'OptionsSliderTemplate')
    f:SetScript('OnMouseWheel', Slider_OnMouseWheel)
    f:SetMinMaxValues(low, high)
    f:SetValueStep(step)
    f:EnableMouseWheel(true)

    _G[name .. 'Text']:SetText(text)
    _G[name .. 'Low']:SetText('')
    _G[name .. 'High']:SetText('')

    local text = f:CreateFontString(nil, 'BACKGROUND', 'GameFontHighlightSmall')
    text:SetPoint('LEFT', f, 'RIGHT', 7, 0)
    f.valText = text

    return f
    end
end