-- yleaf(yaroot@gmail.com)
local L = LibStub("AceLocale-3.0"):NewLocale("Ellipsis_Options", "zhCN")
if not L then return end

local mustShow = '必须显示目标:\n |cff67b1e9N没有目标|r - AOE时\n |cff67b1e9玩家|r - 如果追踪\n |cff67b1e9宠物|r - 如果追踪'

L.Lock = '锁定'
L.LockDesc = '锁定Ellipsis并隐藏的|cff67b1e9目标|r和|cff67b1e9醒目目标|r.'

L.SampleTimers = '测试'
L.SampleTimersDesc = '创建一些计时器以测试设置效果.\n\n按下后会重置计时器, 按住Shift键会清除这些测试计时器.'
L.SampleTarget = '测试目标 %d'
L.SampleTimer = '测试计时 %d'

-- Display (Base)
L.Display = '显示设置'
L.DisplayDesc = '设置基础显示模式.'

L.Tooltips = '提示'
L.TooltipsDesc = '鼠标移到计时器上显示提示.'

L.Clickable = '可点击计时器'
L.ClickableDesc = '开启计时器的点击通告/屏蔽等功能.'

L.AuraAlpha = '透明度 - 光环'
L.AuraAlphaDesc = '设置透明度.'

L.AuraScale = '缩放 - 光环'
L.AuraScaleDesc = '设置缩放.'

L.AuraWidth = '宽度 - 光环'
L.AuraWidthDesc = '设置计时器的宽度(单位:像素).'

L.CDAlpha = '透明度 - 冷却'
L.CDAlphaDesc = '设置冷却条的透明度.'

L.CDScale = '缩放 - 冷却'
L.CDScaleDesc = '设置冷却计时的缩放.'

-- Display (Targets 1)
L.DisplayTarget1 = '光环设置 1'
L.DisplayTargetDesc = '设置目标光环计时.'

L.ConfigTargetDisplay = '设置目标显示'
L.ConfigTargetDisplayDesc = "设置除了必须显示的目标以外的计时器显示目标, 将会永远显示光环计时. \n\n前4个设置中目标和焦点只在显示时拥有高优先级, 后3个设置中, 除了你的设置显示的目标外没有目标会被显示.\n\n所有 (无优先)\n只按照目标排列计时器.\n\n所有 (目标优先)\n你的目标将显示在第一个\n\n所有 (焦点优先)\n你的焦点将显示在第一个\n\n所有 (所有优先)\n目标将会显示在焦点下面.\n\n仅限目标(如果存在)\n只显示目标\n\n仅限焦点(如果存在)\n只显示焦点\n\n目标和焦点\n只显示目标和焦点的计时." .. mustShow

L.ConfigTargetDisplayAll = '所有 (无优先)'
L.ConfigTargetDisplayAllBoth = '所有 (所有优先)'
L.ConfigTargetDisplayAllFocus = '所有 (焦点优先)'
L.ConfigTargetDisplayAllTarget = '所有 (目标优先)'
L.ConfigTargetDisplayBoth = '目标和焦点'
L.ConfigTargetDisplayFocus = '仅限焦点'
L.ConfigTargetDisplayTarget = '仅限目标'

L.ShowNumTargets = '最大目标数'
L.ShowNumTargetsDesc = "设置最大显示的目标数量 (除了必须显示的目标外).\n\n如果选择了只显示目标/焦点, 这个设置会自动失效.\n\n" .. mustShow

L.TargetFont = '字体'
L.TargetFontDesc = '设置字体.'

L.TargetFontHeight = '字体大小'
L.TargetFontHeightDesc = '设置字体大小.'

L.TargetPadding = '间隔'
L.TargetPaddingDesc = '设置间隔.'

L.GrowTargets = '增长方向'
L.GrowTargetsDesc = '设置增长方向.'

L.GrowUP = '上'
L.GrowDOWN = '下'
L.GrowLEFT = '左'
L.GrowRIGHT = '右'

-- Display (Targets 2)
L.DisplayTarget2 = '光环设置 2'

L.ShowLevel = '显示等级'
L.ShowLevelDesc = '计时器怪物名字旁显示怪物等级.'

L.ShowClassColours = '显示职业颜色'
L.ShowClassColoursDesc = '怪物名字显示职业颜色.'

