-------------------------------------------------------------------------------
-- Localized Lua globals. 
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local tonumber = _G.tonumber
local type = _G.type

-- Libraries
local math = _G.math


-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...
local L = private.L


-------------------------------------------------------------------------------
-- Frames.
-------------------------------------------------------------------------------
local target_button = _G.CreateFrame("Button", "_NPCScanButton", _G.UIParent, "SecureActionButtonTemplate,SecureHandlerShowHideTemplate")
target_button:Hide()
target_button:SetPoint("BOTTOM", _G.UIParent, 0, 128)
target_button:SetSize(150, 42)
target_button:SetScale(1.25)
target_button:SetMovable(true)
target_button:SetUserPlaced(true)
target_button:SetClampedToScreen(true)
target_button:SetFrameStrata("FULLSCREEN_DIALOG")
target_button:SetNormalTexture([[Interface\AchievementFrame\UI-Achievement-Parchment-Horizontal]])

target_button:SetAttribute("type", "macro")
target_button:SetAttribute("_onshow", "self:Enable()")
target_button:SetAttribute("_onhide", "self:Disable()")

target_button:SetBackdrop({
	tile = true,
	edgeSize = 16,
	edgeFile = [[Interface\Tooltips\UI-Tooltip-Border]]
})

target_button:SetBackdropBorderColor(0.7, 0.15, 0.05) -- Brown

target_button:HookScript("OnShow", function(self)
	self:RegisterEvent("MODIFIER_STATE_CHANGED")
	self:RegisterEvent("PLAYER_TARGET_CHANGED")
	self:EnableDrag(_G.IsModifiedClick("_NPCSCAN_BUTTONDRAG"))
end)

target_button:HookScript("OnHide", function(self)
	self:UnregisterEvent("MODIFIER_STATE_CHANGED")
	self:UnregisterEvent("PLAYER_TARGET_CHANGED")
	self:UnregisterEvent("UNIT_MODEL_CHANGED")
	self:EnableDrag(false)

	if self.SoundEnableAllChanged then
		self.SoundEnableAllChanged = nil
		_G.SetCVar("Sound_EnableAllSound", 0)
	end

	if self.SoundEnableSFXChanged then
		self.SoundEnableSFXChanged = nil
		_G.SetCVar("Sound_EnableSFX", 0)
	end

	if self.SoundInBGChanged then
		self.SoundInBGChanged = nil
		_G.SetCVar("Sound_EnableSoundWhenGameIsInBG", 0)
	end

	if type(self.ID) == "number" then
		private.Overlays.Remove(self.ID)
	end
end)

target_button:SetScript("OnEnter", function(self)
	self:SetBackdropBorderColor(1, 1, 0.15) -- Yellow
end)

target_button:SetScript("OnLeave", function(self)
	self:SetBackdropBorderColor(0.7, 0.15, 0.05) -- Brown
end)

target_button:SetScript("OnEvent", function(self, event_name, ...)
	if self[event_name] then
		return self[event_name](self, event_name, ...)
	end
end)

target_button:RegisterEvent("PLAYER_REGEN_ENABLED")

private.Button = target_button


local close_button = _G.CreateFrame("Button", nil, target_button, "UIPanelCloseButton")
close_button:SetPoint("TOPRIGHT")
close_button:SetSize(32, 32)
close_button:SetScale(0.8)
close_button:SetHitRectInsets(8, 8, 8, 8)


target_button.Drag = target_button:CreateTitleRegion()
target_button.Model = _G.CreateFrame("PlayerModel", nil, target_button)
target_button.Flash = _G.CreateFrame("Frame")
target_button.Flash.LoopCountMax = 3

target_button.RotationRate = math.pi / 4

target_button.ModelDefaultScale = 0.75
--- [ Model:lower() ] = "[Scale]|[X]|[Y]|[Z]", where any parameter can be left empty


