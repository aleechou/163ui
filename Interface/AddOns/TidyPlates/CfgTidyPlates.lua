U1RegisterAddon("TidyPlates", {
    title = "美化姓名版",
    defaultEnable = 1,
    load = "NORMAL",
    optionsAfterLogin = 1,

    tags = { TAG_INTERFACE, TAG_GOOD, TAG_BIG, },
    icon = [[Interface\Icons\Spell_Holy_SealOfRighteousness]],
    desc = "強大到爆的多功能姓名版美化插件。``设置口令：/tidyplates",
    pics = 2,

    {
        text = "重置所有控制台设定",
        callback = function(cfg, v, loading)
            TidyPlatesOptions = nil;
            TidyPlatesHubCache = nil;
            TidyPlatesHubGlobal = nil;
            TidyPlatesHubSettings = nil;
            TidyPlatesWidgetData = nil; 
            ReloadUI();
        end,
    },

});