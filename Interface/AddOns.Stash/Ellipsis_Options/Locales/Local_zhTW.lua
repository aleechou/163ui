-- yleaf(yaroot@gmail.com)
local L = LibStub("AceLocale-3.0"):NewLocale("Ellipsis_Options", "zhTW")
if not L then return end

local mustShow = '必須顯示目標:\n |cff67b1e9N沒有目標|r - AOE時\n |cff67b1e9玩家|r - 如果追蹤\n |cff67b1e9寵物|r - 如果追蹤'

L.Lock = '鎖定'
L.LockDesc = '鎖定Ellipsis並隱藏的|cff67b1e9目標|r和|cff67b1e9醒目目標|r.'

L.SampleTimers = '測試'
L.SampleTimersDesc = '創建一些計時器以測試設定效果.\n\n按下後會重置計時器, 按住Shift鍵會清除這些測試計時器.'
L.SampleTarget = '測試目標 %d'
L.SampleTimer = '測試計時 %d'

-- Display (Base)
L.Display = '顯示設定'
L.DisplayDesc = '設定基礎顯示模式.'

L.Tooltips = '提示'
L.TooltipsDesc = '滑鼠移到計時器上顯示提示.'

L.Clickable = '可點擊計時器'
L.ClickableDesc = '開啟計時器的點擊通告/遮蔽等功能.'

L.AuraAlpha = '透明度 - 光環'
L.AuraAlphaDesc = '設定透明度.'

L.AuraScale = '縮放 - 光環'
L.AuraScaleDesc = '設定縮放.'

L.AuraWidth = '寬度 - 光環'
L.AuraWidthDesc = '設定計時器的寬度(單位:像素).'

L.CDAlpha = '透明度 - 冷卻'
L.CDAlphaDesc = '設定冷卻條的透明度.'

L.CDScale = '縮放 - 冷卻'
L.CDScaleDesc = '設定冷卻計時的縮放.'

-- Display (Targets 1)
L.DisplayTarget1 = '光環設定 1'
L.DisplayTargetDesc = '設定目標光環計時.'

L.ConfigTargetDisplay = '設定目標顯示'
L.ConfigTargetDisplayDesc = "設定除了必須顯示的目標以外的計時器顯示目標, 將會永遠顯示光環計時. \n\n前4個設定中目標和焦點只在顯示時擁有高優先級, 後3個設定中, 除了你的設定顯示的目標外沒有目標會被顯示.\n\n所有 (無優先)\n只按照目標排列計時器.\n\n所有 (目標優先)\n你的目標將顯示在第一個\n\n所有 (焦點優先)\n你的焦點將顯示在第一個\n\n所有 (所有優先)\n目標將會顯示在焦點下面.\n\n僅限目標(如果存在)\n只顯示目標\n\n僅限焦點(如果存在)\n只顯示焦點\n\n目標和焦點\n只顯示目標和焦點的計時." .. mustShow

L.ConfigTargetDisplayAll = '所有 (無優先)'
L.ConfigTargetDisplayAllBoth = '所有 (所有優先)'
L.ConfigTargetDisplayAllFocus = '所有 (焦點優先)'
L.ConfigTargetDisplayAllTarget = '所有 (目標優先)'
L.ConfigTargetDisplayBoth = '目標和焦點'
L.ConfigTargetDisplayFocus = '僅限焦點'
L.ConfigTargetDisplayTarget = '僅限目標'

L.ShowNumTargets = '最大目標數'
L.ShowNumTargetsDesc = "設定最大顯示的目標數量 (除了必須顯示的目標外).\n\n如果選擇了只顯示目標/焦點, 這個設定會自動失效.\n\n" .. mustShow

L.TargetFont = '字體'
L.TargetFontDesc = '設定字體.'

L.TargetFontHeight = '字體大小'
L.TargetFontHeightDesc = '設定字體大小.'

L.TargetPadding = '間隔'
L.TargetPaddingDesc = '設定間隔.'

L.GrowTargets = '增長方向'
L.GrowTargetsDesc = '設定增長方向.'

L.GrowUP = '上'
L.GrowDOWN = '下'
L.GrowLEFT = '左'
L.GrowRIGHT = '右'

-- Display (Targets 2)
L.DisplayTarget2 = '光環設定 2'

L.ShowLevel = '顯示等級'
L.ShowLevelDesc = '計時器怪物名字旁顯示怪物等級.'

L.ShowClassColours = '顯示職業顏色'
L.ShowClassColoursDesc = '怪物名字顯示職業顏色.'