do
	local MODELS = {
		ALLIANCE_LION = [[creature\alliancelionmount\alliancelion.m2]],
		ARMADILLO = [[creature\armadillo\armadillo.m2]],
		MAMMOTH = [[creature\mammoth\mammoth.m2]],
		NORTHREND_DRAGON = [[creature\dragon\northrenddragon.m2]],
		ULDUM_WATCHER_LEFT = [[creature\uldumwatcher\uldumwatcherleft.m2]],
		WHALESHARK = [[creature\whaleshark\whaleshark.m2]],
		WIGHT = [[creature\wight\wight.m2]],
		UNDEAD_SHIP = [[world\expansion02\doodads\ships\nd_ship_ud_bg.m2]],
	}


	target_button.ModelCameras = {
		[MODELS.ALLIANCE_LION] = ".7|.3|.5", -- Sambas
		[MODELS.ARMADILLO] = "2||-.3", -- Armagedillo
		[MODELS.NORTHREND_DRAGON] = ".5||3|20", -- Hemathion, Vyragosa
		[MODELS.MAMMOTH] = ".3|.5|2.1", -- Tukemuth
		[MODELS.ULDUM_WATCHER_LEFT] = "|||16", -- Akma'hat
		[MODELS.WHALESHARK] = ".7|-.5", -- Mobus
		[MODELS.WIGHT] = ".7", -- Griegen
		[MODELS.UNDEAD_SHIP] = ".15|0|15", -- Dread Ship Vazuvius
	}
end -- do-block


-------------------------------------------------------------------------------
-- Target button methods.
-------------------------------------------------------------------------------
-- Plays an alert sound, temporarily enabling sound if necessary.
-- @param AlertSound A LibSharedMedia sound key, or nil to play the default.
do
	local sound_is_playing = false

	function target_button.PlaySound(sound_name)
		if sound_is_playing then
			return
		end

		if private.OptionsCharacter.AlertSoundUnmute then
			if not target_button.SoundEnableAllChanged and not _G.GetCVarBool("Sound_EnableAllSound") then
				target_button.SoundEnableAllChanged = true
				_G.SetCVar("Sound_EnableAllSound", 1) -- Restored when alert is closed
			end

			if not target_button.SoundEnableSFXChanged and not _G.GetCVarBool("Sound_EnableSFX") then
				target_button.SoundEnableSFXChanged = true
				_G.SetCVar("Sound_EnableSFX", 1)
			end

			if not target_button.SoundInBGChanged and not _G.GetCVarBool("Sound_EnableSoundWhenGameIsInBG") then
				target_button.SoundInBGChanged = true
				_G.SetCVar("Sound_EnableSoundWhenGameIsInBG", 1)
			end
		end

		if not sound_name then
			_G.PlaySoundFile([[Sound\Events\gruntling_horn_bb.wav]], "Master")
		elseif sound_name == L.CONFIG_ALERT_SOUND_CLASSIC then
			_G.PlaySoundFile([[Sound\Event Sounds\Event_wardrum_ogre.wav]], "Master")
			_G.PlaySoundFile([[Sound\Events\scourge_horn.wav]], "Master")
		else
			local LSM = _G.LibStub("LibSharedMedia-3.0")
			_G.PlaySoundFile(LSM:Fetch(LSM.MediaType.SOUND, sound_name), "Master")
		end
		sound_is_playing = true
	end


	local ALERT_SOUND_DELAY = 8

	local timer = 0
	local alert_updater = _G.CreateFrame("Frame")
	alert_updater:Show()

	alert_updater:SetScript("OnUpdate", function(self, elapsed)
		timer = timer + elapsed

		if timer >= ALERT_SOUND_DELAY then
			timer = 0
			sound_is_playing = false
		end
	end)
end -- do-block


-- Plays alerts and sets the targeting button if not in combat.
-- If in combat, queues the button to appear when combat ends.
-- @see NS:Update
function target_button:SetNPC(ID, Name, Source)
	if tonumber(ID) then
		ID = tonumber(ID)
		private.Overlays.Add(ID)
		private.Overlays.Found(ID)
	end
	self.PlaySound(private.Options.AlertSound)

	if private.OptionsCharacter.AlertScreenEdgeFlash then
		self.Flash:Show()
		self.Flash.Fade:Pause() -- Forces OnPlay to fire again if it was already playing
		self.Flash.Fade:Play()
	end

	if _G.InCombatLockdown() then
		if type(self.PendingID) == "number" then -- Remove old pending NPC
			private.Overlays.Remove(self.PendingID)
		end
		self.PendingID, self.PendingName, self.PendingSource = ID, Name, Source
	else
		self:Update(ID, Name, Source)
	end
