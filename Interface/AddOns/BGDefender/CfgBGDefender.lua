U1RegisterAddon("BGDefender", {
    title = "PVP战场求助",
    defaultEnable = 0,
    load = "NORMAL",
    optionsAfterLogin = 1,

    tags = { TAG_PVP },
    icon = [[Interface\Icons\Ability_Physical_Taunt]],
    desc = "一个小框架方便跟对战场内的其他玩家交流或求助.``显示通报窗口：/bgd",

    {
        text = "重置所有控制台设定",
        callback = function(cfg, v, loading)
            BGD_Prefs = nil;
            ReloadUI();
        end,
    },

});
