-- Default locals
local L = LibStub("AceLocale-3.0"):NewLocale("Ellipsis_Options", "enUS", true)

if not L then return end -- abort if not using these locals

local mustShow = 'Must Show Targets:\n |cff67b1e9No Target|r - for AoEs\n |cff67b1e9Player|r - if tracked\n |cff67b1e9Pet|r - if tracked'

L.Lock = 'Lock'
L.LockDesc = 'Lock the Ellipsis GUI preventing movement and hiding the drag frame for both |cff67b1e9Targets|r and |cff67b1e9Prominent Targets|r.'

L.SampleTimers = 'Test'
L.SampleTimersDesc = 'Creates a set of sample aura and cooldowns timers to aid in setting options.\n\nPressing this button again will reset the timers, and pressing it with the Shift key held down will clear the sample timers.'
L.SampleTarget = 'Sample Target %d'
L.SampleTimer = 'Sample Timer %d'

-- Display (Base)
L.Display = 'Display Options'
L.DisplayDesc = 'Configure base gui display.'

L.Tooltips = 'Tooltips'
L.TooltipsDesc = 'Show tooltips on mouseover of aura and cooldown timers.'

L.Clickable = 'Clickable'
L.ClickableDesc = 'Set aura and cooldown timers to be clickable for duration announcements and track blocking.'

L.AuraAlpha = 'Alpha - Auras'
L.AuraAlphaDesc = 'Set the transparency of aura timers and targets.'

L.AuraScale = 'Scale - Auras'
L.AuraScaleDesc = 'Set the relative scale of aura timers and targets to the base UI.'

L.AuraWidth = 'Aura Entry Width'
L.AuraWidthDesc = 'Set the width (in pixels) of aura entries; this means both the target identifiers and the timers themselves.'

L.CDAlpha = 'Alpha - Cooldowns'
L.CDAlphaDesc = 'Set the transparency of the cooldown bar and timers.'

L.CDScale = 'Scale - Cooldowns'
L.CDScaleDesc = 'Set the relative scale of the cooldown bar and timers to the base UI.'

-- Display (Targets 1)
L.DisplayTarget1 = 'Aura Targets 1'
L.DisplayTargetDesc = 'Configure aura target options.'

L.ConfigTargetDisplay = 'Configure Target Display'
L.ConfigTargetDisplayDesc = "Configures the display of aura targets other than the 'must show' targets, which will always be shown if timers exist on them. Of the options below, for the first four options, target and focus are only prioritized if they exist and have timers; for the final three, no targets will be shown unless the appropriate entries (target, focus or both) exist.\n\nAll (No Priority)\nStandard ordering of targets.\n\nAll (Target Priority)\nTarget shown at head of list.\n\nAll (Focus Priority)\nFocus shown at head of list.\n\nAll (Both Priority)\nTarget shown at head of list followed by focus.\n\nTarget Only\nShow only target (if present).\n\nFocus Only\nShow only focus (if present).\n\nTarget & Focus\nShow only target and focus (if present).\n\n" .. mustShow

L.ConfigTargetDisplayAll = 'All (No Priority)'
L.ConfigTargetDisplayAllBoth = 'All (Both Priority)'
L.ConfigTargetDisplayAllFocus = 'All (Focus Priority)'
L.ConfigTargetDisplayAllTarget = 'All (Target Priority)'
L.ConfigTargetDisplayBoth = 'Target & Focus'
L.ConfigTargetDisplayFocus = 'Focus Only'
L.ConfigTargetDisplayTarget = 'Target Only'

L.ShowNumTargets = 'Max Targets'
L.ShowNumTargetsDesc = "Set the maximum number of aura targets to display (other than 'must show' targets).\n\nThis value will be ignored if Target Display is set to show only target or focus (or both).\n\n" .. mustShow

L.TargetFont = 'Target Font'
L.TargetFontDesc = 'Set the font to use for aura target identifiers.'

L.TargetFontHeight = 'Target Font Size'
L.TargetFontHeightDesc = 'Set the size of the font to use for aura target identifiers.'

