local AtlasLoot = _G.AtlasLoot
local Mount = AtlasLoot.Button:AddType("Mount", "mount")
local Item = AtlasLoot.Button:GetType("Item")
local AL = AtlasLoot.Locales

local MountData = AtlasLoot.Data.Mount

-- lua
local type = type
local tonumber = tonumber
local str_match = string.match

-- WoW
local C_MountJournal_GetMountInfo, C_MountJournal_GetMountInfoExtra = C_MountJournal.GetMountInfo, C_MountJournal.GetMountInfoExtra

local MOUNT_FACTION_TEXTURES = {
    [0] = "MountJournalIcons-Horde",
    [1] = "MountJournalIcons-Alliance"
}
local MOUNT_LOC = _G.MOUNT
local MOUNT_COLOR = "|cffffff00"
local USE_ITEM_BUTTON = "b1"
local MOUNT_OVERLAY = "Interface\\PetBattles\\PetJournal"
local NO_MOUNT_TEXTURE = "Interface\\Icons\\MountJournalPortrait"

local MountClickHandler = nil

function Mount.OnSet(button, second)
	if not MountClickHandler then
		MountClickHandler = AtlasLoot.ClickHandler:Add(
		"Mount",
		{
			GoTo = { "LeftButton", "None" },
			types = {
				GoTo = true,
			},
		},
		AtlasLoot.db.Button.Mount.ClickHandler, 
		{
			{ "GoTo",		AL["Show Mount in Journal"],			AL["Show Mount in Journal"] },
		})
	end
	if not button then return end
	
	local setButton, setTable
	if second and button.__atlaslootinfo.secType then
		setButton = button.secButton
		setTable = button.__atlaslootinfo.secType
	else
		setButton = button
		setTable = button.__atlaslootinfo
	end
	
	if type(setTable[2]) == "table" then
		if not setTable[2][1] and not setTable[2][2] then
			error("Unknown mount!")
		end
		setTable[2][2] = tonumber(setTable[2][2])
		setButton.MountID = setTable[2][1] or MountData.GetSpellIDfromItemID(setTable[2][2])
		setButton.ItemID = setTable[2][2] or MountData.GetItemIDfromSpellID(setTable[2][2])
		setButton.MountIndex = MountData.GetIndexFromItemID(setButton.ItemID)
	elseif setTable[2] == USE_ITEM_BUTTON and button.ItemID then
		setButton.MountID = setTable[2][1] or MountData.GetSpellIDfromItemID(button.ItemID)
		if not setButton.MountID then
			error("Unknown mount! <"..button.ItemID.."> ")
		end
		setButton.ItemID = setTable[2][2] or MountData.GetItemIDfromSpellID(setButton.MountID)
		setButton.MountIndex = MountData.GetIndexFromItemID(setButton.ItemID)
	elseif setTable[2] then
		setButton.MountID = setTable[2]
		setButton.ItemID = MountData.GetItemIDfromSpellID(setTable[2])
		if not setButton.ItemID then
			error("Unknown mount!")
		end
		setButton.MountIndex = MountData.GetIndexFromItemID(setButton.ItemID)
	else
		error("Unknown mount!")
	end
	Mount.Refresh(setButton)
end

function Mount.OnClear(button)
	button.MountID = nil
	button.secButton.MountID = nil
	button.ItemID = nil
	button.secButton.ItemID = nil
	button.MountIndex = nil
	button.secButton.MountIndex = nil
	
	button.info = nil
	button.secButton.info = nil
end

function Mount.OnMouseAction(button, mouseButton)
	if not mouseButton then return end
	mouseButton = MountClickHandler:Get(mouseButton)
	if mouseButton == "GoTo" then
		if not IsAddOnLoaded("Blizzard_PetJournal") then
			LoadAddOn("Blizzard_PetJournal")
		end
		
		ShowUIPanel(PetJournalParent)
		PetJournalParent_SetTab(PetJournalParent, 1)
		MountJournal_Select(MountData.GetIndexFromSpellID(button.MountID))
	end
end

function Mount.OnEnter(button)
	Mount.ShowToolTipFrame(button)
end

function Mount.OnLeave(button)
	if Mount.tooltipFrame then 
		Mount.tooltipFrame:Hide() 
		
	end
	if button.ItemID then Item.OnLeave(button) end
end

function Mount.Refresh(button)
	local name, _, icon, _, _, _, isFactionSpecific, faction = C_MountJournal_GetMountInfo(button.MountIndex)
	local creatureDisplayID, descriptionText, sourceText = C_MountJournal_GetMountInfoExtra(button.MountIndex)

	if button.type == "secButton" then
		
	else
		button.name:SetText(name)
		button.extra:SetText(MOUNT_LOC)
	end
	
	button.overlay:Show()
	button.overlay:SetTexture(MOUNT_OVERLAY)
	button.overlay:SetTexCoord(0.41992188, 0.52343750, 0.02246094, 0.07519531)
	button.overlay:SetHeight(button.icon:GetHeight()*1.2)
	button.overlay:SetWidth(button.icon:GetWidth()*1.2)
	
	button.icon:SetTexture(icon or NO_MOUNT_TEXTURE)
	
	button.info = { name, icon, creatureDisplayID, descriptionText, sourceText, isFactionSpecific, faction }
	
	return true