end

-- Updates the button out of combat to target a given unit.
-- @param ID A numeric NpcID or string UnitID.
-- @param Name Localized name of the unit.  If ID is an NpcID, Name is used in the targeting macro.
-- @param Source Name of the scan, custom or achievement, that set off this alert.
function target_button:Update(ID, Name, Source)
	if type(self.ID) == "number" then
		private.Overlays.Remove(self.ID)
	end
	self.ID = ID
	self:SetText(Name)

	if Source == Name then
		Source = nil
	end
	self.Source:SetText(Source)

	local Model = self.Model
	Model:Reset()

	if type(ID) == "number" then -- ID is NPC ID
		Model.UnitID = nil
		Model:SetCreature(ID)
		self:UnregisterEvent("UNIT_MODEL_CHANGED")
	else -- ID is UnitID
		Model.UnitID, Name = ID, ID
		Model:SetUnit(ID)
		self:RegisterEvent("UNIT_MODEL_CHANGED")
	end

	if Source == "Unknown Vignette" then
		Model:SetDisplayInfo(28089)
		self:SetAttribute("macrotext", private.macrotext)
	else
		self:SetAttribute("macrotext", "/cleartarget\n/targetexact " .. Name)
	end
	self:PLAYER_TARGET_CHANGED() -- Updates the target icon

	self:Show()
	self:StopAnimating()
	self.Glow:Play()
	self.Shine:Play()
end


-- Enables or disables dragging the button.
-- Not a secure function Can be run in combat.
function target_button:EnableDrag(Enable)
	local Drag = self.Drag
	Drag:ClearAllPoints()

	if Enable then
		Drag:SetAllPoints()
	else -- Position offscreen
		Drag:SetPoint("TOP", _G.UIParent, 0, math.huge)
	end
end


function target_button:PLAYER_REGEN_ENABLED()
	if self.PendingName and self.PendingID then
		self:Update(self.PendingID, self.PendingName, self.PendingSource)
		self.PendingID = nil
		self.PendingName = nil
		self.PendingSource = nil
	end
end


-- Enables or disables dragging when the drag modifier is held.
function target_button:MODIFIER_STATE_CHANGED()
	self:EnableDrag(_G.IsModifiedClick("_NPCSCAN_BUTTONDRAG"))
end


do
	-- @param ID A numeric NpcID or string UnitID.
	-- @return True if the given ID represents the current target.
	local function TargetIsFoundRare(ID) -- Returns true if the button targeted its rare
		if type(ID) == "number" then
			local GUID = _G.UnitGUID("target")
			if GUID and ID == tonumber(GUID:sub(6, 10), 16) then
				return true
			end
		else -- UnitID
			return _G.UnitIsUnit(ID, "target")
		end
	end

	-- Raid marks the rare when it's targeted.
	function target_button:PLAYER_TARGET_CHANGED()
		local ID = self.ID
		if TargetIsFoundRare(ID) then
			if _G.GetRaidTargetIndex("target") ~= private.OptionsCharacter.TargetIcon and (not _G.IsInRaid() or (_G.UnitIsGroupAssistant("player") or _G.UnitIsGroupLeader("player"))) then
				_G.SetRaidTarget("target", private.OptionsCharacter.TargetIcon)
			end

			if type(ID) == "number" then -- Update model with more accurate visual
				self.Model.UnitID = "target"
				self:RegisterEvent("UNIT_MODEL_CHANGED")
				self:UNIT_MODEL_CHANGED(nil, "target")
			end
		elseif self.Model.UnitID and type(ID) == "number" then -- Quit updating model for creature ID
			self.Model.UnitID = nil
			self:UnregisterEvent("UNIT_MODEL_CHANGED")
		end
	end
end


