local _
local _G = getfenv(0)
local format = string.format
local strfind = string.find
local _, i
--~ LoadAddOn("Blizzard_InspectUI")
local inspectUnit, inspectGUID
local lastRequestTime = 0
local inspectList = {}
local inspectItem = {}
local inspectTime = GetTime()
local PRIMARY_TALENT = SPECIALIZATION.." : "
local SECONDARY_TALENT = TALENT.." : "
local AL = LibStub:GetLibrary("AceLocale-3.0")
local LGIST = LibStub:GetLibrary("LibGroupInSpecT-1.0")

CURRENTLY_EQUIPPED = "|cFFFF8000----"..CURRENTLY_EQUIPPED.."----|r"

zTip = CreateFrame("Frame", nil, GameTooltip)

function zTip:GetDefault()
	return {
		Anchor = 3,
		OffsetX = 30, OffsetY = 30,
		OrigPosX = 70, OrigPosY = 120,
		Scale = 1.0,
		Fade = false,
		DisplayPvPRank = true,
		ShowIsPlayer = false,
		DisplayFaction = true,
		PlayerServer = true,
		TargetOfMouse = true,
		ClassIcon = true,
		TalentIcon = true,
		CombatHide = false,
		VividMask = true,
		ShowTalent = true,	
		TargetedBy = true,
		ManaBAR = true,	
		NPCClass = true,
		ItemLevel = true,
		ShowFaction = false,
	}
end

-------------------------------------------------------
-- Inspect protection codes for 5.0/MOP

-- 上官晓雾    2012-8
-------------------------------------------------------
local GetInspectTalent

do
	local inspectUnit, inspectGUID
	local nextInspectable = 0
	local updateElapsed = 0
	local loadtalent = true
	function GetUnitByGUID(unitGUID)
		local unitID
		for i = 1, 4, 1 do
		if UnitGUID("party"..i) == unitGUID then unitID = "party"..i end
		end
		for i = 1, 40, 1 do
		if UnitGUID("raid"..i) == unitGUID then unitID = "raid"..i end
		end
		if UnitGUID("player") == unitGUID then
		unitID = "player"
		elseif UnitGUID("mouseover") == unitGUID then
		unitID = "mouseover"
		elseif UnitGUID("target") == unitGUID then
		unitID = "target"
		elseif UnitGUID("focus") == unitGUID then
		unitID = "focus"
		end
		return unitID
	end
	-- IMPORTANT !!!
	hooksecurefunc("NotifyInspect", function()
		nextInspectable = GetTime() + 2
	end)

	local function GetTalentLine(data, id)
		return data[id] or "|cff9d9d9d"..NONE.."|r"
	end

	GetInspectTalent = function(unit)
		if not unit then
			return
		end

		local guid = UnitGUID(unit)
		if not guid then
			return
		end
		local data = inspectList[guid]
		if data and data[1] and data[1] == format("|cff%s%s [%s]|r","00ff00", NONE,NONE) then inspectList[guid]=nil end
		if data then
			if GetTime() - data.lasttmer > 10 then
				inspectUnit, inspectGUID = unit, guid
			end
			return GetTalentLine(data, 1), data[2] ,data[3]

		end

		inspectUnit, inspectGUID = unit, guid
	end


	local frame = CreateFrame("Frame")
	frame:SetScript("OnUpdate", function(self, elapsed)
		if not inspectUnit or not inspectGUID then
			return
		end

		updateElapsed = updateElapsed + elapsed
		if updateElapsed < 0.2 then
			return
		end
		updateElapsed = 0
		if inspectGUID ~= UnitGUID(inspectUnit) then
			inspectUnit, inspectGUID = nil
		elseif GetTime() > nextInspectable then
--~ 			if InspectFrame then
--~ 				InspectFrame.unit = inspectUnit
--~ 			end
			loadtalent = true
 			NotifyInspect(inspectUnit)
			inspectUnit, inspectGUID = nil
		end
	end)
	-----------------------ilevel------------------
	function HGetItemLevel(link)
	  local levelAdjust={
		["0"]=0,["1"]=8,["373"]=4,["374"]=8,["375"]=4,["376"]=4,
		["377"]=4,["379"]=4,["380"]=4,["445"]=0,["446"]=4,["447"]=8,
		["451"]=0,["452"]=8,["453"]=0,["454"]=4,["455"]=8,["456"]=0,
		["457"]=8,["458"]=0,["459"]=4,["460"]=8,["461"]=12,["462"]=16,
		["465"] = 0,["466"] = 4,["467"] = 8,["468"] = 0,["469"] = 4,
		["470"] = 8,["471"] = 12,["472"] = 16,["476"] = 0,["477"] = 4,
		["478"] = 8,["479"] = 0,["480"] = 8,
		["491"]=0,["492"]=4,["493"]=8,
		["494"]=0,["495"]=4,["496"]=8,["497"]=12,["498"]=16}

	  local baseLevel = select(4,GetItemInfo(link))
	  local upgrade = string.match(link,":(%d+)\124h%[")
	  if baseLevel and upgrade then
		return baseLevel + (levelAdjust[upgrade] or 0)
	  else
		return baseLevel
	  end
	end

	function TableSum(table)
		local retVal, _ = 0

		for _, n in ipairs(table) do
			retVal = retVal + n
		end

		return retVal
	end
	function GetUnitItemLevelGUID(unitGUID)
		local unit=GetUnitByGUID(unitGUID)
		local items = {}
		local count, sum = 0, 0

		if unit and UnitIsPlayer(unit) and CheckInteractDistance(unit, 1) then
			for i = 1, 18, 1 do
				local itemLink = GetInventoryItemLink(unit, i) or 0
				local itemLevel = HGetItemLevel(itemLink)

				if itemLevel and itemLevel > 0 and i ~= 4 then
					tinsert(items, (itemLevel or 0))
				end
			end

			count, sum = #(items), TableSum(items)

			if (true or 1) == 1 then
				if GetInventoryItemLink(unit, 17) then
					count = 17
				else
					count = 16
				end
			end
		end

		if sum >= count and count > 0 then
			return tonumber(string.format("%.".."1".."f", sum/count))
		else
			return nil
		end
	end
	---------------------------------------------
	frame:RegisterEvent("INSPECT_READY")
	frame:RegisterEvent("UNIT_INVENTORY_CHANGED")

	frame:SetScript("OnEvent", function(self, event, unitGUID)
	-----------------------
		if event == "UNIT_INVENTORY_CHANGED" then

			if unitGUID ~= "player" then
				if inspectItem[UnitGUID(unitGUID)] then inspectItem[UnitGUID(unitGUID)] = nil end
			end

			return;
		end
		if event == "INSPECT_READY" then
			local unit = GetUnitByGUID(unitGUID)
			if zTipSaves.ItemLevel and  unitGUID and unit and  CheckInteractDistance(unit, 1) then

				if not inspectItem[unitGUID] then
					inspectItem[unitGUID] = { ["equipped"] =GetUnitItemLevelGUID(unitGUID), ["count"] = 1 }

					if unit then
						NotifyInspect(unit)
					end
				else
					inspectItem[unitGUID].equipped = GetUnitItemLevelGUID(unitGUID)
					inspectItem[unitGUID].count = inspectItem[unitGUID].count + 1

					if inspectItem[unitGUID].equipped and inspectItem[unitGUID].count >= 2 then
						for i = 3, GameTooltip:NumLines() do
							local line = getglobal("GameTooltipTextLeft"..i)
							local text = line:GetText()
							if text and strfind(text, zTip.locStr.ItemLevel) then
								line:SetText(zTip.locStr.ItemLevel.." : |cffffffff"..inspectItem[unitGUID].equipped.."|r")
								GameTooltip:Show()
								break
							end
						end
					else
						if unit then NotifyInspect(unit) end
					end
				end
			end
			if loadtalent then
				local data = inspectList[unitGUID]
				if data then
					wipe(data)
				else
					data = {}
					inspectList[unitGUID] = data
				end

				local activeGroup = GetActiveSpecGroup()
				local numGroups = GetNumSpecGroups()
				local _, name, _, icon, _,style = GetSpecializationInfoByID(GetInspectSpecialization(unit))
				data[1] = format("|cff%s%s [%s]|r","00ff00", name or NONE,style and _G[style] or NONE)
				data[2] = icon
				if unitGUID == inspectGUID then
					inspectUnit, inspectGUID = nil
				end

				if data[1] == format("|cff%s%s [%s]|r","00ff00", NONE,NONE) then
					inspectList[unitGUID]=nil
					loadtalent = true
					return
				else
					data.lasttmer=GetTime()
					loadtalent = false
				end

				if zTipSaves.ShowTalent and unitGUID == UnitGUID("mouseover") then
					for i = 3, GameTooltip:NumLines() do
						local line = getglobal("GameTooltipTextLeft"..i)
						local text = line:GetText()
						if text and strfind(text, PRIMARY_TALENT) then
							if zTipSaves.TalentIcon then
								line:SetText("     "..PRIMARY_TALENT..GetTalentLine(data, 1))
								zTip:SetTalentIcon(data[2])
							else
								line:SetText(PRIMARY_TALENT..GetTalentLine(data, 1))
							end
							GameTooltip:Show()
							break
						end
					end
				end
			end
		end
	end)
