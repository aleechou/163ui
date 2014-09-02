local XLoot = select(2, ...)

local function CompileLocales(locales)
	local L = locales[GetLocale()] and locales[GetLocale()] or locales.enUS
	if L ~= locales.enUS then
		setmetatable(L, { __index = locales.enUS })
		for k, v in pairs(L) do	
			if type(v) == 'table' then
				setmetatable(v, { __index = locales.enUS[k] })
			end
		end
	end
	return L
end

-- locales expects table: { enUS = {...}, ... }
function XLoot:Localize(name, locales)
	self["L_"..name] = CompileLocales(locales)
end

local locales = {
	enUS = {
		skin_svelte = "XLoot: Svelte",
		skin_legacy = "XLoot: Legacy",
		skin_smooth = "XLoot: Smooth",
	},
	-- Possibly localized
	ptBR = {},
	frFR = {},
	deDE = {},
	koKR = {},
	esMX = {},
	ruRU = {},
	zhCN = {},
	esES = {},
	zhTW = {},
}

-- Automatically inserted translations


locales.deDE["skin_legacy"] = "XLoot: Erbe" -- Needs review
locales.deDE["skin_smooth"] = "XLoot: Weich" -- Needs review
locales.deDE["skin_svelte"] = "XLoot: Schlank" -- Needs review

locales.koKR["skin_legacy"] = "XLoot: Legacy" -- Needs review
locales.koKR["skin_smooth"] = "XLoot: Smooth" -- Needs review
locales.koKR["skin_svelte"] = "XLoot: Svelte" -- Needs review


locales.ruRU["skin_legacy"] = "XLoot: Legacy"
locales.ruRU["skin_smooth"] = "XLoot: Smooth"
locales.ruRU["skin_svelte"] = "XLoot: Svelte"

locales.zhCN["skin_legacy"] = "XLoot: Legacy"
locales.zhCN["skin_smooth"] = "XLoot: Smooth"
locales.zhCN["skin_svelte"] = "XLoot: Svelte"


locales.zhTW["skin_legacy"] = "XLoot: 傳統" -- Needs review
locales.zhTW["skin_smooth"] = "XLoot: 滑順" -- Needs review
locales.zhTW["skin_svelte"] = "XLoot: 苗條" -- Needs review



XLoot.L = CompileLocales(locales)
