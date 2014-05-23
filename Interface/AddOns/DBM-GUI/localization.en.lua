DBM_GUI_Translations = {}

local L = DBM_GUI_Translations

L.MainFrame = "Deadly Boss Mods"

L.TranslationByPrefix		= "Translated by "
L.TranslationBy 			= "Iceoven@Dath'Remar"
L.Website					= "Visit our English version Github project page at |cFF73C2FBhttps://github.com/henryj/Voice-Encounter-Mods|r"
L.WebsiteButton				= "Github"
L.SoundMM					= "Voice Actor"

L.OTabBosses	= "Bosses"
L.OTabOptions	= "Options"

L.Checkinstance				= "Check instance"
L.Checkver					= "Check version"

L.TabCategory_Options	 	= "General Options"
L.TabCategory_MOP	 		= "Mists of Pandaria"
L.TabCategory_CATA	 		= "Cataclysm"
L.TabCategory_WOTLK 		= "Wrath of the Lich King"
L.TabCategory_BC 			= "The Burning Crusade"
L.TabCategory_CLASSIC		= "WoW Classic"
L.TabCategory_PVP 			= "PvP"
L.TabCategory_OTHER    		= "Other Boss Mods"

L.BossModLoaded 			= "%s statistics"
L.BossModLoad_now 			= [[This boss mod is not loaded. 
It will be loaded when you enter the instance. 
You can also click the button to load the mod manually.]]

L.PosX						= 'Position X'
L.PosY						= 'Position Y'

L.MoveMe 					= 'Move me'
L.Button_OK 				= 'OK'
L.Button_Cancel 			= 'Cancel'
L.Button_LoadMod 			= 'Load AddOn'
L.Mod_Enabled				= "Enable boss mod"
L.Mod_Reset					= "Load default options"
L.Reset 					= "Reset"

L.Enable  					= "Enable"
L.Disable					= "Disable"

L.NoSound					= "No sound"

L.IconsInUse				= "Icons used by this mod"

-- Tab: Boss Statistics
L.BossStatistics			= "Boss Statistics"
L.Statistic_Kills			= "Victories:"
L.Statistic_Wipes			= "Wipes:"
L.Statistic_Incompletes		= "Incompletes:"--For scenarios, TODO, figure out a clean way to replace any Statistic_Wipes with Statistic_Incompletes for scenario mods
L.Statistic_BestKill		= "Best Victory:"

-- Tab: General Core Options
L.General 					= "General DBM Core Options"
L.EnableDBM 				= "Enable DBM"
L.EnableMiniMapIcon			= "Show minimap button"
L.SetPlayerRole				= "Automatically set player role (Enabled recommended)"
L.UseMasterVolume			= "Use Master audio channel to play DBM sound alerts"
L.LFDEnhance				= "Play readycheck sound for role checks &amp; BG/LFG proposals in Master audio channel"
L.AutologBosses				= "Automatically record boss encounters using blizzard combat log"
L.AdvancedAutologBosses		= "Automatically record boss encounters with Transcriptor"
L.LogOnlyRaidBosses			= "Only record raid boss encounters (exclude Raid Finder/party/scenario)"
L.Latency_Text				= "Set max latency sync threshold: %d"
-- Tab: General Timer Options
L.TimerGeneral 				= "General DBM Timer Options"
L.SKT_Enabled				= "Always show speed kill timer (Overrides boss-specific option)"
L.ChallengeTimerOptions		= "Set option for challenge mode best clear timer"
L.ChallengeTimerPersonal	= "Personal"
L.ChallengeTimerGuild		= "Guild"
L.ChallengeTimerRealm		= "Realm"

L.ModelOptions				= "3D Model Viewer Options"
L.EnableModels				= "Enable 3D models in boss options"
L.ModelSoundOptions			= "Set sound option for model viewer"
L.ModelSoundShort			= "Short"
L.ModelSoundLong			= "Long"

L.Button_RangeFrame			= "Show/hide range frame"
L.Button_RangeRadar			= "Show/hide range radar"
L.Button_InfoFrame			= "Show/hide info frame"
L.Button_TestBars			= "Start test bars"