end

zTipSaves = zTip:GetDefault()

zTip.GuildColorAlpha = 0.86
local pet_r=1
local pet_b=0
local pet_g=1

-- localized strings
zTip.locStr = {}

-- record player's factions standingId
zTip.factions = {}

function zTip:GetHexColor(color)
	if not color then
		return "FFFFFF"
	else
		return format("%2x%2x%2x",color.r*255,color.g*255,color.b*255)
	end
end

local lDiff,lRange, r, g, b
function zTip:GetDifficultyColor(level)
	lDiff = level - UnitLevel("player");
	lRange = GetQuestGreenRange()
	if (lDiff >= 0) then
		r = 1.00; b = 0.00;
		if lDiff < 10 then
			g = 1 - (lDiff*0.10)
		else
			g = 0.00
		end
	elseif ( -lDiff < lRange) then
		g = 1.00; b = 0.00;
		r = 1 - (-1.0*lDiff)/lRange
	elseif ( -lDiff == lRange ) then
		r = 0.50; g = 1.00; b = 0.50;
	else
		r = 0.75; g = 0.75; b = 0.75;
	end
	return format("%2x%2x%2x",r*255,g*255,b*255);
end

local coords
function zTip:SetClassIcon(classToken,ispet)
	if not self.icon then
		self.icon = GameTooltip:CreateTexture(nil, "OVERLAY")
		self.icon:SetWidth(16); self.icon:SetHeight(16);
		self.icon:SetPoint("LEFT", GameTooltipTextLeft1, 1, 1)
		self.icon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
		self.icon:Hide()

	end
	if not self.peticon and ispet then
		self.peticon = GameTooltip:CreateTexture(nil, "OVERLAY")
		self.peticon:SetWidth(16); self.peticon:SetHeight(16);
		self.peticon:SetPoint("LEFT", GameTooltipTextLeft1, 1, 1)
		self.peticon:SetTexture("Interface\\Icons\\Pet_TYPE_"..PET_TYPE_SUFFIX[classToken])
		self.icon:Hide()
	end

	if ispet then
		self.peticon:SetTexture("Interface\\Icons\\Pet_TYPE_"..PET_TYPE_SUFFIX[classToken])
		self.peticon:Show()
	else
		coords = CLASS_BUTTONS[classToken]
		self.icon:SetTexCoord(coords[1],coords[2],coords[3],coords[4])
		self.icon:Show()
	end
