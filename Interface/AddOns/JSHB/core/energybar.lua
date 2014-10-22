--
-- JSHB - Power bar module
--

if not (tContains({ "HUNTER", "WARRIOR", "ROGUE", "WARLOCK", }, select(2, UnitClass("player") ) ) ) then return end

-- Cache
local select, UnitAura = select, UnitAura
local _

JSHB.predictionSpellBase = 14
local playerHasT13Bonus = false

--	Check how many tier 13 items we have on
local playerSetBonusHandlerForT13 = CreateFrame("Frame", "JSHB_T13BONUSHANDLER")
local t13ItemsFound = 0
local t13ItemID
local function CheckPlayerHasT13Bonus()
	-- Tier 13 2 piece bonus
	-- Hands
	t13ItemsFound = 0
	t13ItemID = GetInventoryItemID("player", 10)
	if (t13ItemID and ( (t13ItemID == 78769) or (t13ItemID == 77029) or (t13ItemID == 78674) ) ) then
		t13ItemsFound = t13ItemsFound + 1
	end
	-- Shoulders
	t13ItemID = GetInventoryItemID("player", 3)
	if (t13ItemID and ( (t13ItemID == 78832) or (t13ItemID == 77032) or (t13ItemID == 78737) ) ) then
		t13ItemsFound = t13ItemsFound + 1
	end
	-- Chest
	t13ItemID = GetInventoryItemID("player", 5)
	if (t13ItemID and ( (t13ItemID == 78756) or (t13ItemID == 77028) or (t13ItemID == 78661) ) ) then
		t13ItemsFound = t13ItemsFound + 1
	end
	-- Legs
	t13ItemID = GetInventoryItemID("player", 7)
	if (t13ItemID and ( (t13ItemID == 78804) or (t13ItemID == 77031) or (t13ItemID == 78709) ) ) then
		t13ItemsFound = t13ItemsFound + 1
	end
	-- Head
	t13ItemID = GetInventoryItemID("player", 1)
	if (t13ItemID and ( (t13ItemID == 78793) or (t13ItemID == 77030) or (t13ItemID == 78698) ) ) then
		t13ItemsFound = t13ItemsFound + 1
	end
	
	playerHasT13Bonus = (t13ItemsFound > 1) and true or false
end

if (select(2, UnitClass("player") ) == "HUNTER") then
	playerSetBonusHandlerForT13:SetScript("OnEvent", function(self, event, ...) CheckPlayerHasT13Bonus() end)
	playerSetBonusHandlerForT13:RegisterEvent("UNIT_INVENTORY_CHANGED")
end

-- Prediction of new value for focus based on talents and items
local adjustment = 0
local function getPredictionAdjustment()
	adjustment = 0
	
	-- Account for MM Steady Focus buff 3 extra focus
	---- Contributed to by: osa - http://www.mmo-champion.com/threads/1169669-JSHB-The-future-and-MoP?p=17825521&viewfull=1#post17825521
	--if (GetSpecialization() == 2) and select(1, UnitAura("player", GetSpellInfo(53220), nil, "HELPFUL") ) then -- 53220 = Steady Focus (buff)
		--adjustment = adjustment + 3
	--end
	---- end osa
	
	-- Account for the T13 2-Piece bonus
	if playerHasT13Bonus then
		adjustment = adjustment + JSHB.predictionSpellBase
	end

	return (adjustment)
end

local name1, cost1, tColor1, tCost1
local function getBarColor(incPrediction)

	if (not incPrediction) then incPrediction = 0 end

	-- class colored is turned on
	if JSHB.db.profile.energybar.classcolored then
		-- high warning conditions
		if JSHB.db.profile.energybar.highwarn and ( ( (UnitPower("player") + incPrediction) / UnitPowerMax("player") ) >= JSHB.db.profile.energybar.highwarnthreshold) then
			-- class colored but over high threshold
			return JSHB.db.profile.energybar.barcolorhigh
		elseif JSHB.db.profile.energybar.lowwarn and ( (UnitPower("player") + incPrediction) < JSHB.GetMainSpellCost() ) then
			-- Focus is lower than main shot
			return JSHB.db.profile.energybar.barcolorlow
		else
			-- Tick coloring overrides the norm bar color but not high/low warnings
			if (JSHB.db.profile.energybar.ticks[1][1] == true) and (JSHB.F.EnergyBar["indicatorTick1"]) then
			
				tColor1, tCost1 = false, 0
				for i=1,5 do
					if (JSHB.db.profile.energybar.ticks[i][1] == true) and (JSHB.F.EnergyBar["indicatorTick"..i]) and (JSHB.db.profile.energybar.ticks[i][4] == true) then
						if (i > 1) then
							name1, rank, icon, castTime, minRange, maxRange  = GetSpellInfo(JSHB.db.profile.energybar.ticks[i][2])
						end
						
						if name1 == "Arcane Shot" then
							if UnitAura("player", "Thrill of the Hunt") then
								cost1 = 10
							else
								cost1 = 30
							end
						end
						
						if name1 == "Aimed Shot" then
							if UnitAura("player", "Thrill of the Hunt") then
								cost1 = 30
							else
								cost1 = 50
							end
						end
							
							
						if name1 == "Multi-Shot" then
							if UnitAura("player", "Bestial Wrath") then
								cost1 = 20
							else
							    cost1 = 40
							end
							if UnitAura("player", "Bombardment") then
								cost1 = 15
							end
							if UnitAura("player", "Thrill of the Hunt") then
							    if (cost1 - 20) > 0 then
									cost1 = cost1 - 20
								else
									cost1 = 0
								end
							end
						end
						
						if name1 == "Black Arrow" then
							cost1 = 35
						end
						if name1 == "Barrage" then
							cost1 = 60
						end
						if name1 == "Glaive Toss" then
							cost1 = 15
						end
						if name1 == "Power Shot" then
							cost1 = 15
						end
						if name1 == "A Murder of Crows" then
							cost1 = 30
						end
						if name1 == "Revive Pet" then
							cost1 = 35
						end
						
						if (i == 1) or ( (i > 1) and name1 and cost1 and (cost1 > 0) ) then						
							if (i == 1) then
								if (UnitPower("player") >= JSHB.GetMainSpellCost() ) then							
									tCost1 = JSHB.GetMainSpellCost()
									tColor1 = JSHB.db.profile.energybar.ticks[i][5]
								end								
							elseif (JSHB.db.profile.energybar.ticks[i][3] == true) and (UnitPower("player") >= (JSHB.GetMainSpellCost() + cost1) ) and ( (JSHB.GetMainSpellCost() + cost1) > tCost1) then							
								tCost1 = JSHB.GetMainSpellCost() + cost1
								tColor1 = JSHB.db.profile.energybar.ticks[i][5]								
							elseif (UnitPower("player") >= cost1) and (cost1 > tCost1) and (cost1 > tCost1) and (JSHB.db.profile.energybar.ticks[i][3] ~= true) then							
								tCost1 = cost1
								tColor1 = JSHB.db.profile.energybar.ticks[i][5]
							end
						end					
					end
				end
				
				if (tColor1 ~= false) then
					return tColor1
				else
					return { RAID_CLASS_COLORS[JSHB.playerClass].r, RAID_CLASS_COLORS[JSHB.playerClass].g, RAID_CLASS_COLORS[JSHB.playerClass].b, 1 }
				end
			else
				-- class colored not over high threshold or high threshold is turned off
				return { RAID_CLASS_COLORS[JSHB.playerClass].r, RAID_CLASS_COLORS[JSHB.playerClass].g, RAID_CLASS_COLORS[JSHB.playerClass].b, 1 }
			end
		end

	-- class colored is not turned on
	elseif JSHB.db.profile.energybar.highwarn and ( ( (UnitPower("player") + incPrediction) / UnitPowerMax("player") ) >= JSHB.db.profile.energybar.highwarnthreshold) then
		-- over the threshold enabled, set to the high warning color	
		return JSHB.db.profile.energybar.barcolorhigh
	elseif JSHB.db.profile.energybar.lowwarn and ( (UnitPower("player") + incPrediction) < JSHB.GetMainSpellCost() ) then
		-- Focus is lower than main shot
		return JSHB.db.profile.energybar.barcolorlow
	else
		-- Tick coloring overrides the norm bar color but not high/low warnings
		if (JSHB.db.profile.energybar.ticks[1][1] == true) and (JSHB.F.EnergyBar["indicatorTick1"]) then
			tColor1, tCost1 = false, 0
			for i=1,5 do
				if (JSHB.db.profile.energybar.ticks[i][1] == true) and (JSHB.F.EnergyBar["indicatorTick"..i]) and (JSHB.db.profile.energybar.ticks[i][4] == true) then
					if (i > 1) then
						
							name1, rank, icon, castTime, minRange, maxRange  = GetSpellInfo(JSHB.db.profile.energybar.ticks[i][2])
						end
						
						if name1 == "Arcane Shot" then
							cost1 = 30
						end
						if name1 == "Aimed Shot" then
							if UnitAura("player", "Thrill of the Hunt") then
								cost1 = 30
							else
								cost1 = 50
							end
						end
						if name1 == "Multi-Shot" then
							if UnitAura("player", "Bestial Wrath") then
								cost1 = 20
							else
							    cost1 = 40
							end
							if UnitAura("player", "Bombardment") then
								cost1 = 15
							end
							if UnitAura("player", "Thrill of the Hunt") then
							    if (cost1 - 20) > 0 then
									cost1 = cost1 - 20
								else
									cost1 = 0
								end
							end
						end
						if name1 == "Black Arrow" then
							cost1 = 35
						end
						if name1 == "Barrage" then
							cost1 = 60
						end
						if name1 == "Glaive Toss" then
							cost1 = 15
						end
						if name1 == "Power Shot" then
							cost1 = 15
						end
						if name1 == "A Murder of Crows" then
							cost1 = 30
						end
						if name1 == "Revive Pet" then
							cost1 = 35
						end
						
					if (i == 1) or ( (i > 1) and name1 and cost1 and (cost1 > 0) ) then					
						if (i == 1) then
							if (UnitPower("player") >= JSHB.GetMainSpellCost() ) then						
								tCost1 = JSHB.GetMainSpellCost()
								tColor1 = JSHB.db.profile.energybar.ticks[i][5]
							end							
						elseif (JSHB.db.profile.energybar.ticks[i][3] == true) and (UnitPower("player") >= (JSHB.GetMainSpellCost() + cost1) ) and ( (JSHB.GetMainSpellCost() + cost1) > tCost1) then						
							tCost1 = JSHB.GetMainSpellCost() + cost1
							tColor1 = JSHB.db.profile.energybar.ticks[i][5]							
						elseif (UnitPower("player") >= cost1) and (cost1 > tCost1) and (JSHB.db.profile.energybar.ticks[i][3] ~= true) then						
							tCost1 = cost1
							tColor1 = JSHB.db.profile.energybar.ticks[i][5]
						end
					end					
				end
			end
			
			if (tColor1 ~= false) then
				return tColor1
			else
				return JSHB.db.profile.energybar.barcolor
			end
		else
			-- class colored not over high threshold or high threshold is turned off
			return JSHB.db.profile.energybar.barcolor
		end
	end
