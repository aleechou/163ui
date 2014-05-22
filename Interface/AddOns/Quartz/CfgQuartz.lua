U1RegisterAddon("Quartz", {
    title = "施法条增强",
    tags = { TAG_INTERFACE, TAG_GOOD, },
    defaultEnable = 1,
    load = "NORMAL",
    icon = [[Interface\ICONS\INV_Enchant_EssenceCosmicGreater]],
    desc = "美化和增强施法条，支持延迟显示等贴心功能。",
	
	{ 
        type = 'button', 
        text = '配置界面', 
        callback = function() 
            InterfaceOptionsFrame_OpenToCategory("Quartz 3")
			InterfaceOptionsFrame_OpenToCategory("Quartz 3")
			InterfaceOptionsFrame_OpenToCategory("Quartz 3")
        end 
    }, 	
});