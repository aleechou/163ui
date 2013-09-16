-- Default locals
local L = LibStub("AceLocale-3.0"):NewLocale("Ellipsis", "enUS", true)

if not L then return end -- abort if not using these locals

L.UpdatingDatabase = 'Updating database to new version...'

L.Targets = 'Targets'
L.Prominence = 'Prominent Targets'
L.Cooldowns = 'Cooldowns'

L.NoTarget = 'No Target'

L.TimeStringSecTenth = '%.1fs'
L.TimeStringSec = '%ds'
L.TimeStringMinSec = '%dm %ds'
L.TimeStringMin = '%dm'
L.TimeStringHour = '%dhr'

L.LeftClickToAnnounce = 'Left-Click to announce.'
L.RightClickToCancel = 'Right-Click to cancel timer.'
L.ShiftRightClickToBlock = 'Shift+Right-Click to block this spell.'
L.CtrlRightClickToDestroyTotem = 'Ctrl+Right-Click to destroy this totem.'

L.DNTWontTrack = 'Timers for %s will no longer be tracked by Ellipsis.'
L.CDDNTWontTrack = 'Cooldowns for %s will no longer be tracked by Ellipsis.'

L.EllipsisOptionsNotEnabled = 'Please enable the Ellipsis_Options addon for option configuration.'

L.NotifyExpiredTimer = '%s has EXPIRED on %s!'
L.NotifyBrokenTimer = '%s has BROKEN on %s!'
L.NotifyCDExpiredTimer = '%s cooldown has completed!'

L.TimerAnnounceAoeGhost = 'My %s has expired.'
L.TimerAnnounceAoeActive = 'My %s will expire in %d:%02d.'

L.TimerAnnounceNormalGhost = 'My %s has expired on %s.'
L.TimerAnnounceNormalActive = 'My %s will expire on %s in %d:%02d.'

L.Shocks = 'Shocks'
L.Traps = 'Traps'

L.SearchPatternCooldown = 'cooldown'
L.SearchPatternRecharge = 'recharge'

L.CDTimerAnnouncePet = "My pet's %s cooldown will end in %d:%02d."
L.CDTimerAnnounceSpellItem = 'My %s cooldown will end in %d:%02d.'

L.TimeRemaining = 'Time Remaining: %d:%02d'

L.Potions = 'Potions'
L.HealthstonesGems = 'Healthstones and Mana Gems'
L.Soulstones = 'Soulstones'

L.ManaPotion = 'Mana Potion$'
L.HealingPotion = 'Healing Potion$'
L.ProtPotion = 'Protection Potion$'
L.Healthstone = 'Healthstone$'
L.FelBlossom = '^Fel Blossom$'
L.NightmareSeed = '^Nightmare Seed$'
L.FlameCap = '^Flame Cap$'
L.Soulstone = 'Soulstone$'
L.ManaAgate = '^Mana Agate$'
L.ManaJade = '^Mana Jade$'
L.ManaCitrine = '^Mana Citrine$'
L.ManaRuby = '^Mana Ruby$'
L.ManaEmerald = '^Mana Emerald$'
L.ManaSapphire = '^Mana Sapphire$'
