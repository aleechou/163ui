U1RegisterAddon("JSHB", { 
    title = "猎人集中值增强条",
    defaultEnable = (class=="HUNTER") and 1 or 0,
    tags = { TAG_CLASS, TAG_HUNTER, },
    secure = 1,
    nopic = 1,
    desc = "在界面上显示你的集中值计时条，可以显示你的集中值、自动射击计时、猎人技能的冷却、猎人技能的Buff计时等讯息。",
    icon = [[Interface\Icons\Ability_Hunter_ImprovedSteadyShot]],
	

    {
        type = 'button',
        text = '配置',
        callback = function()
            SlashCmdList["JSHB"]("")
        end,
    },
	
});