-- author: callmejames @《凤凰之翼》 一区藏宝海湾
-- commit by: yaroot <yaroot AT gmail.com>


if GetLocale() ~= "zhCN" then return end

local L

----------------------------
--  The Obsidian Sanctum  --
----------------------------
--  Shadron  --
---------------
L = DBM:GetModLocalization("Shadron")

L:SetGeneralLocalization({
	name = "沙德隆"
})

----------------
--  Tenebron  --
----------------
L = DBM:GetModLocalization("Tenebron")

L:SetGeneralLocalization({
	name = "塔尼布隆"
})

----------------
--  Vesperon  --
----------------
L = DBM:GetModLocalization("Vesperon")

L:SetGeneralLocalization({
	name = "维斯匹隆"
})

------------------
--  Sartharion  --
------------------
L = DBM:GetModLocalization("Sartharion")

L:SetGeneralLocalization({
	name = "萨塔里奥"
})

L:SetWarningLocalization({
	WarningTenebron	        = "塔尼布隆到来",
	WarningShadron	        = "沙德隆到来",
	WarningVesperon	        = "维斯匹隆到来",
	WarningFireWall	        = "烈焰之啸",
	WarningVesperonPortal	= "维斯匹隆的传送门",
	WarningTenebronPortal	= "塔尼布隆的传送门",
	WarningShadronPortal    = "沙德隆的传送门"
})

L:SetTimerLocalization({
	TimerTenebron	= "塔尼布隆到来",
	TimerShadron	= "沙德隆到来",
	TimerVesperon	= "维斯匹隆到来"
})

L:SetOptionLocalization({
	AnnounceFails           = "公布踩中暗影裂隙和撞上烈焰之啸的玩家到团队频道 (需要团长或助理权限)",
	TimerTenebron           = "为塔尼布隆到来显示计时条",
	TimerShadron            = "为沙德隆到来显示计时条",
	TimerVesperon           = "为维斯匹隆到来显示计时条",
	WarningFireWall         = "为烈焰之啸显示特别警报",
	WarningTenebron         = "提示塔尼布隆到来",
	WarningShadron          = "提示沙德隆到来",
	WarningVesperon         = "提示维斯匹隆到来",
	WarningTenebronPortal	= "为塔尼布隆的传送门显示特别警报",
	WarningShadronPortal	= "为沙德隆的传送门显示特别警报",
	WarningVesperonPortal	= "为维斯匹隆的传送门显示特别警报"
})

L:SetMiscLocalization({
	Wall			= "%s周围的岩浆沸腾了起来！",
	Portal			= "%s开始开启暮光传送门!",
	NameTenebron		= "塔尼布隆",
	NameShadron		= "沙德隆",
	NameVesperon		= "维斯匹隆",
	FireWallOn		= "烈焰之啸: %s",
	VoidZoneOn		= "暗影裂隙: %s",
	VoidZones		= "踩中暗影裂隙 (这一次): %s",
	FireWalls		= "撞上烈焰之啸 (这一次): %s"
})

------------------------
--  The Ruby Sanctum  --
------------------------
--  Baltharus the Warborn  --
-----------------------------
L = DBM:GetModLocalization("Baltharus")

L:SetGeneralLocalization({
	name = "战争之子巴尔萨鲁斯"
})

L:SetWarningLocalization({
	WarningSplitSoon	= "分裂 即将到来"
})

L:SetOptionLocalization({
	WarningSplitSoon	= "为分裂显示预先警告",
	RangeFrame		= "显示距离框(12码)",
	SetIconOnBrand		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74505)
})

-------------------------
--  Saviana Ragefire  --
-------------------------
L = DBM:GetModLocalization("Saviana")

L:SetGeneralLocalization({
	name = "塞维娅娜·怒火"
})

L:SetOptionLocalization({
	RangeFrame		= "显示距离框(10码)",
	BeaconIcon				= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(74453)
})

--------------------------
--  General Zarithrian  --
--------------------------
L = DBM:GetModLocalization("Zarithrian")

L:SetGeneralLocalization({
	name = "萨瑞瑟里安将军"
})

L:SetWarningLocalization({
	WarnAdds	= "新的小怪",
	warnCleaveArmor		= "%s 于 >%s< (%s)"	-- Cleave Armor on >args.destName< (args.amount)
})

L:SetTimerLocalization({
	TimerAdds		= "新的小怪"
})

L:SetOptionLocalization({
	WarnAdds		= "提示新的小怪",
	TimerAdds		= "为新的小怪显示定时器",
	warnCleaveArmor	= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell:format(74367)
})

L:SetMiscLocalization({
	SummonMinions		= "让他们化为灰烬，仆从们！"
})

-------------------------------------
--  Halion the Twilight Destroyer  --
-------------------------------------
L = DBM:GetModLocalization("Halion")

L:SetGeneralLocalization({
	name = "海里昂"
})

L:SetWarningLocalization({
	TwilightCutterCast	= "施放暮光撕裂射线: 3秒后"
})

L:SetOptionLocalization({
	TwilightCutterCast	= "当$spell:77844开始施放时显示警告",
	AnnounceAlternatePhase	= "显示你不在的另一个领域内的技能报警和计时",
	SoundOnConsumption	= "为$spell:74562或$spell:74792播放音效",--We use localized text for these functions
	SetIconOnConsumption	= "为中了$spell:74562或$spell:74792的目标设置标记",--So we can use single functions for both versions of spell.
	WhisperOnConsumption	= "悄悄话提示$spell:74562或$spell:74792的目标(需要团长权限)"
})

L:SetMiscLocalization({
	Halion				= "海里昂",
	MeteorCast		= "天空在燃烧！",
	Phase2			= "暮光的世界将会让你痛不欲生！够胆量的就进来吧！",
	Phase3			= "我就是交织的光影！凡人，在死亡之翼的使者面前颤抖吧！",
	twilightcutter		= "黑暗能量正在这颗旋转的魔球中脉动！",
	WhisperCombustion		= "你中了炽焰燃烧！快跑墙边！",
	WhisperConsumption		= "你中了灵魂吞噬！快跑墙边！",
	Kill			= "享受胜利吧，凡人们，这是你们最后的胜利。回归的主人将烧毁这个世界！"
})
