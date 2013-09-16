local Ellipsis = LibStub('AceAddon-3.0'):GetAddon('Ellipsis')
local L = LibStub('AceLocale-3.0'):GetLocale('Ellipsis')

local aoeSpells = {
	['WARLOCK'] = {
		[5484] = 8, -- howl of terror
		[30283] = 3, -- shadowfury
		[47897] = 6, -- shadowflame
	},
	['DEATHKNIGHT'] = {
		[43265] = 10, -- death and decay
		[108201] = 10, -- desecrated ground
	},
	['DRUID'] = {
		[5209] = 6, -- challenging roar
		[106737] = 15, -- force of nature
		[106898] = 8, -- stampeding roar
		[99] = 3, -- disorientating roar
	},
	['HUNTER'] = {
		[1499] = 60, -- freezing trap
		[13795] = 60, -- immolation trap
		[13809] = 60 , -- ice trap
		[13813] = 60, -- explosive trap
		[13809] = 60, -- frost trap
		[34600] = 60, -- snake trap
	},
	['MAGE'] = {
		[11113] = 3, -- blast wave
		[120] = 8, -- cone of cold
		[122] = 8, -- frost nova
		[31661] = 4, -- dragon's breath
		[80353] = 40, -- time warp
		[55342] = 30, -- mirror image
		[113724] = 10, -- ring of frost
	},
	['MONK'] = {
		[123904] = 45, -- xuen, the white tiger
	},
	['PALADIN'] = {
		[26573] = 9, -- consecration
	},
	['PRIEST'] = {
		[8122] = 8, -- psychic scream
		[64843] = 8, -- divine hymn
		[34433] = 12, -- shadow fiend
		[108921] = 10, -- psyfiend
	},
	['WARRIOR'] = {
		[1161] = 6, -- challenging shout
		[1160] = 30, -- demo shout
		[5246] = 8, -- intimidating shout
		[12323] = 6, -- piercing howl
		[6343] = 30, -- thunder clap
		[46968] = 4, -- shockwave
	},
	['ROGUE'] = {
		[1725] = 10, -- distract
	},
	['SHAMAN'] = {
		[108269] = 5, -- capacitor
		[8177] = 15, -- grounding
		[120668] = 10, -- stormlash
		[98008] = 6, 	-- spirit link
		[108273] = 6, 	-- windwalk
		[2484] = 20, -- earthbind
		[8143] = 6, -- tremor
		[2062] = 60, -- earth elemental
		[51485] = 20, 	-- earthgrab
		[2894] = 60, -- fire elemental
		[8190] = 60, -- magma
		[3599] = 60, -- searing
		[5394] = 15, -- healing stream
		[16190] = 16, -- mana tide
		[108280] = 10, 	-- healing tide
		[32182] = 40, 	-- heroism
		[2825] = 40, 	-- bloodlust
		[51533] = 30,	-- feral spirit (wolves)
	},
}

local uniqueSpells = {
	['WARLOCK'] = {
		[6358] = true, -- seduction
		[710] = true, -- banish
		[1098] = true, -- enslave demon
	},
	['DRUID'] = {
		[2637] = true, -- hibernate
	},
	['PRIEST'] = {
		[33076] = true, -- prayer of mending
	},
	['HUNTER'] = {
		[1130] = true, -- hunter's mark
	},
	['MAGE'] = {
		[118] = true, -- polymorph
		[28271] = true, -- polymorph: turtle
		[28272] = true, -- polymorph: pig
		[31589] = true, -- slow
		[61025] = true, -- polymorph: serpent
		[61305] = true, -- polymorph: cat
		[61721] = true, -- polymorph: rabbit
		[61780] = true, -- polymorph: turkey (wth)
	},
	['ROGUE'] = {
		[6770] = true, -- sap
	},
	['SHAMAN'] = {
		[974] = true, -- earth shield
		[51514] = true, -- hex
	},
}

local totemGroups = { -- Fire = 1 Earth = 2 Water = 3 Air = 4 (Blizzard's ordering)
	[108269] = 4, -- capacitor
	[8177] = 4, -- grounding
	[120668] = 4, -- stormlash
	[98008] = 4, 	-- spirit link
	[108273] = 6, 	-- windwalk
	[2484] = 2, -- earthbind
	[8143] = 2, -- tremor
	[2062] = 2, -- earth elemental
	[51485] = 2, 	-- earthgrab
	[2894] = 1, -- fire elemental
	[8190] = 1, -- magma
	[3599] = 1, -- searing
	[5394] = 3, -- healing stream
	[16190] = 3, -- mana tide
	[108280] = 3, 	-- healing tide
}

function Ellipsis:DefineClassSpells()
	local class = select(2, UnitClass('player'))
	local aoe = self.aoeSpells

	-- Fill out class-specific aoe spells
	if (aoeSpells[class]) then
		for spellID, duration in pairs(aoeSpells[class]) do
			aoe[spellID] = {duration, select(3, GetSpellInfo(spellID))}
		end
	end

	-- Fill out unique (one existance total) spells for class
	if (uniqueSpells[class]) then
		for spellID in pairs(uniqueSpells[class]) do
			self.uniqueSpells[spellID] = true
		end
	end

	-- Special cases for certain classes
	if (class == 'WARLOCK') then -- setup enslave demon
		self.isWarlock = true
		self.specialSpell = 1098
	elseif (class == 'SHAMAN') then -- used when checking for totemic call (as it will kill a bunch of timers)
		self.isShaman = true
		self.specialSpell = 36936

		for spellID, totemType in pairs(totemGroups) do
			self.totemGroups[spellID] = totemType
		end
	end
end
