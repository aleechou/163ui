U1RegisterAddon("TradeTabs", {
    title = "专业技能标签",
    defaultEnable = 1,

    tags = { TAG_TRADING },
    icon = [[Interface\Icons\ACHIEVEMENT_GUILDPERK_LADYLUCK]],
    desc = "在专业技能面板右侧显示多个标签，对应自己所学会的所有商业技能",

    modifier = "|cffcd1a1c[网易]|r",

    --[[------ Options --------
    {
        var = "",
        default = "",
        text = "", 
        callback = function(cfg, v, loading) end, 
    },
    {
        var = "",
        default = "",
        text = "",
        callback = function(cfg, v, loading) end,
    },
    --]]
});