end

function zTip:SetTalentIcon(icontexture)
	if not icontexture then return end
	local tline
	for i = 3, GameTooltip:NumLines() do
		tline = getglobal("GameTooltipTextLeft"..i)
		local text = tline:GetText()
		if text and strfind(text, PRIMARY_TALENT) then
			break
		end
	end


	if not self.talenticon then
		self.talenticon = GameTooltip:CreateTexture(nil, "OVERLAY")
		self.talenticon:SetWidth(15); self.talenticon:SetHeight(15);
		self.talenticon:SetPoint("LEFT", tline, -0, -1)
		self.talenticon:SetTexture(icontexture)
		self.talenticon:Hide()
	end

	self.talenticon:SetPoint("LEFT", tline, -0, -1)
	self.talenticon:SetTexture(icontexture)
	self.talenticon:Show()

end

function zTip:GetVividMask()
	local mask = _G["GameTooltipMask"]
	if mask then return mask end

	mask = GameTooltip:CreateTexture("GameTooltipMask")
	mask:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
	mask:SetPoint("TOPLEFT", GameTooltip, "TOPLEFT", 4, -4)
	mask:SetPoint("BOTTOMRIGHT", GameTooltip, "TOPRIGHT", -4, -30)
	mask:SetBlendMode("ADD")
	mask:SetGradientAlpha("VERTICAL", 0, 0, 0, 0, 1, 1, 1, 0.66)
	mask:Hide()

	return mask
end


--[[
	Events
--]]

function zTip:OnUpdate(elapsed)
	-- offset to mouse
	if self.AnchorType then
		x,y = GetCursorPosition()
		uiscale = UIParent:GetScale()
		tipscale = GameTooltip:GetScale()
		x = (x + zTipSaves.OffsetX) / tipscale / uiscale
		GameTooltip:ClearAllPoints()
		if zTip.AnchorType == 2 then
			y = (y + zTipSaves.OffsetY) / tipscale / uiscale
			GameTooltip:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", x, y)
		else
			y = (y - zTipSaves.OffsetY) / tipscale / uiscale
			GameTooltip:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT", x, y)
		end
	end

	if UnitExists("mouseover") then
		-- refresh target of mouseover
		self:RefreshMouseOverTarget(elapsed)
	elseif self.unit and not zTipSaves.Fade and GameTooltip:IsOwned(UIParent) then
		GameTooltip:Hide()
	end
end

function zTip:OnEvent(event, ...)
	if event == "PLAYER_LOGIN" then
		self:Init()
	elseif event == "PLAYER_ENTERING_WORLD" then
		GameTooltip:SetScale(zTipSaves.Scale)
	elseif event == "UPDATE_FACTION" then
		self:UpdatePlayerFaction()
	end
end
zTip:RegisterEvent("PLAYER_LOGIN")
zTip:SetScript("OnEvent",zTip.OnEvent)

--[[Initialize]]--
function zTip:Init()
	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:SetScript("OnUpdate", self.OnUpdate)

	-- setting GameTooltip
	GameTooltip:SetBackdrop( {
	  bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	  edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	  tile = true, tileSize = 16, edgeSize = 16,
	  insets = { left = 4, right = 4, top = 4, bottom = 4 } -- self is what we need!
	});
	GameTooltip:SetBackdropBorderColor(TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b);
	GameTooltip:SetBackdropColor(TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b);

	-- mask
	if zTipSaves.VividMask then
		zTip:GetVividMask():Show()
	end

	-- mana bar
		GameTooltipStatusBar.manabar = CreateFrame("StatusBar","GameTooltipManaBar",GameTooltipStatusBar)
		GameTooltipManaBar:SetPoint("TOPLEFT",GameTooltipStatusBar,"BOTTOMLEFT")
		GameTooltipManaBar:SetPoint("TOPRIGHT",GameTooltipStatusBar,"BOTTOMRIGHT")
		if zTipSaves.ManaBAR then
			GameTooltipManaBar:SetHeight(GameTooltipStatusBar:GetHeight())
		else
			GameTooltipManaBar:SetHeight(0.1)
		end
		GameTooltipManaBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-TargetingFrame-BarFill")
		UnitFrameManaBar_Initialize("mouseover",GameTooltipManaBar)

	-- Scripts

	GameTooltip:HookScript("OnTooltipSetUnit", function(self)
		zTip:OnTooltipSetUnit()
	end)

	GameTooltip:HookScript("OnTooltipCleared", function(self)
		GameTooltip_ClearMoney(self)
		zTip:OnGameTooltipHide()
	end)


	-- HOOKs
	hooksecurefunc("GameTooltip_SetDefaultAnchor", zTip.SetDefaultAnchor)
	--GameTooltip_SetDefaultAnchor = zTip.SetDefaultAnchor
	--GameTooltip_UnitColor = function(unit)
	--	return zTip:UnitColor(unit)
	--end

	-- Slash
	SLASH_ZTIPSLASH1 = "/ztip"
	SlashCmdList["ZTIPSLASH"] = function(msg)
		zTip:Slash(msg)
	end