L.ShowRaidIcons = '顯示團隊標記'
L.ShowRaidIconsDesc = '計時器關務名字上顯示團隊標記.'

L.ProminentTargetsHeader = '醒目目標計時器'
L.ProminentTargetsDesc = '這些目標將會顯示在|cff67b1e9醒目計時器|r下, 而不是|cff67b1e9普通計時器|r.'

L.ProminentItemsDesc = '標記這個目標為醒目目標, 此目標計時將會顯示在|cff67b1e9醒目計時器|r下.'

L.ProminentNoTarget = '沒有目標(AoE)'
L.ProminentPlayer = '玩家'
L.ProminentPet = '寵物'

-- Display (Timers 1)
L.DisplayTimer1 = '計時器設定 1'
L.DisplayTimerDesc = '設定計時器選項.'

L.SortTimerMethod = '排序計時器'
L.SortTimerMethodDesc = '設定如何排序.'
L.SortTimerMethod1 = '字母 (正)'
L.SortTimerMethod2 = '字母 (逆)'
L.SortTimerMethod3 = '剩餘時間 (正)'
L.SortTimerMethod4 = '剩餘時間 (逆)'
L.SortTimerMethod5 = '不排序'

L.TimerFormat = '時間顯示格式'
L.TimerFormatDesc = '設定如何顯示時間.\n\n例: 3個不同的值會被用于分鐘/秒/10秒以下(可選)的顯示樣式.\n\n## - 1:09   |   9   |   9.4\n\n0:## - 1:09   |   0:09   |   0:09.4\n\n##s - 1m 9s   |   9s   |   9.4s\n\n##s abbv - 1m   |   9s   |   9.4s'
L.TimerFormat1 = '##'
L.TimerFormat2 = '0:##'
L.TimerFormat3 = '##s'
L.TimerFormat4 = '##s abbv'

L.ShowTenths = '顯示10秒以下樣式'
L.ShowTenthsDesc = '設定是否在一個計時在10秒內時使用特殊的格式來顯示.'

L.Mode = '顯示樣式'
L.ModeDesc = '設定怎樣顯示計時器\n\n計時條模式將顯示一個有著法術名字,圖示和剩餘時間的計時條.\n\n圖示模式將顯示一個只有剩餘時間的法術圖示.'
L.ModeBars = '計時條'
L.ModeIcons = '圖示'

L.GrowTimers = '增長方向'
L.GrowTimersDesc = '設定計時器增長方向.'

L.GhostShow = '鬼魂計時'
L.GhostShowDesc = '是否顯示鬼魂計時. 如果選中將會在一個法術結束以後繼續顯示該法術圖示, 這會提示你這個法術已經失效..'

L.GhostDuration = '鬼魂計時器持續時間'
L.GhostDurationDesc = '設定顯示鬼魂計時器的時間(秒).'

-- Display (Timers 2)
L.DisplayTimer2 = '計時器設定 2'

L.BarHeight = '計時條高度'
L.BarHeightDesc = "設定計時條的高度(計時條模式)."

L.IconHeight = '圖示高度'
L.IconHeightDesc = "設定圖示的高度(圖示模式).\n\n因為圖示是正方形, 所以寬度也將是這個值."

L.TimerPadding = '計時條間隔'
L.TimerPaddingDesc = '設定計時條之間的間隔.'

L.Texture = '計時條材質'
L.TextureDesc = "設定計時條的材質."

L.TimerFont = '字體'
L.TimerFontDesc = "設定所有文字所使用的字體."

L.TimerFontHeight = '字體大小'
L.TimerFontHeightDesc = '設定字體大小.'

L.ShowStackInName = '在法術名字上顯示堆疊'
L.ShowStackInNameDesc = "將堆疊 (例如: 生命綻放) 顯示在法術名字上\n\n如果你使用圖示模式並激活了這個設定, 你將不會看到堆疊."

-- Display (Cooldowns 1)
L.DisplayCooldown1 = '冷卻計時 1'
L.DisplayCooldownDesc = '設定冷卻計時.'

L.CDHorizontal = '橫向'
L.CDHorizontalDesc = '勾選將橫向顯示, 反之則縱向.'

L.CDHideWhenNone = '不計時時隱藏'
L.CDHideWhenNoneDesc = '選中後將在沒法術冷卻顯示時隱藏.'

L.CDLength = '計時條長度'
L.CDLengthDesc = '設定冷卻計時條的長度.\n\n縱向顯示時為高度.'