L.PizzaTimer_Headline 		= 'Create a "Pizza Timer"'
L.PizzaTimer_Title			= 'Name (e.g. "Pizza!")'
L.PizzaTimer_Hours 			= "Hours"
L.PizzaTimer_Mins 			= "Min"
L.PizzaTimer_Secs 			= "Sec"
L.PizzaTimer_ButtonStart 	= "Start timer"
L.PizzaTimer_BroadCast		= "Broadcast to raid"

-- Tab: Raidwarning
L.Tab_RaidWarning 			= "Raid Warnings"
L.RaidWarning_Header		= "Raid Warning Options"
L.RaidWarnColors 			= "Raid Warning Colors"
L.RaidWarnColor_1 			= "Color 1"
L.RaidWarnColor_2 			= "Color 2"
L.RaidWarnColor_3		 	= "Color 3"
L.RaidWarnColor_4 			= "Color 4"
L.InfoRaidWarning			= [[You can specify the position and colors of the raid warning frame. 
This frame is used for messages like "Player X is affected by Y".]]
L.ColorResetted 			= "The color settings of this field have been reset."
L.ShowWarningsInChat 		= "Show warnings in chat frame"
L.ShowChatTime			 	= "Add time label before warnings in chat frame"
L.ShowFakedRaidWarnings 	= "Show warnings as faked raid warning messages"
L.WarningIconLeft 			= "Show icon on left side"
L.WarningIconRight 			= "Show icon on right side"
L.WarningIconChat 			= "Show icons in chat frame"
L.ShowCountdownText			= "Show countdown text"
L.RaidWarnMessage 			= "Thanks for using Deadly Boss Mods"
L.BarWhileMove 				= "Raid warning movable"
L.RaidWarnSound				= "Play sound on raid warning"
L.CountdownVoice			= "Set voice"
L.SpecialWarnSound			= "Set sound for special warnings affecting you or your specific role"
L.SpecialWarnSound2			= "Set sound for special warnings affecting everyone"
L.SpecialWarnSound3			= "Set sound for VERY important special warnings"

-- Tab: Generalwarnings
L.Tab_GeneralMessages 		= "General Messages"
L.CoreMessages				= "Core Message Options"
L.ShowLoadMessage 			= "Show mod loading messages in chat frame"
L.ShowPizzaMessage 			= "Show timer broadcast messages in chat frame"
L.CombatMessages			= "Combat Message Options"
L.ShowEngageMessage 		= "Show engage messages in chat frame"
L.ShowKillMessage 			= "Show kill messages in chat frame"
L.ShowWipeMessage 			= "Show wipe messages in chat frame"
L.ShowRecoveryMessage 		= "Show timer recovery messages in chat frame"
L.WhisperMessages			= "Whisper Message Options"
L.AutoRespond 				= "Auto-respond to whispers while fighting"
L.EnableStatus 				= "Reply to 'status' whispers"
L.WhisperStats 				= "Include kill/wipe stats in whisper responses"

-- Tab: Barsetup
L.BarSetup   				= "Bar Style"
L.BarTexture 				= "Bar texture"
L.BarStartColor				= "Start color"
L.BarEndColor 				= "End color"
L.ExpandUpwards				= "Expand bars upward"
L.Bar_Font					= "Font used for bars"
L.Bar_FontSize				= "Font size"
L.Slider_BarOffSetX 		= "Offset X: %d"
L.Slider_BarOffSetY 		= "Offset Y: %d"
L.Slider_BarWidth 			= "Bar width: %d"
L.Slider_BarScale 			= "Bar scale: %0.2f"
L.AreaTitle_BarSetup		= "General Bar Options"
L.AreaTitle_BarSetupSmall 	= "Small Bar Options"
L.AreaTitle_BarSetupHuge	= "Huge Bar Options"
L.BarIconLeft 				= "Left icon"
L.BarIconRight 				= "Right icon"
L.EnableHugeBar 			= "Enable huge bar (aka Bar 2)"
L.FillUpBars				= "Fill up bars"
L.ClickThrough				= "Disable mouse events (allows you to click through bars)"

