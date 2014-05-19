-----------------------------------------------------------
-- LibMsgBox-1.0.lua
-----------------------------------------------------------
-- An API wraping for Blizzard StaticPopup_... functions.
--
-- Abin (2013-5-29)

-----------------------------------------------------------
-- API Documentation:
-----------------------------------------------------------

-- LibMsgBox:Confirm("text", buttons, OnOK, arg1 [, OnCancel [, timeout ]]) -- Displays a confirmation dialog
-- LibMsgBox:Input("text", OnOK, arg1 [, numeric [, default ]]) -- Displays an input dialog
-- LibMsgBox:Clear() -- Hide the dialog

-----------------------------------------------------------
-- About "buttons"
-----------------------------------------------------------

-- Type "table": User defined string table contains at least one string value, for example { "Hello", "Bye" }
-- Type "string": Key of a predefined string table (localized strings), valid keys are listed below:
-- If not specified, "MB_OKCANCEL" will be used as default.

-- "MB_OK":		{ OKAY }
-- "MB_OKCANCEL":	{ OKAY, CANCEL }
-- "MB_YESNO":		{ YES, NO }
-- "MB_ACCEPTDECLINE":	{ ACCEPT, DECLINE }

-----------------------------------------------------------
-- Prototype of "OnOK"
-----------------------------------------------------------

-- LibMsgBox:Confirm
-- OnOK(arg1)

-- LibMsgBox:Input
-- OnOK(value) or OnOK(arg1, value) -- value is either "string" or "number" type, depends on "numeric"

-- The dialog disappears if OnOK returns nil or false

-----------------------------------------------------------
-- Prototype of "OnCancel"
-----------------------------------------------------------

-- OnCancel(arg1), return values ignore

-----------------------------------------------------------

local error = error
local format = format
local type = type
local strtrim = strtrim
local tonumber = tonumber
local tostring = tostring
local StaticPopup_Show = StaticPopup_Show
local StaticPopup_Hide = StaticPopup_Hide

local VERSION = 1.02

local lib = _G["LibMsgBox"]
if lib and lib.version >= VERSION then return end

if not lib then
	lib = { version = VERSION }
	_G["LibMsgBox"] = lib
end

local IDENTITY = "{B20731E1-EB20-4580-9302-89340B8EDA33}"

local popData = StaticPopupDialogs[IDENTITY]
if not popData then
	popData = { exclusive = 1, whileDead = 1, hideOnEscape = 1, }
	StaticPopupDialogs[IDENTITY] = popData
end

local userData = _G[IDENTITY]
if not userData then
	userData = {}
	_G[IDENTITY] = userData
end

local MB_FLAGS = {
	MB_OK = { OKAY },
	MB_OKCANCEL = { OKAY, CANCEL },
	MB_YESNO = { YES, NO },
	MB_ACCEPTDECLINE = { ACCEPT, DECLINE },
}

local function ParseButtons(buttons)
	local list = MB_FLAGS[buttons] or buttons
	if type(list) ~= "table" then
		list = MB_FLAGS.MB_OKCANCEL
	end

	popData.button1 = list[1]
	popData.button2 = list[2]
end

function lib:Confirm(text, buttons, OnOK, arg1, OnCancel, timeout)
	if type(text) ~= "string" then
		error(format("Invalid parameter #1 in LibMsgBox:Confirm, string expected, got %s.", type(text)))
		return
	end

	self:Clear()
	ParseButtons(buttons)
	popData.hasEditBox = nil
	popData.text = text
	popData.timeout = timeout and tonumber(timeout) or 0
	popData.userFunc1, popData.userFunc2 = OnOK, OnCancel

	local dialog = StaticPopup_Show(IDENTITY)
	if dialog then
		dialog.data = arg1
		return dialog
	end
end

function lib:Input(text, OnOK, arg1, numeric, default)
	if type(text) ~= "string" then
		error(format("Invalid parameter #1 in LibMsgBox:Input, string expected, got %s.", type(text)))
		return
	end

	self:Clear()
	ParseButtons("MB_OKCANCEL")
	popData.hasEditBox = 1
	popData.text = text
	popData.userFunc1, popData.userFunc2 = OnOK

	local dialog = StaticPopup_Show(IDENTITY)
	if dialog then
		dialog.data, dialog.data2 = arg1, numeric
		if default then
			dialog.editBox:SetText(tostring(default))
			dialog.editBox:SetFocus()
			dialog.editBox:HighlightText()
		end
		return dialog
	end
end

function lib:Clear()
	StaticPopup_Hide(IDENTITY)
end

function popData.OnAccept(dialog, arg1, numeric)
	if type(popData.userFunc1) ~= "function" then
		return
	end

	local invalid
	if popData.hasEditBox then
		local value = strtrim(dialog.editBox:GetText())
		if value == "" then
			value = nil
		end

		if value and numeric then
			value = tonumber(value)
		end

		if value then
			if arg1 then
				invalid = popData.userFunc1(arg1, value)
			else
				invalid = popData.userFunc1(value)
			end
		else
			invalid = 1
		end
	else
		invalid = popData.userFunc1(arg1)
	end

	if invalid then
		dialog.editBox:SetFocus()
		dialog.editBox:HighlightText()
		return 1
	end
end

function popData.OnCancel(dialog, arg1)
	if type(popData.userFunc2) == "function" then
		popData.userFunc2(arg1)
	end
end

function popData.EditBoxOnEnterPressed(self)
	local dialog = self:GetParent()
	if not popData.OnAccept(dialog, dialog.data, dialog.data2) then
		dialog:Hide()
	end
end

function popData.EditBoxOnEscapePressed(self)
	local dialog = self:GetParent()
	popData.OnCancel(dialog, dialog.data)
	dialog:Hide()
end