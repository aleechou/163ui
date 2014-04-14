﻿-- --------------------
-- TellMeWhen
-- Originally by Nephthys of Hyjal <lieandswell@yahoo.com>

-- Other contributions by:
--		Sweetmms of Blackrock, Oozebull of Twisting Nether, Oodyboo of Mug'thol,
--		Banjankri of Blackrock, Predeter of Proudmoore, Xenyr of Aszune

-- Currently maintained by
-- Cybeloras of Aerie Peak/Detheroc/Mal'Ganis
-- --------------------


if not TMW then return end

local TMW = TMW
local L = TMW.L
local print = TMW.print

local floor, min, max, strsub, strfind = 
	  floor, min, max, strsub, strfind
local pairs, ipairs, sort, tremove, CopyTable = 
	  pairs, ipairs, sort, tremove, CopyTable
	  
local CI = TMW.CI

-- GLOBALS: CreateFrame, NONE, NORMAL_FONT_COLOR



local EVENTS = TMW.EVENTS
local Lua = EVENTS:GetEventHandler("Lua")
Lua.handlerName = L["EVENTHANDLER_LUA_TAB"]


TMW:RegisterCallback("TMW_OPTIONS_LOADED", function()
	Lua.ConfigContainer.Error:SetWidth(Lua.ConfigContainer:GetWidth() - 20)
end)

-- Overrides TestEvent inherited from TMW.Classes.EventHandler
function Lua:TestEvent(eventID)
	local eventSettings = EVENTS:GetEventSettings(eventID)

	local code = eventSettings.Lua
	
	local func = self:GetCompiledFunction(code)
	
	if func then
		local success, err = pcall(func, TMW.CI.ic)
		
		if not success then
			Lua:SetError(code, "RUNTIME", err)
		end
	end
end

---------- Events ----------
function Lua:LoadSettingsForEventID(id)
	Lua:LoadCode(EVENTS:GetEventSettings(id).Lua)
end

function Lua:LoadCode(code)
	self.ConfigContainer.Code:SetText(code)
	
	local func, err = self:GetCompiledFunction(code)
	
	self:SetError(code, "COMPILE", err)
end

function Lua:SetError(code, kind, err)
	local Error = self.ConfigContainer.Error
	
	if not err or err == "" then
		--Error:Hide()
		Error:SetText("")
		return
	end
	
	err = err:gsub("%[string .*%]", "line")
	local line = tonumber(err:match("line:(%d+):"))
	
	code = code:gsub("\r\n", "\n"):gsub("\r", "\n")
	local lineText = select(line, strsplit("\n", code)) or ""
	
	lineText = lineText:trim(" \t\r\n")
	if #lineText > 25 then
		lineText = lineText:sub(1, 25) .. "..."
	end
	
	err = "|cffee0000" .. kind .. " ERROR: " .. err:gsub("line:(%d+):", "line %1 (\"" .. lineText .. "\"):")
	
	--Error:Show()
	Error:SetText(err)
end

function Lua:SetupEventDisplay(eventID)
	if not eventID then return end

	local code = EVENTS:GetEventSettings(eventID).Lua

	code = code:trim(" \r\n\t")
		
	if code == "" then
		code = "|cff808080<No Code>"
	else
		code = code:match("^%-?%-?([^\r\n]*)"):trim()
		
		if code == "" then
			code = "|cff808080<No Code/No Title>"
		end
	end

	
	EVENTS.EventHandlerFrames[eventID].DataText:SetText("|cffcccccc" .. L["EVENTHANDLER_LUA_LUA"] .. ":|r " .. code)
end
--[[
function Sound:SetupEventDisplay(eventID)
	if not eventID then return end

	local name = EVENTS:GetEventSettings(eventID).Sound

	if name == "None" then
		name = "|cff808080" .. NONE
	end

	EVENTS.EventHandlerFrames[eventID].DataText:SetText("|cffcccccc" .. self.handlerName .. ":|r " .. name)
end]]