L.CDThickness = '計時條高度'
L.CDThicknessDesc = '設定冷卻計時條的高度.\n\n縱向顯示時為寬度.'

L.CDTimeDetail = '詳細時間刻度'
L.CDTimeDetailDesc = '設定顯示在計時條上的詳細的時間刻度.'

L.CDMaxTimeDisplay = '刻度最大時間'
L.CDMaxTimeDisplayDesc = '設定在冷卻條刻度上顯示的最大時間(單位為秒).\n\n任何較長時間的冷卻將會一直在計時條右側停留, 直到他們的冷卻時間低于這個值.'

L.CDFontHeight = '刻度字體大小'
L.CDFontHeightDesc = '設定刻度字體的大小.'

-- Display (Cooldowns 2)
L.DisplayCooldown2 = '冷卻計時 2'

L.CDTexture = '計時條材質'
L.CDTextureDesc = '設定計時條材質.'

L.CDShowOffsetTags = '顯示偏移標籤'
L.CDShowOffsetTagsDesc = '如果一個圖示距離計時條過遠, 將會顯示一個標籤來鏈接其和計時條.'

L.CDOffset1 = '偏移: 法術'
L.CDOffset1Desc = '設定法術冷卻時間偏移.\n\n正面: 計時條根據方向設定在計時器上方或右邊.\n\n負面: 計時條根據方向設定在計時器下方或左邊.'

L.CDOffset3 = '偏移: 物品'
L.CDOffset3Desc = '設定裝備和物品冷卻時間偏移.\n\n正面: 計時條根據方向設定在計時器上方或右邊.\n\n負面: 計時條根據方向設定在計時器下方或左邊.'

L.CDOffset2 = '偏移: 寵物'
L.CDOffset2Desc = '設定寵物技能冷卻時間偏移.\n\n正面: 計時條根據方向設定在計時器上方或右邊.\n\n負面: 計時條根據方向設定在計時器下方或左邊.'

-- Display (Colours)
L.DisplayColours = '顏色'
L.DisplayColoursDesc = '設定顏色.'

L.ColourTimerDesc = '光環顏色:'

L.ColourBackground = '計時器背景'
L.ColourBackgroundDesc = '設定計時器背景顏色.\n\n可以獨立設定透明度.'

L.ColourGhost = '鬼魂計時器'
L.ColourGhostDesc = '設定鬼魂計時器的顏色.'

L.ColourTargetText = '目標監視器'
L.ColourTargetTextDesc = '設定目標監視器的顏色.'

L.ColourTimerText = '計時器文字'
L.ColourTimerTextDesc = '設定計時器文字顏色(法術名字/剩餘時間).'

L.ColourCDDesc = '冷卻顏色:'

L.ColourCDBar = '主計時器'
L.ColourCDBarDesc = '設定主計時器顏色.\n\n可以獨立設定透明度.'

L.ColourCDBorder = '計時條邊框'
L.ColourCDBorderDesc = "設定計時條邊框顏色.\n\n可以獨立設定透明度."

L.ColourCDBackdrop = '計時條背景'
L.ColourCDBackdropDesc = "設定計時條背景顏色. (計時條透明時可見.)\n\n可以獨立設定透明度."

L.ColourCDText = '刻度文字'
L.ColourCDTextDesc = "設定冷卻條上的文字顏色."

L.ColourCD1 = '偏移標籤: 法術'
L.ColourCD1Desc = '設定法術偏移標籤顏色.\n\n注意: 只在顯示偏移標籤時有效.'

L.ColourCD3 = '偏移標籤: 物品'
L.ColourCD3Desc = '設定物品偏移標籤顏色.\n\n注意: 只在顯示偏移標籤時有效.'

L.ColourCD2 = '偏移標籤: 寵物'
L.ColourCD2Desc = '設定寵物偏移標籤顏色.\n\n注意: 只在顯示偏移標籤時有效.'

-- Aura Tracking
L.AuraTracking = '光環監視'
L.AuraTrackingDesc = '設定光環監視.'

L.TrackBuffs = '監視Buff'
L.TrackBuffsDesc = '監視你施放的Buff.'

L.TrackDebuffs = '監視Debuff'
L.TrackDebuffsDesc = '監視你釋放的Debuff.'

L.TrackPlayer = '監視自身Buff'
L.TrackPlayerDesc = '監視你對自己施放的Buff.'

L.TrackPet = '監視寵物Buff'
L.TrackPetDesc = '监视你对你宠物施放的Buff.'