L.ShowRaidIcons = '显示团队标记'
L.ShowRaidIconsDesc = '计时器关务名字上显示团队标记.'

L.ProminentTargetsHeader = '醒目目标计时器'
L.ProminentTargetsDesc = '这些目标将会显示在|cff67b1e9醒目计时器|r下, 而不是|cff67b1e9普通计时器|r.'

L.ProminentItemsDesc = '标记这个目标为醒目目标, 此目标计时将会显示在|cff67b1e9醒目计时器|r下.'

L.ProminentNoTarget = '没有目标(AoE)'
L.ProminentPlayer = '玩家'
L.ProminentPet = '宠物'

-- Display (Timers 1)
L.DisplayTimer1 = '计时器设置 1'
L.DisplayTimerDesc = '设置计时器选项.'

L.SortTimerMethod = '排序计时器'
L.SortTimerMethodDesc = '设置如何排序.'
L.SortTimerMethod1 = '字母 (正)'
L.SortTimerMethod2 = '字母 (逆)'
L.SortTimerMethod3 = '剩余时间 (正)'
L.SortTimerMethod4 = '剩余时间 (逆)'
L.SortTimerMethod5 = '不排序'

L.TimerFormat = '时间显示格式'
L.TimerFormatDesc = '设置如何显示时间.\n\n例: 3个不同的值会被用于分钟/秒/10秒以下(可选)的显示样式.\n\n## - 1:09   |   9   |   9.4\n\n0:## - 1:09   |   0:09   |   0:09.4\n\n##s - 1m 9s   |   9s   |   9.4s\n\n##s abbv - 1m   |   9s   |   9.4s'
L.TimerFormat1 = '##'
L.TimerFormat2 = '0:##'
L.TimerFormat3 = '##s'
L.TimerFormat4 = '##s abbv'

L.ShowTenths = '显示10秒以下样式'
L.ShowTenthsDesc = '设置是否在一个计时在10秒内时使用特殊的格式来显示.'

L.Mode = '显示样式'
L.ModeDesc = '设置怎样显示计时器\n\n计时条模式将显示一个有着法术名字,图标和剩余时间的计时条.\n\n图标模式将显示一个只有剩余时间的法术图标.'
L.ModeBars = '计时条'
L.ModeIcons = '图标'

L.GrowTimers = '增长方向'
L.GrowTimersDesc = '设置计时器增长方向.'

L.GhostShow = '魔鬼计时'
L.GhostShowDesc = '是否显示魔鬼计时. 如果选中将会在一个法术结束以后继续显示该法术图标, 这会提示你这个法术已经失效..'

L.GhostDuration = '魔鬼计时器持续时间'
L.GhostDurationDesc = '设置显示魔鬼计时器的时间(秒).'

-- Display (Timers 2)
L.DisplayTimer2 = '计时器设置 2'

L.BarHeight = '计时条高度'
L.BarHeightDesc = "设置计时条的高度(计时条模式)."

L.IconHeight = '图标高度'
L.IconHeightDesc = "设置图标的高度(图标模式).\n\n因为图标是正方形, 所以宽度也将是这个值."

L.TimerPadding = '计时条间隔'
L.TimerPaddingDesc = '设置计时条之间的间隔.'

L.Texture = '计时条材质'
L.TextureDesc = "设置计时条的材质."

L.TimerFont = '字体'
L.TimerFontDesc = "设置所有文字所使用的字体."

L.TimerFontHeight = '字体大小'
L.TimerFontHeightDesc = '设置字体大小.'

L.ShowStackInName = '在法术名字上显示堆叠'
L.ShowStackInNameDesc = "将堆叠 (例如: 生命绽放) 显示在法术名字上\n\n如果你使用图标模式并激活了这个设置, 你将不会看到堆叠."

-- Display (Cooldowns 1)
L.DisplayCooldown1 = '冷却计时 1'
L.DisplayCooldownDesc = '设置冷却计时.'

L.CDHorizontal = '横向'
L.CDHorizontalDesc = '勾选将横向显示, 反之则纵向.'

L.CDHideWhenNone = '不计时时隐藏'
L.CDHideWhenNoneDesc = '选中后将在没法术冷却显示时隐藏.'

L.CDLength = '计时条长度'
L.CDLengthDesc = '设置冷却计时条的长度.\n\n纵向显示时为高度.'