L.TargetPadding = 'Target Padding'
L.TargetPaddingDesc = 'Set the padding (in pixels) between aura targets.'

L.GrowTargets = 'Grow Targets'
L.GrowTargetsDesc = 'Set the direction in which additional aura targets grow relative to the first entry.'

L.GrowUP = 'up'
L.GrowDOWN = 'down'
L.GrowLEFT = 'left'
L.GrowRIGHT = 'right'

-- Display (Targets 2)
L.DisplayTarget2 = 'Aura Targets 2'

L.ShowLevel = 'Show Level'
L.ShowLevelDesc = 'Show the mob levels in aura target identifiers.'

L.ShowClassColours = 'Show Class Colours'
L.ShowClassColoursDesc = 'Set the text of aura target identifiers to be the appropriate class colour.\n\nNote: When active, the Target Identifier colour option is ignored.'

L.ShowRaidIcons = 'Show Raid Icons'
L.ShowRaidIconsDesc = 'Show raid icons in aura target identifiers.'

L.ProminentTargetsHeader = 'Prominent Targets'
L.ProminentTargetsDesc = 'The following aura targets can be set to be prominent which means they will appear under the |cff67b1e9Prominent Targets|r anchor instead of the usual |cff67b1e9Targets|r anchor. This allows for a seperation of personal timers from others.'

L.ProminentItemsDesc = 'Make this aura target prominent, which will make it display under the |cff67b1e9Prominent Targets|r anchor.'

L.ProminentNoTarget = 'No Target (AoEs)'
L.ProminentPlayer = 'Player'
L.ProminentPet = 'Pet'

-- Display (Timers 1)
L.DisplayTimer1 = 'Aura Timers 1'
L.DisplayTimerDesc = 'Configure aura timer options.'

L.SortTimerMethod = 'Timer Sorting'
L.SortTimerMethodDesc = 'Set how to sort active timers on an aura target.'
L.SortTimerMethod1 = 'Alphabetical (Asc)'
L.SortTimerMethod2 = 'Alphabetical (Desc)'
L.SortTimerMethod3 = 'Time Remaining (Asc)'
L.SortTimerMethod4 = 'Time Remaining (Desc)'
L.SortTimerMethod5 = 'No Sorting'

L.TimerFormat = 'Time Display Format'
L.TimerFormatDesc = 'Set how time remaining is displayed on aura timers.\n\nFor examples, three values are given, they are the minute display, the second display and the (optional) tenths display when the timer is below 10 seconds.\n\n## - 1:09   |   9   |   9.4\n\n0:## - 1:09   |   0:09   |   0:09.4\n\n##s - 1m 9s   |   9s   |   9.4s\n\n##s abbv - 1m   |   9s   |   9.4s'
L.TimerFormat1 = '##'
L.TimerFormat2 = '0:##'
L.TimerFormat3 = '##s'
L.TimerFormat4 = '##s abbv'

L.ShowTenths = 'Show Tenths'
L.ShowTenthsDesc = 'Set whether aura timers show tenths of a second when in their final 10 second countdown.'

L.Mode = 'Timer Mode'
L.ModeDesc = 'Set the mode in which to display aura timers.\n\nBars mode shows a countdown bar with overlaid spell icon, spell name text and timer text.\n\nIcons mode show just a spell icon with associated timer text.'
L.ModeBars = 'bars'
L.ModeIcons = 'icons'

L.GrowTimers = 'Grow Timers'
L.GrowTimersDesc = 'Set the direction in which additional aura timers grow relative to the first entry.'

L.GhostShow = 'Ghost Timers'
L.GhostShowDesc = 'Set whether or not to show ghost timers. Ghost timers appear in place of an aura timer once it has expired as a helpful reminder that that particular timer is no longer active.\n\nWhen disabled, timers simply disappear once they have expired.'

L.GhostDuration = 'Ghost Timer Duration'
L.GhostDurationDesc = 'Set the duration (in seconds) of ghost timers when they are enabled.'

-- Display (Timers 2)
L.DisplayTimer2 = 'Aura Timers 2'

