-- Author      : s1172
-- Create Date : 2013/5/2 18:27:45

local api = CreateFrame("frame","ElfintipApi")

api.Localization={}
--- Returns localized string
-- @param str The string to localize.
-- @return The localized string.
function api:Localize(str)
	return self.Localization[str]
end