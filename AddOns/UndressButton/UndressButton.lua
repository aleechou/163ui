-- haxninja
BINDING_NAME_UndressButtonName = "以目标为模型试穿";
BINDING_HEADER_UndressButtonHeader = "试穿增强";

function UndressButton_Load(self)
	if (not AuctionDressUpFrame) then
		self:RegisterEvent("ADDON_LOADED");
	end
end

function UndressButton_Event(self, event, arg1, arg2)
	if (event == "ADDON_LOADED") then
		if (arg1 == "Blizzard_AuctionUI") then
			self:UnregisterEvent("ADDON_LOADED");
			AuctionDressUpFrameUndressButton:SetPoint("BOTTOM", "SideDressUpModelResetButton", "TOP", 0, 2);
			AuctionDressUpFrameUndressButton:SetParent("SideDressUpModel");
			AuctionDressUpFrameUndressButton:SetFrameLevel(SideDressUpModelResetButton:GetFrameLevel());
		end
	end
end

function UndressButton_Reset()
	SetPortraitTexture(DressUpFramePortrait, "player");
	--SetDressUpBackground();
	DressUpModel:SetUnit("player");
end

function UndressButton_DressUpTarget(x)
	if (not DressUpFrame:IsVisible()) then
		ShowUIPanel(DressUpFrame);
	else
		PlaySound("gsTitleOptionOK");
	end
	if (x == "inspect") then
        --use target model
		if(UnitIsVisible("target")) then
			SetPortraitTexture(DressUpFramePortrait, "target");
			SetDressUpTargetBackground();
			DressUpModel:SetUnit("target");
		else
			UndressButton_Reset();
		end
	elseif (x == "dress") then
        --use target gears
		if(UnitIsVisible("target") and UnitIsPlayer("target")) then
			SetPortraitTexture(DressUpFramePortrait, "player");
			--SetDressUpBackground();
			DressUpModel:SetUnit("player");
			DressUpModel:Undress();
			UndressButton_Inspect("target");
		else
			UndressButton_Reset();
			UndressButton_Inspect("player");
		end
	end
end

function UndressButton_Inspect(unit)
	local slots = {
		"HeadSlot", "ShoulderSlot", "BackSlot", "ChestSlot", "ShirtSlot", "TabardSlot", "WristSlot",
		"HandsSlot", "WaistSlot", "LegsSlot", "FeetSlot", "MainHandSlot", "SecondaryHandSlot"
	}; -- "NeckSlot", "Finger0Slot", "Finger1Slot", "Trinket0Slot", "Trinket1Slot", "RangedSlot" left out for obvious reasons
	NotifyInspect(unit);
	for _, slot in ipairs(slots) do
		DressUpItemLink(GetInventoryItemLink(unit, GetInventorySlotInfo(slot)));
	end
end

function DressUpTargetTexturePath()
	local race, fileName = UnitRace("target");
	if ( fileName == "Gnome" or fileName == "GNOME" ) then
		fileName = "Dwarf";
	elseif ( fileName == "Troll" or fileName == "TROLL" ) then
		fileName = "Orc";
	end
	if ( not fileName ) then
		fileName = "Orc";
	end

	return "Interface\\DressUpFrame\\DressUpBackground-"..fileName;
end

function SetDressUpTargetBackground()
	local texture = DressUpTargetTexturePath();
	DressUpBackgroundTopLeft:SetTexture(texture..1);
	DressUpBackgroundTopRight:SetTexture(texture..2);
	DressUpBackgroundBotLeft:SetTexture(texture..3);
	DressUpBackgroundBotRight:SetTexture(texture..4);
end