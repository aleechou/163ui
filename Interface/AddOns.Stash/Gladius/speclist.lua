
local GetSpellInfo
do
      local g = _G.GetSpellInfo
      GetSpellInfo = function(x)
	    return g(x) or '_'
      end
end

local L = Gladius.L

function Gladius:GetSpecList()
	return {      
		-- WARRIOR
		[GetSpellInfo(12294)]	= L["Arms"],				-- Mortal Strike
		[GetSpellInfo(56638)]	= L["Arms"],				-- Taste for Blood
		[GetSpellInfo(1464)]	= L["Arms"],				-- Slam
		[GetSpellInfo(7384)]	= L["Arms"],				-- Overpower
		[GetSpellInfo(12328)]	= L["Arms"],				-- Sweeping Strikes
		
		[GetSpellInfo(23881)]	= L["Fury"],				-- Bloodthirst
		[GetSpellInfo(100130)]	= L["Fury"],				-- Wild Strike
		[GetSpellInfo(96103)]	= L["Fury"],				-- Raging Blow
		[GetSpellInfo(85384)]	= L["Fury"],				-- Raging Blow OH
		
		[GetSpellInfo(23922)]	= L["Protection"],			-- Shield Slam
		[GetSpellInfo(2565)]	= L["Protection"],			-- Shield Block
		[GetSpellInfo(20243)]	= L["Protection"],			-- Devastate
		[GetSpellInfo(6572)]	= L["Protection"],			-- Revenge
		[GetSpellInfo(12975)]	= L["Protection"],			-- Last Stand
		
		-- PALADIN
		[GetSpellInfo(31935)]	= L["Protection"],		-- Avenger's Shield
		[GetSpellInfo(20473)]	= L["Holy"],			   -- Holy Shock
		--[GetSpellInfo(68020)]	= L["Retribution"],		-- Seal of Command
		[GetSpellInfo(35395)]	= L["Retribution"],		-- Crusader Strike
		[GetSpellInfo(53385)]	= L["Retribution"],		-- Divine Storm
		[GetSpellInfo(20066)]	= L["Retribution"],		-- Repentance
		[GetSpellInfo(85256)]	= L["Retribution"],		-- Templar's Verdict
		-- ROGUE
		[GetSpellInfo(1329)]	= L["Assassination"],	   -- Mutilate
		[GetSpellInfo(51690)]	= L["Combat"],			   -- Killing Spree
		[GetSpellInfo(13877)]	= L["Combat"],			   -- Blade Flurry
		[GetSpellInfo(13750)]	= L["Combat"],			   -- Adrenaline Rush
		[GetSpellInfo(16511)]	= L["Subtlety"],		   -- Hemorrhage
		[GetSpellInfo(36554)]	= L["Subtlety"],		   -- Shadowstep
		[GetSpellInfo(31223)]	= L["Subtlety"],		   -- Master of Subtlety
		-- PRIEST
		[GetSpellInfo(47540)]	= L["Discipline"],		-- Penance
		[GetSpellInfo(10060)]	= L["Discipline"],		-- Power Infusion
		[GetSpellInfo(33206)]	= L["Discipline"],		-- Pain Suppression
		--[GetSpellInfo(52795)]	= L["Discipline"],		-- Borrowed Time
		--[GetSpellInfo(57472)]	= L["Discipline"],		-- Renewed Hope
		[GetSpellInfo(47517)]	= L["Discipline"],		-- Grace
      [GetSpellInfo(34861)]	= L["Holy"],			   -- Circle of Healing
      --[GetSpellInfo(14751)]	= L["Holy"],			   -- Chakra
		[GetSpellInfo(47788)]	= L["Holy"],			   -- Guardian Spirit
		[GetSpellInfo(15487)]	= L["Shadow"],			   -- Silence
		[GetSpellInfo(34914)]	= L["Shadow"],			   -- Vampiric Touch	
		[GetSpellInfo(15407)]	= L["Shadow"],			   -- Mind Flay		
		[GetSpellInfo(15473)]	= L["Shadow"],			   -- Shadowform
		[GetSpellInfo(15286)]	= L["Shadow"],			   -- Vampiric Embrace
		-- DEATHKNIGHT
		[GetSpellInfo(55050)]	= L["Blood"],			   -- Heart Strike
		[GetSpellInfo(49016)]	= L["Blood"],			   -- Hysteria
		--[GetSpellInfo(53138)]	= L["Blood"],			   -- Abomination's Might
		--[GetSpellInfo(49203)]	= L["Frost"],			   -- Hungering Cold
		[GetSpellInfo(49143)]	= L["Frost"],			   -- Frost Strike
		[GetSpellInfo(49184)]	= L["Frost"],			   -- Howling Blast
		[GetSpellInfo(55610)]	= L["Frost"],			   -- Imp. Icy Talons
		[GetSpellInfo(55090)]	= L["Unholy"],			   -- Scourge Strike
		[GetSpellInfo(49222)]	= L["Unholy"],			   -- Bone Shield	
		-- MAGE
		[GetSpellInfo(44425)]	= L["Arcane"],			   -- Arcane Barrage
		--[GetSpellInfo(31583)]	= L["Arcane"],			   -- Arcane Empowerment
		[GetSpellInfo(44457)]	= L["Fire"],		   	-- Living Bomb
		[GetSpellInfo(31661)]	= L["Fire"],		   	-- Dragon's Breath
		[GetSpellInfo(11366)]	= L["Fire"],		   	-- Pyroblast
		[GetSpellInfo(11129)]	= L["Fire"],			   -- Combustion		
		[GetSpellInfo(44572)]	= L["Frost"],		   	-- Deep Freeze
		[GetSpellInfo(31687)]	= L["Frost"],		   	-- Summon Water Elemental
		[GetSpellInfo(11426)]	= L["Frost"],			   -- Ice Barrier		
		-- WARLOCK
		[GetSpellInfo(48181)]	= L["Affliction"],		-- Haunt
		[GetSpellInfo(30108)]	= L["Affliction"],		-- Unstable Affliction
		--[GetSpellInfo(59672)]	= L["Demonology"],		-- Metamorphosis
		[GetSpellInfo(50769)]	= L["Destruction"],		-- Chaos Bolt
		[GetSpellInfo(30283)]	= L["Destruction"],		-- Shadowfury
		--[GetSpellInfo(30299)]	= L["Destruction"],		-- Nether Protection
		[GetSpellInfo(17962)]	= L["Destruction"],		-- Conflagrate
		-- SHAMAN
		[GetSpellInfo(51490)]	= L["Elemental"],		   -- Thunderstorm
		[GetSpellInfo(16166)]	= L["Elemental"],		   -- Elemental Mastery
		[GetSpellInfo(51470)]	= L["Elemental"],		   -- Elemental Oath
		--[GetSpellInfo(30802)]	= L["Enhancement"],		-- Unleashed Rage
		[GetSpellInfo(51533)]	= L["Enhancement"],		-- Feral Spirit
		[GetSpellInfo(30823)]	= L["Enhancement"],		-- Shamanistic Rage
		[GetSpellInfo(17364)]	= L["Enhancement"],		-- Stormstrike
		[GetSpellInfo(60103)]	= L["Enhancement"],		-- Lava Lash
		[GetSpellInfo(61295)]	= L["Restoration"],		-- Riptide
		[GetSpellInfo(51886)]	= L["Restoration"],		-- Cleanse Spirit
		[GetSpellInfo(974)]	   = L["Restoration"],		-- Earth Shield		
		-- HUNTER
		[GetSpellInfo(19577)]	= L["Beast Mastery"],	-- Intimidation
		[GetSpellInfo(20895)]	= L["Beast Mastery"],	-- Spirit Bond
		[GetSpellInfo(19506)]	= L["Marksmanship"],	   -- Trueshot Aura
		[GetSpellInfo(34490)]	= L["Marksmanship"],	   -- Silencing Shot
		[GetSpellInfo(53209)]	= L["Marksmanship"],	   -- Chimera Shot
		[GetSpellInfo(19434)]	= L["Marksmanship"],    -- Aimed Shot
		[GetSpellInfo(53301)]	= L["Survival"],		   -- Explosive Shot
		[GetSpellInfo(19386)]	= L["Survival"],		   -- Wyvern Sting
		-- DRUID
		[GetSpellInfo(48505)]	= L["Balance"],			-- Starfall
		--[GetSpellInfo(50516)]	= L["Balance"],			-- Typhoon
		[GetSpellInfo(78674)]	= L["Balance"],			-- Starsurge
		[GetSpellInfo(33831)]	= L["Balance"],			-- Force of Nature
		[GetSpellInfo(24907)]	= L["Balance"],			-- Moonkin Form
		[GetSpellInfo(33876)]	= L["Feral"],			   -- Mangle (Cat)
		[GetSpellInfo(33878)]	= L["Feral"],			   -- Mangle (Bear)
		[GetSpellInfo(24932)]	= L["Feral"],			   -- Leader of the Pack
		[GetSpellInfo(18562)]	= L["Restoration"],		-- Swiftmend
		[GetSpellInfo(48438)]	= L["Restoration"],		-- Wild Growth		
		[GetSpellInfo(33891)]	= L["Restoration"],		-- Tree of Life		
		--[GetSpellInfo(65139)]	= L["Restoration"],		-- Tree of Life
	}
end
