-- Author      : s1172
-- Create Date : 2013/2/28 13:17:37

local TrialTipApi=CreateFrame("frame","TrialTipApi",UIParent)

TrialTipApi.Localization={}

--- Returns localized string
-- @param str The string to localize.
-- @return The localized string.
function TrialTipApi:Localize(str)
	return self.Localization[str]
end