-- Updates the 3D preview display if the targeted rare changes appearance.
function target_button:UNIT_MODEL_CHANGED(_, UnitID)
	if _G.UnitIsUnit(UnitID, self.Model.UnitID) then
		self.Model:Reset(true) -- Don't reset rotation
		self.Model:SetUnit(UnitID)
	end
end


-- Stops the animation after a number of loops.
function target_button.Flash:OnLoop(Direction)
	if Direction == "FORWARD" then
		self.LoopCount = self.LoopCount + 1
		local Flash = self:GetParent()
		if self.LoopCount >= Flash.LoopCountMax then
			self:Stop()
			Flash:Hide()
		end
	end
end


-- Resets the loop count when resumed/restarted.
function target_button.Flash:OnPlay()
	self.LoopCount = 0
end


do
	-- Adjusts the model camera to compensate for bad default camera angles.
	local function AdjustModel(self)
		local Path = self:GetModel()

		if type(Path) == "string" then
			local ID = self:GetParent().ID
			if type(ID) == "number" or not _G.UnitIsPlayer(ID) then -- Creature
				local Scale, X, Y, Z = ("|"):split(target_button.ModelCameras[Path:lower()] or "")
				self:SetModelScale(target_button.ModelDefaultScale * (tonumber(Scale) or 1))
				self:SetPosition(tonumber(Z) or 0, tonumber(X) or 0, tonumber(Y) or 0)
			else -- Player
				self:SetModelScale(target_button.ModelDefaultScale)
			end
		end
	end

	local frame_count = 0

	-- Fires when the 3D model mesh loads and is ready to display.
	local function OnUpdateModel(self)
		frame_count = frame_count - 1

		if frame_count <= 0 then
			-- Restore normal rotation
			self:SetScript("OnUpdateModel", nil)
			self:SetScript("OnUpdate", self.OnUpdate)
			AdjustModel(self)
			self:SetAlpha(1)
		end
	end

	--- Clears the model and readies it for a SetCreature/Unit call.
	function target_button.Model:Reset(KeepFacing)
		self:SetAlpha(0) -- Keep hidden until scaled properly
		self:SetScript("OnUpdateModel", nil)
		self:SetModelScale(1)
		self:SetPosition(0, 0, 0)

		if not KeepFacing then
			self:SetFacing(0)
		end
		self:ClearModel()

		-- Wait a while after model changes, or else the current model scale will display as 100% with later calls scaling relative to it.
		frame_count = 10 -- Voodoo!  Larger means less chance of scale bug.
		self:SetScript("OnUpdate", nil)
		self:SetScript("OnUpdateModel", OnUpdateModel)
	end
end


-- Slowly rotates the 3D model preview.
function target_button.Model:OnUpdate(elapsed)
	self:SetFacing(self:GetFacing() + elapsed * target_button.RotationRate)
end


local Background = target_button:GetNormalTexture()
Background:SetDrawLayer("BACKGROUND")
Background:ClearAllPoints()
Background:SetPoint("BOTTOMLEFT", 3, 3)
Background:SetPoint("TOPRIGHT", -3, -3)
Background:SetTexCoord(0, 1, 0, 0.25)


local TitleBackground = target_button:CreateTexture(nil, "BORDER")
TitleBackground:SetTexture([[Interface\AchievementFrame\UI-Achievement-Title]])
TitleBackground:SetPoint("TOPRIGHT", -5, -5)
TitleBackground:SetPoint("LEFT", 5, 0)
TitleBackground:SetHeight(18)
TitleBackground:SetTexCoord(0, 0.9765625, 0, 0.3125)
TitleBackground:SetAlpha(0.8)


local Title = target_button:CreateFontString(nil, "OVERLAY", "GameFontHighlightMedium", 1)
Title:SetPoint("TOPLEFT", TitleBackground, 0, 2)
Title:SetPoint("RIGHT", TitleBackground)
target_button:SetFontString(Title)


target_button.Source = target_button:CreateFontString(nil, "OVERLAY", "SystemFont_Tiny")
target_button.Source:SetPoint("BOTTOMLEFT", TitleBackground)
target_button.Source:SetPoint("RIGHT", -8, 0)
target_button.Source:SetTextHeight(6)


