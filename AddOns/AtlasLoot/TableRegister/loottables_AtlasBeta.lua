-- $Id: loottables_AtlasBeta.lua 4163 2013-03-19 15:06:21Z dynaletik $
--[[
loottables.en.lua
This file assigns a title to every loot table.  The primary use of this table
is in the search function, as when iterating through the loot tables there is no
inherant title to the loot table, given the origins of the mod as an Atlas plugin.
]]

-- Invoke libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");
local ALIL = AtlasLoot_IngameLocales;
local BabbleBoss = AtlasLoot_GetLocaleLibBabble("LibBabble-Boss-3.0")
local BabbleInventory = AtlasLoot_GetLocaleLibBabble("LibBabble-Inventory-3.0")

-- Using alchemy skill to get localized rank
local JOURNEYMAN = select(2, GetSpellInfo(3101));
local EXPERT = select(2, GetSpellInfo(3464));
local ARTISAN = select(2, GetSpellInfo(11611));
local MASTER = select(2, GetSpellInfo(28596));

local ALCHEMY, APPRENTICE = GetSpellInfo(2259);
local BLACKSMITHING = GetSpellInfo(2018);
local ARMORSMITH = GetSpellInfo(9788);
local WEAPONSMITH = GetSpellInfo(9787);
local AXESMITH = GetSpellInfo(17041);
local HAMMERSMITH = GetSpellInfo(17040);
local SWORDSMITH = GetSpellInfo(17039);
local COOKING = GetSpellInfo(2550);
local ENCHANTING = GetSpellInfo(7411);
local ENGINEERING = GetSpellInfo(4036);
local GNOMISH = GetSpellInfo(20220);
local GOBLIN = GetSpellInfo(20221);
local FIRSTAID = GetSpellInfo(3273);
local FISHING = GetSpellInfo(63275);
local INSCRIPTION = GetSpellInfo(45357);
local JEWELCRAFTING = GetSpellInfo(25229);
local LEATHERWORKING = GetSpellInfo(2108);
local DRAGONSCALE = GetSpellInfo(10656);
local ELEMENTAL = GetSpellInfo(10658);
local TRIBAL = GetSpellInfo(10660);
local MINING = GetSpellInfo(2575);
local TAILORING = GetSpellInfo(3908);
local MOONCLOTH = GetSpellInfo(26798);
local SHADOWEAVE = GetSpellInfo(26801);
local SPELLFIRE = GetSpellInfo(26797);


AtlasLoot_LootTableRegister_AtlasBeta = {
	["Instances"] = {
		--[[ example
			-- ["Info"] is optional
			
			["BlackrockCaverns"] = {
				["Bosses"] = {
					{ "BlackrockCavernsRomogg", 2 },
					{ "BlackrockCavernsCorla", 3 },
					{ "BlackrockCavernsSteelbender", 4 },
					{ "BlackrockCavernsBeauty", 5 },
					{ "BlackrockCavernsLordObsidius", 6 },
					{ "BlackrockCavernsTrash", 11 },
				},
				["Info"] = { ALIL["Blackrock Caverns"], "AtlasLootCataclysm", mapname = "BlackrockCaverns" },
			},
		]]--
		},
}

local mergeFinish = false
function AtlasLoot:LootTableRegister_Merge()
	if not mergeFinish then 
		for k,v in pairs(AtlasLoot_LootTableRegister_AtlasBeta) do
			for i,j in pairs(v) do
				if j["Bosses"] then 
					AtlasLoot_LootTableRegister_AtlasBeta[k][i]["Bosses"] = j["Bosses"]
				end
				if j["Info"] then 
					AtlasLoot_LootTableRegister_AtlasBeta[k][i]["Info"] = j["Info"]
				end
			end
		end
		mergeFinish = true
	end
end