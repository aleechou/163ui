local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local MAJOR_VERSION = "AlarWidgets-3.0"
local MINOR_VERSION = 1000
local pp=print
--[[
Name: AlarWidgets-3.0.lua
Revision: $Rev$
Author: Alar of Daggerspine
Email: alar@aspide.it
Website: http://www.curse.com
SVN: $HeadUrl:$
Description: Generic library
Dependencies: Ace3
License: LGPL v2.1
--]]
local me, ns = ...
--[===[@debug@
--print("Loading",__FILE__," inside ",me)
LibStub("AlarLoader-3.0"):loadingList(__FILE__,me)
--@end-debug@]===]
if (LibDebug) then LibDebug() end
local function debug(...)
--[===[@debug@
	print(...)
--@end-debug@]===]
end
local print=_G.print
local notify=_G.print
local error=_G.error
local function dump() end
local function debugEnable() end
if (LibStub("AlarLoader-3.0",true)) then
	local rc=LibStub("AlarLoader-3.0"):GetPrintFunctions(MAJOR_VERSION)
	print=rc.print
	--[===[@debug@
	debug=rc.debug
	dump=rc.dump
	--@end-debug@]===]
	notify=rc.notify
	error=rc.error
	debugEnable=rc.debugEnable
else
	debug("Missing AlarLoader-3.0")
end
local _,_,_,toc=GetBuildInfo()
if (not LibStub) then
		error("Couldn't find LibStub. Please reinstall " .. MAJOR_VERSION )
end
local lib,old=LibStub:NewLibrary(MAJOR_VERSION,MINOR_VERSION) --#AWG
if (not lib) then
		debug("Already loaded a newer or equal version of " .. MAJOR_VERSION)
		return -- Already loaded
end
if (old) then
		debug(format("Upgrading %s from %s to %s",MAJOR_VERSION,old,MINOR_VERSION))
end
debugEnable(false)
local L=LibStub("AceLocale-3.0"):GetLocale('AlarShared',true)
--[[ Standard prologue end --]]
-----------------------------------------------------------------------------
lib.widgets=lib.widgets or {}
local AceGUI = LibStub("AceGUI-3.0")
lib.AceGUI=AceGUI
lib.pp=debug
local WidgetVersion=MINOR_VERSION-65432
function lib:IterateWidgets() return pairs(self.widgets) end
----------------
-- Main Frame --
----------------
do
	local proto={} --#proto
	local meta1={
		__call=function(...)
			print("Funzione",...)
		end
	}

