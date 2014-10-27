local AL = {}
_G.AtlasLoot.Locales = AL

--lua
local rawset = rawset

-- WoW
local GetLocale = GetLocale

function _G.AtlasLoot.GetLocales(locale)
	return GetLocale() == locale and AL or nil
end

setmetatable(AL, {
	__index = function(self, key)
		error(format("%s LOCALE NOT FOUND", key or "nil"))
		--self[key] = key or ""
		return key or "LOCERROR"
	end,
	__newindex = function(self, key, value)
		rawset(self, key, value == true and key or value)
	end,
	}
)
