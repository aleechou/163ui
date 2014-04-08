--/run for _, v in pairs(GridClickSets_DefaultSets) do for _, v2 in pairs(v) do for _, v3 in next, v2 do if not GetSpellInfo(v3) then print(v3, GetSpellInfo(v3)) end end end end
GRID_CLICK_SETS_BUTTONS = 5 --max buttons, another 2 more for wheel up & wheel down

local function gn(spellId)
	--return select(1, GetSpellInfo(spellId))
	return spellId;
end

GridClickSets_DefaultSets = {
	PRIEST = {
		["1"] = {
			["shift-"]	= gn(139),--"恢復",
			["ctrl-"]	= gn(527),--"驅散魔法",
			["alt-"]	= gn(2061),--"快速治療",
			["alt-ctrl-"]	= gn(2006),--"復活術",
		},
		["2"] = {
			[""]		= gn(17),--"真言術:盾",
			["shift-"]	= gn(2050),--"治疗术",
			["ctrl-"]	= gn(528),--"驅除疾病", 
			["alt-"]	= gn(2060),--"強效治療術",
			["alt-ctrl-"]	= gn(32546),--"束縛治療",
		},
		["3"] = {
			[""]		= gn(34861),--"治療之環",
			["shift-"]	= gn(33076),--"癒合禱言",
			["alt-"]	= gn(1706),--"漂浮术",
            ["ctrl-"]   = gn(88684),
			["alt-ctrl-"]	= gn(21562),--"真言术.韧",
		},
	},
	
	DRUID = {
		["1"] = {
			["shift-"]	= gn(774),--"回春術",
			["ctrl-"]	= gn(2782),--"解除詛咒,毒",
			["alt-"]	= gn(8936),--"癒合",
			["alt-ctrl-"]	= gn(50769),--"復活",
		},
		["2"] = {
			[""]		= gn(48438),--"野性痊癒",
			["shift-"]	= gn(18562),--"迅捷治愈",
			["ctrl-"]	= gn(88423),--"自然治愈",
			["alt-"]	= gn(50464),--"滋補術",
		},
		["3"] = {
			[""]		= gn(33763),--"生命之花",
			["alt-ctrl-"]	= gn(1126),--"野性印记",
		},
	},

	SHAMAN = { 
		["1"] = {
			["alt-"]	= gn(1064),--"治疗链",
			["shift-"]	= gn(331),--"治疗波",
			["ctrl-"]	= gn(974),--"大地之盾",
			["alt-ctrl-"]	= gn(2008),--"先祖之魂",
		},
		["2"] = {
			[""]		= gn(61295),--"激流",
			["alt-"]	= gn(8004),--"次级治疗波",
			["shift-"]	= gn(77472),--"次级治疗波",
			["ctrl-"]	= gn(51886),--"净化灵魂",
		},
		["3"] = {
			[""]		= gn(1064),--"治疗链",
            ["ctrl-"]	= gn(73680),--"元素释放",
			["alt-"]	= gn(546),--"水上行走",
			["shift-"]	= gn(131),--"水下呼吸",
		},
	},

	PALADIN = {
		["1"] = {
			["shift-"]	= gn(635),--"聖光術",
			["alt-"]	= gn(19750),--"聖光閃現",
			["ctrl-"]	= gn(53563),--"圣光信标",
			["alt-ctrl-"]	= gn(7328),--"救贖",
		},
		["2"] = {
			[""]		= gn(20473),--"神聖震擊",
			["shift-"]	= gn(82326),--"Divine Light",
			["ctrl-"]	= gn(4987),--"淨化術",
			["alt-"]	= gn(85673),--"Word of Glory",
			["alt-ctrl-"]	= gn(633),--"聖療術",
		},
		["3"] = {
			[""]		= gn(31789),--正義防護
			["alt-"]	= gn(20217),--王者
			["shift-"]	= gn(20911),--庇護
			["ctrl-"]	= gn(19740),--力量
		},
	},

	WARRIOR = {
		["1"] = {
			["ctrl-"]	= gn(50720),--"戒備守護",
		},
		["2"] = {
			[""]		= gn(3411),--"阻擾",
		},
	},

	MAGE = {
		["1"] = {
			["shift-"]	= gn(1459),--"秘法智力",
			["alt-"]	= gn(1459),--"秘法智力",
			["ctrl-"]	= gn(54646),--"秘法专注",
		},
		["2"] = {
			[""]		= gn(475),--"解除詛咒",
			["ctrl-"]	= gn(475),--"解除詛咒",
			["alt-"]	= gn(475),--"解除詛咒",
			["shift-"]	= gn(475),--"解除詛咒",
		},
		["3"] = {
			["alt-"]	= gn(130),--"缓落术",
		},
	},

	WARLOCK = {
		["1"] = {
			["ctrl-"]	= gn(80398),--"Dark Indent",
			["alt-"]	= gn(80398),--"Dark Indent",
			["shift-"]	= gn(80398),--"Dark Indent",
		},
		["2"] = {
			[""]		= gn(5697),--"魔息術",
			["ctrl-"]	= gn(5697),--"魔息術",
			["alt-"]	= gn(5697),--"魔息術",
			["shift-"]	= gn(5697),--"魔息術",
		},
	},

	HUNTER = {
		["2"] = {
			[""]		= gn(34477),--"誤導",
		},
	},
	
	ROGUE = {
		["2"] = {
			[""]		= gn(57933),--"偷天換日",
		},
	},

	DEATHKNIGHT = {
		["1"] = {
			["ctrl-"]	= gn(61999),--"复活盟友",
			["alt-"]	= gn(61999),--"复活盟友",
			["shift-"]	= gn(61999),--"复活盟友",
		},
		["2"] = {
			[""]		= gn(47541),--"死亡缠绕",
		},
	},
}