end

--factions
local name, standingId, isHeader, isCollapsed
function zTip:UpdatePlayerFaction()
	for i = 1, GetNumFactions() do
		name,_,standingId,_,_,_,_,_,isHeader,isCollapsed,_ = GetFactionInfo(i)
		if not isHeader then
			self.factions[name] = standingId
		end
	end
end

local reaction	-- self var used in several functions
local gender = UnitSex("player")

-- get the formated faction name
local label, str
function zTip:GetUnitFaction(unit, reaction)
	reaction = reaction or UnitReaction(unit, "player")
	if not reaction then return "" end

	if reaction == 7 then
		for i = GameTooltip:NumLines(),3,-1 do
			label = _G["GameTooltipTextLeft"..i]:GetText()
			if label and label ~= PVP and self.factions[label] then
				reaction = self.factions[label]
				break
			end
		end
	end
	str = GetText("FACTION_STANDING_LABEL"..reaction, gender)
	if reaction == 5 then str = format("|cff33CC33%s|r", str)
	elseif reaction == 6 then str = format("|cff33CCCC%s|r", str)
	elseif reaction == 7 then str = format("|cffFF6633%s|r", str)
	elseif reaction == 8 then str = format("|cffDD33DD%s|r", str)
--Add 4 lines. By YYSS
	elseif reaction == 1 then str = format("|cffFF4444%s|r", str)
	elseif reaction == 2 then str = format("|cffFF0000%s|r", str)
	elseif reaction == 3 then str = format("|cffFF7744%s|r", str)
	elseif reaction == 4 then str = format("|cffFFCC00%s|r", str)
	end

	return str
end

--[[
	Positions
--]]
local x,y,uiscale,tipscale

function zTip:SetDefaultAnchor(parent)
	self:SetOwner(parent, "ANCHOR_NONE");
	if zTipSaves.OrigPosX and zTipSaves.OrigPosY then
		self:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -zTipSaves.OrigPosX - 13, zTipSaves.OrigPosY);
	else
		self:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X - 13, CONTAINER_OFFSET_Y);
	end
	--self.default = 1;

	if zTipSaves.Anchor then
		if parent == UIParent then
			-- posiont will be set in update function
			if zTipSaves.Anchor == 0 or zTipSaves.Anchor == 3 then
				zTip.AnchorType = 1
			elseif zTipSaves.Anchor == 2 or zTipSaves.Anchor == 5 then
				zTip.AnchorType = 2
			end
			if UnitExists("mouseover") then
				if zTipSaves.Anchor == 1 or zTipSaves.Anchor == 4 then -- on top
					zTip.AnchorType = nil
					uiscale = UIParent:GetScale()
					tipscale = self:GetScale()
					x = zTipSaves.OffsetX / tipscale / uiscale
					y = zTipSaves.OffsetY / tipscale / uiscale
					self:ClearAllPoints()
					self:SetPoint("TOP",UIParent,"TOP", x, -y)
				else -- follow cursor [0,2,3,5]
				end
			else -- not unit
				self:SetOwner(parent, "ANCHOR_CURSOR")
			end
		else -- not a unit tip, buttons or other
			if zTipSaves.Anchor > 2 or parent.unit and zTipSaves.Anchor~=0 then
				self:SetOwner(parent,"ANCHOR_RIGHT")
			else -- use default anchor (BottomRight to Screen)

			end
		end
	else -- use deault
	end
end

--Hook：GameTooltip
hooksecurefunc(GameTooltip, "FadeOut", function(self)
	if (not zTipSaves.Fade) then
		GameTooltip:Hide();
	end
end)

--[[
	Tip Formatings
--]]
local unit, guid
local bplayer, bdead, tapped
local tip, text, levelline, tmp, tmp2
local unitrace, unitCreatureType
local guild, guildrank, guildid
local bbattlepet
--[[ Pre Format ]]
local targetlinenum
local found, trueNum
--[[ MouseOver Target ]]
local mouseTarget
function zTip:RefreshMouseOverTarget(elapsed)
	-- timer, refresh every 0.5s
	self.timer = (self.timer or 0.5) + elapsed
	if self.timer < 0.5 then return end
	self.timer = 0


	if not zTipSaves.TargetOfMouse or not targetlinenum then return end
	text = _G["GameTooltipTextLeft"..targetlinenum]
	if not text then return end

	tip, tmp, tmp2 = nil, nil, nil
	if not UnitExists(zTip.unittarget) then
		mouseTarget = nil
		text:SetText()
		GameTooltip:Show()
	else
		name = UnitName(zTip.unittarget)
		if name ~= mouseTarget then
			mouseTarget = name or UNKNOWNOBJECT
			tip = format("|cffFFFF00%s [|r", zTip.locStr.Targeting)
			if UnitIsUnit(zTip.unittarget, "player") then
				tip = format("%s |c00FF0000%s|r", tip, zTip.locStr.YOU)
			elseif UnitIsUnit(zTip.unittarget, zTip.unit) then
				tip = format("%s |cffFFFFFF%s|r", tip, zTip.locStr.Self)
			elseif UnitIsPlayer(zTip.unittarget) then
				tmp, tmp2 = UnitClass(zTip.unittarget)
				if UnitIsEnemy(zTip.unittarget,"player") then
					-- red enemy player
					tip = format("%s |cffFF0000%s|r |cff%s(%s)|r", tip,mouseTarget,
						zTip:GetHexColor(RAID_CLASS_COLORS[(tmp2 or "")]), tmp or nil)
				else
					-- white friend player
					tip = format("%s |cff%s%s|r |cffFFFFFF(%s)|r", tip,
						zTip:GetHexColor(RAID_CLASS_COLORS[(tmp2 or "")]),
						mouseTarget,tmp or nil)
				end
			else
				tip = format("%s |cffFFFFFF%s|r", tip, mouseTarget)
			end
			tip = format("%s |cffFFFF00]|r", tip) -- ']'
			text:SetText(tip)
			GameTooltip:Show()
		end
	end