L.BarHeight = 'Bar Height'
L.BarHeightDesc = "Set the height (in pixels) of a timer bar when in 'bars' mode."

L.IconHeight = 'Icon Height'
L.IconHeightDesc = "Set the height (in pixels) of an icon when in 'icons' mode.\n\nNote: This also sets the width of the icon due to it being square."

L.TimerPadding = 'Timer Padding'
L.TimerPaddingDesc = 'Set the padding (in pixels) between timer entries in either timer mode.'

L.Texture = 'Bar Texture'
L.TextureDesc = "Set the texture to use for the timer bar when in 'bars' mode."

L.TimerFont = 'Timer Font'
L.TimerFontDesc = "Set the font to use for timer text, this includes the time display in both modes, and the spell name display in 'bars' mode."

L.TimerFontHeight = 'Timer Font Height'
L.TimerFontHeightDesc = 'Set the size of the font to use for timer text.'

L.ShowStackInName = 'Show Stack In Name'
L.ShowStackInNameDesc = "Set stacks (for spells that stack like Lifebloom) to be shown as part of the spell name text in 'bars' mode as opposed to the default which is a number overlay on the icon.\n\nNote: Setting this to enabled means stacks will not be shown in 'icons' mode."

-- Display (Cooldowns 1)
L.DisplayCooldown1 = 'Cooldowns 1'
L.DisplayCooldownDesc = 'Configure cooldown options.'

L.CDHorizontal = 'Horizontal Bar'
L.CDHorizontalDesc = 'Set the cooldown bar to display horizontally as opposed to vertically.'

L.CDHideWhenNone = 'Hide When None'
L.CDHideWhenNoneDesc = 'When enabled, the cooldown bar is hidden when there are no active timers, when disabled, the cooldown bar is always visible.'

L.CDLength = 'Bar Length'
L.CDLengthDesc = 'Set the length (in pixels) of the cooldown bar.\n\nNote: This sets its height when displayed vertically.'

L.CDThickness = 'Bar Thickness'
L.CDThicknessDesc = 'Set the thickness (in pixels) of the cooldown bar.\n\nNote: This sets its width when displayed vertically.'

L.CDTimeDetail = 'Detailed Timescale'
L.CDTimeDetailDesc = 'Set the detail displayed (how frequently time values are shown) on the cooldown bar timescale.'

L.CDMaxTimeDisplay = 'Timescale Max Time'
L.CDMaxTimeDisplayDesc = 'Set the maximum time (in seconds) that will be displayed on the cooldown bar timescale.\n\nNote: Any tracked timers with a greater value will stay at the end of the bar until their remaining time is less than the maximum.'

L.CDFontHeight = 'Timescale Font Height'
L.CDFontHeightDesc = 'Set the height of the font used to display the cooldown bar timescale.'

-- Display (Cooldowns 2)
L.DisplayCooldown2 = 'Cooldowns 2'

L.CDTexture = 'Bar Texture'
L.CDTextureDesc = 'Set the texture to use for the cooldown bar.'

L.CDShowOffsetTags = 'Show Offset Tags'
L.CDShowOffsetTagsDesc = 'If any cooldown timer types are offset from the main by a greater value than half the width, an offset tag will be displayed connecting the icon to the main bar. Disabling this option will hide those tags and make the icons float at their set offset.'

L.CDOffset1 = 'Offset: Spells'
L.CDOffset1Desc = 'Set the offset for spell cooldown timers.\n\nPositive: Sets the timer either above or to the right of the bar depending on orientation.\n\nNegative: Sets the timer either below or to the left of the bar depending on orientation.'

L.CDOffset3 = 'Offset: Items'
L.CDOffset3Desc = 'Set the offset for equipment and item cooldown timers.\n\nPositive: Sets the timer either above or to the right of the bar depending on orientation.\n\nNegative: Sets the timer either below or to the left of the bar depending on orientation.'

L.CDOffset2 = 'Offset: Pet'
L.CDOffset2Desc = 'Set the offset for pet ability cooldown timers.\n\nPositive: Sets the timer either above or to the right of the bar depending on orientation.\n\nNegative: Sets the timer either below or to the left of the bar depending on orientation.'

