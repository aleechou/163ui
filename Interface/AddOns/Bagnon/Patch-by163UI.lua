local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')

local defaultSettings = {
	["inventory"] = {
		["point"] = "BOTTOMRIGHT",
		["itemFrameColumns"] = 10,
		["dataBrokerObject"] = "背包",
		["y"] = 38,
		["x"] = -160,
	},
	["guildbank"] = {
		["point"] = "TOPLEFT",
		["y"] = -170,
		["x"] = 25,
	},
	["voidstorage"] = {
		["point"] = "TOPLEFT",
		["y"] = -170,
		["x"] = 25,
	},
	["bank"] = {
		["point"] = "TOPLEFT",
		["y"] = -170,
		["x"] = 25,
		["itemFrameColumns"] = 18,
		
	},
}

local function importsetting (db,key,settings)
	if not db[key] then db[key] = settings return end
	for n,v in pairs(settings) do
		db[key][n] = v
	end
end



Bagnon.SavedFrameSettings.oriGetGlobalDB = Bagnon.SavedFrameSettings.GetGlobalDB
function Bagnon.SavedFrameSettings:GetGlobalDB()

	local db = self:oriGetGlobalDB()

	if (db["version-163ui"] or 0) < 2014091001 then
		if not db.frames then db.frames = {} end
		for key,settings in pairs(defaultSettings) do
			importsetting(db.frames,key,settings)
		end
	end

    db["version-163ui"] = tonumber(GetAddOnMetadata("Bagnon","X-163UI-Version")or"0")

	return db
end