L.CDThickness = '计时条高度'
L.CDThicknessDesc = '设置冷却计时条的高度.\n\n纵向显示时为宽度.'

L.CDTimeDetail = '详细时间刻度'
L.CDTimeDetailDesc = '设置显示在计时条上的详细的时间刻度.'

L.CDMaxTimeDisplay = '刻度最大时间'
L.CDMaxTimeDisplayDesc = '设置在冷却条刻度上显示的最大时间(单位为秒).\n\n任何较长时间的冷却将会一直在计时条右侧停留, 直到他们的冷却时间低于这个值.'

L.CDFontHeight = '刻度字体大小'
L.CDFontHeightDesc = '设置刻度字体的大小.'

-- Display (Cooldowns 2)
L.DisplayCooldown2 = '冷却计时 2'

L.CDTexture = '计时条材质'
L.CDTextureDesc = '设置计时条材质.'

L.CDShowOffsetTags = '显示偏移标签'
L.CDShowOffsetTagsDesc = '如果一个图标距离计时条过远, 将会显示一个标签来链接其和计时条.'

L.CDOffset1 = '偏移: 法术'
L.CDOffset1Desc = '设置法术冷却的偏移.\n\n大于0: 会将计时器置于上方/右方.\n\n小于0: 会将计时器置于下面/左边.'

L.CDOffset3 = '偏移: 物品'
L.CDOffset3Desc = '设置物品冷却的偏移.\n\n大于0: 会将计时器置于上方/右方.\n\n小于0: 会将计时器置于下面/左边.'

L.CDOffset2 = '偏移: 宠物'
L.CDOffset2Desc = '设置宠物冷却的偏移.\n\n大于0: 会将计时器置于上方/右方.\n\n小于0: 会将计时器置于下面/左边.'

-- Display (Colours)
L.DisplayColours = '颜色'
L.DisplayColoursDesc = '设置颜色.'

L.ColourTimerDesc = '光环颜色:'

L.ColourBackground = '计时器背景'
L.ColourBackgroundDesc = '设置计时器背景颜色.\n\n可以独立设置透明度.'

L.ColourGhost = '魔鬼计时器'
L.ColourGhostDesc = '设置魔鬼计时器的颜色.'

L.ColourTargetText = '目标监视器'
L.ColourTargetTextDesc = '设置目标监视器的颜色.'

L.ColourTimerText = '计时器文字'
L.ColourTimerTextDesc = '设置计时器文字颜色(法术名字/剩余时间).'

L.ColourCDDesc = '冷却颜色:'

L.ColourCDBar = '主计时器'
L.ColourCDBarDesc = '设置主计时器颜色.\n\n可以独立设置透明度.'

L.ColourCDBorder = '计时条边框'
L.ColourCDBorderDesc = "设置计时条边框颜色.\n\n可以独立设置透明度."

L.ColourCDBackdrop = '计时条背景'
L.ColourCDBackdropDesc = "设置计时条背景颜色. (计时条透明时可见.)\n\n可以独立设置透明度."

L.ColourCDText = '时间刻度文字'
L.ColourCDTextDesc = "设置刻度文字颜色."

L.ColourCD1 = '偏移标签: 法术'
L.ColourCD1Desc = '设置法术偏移表情颜色.\n\n只在显示偏移标签时有效.'

L.ColourCD3 = '偏移标签: 物品'
L.ColourCD3Desc = '设置物品偏移表情颜色.\n\n只在显示偏移标签时有效.'

L.ColourCD2 = '偏移标签: 宠物'
L.ColourCD2Desc = '设置宠物偏移表情颜色.\n\n只在显示偏移标签时有效.'

-- Aura Tracking
L.AuraTracking = '光环监视'
L.AuraTrackingDesc = '设置光环监视.'

L.TrackBuffs = '监视Buff'
L.TrackBuffsDesc = '监视你施放的Buff.'

L.TrackDebuffs = '监视Debuff'
L.TrackDebuffsDesc = '监视你释放的Debuff.'

L.TrackPlayer = '监视自身Buff'
L.TrackPlayerDesc = '监视你对自己施放的Buff.'

L.TrackPet = '监视宠物Buff'
L.TrackPetDesc = '监视你对你宠物施放的Buff.'

