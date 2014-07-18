U1RegisterAddon("ChatFilter", { 
    title = "聊天过滤",
    defaultEnable = 0,
    tags = { TAG_CHAT, },
    secure = 1,
nopic = 1,
    desc = "强力聊天过滤插件，过滤重复及广告信息，过滤多行宏，合并显示切换天赋时的学会/忘却技能，合并显示获得成就，合并显示制造物品。",
    icon = [[Interface\Icons\Spell_Holy_PowerInfusion]],
    optionsAfterVar = 1,
	
	
	U1RegisterAddon('!NoTaint', {title = '聊天栏过滤', parent = 'ChatFilter'})
	
});