-- Display (Colours)
L.DisplayColours = 'Colours'
L.DisplayColoursDesc = 'Configure gui colours.'

L.ColourTimerDesc = 'Aura Colours:'

L.ColourBackground = 'Timer Background'
L.ColourBackgroundDesc = 'Set the colour of the timer background which is shown behind active timers as they count down.\n\nNote: This interface element can also have its transparency set.'

L.ColourGhost = 'Ghost Timers'
L.ColourGhostDesc = 'Set the colour of ghost timers when shown.'

L.ColourTargetText = 'Target Identifier'
L.ColourTargetTextDesc = 'Set the colour of the target identifiers.'

L.ColourTimerText = 'Timer Text'
L.ColourTimerTextDesc = 'Set the colour of timer text (both spell names and time remaining).'

L.ColourCDDesc = 'Cooldown Colours:'

L.ColourCDBar = 'Main Bar'
L.ColourCDBarDesc = 'Set the colour of the main cooldown bar.\n\nNote: This interface element can also have its transparency set.'

L.ColourCDBorder = 'Bar Border'
L.ColourCDBorderDesc = "Set the colour of the main cooldown bar's border.\n\nNote: This interface element can also have its transparency set."

L.ColourCDBackdrop = 'Bar Backdrop'
L.ColourCDBackdropDesc = "Set the colour of the main cooldown bar's backdrop. This can only be seen if the main bar is partially (or fully) transparent.\n\nNote: This interface element can also have its transparency set."

L.ColourCDText = 'Timescale Text'
L.ColourCDTextDesc = "Set the colour of the cooldown bar's timescale text."

L.ColourCD1 = 'Offset Tag: Spells'
L.ColourCD1Desc = 'Set the colour of spell offset tags.\n\nNote: Only visible if an offset is given for spell timers.'

L.ColourCD3 = 'Offset Tag: Items'
L.ColourCD3Desc = 'Set the colour of equipment and item offset tags.\n\nNote: Only visible if an offset is given for item timers.'

L.ColourCD2 = 'Offset Tag: Pet'
L.ColourCD2Desc = 'Set the colour of pet ability offset tags.\n\nNote: Only visible if an offset is given for pet ability timers.'

-- Aura Tracking
L.AuraTracking = 'Aura Tracking'
L.AuraTrackingDesc = 'Configure aura tracking.'

L.TrackBuffs = 'Track Buffs'
L.TrackBuffsDesc = 'Enable tracking for buffs that you cast.'

L.TrackDebuffs = 'Track Debuffs'
L.TrackDebuffsDesc = 'Enable tracking for debuffs that you cast.'

L.TrackPlayer = 'Track Player Buffs'
L.TrackPlayerDesc = 'Enable tracking of buffs you cast on yourself.'

L.TrackPet = 'Track Pet Buffs'
L.TrackPetDesc = 'Enable tracking of buffs you cast on your pet.'

L.MinAuraDuration = 'Min Aura Duration'
L.MinAuraDurationDesc = 'Set the minimum duration of auras (in seconds) that will be tracked by Ellipsis.'

L.MaxAuraDuration = 'Max Aura Duration'
L.MaxAuraDurationDesc = 'Set the maximum duration of auras (in minutes) that will be tracked by Ellipsis.\n\nA setting of 0 will disable max duration checking, allowing auras of any duration.'

L.DNTAdd = "Add to 'Do Not Track' List"
L.DNTAddDesc = 'Add spells to the Do Not Track list to prevent their timers being tracked by Ellipsis.'

L.DNTList = 'Do Not Track List'
L.DNTListDesc = 'Lists the spells that have been added to the DNT list, and allows for their removal by selecting them from the dropdown box.'

L.DNTWillTrack = 'Timers for %s will now be tracked by Ellipsis.'

-- Cooldown Tracking
L.CooldownTracking = 'Cooldown Tracking'
L.CooldownTrackingDesc = 'Configure cooldown tracking.'

