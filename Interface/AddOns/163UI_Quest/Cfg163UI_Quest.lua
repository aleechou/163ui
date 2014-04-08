U1RegisterAddon("163UI_Quest", {
    title = "任务交接增强",
    defaultEnable = 1,

    tags = { TAG_MAPQUEST, },
    icon = [[Interface\Icons\INV_Letter_18]],
    desc = "与任务交接相关的贴心功能：``在任务奖励处直接显示物品售价(此功能来自Abin的QuestPrice)，提供'自动选择最贵并交还任务'的按钮。``在任务面板上增加快捷的交接任务按钮，不必设置即可实现半自动交接，如果点选NPC时按住ALT键，则可自动点击快捷按钮，实现'全自动交接'。``拾取任务触发物品后，自动弹出接受任务的窗口。",
    pics = 2,

    author = "|cffcd1a1c[网易原创]|r",
    --modifier = "|cffcd1a1c[网易]|r",

    --toggle = function(name, info, enable, justload) end,

    {
        var = "searchcontainer",
        default = 1,
        text = "自动接受背包物品的任务",
        tip = "说明`当打怪拾取到能接受的任务物品的时候，自动点击接受任务。如果有收藏的任务物品，请关闭此项",
        -- callback = function(cfg, v, loading)
        --     if v then U1QuestEventFrame:RegisterEvent("BAG_UPDATE") else U1QuestEventFrame:UnregisterEvent("BAG_UPDATE") end
        -- end,
    },
});