end

function zTip:OnTooltipSetUnit()
	if zTipSaves.CombatHide and UnitExists("boss1") then GameTooltip:Hide() end

	zTip.unit = zTip:OnMouseOverUnit(GameTooltip:GetUnit())
	if not zTip.unit then return; end
	zTip.unittarget = zTip.unit.."target"
	GameTooltipStatusBar.unit = zTip.unit
	GameTooltipManaBar.unit = zTip.unit
	UnitFrameManaBar_Update(GameTooltipManaBar,zTip.unit)
end

function zTip:OnGameTooltipHide()
	targetlinenum = nil
	trueNum = nil
	mouseTarget = nil
	zTip.AnchorType = nil
	zTip.timer = nil
	zTip.unit = nil
	zTip.unittarget = nil
	if zTip.icon then zTip.icon:Hide() end
	if zTip.peticon then zTip.peticon:Hide() end
	if zTip.talenticon then zTip.talenticon:Hide() end
end

function zTip:UnitClassColorText(unit)
	if not unit then return "";end
	local UnitClassSYS = select(2,UnitClass(unit))
	local UnitClassLOCAL = zTip.locStr.LocalClassName[UnitClassSYS] or UnitClassSYS
	local color = RAID_CLASS_COLORS[UnitClassSYS]
	if not color then return "";end
	local ColorText = string.format("|cff%.2x%.2x%.2x%s|r",color.r*255,color.g*255,color.b*255,UnitClassLOCAL)
	return ColorText
end

--[[ Name Color ]]
local DEFCOLOR = { r = 0.5, g = 0.5, b = 1.0 }
function zTip:UnitColor(unit, bdead, tapped, reaction,bbattlepet)
	bdead = bdead or UnitHealth(unit) <= 0 and (not bplayer or UnitIsDeadOrGhost(unit))
	tapped = tapped or UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))
	reaction = reaction or UnitReaction(unit, "player")
	local ISPLAYER = UnitIsPlayer(unit)
	if tapped or bdead then
		r = 0.55;g = 0.55;b = 0.55
	elseif bbattlepet then
		r,g,b = 0.8,0.5,0.8
	elseif ISPLAYER or UnitPlayerControlled(unit) then
		if ( UnitCanAttack(unit, "player") ) then
			if ( not UnitCanAttack("player", unit) ) then
				--purple, caution, only they can attack
				r = 1.0;g = 0.4;b = 1.0
			else
				-- Hostile players are red
				r = 1.0;g = 0.0;b = 0.0
			end
		elseif ( UnitCanAttack("player", unit) ) then
			-- Players we can attack but which are not hostile are yellow
			r = 1.0;g = 1.0;b = 0.0
		-- elseif (UnitIsPVP(unit) and not UnitIsPVPSanctuary(unit) and not UnitIsPVPSanctuary("player")) then
			-- -- Players we can assist but are PvP flagged are green
			-- r = 0.0;g = 1.0;b = 0.0
		else

			local color = ISPLAYER and RAID_CLASS_COLORS[select(2,UnitClass(unit))] or DEFCOLOR
			r, g, b = color.r, color.g, color.b
		end

	elseif reaction then
		-- mob/npc
		if reaction < 4 then -- harm
			r,g,b = 1,0.3,0.22
		elseif reaction > 4 then -- friendly
			r,g,b = 0,1,0
		else -- nature
			r,g,b = 1,1,0
		end
	else -- normal
		r,g,b = 1,1,1
	end
	return r,g,b
end

--[[ Format Unit Tip ]]
--[[
	if on mouse over unit, then first call GameTooltip_UnitColor("mouseover")
	then UPDATE_MOUSEOVER_UNIT triggers
	elseif on a UnitFrame first call GameTooltip_UnitColor("mouseover") too
	then call GameTooltip:SetUnit function
	last UnitFrame will call GameTooltip_UnitColor(self.unit) again but not the "mouseover"
--]]
function zTip:OnMouseOverUnit(name,unit)
	if not unit then return;end
	-- hack to fix problems
	if unit == "npc" then unit = "mouseover" end
--[[
	local values and initials
--]]
	bplayer = UnitIsPlayer(unit)
	name = name or UnitName(unit)
	guid = UnitGUID(unit)
	bbattlepet = (UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit) )
	bdead = UnitHealth(unit) <= 0 and (not bplayer or UnitIsDeadOrGhost(unit))
	tapped = UnitIsTapped(unit) and (not UnitIsTappedByPlayer(unit))

	reaction = UnitReaction(unit, "player")