-- Tab: Spec Warn Frame
L.Panel_SpecWarnFrame		= "Special Warnings"
L.Area_SpecWarn				= "Special Warning Options"
L.SpecWarn_Enabled			= "Show special warnings for boss abilities"
L.SpecWarn_FlashFrame		= "Show screen flash for special warnings"
L.SpecWarn_ShakeFrame		= "Show screen vibration for the devastating"
L.SpecWarn_AdSound			= "Enable advanced sound options for special warnings (requires UI Reload)"
L.SpecWarn_Font				= "Font used for special warnings"
L.SpecWarn_FontSize			= "Font size: %d"
L.SpecWarn_FontColor		= "Font color"
L.SpecWarn_FontType			= "Select font"
L.SpecWarn_FlashColor		= "Flash color (%d)"
L.SpecWarn_FlashDur			= "Flash duration: %0.1f"
L.SpecWarn_FlashAlpha		= "Flash alpha: %0.1f"
L.SpecWarn_DemoButton		= "Show example"
L.SpecWarn_MoveMe			= "Set position"
L.SpecWarn_ResetMe			= "Reset to defaults"

L.Panel_LTSpecWarnFrame		= "Long-term Special Warnings"
L.Area_LTSpecWarn			= "Long-term Special Warning Options"
L.LTSpecWarn_Enabled		= "Show Long-term special warnings"
L.LTSpecWarn_Font			= "Font used for Long-term special warnings"
L.TestWarningEnd			= "Examples exist only five seconds, but the real long-term special warning will exist for a long time on your screen until the trigger event is canceled"

-- Tab: HealthFrame
L.Panel_HPFrame				= "Health Frame"
L.Area_HPFrame				= "Health Frame Options"
L.HP_Enabled				= "Always show health frame (Overrides boss-specific option)"
L.HP_GrowUpwards			= "Expand health frame upward"
L.HP_ShowDemo				= "Show HP frame"
L.BarWidth					= "Bar width: %d"

-- Tab: Spam Filter
L.Panel_SpamFilter				= "Global and Spam Filters"
L.Area_SpamFilter				= "Spam Filter Options"
L.StripServerName				= "Strip realm name in warnings and timers"
L.SpamBlockBossWhispers			= "Filter &lt;DBM&gt; warning whispers while fighting"
L.BlockVersionUpdateNotice		= "Disable update notification popup (Not recommended)"
L.ShowBigBrotherOnCombatStart	= "Perform Big Brother buff check on combat start"
L.BigBrotherAnnounceToRaid		= "Announce Big Brother results to raid"

L.Area_SpamFilter_Outgoing		= "Global Filter Options"
L.SpamBlockNoShowAnnounce		= "Do not show announces or play warning sounds"
L.SpamBlockNoSendWhisper		= "Do not send whispers to other players"
L.SpamBlockNoSetIcon			= "Do not set icons on targets"
L.SpamBlockNoRangeFrame			= "Do not show range frame"
L.SpamBlockNoInfoFrame			= "Do not show info frame"

L.Area_PullTimer				= "Pull Timer Filter Options"
L.DontShowPTNoID				= "Block pull timers not sent from same zone as you"
L.DontShowPT					= "Do not show Pull Timer bar"
L.DontShowPTText				= "Do not show announce text for Pull Timer"
L.DontPlayPTCountdown			= "Do not play Pull/Combat Timer countdown audio"
L.DontShowPTCountdownText		= "Do not show Pull/Combat Timer countdown text"
L.PT_Threshold					= "Do not show Pull/Combat Timer countdown text above: %d"

L.Panel_HideBlizzard			= "Hide Blizzard"
L.Area_HideBlizzard				= "Hide Blizzard Options"
L.HideBossEmoteFrame			= "Hide raid boss emote frame during boss fights"
L.HideWatchFrame				= "Hide watch (objectives) frame during boss fights"
L.SpamBlockSayYell				= "Hide chat bubbles announces from the chat frame"
L.DisableCinematics				= "Hide in-game cinematics"
L.AfterFirst					= "After each movie has played once"
L.Always						= "Always"

-- Misc
L.FontHeight	= 16