local _, engClass = UnitClass("player")
U1RegisterAddon("EventAlertMod", {
    title = "技能特效报警",
    defaultEnable = 0,
    --optionsAfterVar = 1,
    load = "LOGIN", --5.0 script ran too long
    --secure = 1,
    --minimap = "",
    --frames = {""}, --需要保存位置的框体

    tags = { TAG_COMBATINFO },
    icon = [[Interface\Icons\Spell_Nature_Polymorph_Cow]],
    desc = "图标式的技能特效报警，当要监控的技能满足条件时，在人物上方或下方显示对应的法术图标及时间。可以监控技能冷却、增益和负面效果，也可以提醒需要释放的技能，例如死骑职业可以提示‘当身上没有战斗怒吼和寒冬号角，而且寒冬号角技能可用时，显示提示图标’。``设置界面稍微有点复杂，快捷指令是/eam opt。`其他指令说明：/eam help",
    pics = 2,

    --toggle = function(name, info, enable, justload) end, --如果未开插件，则初始不会调用。

    {
        type = 'button',
        text = '开启设置界面',
        tip = "快捷命令`/eam opt",
        callback = function()
            return (SlashCmdList['EVENTALERTMOD'])'opt'
        end,
    },
	
	{
        var = 'checkBE',
		visible = (engClass == "WARLOCK"),
        text = '监视爆燃灰烬',
        callback = function(cfg, v, loading)
            EA_SpecCheckPower.CheckBurningEmbers = v and true or false
        end,
    },

});