--[[
	New Way
--]]
	tip, text, levelline, foundpvp, foundfact, tmp, tmp2 = nil
	local pvplinenum,factlinenum=nil

	--[[ Serch and Delete ]]
	trueNum = GameTooltip:NumLines()
	lastlinenum = trueNum
	for i = 2, trueNum do
		text = _G[GameTooltip:GetName().."TextLeft"..i]
		tip = text:GetText()
		if tip then
			if not levelline and (strfind(tip, LEVEL) or strfind(tip,"Pet Level")) then
				levelline = i
			elseif not zTipSaves.ShowFaction and (tip == FACTION_ALLIANCE or tip == FACTION_HORDE) then
				text:SetText()
				foundfact = true
				factlinenum = i
--~ 				lastlinenum = lastlinenum - 1
			elseif tip == PVP then
				text:SetText()
				pvplinenum = i
				foundpvp = true
--~ 				lastlinenum = lastlinenum - 1
			elseif tip == TAMEABLE then
				text:SetText( format("|cff00FF00%s|r", tip) )
			elseif tip == NOT_TAMEABLE then
				text:SetText( format("|cffFF6035%s|r", tip) )
			end
		end
	end

	-- insert target line
	if zTipSaves.TargetOfMouse then
		if not foundfact then
			GameTooltip:AddLine("zTip -- target line")
			targetlinenum = GameTooltip:NumLines()
		else
			targetlinenum = factlinenum
		end
		text = _G["GameTooltipTextLeft"..targetlinenum]
		if text then
			text:SetText()
		else
			targetlinenum = nil
		end
	end

	if zTipSaves.ItemLevel and bplayer and not bbattlepet and UnitFactionGroup(unit) == UnitFactionGroup("player") then
		local itemlevel = inspectItem[UnitGUID(unit)]
		local InDistance = CheckInteractDistance(unit, 1)
		local EnableNotifyInspect = (not InspectFrame or not InspectFrame:IsShown()) and (not Examiner or not Examiner:IsShown())

		if itemlevel and itemlevel.count > 1 then
			if itemlevel.equipped and itemlevel.count >= 2 then
				GameTooltip:AddLine(zTip.locStr.ItemLevel.." : |cffffffff"..itemlevel.equipped.."|r")
			end
		elseif EnableNotifyInspect then
				if InDistance then
					GameTooltip:AddLine(zTip.locStr.ItemLevel.." : "..zTip.locStr.Loading)
					NotifyInspect(unit)
				else
					GameTooltip:AddLine(zTip.locStr.ItemLevel.." : "..zTip.locStr.TooFar)
				end
		end
	end

	-- insert talent line
	if (zTipSaves.ShowTalent and bplayer and UnitLevel(unit) > 9) and not bbattlepet and UnitFactionGroup(unit) == UnitFactionGroup("player") then
		local InDistance = CheckInteractDistance(unit, 1)
		local EnableNotifyInspect = (not InspectFrame or not InspectFrame:IsShown()) and (not Examiner or not Examiner:IsShown())
		local primary,icontexture= GetInspectTalent(unit)
		local tmpPRIMARY_TALENT=PRIMARY_TALENT
--~ 	--------------------------------------------
		local talentline=nil

		GameTooltip:AddLine("zTip -- talent line")

		talentline = _G["GameTooltipTextLeft"..GameTooltip:NumLines()]
--~ 	--------------------------------------------
		if (primary) then
			if zTipSaves.TalentIcon then
				talentline:SetText("     "..tmpPRIMARY_TALENT..primary)
				zTip:SetTalentIcon(icontexture)
			else
				talentline:SetText(tmpPRIMARY_TALENT..primary)
			end
		else
			if not EnableNotifyInspect then
				talentline:SetText(zTip.locStr.Talent..format("|cFFAAAAAA%s|r", zTip.locStr.DisableReadTalent))
			else
				if InDistance then
					talentline:SetText(tmpPRIMARY_TALENT..zTip.locStr.Loading)
				else
					talentline:SetText(tmpPRIMARY_TALENT..zTip.locStr.TooFar)
				end
			end
		end

	end


	-- Add "Targeted By" line
	if zTipSaves.TargetedBy then
		local num= GetNumGroupMembers()
		if (num > 0) then
			local players, counter = "", 0
			for i = 1,num do
				local unit1 = (UnitName("raid"..i) and "raid"..i or "party"..i)
				if (UnitIsUnit(unit1.."target",unit)) and (not UnitIsUnit(unit1,"player")) then
					if (mod(counter + 3,6) == 0) then
						players = players.."\n"
					end
					local color = RAID_CLASS_COLORS[select(2,UnitClass(unit1))]
					players = ("%s|cff%.2x%.2x%.2x%s|r, "):format(players,color.r*255,color.g*255,color.b*255,UnitName(unit1))
					counter = (counter + 1)
				end
			end
			if (players ~= "") then
--~ 	--------------------------------------------
				local targetedbyline = nil

				GameTooltip:AddLine("zTip -- targetedby line")

				targetedbyline= _G["GameTooltipTextLeft"..GameTooltip:NumLines()]
