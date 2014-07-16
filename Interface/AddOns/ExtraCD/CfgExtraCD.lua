U1RegisterAddon("ExtraCD", { 
    title = "内置CD监控",
    defaultEnable = 0,
    tags = { TAG_COMBATINFO, },
    secure = 1,
    nopic= 1,
    desc = "物品及技能的内置CD监控，支持多种饰品及各职业天赋",
    icon = [[Interface\Icons\INV_Misc_Drum_01]],
    optionsAfterVar = 1,

{ 
        type = 'button', 
        text = '设置', 
        callback = function() 
		InterfaceOptionsFrame_OpenToCategory("ExtraCD")
		InterfaceOptionsFrame_OpenToCategory("ExtraCD")
		InterfaceOptionsFrame_OpenToCategory("ExtraCD")
        end 
    }, 



});