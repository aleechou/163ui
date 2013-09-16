UI163_USER_MODE = 1 --这句必须写一次，影响一些默认值。单体版控制台已经写过了
U1RegisterAddon("BlinkHealthText", {
    title = "多玩简易状态",
    tags = {"COMBATINFO", "GOOD"},
    icon = "Interface\\Icons\\Spell_ChargeNegative",
    nopic = 1,
	toggle = function(name, info, enable, justload)
		if enable then
			SlashCmdList["BLINKHEALTH"]("on")
		else
			SlashCmdList["BLINKHEALTH"]("off")
		end
		return false
	end,
	{
		text = "移动插件",
		callback = function(cfg, v, loading)
			SlashCmdList["BLINKHEALTH"]("move")
		end,
	},
	{
		var = "enableTargetName",
		text = "显示目标名字",
		callback = function(cfg, v, loading)
			if v then
				SlashCmdList["BLINKHEALTH"]("nameon")
			else
				SlashCmdList["BLINKHEALTH"]("nameoff")
			end
		end,
	},
	{
		var = "enableTargetCast",
		text = "显示目标施法条",
		callback = function(cfg, v, loading)
			if v then
				SlashCmdList["BLINKHEALTH"]("caston")
			else
				SlashCmdList["BLINKHEALTH"]("castoff")
			end
		end,
	},
	{
		var = "enableRune",
		text = "显示符文条(死骑可用)",
		callback = function(cfg, v, loading)
			if v then
				SlashCmdList["BLINKHEALTH"]("runeon")
			else
				SlashCmdList["BLINKHEALTH"]("runeoff")
			end
		end,
	},
	{
		var = "enableNumberHit",
		text = "显示数字连击点数(盗贼和德鲁依可用)",
		callback = function(cfg, v, loading)
			if v then
				SlashCmdList["BLINKHEALTH"]("hiton")
			else
				SlashCmdList["BLINKHEALTH"]("hitoff")
			end
		end,
	},
})