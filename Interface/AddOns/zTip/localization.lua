if GetLocale() == "zhCN" then
	zTip.locStr = {
		PetLevel	="宠物等级",
		Rare			= "稀有",
		Targeting	= "目标",
		YOU			= ">> 你 <<",
		Self			= "自己",
		NotSpecified	= "未指定",
		Specified	= "神秘物种",
		Talent			= "天赋: ",
		inactiveTalent	= "备用: ",
		TargetedBy		= "关注",
		LocalClassName= {
			["DRUID"]		= 	"德鲁伊";
			["HUNTER"]		= 	"猎人";
			["MAGE"]		= 	"法师";
			["PRIEST"]		= 	"牧师";
			["ROGUE"]		= 	"潜行者";
			["WARLOCK"]		= 	"术士";
			["WARRIOR"]		= 	"战士";
			["SHAMAN"]		= 	"萨满祭司";
			["PALADIN"]		= 	"圣骑士";
			["DEATHKNIGHT"]	= 	"死亡骑士";
			},
		Loading				= "读取中...",
		TooFar				= "距离过远",
		DisableReadTalent	= "观察时停止读取",
		ResetCache			= "天赋缓存已清空",
		ItemLevel 			= "物等",
	}
	if zTipOption then
		zTipOption.locStr = {
			["zTip Options"] = "zTip Options",
			["Positions"] = "锚点位置",
			["Offsets"] = "偏移值（按Enter键生效）",
			["Original Position Offsets"] = "原始位置偏移",
			["Target"] = "目标",
			["Fade"] = "渐隐",
			["PVPName"] = "头衔",
			["Reputation"] = "声望",
			["RealmName"] = "服务器名",
			["IsPlayer"] = "标识(玩家)",
			["ClassIcon"] = "职业图标",
			["VividMask"] = "立体化",
			["ShowTalent"] = "天赋",
			["TargetedBy"] = "关注目标",
			["ManaBAR"] = "法力条",
			["NPCClass"] = "NPC职业",
			["Scale"] = "缩放",
			["FollowCursor"] = "鼠标右下",
			["FollowCursorA"] = "鼠标右下/右下角",
			["RootOnTop"] = "屏幕上方",
			["OnCursorTop"] = "鼠标上方",
			["RightBottom"] = "右下角",
			["OffsetX"] = "水平偏移",
			["OffsetY"] = "垂直偏移",
			["OrigPosX"] = "默认水平偏移",
			["OrigPosY"] = "默认垂直偏移",
			["TalentIcon"] = "天赋图标",
			["CombatHide"] = "BOSS战斗中隐藏",
			["ItemLevel"] = "物品等级",
			["FactionName"] = "隐藏阵营标志",
		}
	end
elseif GetLocale() == "zhTW" then
	zTip.locStr = {
		PetLevel	="寵物等級",
		Rare			= "稀有",
		Targeting	= "目標",
		YOU			= ">> 你 <<",
		Self			= "自己",
		NotSpecified	= "未指定", -- 也許不正確？
		Specified	= "神秘物種",
		Talent			= "天賦: ",
		inactiveTalent	= "備用: ",
		TargetedBy		= "關註",
		LocalClassName= {
			["DRUID"]		= 	"德魯伊";
			["HUNTER"]		= 	"獵人";
			["MAGE"]		= 	"法師";
			["PRIEST"]		= 	"牧師";
			["ROGUE"]		= 	"盜賊";
			["WARLOCK"]		= 	"術士";
			["WARRIOR"]		= 	"戰士";
			["SHAMAN"]		= 	"薩滿";
			["PALADIN"]		= 	"聖騎士";
			["DEATHKNIGHT"]	= 	"死亡騎士";
			},
		Loading				= "讀取中...",
		TooFar				= "距離過遠",
		DisableReadTalent	= "觀察時停止讀取",
		ResetCache			= "天賦緩存已清空",
		ItemLevel 			= "物等",
	}
	if zTipOption then
		zTipOption.locStr = {
			["zTip Options"] = "zTip Options",
			["Positions"] = "錨點設定",
			["Offsets"] = "偏移設定（按Enter鍵生效）",
			["Original Position Offsets"] = "原始偏移設定",
			["Target"] = "目標",
			["Fade"] = "淡出",
			["PVPName"] = "頭銜",
			["Reputation"] = "聲望",
			["RealmName"] = "伺服器名",
			["IsPlayer"] = "標示(玩家)",
			["ClassIcon"] = "職業圖示",
			["VividMask"] = "立體化",
			["ShowTalent"] = "天賦",
			["TargetedBy"] = "關註目標",
			["ManaBAR"] = "法力條/生命條",
			["NPCClass"] = "NPC職業",
			["Scale"] = "縮放",
			["FollowCursor"] = "游標右下",
			["FollowCursorA"] = "游標右下/右下角",
			["RootOnTop"] = "屏幕上方",
			["OnCursorTop"] = "游標正上",
			["RightBottom"] = "右下角",
			["OffsetX"] = "水平偏移",
			["OffsetY"] = "垂直偏移",
			["OrigPosX"] = "原始水平偏移",
			["OrigPosY"] = "原始垂直偏移",
			["TalentIcon"] = "天賦圖標",
			["CombatHide"] = "BOSS戰鬥中隱藏",
			["ItemLevel"] = "物品等級",
			["FactionName"] = "隱藏陣營標誌",
		}
	end
