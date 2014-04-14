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

local loadstring =
	  loadstring


local Lua = TMW.Classes.EventHandler:New("Lua")

Lua:RegisterEventDefaults{
	Lua = "-- <Untitled Lua Code>\n\nlocal icon = ...\n\n--Your code goes here:\n\n\n\n",
}

local Functions = {}

function Lua:GetCompiledFunction(luaCode)
	if Functions[luaCode] then
		return Functions[luaCode]
	end
	
	local func, err = loadstring(luaCode)
	
	if func then
		Functions[luaCode] = func
	end
	
	return func, err
end

-- Required methods
function Lua:ProcessIconEventSettings(event, eventSettings)
	return type(self:GetCompiledFunction(eventSettings.Lua)) == "function"
end

function Lua:HandleEvent(icon, eventSettings)
	local func = self:GetCompiledFunction(eventSettings.Lua)
	
	if func then
		return TMW.safecall(func, icon)
	end
end

function Lua:OnRegisterEventHandlerDataTable()
	error("The Lua event handler does not support registration of event handler data - everything is user-defined.", 3)
end