GridClickSets_SpellList = {
	PRIEST = {
		(2050),--"治療術",
		(2061),--"快速治療",
		(2060),--"強效治療術",
		(139),--"恢復",
		(17),--"真言術:盾",
		(32546),--"束縛治療",
		(2006),--"復活術",
		(527),--"驅散魔法",
		(528),--"祛病術",
		(21562),--"真言術:韌",
		(27683),--暗影防护
		(596),--治疗祷言
		(34861),--"治療之環",
		(33076),--"癒合禱言",
		(47540),--"懺悟",
		(47788),--神圣之灵
		(6346),--"防護恐懼結界",
		(1706),--漂浮术
		(73325),--Leap of Faith
		(33206),--痛苦压制
		(10060),--能量灌注
		(62618),--真言术.壁
        (88684),--圣言术：静
	},
	DRUID = {
		(5185),--"治療之觸",
		(50464),--"滋補術",
		(774),--"回春術",
		(8936),--"癒合",
		(33763),--"生命之花",
		(50769),--"復活",
		(48438),--"野性痊癒",
		(18562),--"迅捷治愈",
		(88423),--"自然治愈",
		(2782),--"解除詛咒,毒",
		(20484),--"復生",
		(1126),--"野性印記", 
		(29166),--激活
		(467),--荆棘术
		(94447),--生命之花
	},
	SHAMAN = { 
		(331),--"治疗波",
		(8004),--"次级治疗波",
		(77472),--"強效治療波",
		(1064),--"治疗链",
        (73680), --"元素释放",
		(974),--"大地之盾",
		(2008),--"先祖之魂",
		(61295),--"激流",
		(51886),--"净化灵魂",
		(546),--"水上行走",
		(131),--"水下呼吸",
	},
	PALADIN = {
		(635),--"聖光術",
		(19750),--"聖光閃現",
		(82326),--"Divine Light",
		(53563),--"圣光信标",
		(20473),--"神聖震擊",
		(4987),--"淨化術",
		(633),--"聖療術",
		(7328),--"救贖",
		(19740),--"力量祝福",
		(20911),--"庇护祝福",
		(20217),--"王者祝福",
		--(19752),--"干涉",
		(31789),--"正义防护",
		(1038),--"拯救之手",
		(1044),--"自由之手",
		(1022),--"保护之手",
		(85673),--"Word of Glory",
        (82327),--"圣光普照"
	},
	WARRIOR = {
		(50720),--"戒備守護",
		(3411),--"阻擾",
	},

	MAGE = {
		(1459),--"秘法智力",
		(475),--"解除詛咒",
		(54646),--"秘法专注",
		(130),--"缓落术",
	},
	WARLOCK = {
		(5697),--"魔息術",
		(80398),--"Dark Indent",
	},
	HUNTER = {
		(34477),--"誤導",
	},
	ROGUE = {
		(57933),--"偷天換日",
	},
	DEATHKNIGHT = {
		(47541),--"死亡缠绕",
		(61999),--"复活盟友",
	},
}

if GetLocale() == "zhCN" then
GridClickSets_Titles = {
	"直接点击 :",
	"Ctrl 点击 :",
	"Alt  点击 :",
	"Shift 点击 :",
	"Ctrl + Alt :",
	"Ctrl + Shift :",
	"Shift + Alt :",
	"C + S + A :",
}
else
GridClickSets_Titles = {
	"Direct  Click :",
	"Ctrl +  Click :",
	"Alt  +  Click :",
	"Shift + Click :",
	"Ctrl + Alt :",
	"Ctrl + Shift :",
	"Shift + Alt :",
	"C + S + A :",
}
end

