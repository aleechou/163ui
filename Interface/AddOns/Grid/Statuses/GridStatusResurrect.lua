
local _, Grid = ...
local L = Grid.L

local GridFrame = Grid:GetModule("GridFrame")

local GridStatusResurrect = Grid:NewStatusModule("GridStatusResurrect")
local RESURRECTING = "正在复活"
GridStatusResurrect.menuName = RESURRECTING
GridStatusResurrect.options = false

GridStatusResurrect.defaultDB = {
	debug = false,
	alert_res163 = {
		text = RESURRECTING,
		enable = true,
		color = { r = 0.5, g = 0.5, b = 1, a = 1.0 },
		priority = 99,
		range = false,
	},
}

function GridStatusResurrect:PostInitialize()
	self:RegisterStatus("alert_res163", RESURRECTING, nil, true)
end

function GridStatusResurrect:OnStatusEnable(status)
	if status == "alert_res163" then
		self:RegisterEvent("INCOMING_RESURRECT_CHANGED")
	end
end

function GridStatusResurrect:OnStatusDisable(status)
	if status == "alert_res163" then
		self:UnregisterEvent("INCOMING_RESURRECT_CHANGED")
		self.core:SendStatusLostAllUnits("alert_res163")
	end
end

function GridStatusResurrect:INCOMING_RESURRECT_CHANGED(event, unitid)
	local settings = self.db.profile.alert_res163

    GridFrame:WithAllFrames(function (f)
        if f.unit and f:IsVisible() then
            if UnitHasIncomingResurrection(f.unit) then
                self.core:SendStatusGained(
                    f.unitGUID,
                    "alert_res163",
                    settings.priority,
                    (settings.range and 40),
                    settings.color,
                    "活",
                    nil,
                    nil,
                    "Interface\\RaidFrame\\Raid-Icon-Rez")
            else
                self.core:SendStatusLost(f.unitGUID, "alert_res163")
            end
        end
    end)
end