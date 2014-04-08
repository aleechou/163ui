
local Masque = LibStub'Masque'
local BlizzFacade = LibStub('AceAddon-3.0'):NewAddon('BlizzFacade', 'AceHook-3.0')

function BlizzFacade:OnInitialize()
    self.groups = {}
    -- dummy
end

function BlizzFacade:OnEnable()
    self:HookBuff()

    if(not U1IsAddonEnabled'Dominos') then
        self:HookActionButton()
    end
end

function BlizzFacade:OnDisable()

end

local AuraButton_Update
do
    local buffbutton = 0
    local debuffbutton = 0

    function AuraButton_Update(buttonName, index)
        local btn = _G[buttonName..index]
        if(not btn or btn.__BlizzFacade) then return end
        btn.__BlizzFacade = true

        if(buttonName == 'BuffButton') then
            BlizzFacade.groups.buffs:AddButton(btn)
            if(index > buffbutton) then
                buffbutton = index
            end
        elseif(buttonName == 'DebuffButton') then
            BlizzFacade.groups.debuffs:AddButton(btn)
            if(index > debuffbutton) then
                debuffbutton = index
            end
        end

        if(buffbutton == BUFF_MAX_DISPLAY and debuffbutton == DEBUFF_MAX_DISPLAY) then
            BlizzFacade:Unhook(AuraButton_Update)
        end
    end
end

function BlizzFacade:HookBuff()
    self.groups.buffs = Masque:Group('默认BUFF按钮', '增益按钮')
    self.groups.debuffs = Masque:Group('默认BUFF按钮', '减益按钮')
    self.groups.tempenchant = Masque:Group('默认BUFF按钮', '武器附魔')

    self:SecureHook('AuraButton_Update', AuraButton_Update)

    for i=1, NUM_TEMP_ENCHANT_FRAMES do
        local button = _G["TempEnchant"..i]
        if(button) then
            self.groups.tempenchant:AddButton(button)
        end
    end

    for i=1, BUFF_MAX_DISPLAY do
        if(_G['BuffButton'..i]) then
            AuraButton_Update("BuffButton", i, "HELPFUL")
        else
            break
        end
    end

    for i=1, BUFF_MAX_DISPLAY do
        if(_G['DebuffButton'..i]) then
            AuraButton_Update("DebuffButton", i, "HARMFUL")
        else
            break
        end
    end
end

local AddButtonToGroup = function(btnname, index, groupname, func)
    local Group = Masque:Group('默认动作条按钮', groupname)
    BlizzFacade.groups[groupname] = Group
    for i = 1, index do
        local btn = _G[format(btnname, i)]
        if(btn) then
            Group:AddButton(btn)
            if(func) then
                pcall(func, btn)
            end
        end
    end
end

function BlizzFacade:HookActionButton()
    local group = '主动作条'
    AddButtonToGroup('ActionButton%d', NUM_ACTIONBAR_BUTTONS, group, function(btn)
        if not InCombatLockdown() then btn:SetFrameStrata'HIGH' end
    end)
    --[[
    local group = '额外动作条'
    do
        local lvl = ActionButton1:GetFrameLevel()
        if not InCombatLockdown() then BonusActionBarFrame:SetFrameLevel(lvl + 1) end
    end
    AddButtonToGroup('BonusActionButton%d', NUM_BONUS_ACTION_SLOTS, group, function(btn)
        if not InCombatLockdown() then btn:SetFrameStrata'DIALOG' end
    end)

    local group = '姿态动作条'
    AddButtonToGroup('ShapeshiftButton%d', NUM_SHAPESHIFT_SLOTS, group, function(btn)
        if not InCombatLockdown() then btn:SetFrameStrata'HIGH' end
    end)
    --]]

    local group = '宠物动作条'
    AddButtonToGroup('PetActionButton%d', NUM_PET_ACTION_SLOTS, group)

    local group = '右侧动作条1'
    AddButtonToGroup('MultiBarLeftButton%d', NUM_MULTIBAR_BUTTONS, group)
    local group = '右侧动作条2'
    AddButtonToGroup('MultiBarRightButton%d', NUM_MULTIBAR_BUTTONS, group)
    local group = '左下动作条'
    AddButtonToGroup('MultiBarBottomLeftButton%d', NUM_MULTIBAR_BUTTONS, group)
    local group = '右下动作条'
    AddButtonToGroup('MultiBarBottomRightButton%d', NUM_MULTIBAR_BUTTONS, group)

    local group = '控制动作条'
    AddButtonToGroup('PossessButton%d', NUM_POSSESS_SLOTS, group)

    --[[
    local group = '载具动作条'
    local SetPoint = ActionButton1Count.SetPoint
    AddButtonToGroup('VehicleMenuBarActionButton%d', VEHICLE_MAX_ACTIONBUTTONS, group, function(btn)
        local hotkey = _G[btn:GetName() .. 'HotKey']
        if(hotkey and hotkey.SetPoint ~= SetPoint) then
            hotkey.SetPoint = SetPoint
        end
    end)
    --]]
end
