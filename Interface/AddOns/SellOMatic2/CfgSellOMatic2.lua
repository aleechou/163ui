U1RegisterAddon("SellOMatic2", {
    title = "自动售卖助手",
    defaultEnable = 1,
    optionsAfterLogin = 1,
    nopic = true,

    tags = {TAG_ITEM},
    desc = "自动售卖助手在商人交易窗口右上添加了一个自动出售物品的按钮，只需轻点一下这个按钮便可把背包中的灰色物品等垃圾一次全部售出。也可以设置为访问NPC时候就自动出售所有垃圾。",
    icon = [[Interface\Icons\INV_Ammo_FireTar]],

    modifier = "|cffcd1a1c[网易]|r",


	
	    {
        text = "配置选项",
        callback = function ()
		InterfaceOptionsFrame_OpenToCategory("Sell-O-Matic")
		InterfaceOptionsFrame_OpenToCategory("Sell-O-Matic")
		InterfaceOptionsFrame_OpenToCategory("Sell-O-Matic")
		end,
    },
	
});

U1RegisterAddon("SellOMatic2_Destroy", {
    parent = "SellOMatic2",
    protected = 1,
    hide = 1,
});

U1RegisterAddon("SellOMatic2_Item", {
    parent = "SellOMatic2",
    protected = 1,
    hide = 1,
});

U1RegisterAddon("SellOMatic2_List", {
    parent = "SellOMatic2",
    protected = 1,
    hide = 1,
});
