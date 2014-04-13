--------------------------------------------------------------
-- LibScanTip
--
-- A library for obtaining information those can only be obtained from
-- tooltip text scanning.
--
-- API:
--
-- LibScanTip:CallMethod("method", ...) -- Same as calling the tooltip method
-- LibScanTip:NumLines() -- Get total lines of the tooltip
-- LibScanTip:GetText(line, right) -- Retrieve a line of text
-- LibScanTip:FindText(text, wholematch, startline, endline, right) -- Text search

-- Abin
-- 2012-2-04
--------------------------------------------------------------

local VERSION = 1.0

local type = type
local strfind = strfind
local _G = _G

local TIPNAME = "LibScanTip_TooltipFrame"
local TIPOWNER = WorldFrame

local tooltip = _G[TIPNAME]
if type(tip) == "table" then
	local version = tip._libversion
	if type(version) == "number" and version >= VERSION then
		return
	end
else
	tip = CreateFrame("GameTooltip", TIPNAME, TIPOWNER, "GameTooltipTemplate")
end

tip._libversion = VERSION
tip:SetScript("OnShow", function(self) self._tipshown = 1 end)
tip:SetScript("OnHide", function(self) self._tipshown = nil end)
tip:Hide()
tip:SetAlpha(0)

local lib = _G.LibScanTip
if type(lib) ~= "table" then
	lib = {}
	_G.LibScanTip = lib
end

function lib:CallMethod(method, ...)
	local func = tip[method]
	if type(func) ~= "function" then
		return
	end

	if not tip._tipshown then
		tip:SetOwner(TIPOWNER, "ANCHOR_NONE")
	end

	tip:ClearLines()
	return 1, func(tip, ...)
end

function lib:NumLines()
	return tip:NumLines()
end

local PREFIX_LEFT = TIPNAME.."TextLeft"
local PREFIX_RIGHT = TIPNAME.."TextRight"

function lib:GetText(line, right)
	local text = _G[(right and PREFIX_RIGHT or PREFIX_LEFT)..line]
	return text and text:GetText()
end

function lib:FindText(text, wholematch, startline, endline, right)
	if type(text) ~= "string" or text == "" then
		return
	end

	if type(startline) ~= "number" or startline < 1 then
		startline = 1
	end

	local maxline = tip:NumLines()
	if type(endline) ~= "number" or endline > maxline then
		endline = maxline
	end

	local i
	for i = startline, endline do
		local line = self:GetText(i, right)
		if line then
			if wholematch then
				if line == text then
					return line, i
				end
			else
				local _, _, content = strfind(line, text)
				if content then
					return content, i
				end
			end
		end
	end
end