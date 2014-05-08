U1RegisterAddon("Combuctor", {
    title = "背包整合",
    defaultEnable = 1,
    optionsAfterLogin = 1,
    nopic = true,

    tags = {TAG_ITEM},
    desc = "整合背包/银行/公会银行",
    icon = [[Interface\Icons\INV_Misc_Bag_29]],
    optdeps = {"BagBrother"},

    modifier = "|cffcd1a1c[网易]|r",

    {
        text = "打开设置界面",
        callback = function()
            InterfaceOptionsFrame_OpenToCategory("Combuctor")
        end,
    },
});

U1RegisterAddon("Combuctor_Config", {
    parent = "Combuctor",
    protected = 1,
    hide = 1,
});
U1RegisterAddon("Combuctor_Sets", {
    parent = "Combuctor",
    protected = 1,
    hide = 1,
});