--~ 	--------------------------------------------
				targetedbyline:SetText(zTip.locStr.TargetedBy.." (|cffffffff"..counter.."|r): "..players:sub(1,-5))
			end
		end
	end

	if levelline then
		if bbattlepet then
			tmp=UnitBattlePetLevel(unit)
			tmp2=format(TOOLTIP_WILDBATTLEPET_LEVEL_CLASS,"","")
		else
			tmp=UnitLevel(unit)
			tmp2 = ""
		end

		if bdead then
			if tmp > 0 then
				tmp2 = format("|cff888888%d %s|r", tmp, CORPSE)
			else
				tmp2 = format("|cff888888?? %s|r", CORPSE)
			end
		elseif ( tmp > 0 ) then
			-- Color level number
			if UnitCanAttack("player", unit) or UnitCanAttack(unit, "player") then
				tmp2 = format("|cff%s%d|r", zTip:GetDifficultyColor(tmp), tmp)
			else
				-- normal color
				tmp2 = format("%s|cff3377CC%d|r",tmp2,tmp)
			end
		else
			-- Target is too high level to tell
			tmp2 = "|cffFF0000 ??|r"
		end

		-- creature type/ creature family(pet)
		unitrace = UnitRace(unit)
		unitCreatureType = UnitCreatureType(unit)
		if unitrace and bplayer then
			--race, it is a player
			if UnitFactionGroup(unit) == UnitFactionGroup("player") then
				tmp = "00FF33"
			else
				tmp = "FF3300"
			end
			tmp2 = format("%s |cff%s%s|r", tmp2, tmp, unitrace)
			-- class
			_, tmp = UnitClass(unit)
			-- class icon
			if zTipSaves.ClassIcon then
				zTip:SetClassIcon(tmp,false)
			end
			tmp = zTip:GetHexColor(RAID_CLASS_COLORS[(tmp or "")])
			tmp2 = format("%s |cff%s%s|r ", tmp2, tmp, _)
		elseif UnitPlayerControlled(unit) or bbattlepet then
			--creature family, its is a pet
			if bbattlepet then
				-- petType
				local petType=UnitBattlePetType(unit)
				tmp=_G["BATTLE_PET_NAME_"..petType]
				if zTipSaves.ClassIcon then
					zTip:SetClassIcon(petType,true)
				end
				tmp2 = format("%s %s ",tmp2,tmp or "")
			else
				tmp2 = format("%s %s ",tmp2,(UnitCreatureFamily(unit) or unitCreatureType or "") )
			end
		elseif unitCreatureType then
			--creature type, it is a mob or npc
			if unitCreatureType == zTip.locStr.NotSpecified then unitCreatureType = zTip.locStr.Specified end
			tmp2 = format("%s |cffFFFFFF%s|r", tmp2, unitCreatureType)
			if zTipSaves.NPCClass then
				tmp2 = format("%s %s", tmp2, zTip:UnitClassColorText(unit))
			end
			if zTipSaves.DisplayFaction and reaction and reaction > 0 then
				tmp2 = format("%s %s ", tmp2, zTip:GetUnitFaction(unit,reaction))
			end
		else
			tmp2 = format("%s %s ",tmp2,UKNOWNBEING)
		end
		tip = tmp2

		-- special info
		tmp = nil
		tmp2 = ""
		if bplayer then
			if zTipSaves.ShowIsPlayer then
				tmp2 = format("(%s)",PLAYER)
			end
		elseif not UnitPlayerControlled(unit) then
			tmp = UnitClassification(unit) -- Elite status
			--if tmp and tmp ~= "normal" and UnitHealth(unit) > 0 then
			if tmp and tmp ~= "normal" then
				if tmp == "elite" then
					tmp2 = format("|cffFFFF33(%s)|r", ELITE)
				elseif tmp == "worldboss" then
					tmp2 = format("|cffFF0000(%s)|r", BOSS)
				elseif tmp == "rare" then
					tmp2 = format("|cffFF66FF(%s)|r", zTip.locStr.Rare)
				elseif tmp == "rareelite" then
					tmp2 = format("|cffFFAAFF(%s%s)|r", zTip.locStr.Rare, ELITE)
				else
					tmp2 = format("(%s)", tmp) -- unknown type
				end
			end
		end
		_G["GameTooltipTextLeft"..levelline]:SetText( format("%s%s",tip,tmp2) )
	end

	--[[ First Line, rewrite name ]]
	if bplayer or bbattlepet then
		if zTipSaves.ClassIcon then
			tip = "     "
		else
			tip = ""
		end
		if not zTipSaves.DisplayPvPRank then
			GameTooltipTextLeft1:SetText( format("%s%s", tip, name ) )
		else
			GameTooltipTextLeft1:SetText( format("%s%s", tip, (UnitPVPName(unit) or name) ) )
		end
	end

	--[[ Second Line, Rewrite / Insert guild and/or realm name ]]
	tip = nil
	guild, guildrank, guildid = GetGuildInfo(unit)
	if bplayer then
		if guild then
			tip = "<"..guild.."> "..guildrank.."("..guildid..")"
		end
		_, tmp = UnitName(unit)
		if zTipSaves.PlayerServer and (tmp and tmp~="" or tip) then
			if tmp and tip then
				tmp2 = " @ "
			else
				tmp2 = ""
			end
			tip = format("%s|cff00EEEE%s%s|r", tip or "", tmp2, tmp or "")
		end
		if tip then
			if guild then
				GameTooltipTextLeft2:SetText(tip)
			else--if levelline == 2 then
--~ 				tmp = GameTooltip:NumLines()
--~ 				GameTooltip:AddLine("zTip -- self is Add Line")
--~ 				for i = tmp, 2, -1 do
--~ 					_G["GameTooltipTextLeft"..i+1]:SetText(_G["GameTooltipTextLeft"..i]:GetText())
--~ 				end
				GameTooltipTextLeft1:SetText(GameTooltipTextLeft1:GetText().." - "..tmp)
