if not CoreDependCall then
    CoreDependCall = function(addon, func) if IsAddOnLoaded(addon) then func() end end
end

CoreDependCall("Grid", function()

local GridFrame = Grid:GetModule("GridFrame")

GridClickSets = Grid:NewModule("GridClickSets")

function GridFrameDropDown_Initialize(self)
	local unit = self:GetParent().unit;
	if ( not unit ) then
		return;
	end
	local menu;
	local name;
	local id = nil;
	if ( UnitIsUnit(unit, "player") ) then
		menu = "SELF";
	elseif ( UnitIsUnit(unit, "vehicle") ) then
		-- NOTE: vehicle check must come before pet check for accuracy's sake because
		-- a vehicle may also be considered your pet
		menu = "VEHICLE";
	elseif ( UnitIsUnit(unit, "pet") ) then
		menu = "PET";
	elseif ( UnitIsPlayer(unit) ) then
		id = UnitInRaid(unit);
		if ( id ) then
			menu = "RAID_PLAYER";
			name = GetRaidRosterInfo(id);
		elseif ( UnitInParty(unit) ) then
			menu = "PARTY";
		else
			menu = "PLAYER";
		end
	else
		menu = "TARGET";
		name = RAID_TARGET_ICON;
	end
	if ( menu ) then
		UnitPopup_ShowMenu(self, menu, unit, name, id);
	end
end

local function initializeFrame(gridFrameObj, frame)
	frame.dropDown = CreateFrame("Frame", frame:GetName().."DropDown", frame, "UIDropDownMenuTemplate");
	frame.dropDown:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 0, 2);
	tinsert(UnitPopupFrames, frame.dropDown:GetName());
	UIDropDownMenu_Initialize(frame.dropDown, GridFrameDropDown_Initialize, "MENU");
	frame.menu = function()
		ToggleDropDownMenu(1, nil, frame.dropDown, frame:GetName(), 0, 0);
	end
	frame:SetAttribute("*type2", "menu");
	frame.dropDown:Hide();
	GridClickSets_SetAttributes(frame, GridClickSetsFrame_GetCurrentSet());
end

hooksecurefunc(GridFrame, "InitializeFrame", initializeFrame)
if IsLoggedIn() and GridFrame.registeredFrames then GridFrame:WithAllFrames(function(f) initializeFrame(nil, f) end) end

GridClickSets.options = {
	type = "execute",
	name = GRIDCLICKSETS_MENUNAME,
	desc = GRIDCLICKSETS_MENUTIP,
	order = 1,
	func = function()
		LibStub("AceConfigDialog-3.0"):Close("Grid");
		GridClickSetsFrame:Show();
		GameTooltip:Hide();
	end
}

function GridClickSets:OnEnable()
	--the profile no longer work with grid.
end

function GridClickSets:Reset()
	--the profile no longer work with grid.
end

table.insert(GridClickSetsFrame_Updates, function(set)
	GridFrame:WithAllFrames(function (f) GridClickSets_SetAttributes(f, set) end)
end);

end)