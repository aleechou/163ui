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
	
    {
        type="checkbox",
        text="自动贩卖",
        var = "autoSell",
        default = true,
        tip="切换开启/关闭自动模式",
		getvalue = function() return SellOMatic.db.profile['autoSell'] end,
        callback = function(cfg, v, loading)
			if v then
				SellOMatic.db.profile['autoSell'] = true
			else
				SellOMatic.db.profile['autoSell'] = false
			end
		end,
    },	
	{
        var = "showFullInfo",
        default =  "2-LITE",
        text = "讯息种类",
        type = "radio",
        options = {"完整","1-FULL", "精简","2-LITE"},
		getvalue = function() return SellOMatic.db.profile['showFullInfo'] end,
		callback = function(cfg, v, loading)
			SellOMatic.db.profile['showFullInfo'] = v
        end,
	},
    {
        type="checkbox",
        text="预览",
        var = "preview",
        default = false,
        tip="开启/关闭出售前的预览",
		getvalue = function() return SellOMatic.db.profile['preview'] end,
        callback = function(cfg, v, loading)
			if v then
				SellOMatic.db.profile['preview'] = true
			else
				SellOMatic.db.profile['preview'] = false
			end
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