--~ 				if targetlinenum then
--~ 					targetlinenum = targetlinenum + 1
--~ 				end
			end
		end
	end

	--[[ Colors ]]

	r,g,b = zTip:UnitColor(unit, bdead, tapped, reaction,bbattlepet)
	GameTooltipTextLeft1:SetText(format("|cff%2x%2x%2x",r*255,g*255,b*255)..GameTooltipTextLeft1:GetText().."|r")

	if tip or (levelline and levelline > 2) then
		if bdead or tapped then
			GameTooltipTextLeft2:SetTextColor(0.55,0.55,0.55)
		elseif bbattlepet then
			if levelline~=3 then
				GameTooltipTextLeft1:SetTextColor(pet_r,pet_g,pet_b)
				GameTooltipTextLeft2:SetTextColor(r,g,b)
			end
		else
			GameTooltipTextLeft2:SetTextColor(r*zTip.GuildColorAlpha,g*zTip.GuildColorAlpha,b*zTip.GuildColorAlpha)
		end
	end

	if bplayer and guild then
		if guild == GetGuildInfo("player") then
			GameTooltipTextLeft2:SetTextColor(0.9, 0.5, 0.9)
		else
			GameTooltipTextLeft2:SetTextColor(1.0, 1.0, 1.0)
		end
	end

--[[
	done
--]]
	GameTooltip:Show()
	return unit
end

--[[
	Slash Command
--]]

function zTip:Slash(msg)
	local param1 = string.lower(msg)
	if (param1 == "cc") then
		wipe(inspectList)
		collectgarbage("collect")
		DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r "..zTip.locStr.ResetCache, 1,1,0)
	elseif (param1 == "ct") then
		if (UnitIsPlayer("target")) then
			local name = UnitName("target")
			local guid = UnitGUID("target")
			if inspectList[guid] then
				inspectList[guid] = nil
				DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r |cff"..zTip:GetHexColor(RAID_CLASS_COLORS[select(2,UnitClass("target"))])..name.."|r 的天赋缓存已被清空");
			else
				DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r 未找到 |cff"..zTip:GetHexColor(RAID_CLASS_COLORS[select(2,UnitClass("target"))])..name.."|r 的天赋缓存");
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r 没有目标或目标不是玩家");
		end
	elseif (param1 == "pp") then
		local n=0
		for k,v in pairs(inspectList) do
			n=n+1;
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r inspectList="..n);
	else
		collectgarbage("collect")
		UpdateAddOnMemoryUsage()
		--DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r Toggle Option Window", 1,1,0)
		--DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r "..format("%.2f",GetAddOnMemoryUsage("zTip")).." KB", 1,1,0)
		if not zTipOption then return end
		if not zTipOption.ready then zTipOption:Init() end
		if not zTipOption:IsShown() then zTipOption:Show() end
	end
end

--[[ fishui hide

---- ID
local select, UnitBuff, UnitDebuff, UnitAura, tonumber, strfind, hooksecurefunc =
	select, UnitBuff, UnitDebuff, UnitAura, tonumber, strfind, hooksecurefunc
local function addLine(self,id,isItem)
	if IsAltKeyDown() then
		if isItem then
			self:AddDoubleLine("物品ID:","|cffffffff"..id)
		else
			self:AddDoubleLine("法术ID:","|cffffffff"..id)
		end
		self:Show()
	end
end

-- Spell Hooks ----------------------------------------------------------------
hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
	local id = select(11,UnitBuff(...))
	if id then addLine(self,id) end
end)

hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
	local id = select(11,UnitDebuff(...))
	if id then addLine(self,id) end
end)

hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
	local id = select(11,UnitAura(...))
	if id then addLine(self,id) end
end)

GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	local id = select(3,self:GetSpell())
	if id then addLine(self,id) end
end)

hooksecurefunc("SetItemRef", function(link, ...)
	local id = tonumber(link:match("spell:(%d+)"))
	if id then addLine(ItemRefTooltip,id) end
end)

-- Item Hooks -----------------------------------------------------------------
local function attachItemTooltip(self)
	local link = select(2,self:GetItem())
	if not link then return end
	local id = select(3,strfind(link, "^|%x+|Hitem:(%-?%d+):(%d+):(%d+):(%d+):(%d+):(%d+):(%-?%d+):(%-?%d+)"))
	if id then addLine(self,id,true) end
end

GameTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip3:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip3:HookScript("OnTooltipSetItem", attachItemTooltip)
--]]

CoreDependCall("AtlasLoot", function()
    if AtlasLootTooltipTEMP then
        AtlasLootTooltipTEMP.shoppingTooltips = AtlasLootTooltipTEMP.shoppingTooltips  or { ShoppingTooltip1, ShoppingTooltip2, ShoppingTooltip3 };
        AtlasLootTooltipTEMP:HookScript("OnTooltipSetItem", function(self, ...)
            if ( IsModifiedClick("COMPAREITEMS") or (GetCVarBool("alwaysCompareItems") and not self:IsEquippedItem()) ) then
                GameTooltip_ShowCompareItem(self, 1);
            end
        end)
    end
end)

local DEFAULT_ICON_SIZE = 20

local function AddIcon(self, icon)
	if BAnd(32, TTVar.ItemInfo) and icon then
		local title = _G[self:GetName() .. 'TextLeft1']
		if title and not title:GetText():find('|T' .. icon) then
			title:SetFormattedText('|T%s:%d|t %s', icon, DEFAULT_ICON_SIZE, title:GetText())
		end
	end
end
