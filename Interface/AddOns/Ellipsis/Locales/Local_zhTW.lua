-- yleaf(yaroot@gmail.com)
local L = LibStub("AceLocale-3.0"):NewLocale("Ellipsis", "zhTW")
if not L then return end

L.UpdatingDatabase = '升級到新版本...'

L.Targets = '目標'
L.Prominence = '突出目標'
L.Cooldowns = '冷卻'

L.NoTarget = '無目標'

L.TimeStringSecTenth = '%.1fs'
L.TimeStringSec = '%ds'
L.TimeStringMinSec = '%dm %ds'
L.TimeStringMin = '%dm'
L.TimeStringHour = '%dhr'

L.LeftClickToAnnounce = '左擊通告'
L.RightClickToCancel = '右擊取消計時'
L.ShiftRightClickToBlock = 'Shift右擊屏蔽此技能'
L.CtrlRightClickToDestroyTotem = 'Ctrl右擊摧毀圖騰'

L.DNTWontTrack = 'Ellipsis 不會再追蹤 %s.'
L.CDDNTWontTrack = 'Ellipsis 不會再追蹤 %s 的冷卻.'

L.EllipsisOptionsNotEnabled = '請開啟 Ellipsis_Options 設置 Ellipsis.'

L.NotifyExpiredTimer = '%2$s 的 %1$s 消失了!!'
L.NotifyBrokenTimer = '%2$s 的 %1$s 被打破!'
L.NotifyCDExpiredTimer = '冷卻完成 %s!'

L.TimerAnnounceAoeGhost = '我的 %s 消失了.'
L.TimerAnnounceAoeActive = '我的 %s 將在 %d:%02d 消失.'

L.TimerAnnounceNormalGhost = '我的 %s 從 %s 消失.'
L.TimerAnnounceNormalActive = '我的 %1$s 將在 %3$d:%4$02d 后從 %2$s 消失.'

L.Shocks = '眩暈'
L.Traps = '陷阱'

L.SearchPatternCooldown = '冷卻'
L.SearchPatternRecharge = 'recharge'

L.CDTimerAnnouncePet = "我的寵物冷卻 %s 將在 %d:%02d 后完成."
L.CDTimerAnnounceSpellItem = '我的冷卻 %s 將在 %d:%02d 后完成.'

L.TimeRemaining = '還有: %d:%02d'

L.Potions = '藥水'
L.HealthstonesGems = '生命/法力寶石'
L.Soulstones = '靈魂石'

L.ManaPotion = '治療藥水$'
L.HealingPotion = '法力藥水$'
L.ProtPotion = '防護藥水$'
L.Healthstone = '治療石$'
L.FelBlossom = '^魔獄樹花$'
L.NightmareSeed = '^夢魘種子$'
L.FlameCap = '^火帽花$'
L.Soulstone = '靈魂石$'
L.ManaAgate = '^法力瑪瑙$'
L.ManaJade = '^法力碧玉$'
L.ManaCitrine = '^法力黃水晶$'
L.ManaRuby = '^法力紅寶石$'
L.ManaEmerald = '^法力翡翠$'
L.ManaSapphire = '^法力藍寶石$'