GridClickSets_Modifiers = {
	"",
	"ctrl-",
	"alt-",
	"shift-",
	"alt-ctrl-",
	"ctrl-shift-",
	"alt-shift-",
	"alt-ctrl-shift-",
}

--[[ set format
GridClickSets_Set = {
	["1"] = {
		["shift-"] = { type = "spellId:1001" },
		["ctrl-"] = { type = "TARGET" },
	},
	["3"] = {
		["shift-"] = { type = "SPELL", arg = "治疗波" },
		["shift-"] = { type = "MACRO", arg = "/target ##\n/cast [target=##]治疗波" },
	}
}
]]

--for check deleted spells
function GridClickSets_Check()
	for clz, set in pairs(GridClickSets_SpellList) do
		for _, spellId in pairs(set) do
			if not GetSpellInfo(spellId) then ChatFrame1:AddMessage(spellId); end
		end
	end	
end

function GridClickSets_ConvertDefault(set) 
	if not set then return {} end

	local modi, v
	local conv = {}

	for modi, v in pairs(set) do
		if type(v) == "number" then
			conv[modi] = { type = "spellId:"..v };
		else
			conv[modi] = { type = v.type, arg = v.arg };
		end
	end
	return conv;
end

function GridClickSets_GetBtnDefaultSet(btn)
	local _, c = UnitClass("player")
	if GridClickSets_DefaultSets[c] then
		return GridClickSets_ConvertDefault(GridClickSets_DefaultSets[c][tostring(btn)])
	else
		return {}
	end
end

function GridClickSets_GetDefault()
	local set = {}
	for i=1,5 do
		set[tostring(i)] = GridClickSets_GetBtnDefaultSet(i)
	end
	return set
end

local secureHeader = CreateFrame("Frame", nil, UIParent, "SecureHandlerBaseTemplate")

function GridClickSets_SetAttributes(frame, set)
	set = set or GridClickSets_GetDefault()

	for i=1,GRID_CLICK_SETS_BUTTONS do
		local btn = set[tostring(i)] or {};
		for j=1,8 do
			local modi = GridClickSets_Modifiers[j]
			local set = btn[modi] or {}

			GridClickSets_SetAttribute(frame, i, modi, set.type, set.arg)
		end
	end

	-- for wheel up/down bindings (new on 11.02.22)
	local binded = 0
	local script = "self:ClearBindings()";
	for i=1,2 do
		local btn = set[tostring(GRID_CLICK_SETS_BUTTONS+i)] or {};
		for j=1,8 do
			local modi = GridClickSets_Modifiers[j]
			local set = btn[modi]
			if(set) then 
				binded = binded + 1
				script = script.."self:SetBindingClick(1, \""..modi..(i==1 and "MOUSEWHEELUP" or "MOUSEWHEELDOWN").."\", self, \"Button"..(GRID_CLICK_SETS_BUTTONS+binded).."\")"
				GridClickSets_SetAttribute(frame, GRID_CLICK_SETS_BUTTONS+binded, "", set.type, set.arg)
			end
		end
	end

	secureHeader:UnwrapScript(frame, "OnEnter")
	secureHeader:WrapScript(frame, "OnEnter", script);
	secureHeader:UnwrapScript(frame, "OnLeave")
	secureHeader:WrapScript(frame, "OnLeave", "self:ClearBindings()");
end

function GridClickSets_SetAttribute(frame, button, modi, type, arg)
	--if InCombatLockdown() then return end

	if(type==nil or type=="NONE") then
		frame:SetAttribute(modi.."type"..button, nil)
		frame:SetAttribute(modi.."macrotext"..button, nil)
		frame:SetAttribute(modi.."spell"..button, nil)
		return
	elseif strsub(type, 1, 8) == "spellId:" then
		frame:SetAttribute(modi.."type"..button, "spell")
		frame:SetAttribute(modi.."spell"..button, select(1, GetSpellInfo(strsub(type, 9))))
		return
	end

	frame:SetAttribute(modi.."type"..button, type)
	if type == "spell" then
		frame:SetAttribute(modi.."spell"..button, arg)
	elseif type == "macro" then
		local unit = SecureButton_GetModifiedUnit(frame, modi.."unit"..button)
		if unit and arg then
			arg = string.gsub(arg, "##", unit)
		else
			arg = arg and string.gsub(arg, "##", "@mouseover")
		end
		frame:SetAttribute(modi.."macrotext"..button, arg)
	end
end