L.TrackCooldownsFor = 'Track Cooldowns For...'

L.CDSpell = 'Spells'
L.CDSpellDesc = 'Enable tracking of your spell cooldowns.'

L.CDItem = 'Items'
L.CDItemDesc = 'Enable tracking of your equipment and item cooldowns.'

L.CDPet = 'Pet Abilities'
L.CDPetDesc = "Enable tracking of your pet's ability cooldowns."

L.CDMinDuration = 'Min CD Duration'
L.CDMinDurationDesc = 'Set the minimum duration of cooldowns (in seconds) that will be tracked by Ellipsis.\n\nThis setting will not go below 2 seconds so as to avoid all cooldowns showing up due to the GCD.'

L.CDMaxDuration = 'Max CD Duration'
L.CDMaxDurationDesc = 'Set the maximum duration of cooldowns (in minutes) that will be tracked by Ellipsis.\n\nA setting of 0 will disable max duration checking, allowing cooldowns of any duration.'

L.CDDNTAddDesc = 'Add spells to the Do Not Track list to prevent their cooldowns being tracked by Ellipsis.'

L.CDDNTListDesc = 'Lists the cooldowns that have been added to the DNT list, and allows for their removal by selecting them from the dropdown box.'

L.CDDNTWillTrack = 'Cooldowns for %s will now be tracked by Ellipsis.'

-- Output (Audio)
L.OutputAudio = 'Output (Audio)'
L.OutputAudioDesc = 'Configure audio output.'

L.OAPlaySounds = 'Enable'
L.OAPlaySoundsDesc = 'Enable audio notifications on timer completion.'

L.OAPlaySoundsOn = 'Play Sounds On...'

L.OAExpiredDesc = 'Sound to play when an aura timer expires naturally.'
L.OABrokenDesc = 'Sound to play when an aura timer ends early.'
L.OACDExpiredDesc = 'Sound to play when a cooldown timer expires.'

-- Output (Visual)
L.OutputVisual = 'Output (Visual)'
L.OutputVisualDesc = 'Configure visual output.'

L.OVOutputTo = 'Output To'
L.OVOutputToDesc = 'Configure visual output location.'

L.OVNotifyOn = 'Notify On...'

L.OVNotifyExpireDesc = 'Display a message when an aura timer expires naturally.'
L.OVNotifyBreakDesc = 'Display a message when an aura timer ends early.'
L.OVNotifyCDExpireDesc = 'Display a message when a cooldown timer expires.'

-- Output (Common To Both)
L.OAVExpired = 'Expired Aura Timers'
L.OAVBroken = 'Broken Aura Timers'
L.OAVCDExpired = 'Expired CD Timers'

-- Advanced
L.Advanced = 'Advanced'
L.AdvancedDesc = 'Configure advanced options.\n\nExperienced users only.'

L.AdvancedWarning = "These options provide low level config of Ellipsis' tracking functions, please be sure you know what you are doing before changing them."

L.TimerUpdateRate = 'Timer Update Rate'
L.TimerUpdateRateDesc = "Set the delay (in seconds) between updates of Ellipsis' aura and cooldown timers. This includes both timer text updates and progression along timer bars.\n\nLower values will result in higher resource usage and smoother looking bar updates, and higher values will reduce usage and result in more 'jerky' bar updates.\n\nRecommended: 0.05 - 0.15 seconds"

L.SecondaryScan = 'Secondary Scanning'
L.SecondaryScanDesc = 'Set whether to perform secondary scanning when in parties or raids.\n\nSecondary scanning checks the targets of all members in the group every second (by default), looking for your aura timers to provide additional tracking accuracy for broken timers. This is only required for Debuff timers as all Buffs on your group are tracked in real time by primary scanning.'

L.SecondaryScanRate = 'Secondary Scanning Rate'
L.SecondaryScanRateDesc = 'Set the delay (in seconds) between secondary scans.\n\nMore frequent scans will result in better accuracy at the cost of higher resource usage, less frequent scans will reduce usage but result in less accuracy for broken timers.\n\nRecommended: 1.0 - 1.5 seconds'