L.MinAuraDuration = '最小光环持续时间'
L.MinAuraDurationDesc = '设置被Ellipsis追踪的最小的持续时间(秒).'

L.MaxAuraDuration = '最大光环持续时间'
L.MaxAuraDurationDesc = '设置Ellipsis监视的最大的持续时间(分钟).\n\n设置为0将监视所有.'

L.DNTAdd = "增加到忽略列表"
L.DNTAddDesc = 'Ellipsis将不会监视在此列表中的法术.'

L.DNTList = '忽略列表'
L.DNTListDesc = '列出了忽略列表中的法术, 你可以在下拉菜单中点击将其移除.'

L.DNTWillTrack = 'Ellipsis将不会监视 %s.'

-- Cooldown Tracking
L.CooldownTracking = '冷却监视'
L.CooldownTrackingDesc = '设置冷却监视.'

L.TrackCooldownsFor = '监视冷却...'

L.CDSpell = '法术'
L.CDSpellDesc = '开启法术冷却监视.'

L.CDItem = '物品'
L.CDItemDesc = '开启物品冷却监视.'

L.CDPet = '宠物技能'
L.CDPetDesc = "开启宠物技能冷却监视."

L.CDMinDuration = '最少冷却时间'
L.CDMinDurationDesc = '设置Ellipsis将监视的最少冷却时间(秒).\n\n这项设置必须大于2秒(避免公共冷却)'

L.CDMaxDuration = '最大冷却时间'
L.CDMaxDurationDesc = '设置Ellipsis将监视的最大冷却时间(分钟).\n\n设置为0监视所有冷却.'

L.CDDNTAddDesc = 'Ellipsis将不会监视在此列表中的冷却.'

L.CDDNTListDesc = '列出了忽略列表中的冷却, 你可以在下拉菜单中点击将其移除.'

L.CDDNTWillTrack = 'Ellipsis将不会监视 %s 的冷却.'

-- Output (Audio)
L.OutputAudio = '输出 (音效)'
L.OutputAudioDesc = '设置输出音效.'

L.OAPlaySounds = '启用'
L.OAPlaySoundsDesc = '启用音效提示.'

L.OAPlaySoundsOn = '播放音效...'

L.OAExpiredDesc = '光环自然消失音效.'
L.OABrokenDesc = '光环非自然原因音效(被驱散等)音效.'
L.OACDExpiredDesc = '冷却完成音效.'

-- Output (Visual)
L.OutputVisual = '输出 (视觉)'
L.OutputVisualDesc = '设置视觉输出.'

L.OVOutputTo = '输出到'
L.OVOutputToDesc = '视觉输出到...'

L.OVNotifyOn = '提示...'

L.OVNotifyExpireDesc = '在光环自然结束后显示一条提示信息.'
L.OVNotifyBreakDesc = '在光环提早结束时显示一条提示信息.'
L.OVNotifyCDExpireDesc = '在冷却完成后显示一条提示信息.'

-- Output (Common To Both)
L.OAVExpired = '光环结束计时器'
L.OAVBroken = '打破光环计时器'
L.OAVCDExpired = '冷却计时器'

-- Advanced
L.Advanced = '高级'
L.AdvancedDesc = '高级设置.\n\n不改变这些Ellipsis也可以非常好的工作.'

L.AdvancedWarning = "这些设置可以调整Ellipsis的追踪功能, 请在改变这些值以前弄清楚他们的用途."

L.TimerUpdateRate = '计时器刷新频率'
L.TimerUpdateRateDesc = '设置Ellipsis各计时器刷新频率.\n\n较低的值会提高计时器的平滑度并导致较高的资源占用, 较高的值会减少资源占用不过也会导致"抽筋"一样的计时条.\n\n推荐值: 0.05 - 0.15 秒'

L.SecondaryScan = '次扫描'
L.SecondaryScanDesc = '设置是否在队伍中执行次扫描.\n\n次扫描将每秒(默认)扫描一次所有队友的目标, 来精确的检查你的Debuff是否被打破. 只在主扫描实时扫描你队伍的Debuff时需要.'

L.SecondaryScanRate = '次扫描频率'
L.SecondaryScanRateDesc = '设置次扫描频率.\n\n频繁的扫描会更精确不过将导致高资源占用, 较低频率将减少资源占用但会降低精确度.\n\n推荐: 1.0 - 1.5 秒'