elseif GetLocale() == "koKR" then
	zTip.locStr = {
		Rare			= "희귀",
		Targeting	= "대상 선택",
		YOU			= ">> U <<",
		Self			= "자신",
		NotSpecified	= "Not specified", -- maybe not correct
		Specified	= "Mystery",
		Talent			= "1특성: ",
		inactiveTalent	= "2특성: ",
		TargetedBy		= "목표 선택:",
		LocalClassName= {
			["DRUID"]		= 	"드루이드";
			["HUNTER"]		= 	"사냥꾼";
			["MAGE"]		= 	"마법사";
			["PRIEST"]		= 	"사제";
			["ROGUE"]		= 	"도적";
			["WARLOCK"]		= 	"흑마법사";
			["WARRIOR"]		= 	"전사";
			["SHAMAN"]		= 	"주술사";
			["PALADIN"]		= 	"성기사";
			["DEATHKNIGHT"]	= 	"죽음의 기사";
			},
		Loading				= "불려오는중...",
		TooFar				= "너무 멀리 떨어져 있음",
		DisableReadTalent	= "살펴보는 동안 불려오기 비활성화",
		ResetCache			= "특성 은닉처를 다시 고쳐 놓아라",
	}
	if zTipOption then
		zTipOption.locStr = {
			["zTip Options"] = "zTip Options",
			["Positions"] = "위치",
			["Offsets"] = "간격",
			["Original Position Offsets"] = "원래의 위치 간격",
			["Target"] = "대상",
			["Fade"] = "사라짐",
			["PVPName"] = "PVP 계급",
			["Reputation"] = "평판",
			["RealmName"] = "서버 이름",
			["IsPlayer"] = "마크 (플레이어)",
			["ClassIcon"] = "직업 아이콘",
			["VividMask"] = "선명한 마스크",
			["ShowTalent"] = "특성",
			["TargetedBy"] = "목표 선택",
			["ManaBAR"] = "매직",
			["NPCClass"] = "NPC직업",
			["Scale"] = "크기",
			["FollowCursor"] = "커서 따라가기",
			["RootOnTop"] = "상단 고정",
			["OnCursorTop"] = "커서 상단",
			["RightBottom"] = "우측 하단",
			["OffsetX"] = "X 간격",
			["OffsetY"] = "Y 간격",
			["OrigPosX"] = "원래 X 위치 간격",
			["OrigPosY"] = "원래 Y 위치 간격",
		}
	end
else
	zTip.locStr = {
		PetLevel	="Petlevel",
		Rare			= "Rare",
		Targeting	= "Targeting",
		YOU			= ">> U <<",
		Self			= "Self",
		NotSpecified	= "Not specified", -- maybe not correct
		Specified	= "Mystery",
		Talent			= "Talent: ",
		inactiveTalent	= "Inactive: ",
		TargetedBy		= "TargetedBy",
		LocalClassName= {
			["DRUID"]		= 	"Druid";
			["HUNTER"]		= 	"Hunter";
			["MAGE"]		= 	"Mage";
			["PRIEST"]		= 	"Priest";
			["ROGUE"]		= 	"Rogue";
			["WARLOCK"]		= 	"Warlock";
			["WARRIOR"]		= 	"Warrior";
			["SHAMAN"]		= 	"Shaman";
			["PALADIN"]		= 	"Paladin";
			["DEATHKNIGHT"]	= 	"DeathKnight";
			},
		Loading				= "Loading...",
		TooFar				= "Too far",
		DisableReadTalent	= "Disable loading while inspecting",
		ResetCache			= "Reset talent cache",
	}
	if zTipOption then
		zTipOption.locStr = {
			["zTip Options"] = "zTip Options",
			["Positions"] = "Positions",
			["Offsets"] = "Offsets(ENTER to apply)",
			["Original Position Offsets"] = "Original Position Offsets",
			["Target"] = "Target",
			["Fade"] = "Fade",
			["PVPName"] = "PVPName",
			["Reputation"] = "Reputation",
			["RealmName"] = "RealmName",
			["IsPlayer"] = "Mark(Player)",
			["ClassIcon"] = "ClassIcon",
			["VividMask"] = "VividMask",
			["ShowTalent"] = "ShowTalent",
			["TargetedBy"] = "TargetedBy",
			["ManaBAR"] = "Mana Bar",
			["NPCClass"] = "NPC Class",
			["Scale"] = "Scale",
			["FollowCursor"] = "FollowCursor",
			["RootOnTop"] = "RootOnTop",
			["OnCursorTop"] = "OnCursorTop",
			["RightBottom"] = "RightBottom",
			["OffsetX"] = "OffsetX",
			["OffsetY"] = "OffsetY",
			["OrigPosX"] = "OrigPosX",
			["OrigPosY"] = "OrigPosY",
		}
	end
end
