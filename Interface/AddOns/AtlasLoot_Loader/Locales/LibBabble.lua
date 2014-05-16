-- $Id: LibBabble.lua 3725 2012-04-23 23:39:19Z lag123 $
--[[
AtlasLoot_GetLocaleLibBabble(typ)
Get english translations for non translated things. (Combines Locatet and English table)
Only Useable with LibBabble
function AtlasLoot_GetLocaleLibBabble(typ)
	local tab = LibStub(typ):GetBaseLookupTable()
	local loctab = LibStub(typ):GetUnstrictLookupTable()
	local rettab = {}
	
	setmetatable(rettab, {
		__index = loctab or tab
	})
	
	return rettab
end
]]
--[[
AtlasLoot_GetLocaleLibBabble(typ)
Get english translations for non translated things. (Combines Locatet and English table)
Only Useable with LibBabble
]]
function AtlasLoot_GetLocaleLibBabble(typ)
	local rettab = {}
	local tab = LibStub(typ):GetBaseLookupTable()
	local loctab = LibStub(typ):GetUnstrictLookupTable()
	if not tab or not loctab then
		return setmetatable(rettab, {
			__index = function(a,b) return typ.." ERROR" end
		})
	end
	for k,v in pairs(loctab) do
		rettab[k] = v;
	end
	for k,v in pairs(tab) do
		if not rettab[k] then
			rettab[k] = v;
		end
	end
	return rettab
end

