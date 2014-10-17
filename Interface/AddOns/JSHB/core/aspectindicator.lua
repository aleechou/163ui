--
-- JSHB - Aspect/Stance indicator module
--

if not tContains({ "HUNTER", "WARRIOR", "ROGUE" }, select(2, UnitClass("player") ) ) then return end

-- Cache
local GetShapeshiftForm, GetSpecialization, UnitInVehicle = GetShapeshiftForm, GetSpecialization, UnitInVehicle

local _, poisonSpellID
local poisonTable = nil
local function RogueHasPoisonUp()
	if (not poisonTable) then
		if (not select(1, GetSpellInfo(3408) ) ) then return nil end
		poisonTable = {
			[select(1, GetSpellInfo(3408) )] = select(3, GetSpellInfo(3408) ), -- 3408: Crippling Poison
			[select(1, GetSpellInfo(8679) )] = select(3, GetSpellInfo(8679) ), -- 8679: Wound Poison
			[select(1, GetSpellInfo(5761) )] = select(3, GetSpellInfo(5761) ), -- 5761: Mind-numbing Poison
			[select(1, GetSpellInfo(2823) )] = select(3, GetSpellInfo(2823) ), -- 2823: Deadly Poison
			[select(1, GetSpellInfo(108215) )] = select(3, GetSpellInfo(108215) ), -- 108215: Paralytic Poison
			[select(1, GetSpellInfo(108211) )] = select(3, GetSpellInfo(108211) ), -- 108211: Leeching Poison
		}
	end
	
	for k,v in pairs(poisonTable) do
		if (select(1, UnitBuff("player", k) ) ) then return(v) end
	end
	
	return nil -- No poison up
end

