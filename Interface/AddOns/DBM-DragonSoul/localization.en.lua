local L

-------------
-- Morchok --
-------------
L= DBM:GetModLocalization(311)

L:SetWarningLocalization({
	KohcromWarning	= "%s: %s"--Bossname, spellname. At least with this we can get boss name from casts in this one, unlike a timer started off the previous bosses casts.
})

L:SetTimerLocalization({
	KohcromCD		= "Kohcrom mimicks %s",--Universal single local timer used for all of his mimick timers
})

L:SetOptionLocalization({
	KohcromWarning	= "Show warnings for $journal:4262 mimicking abilities.",
	KohcromCD		= "Show timers for $journal:4262's next ability mimick.",
	RangeFrame		= "Show range frame (5) for achievement."
})

L:SetMiscLocalization({
})

---------------------
-- Warlord Zon'ozz --
---------------------
L= DBM:GetModLocalization(324)

L:SetOptionLocalization({
	ShadowYell			= "Yell when you are affected by $spell:103434<br/>(Heroic difficulty only)",
	CustomRangeFrame	= "Range Frame options (Heroic only)",
	Never				= "Disabled",
	Normal				= "Normal Range Frame",
	DynamicPhase2		= "Phase2 Debuff Filtering",
	DynamicAlways		= "Always Debuff Filtering"
})

L:SetMiscLocalization({
	voidYell	= "Gul'kafh an'qov N'Zoth."--Start translating the yell he does for Void of the Unmaking cast, the latest logs from DS indicate blizz removed the UNIT_SPELLCAST_SUCCESS event that detected casts. sigh.
})

-----------------------------
-- Yor'sahj the Unsleeping --
-----------------------------
L= DBM:GetModLocalization(325)

L:SetWarningLocalization({
	warnOozesHit	= "%s absorbed %s"
})

L:SetTimerLocalization({
	timerOozesActive	= "Oozes Attackable",
	timerOozesReach		= "Oozes Reach Boss"
})

L:SetOptionLocalization({
	warnOozesHit		= "Announce what oozes hit the boss",
	timerOozesActive	= "Show timer for when Oozes become attackable",
	timerOozesReach		= "Show timer for when Oozes reach Yor'sahj",
	RangeFrame			= "Show range frame (4) for $spell:104898<br/>(Normal+ difficulty)"
})

L:SetMiscLocalization({
	Black			= "|cFF424242black|r",
	Purple			= "|cFF9932CDpurple|r",
	Red				= "|cFFFF0404red|r",
	Green			= "|cFF088A08green|r",
	Blue			= "|cFF0080FFblue|r",
	Yellow			= "|cFFFFA901yellow|r"
})

-----------------------
-- Hagara the Binder --
-----------------------
L= DBM:GetModLocalization(317)

L:SetWarningLocalization({
	WarnPillars				= "%s: %d left",
	warnFrostTombCast		= "%s in 8 sec"
})

L:SetTimerLocalization({
	TimerSpecial			= "First Special"
})

L:SetOptionLocalization({
	WarnPillars				= "Announce how many $journal:3919 or $journal:4069 are left",
	TimerSpecial			= "Show timer for first special ability cast",
	RangeFrame				= "Show range frame: (3) for $spell:105269, (10) for $journal:4327",
	AnnounceFrostTombIcons	= "Announce icons for $spell:104451 targets to raid chat<br/>(requires raid leader)",
	warnFrostTombCast		= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(104448),
	SetIconOnFrostTomb		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(104451),
	SetIconOnFrostflake		= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(109325),
	SpecialCount			= "Play countdown sound for $spell:105256 or $spell:105465",
	SetBubbles				= "Automatically disable chat bubbles when $spell:104451 available<br/>(restores them when combat ends)"
})

L:SetMiscLocalization({
	TombIconSet				= "Frost Beacon icon {rt%d} set on %s"
})

---------------
-- Ultraxion --
---------------
L= DBM:GetModLocalization(331)

L:SetWarningLocalization({
	specWarnHourofTwilightN		= "%s (%d) in 5s"--spellname Count
})

