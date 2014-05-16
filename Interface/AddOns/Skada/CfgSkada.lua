U1RegisterAddon("Skada", {
    title = "伤害统计",
    tags = {TAG_RAID },
	defaultEnable = 1,
    icon = [[Interface\ICONS\ACHIEVEMENT_GUILDPERK_FASTTRACK_RANK2]],
    desc = "老牌的伤害统计插件，可以用来统计DPS、治疗量、驱散次数、承受伤害、死亡记录等等，是团队不可缺少的数据分析工具。支持图形化显示、信息广播等功能。",
	minimap = "LibDBIcon10_Skada",
   { 
        type = 'button', 
        text = '配置模块', 
        callback = function() 
            InterfaceOptionsFrame_OpenToCategory("Skada")
            InterfaceOptionsFrame_OpenToCategory("Skada")
        end 
    }, 
});