end

local newPrediction1, barColor1
local function updatePrediction()

	if JSHB.db.profile.energybar.enableprediction and JSHB.F.EnergyBar.playerIsCasting then

		-- Add values if AotF active and talent points, and Termination points, etc...
		newPrediction1 = JSHB.predictionSpellBase + getPredictionAdjustment()

		barColor1 = getBarColor(newPrediction1)
		
		JSHB.F.EnergyBar.PredictionFrame:SetSize(
			(JSHB.F.EnergyBar:GetWidth() / 100) * newPrediction1, JSHB.F.EnergyBar:GetHeight() )

		JSHB.F.EnergyBar.PredictionFrame:ClearAllPoints()
		JSHB.F.EnergyBar.PredictionFrame:SetPoint("LEFT", JSHB.F.EnergyBar, "LEFT",
			JSHB.F.EnergyBar:GetWidth() / (select(2, JSHB.F.EnergyBar:GetMinMaxValues() ) / JSHB.F.EnergyBar:GetValue() ), 0)

		if (UnitPower("player") + newPrediction1) > UnitPowerMax("player") then
			JSHB.F.EnergyBar.PredictionFrame:SetSize(
				(JSHB.F.EnergyBar:GetWidth() / 100) * (UnitPowerMax("player") - UnitPower("player") ), JSHB.F.EnergyBar:GetHeight() )			
		end
		
		JSHB.F.EnergyBar.PredictionFrame:SetStatusBarColor(barColor1[1], barColor1[2], barColor1[3], 1)
		
		if ( (UnitPowerMax("player") - UnitPower("player") ) > 0) and (not UnitIsDeadOrGhost("player") ) then
			JSHB.F.EnergyBar.PredictionFrame:SetAlpha(JSHB.F.EnergyBar:GetAlpha() * 0.6)
			JSHB.F.EnergyBar.PredictionFrame:Show()
		else
			JSHB.F.EnergyBar.PredictionFrame:Hide()
		end
	end
end