L:SetTimerLocalization({
	TimerCombatStart	= "Ultraxion Active"
})

L:SetOptionLocalization({
	TimerCombatStart	= "Show timer for Ultraxion RP",
	ResetHoTCounter		= "Restart Hour of Twilight counter",--$spell doesn't work in this function apparently so use typed spellname for now.
	Never				= "Never",
	ResetDynamic		= "Reset in sets of 3/2 (heroic/normal)",
	Reset3Always		= "Always Reset in sets of 3",
	SpecWarnHoTN		= "Special warn 5s before Hour of Twilight. If counter reset is Never, this follows 3set rule",
	One					= "1 (ie 1 4 7)",
	Two					= "2 (ie 2 5)",
	Three				= "3 (ie 3 6)"
})

L:SetMiscLocalization({
	Pull				= "I sense a great disturbance in the balance approaching. The chaos of it burns my mind!"
})

-------------------------
-- Warmaster Blackhorn --
-------------------------
L= DBM:GetModLocalization(332)

L:SetWarningLocalization({
	SpecWarnElites	= "Twilight Elites!"
})

L:SetTimerLocalization({
	TimerAdd			= "Next Elites"
})

L:SetOptionLocalization({
	TimerAdd			= "Show timer for next Twilight Elites spawn",
	SpecWarnElites		= "Show special warning for new Twilight Elites",
	SetTextures			= "Automatically disable projected textures in phase 1<br/>(returns it to enabled in phase 2)"
})

L:SetMiscLocalization({
	SapperEmote			= "A drake swoops down to drop a Twilight Sapper onto the deck!",
	Broadside			= "spell:110153",
	DeckFire			= "spell:110095",
	GorionaRetreat			= "screeches in pain and retreats into the swirling clouds"
})

-------------------------
-- Spine of Deathwing  --
-------------------------
L= DBM:GetModLocalization(318)

L:SetWarningLocalization({
	warnSealArmor			= "%s",
	SpecWarnTendril			= "Get Secured!"
})

L:SetOptionLocalization({
	warnSealArmor			= DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast:format(105847),
	SpecWarnTendril			= "Show special warning when you are missing $spell:105563 debuff",
	InfoFrame				= "Show info frame for players without $spell:105563",
	SetIconOnGrip			= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(105490),
	ShowShieldInfo			= "Show absorb bar for $spell:105479<br/>(Ignores boss health frame option)"
})

L:SetMiscLocalization({
	Pull			= "The plates! He's coming apart! Tear up the plates and we've got a shot at bringing him down!",
	NoDebuff		= "No %s",
	PlasmaTarget	= "Searing Plasma: %s",
	DRoll			= "about to roll",
	DLevels			= "levels out"
})

---------------------------
-- Madness of Deathwing  -- 
---------------------------
L= DBM:GetModLocalization(333)

L:SetOptionLocalization({
	RangeFrame			= "Show dynamic range frame based on player debuff status for<br/>$spell:108649 on Heroic difficulty",
	SetIconOnParasite	= DBM_CORE_AUTO_ICONS_OPTION_TEXT:format(108649)
})

L:SetMiscLocalization({
	Pull				= "You have done NOTHING. I will tear your world APART."
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("DSTrash")

L:SetGeneralLocalization({
	name =	"Dragonsoul Trash"
})

L:SetWarningLocalization({
	DrakesLeft			= "Twilight Assaulter remaining: %d"
})

L:SetTimerLocalization({
	timerRoleplay		= GUILD_INTEREST_RP,
	TimerDrakes			= "%s"--spellname from mod
})

L:SetOptionLocalization({
	DrakesLeft			= "Announce how many Twilight Assaulters remain",
	TimerDrakes			= "Show timer for when Twilight Assaulters $spell:109904"
})

L:SetMiscLocalization({
	firstRP				= "Praise the Titans, they have returned!",
	UltraxionTrash		= "It is good to see you again, Alexstrasza. I have been busy in my absence.",
	UltraxionTrashEnded = "Mere whelps, experiments, a means to a greater end. You will see what the research of my clutch has yielded."
})