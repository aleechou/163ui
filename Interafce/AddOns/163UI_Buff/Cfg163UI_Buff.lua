U1RegisterAddon("163UI_Buff", {
    title = "增益时间",
    defaultEnable = 1,

    tags = { TAG_COMBATINFO },
    icon = [[Interface\Icons\Achievement_Reputation_KirinTor]],

    author = "SonicBuff",
    modifier = "|cffcd1a1c[网易]|r",

    desc = "玩家的增益效果和负面效果显示精确到秒，无持续时间的状态可以显示'N/A'。``鼠标移动到状态图标上可以显示此效果的施法者",

    --toggle = function(name, info, enable, justload) end,

    -------- Options --------
    {
        text = "增益持续时间",
        tip = "说明`请通过默认的设置界面进行设置",
        default = 1,
        reload = 1,
        type = 'checkbox',
        getvalue = function() return GetCVar'buffDurations' == '1' end,
        callback = function(cfg, v, loading)
            if(v) then
                SetCVar('buffDurations', '1')
            else
                SetCVar('buffDurations', '0')
            end
            -- CoreIOF_OTC(InterfaceOptionsBuffsPanel);
            -- CoreUIShowCallOut(InterfaceOptionsBuffsPanel, InterfaceOptionsBuffsPanelBuffDurations, nil, -15, 10, 160-26-15, -45+26+10)
        end,
    },

    {
        text = "显示所有敌方负面状态",
        tip = "说明`因暴雪的程序BUG，只能通过默认的设置界面进行设置，修改完后记得按确定按钮才能生效。",
        callback = function()
            CoreIOF_OTC(InterfaceOptionsBuffsPanel);
            CoreUIShowCallOut(InterfaceOptionsBuffsPanel, InterfaceOptionsBuffsPanelShowAllEnemyDebuffs, nil, -15, 10, 220-26-15, -45+26+10)
        end,
    },

    {
        var = "time",
        default = 1,
        text = "增益时间精确到秒",
        callback = function(cfg, v, loading)
            _G["163UI_Buff"].cfg_showsec = v
            -- for dura, _ in pairs(SBuff_AuraDurationProcessed) do
            --     SBuff_Aura_ChangeBuffFontSize(dura, true)
            -- end
            -- SBuff_ResetAuraDurationFontSize()
        end,
    },

    {
        var = 'time10',
        default = 0,
        text = '十分钟以上不显示秒(需要打开[增益时间精确到秒]',
        callback = function(cfg, v, loading)
            _G['163UI_Buff'].cfg_showsec_10 = v
        end,
    },

    {
        var = "na",
        default = 1,
        text = "无时间的显示为N/A",
        callback = function(cfg, v, loading)
            _G["163UI_Buff"].cfg_showna = v
        end,
    },

    --[[
    {
        var = "showAllEnemyDebuffs",
        default = "1",
        text = SHOW_ALL_ENEMY_DEBUFFS_TEXT or "显示所有敌方负面状态",
        getvalue = function() return GetCVarBool("showAllEnemyDebuffs") end,
        callback = function(cfg, v, loading) SetCVar("showAllEnemyDebuffs", v and "1" or "0", "SHOW_ALL_ENEMY_DEBUFFS_TEXT") end,
    },
    ]]

    {
        var = "caster",
        default = 1,
        text = "显示BUFF的施放者",
        callback = function(cfg, v, loading) togglehook(nil, "CastByHook", noop, not v) end,
    },

    {
        var = "buffSize",
        default = 13,
        type = "spin",
        tip = "说明`调整美化后的增益减益下面的计时文字尺寸。",
        range = {1, 32, 1},
        text = "剩余时间文字大小",
        callback = function(cfg, v, loading)
            return SBuff_ResetAuraDurationFontSize()
        end,
    }
});