local meta=
{
__index=function(table,key)
		return function() end
	end
}
	function proto:OnAcquire()
		self:ApplyStatus()
	end

	function proto:OnRelease()
		self.status = nil
		for k in pairs(self.localstatus) do
			self.localstatus[k] = nil
		end
	end
	function proto:ApplyStatus(this)
		return
	end
	function proto:IsRestricted()
		return (issecure() or self.frame:IsProtected()) and InCombatLockdown()
	end
	function proto:Status()
		if (self.obj) then
			return self.obj.status or self.obj.localstatus
		else
			return self.status or self.localstatus
		end
	end
	function proto:Show()
		local frame=self.frame
		if (frame:IsProtected() and InCombatLockdown()) then return end
		if (frame.fade) then frame.fade.Stop() end
		frame:SetAlpha(1.0)
		frame:Show()
	end
	function proto:Hide()
		local frame=self.frame
		if (frame:IsProtected() and InCombatLockdown()) then return end
		if (frame.fade) then frame.fade.Stop() end
		if (not InCombatLockdown()) then
			frame:Hide()
		end
		frame:SetAlpha(1.0)
	end

	function proto:SetLocked(lock)
		local status = self:Status()
		local old=status.locked
		status.locked=lock
		self:Lock()
		return old
	end
	function proto:GetLocked()
		local status = self:Status()
		return status.locked
	end
	function proto:FadeIn(delay,from,to)
		local frame=self.frame
		if (frame:IsProtected() and InCombatLockdown()) then return end
		delay=delay or 30
		from=from or frame:GetAlpha()
		to=to or 1
		local frame=self.frame
		if (frame:IsShown()) then
			frame:SetAlpha(to)
		else
					UIFrameFadeIn(frame,delay,from,to)
				end
	end
	function proto:FadeOut(delay,from,to)
		local frame=self.frame
		if (frame:IsProtected() and InCombatLockdown()) then return end
		delay=delay or 30
		from=from or frame:GetAlpha()
		to=to or 0
		local frame=self.frame
			if (not frame:IsShown()) then
			frame:SetAlpha(to)
		else
			UIFrameFadeOut(frame,delay,from,to)
		end
	end
	function proto:GetInfo()
		local frame=self.frame
		print(frame:GetWidth(),'x',frame:GetHeight(),frame:GetWidth())
		for i= 1,frame:GetNumPoints() do
			print (frame:GetPoint(i))
		end
	end
	function proto:ClearAllPoints()
		self.frame:ClearAllPoints()
	end
	function proto:GetEffectiveScale()
		return self.frame:GetEffectiveScale()
	end
	function proto:SetPoint(...)
		if (self.frame:IsProtected() and InCombatLockdown()) then return end
		self.frame:SetPoint(...)
	end
	function proto:GetTop()
		return self.frame:GetTop()
	end
	function proto:GetBottom()
		return self.frame:GetBottom()
	end
	function proto:GetLeft()
		return self.frame:GetLeft()
	end
	function proto:GetRight()
		return self.frame:GetRight()
	end
	function proto:GetCenter()
		return self.frame:GetCenter()
	end
	function proto:GetWidth()
		return self.frame:GetWidth()
	end
	function proto:GetHeight()
		return self.frame:GetHeight()
	end
	function proto:SetScale(scale)
		if (self.frame:IsProtected() and InCombatLockdown()) then return end
		scale=tonumber(scale) or 1
		if (scale < 0.5) then scale=0.5 end
		self.frame:SetScale(scale)
		local status = self:Status()
		status.scale=scale
	end
	function proto:SetStatusTable(status)
		assert(type(status) == "table")
		self.status = status
		self:ApplyStatus()
	end
	function proto:SaveStatus()
		local status = self:Status()
		local this=self.frame
		status.width = this:GetWidth()
		status.height = this:GetHeight()
		status.top = this:GetTop()
		status.left = this:GetLeft()
	end
	function proto:Super()
		return proto
	end
	function lib.InjectStandardMethods(target)
			for k,v in pairs(proto) do
			target[k]=target[k] or v
			end
			if (not target.localstatus) then
				target.localstatus={}
			end
	end
	function lib:RescaleXY(x,y,from,to)
		local sfrom=from:GetEffectiveScale()
		local sto=to:GetEffectiveScale()
		return x*sfrom/sto,y*sfrom/sto
	end
	function proto:Parent(ancestor,method,...)
			local f=self.parents[ancestor]
			if (type(f)=="table" and method) then
			if type(f[method])=="function" then
				return f[method](self,...)
			end
		end
	end
	function proto:Inject(source,ancestor)
		ancestor=ancestor or '<SUPER>'
		self.parents=self.parents or {}
		self.parents[ancestor]=setmetatable({},meta)
		for func,body in pairs(source) do
			self.parents[ancestor][func]=self[func]
			self[func]=body
		end
	end
end
function lib:CreatePanel()
		AceGUI:Create('AlarPanel')
end
function lib:CreateConfig()
		AceGUI:Create('AlarConfig')
end
function lib:CreateMiniMap()
		AceGUI:Create('AlarMinimapButton')
end
function lib:CreateCastButton()
		AceGUI:Create('AlarCastButton')
end
lib.panels=lib.panels or {}
do
	local panels=lib.panels

function lib:Pop(widget,offset)
	debug('Popping',widget.frame:GetName())
	offset=offset or 48
	local newoffset=0
	local lpanels=panels
	for i,panel in pairs(lpanels) do
		if (panel==widget) then return newoffset end
		if (type(panel.IsShown)=="function") then
			if (not panel:IsShown()) then
				tremove(panels,i)
			else
				newoffset=newoffset+offset
			end
		else
			tremove(panels,i)
		end
	end
	tinsert(panels,widget)
	return newoffset
end
end
------------------------- Helpers -----
