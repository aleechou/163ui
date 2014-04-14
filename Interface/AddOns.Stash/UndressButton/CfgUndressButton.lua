U1RegisterAddon("UndressButton", {
    title = "试穿增强",
    defaultEnable = 1,
    --optionsAfterVar = 1,
    --minimap = "",

    tags = { TAG_INTERFACE },
    icon = [[Interface\Icons\INV_Chest_Cloth_67]],
    desc = "增强系统默认的试穿窗口，添加全部脱掉的按钮。另外可以以目标为模特试穿，也可以试穿目标身上的装备。`（要打开试穿窗口只需Ctrl点击任意一件装备）",

    --author = "|cffcd1a1c[网易原创]|r",
    --modifier = "|cffcd1a1c[网易]|r",

    --toggle = function(name, info, enable, justload) end,

    {
        text = "设置试穿目标热键",
        callback = function(cfg, v, loading) CoreUIShowKeyBindingFrame("UndressButtonName") end,
    },
    --[[------ Options --------
    {
        var = "",
        default = "",
        text = "",
        callback = function(cfg, v, loading) end,
    },
    --]]
});
