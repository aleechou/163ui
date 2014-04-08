------------------------------------------------------------
-- Core.lua
--
-- Abin
-- 2011/2/20
------------------------------------------------------------

local _, addon = ...
local L = addon.L

local function Button_UpdateHotkeys(self)
	ClearOverrideBindings(self)
	local key1, key2 = GetBindingKey("EASYMOUNT_HOTKEY"..self:GetID())
	if key2 then
		SetOverrideBindingClick(self, false, key2, self:GetName())
	end

	if key1 then
		SetOverrideBindingClick(self, false, key1, self:GetName())
	end
end

local function CreateMountButton(name, id, snippet)
	local button = CreateFrame("Button", name, UIParent, "SecureActionButtonTemplate,SecureHandlerMouseUpDownTemplate")
	button:SetID(id)
	button:SetAttribute("type", "macro")
	button:SetAttribute("_onmouseup", snippet)
	button.UpdateHotkeys = Button_UpdateHotkeys
	return button
end

local normalButton = CreateMountButton("EasyMountNormalButton", 1, [[
	local groundCount = self:GetAttribute("groundCount") or 0
	local flyCount = self:GetAttribute("flyCount") or 0
	local swimCount = self:GetAttribute("swimCount") or 0
	local swimming = IsSwimming() or self:GetAttribute("vashjir")

	local macro, spell, category, count
	if UnitHasVehicleUI("player") then
		macro = "/script VehicleExit()"
	elseif IsMounted() then
		macro = "/dismount"
	elseif PlayerInCombat() then
		if swimming then
			spell = self:GetAttribute("auaticForm")
		else
			spell = self:GetAttribute("combatForm")
		end
	elseif swimCount > 0 and swimming then
		category, count = "swim", swimCount
	elseif flyCount > 0 and IsFlyableArea() then
		category, count = "fly", flyCount
	elseif groundCount > 0 then
		category, count = "ground", groundCount
	end

	if category then
		if count > 1 then
			spell = self:GetAttribute(category..random(count))
		else
			spell = self:GetAttribute(category.."1")
		end
	end

	self:SetAttribute("macrotext", macro or (spell and "/cast "..spell))
]])

local groundButton = CreateMountButton("EasyMountGroundButton", 2, [[
	local macro, spell
	local count = self:GetAttribute("groundCount") or 0

	if UnitHasVehicleUI("player") then
		macro = "/script VehicleExit()"
	elseif IsMounted() then
		macro = "/dismount"
	elseif count > 1 then
		spell = self:GetAttribute("ground"..random(count))
	else
		spell = self:GetAttribute("ground1")
	end
	self:SetAttribute("macrotext", macro or (spell and "/cast "..spell))
]])

local vendorsButton = CreateMountButton("EasyMountVendorsButton", 3, [[
	local macro, spell
	local count = self:GetAttribute("vendorsCount") or 0

	if UnitHasVehicleUI("player") then
		macro = "/script VehicleExit()"
	elseif IsMounted() then
		macro = "/dismount"
	elseif count > 1 then
		spell = self:GetAttribute("vendors"..random(count))
	else
		spell = self:GetAttribute("vendors1")
	end
	self:SetAttribute("macrotext", macro or (spell and "/cast "..spell))
]])

local function UpdateAttribute(button, category, key)
	key = key or category
	local list = addon.mountList[category]
	local count = 0
	local data
	for _, data in ipairs(list) do
		if not addon:IsBlackListed(category, data.id) and (data.id ~= 75207 or addon.vashjir) then
			count = count + 1
			button:SetAttribute(key..count, data.name)
		end
	end
	button:SetAttribute(key.."Count", count)
end

local function TaqHasMounts()
	for _, data in ipairs(addon.mountList.taq) do
		if not addon:IsBlackListed("taq", data.id) then
			return 1
		end
	end
end

local needUpdate
local function UpdateActions()
	needUpdate = nil
	if GetRealZoneText() == L["taq"] and TaqHasMounts() then
		UpdateAttribute(normalButton, "taq", "ground")
	else
		UpdateAttribute(normalButton, "ground")
	end

	normalButton:SetAttribute("auaticForm", addon.aquaticForm)
	normalButton:SetAttribute("combatForm", addon.combatForm)
	normalButton:SetAttribute("vashjir", addon.vashjir)
	UpdateAttribute(normalButton, "fly")
	UpdateAttribute(normalButton, "swim")
	UpdateAttribute(groundButton, "ground")
	UpdateAttribute(vendorsButton, "vendors")
end

function addon:UpdateActions()
	if InCombatLockdown() then
		needUpdate = 1
	else
		UpdateActions()
	end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("UPDATE_BINDINGS")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:RegisterEvent('PLAYER_LOGIN')

local do_update_binding = function()
    normalButton:UpdateHotkeys()
    groundButton:UpdateHotkeys()
    vendorsButton:UpdateHotkeys()
end

local _update_bindings = false
frame:SetScript("OnEvent", function(self, event)
    if event == "UPDATE_BINDINGS" or event == 'PLAYER_LOGIN' then
        if(InCombatLockdown()) then
            _update_bindings = true
        else
            do_update_binding()
        end
    elseif event == "PLAYER_REGEN_ENABLED" then
        if(needUpdate) then
            UpdateActions()
        end
        if(_update_bindings) then
            do_update_binding()
        end
    end
end)

function addon:LiteBuff()
    local _, _, icon = GetSpellInfo(36702)

    local LiteBuff = LiteBuff
    if(not LiteBuff) then return end
    local L = LiteBuff.L

    local button = LiteBuff:CreateActionButton('EasyMount', '一键坐骑', nil, nil, 'DUAL')
    button:SetFlyProtect('type1', 'macro', 'type2', 'macro')
    button.icon:SetIcon(icon)

    button.OnTooltipText =function(self, tooltip)
        GameTooltip:AddLine(L["left click"]..'自动', 1, 1, 1, 1)
        GameTooltip:AddLine(L["right click"]..'陆地', 1, 1, 1, 1)
        GameTooltip:AddLine('中键: 取消坐骑', 1, 1, 1, 1)
    end

    for _, btn in next, {normalButton, groundButton} do
        btn:SetParent(button)
        btn:SetAttribute('_childupdate-onmouseup', [[
            self:RunAttribute('_onmouseup')
        ]])
    end

    button:SetAttribute('type1', 'macro')
    button:SetAttribute('type2', 'macro')
    button:SetAttribute('type3', 'macro')
    button:SetAttribute('macrotext1', [[/click EasyMountNormalButton]])
    button:SetAttribute('macrotext2', [[/click EasyMountGroundButton]])
    button:SetAttribute('macrotext3', select(2, UnitClass'player') == 'DRUID'
        and '/cancelform\n/dismount' or [[/dismount]])
    button:SetAttribute('_onmouseup', [[
        self:ChildUpdate('onmouseup', '_onmouseup')
    ]])

    button.OnMountStateChanged = function(self, mounted)
        self.status = mounted and 1 or -1
        return self:UpdateStatus()
    end

    button:SetAttribute('_onstate-mountstate', [[
        self:CallMethod('OnMountStateChanged', newstate == 1)
    ]])
    RegisterStateDriver(button, 'mountstate', '[mounted][flying] 1; 0')
end
