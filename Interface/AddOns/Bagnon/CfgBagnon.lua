U1RegisterAddon("Bagnon", {
    title = "简约背包整合",
    defaultEnable = 0,
    optionsAfterLogin = 1,
    nopic = true,

    tags = {TAG_ITEM},
    desc = "整合背包/银行/公会银行/虚空储存，并支持离线查看。与分类背包整合（Combuctor）功能重复，建议只开启一个背包整合插件。",
    icon = [[Interface\Icons\INV_Misc_Bag_29]],
    optdeps = {"BagBrother"},

    modifier = "|cffcd1a1c[网易]|r",

    {
        text = "打开设置界面",
        callback = function()
            Bagnon:ShowOptions()
        end,
    },
});

U1RegisterAddon("Bagnon_Config", {
    parent = "Bagnon",
    protected = 1,
    hide = 1,
});

U1RegisterAddon("Bagnon_GuildBank", {
    parent = "Bagnon",
    title = "公会银行",
    desc = "暂时不能更改权限, 如有需要请关闭该子插件",
});

U1RegisterAddon("Bagnon_VoidStorage", {
    parent = "Bagnon",
    title = "虚空储存",
});

U1RegisterAddon("tdCore", {
    title = "太多插件",
	parent = "Bagnon",
    hide = 1,
})

U1RegisterAddon("tdPack", {
    title = "[简]背包整理",
	parent = "Bagnon",
    hide = 1,
})

