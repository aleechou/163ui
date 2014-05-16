local _
local _G = _G

local classColors = {}
do
	for class, c in pairs(CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS) do
		classColors[class] = format('|cff%02x%02x%02x', c.r*255, c.g*255, c.b*255)
	end
end

local function SetCaster(self, unit, index, filter)
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable = UnitAura(unit, index, filter)
	if unitCaster then
		local uname, urealm = UnitName(unitCaster)
		local _, uclass = UnitClass(unitCaster)
		if urealm then uname = uname..'-'..urealm end
		--if IsAltKeyDown() then
		self:AddDoubleLine(string.format(Castby_Text,(classColors[uclass] or '|cffffffff') .. uname .. '|r'));
		self:Show()
		--end
	end
end

hooksecurefunc(GameTooltip, 'SetUnitAura', SetCaster)
hooksecurefunc(GameTooltip, 'SetUnitBuff', function(self, unit, index, filter)
	filter = filter and ('HELPFUL '..filter) or 'HELPFUL'
	SetCaster(self, unit, index, filter)
end)
hooksecurefunc(GameTooltip, 'SetUnitDebuff', function(self, unit, index, filter)
	filter = filter and ('HARMFUL '..filter) or 'HARMFUL'
	SetCaster(self, unit, index, filter)
end)

hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
	local id = select(11,UnitBuff(...))
	if id then
	--if id and IsAltKeyDown() then
		self:AddDoubleLine(SpellNum,id)
		self:Show()
	end
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
	local id = select(11,UnitDebuff(...))
	if id then
	--if id and IsAltKeyDown() then
		self:AddDoubleLine(SpellNum,id)
		self:Show()
	end
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
	local id = select(11,UnitAura(...))
	if id then
	--if id and IsAltKeyDown() then
		self:AddDoubleLine(SpellNum,id)
		self:Show()
	end
end)

hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
	if string.find(link,"^spell:") then
	--if string.find(link,"^spell:") and IsAltKeyDown() then
		local id = string.sub(link,7)
		ItemRefTooltip:AddDoubleLine(SpellNum,id)
		ItemRefTooltip:Show()
	end
end)

--Taint and skill hide alt + show
GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	local id = select(3,self:GetSpell())
	if id and IsAltKeyDown() then
		self:AddDoubleLine(SpellNum,id)
		self:Show()
	end
end)