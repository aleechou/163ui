local AddonName, Addon = ...
local EncounterBarController = Dominos:NewModule('EncounterBar')

function EncounterBarController:OnInitialize()
	_G['PlayerPowerBarAlt'].ignoreFramePositionManager = true
	self:Load()
end

function EncounterBarController:Load()
	self.frame = Addon.EncounterBar:New()
end

function EncounterBarController:Unload()
	self.frame:Free()
end