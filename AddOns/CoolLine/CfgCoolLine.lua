U1RegisterAddon("CoolLine", {
    title = "线性冷却条",
    defaultEnable  = 1,
    -- load = "LOGIN", --LATER会导致屏幕大闪

    tags = {TAG_COMBATINFO,},
    icon = [[Interface\Icons\inv_misc_pocketwatch_02]],
    desc = "在你的界面上显示一个有各种时间刻度的计时条，显示各个法术、物品和技能的图标，以流水线的方式显示冷却的时间，让你能立即决定下一步能使用什么技能。",

    toggle = function(name, info, enable, justload)
        if(justload) then
            if(U1IsAddonEnabled('Ellipsis')) then
                DisableAddOn('CoolLine')
            end
        end
        if(CoolLine and not justload) then
            if(enable) then
                CoolLine:Show()
            else
                CoolLine:Hide()
            end
        end
    end,

    {
        type="checkbox",
        var = "lock",
        text = "锁定线性冷却条位置",
        tip = "说明`锁定/解锁屏幕下方的线性技能冷却条，除可以移动外，还可以拖动右下的红色方块调整大小。",
        default = false,
        callback = function(cfg, v, loading)
            if(CONFIGMODE_CALLBACKS and CONFIGMODE_CALLBACKS.CoolLine) then
                local cmd = v and 'OFF' or 'ON'
                CONFIGMODE_CALLBACKS.CoolLine(cmd)
            end
        end,
    },

});
