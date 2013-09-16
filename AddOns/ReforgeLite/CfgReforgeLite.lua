local load_reforgelite = function()
    if(not IsAddOnLoaded'ReforgeLite') then
        U1LoadAddOn'ReforgeLite'
    end
    -- ReforgeLite:UpdateItems()
end

U1RegisterAddon("ReforgeLite", {
    title = "重铸助手",
    defaultEnable = 1,
    --optionsAfterVar = 1,
    load = "DEMAND",
    --secure = 1,
    --minimap = "",
    --frames = {""}, --需要保存位置的框体

    tags = { TAG_INTERFACE },
    icon = [[Interface\Reforging\Reforge-Portrait]],
    desc = "根据玩家当前天赋，计算全身装备的最佳重铸方案（满足命中精准等预设条件），并可一键完成全身重铸。` `在重铸师处打开重铸界面就可以看到自动计算按钮。也可手工运行/reforge开启界面。``注意：如果卡很久也无法得到计算结果，请调高|cffffffff速度|r选项。",

    modifier = "|cffcd1a1c[网易]|r",

    --toggle = function(name, info, enable, justload) end,
    {
        enableOnNotLoad = 1,
        type = 'button',
        text = '打开重铸计算器',
        callback = function()
            load_reforgelite()
            -- ReforgeLite:UpdateItems()
            return ReforgeLite:OnCommand()
        end,
    },
});

if not CoreOnEvent then return end --for pinyin generation

local cfg_key = 'reforgelite/autoload'

-- CoreOnEvent('GOSSIP_SHOW', function()
--     if not U1IsAddonEnabled("reforgelite") then return end
--     if(1 < GetNumGossipOptions()) then
--         local text1 = GetGossipOptions()
--         if(text1 == '重铸一件物品。' and U1DB.configs[cfg_key]) then
--             SelectGossipOption(1)
--         end
--     end
-- end)

--/run for k, v in pairs(ReforgeLite.presets) do print("-----"..k.."---") for k2,v2 in pairs(v) do print(k2) end end
CoreOnEvent('FORGE_MASTER_OPENED', function()
    --if not U1IsAddonEnabled("reforgelite") then return end
    U1DB.configs[cfg_key] = true

    local lclass, class = UnitClass'player'

--     local gettalentpoints = function(index, tab, group)
--         group = group or GetActiveTalentGroup()
--         local name, icon, tier, column, rank = GetTalentInfo(tab, index, nil, nil, group)
--         return rank
--     end


    local L = setmetatable({}, {__index = function(t, i)
        if(type(i) == 'string') then
            t[i] = ReforgeLiteLocale[i] or i
            return t[i]
        end
        return i
    end})

--     local get_current_talent_name = function()
--         local group = GetActiveSpecGroup()
--         local spec = GetSpecialization(false, false, group);
--         if(spec) then
--             return select(2, GetSpecializationInfo(spec));
--         end
--     end

    local calc_and_open = function()
        -- local display_setname, preset, prefix

        local preset, setname

        -- local presets = ReforgeLite.presets
        local specName
        do
            local spec = GetSpecialization()
            local id, name = GetSpecializationInfo(spec)
            specName = name
        end

        if(specName) then
            for k, v in next, ReforgeLite.presets do
                local name = k:gsub('<(.*)>', function(a) return L[a] end)
                if(specName == name) then
                    preset = v
                    setname = name
                end
            end
        end

        if(not preset) then
            local _
            _, preset = next(ReforgeLite.presets)
        end

--         local presets = ReforgeLite.presets[class]
--         if presets["Tier 13"] then prefix = L["Tier 13"].."-" presets = presets["Tier 13"] end
--         local current_talent = get_current_talent_name()

--         if(current_talent) then
--             for name, set in next, presets do
--                 if(current_talent == L[name] or L[name]:find(current_talent)) then
--                     preset = set
--                     display_setname = (prefix or "")..L[name]
--                     break
--                 end
--             end
--         end

--         -- get first preset in sight
--         if not preset then
--             local name, set = next(presets)
--             display_setname = (prefix or "")..L[name]
--             preset = set
--         end

--         -- there're subsets
--         if not (preset.caps or preset.weights) then
--             presets = preset
--             preset = nil
--             local set_name 

-- --             --print(set_name)

--             preset = set_name and presets[set_name]
--             display_setname = L[set_name]
--         end

--         if(preset and preset.weights) then
--             ReforgeLite:SetStatWeights(preset.weights, preset.caps or {})
--         end

        if(preset) then
            local s = preset
            if(s.leaf == 'import') then
                ReforgeLite:SetStatWeights(s.weights, s.caps, s.prio)
            else
                ReforgeLite:SetStatWeights(s.weights, s.caps or {}, s.prio)
            end
        end

        -- click compute button
        local compute = ReforgeLite.computeButton
        local _ = (compute:GetScript'OnClick')(compute)

        ReforgeLite:ShowMethodWindow()
        ReforgeLite.methodWindow.title:SetText("重铸助手" .. ' (' .. setname .. ')')
    end


    --
    -- Create Button
    --
    local btn = TplPanelButton(ReforgingFrame)
    btn:SetWidth(80)
    btn.text:SetText'自动计算'
    btn:SetPoint('TOPRIGHT', ReforgingFrame, -70, -30)
    btn:SetFrameLevel(btn:GetFrameLevel() + 50)
    btn:SetScript('OnClick', function()
        load_reforgelite()
        if not ReforgeLite.initialized then
            ReforgeLite:CreateFrame()
        end
        ReforgeLite:UpdateItems()

        calc_and_open()
    end)
    CoreUIEnableTooltip(btn, "重铸助手", "根据当前天赋自动计算全身装备的最佳重铸方案，点击'重铸所选'按钮立即完成所有重铸。")

    local adv = TplPanelButton(ReforgingFrame)
    adv.text:SetText'高级'
    adv:SetWidth(55)
    adv:SetPoint('TOPLEFT', btn, 'TOPRIGHT', 3, 0)
    adv:SetFrameLevel(btn:GetFrameLevel() + 50)
    adv:SetScript('OnClick', function()
        if(not ReforgeLite) then
            load_reforgelite()
        end
        if(ReforgeLite:IsShown()) then
            ReforgeLite:Hide()
        else
            ReforgeLite:OnCommand()
            ReforgeLite.title:SetText'重铸助手'
        end
    end)
    CoreUIEnableTooltip(adv, "说明", "打开重铸助手高级设置界面，可以调整各项属性的重铸目标，然后点'计算'按钮，再点'显示结果'按钮即可")


    --ReforgingFrame:HookScript('OnHide', function()
    --    if(ReforgeLite) then ReforgeLite:Hide() end
    --    if(ReforgeLite and ReforgeLite.methodWindow) then ReforgeLite.methodWindow:Hide() end
    --end)

    return 1 -- unregistar this event
end)