function JSHB.SetupEnergyBarModule()

	-- Destruction
	local ii = 1
	if JSHB.F.StackBars then
		while (JSHB.F.StackBars[ii] ~= nil) do
			JSHB.F.StackBars[ii]:Hide()
			JSHB.F.StackBars[ii]:UnregisterAllEvents()
			JSHB.F.StackBars[ii]:SetScript("OnUpdate", nil)
			JSHB.F.StackBars[ii]:SetParent(nil)
			ii = ii + 1
		end
	end
	
	if JSHB.F.StackBarsHost then
		JSHB.F.StackBarsHost:Hide()
		JSHB.DeregisterMovableFrame("MOVER_STACKBARS")
		JSHB.F.StackBarsHost:SetParent(nil)
	end
	
	if JSHB.F.EnergyBar then
		JSHB.F.EnergyBar:Hide()
		JSHB.F.EnergyBar:SetScript("OnUpdate", nil)
		JSHB.F.EnergyBar:SetScript("OnEvent", nil)
		JSHB.F.EnergyBar:UnregisterAllEvents()
		if JSHB.F.EnergyBar.autoShotFrame then
			JSHB.F.EnergyBar.autoShotFrame:SetScript("OnUpdate", nil)
			if JSHB.F.EnergyBar.autoShotFrame.smoother then
				JSHB.RemoveSmooth(JSHB.F.EnergyBar.autoShotFrame)
			end
		end
		if JSHB.F.EnergyBar.smoother then
			JSHB.RemoveSmooth(JSHB.F.EnergyBar)
		end
		JSHB.DeregisterMovableFrame("MOVER_ENERGYBAR")
		JSHB.F.EnergyBar:SetParent(nil)
	end
		
	-- Construction
	if JSHB.db.profile.energybar.enabled then

		local ENERGYBAR_UPDATEINTERVAL = 0.07

		-- Create the Frame
		JSHB.F.EnergyBar = JSHB.MakeFrame(JSHB.F.EnergyBar, "StatusBar", "JSHB_ENERGYBAR", JSHB.db.profile.energybar.anchor[2] or UIParent)
		JSHB.F.EnergyBar:SetParent(JSHB.db.profile.energybar.anchor[2] or UIParent)
		JSHB.F.EnergyBar:ClearAllPoints()
		JSHB.F.EnergyBar:SetStatusBarTexture(JSHB.GetActiveTextureFile(JSHB.db.profile.energybar.bartexture) )
		JSHB.F.EnergyBar:SetMinMaxValues(0, (UnitPowerMax("player") > 0) and UnitPowerMax("player") or 100)	
		JSHB.F.EnergyBar:SetStatusBarColor(JSHB.db.profile.energybar.classcolored and
			(unpack({ RAID_CLASS_COLORS[JSHB.playerClass].r, RAID_CLASS_COLORS[JSHB.playerClass].g, RAID_CLASS_COLORS[JSHB.playerClass].b, 1}) ) or unpack(JSHB.db.profile.energybar.barcolor) )
		JSHB.F.EnergyBar:SetSize(JSHB.db.profile.energybar.width, JSHB.db.profile.energybar.height)
		JSHB.F.EnergyBar:SetPoint(JSHB.GetActiveAnchor(JSHB.db.profile.energybar.anchor) )
		JSHB.F.EnergyBar:SetAlpha(0)
		JSHB.F.EnergyBar:SetValue(UnitPower("player") )
		
		-- Create the Background and border if the user wants one
		if JSHB.db.profile.energybar.stacksretro then -- 3.7 for retro stack bars
			local sizeOverrides = {
				0, -- left
				0, -- right
				(JSHB.db.profile.energybar.stacksretroontop and 10 or 0),	-- top
				(JSHB.db.profile.energybar.stacksretroontop and 0 or -10),	-- bottom
			}
			JSHB.F.EnergyBar.backgroundRetro = JSHB.MakeBackground(JSHB.F.EnergyBar, JSHB.db.profile.energybar, nil, sizeOverrides, JSHB.F.EnergyBar.backgroundRetro)
			JSHB.F.EnergyBar.backgroundRetro:Hide()
		elseif JSHB.F.EnergyBar.backgroundRetro then
			JSHB.F.EnergyBar.backgroundRetro:Hide()
		end
		JSHB.F.EnergyBar.background = JSHB.MakeBackground(JSHB.F.EnergyBar, JSHB.db.profile.energybar, nil, nil, JSHB.F.EnergyBar.background)

		JSHB.RegisterMovableFrame(
			"MOVER_ENERGYBAR",
			JSHB.F.EnergyBar,
			JSHB.F.EnergyBar,
			JSHB.L["Focus Bar"],
			JSHB.db.profile.energybar,
			JSHB.SetupEnergyBarModule,
			JSHB.defaults.profile.energybar,
			JSHB.db.profile.energybar
		)
		
		if JSHB.db.profile.energybar.smoothbar then
			JSHB.MakeSmooth(JSHB.F.EnergyBar)
		end
		--show the number
		if JSHB.db.profile.energybar.energynumber then		
			JSHB.F.EnergyBar.value = JSHB.F.EnergyBar.value or JSHB.F.EnergyBar:CreateFontString(nil, "OVERLAY")
			JSHB.F.EnergyBar.value:ClearAllPoints()
			JSHB.F.EnergyBar.value:SetJustifyH("CENTER")
			JSHB.F.EnergyBar.value:SetPoint("CENTER", JSHB.F.EnergyBar, "CENTER", JSHB.db.profile.energybar.energyfontoffset, (JSHB.db.profile.energybar.shotbar == true) and 2 or 0)
			JSHB.F.EnergyBar.value:SetFont(JSHB.GetActiveFont(JSHB.db.profile.energybar.energyfont) )
			JSHB.F.EnergyBar.value:SetTextColor(unpack(JSHB.db.profile.energybar.energyfontcolor) )
			JSHB.F.EnergyBar.value:SetText(UnitPower("player") )
			JSHB.F.EnergyBar.value:Show()
		elseif JSHB.F.EnergyBar.value then
			JSHB.F.EnergyBar.value:Hide()
		end

		if JSHB.db.profile.energybar.targethealth then		
			JSHB.F.EnergyBar.targetHealthValue = JSHB.F.EnergyBar.targetHealthValue or JSHB.F.EnergyBar:CreateFontString(nil, "OVERLAY")
			JSHB.F.EnergyBar.targetHealthValue:ClearAllPoints()
			JSHB.F.EnergyBar.targetHealthValue:SetJustifyH("LEFT")
			JSHB.F.EnergyBar.targetHealthValue:SetPoint("LEFT", JSHB.F.EnergyBar, "LEFT", 1 + JSHB.db.profile.energybar.healthfontoffset, (JSHB.db.profile.energybar.shotbar == true) and 2 or 0)
			JSHB.F.EnergyBar.targetHealthValue:SetFont(JSHB.GetActiveFont(JSHB.db.profile.energybar.healthfont) )
			JSHB.F.EnergyBar.targetHealthValue:SetText("")
			JSHB.F.EnergyBar.targetHealthValue:Show()
		elseif JSHB.F.EnergyBar.targetHealthValue then
			JSHB.F.EnergyBar.targetHealthValue:Hide()
		end
		
		-- Setup prediction bar
		if JSHB.db.profile.energybar.enableprediction then		
			JSHB.F.EnergyBar.PredictionFrame = JSHB.F.EnergyBar.PredictionFrame or CreateFrame("StatusBar", nil, JSHB.F.EnergyBar)
			JSHB.F.EnergyBar.PredictionFrame:SetParent(JSHB.F.EnergyBar)
			JSHB.F.EnergyBar.PredictionFrame:ClearAllPoints()
			JSHB.F.EnergyBar.PredictionFrame:SetStatusBarTexture(JSHB.F.EnergyBar:GetStatusBarTexture():GetTexture() ) -- Use the main bar's texture
			JSHB.F.EnergyBar.PredictionFrame:SetMinMaxValues(0, 1)
			JSHB.F.EnergyBar.PredictionFrame:SetValue(1)
			JSHB.F.EnergyBar.PredictionFrame:SetFrameLevel(JSHB.F.EnergyBar:GetFrameLevel() )
			JSHB.F.EnergyBar.PredictionFrame:SetSize( (JSHB.F.EnergyBar:GetWidth() / 100) * (JSHB.predictionSpellBase + getPredictionAdjustment() ), JSHB.F.EnergyBar:GetHeight() )		   
			JSHB.F.EnergyBar.PredictionFrame:Hide()
		elseif JSHB.F.EnergyBar.PredictionFrame then
			JSHB.F.EnergyBar.PredictionFrame:Hide()
		end
		
		-- Setup Auto shot bar
		if JSHB.db.profile.energybar.shotbar then
			JSHB.F.EnergyBar.autoShotFrame = JSHB.F.EnergyBar.autoShotFrame or CreateFrame("StatusBar", nil, JSHB.F.EnergyBar)
			JSHB.F.EnergyBar.autoShotFrame:SetParent(JSHB.F.EnergyBar)
			JSHB.F.EnergyBar.autoShotFrame:ClearAllPoints()
			JSHB.F.EnergyBar.autoShotFrame:SetStatusBarTexture(JSHB.F.EnergyBar:GetStatusBarTexture():GetTexture() ) -- Use the main bar's texture
			JSHB.F.EnergyBar.autoShotFrame:SetPoint("BOTTOMLEFT", JSHB.F.EnergyBar, "BOTTOMLEFT", 0, 0)
			JSHB.F.EnergyBar.autoShotFrame:SetMinMaxValues(0, UnitRangedDamage("player") * 100)
			JSHB.F.EnergyBar.autoShotFrame:SetSize(JSHB.F.EnergyBar:GetWidth(), 3)
			JSHB.F.EnergyBar.autoShotFrame:SetValue(UnitRangedDamage("player") )
			JSHB.F.EnergyBar.autoShotFrame:SetFrameLevel(JSHB.F.EnergyBar:GetFrameLevel() + 1)		
			JSHB.F.EnergyBar.autoShotFrame:SetStatusBarColor(unpack(JSHB.db.profile.energybar.shotbarcolor) )
			
			if JSHB.db.profile.energybar.smoothbarshotbar then
				JSHB.MakeSmooth(JSHB.F.EnergyBar.autoShotFrame)
			end
			
			JSHB.F.EnergyBar.autoShotFrame.updateTimer = 0
			JSHB.F.EnergyBar.autoShotFrame:SetScript("OnUpdate", function(self, elapsed)
				self.updateTimer = self.updateTimer + elapsed
				if self.updateTimer <= 0.015 then return else self.updateTimer = 0 end
				self.updateTimer = 0				
				if (GetTime() < self:GetParent().autoShotEndTime) then
					self:SetValue( (UnitRangedDamage("player") * 100) - ( (self:GetParent().autoShotEndTime * 100) - (GetTime() * 100) ) )
				else
					self:SetValue(0)
					self:Hide()
				end
			end)
		elseif JSHB.F.EnergyBar.autoShotFrame then
			JSHB.F.EnergyBar.autoShotFrame:Hide()
		end
		
		-- Setup Auto shot time
		if JSHB.db.profile.energybar.shottimer then
			JSHB.F.EnergyBar.autoShotValue = JSHB.F.EnergyBar.autoShotValue or JSHB.F.EnergyBar:CreateFontString(nil, "OVERLAY")
			JSHB.F.EnergyBar.autoShotValue:ClearAllPoints()
			JSHB.F.EnergyBar.autoShotValue:SetFont(JSHB.GetActiveFont(JSHB.db.profile.energybar.shottimerfont) )
			JSHB.F.EnergyBar.autoShotValue:SetTextColor(unpack(JSHB.db.profile.energybar.shottimerfontcolor) )
			JSHB.F.EnergyBar.autoShotValue:SetPoint("BOTTOMRIGHT", JSHB.F.EnergyBar, "BOTTOMRIGHT", 1  + JSHB.db.profile.energybar.shottimerfontoffset, 1)
			JSHB.F.EnergyBar.autoShotValue:SetJustifyH("BOTTOM")
			JSHB.F.EnergyBar.autoShotValue:Show()
		elseif JSHB.F.EnergyBar.autoShotValue then
			JSHB.F.EnergyBar.autoShotValue:Hide()
		end

		-- Setup Indicator marks
		local name, cost
		for ii=1,5 do
			if (JSHB.db.profile.energybar.ticks[ii][1] == true) and ( (JSHB.db.profile.energybar.ticks[ii][6] == 0)
				or (JSHB.db.profile.energybar.ticks[ii][6] == GetSpecialization() ) ) and (JSHB.db.profile.energybar.ticks[1][1] == true) then
				
				if (ii > 1) then
					name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(JSHB.db.profile.energybar.ticks[ii][2])
				end
						
						if name == "Arcane Shot" then
							if UnitAura("player", "Thrill of the Hunt") then
								cost = 10
							else
								cost = 30
							end
						end
						if name == "Aimed Shot" then
							if UnitAura("player", "Thrill of the Hunt") then
								cost = 30
							else
								cost = 50
							end
						end
						if name == "Multi-Shot" then
							if UnitAura("player", "Bestial Wrath") then
								cost = 20
							else
							    cost = 40
							end
							if UnitAura("player", "Bombardment") then
								cost = 15
							end
							if UnitAura("player", "Thrill of the Hunt") then
							    if (cost - 20) > 0 then
									cost = cost - 20
								else
									cost = 0
								end
							end
						end
						if name == "Black Arrow" then
							cost = 35
						end
						if name == "Barrage" then
							cost = 60
						end
						if name == "Glaive Toss" then
							cost = 15
						end
						if name == "Power Shot" then
							cost = 15
						end
						if name == "A Murder of Crows" then
							cost = 30
						end
						if name == "Revive Pet" then
							cost = 35
						end
				
				
				
				
				if (ii == 1) or ( (ii > 1) and name and cost and (cost > 0) ) then
					JSHB.F.EnergyBar["indicatorTick"..ii] = JSHB.MakeFrame(JSHB.F.EnergyBar["indicatorTick"..ii], "Frame", "JSHB_ENERGYBAR_TICK"..ii, JSHB.F.EnergyBar)
					JSHB.F.EnergyBar["indicatorTick"..ii]:SetParent(JSHB.F.EnergyBar)
					JSHB.F.EnergyBar["indicatorTick"..ii]:ClearAllPoints()
					
						if JSHB.db.profile.energybar.ticks[ii][7] == true then
							JSHB.F.EnergyBar["indicatorTick"..ii]:SetSize(6, JSHB.F.EnergyBar:GetHeight() * 1.1)
						else
							JSHB.F.EnergyBar["indicatorTick"..ii]:SetSize(10, JSHB.F.EnergyBar:GetHeight() * 1.6)
						end
					
					
					--JSHB.F.EnergyBar["indicatorTick"..ii]:SetSize(10, JSHB.F.EnergyBar:GetHeight() * 1.6)
					
					JSHB.F.EnergyBar["indicatorTick"..ii].tex = JSHB.F.EnergyBar["indicatorTick"..ii].tex or JSHB.F.EnergyBar["indicatorTick"..ii]:CreateTexture(nil, "OVERLAY")
					JSHB.F.EnergyBar["indicatorTick"..ii].tex:ClearAllPoints()
					JSHB.F.EnergyBar["indicatorTick"..ii].tex:SetAllPoints(JSHB.F.EnergyBar["indicatorTick"..ii])
	
	
					-- Yes, I've made a mess of the code. Sorry if anyone tries to follow this.
					if name ~= "A Murder of Crows" and name ~= "Glaive Toss" and name ~= "Barrage" and name ~= "Black Arrow" and name ~= "Multi-Shot" and name ~= "Aimed Shot" and name ~= "Arcane Shot" then
						
						if JSHB.db.profile.energybar.ticks[1][7] == true then
						currentSpec = GetSpecialization()
							if (currentSpec == 1) then
								_, _, icon2, _, _, _ = GetSpellInfo("Kill Command")
								JSHB.F.EnergyBar["indicatorTick"..ii].tex:SetTexture(icon2)
							end
							
							if (currentSpec == 2) then
								_, _, icon2, _, _, _ = GetSpellInfo("Chimaera Shot")
								JSHB.F.EnergyBar["indicatorTick"..ii].tex:SetTexture(icon2)
	
							end
							if (currentSpec == 3) then
								_, _, icon2, _, _, _ = GetSpellInfo("Explosive Shot")
								JSHB.F.EnergyBar["indicatorTick"..ii].tex:SetTexture(icon2)
							end
						else						
							JSHB.F.EnergyBar["indicatorTick"..ii].tex:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
						end
						
					else	
						if JSHB.db.profile.energybar.ticks[ii][7] == true then
							JSHB.F.EnergyBar["indicatorTick"..ii].tex:SetTexture(icon)
						else
							JSHB.F.EnergyBar["indicatorTick"..ii].tex:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
						end
						
						
					end
					if JSHB.db.profile.energybar.ticks[ii][7] == true then
						JSHB.F.EnergyBar["indicatorTick"..ii].tex:SetBlendMode("DISABLE")
					else
						JSHB.F.EnergyBar["indicatorTick"..ii].tex:SetBlendMode("ADD")
					end
					
					JSHB.F.EnergyBar["indicatorTick"..ii]:SetAlpha(1)
					JSHB.F.EnergyBar["indicatorTick"..ii]:Hide()
					
				elseif JSHB.F.EnergyBar["indicatorTick"..ii] then
					JSHB.F.EnergyBar["indicatorTick"..ii]:Hide()
				end
			elseif JSHB.F.EnergyBar["indicatorTick"..ii] then
				JSHB.F.EnergyBar["indicatorTick"..ii]:Hide()
			end
		end
		
		-- Register Events to support the bar
		JSHB.F.EnergyBar:RegisterEvent("UNIT_SPELLCAST_START")
		JSHB.F.EnergyBar:RegisterEvent("UNIT_SPELLCAST_STOP")
		JSHB.F.EnergyBar:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
		JSHB.F.EnergyBar:RegisterEvent("UNIT_SPELLCAST_FAILED")
		JSHB.F.EnergyBar:RegisterEvent("UNIT_MAXPOWER")
		JSHB.F.EnergyBar:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
		JSHB.F.EnergyBar.autoShotStartTime = 0
		JSHB.F.EnergyBar.autoShotEndTime = 0
		JSHB.F.EnergyBar:SetScript("OnEvent", function(self, event, ...)
			self.sourceUnit1, self._, self._, self._, self.spellId1 = ...

			if (event == "UNIT_SPELLCAST_START") and JSHB.db.profile.energybar.enableprediction then
			
				if (self.sourceUnit1 == "player") then						
					if (self.spellId1  == 56641) or (self.spellId1 == 77767) then -- HUNTER: Steady Shot / Cobra Shot
						self.playerIsCasting = true
						updatePrediction()
					end
				end
			
			elseif (event == "UNIT_SPELLCAST_SUCCEEDED") and (self.spellId1 == 75) and (JSHB.db.profile.energybar.shotbar or JSHB.db.profile.energybar.shottimer) then -- HUNTER: Auto shot
			
				self.autoShotStartTime = GetTime()
				self.autoShotEndTime = self.autoShotStartTime + UnitRangedDamage("player")

				if JSHB.db.profile.energybar.shotbar then
					self.autoShotFrame:Show()
				end

				if JSHB.db.profile.energybar.shottimer then
					self.autoShotValue:SetFormattedText("%.1f", self.autoShotEndTime - GetTime() ) -- "%.1f"
				end
			
			elseif (event == "UNIT_MAXPOWER") then
			
				self:SetMinMaxValues(0, UnitPowerMax("player") )
			
			elseif (event == "UNIT_SPELLCAST_STOP") or (event == "UNIT_SPELLCAST_FAILED") then
			
				if ( (self.spellId1 == 56641) or (self.spellId1 == 77767) ) and JSHB.db.profile.energybar.enableprediction then -- HUNTER: Steady Shot / Cobra Shot			
					self.playerIsCasting = nil					
					self.PredictionFrame:Hide()
				end
				
			elseif (event == "PLAYER_SPECIALIZATION_CHANGED") then

				JSHB.SetupEnergyBarModule()
			end
		end)
		
		-- Setup the script for handling the bar
		JSHB.F.EnergyBar.updateTimer = 0
		JSHB.F.EnergyBar.doPrediction = (select(2, UnitClass("player") ) == "HUNTER") and true or nil
		JSHB.F.EnergyBar:SetScript("OnUpdate", function(self, elapsed)
		
			self.updateTimer = self.updateTimer + elapsed
			
			if self.updateTimer < ENERGYBAR_UPDATEINTERVAL then return else self.updateTimer = 0 end
		
			-- Overrides take precidence over normal alpha
			if C_PetBattles.IsInBattle() then
				self:SetAlpha(0) -- Hide for pet battles
			elseif JSHB.db.profile.energybar.deadoverride and UnitIsDeadOrGhost("player") then			
				self:SetAlpha(JSHB.db.profile.energybar.deadoverridealpha)
			elseif JSHB.db.profile.energybar.mountoverride and (IsMounted() or UnitUsingVehicle("player") ) then			
				self:SetAlpha(JSHB.db.profile.energybar.mountoverridealpha)				
			elseif JSHB.db.profile.energybar.oocoverride and (not InCombatLockdown() ) then			
				self:SetAlpha(JSHB.db.profile.energybar.oocoverridealpha)				
			elseif (UnitPower("player") ~= UnitPowerMax("player") ) then			
				self:SetAlpha(JSHB.db.profile.energybar.activealpha)
			else			
				self:SetAlpha(JSHB.db.profile.energybar.inactivealpha)
			end
			
			-- Handle status bar updating
			self:SetValue(UnitPower("player") )
			
			if (JSHB.db.profile.energybar.energynumber and self.value) then
				self.value:SetText(UnitPower("player") )
			end

			self:SetStatusBarColor(unpack(getBarColor() ) )

			-- Update the prediction bar, if enabled (Only suppors Hunters right now)
			if self.doPrediction then updatePrediction() end
			
			-- Update Shot time
			if JSHB.db.profile.energybar.shottimer then
				if (not UnitIsDeadOrGhost("player") ) and (GetTime() < self.autoShotEndTime) and InCombatLockdown() then
					self.autoShotValue:SetFormattedText("%.1f", self.autoShotEndTime - GetTime() )
				else
					self.autoShotValue:SetText("")
				end
			end
			
			-- Handle Target Health Percentage
			if JSHB.db.profile.energybar.targethealth then			
				if (not UnitExists("target") ) or (UnitIsDeadOrGhost("target") ) then 
					self.targetHealthValue:SetText("")
				else
					if ( (UnitHealth("target") / UnitHealthMax("target") ) >= .9) then					
						self.targetHealthValue:SetFormattedText("|cffffff00%d %%|r", (UnitHealth("target") / UnitHealthMax("target") ) * 100)						
					elseif (UnitHealth("target") / UnitHealthMax("target") >= .2) then					
						self.targetHealthValue:SetFormattedText("|cffffffff%d %%|r", (UnitHealth("target") / UnitHealthMax("target") ) * 100)						
					else
						self.targetHealthValue:SetFormattedText("|cffff0000%d %%|r", (UnitHealth("target") / UnitHealthMax("target") ) * 100)
					end
				end			
			end
			
			-- Handle indicator tick marks
			for i=1,5 do
				if (JSHB.db.profile.energybar.ticks[i][1] == true) and (self["indicatorTick"..i] ~= nil) and (JSHB.db.profile.energybar.ticks[1][1] == true) then
				
					if (i > 1) then
						--self.name2, _, _, self.cost2 = GetSpellInfo(JSHB.db.profile.energybar.ticks[i][2])
						self.name2 = ""
						self.name2, rank, icon, castTime, minRange, maxRange = GetSpellInfo(JSHB.db.profile.energybar.ticks[i][2])
					end
					
						if self.name2 == "Arcane Shot" then
							if UnitAura("player", "Thrill of the Hunt") then
								self.cost2 = 10
							else
								self.cost2 = 30
							end
						end
						if self.name2 == "Aimed Shot" then
							if UnitAura("player", "Thrill of the Hunt") then
							self.cost2 = 30
								else
							self.cost2 = 50
							end
						end
						
						if self.name2 == "Multi-Shot" then
							if UnitAura("player", "Bestial Wrath") then
								self.cost2 = 20
							else
							    self.cost2 = 40
							end
							if UnitAura("player", "Bombardment") then
								self.cost2 = 15
							end
							if UnitAura("player", "Thrill of the Hunt") then
							    if (self.cost2 - 20) > 0 then
									self.cost2 = self.cost2 - 20
								else
									self.cost2 = 0
								end
							end
							
						end
					
						if self.name2 == "Black Arrow" then
							self.cost2 = 35
						end
						if self.name2 == "Barrage" then
							self.cost2 = 60
						end
						if self.name2 == "Glaive Toss" then
							self.cost2 = 15
						end
						if self.name2 == "Power Shot" then
							self.cost2 = 15
						end
						if self.name2 == "A Murder of Crows" then
							self.cost2 = 30
						end
						if self.name2 == "Revive Pet" then
							self.cost2 = 35
						end
					
					
					
					if (i == 1) or ( (i > 1) and self.name2 and self.cost2 and (self.cost2 > 0) ) then
						if (i == 1) then
							self["indicatorTick"..i]:ClearAllPoints()
							self["indicatorTick"..i]:SetPoint("LEFT", self, "LEFT", JSHB.GetMainSpellCost() * (self:GetWidth() / select(2, self:GetMinMaxValues() ) ) - 5, 0)
						else
							self["indicatorTick"..i]:ClearAllPoints()
							--was using this to put the icons below the bar, testing out something. Leaving in just because.
								if JSHB.db.profile.energybar.ticks[i][7] == true then
									yy = -0
								else
									yy = 0
								end
							
							
							self["indicatorTick"..i]:SetPoint("LEFT", self, "LEFT", 
								( (JSHB.db.profile.energybar.ticks[i][3] == true) and (JSHB.GetMainSpellCost() + self.cost2) or self.cost2) * 
								
								--Set how high off the bar it is
							
									(self:GetWidth() / select(2, self:GetMinMaxValues() ) ) - 5, yy)

									
						end
						self["indicatorTick"..i]:Show()
					else
						self["indicatorTick"..i]:Hide()
					end
				end
			end
		end)
		JSHB.F.EnergyBar:Show()
	end
	
	-- Construct the Stacks indicator
	if (not JSHB.db.profile.energybar.enablestacks) then return end
	
	if (not JSHB.db.profile.energybar.enabled) and (JSHB.db.profile.energybar.embedstacks or JSHB.db.profile.energybar.stacksretro) then return end

	local STACKBARS_UPDATEINTERVAL = 0.1
	local numBars = 1
	local barSize = 0
	local checkFunction = function(self) return end
	local checkStacksFunction = function(self) return(0) end
	local checkProcFunction = function(self) return end
	local stackSize = 0

	-- Setup the host frame & mover if not embedded
	JSHB.F.StackBarsHost = JSHB.MakeFrame(JSHB.F.StackBarsHost, "Frame", "JSHB_STACKBARS_HOST", JSHB.db.profile.energybar.embedstacks and JSHB.F.EnergyBar or (JSHB.db.profile.energybar.anchor_stacks[2] or UIParent) )
	JSHB.F.StackBarsHost:SetParent(JSHB.db.profile.energybar.embedstacks and JSHB.F.EnergyBar or (JSHB.db.profile.energybar.anchor_stacks[2] or UIParent) )
	JSHB.F.StackBarsHost:ClearAllPoints()
	
	JSHB.stackBarOn = false

	-- Setup the check functions for various specs
	JSHB.F.StackBarsHost.stacks = nil
	JSHB.F.StackBarsHost.proc = nil
	
	local Check_FlashAtMax = function(self)
		JSHB.F.StackBarsHost.stacks = checkStacksFunction()
		if (not JSHB.db.profile.energybar.stacksretro) then -- New Style
		
			if JSHB.F.StackBarsHost.stacks >= self.barIndex then
				if (JSHB.F.StackBarsHost.stacks >= self.totalBars) then
					self:SetAlpha(1)
					return true
				else
					self:SetAlpha(1)
				end
			else
				self:SetAlpha(0)
			end
			
		else -- Retro Style
			if (JSHB.F.StackBarsHost.stacks == 0) then
				if JSHB.stackBarOn then
					if JSHB.F.EnergyBar and JSHB.F.EnergyBar.background then
						JSHB.F.EnergyBar.backgroundRetro:Hide()
						JSHB.F.EnergyBar.background:Show()
					end
					JSHB.stackBarOn = false
				end
				self:SetAlpha(0)
				return false
				
			elseif (JSHB.F.StackBarsHost.stacks > 0) and (not JSHB.stackBarOn) then
				if JSHB.F.EnergyBar and JSHB.F.EnergyBar.background then
					JSHB.F.EnergyBar.backgroundRetro:Show()
					JSHB.F.EnergyBar.background:Hide()
				end
				JSHB.stackBarOn = true
			end

			if (JSHB.F.StackBarsHost.stacks >= self.barIndex) then
				self.backdrop:SetTexture(0, .6, 0, 1) -- Green
				if (JSHB.F.StackBarsHost.stacks == numBars) then
					self:SetAlpha(1)
					return true
				end
			else
				self.backdrop:SetTexture(0, 0, 0, 1) -- Black
			end

			self:SetAlpha(1)
			return false	
		end
	end
	
	local Check_FlashNotMax = function(self)
		JSHB.F.StackBarsHost.stacks = checkStacksFunction()
		if (not JSHB.db.profile.energybar.stacksretro) then -- New Style
		
			if JSHB.F.StackBarsHost.stacks >= self.barIndex then
				if (JSHB.F.StackBarsHost.stacks >= self.totalBars) then
					self:SetAlpha(1)
				else
					self:SetAlpha(1)
					return true
				end
			else
				self:SetAlpha(0)
			end
			
		else -- Retro Style
			if (JSHB.F.StackBarsHost.stacks == 0) then
				if JSHB.stackBarOn then
					if JSHB.F.EnergyBar and JSHB.F.EnergyBar.background then
						JSHB.F.EnergyBar.backgroundRetro:Hide()
						JSHB.F.EnergyBar.background:Show()
					end
					JSHB.stackBarOn = false
				end
				self:SetAlpha(0)
				return false
				
			elseif (JSHB.F.StackBarsHost.stacks > 0) and (not JSHB.stackBarOn) then
				if JSHB.F.EnergyBar and JSHB.F.EnergyBar.background then
					JSHB.F.EnergyBar.backgroundRetro:Show()
					JSHB.F.EnergyBar.background:Hide()
				end
				JSHB.stackBarOn = true
			end

			if (JSHB.F.StackBarsHost.stacks >= self.barIndex) then
				self.backdrop:SetTexture(0, .6, 0, 1) -- Green
				self:SetAlpha(1)
				if (JSHB.F.StackBarsHost.stacks == self.totalBars) then
					return false
				end
				return true
			end
			
			self.backdrop:SetTexture(0, 0, 0, 1) -- Black
			self:SetAlpha(0)
			return false	
		end
	end
	
	local Check_AlwaysFlash = function(self)
		JSHB.F.StackBarsHost.stacks = checkStacksFunction()
		if (not JSHB.db.profile.energybar.stacksretro) then -- New Style
		
			if JSHB.F.StackBarsHost.stacks >= self.barIndex then
				self:SetAlpha(1)
				return true -- SV always flashes, cause stacks work reversed.  It's a proc, not a build-up.
			else
				self:SetAlpha(0)
			end
			
		else -- Retro Style
			if (JSHB.F.StackBarsHost.stacks ~= 0) then
				if (not JSHB.stackBarOn) then
					if JSHB.F.EnergyBar and JSHB.F.EnergyBar.background then
						JSHB.F.EnergyBar.backgroundRetro:Show()
						JSHB.F.EnergyBar.background:Hide()
					end
					JSHB.stackBarOn = true					
				end
			else
				if JSHB.stackBarOn then
					if JSHB.F.EnergyBar and JSHB.F.EnergyBar.background then
						JSHB.F.EnergyBar.backgroundRetro:Hide()
						JSHB.F.EnergyBar.background:Show()
					end
					JSHB.stackBarOn = false
				end
			end			
			
			if (JSHB.F.StackBarsHost.stacks >= self.barIndex) then			
				self.backdrop:SetTexture(0, .6, 0, 1) -- Green
				self:SetAlpha(1)
				return true
			else
				self.backdrop:SetTexture(0, 0, 0, 1) -- Black
				self:SetAlpha(0)
			end
			return false
		end
	end
		
	local Check_FlashWithProc = function(self)
		JSHB.F.StackBarsHost.stacks = checkStacksFunction()
		JSHB.F.StackBarsHost.proc = checkProcFunction()
		if (not JSHB.db.profile.energybar.stacksretro) then -- New Style
		
			if JSHB.F.StackBarsHost.proc then
				self:SetAlpha(1)
				return true
			elseif (JSHB.F.StackBarsHost.stacks >= self.barIndex) then
				self:SetAlpha(1)
			else
				self:SetAlpha(0)
			end
			
		else -- Retro Style
			if JSHB.F.StackBarsHost.proc then
				if (not JSHB.stackBarOn) then
					if JSHB.F.EnergyBar and JSHB.F.EnergyBar.background then
						JSHB.F.EnergyBar.backgroundRetro:Show()
						JSHB.F.EnergyBar.background:Hide()
					end
					JSHB.stackBarOn = true
				end
				self:SetAlpha(1)
				return true
			end

			if (JSHB.F.StackBarsHost.stacks == 0) then
				if JSHB.stackBarOn then
					if JSHB.F.EnergyBar and JSHB.F.EnergyBar.background then
						JSHB.F.EnergyBar.backgroundRetro:Hide()
						JSHB.F.EnergyBar.background:Show()
					end
					JSHB.stackBarOn = false
				end
				self:SetAlpha(0)
				return false
			elseif (JSHB.F.StackBarsHost.stacks > 0) and (not JSHB.stackBarOn) then
				if JSHB.F.EnergyBar and JSHB.F.EnergyBar.background then
					JSHB.F.EnergyBar.backgroundRetro:Show()
					JSHB.F.EnergyBar.background:Hide()
				end
				JSHB.stackBarOn = true
			end

			if (JSHB.F.StackBarsHost.stacks >= self.barIndex) then				
				self.backdrop:SetTexture(0, .6, 0, 1) -- Green
			else
				self.backdrop:SetTexture(0, 0, 0, 1) -- Black
			end

			self:SetAlpha(1)
			return false
		end
	end

	if (GetSpecialization() == 1) then -- H:BM / Wa:ARMS

		if (select(2, UnitClass("player") ) == "WARRIOR") then
			numBars = 5 -- Taste for Blood stacks.
			checkStacksFunction = function(self) return(select(4, UnitAura("player", GetSpellInfo(60503), nil, "HELPFUL") ) or 0) end -- 60503 = Tase for Blood stacks.
			checkFunction = Check_FlashAtMax
		elseif (select(2, UnitClass("player") ) == "ROGUE") then
			numBars = MAX_COMBO_POINTS -- Combo Points.
			checkStacksFunction = function(self) return( ( (not UnitIsDeadOrGhost("player") ) and UnitExists("target") ) and GetComboPoints("player", "target") or 0) end -- Combo points on target.
			checkFunction = Check_FlashAtMax
		elseif (select(2, UnitClass("player") ) == "WARLOCK") then
			numBars = 4
			checkStacksFunction = function(self) return(UnitPower("player", SPELL_POWER_SOUL_SHARDS) or 0) end -- Soul Shards
			checkFunction = Check_FlashAtMax
		else -- HUNTER is default
			numBars = 5 -- Frenzy Stacks on pet for focus fire.
			checkStacksFunction = function(self) return(select(4, UnitAura("pet", GetSpellInfo(19615), nil, "HELPFUL") ) or 0) end -- 19615 = Frenzy Effect
			checkFunction = Check_FlashAtMax
		end
		
	elseif (GetSpecialization() == 2) then -- H:MM / Wa:Fury
	
		if (select(2, UnitClass("player") ) == "WARRIOR") then
			numBars = 3 -- Blood Surge stacks.
			checkStacksFunction = function(self) return(select(4, UnitAura("player", GetSpellInfo(46916), nil, "HELPFUL") ) or 0) end -- 46916 = Blood Surge.
			checkProcFunction = function(self) return(select(1, UnitAura("player", GetSpellInfo(46916), nil, "HELPFUL") ) or false) end -- 46916 = Blood Surge.
			checkFunction = Check_FlashWithProc
		elseif (select(2, UnitClass("player") ) == "ROGUE") then
			numBars = MAX_COMBO_POINTS -- Combo Points.
			checkStacksFunction = function(self) return( ( (not UnitIsDeadOrGhost("player") ) and UnitExists("target") ) and GetComboPoints("player", "target") or 0) end -- Combo points on target.
			checkFunction = Check_FlashAtMax
		elseif (select(2, UnitClass("player") ) == "WARLOCK") then
			numBars = 10
			checkStacksFunction = function(self) return( ( (UnitPower("player", SPELL_POWER_DEMONIC_FURY) or 0) + 1) / 100)	end -- Demonic Fury (1 stack = 200)
			checkFunction = Check_FlashAtMax
		else -- HUNTER is default
			numBars = 3 -- Ready, Set, Aim... on player		
			--checkStacksFunction = function(self) return(select(4, UnitAura("player", GetSpellInfo(82925), nil, "HELPFUL") ) or 0) end -- 82925 = Ready, Set, Aim...
			--checkProcFunction = function(self) return(select(1, UnitAura("player", GetSpellInfo(82926), nil, "HELPFUL") ) or false) end -- 82926 = Fire! proc
			checkFunction = Check_FlashWithProc
		end
		
	elseif (GetSpecialization() == 3) then -- H:SV / Wa:Prot
	
		if (select(2, UnitClass("player") ) == "WARRIOR") then
			numBars = 3 -- Weakened Armor on target.
			checkStacksFunction = function(self) return(select(4, UnitAura("target", GetSpellInfo(113746), nil, "HARMFUL") ) or 0) end -- 113746 = Weakened Armor stacks.
			checkFunction = Check_FlashNotMax
		elseif (select(2, UnitClass("player") ) == "ROGUE") then
			numBars = MAX_COMBO_POINTS -- Combo Points.
			checkStacksFunction = function(self) return( ( (not UnitIsDeadOrGhost("player") ) and UnitExists("target") ) and GetComboPoints("player", "target") or 0) end -- Combo points on target.
			checkFunction = Check_FlashAtMax
		elseif (select(2, UnitClass("player") ) == "WARLOCK") then
			numBars = 4
			checkStacksFunction = function(self) return(UnitPower("player", SPELL_POWER_BURNING_EMBERS) or 0) end -- Burning Embers
			checkFunction = Check_FlashAtMax
		else -- HUNTER is default
			numBars = 2 -- 56342 = Lock n' Load proc
			checkStacksFunction = function(self) return(select(4, UnitAura("player", GetSpellInfo(168980), nil, "HELPFUL") ) or 0) end -- 56342 = Lock n' Load proc
			checkFunction = Check_AlwaysFlash
		end
	end
	
	if JSHB.db.profile.energybar.stacksretro then
		stackSize = ( (JSHB.db.profile.energybar.width - ( (numBars - 1) * 4) ) - 2) / numBars
	else
		stackSize = JSHB.db.profile.energybar.embedstacks and (JSHB.db.profile.energybar.height * .85) or JSHB.db.profile.energybar.stackssize
	end
	
	local gap = 0
	local totalWidth = ( (stackSize + gap) * numBars) - gap
	
	if JSHB.db.profile.energybar.stacksretro then
		JSHB.F.StackBarsHost:SetSize(JSHB.db.profile.energybar.width, 5)
	else
		JSHB.F.StackBarsHost:SetSize( (stackSize + gap) * numBars - gap, stackSize)
	end
	
	if JSHB.db.profile.energybar.embedstacks or JSHB.db.profile.energybar.stacksretro then
		if JSHB.db.profile.energybar.stacksretro then
			if JSHB.db.profile.energybar.stacksretroontop then
				JSHB.F.StackBarsHost:SetPoint("BOTTOMLEFT", JSHB.F.EnergyBar, "TOPLEFT", 0, 3)
			else
				JSHB.F.StackBarsHost:SetPoint("TOPLEFT", JSHB.F.EnergyBar, "BOTTOMLEFT", 0, -3)
			end
		else
			JSHB.F.StackBarsHost:SetPoint("RIGHT", JSHB.F.EnergyBar, "TOPRIGHT")
		end
	else
		JSHB.F.StackBarsHost:SetPoint(JSHB.GetActiveAnchor(JSHB.db.profile.energybar.anchor_stacks) )
	end
	
	JSHB.F.StackBarsHost:SetAlpha(1)
	JSHB.F.StackBarsHost:Show()
		
	if (not JSHB.db.profile.energybar.embedstacks) and (not JSHB.db.profile.energybar.stacksretro) then
		JSHB.RegisterMovableFrame(
			"MOVER_STACKBARS",
			JSHB.F.StackBarsHost,
			JSHB.F.StackBarsHost,
			JSHB.L["Stacks"],
			JSHB.db.profile.energybar,
			nil,
			JSHB.defaults.profile.energybar,
			nil,
			"_stacks"
		)
	end
	
	JSHB.F.StackBars = JSHB.F.StackBars or {} -- recycle
	for i=1,numBars do
		JSHB.F.StackBars[i] = JSHB.F.StackBars[i] or CreateFrame("Frame", nil, JSHB.F.StackBarsHost)
		JSHB.F.StackBars[i]:SetParent(JSHB.F.StackBarsHost)
		JSHB.F.StackBars[i]:ClearAllPoints()
		JSHB.F.StackBars[i]:SetSize(stackSize, JSHB.db.profile.energybar.stacksretro and 5 or stackSize)
		
		if JSHB.db.profile.energybar.stacksreverse and (not JSHB.db.profile.energybar.stacksretro) then
		
			JSHB.F.StackBars[i]:SetPoint("RIGHT", JSHB.F.StackBarsHost, "RIGHT", -( (stackSize + gap) * (i - 1) ), 0)
			
		elseif JSHB.db.profile.energybar.stacksretro then
		
				JSHB.F.StackBars[i]:SetPoint("TOPLEFT", JSHB.F.StackBarsHost, "TOPLEFT", 1 + (stackSize + 4) * (i - 1), 0)
		else
		
			JSHB.F.StackBars[i]:SetPoint("LEFT", JSHB.F.StackBarsHost, "LEFT", ( (stackSize + gap) * (i - 1) ), 0)
		end

		if (not JSHB.db.profile.energybar.stacksretro) then
			JSHB.F.StackBars[i].stack = JSHB.F.StackBars[i].stack or JSHB.F.StackBars[i]:CreateTexture(nil, "ARTWORK")
			JSHB.F.StackBars[i].stack:ClearAllPoints()
			JSHB.F.StackBars[i].stack:SetAllPoints(JSHB.F.StackBars[i])
			JSHB.F.StackBars[i].stack:SetTexture("Interface\\AddOns\\JSHB\\media\\graphics\\stack1.tga")
			JSHB.F.StackBars[i].stack:SetVertexColor(unpack(JSHB.db.profile.energybar.stackscolor) )
			JSHB.F.StackBars[i].stack:Show()
			
			if JSHB.F.StackBars[i].border then
				JSHB.F.StackBars[i].border:Hide()
			end
			if JSHB.F.StackBars[i].backdrop then
				JSHB.F.StackBars[i].backdrop:Hide()
			end
		else
			if JSHB.F.StackBars[i].stack then
				JSHB.F.StackBars[i].stack:Hide()
			end
		
			JSHB.F.StackBars[i].border = JSHB.F.StackBars[i].border or CreateFrame("Frame", nil, JSHB.F.StackBars[i])
			JSHB.F.StackBars[i].border:SetParent(JSHB.F.StackBars[i])
			JSHB.F.StackBars[i].border:ClearAllPoints()
			JSHB.F.StackBars[i].border:SetBackdrop( {
				bgFile = "Interface\\AddOns\\JSHB\\media\\textures\\blank.tga", 
				edgeFile = "Interface\\AddOns\\JSHB\\media\\textures\\blank.tga", 
				tile = false, tileSize = 0, edgeSize = 1, 
				insets = { left = -1, right = -1, top = -1, bottom = -1 }
			} )

			JSHB.F.StackBars[i].border:SetPoint("TOPLEFT", -1, 1)
			JSHB.F.StackBars[i].border:SetPoint("BOTTOMRIGHT", 1, -1)
			JSHB.F.StackBars[i].border:SetFrameLevel(JSHB.F.StackBars[i]:GetFrameLevel() - 1)
			JSHB.F.StackBars[i].border:SetBackdropColor(unpack(JSHB.db.profile.energybar.stackscolorretro_ba) )
			JSHB.F.StackBars[i].border:SetBackdropBorderColor(unpack(JSHB.db.profile.energybar.stackscolorretro_bo) )
			JSHB.F.StackBars[i].border:Show()

			JSHB.F.StackBars[i].backdrop = JSHB.F.StackBars[i].backdrop or JSHB.F.StackBars[i]:CreateTexture(nil, "BACKGROUND", JSHB.F.StackBars[i])
			JSHB.F.StackBars[i].backdrop:SetParent(JSHB.F.StackBars[i])
			JSHB.F.StackBars[i].backdrop:ClearAllPoints()
			JSHB.F.StackBars[i].backdrop:SetPoint("TOPLEFT", 1, -1)
			JSHB.F.StackBars[i].backdrop:SetPoint("BOTTOMRIGHT", -1, 1)
			JSHB.F.StackBars[i].backdrop:SetTexture(0, .6, 0, 1) -- Green
			JSHB.F.StackBars[i].backdrop:Show()
		end
		
		JSHB.F.StackBars[i].barIndex = i
		JSHB.F.StackBars[i].totalBars = numBars
		JSHB.F.StackBars[i].checkFunction = checkFunction
		JSHB.F.StackBars[i].updateTimer = 0
		JSHB.F.StackBars[i].updateFlash = 0

		JSHB.F.StackBars[i]:SetScript("OnUpdate", function(self, elapsed)
			self.updateTimer = self.updateTimer + elapsed
			if self.updateTimer < STACKBARS_UPDATEINTERVAL then return else self.updateTimer = 0 end
			
			if self.checkFunction(self) then
				self.updateFlash = (self.updateFlash >= .5) and 0 or self.updateFlash + .11 + elapsed
				if (not JSHB.db.profile.energybar.stacksretro) then
					self.stack:SetVertexColor(0, .3 + self.updateFlash, 0, 1)
				else
					self.backdrop:SetTexture(0, .3 + self.updateFlash, 0, 1)
				end
			else
				self.updateFlash = 0
				if (not JSHB.db.profile.energybar.stacksretro) then
					self.stack:SetVertexColor(unpack(JSHB.db.profile.energybar.stackscolor) )
				end
			end
		end)

		JSHB.F.StackBars[i]:SetAlpha(0)
		JSHB.F.StackBars[i]:Show()		
	end
end
