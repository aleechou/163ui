UI163_USER_MODE = 1 --这句必须写一次，影响一些默认值。单体版控制台已经写过了
local _, engClass = UnitClass("player")
U1RegisterAddon("BlinkHealthText", {
    title = "多玩简易状态",
    defaultEnable = 0,
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
		visible = (engClass == "DEATHKNIGHT"),
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
		visible = (engClass == "ROGUE" or engClass == "DRUID"),
		callback = function(cfg, v, loading)
			if v then
				SlashCmdList["BLINKHEALTH"]("hiton")
			else
				SlashCmdList["BLINKHEALTH"]("hitoff")
			end
		end,
	},
})

U1RegisterAddon("DailyTamerCheck", {
    title = "宠物日常检测",
    defaultEnable = 0,
    tags = {TAG_MAPQUEST},
    desc = "检测宠物日常任务完成情况，配合TomTom插件，可以设置各个任务的路径点。`快捷命令：/dtc 或 /dtcheck",
	nopic = 1,
    icon = "Interface\\ICONS\\INV_MISC_PETMOONKINTA",
	{
		text="设置相关选项",
		type = "text",
		{
			var = "show_npcicons",
			text = "显示宠物类型图标",
			default = false,
			getvalue=function() 
				return GetOptionValue("show_npcicons") 
			end,
			callback = function(cfg, v, loading)
				RefreshOption(cfg.var, 3, v)
			end,
		},
		{
			var = "show_coordinates",
			text = "显示任务坐标",
			getvalue=function() 
				return GetOptionValue("show_coordinates") 
			end,
			callback = function(cfg, v, loading)
				RefreshOption(cfg.var, 0, v)
			end,
		},
		{
			var = "show_npcnames",
			text = "显示NPC名字",
			default = false,
			getvalue=function() 
				return GetOptionValue("show_npcnames") 
			end,
			callback = function(cfg, v, loading)
				RefreshOption(cfg.var, 1, v)
			end,
		},
		{
			var = "show_npclevel",
			text = "显示宠物等级",
			default = false,
			getvalue=function() 
				return GetOptionValue("show_npclevel") 
			end,
			callback = function(cfg, v, loading)
				RefreshOption(cfg.var, 2, v)
			end,
		},
		{
			var = "show_mapicons",
			text = "显示世界地图图标",
			default = false,
			getvalue=function() 
				return GetOptionValue("show_mapicons") 
			end,
			callback = function(cfg, v, loading)
				RefreshOption(cfg.var, 4, v)
			end,
		},
		{
			var = "show_faction",
			text = "显示对立阵营任务",
			default = true,
			getvalue=function() 
				return GetOptionValue("show_faction") 
			end,
			callback = function(cfg, v, loading)
				RefreshOption(cfg.var, 5, v)
			end,
		},
	},
})

U1RegisterAddon("YOBUFF", {
    title = "YOBUFF",
    defaultEnable = 0,
    tags = {"MANAGEMENT"},
    icon = "Interface\\Icons\\Spell_ChargeNegative",
    nopic = 1,
	{
		text = "配置插件",
		callback = function()
			SlashCmdList["YOBUFF"]()
		end,
	},
})