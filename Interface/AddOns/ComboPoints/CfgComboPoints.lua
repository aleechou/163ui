U1RegisterAddon("ComboPoints", {
    title = "连击点显示",
    defaultEnable = 0,
    optionsAfterVar = 1,
    --minimap = "",
    frames = {"ComboPoints_ComboBar"},

    tags = { TAG_COMBATINFO, TAG_CLASS, TAG_ROGUE, TAG_DRUID, TAG_PALADIN, TAG_SHAMAN, TAG_WARLOCK, },
    icon = [[Interface\Icons\INV_Misc_MissileSmallCluster_Red]],
    desc = "连击点数显示插件，相对默认目标头像上的连击点更加醒目。`- 支持潜行者和德鲁伊`- 支持增强萨满的漩涡武器`- 支持圣骑士的圣能`- 支持术士的灵魂碎片",

    modifier = "|cffcd1a1c[网易]|r",

    toggle = function(name, info, enable, justload)
        if justload then return end
        if not enable then
            SlashCmdList["COMBOPOINTS"]("hide")
        else
            SlashCmdList["COMBOPOINTS"]("show")
        end
    end,

    ---[[------ Options --------
    {
        var = "locked",
        default = 1,
        text = "锁定/解锁位置",
        tip = "说明`解锁后可移动位置，锁定后可防止鼠标点击",
        callback = function(cfg, v, loading)
            SlashCmdList["COMBOPOINTS"](v and "lock" or "unlock");
        end,
    },
    {
        var = "appear",
        default = nil,
        text = "模拟显示",
        tip = "说明`总是显示所有连击点, 方便拖动",
        callback = function(cfg, v, loading)
            ComboPoints_SlashHandler_Appear(not not v);
        end,
    },
    {
        var = "mode",
        default = 6,
        type = "radio",
        cols = 4,
        options = {"向右", 6, "向左", 4, "向上", 8, "向下", 2, },
        text = "连击点排列模式",
        callback = function(cfg, v, loading)
            SlashCmdList["COMBOPOINTS"]("mode "..tostring(v));
        end,
    },
    {
        text = "重置设定",
        callback = function(cfg, v, loading)
            SlashCmdList["COMBOPOINTS"]("reset");
        end,
    },
    --]]
});
--lock unlock 向左向右向上向下 恢复 宽度 高度, 颜色12345