L.MinAuraDuration = '最小光環持續時間'
L.MinAuraDurationDesc = '設置被Ellipsis追蹤的最小持續時間(秒).'

L.MaxAuraDuration = '最大光環持續時間'
L.MaxAuraDurationDesc = '設定Ellipsis監視的最大的持續時間(分鐘).\n\n設定為0將監視所有.'

L.DNTAdd = "增加到忽略列表"
L.DNTAddDesc = 'Ellipsis將不會監視在此列表中的法術.'

L.DNTList = '忽略列表'
L.DNTListDesc = '列出了忽略列表中的法術, 你可以在下拉選單中點擊將其移除.'

L.DNTWillTrack = 'Ellipsis將不會監視 %s.'

-- Cooldown Tracking
L.CooldownTracking = '冷卻監視'
L.CooldownTrackingDesc = '設定冷卻監視.'

L.TrackCooldownsFor = '監視冷卻...'

L.CDSpell = '法術'
L.CDSpellDesc = '開啟法術冷卻監視.'

L.CDItem = '物品'
L.CDItemDesc = '開啟物品冷卻監視.'

L.CDPet = '寵物技能'
L.CDPetDesc = "開啟寵物技能冷卻監視."

L.CDMinDuration = '最少了冷卻時間'
L.CDMinDurationDesc = '設置Ellipsis將監視的最少冷卻時間(秒).\n\n這項設置必須大於2秒(避免公共冷卻)'

L.CDMaxDuration = '最大冷卻時間'
L.CDMaxDurationDesc = '設定Ellipsis將監視的最大冷卻時間.\n\n設定為0監視所有冷卻.'

L.CDDNTAddDesc = 'Ellipsis將不會監視在此列表中的冷卻.'

L.CDDNTListDesc = '列出了忽略列表中的冷卻, 你可以在下拉選單中點擊將其移除.'

L.CDDNTWillTrack = 'Ellipsis將不會監視 %s 的冷卻.'

-- Output (Audio)
L.OutputAudio = '輸出 (音效)'
L.OutputAudioDesc = '設定輸出音效.'

L.OAPlaySounds = '啟用'
L.OAPlaySoundsDesc = '啟用音效提示.'

L.OAPlaySoundsOn = '播放音效...'

L.OAExpiredDesc = '光環自然消失音效.'
L.OABrokenDesc = '光環非自然原因音效(被驅散等)音效.'
L.OACDExpiredDesc = '冷卻完成音效.'

-- Output (Visual)
L.OutputVisual = '輸出 (視覺)'
L.OutputVisualDesc = '設定視覺輸出.'

L.OVOutputTo = '輸出到'
L.OVOutputToDesc = '視覺輸出到...'

L.OVNotifyOn = '提示...'

L.OVNotifyExpireDesc = '在光環自然結束後顯示一條提示訊息.'
L.OVNotifyBreakDesc = '在光環提早結束時顯示一條提示訊息.'
L.OVNotifyCDExpireDesc = '在冷卻完成後顯示一條提示訊息.'

-- Output (Common To Both)
L.OAVExpired = '光環結束計時器'
L.OAVBroken = '打破光環計時器'
L.OAVCDExpired = '冷卻計時器'

-- Advanced
L.Advanced = '進階'
L.AdvancedDesc = '進階設定.\n\n不改變這些Ellipsis也可以非常好的工作.'

L.AdvancedWarning = "這些設定可以調整Ellipsis的追蹤功能, 請在改變這些值以前弄清楚他們的用途."

L.TimerUpdateRate = '計時器刷新頻率'
L.TimerUpdateRateDesc = '設定Ellipsis各計時器刷新頻率.\n\n較低的值會提高計時器的平滑度並導致較高的資源占用, 較高的值會減少資源占用不過也會導致"抽筋"一樣的計時條.\n\n推薦值: 0.05 - 0.15 秒'

L.SecondaryScan = '次掃描'
L.SecondaryScanDesc = '設定是否在隊伍中執行次掃描.\n\n次掃描將每秒(預設)掃描一次所有隊友的目標, 來準確的檢查你的Debuff是否被打破. 只在主掃描時掃描你隊伍的Debuff時需要.'

L.SecondaryScanRate = '次掃描頻率'
L.SecondaryScanRateDesc = '設定次掃描頻率.\n\n頻繁的掃描會更準確不過將導致高資源占用, 較低頻率將減少資源占用但會降低精準度.\n\n推薦: 1.0 - 1.5 秒'