end

function Mount.GetStringContent(str)
	if str == "" then
		return USE_ITEM_BUTTON
	elseif tonumber(str) then
		return tonumber(str)
	else
		return {
			tonumber(str_match(str, "(%d+)")),
			str_match(str, "i(%d+)"),	-- linked item
		}
	end
end

--################################
-- Mount frame
--################################
--[[
local creatureName, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, _, isCollected = C_MountJournal.GetMountInfo(index);
local creatureDisplayID, descriptionText, sourceText, isSelfMount = C_MountJournal.GetMountInfoExtra(index);
MountJournal.MountDisplay.ModelFrame:SetDisplayInfo(creatureDisplayID)
]]--

function Mount.ShowToolTipFrame(button)

	if not Mount.tooltipFrame then 
		local name = "AtlasLoot-MountToolTip"
		local frame = CreateFrame("Frame", name)
		frame:SetClampedToScreen(true)
		frame:SetSize(300, 50)
		frame:SetBackdrop({bgFile = "Interface/Tooltips/UI-Tooltip-Background",
							edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
							tile = true, tileSize = 16, edgeSize = 16, 
							insets = { left = 4, right = 4, top = 4, bottom = 4 }})
		frame:SetBackdropColor(0,0,0,1)
		
		frame.icon = frame:CreateTexture(name.."-icon", frame)
		frame.icon:SetPoint("TOPLEFT", frame, "TOPLEFT", 5, -5)
		frame.icon:SetHeight(26)
		frame.icon:SetWidth(26)
		frame.icon:SetTexture(NO_MOUNT_TEXTURE)
		
		frame.name = frame:CreateFontString(name.."-name", "ARTWORK", "GameFontNormal")
		frame.name:SetPoint("TOPLEFT", frame.icon, "TOPRIGHT", 3, 0)
		frame.name:SetJustifyH("LEFT")
		frame.name:SetWidth(250)
		--frame.name:SetHeight(12)
		frame.name:SetTextColor(1, 1, 1, 1)
		
		frame.source = frame:CreateFontString(name.."-source", "ARTWORK", "GameFontNormalSmall")
		frame.source:SetPoint("TOPLEFT", frame.name, "BOTTOMLEFT", 0, -1)
		frame.source:SetJustifyH("LEFT")
		frame.source:SetJustifyV("TOP")
		frame.source:SetWidth(250)
		--frame.info:SetHeight(20)
		frame.source:SetTextColor(1, 1, 1, 1)
		
		frame.model = CreateFrame("PlayerModel", name.."-model")
		frame.model:ClearAllPoints()
		frame.model:SetParent(frame)
		frame.model:SetPoint("TOPLEFT", frame.icon, "BOTTOMLEFT", 0, -3)
		frame.model:SetSize(145,145)
		frame.model:SetRotation(MODELFRAME_DEFAULT_ROTATION)
		
		frame.desc = frame:CreateFontString(name.."-desc", "ARTWORK", "GameFontNormalSmall")
		frame.desc:SetPoint("TOPLEFT", frame.model, "TOPRIGHT", 0, -3)
		frame.desc:SetJustifyH("LEFT")
		frame.desc:SetJustifyV("TOP")
		frame.desc:SetWidth(145)
		frame.desc:SetHeight(145)
		frame.desc:SetTextColor(1, 1, 1, 1)

		frame.typeIcon = frame:CreateTexture(name.."-typeIcon", frame)
		frame.typeIcon:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
		frame.typeIcon:SetHeight(20)
		frame.typeIcon:SetWidth(20)
		frame.typeIcon:SetTexture(NO_MOUNT_TEXTURE)
		frame.typeIcon:SetTexCoord(0.79687500, 0.49218750, 0.50390625, 0.65625000)
		
		Mount.tooltipFrame = frame
	end
	local tmp
	local frame = Mount.tooltipFrame
	frame:ClearAllPoints()
	frame:SetParent(button:GetParent():GetParent())
	frame:SetFrameStrata("TOOLTIP")
	frame:SetPoint("BOTTOMLEFT", button, "TOPRIGHT")
	
	-- name, icon, creatureDisplayID, descriptionText, sourceText
	
	frame.name:SetText(button.info[1])
	frame.source:SetText(button.info[5])
	frame.icon:SetTexture(button.info[2] or NO_MOUNT_TEXTURE)
	tmp = frame.name:GetHeight()+frame.source:GetHeight()
	frame.icon:SetSize(tmp,tmp)
	frame:SetHeight(tmp+155)
	
	frame.desc:SetText(button.info[4])
	
	frame.model:SetDisplayInfo(button.info[3])
	frame.model:SetDoBlend(false)
	--frame.model:SetAnimation(0,-1) 0=alive, 6=dead
	
	if button.info[6] then
		frame.typeIcon:SetAtlas(MOUNT_FACTION_TEXTURES[button.info[7]],true)
		frame.typeIcon:Show()
	else
		frame.typeIcon:Hide()
	end
	--frame.typeIcon:SetTexture("Interface\\PetBattles\\PetIcon-"..PET_TYPE_SUFFIX[button.info[2]])
	
	frame:Show()
	
	if button.ItemID then
		Item.OnEnter(button, {frame, "ANCHOR_TOPLEFT", 0, 2})
	end
end