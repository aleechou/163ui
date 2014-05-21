U1RegisterAddon("Combuctor", {
    title = "分类背包整合",
    defaultEnable = 1,
    optionsAfterLogin = 1,
    nopic = true,
    tags = {TAG_ITEM},
    desc = "整合背包后支持物品分类，与简约背包整合（Bagnon）功能重复，建议只开启一个背包整合插件。",
    icon = [[Interface\Icons\INV_Misc_Bag_29]],
    optdeps = {"BagBrother"},
    modifier = "|cffcd1a1c[网易]|r",
});
U1RegisterAddon("Combuctor_Config", {title = "分类背包配置", parent = "Combuctor", protected = 1, hide = 1,});
U1RegisterAddon("Combuctor_Sets", {title = "分类背包分类", parent = "Combuctor", protected = 1, hide = 1,});
U1RegisterAddon("JPack", {title = "[分]背包整理", parent = "Combuctor", protected = 1, hide = 1,});
U1RegisterAddon("JPack_Ex", {title = "[分]背包整理按钮", parent = "Combuctor", protected = 1, hide = 1,});