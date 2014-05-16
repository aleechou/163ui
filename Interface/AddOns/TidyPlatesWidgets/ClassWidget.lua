---------------
-- Class Widget
---------------
local classWidgetPath = "Interface\\Addons\\TidyPlatesWidgets\\ClassWidget\\"

--[[
local ClassIconTable = {
	DEATHKNIGHT = "Interface\\Icons\\Spell_Deathknight_ClassIcon",
	DRUID = "Interface\\Icons\\INV_Misc_MonsterClaw_04",
	WARLOCK = "Interface\\Icons\\Spell_Nature_FaerieFire",
	HUNTER = "Interface\\Icons\\INV_Weapon_Bow_07",
	MAGE = "Interface\\Icons\\INV_Staff_13",
	PRIEST = "Interface\\Icons\\INV_Staff_30",
	WARRIOR = "Interface\\Icons\\INV_Sword_27",
	SHAMAN = "Interface\\Icons\\Spell_Nature_BloodLust",
	PALADIN = "Interface\\AddOns\\addon\\UI-CharacterCreate-Classes_Paladin",
	ROGUE = "Interface\\AddOns\\addon\\UI-CharacterCreate-Classes_Rogue",
}

myframe.icon = myframe:CreateTexture(nil,"CENTER"); -- create texture as child of myframe

myframe.icon:SetAllPoints(myframe); -- copy dimensions of myframe to icon

local _,class = UnitClass("player"); -- get non-localized class name

myframe.icon:SetTexture("Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES"); -- this is the image containing all class icons

local coords = CLASS_ICON_TCOORDS[class]; -- get the coordinates of the class icon we want

myframe.icon:SetTexCoord(unpack(coords)); -- cut out the region with our class icon according to coords

--]]

local CachedUnitClass = TidyPlatesUtility.CachedUnitClass

local function UpdateClassWidget(self, unit, showFriendly)
	local class
	if unit then


		if showFriendly and unit.reaction == "FRIENDLY" and unit.type == "PLAYER" then
			--class = TidyPlatesUtility.GroupMembers.Class[unit.name]
			class = CachedUnitClass(unit.name) or TidyPlatesUtility.GroupMembers.Class[unit.name]
		elseif unit.type == "PLAYER" then class = unit.class end

		--class = "DRUID"

		if class and class ~= "UNKNOWN" then
			--self.Icon:SetTexture(ClassIconTable[class])
			self.Icon:SetTexture(classWidgetPath..class)
			self:Show()
		else self:Hide() end
	end

	--[[ Testing
	self.Icon:SetTexture(classWidgetPath.."WARRIOR")
	self:Show()
	--]]
end

local function CreateClassWidget(parent)
	local frame = CreateFrame("Frame", nil, parent)
	frame:SetWidth(24); frame:SetHeight(24)
	--[[
	frame.Border = frame:CreateTexture(nil, "OVERLAY")
	frame.Border:SetPoint("CENTER",frame)
	frame.Border:SetAllPoints(frame)
	frame.Border:SetTexture(classWidgetPath.."BORDER")
	--]]
	frame.Icon = frame:CreateTexture(nil, "ARTWORK")
	--[[
	frame.Icon:SetTexCoord( .1, .9, .1, .9 )
	frame.Icon:SetPoint("LEFT",frame, "LEFT", 1, 0)
	frame.Icon:SetPoint("RIGHT",frame, "RIGHT", -4, 0)
	frame.Icon:SetPoint("TOP",frame, "TOP", 0, -1)
	frame.Icon:SetPoint("BOTTOM",frame, "BOTTOM", 0, 4)
	--]]
	frame.Icon:SetAllPoints(frame)
	frame:Hide()
	frame.Update = UpdateClassWidget
	return frame
end

TidyPlatesWidgets.CreateClassWidget = CreateClassWidget