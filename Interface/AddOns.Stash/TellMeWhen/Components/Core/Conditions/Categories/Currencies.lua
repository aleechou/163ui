﻿-- --------------------
-- TellMeWhen
-- Originally by Nephthys of Hyjal <lieandswell@yahoo.com>

-- Other contributions by:
--		Sweetmms of Blackrock, Oozebull of Twisting Nether, Oodyboo of Mug'thol,
--		Banjankri of Blackrock, Predeter of Proudmoore, Xenyr of Aszune

-- Currently maintained by
-- Cybeloras of Aerie Peak/Detheroc/Mal'Ganis
-- --------------------


if not TMW then return end

local TMW = TMW
local L = TMW.L
local print = TMW.print

local CNDT = TMW.CNDT
local Env = CNDT.Env

local currencies = {
	-- currencies were extracted using the script in the /Scripts folder (source is wowhead)
	-- make sure and order them here in a way that makes sense (most common first, etc)
	{
		ID = "CURRENCIES",
		order = 7,
		name = L["CNDTCAT_CURRENCIES"],
		
		395,	--Justice Points
		396,	--Valor Points
		392,	--Honor Points
		390,	--Conquest Points
		--692,	--Conquest Random BG Meta
		"SPACE",
		391,	--Tol Barad Commendation
		416,	--Mark of the World Tree
		241,	--Champion\'s Seal
		515,	--Darkmoon Prize Ticket
		"SPACE",
		738,	--Lesser Charm of Good Fortune
		697,	--Elder Charm of Good Fortune
		752,	--Mogu Rune of Fate
		"SPACE",
		614,	--Mote of Darkness
		615,	--Essence of Corrupted Deathwing
		"SPACE",
		698,	--Zen Jewelcrafter\'s Token
		361,	--Illustrious Jewelcrafter\'s Token
		402,	--Ironpaw Token
		61,		--Dalaran Jewelcrafter\'s Token
		81,		--Epicurean\'s Award
	},
	{
		ID = "ARCHFRAGS",
		order = 8,
		name = L["CNDTCAT_ARCHFRAGS"],
		
		384,	--Dwarf Archaeology Fragment
		398,	--Draenei Archaeology Fragment
		393,	--Fossil Archaeology Fragment
		394,	--Night Elf Archaeology Fragment
		397,	--Orc Archaeology Fragment
		385,	--Troll Archaeology Fragment
		
		400,	--Nerubian Archaeology Fragment
		399,	--Vrykul Archaeology Fragment
		
		401,	--Tol\'vir Archaeology Fragment
		
		676,	--Pandaren Archaeology Fragment
		677,	--Mogu Archaeology Fragment
		754,	--Mantid Archaeology Fragment
	}
}


local eventsFunc = function(ConditionObject, c)
	return
		ConditionObject:GenerateNormalEventString("CURRENCY_DISPLAY_UPDATE")
end

local spacenext
Env.GetCurrencyInfo = GetCurrencyInfo
for i, currenciesSub in ipairs(currencies) do
	local ConditionCategory = CNDT:GetCategory(currenciesSub.ID, currenciesSub.order, currenciesSub.name, false, false)
	for i, id in ipairs(currenciesSub) do
		if id == "SPACE" then
			ConditionCategory:RegisterSpacer(i + 0.5)
		else
			ConditionCategory:RegisterCondition(i, "CURRENCY" .. id, {
				range = 500,
				unit = false,
				funcstr = [[select(2, GetCurrencyInfo(]] .. id .. [[)) c.Operator c.Level]],
				tcoords = CNDT.COMMON.standardtcoords,
				hidden = true,
				events = eventsFunc,
			})
			spacenext = nil
		end
	end
end

function CNDT:CURRENCY_DISPLAY_UPDATE()
	for i, currenciesSub in ipairs(currencies) do
		for _, id in ipairs(currenciesSub) do
			if id ~= "SPACE" then
				local data = CNDT.ConditionsByType["CURRENCY" .. id]
				local name, amount, texture, _, _, totalMax = GetCurrencyInfo(id)

				if name ~= "" then
					data.text = name
					data.icon = texture
					data.hidden = false
					if TMW.IE then
						TMW.IE.db.locale.Currencies[id] = name .. "^" .. texture
					end
					--[[if totalMax > 0 then -- not using this till blizzard fixes the bug where it shows the honor and conquest caps as 40,000
						data.max = totalMax
					end]]

				elseif TMW.IE then

					local cachedCurrencyData = TMW.IE.db.locale.Currencies[id]
					if cachedCurrencyData then
						local name, texture = strmatch(cachedCurrencyData, "(.*)^(.*)")
						if name and texture then
							data.text = name
							data.icon = texture
							data.hidden = false
						end
					end
				end
			end
		end
	end
end

CNDT:RegisterEvent("CURRENCY_DISPLAY_UPDATE")
CNDT:CURRENCY_DISPLAY_UPDATE()

TMW:RegisterCallback("TMW_OPTIONS_LOADING", function()
	TMW.IE:RegisterDatabaseDefaults{
		locale = {
			Currencies	= {

			},
		},
	}

	TMW.IE:RegisterUpgrade(62217, {
		global = function(self)
			TMW.IE.db.global.Currencies = nil
		end,
	})
end)

TMW:RegisterCallback("TMW_OPTIONS_LOADED", CNDT, "CURRENCY_DISPLAY_UPDATE")