local PC = nil -- Player's Class
function JSHB.SetupAspectIndicatorModule()

	-- Deconstruction
	if JSHB.F.AspectIndicator then
		JSHB.DeregisterMovableFrame("MOVER_INDICATORS_ASPECT")
		JSHB.F.AspectIndicator:Hide()
		JSHB.F.AspectIndicator:SetScript("OnUpdate", nil)
		JSHB.F.AspectIndicator:UnregisterAllEvents()
		JSHB.F.AspectIndicator:SetParent(nil)
		--JSHB.F.AspectIndicator = nil
	end

	-- Construction
	PC = select(2, UnitClass("player") )
	if (PC == "HUNTER") and (UnitLevel("player") < 12) then return end -- Level 12 is when a lowbie first gets aspect
	local INDICATORS_UPDATEINTERVAL = 0.125
	
	if JSHB.db.profile.indicators.aspect_enable then
	
		-- Create the Frame
		JSHB.F.AspectIndicator = JSHB.MakeFrame(JSHB.F.AspectIndicator, "Frame", "JSHB_INDICATORS_ASPECT", JSHB.db.profile.indicators.anchor_aspect[2] or UIParent)
		JSHB.F.AspectIndicator:SetParent(JSHB.db.profile.indicators.anchor_aspect[2] or UIParent)
		JSHB.F.AspectIndicator:ClearAllPoints()
		JSHB.F.AspectIndicator:SetSize(JSHB.db.profile.indicators.aspect_iconsize, JSHB.db.profile.indicators.aspect_iconsize)
		JSHB.F.AspectIndicator:SetPoint(JSHB.GetActiveAnchor(JSHB.db.profile.indicators.anchor_aspect) )

		JSHB.F.AspectIndicator.Icon = JSHB.F.AspectIndicator.Icon or JSHB.F.AspectIndicator:CreateTexture(nil, "BACKGROUND")
		--JSHB.F.AspectIndicator.Icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
		if JSHB.db.profile.indicators.aspect_enabletexcoords then
			JSHB.F.AspectIndicator.Icon:SetTexCoord(unpack(JSHB.db.profile.indicators.aspect_texcoords) )
		else
			JSHB.F.AspectIndicator.Icon:SetTexCoord(0, 1, 0, 1)
		end
		JSHB.F.AspectIndicator.Icon:ClearAllPoints()
		JSHB.F.AspectIndicator.Icon:SetAllPoints(JSHB.F.AspectIndicator)
	
		JSHB.F.AspectIndicator.shine = JSHB.F.AspectIndicator.shine or CreateFrame("Frame", "AutocastShine_ASPECT", UIParent, "AutoCastShineTemplate")
		JSHB.F.AspectIndicator.shine:ClearAllPoints()
		JSHB.F.AspectIndicator.shine:SetSize(JSHB.db.profile.indicators.aspect_iconsize+2, JSHB.db.profile.indicators.aspect_iconsize+2)
		JSHB.F.AspectIndicator.shine:SetPoint("CENTER", JSHB.F.AspectIndicator, "CENTER", 1, -1)
		JSHB.F.AspectIndicator.shine:SetAlpha(1)
		JSHB.F.AspectIndicator.shine:Show()

		-- Create the Background and border if the user wants one
		JSHB.F.AspectIndicator.background = JSHB.MakeBackground(JSHB.F.AspectIndicator, JSHB.db.profile.indicators, "aspect_", nil, JSHB.F.AspectIndicator.background)
		JSHB.F.AspectIndicator:SetAlpha(1)
		JSHB.F.AspectIndicator:Show()
		
		JSHB.F.AspectIndicator.isRogue = (PC == "ROGUE") and true or nil
		
		JSHB.RegisterMovableFrame(
			"MOVER_INDICATORS_ASPECT",
			JSHB.F.AspectIndicator,
			JSHB.F.AspectIndicator,
			(PC == "HUNTER") and JSHB.L["Aspect Indicator"] or (PC == "WARRIOR") and JSHB.L["Stance Indicator"] or JSHB.L["Poison Indicator"],
			JSHB.db.profile.indicators,
			JSHB.SetupIndicatorsModule,
			JSHB.defaults.profile.indicators,
			JSHB.db.profile.indicators,
			"_aspect",
			"aspect_"
		)

		local function DoAspectUpdate(self)
			-- We do things differently is this is a Rogue, this module shows current or missing Poison.
			if (self.isRogue) then
				self.poisonTex = RogueHasPoisonUp()
			end
			if (self.isRogue and self.poisonTex) then
				if (self.Icon:GetTexture() ~= self.poisonTex) then
					self._tex = self.poisonTex
					self.Icon:SetTexture(self._tex)
				end
			-- Set the proper texture for the current (or missing) aspect
			elseif (not self.isRogue) and (GetShapeshiftForm() > 0) then -- There is an aspect up
				self._, self._name = GetShapeshiftFormInfo(GetShapeshiftForm() )
				self._, self._, self._tex = GetSpellInfo(self._name)
				if (self.Icon:GetTexture() ~= self._tex) then
					self.Icon:SetTexture(self._tex)
				end
			elseif (self.Icon:GetTexture() ~= "Interface\\Buttons\\UI-GroupLoot-Pass-Up") then
				--self.Icon:SetTexture("Interface\\Buttons\\UI-GroupLoot-Pass-Up")
			end
			
			if InCombatLockdown() then
				if ( (PC == "HUNTER") and (GetShapeshiftForm() ~= 1) ) -- missing or cheetah/pack
					or ( (PC == "WARRIOR") and (GetSpecialization() == 3) and (GetShapeshiftForm() ~= 2) )
					or ( (PC == "WARRIOR") and (GetSpecialization() ~= 3) and (GetShapeshiftForm() == 2) )
					or (self.isRogue and (not self.poisonTex) ) -- Check for Rogue Poisons!
					and (not UnitInVehicle("player") ) and (not C_PetBattles.IsInBattle() ) then
				
					JSHB.F.AspectIndicator:SetAlpha( (JSHB.db.profile.indicators.aspect_matchbaralpha and JSHB.db.profile.energybar.enabled) and JSHB.F.EnergyBar:GetAlpha() or 1)
					AutoCastShine_AutoCastStart(JSHB.F.AspectIndicator.shine, 1, .5, .5)
					
				elseif (not JSHB.db.profile.indicators.aspect_onlymissing) and (not UnitInVehicle("player") ) and (not C_PetBattles.IsInBattle() ) then -- good aspect, only missing not set
				
					JSHB.F.AspectIndicator:SetAlpha( (JSHB.db.profile.indicators.aspect_matchbaralpha and JSHB.db.profile.energybar.enabled) and JSHB.F.EnergyBar:GetAlpha() or 1)
					AutoCastShine_AutoCastStop(JSHB.F.AspectIndicator.shine)
					
				else
					JSHB.F.AspectIndicator:SetAlpha(0)
					AutoCastShine_AutoCastStop(JSHB.F.AspectIndicator.shine)
				end
			else -- Not in combat!
				if ( (PC == "HUNTER") and (GetShapeshiftForm() ~= 1) ) -- missing or cheetah/pack
					or ( (PC == "WARRIOR") and (GetSpecialization() == 3) and (GetShapeshiftForm() ~= 2) )
					or ( (PC == "WARRIOR") and (GetSpecialization() ~= 3) and (GetShapeshiftForm() == 2) )
					or (self.isRogue and (not self.poisonTex) ) -- Check for Rogue Poisons!
					and (not JSHB.db.profile.indicators.aspect_onlycombat) and (not UnitInVehicle("player") ) and (not C_PetBattles.IsInBattle() ) then
				
					JSHB.F.AspectIndicator:SetAlpha( (JSHB.db.profile.indicators.aspect_matchbaralpha and JSHB.db.profile.energybar.enabled) and JSHB.F.EnergyBar:GetAlpha() or 1)
					AutoCastShine_AutoCastStop(JSHB.F.AspectIndicator.shine)
					
				elseif (not JSHB.db.profile.indicators.aspect_onlymissing) and (not JSHB.db.profile.indicators.aspect_onlycombat) and (not UnitInVehicle("player") )
					and (not C_PetBattles.IsInBattle() ) then -- good aspect, only missing not set
				
					JSHB.F.AspectIndicator:SetAlpha( (JSHB.db.profile.indicators.aspect_matchbaralpha and JSHB.db.profile.energybar.enabled) and JSHB.F.EnergyBar:GetAlpha() or 1)
					AutoCastShine_AutoCastStop(JSHB.F.AspectIndicator.shine)
					
				else
					JSHB.F.AspectIndicator:SetAlpha(0)
					AutoCastShine_AutoCastStop(JSHB.F.AspectIndicator.shine)
				end			
			end
		end
		
		JSHB.F.AspectIndicator.updateTimer = 0
		JSHB.F.AspectIndicator:SetScript("OnUpdate", function(self, elapsed, ...)	
			self.updateTimer = self.updateTimer + elapsed		
			if self.updateTimer < INDICATORS_UPDATEINTERVAL then return else self.updateTimer = 0 end
			if (not JSHB.moversLocked) then return end			
			DoAspectUpdate(self)
		end)
	end
	
end
	