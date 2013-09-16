-- $Id: Options.lua 4017 2012-11-28 22:25:55Z lag123 $
local AtlasLoot = _G.AtlasLoot
--Invoke libraries
local AL = LibStub("AceLocale-3.0"):GetLocale("AtlasLoot");

local GREY = "|cff999999";
local RED = "|cffff0000";
local WHITE = "|cffFFFFFF";
local GREEN = "|cff1eff00";
local PURPLE = "|cff9F3FFF";
local BLUE = "|cff0070dd";
local ORANGE = "|cffFF8400";

local options, moduleOptions = nil, {}
local getOptions

do
 	local function loadAddon(info)
		AtlasLoot:LoadModule("AtlasLoot")
	end

	function getOptions()
		if not options then
			options = {
				type = "group",
				args = {
					general = {
						type = "group",
						inline = true,
						name = "",
						args = {
							all = {						
								type = "group",
								inline = true,
								name = "",
								order = 10,
								args = {
									quicklooks = {
										type = "execute",
										name = AL["Load AtlasLoot"],
										--desc = ,
										func = loadAddon,
										order = 3,
									},
								},
							},
						},
					},	
				},
			}
		end
		return options

	end

end

--[[
AtlasLoot:OptionsInitialize()
]]
function AtlasLoot:OptionsInitialize()
	if self.optFrames then return end
	self.optFrames = {}
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable("AtlasLoot", getOptions)

	self.optFrames.AtlasLoot = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("AtlasLoot", "AtlasLoot", nil, "general")
end

function AtlasLoot:OpenModuleOptions(module)
	LibStub("AceConfigDialog-3.0"):Open("AtlasLoot", nil, module)
end

function AtlasLoot:RefreshModuleOptions()
	LibStub("AceConfigRegistry-3.0"):NotifyChange("AtlasLoot")
end

do
	local Authors = {}
	local Friends = {}
	
	for k,v in pairs(AtlasLoot.AddonInfo.authors) do
		if v.ingame then
			for _,name in ipairs(v.ingame) do
				local a,b = string.split("@", name)
				if a and b then
					Authors[a] = b
				end
			end
			v.ingame = nil
		end
		if v.friends then
			for _,name in ipairs(v.friends) do
				local a,b = string.split("@", name)
				if a and b then
					Friends[a] = b
				end
			end
			v.friends = nil
		end
	end

	function hookUnitTarget(self)
		local name, unit = self:GetUnit()
		if name and unit then
			local _, realm = UnitName(unit)
			if not realm then 
				realm = GetRealmName()
			end

			if name and ( Authors[name] or Friends[name] ) then
				if Authors[name] == realm then
					if AtlasLoot.imagePath then
						self:AddLine("AtlasLoot Author |T"..AtlasLoot.imagePath.."gold:0|t", 0, 1, 0 )
					else
						self:AddLine("AtlasLoot Author", 0, 1, 0 )
					end
				elseif Friends[name] == realm then
					if AtlasLoot.imagePath then
						self:AddLine("AtlasLoot Friend |T"..AtlasLoot.imagePath.."silver:0|t", 0, 1, 0 )
					else
						self:AddLine("AtlasLoot Friend", 0, 1, 0 )
					end
				end
			end
		end
	end
	GameTooltip:HookScript("OnTooltipSetUnit", hookUnitTarget)
end
