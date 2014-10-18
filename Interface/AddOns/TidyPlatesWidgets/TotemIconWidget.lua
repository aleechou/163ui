--------------------
-- Totem Icon Widget
--------------------
local classWidgetPath = "Interface\\Addons\\TidyPlatesWidgets\\ClassWidget\\"
local TotemIcons, TotemTypes = {}, {}

local AIR_TOTEM, EARTH_TOTEM, FIRE_TOTEM, WATER_TOTEM = 1, 2, 3, 4

local function SetTotemInfo(spellid, totemType)
	local name, _, icon = GetSpellInfo(spellid)
	if name and icon and totemType then
		TotemIcons[name] = icon
		TotemTypes[name] = totemType
	end
end

----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------

if (tonumber((select(2, GetBuildInfo()))) >= 15799) then 
	-- Mists of Pandaria 5.x Specific Totems

	SetTotemInfo(120668, AIR_TOTEM) --  Stormlash
	SetTotemInfo(108273, AIR_TOTEM) --  Windwalk
	SetTotemInfo(98008, AIR_TOTEM)  --  Spirit Link
	SetTotemInfo(108269, AIR_TOTEM)  --  Capacitor Totem

	SetTotemInfo(51485, EARTH_TOTEM)  -- Earthgrab Totem
	SetTotemInfo(108270, EARTH_TOTEM)  -- Stone Bulwark Totem

	SetTotemInfo(108280, WATER_TOTEM)  -- Healing Tide Totem

else	
	-- Cataclysm 4.x Specific Totems
	SetTotemInfo(8512,AIR_TOTEM) -- Windfury Totem
	SetTotemInfo(3738,AIR_TOTEM) -- Wrath of Air Totem
	
	SetTotemInfo(5730,EARTH_TOTEM) -- Stoneclaw Totem
	SetTotemInfo(8071,EARTH_TOTEM) -- Stoneskin Totem
	SetTotemInfo(8075,EARTH_TOTEM)  -- Strength of Earth Totem
	
	SetTotemInfo(8227,FIRE_TOTEM) -- Flametongue Totem

	SetTotemInfo(8184,WATER_TOTEM)  -- Elemental Resistance Totem
	SetTotemInfo(5675,WATER_TOTEM) -- Mana Spring Totem
	SetTotemInfo(87718,WATER_TOTEM) -- Totem of Tranquil Mind
end

	-- Common Totems
	SetTotemInfo(8177, AIR_TOTEM) -- Grounding Totem
	
	SetTotemInfo(2062,EARTH_TOTEM) -- Earth Elemental Totem
	SetTotemInfo(2484,EARTH_TOTEM) -- Earthbind Totem
	SetTotemInfo(8143,EARTH_TOTEM) -- Tremor Totem
	
	SetTotemInfo(2894, FIRE_TOTEM)  -- Fire Elemental Totem
	SetTotemInfo(8190, FIRE_TOTEM)  -- Magma Totem
	SetTotemInfo(3599, FIRE_TOTEM)  -- Searing Totem

	SetTotemInfo(5394, WATER_TOTEM)  -- Healing Stream Totem
	SetTotemInfo(16190, WATER_TOTEM)  -- Mana Tide Totem
	
----------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------	

local function IsTotem(name) if name then return (TotemIcons[name] ~= nil) end end
local function TotemSlot(name) if name then return TotemTypes[name] end end

local function UpdateTotemIconWidget(self, unit)
	local icon = TotemIcons[unit.name]
	if icon then
		self.Icon:SetTexture(icon)
		self:Show()
	else 
		self:Hide() 
	end
end

local function CreateTotemIconWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(19); frame:SetHeight(18)
	
	frame.Overlay = frame:CreateTexture(nil, "OVERLAY")
	frame.Overlay:SetPoint("CENTER",frame, 1, -1)
	frame.Overlay:SetWidth(24); frame.Overlay:SetHeight(24)
	frame.Overlay:SetTexture(classWidgetPath.."BORDER")
	--frame.Overlay:SetAllPoints(frame)
	
	frame.Icon = frame:CreateTexture(nil, "ARTWORK")
	frame.Icon:SetPoint("CENTER",frame)
	frame.Icon:SetTexCoord(.07, 1-.07, .07, 1-.07)  -- obj:SetTexCoord(left,right,top,bottom)
	--frame.Icon:SetWidth(46); frame.Icon:SetHeight(47)
	frame.Icon:SetAllPoints(frame)
	
	frame:Hide()
	frame.Update = UpdateTotemIconWidget
	return frame
end

TidyPlatesWidgets.CreateTotemIconWidget = CreateTotemIconWidget
TidyPlatesUtility.IsTotem = IsTotem
TidyPlatesUtility.TotemSlot = TotemSlot