local source_color = _G.NORMAL_FONT_COLOR
target_button.Source:SetTextColor(source_color.r, source_color.g, source_color.b)


local target_button_subtitle = target_button:CreateFontString(nil, "OVERLAY", "GameFontBlackTiny")
target_button_subtitle:SetPoint("TOPLEFT", target_button.Source, "BOTTOMLEFT", 0, -4)
target_button_subtitle:SetPoint("RIGHT", target_button.Source)
target_button_subtitle:SetText(private.L.BUTTON_FOUND)


-- Model view
local Model = target_button.Model
Model:SetPoint("BOTTOMLEFT", target_button, "TOPLEFT", 0, -4)
Model:SetPoint("RIGHT")
Model:SetHeight(target_button:GetWidth() * 0.6)
target_button:SetClampRectInsets(0, 0, Model:GetHeight(), 0) -- Allow room for model


-- Glow animation
local Texture = Model:CreateTexture(nil, "OVERLAY")
Texture:SetPoint("CENTER", target_button)
Texture:SetSize(400 / 300 * target_button:GetWidth(), 171 / 70 * target_button:GetHeight())
Texture:SetTexture([[Interface\AchievementFrame\UI-Achievement-Alert-Glow]])
Texture:SetBlendMode("ADD")
Texture:SetTexCoord(0, 0.78125, 0, 0.66796875)
Texture:SetAlpha(0)
target_button.Glow = Texture:CreateAnimationGroup()


local FadeIn = target_button.Glow:CreateAnimation("Alpha")
FadeIn:SetChange(1.0)
FadeIn:SetDuration(0.2)


local FadeOut = target_button.Glow:CreateAnimation("Alpha")
FadeOut:SetOrder(2)
FadeOut:SetChange(-1.0)
FadeOut:SetDuration(0.5)


-- Shine animation (reflection swipe)
local Texture = target_button:CreateTexture(nil, "ARTWORK")
Texture:SetPoint("TOPLEFT", target_button, 0, 8)
Texture:SetSize(67 / 300 * target_button:GetWidth(), 1.28 * target_button:GetHeight())
Texture:SetTexture([[Interface\AchievementFrame\UI-Achievement-Alert-Glow]])
Texture:SetBlendMode("ADD")
Texture:SetTexCoord(0.78125, 0.912109375, 0, 0.28125)
Texture:SetAlpha(0)
target_button.Shine = Texture:CreateAnimationGroup()


local Show = target_button.Shine:CreateAnimation("Alpha")
Show:SetStartDelay(0.3)
Show:SetChange(1.0)
Show:SetDuration(1e-5) -- Note: 0 is invalid


local Slide = target_button.Shine:CreateAnimation("Translation")
Slide:SetOrder(2)
Slide:SetOffset(target_button:GetWidth() - Texture:GetWidth() + 8, 0)
Slide:SetDuration(0.4)


local FadeOut = target_button.Shine:CreateAnimation("Alpha")
FadeOut:SetOrder(2)
FadeOut:SetStartDelay(0.2)
FadeOut:SetChange(-1.0)
FadeOut:SetDuration(0.2)


-- Full screen flash
local Flash = target_button.Flash
Flash:Hide()
Flash:SetAllPoints()
Flash:SetAlpha(0)
Flash:SetFrameStrata("FULLSCREEN_DIALOG")


local Texture = Flash:CreateTexture()
Texture:SetBlendMode("ADD")
Texture:SetAllPoints()
Texture:SetTexture([[Interface\FullScreenTextures\LowHealth]])


Flash.Fade = Flash:CreateAnimationGroup()
Flash.Fade:SetLooping("BOUNCE")
Flash.Fade:SetScript("OnLoop", Flash.OnLoop)
Flash.Fade:SetScript("OnPlay", Flash.OnPlay)


local FadeIn = Flash.Fade:CreateAnimation("Alpha")
FadeIn:SetChange(1.0)
FadeIn:SetDuration(0.5)
FadeIn:SetEndDelay(0.25)
