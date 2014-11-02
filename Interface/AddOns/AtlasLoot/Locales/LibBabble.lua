local AtlasLoot = _G.AtlasLoot
local LibBabble = {}
AtlasLoot.LibBabble = LibBabble

-- lua
local LibStub = LibStub
local setmetatable, pairs = setmetatable, pairs

function LibBabble:Get(typ)
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