--[[
	Snippet for a basic slashcommand to show version
]]

local addonName, addon = ...

local name = addonName:gsub("%s*", "")

if not name:find("[^%w]") then -- This'll get complicated if addon name isn't plain alpha-numeric
	_G["SLASH_"..name:upper().."1"], _G["SLASH_"..name:upper().."2"] = "/"..name:lower(), "/"..name:lower().."version"

	SlashCmdList[name:upper()] = function(msg, editbox)
		print(addonName, "version:", GetAddOnMetadata(addonName, "Version"))
	end
end