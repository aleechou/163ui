local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local MAJOR_VERSION = "AlarLoader-3.0"
local MINOR_VERSION = 1004
local pp=print
local me, ns = ...
local module,old=LibStub:NewLibrary(MAJOR_VERSION,MINOR_VERSION) --#AlarLoader
if (not module) then return end
setmetatable(module,{
	__call = function(t,fname,me,ns)
		t:loadingList(fname,me)
		t:GetPrintFunctions(me,ns)
		return t
	end
	}
)
local lib=module --#AlarLoader
---@module AlarLoader
--Inizializza l'ambiente standard di un addon
--
local tab={} --- Temporary table for print functions injection
lib.loadingTable=lib.loadingTable or {}
lib.progressive=tonumber(lib.progressive) or 1
---@param #string file filename
---@param #string name addon name
function lib:loadingList(file,name)
	lib.loadingTable[self.progressive]=format('%s in %s',file,name)
	lib.progressive=self.progressive+1
end
lib:loadingList(__FILE__,me)
local function dumpdata() end
if (LibDebug) then
	LibDebug() -- changes environment in order to hijack print, but I want also my old one
	dumpdata=print
else
	LoadAddOn("Blizzard_DebugTools")
	dumpdata=DevTools_Dump
end
local function xformat(fmt,...)
		if tostring(fmt):find("%%") and select('#', ...) >= 1 then
		-- Format string
		local success, text = pcall(string.format, fmt, ...)
		if success then
			return text
		end
	end
	return tostringall(fmt,...)
end
lib.debugs=lib.debugs or {}
local function GetChatFrame(chat)
	if (chat) then
		for i=1,NUM_CHAT_WINDOWS do
			local frame=_G["ChatFrame" .. i]
			if (not frame) then break end
			if (frame.name==chat) then return frame end
		end
		return nil
	end
	return DEFAULT_CHAT_FRAME
end
function lib:GetPrintFunctions(caller,skip)
	local result
	if (type(skip)=='table') then result=skip else wipe(tab) result=tab end
	do
		local GetChatFrame=GetChatFrame
		local caller=tostring(caller) or ''
		local skip=tonumber(skip) or 1
		local prefixp=caller .. ':|r|cff20ff20'
		local prefixd='|cffff1010DBG:' .. caller .. ':|r|cff00ff00'
		local prefixs='|cffff1010DBS:' .. caller .. ':|r|cff00ff00'
		local prefixn=caller .. ':|r|cffff9900'
		local prefixe=caller .. '-Error:|r|cffff0000'
		local xformat=xformat
		local debugs=self.debugs
		debugs[caller]=true
		function result.print(...) pp(prefixp,xformat(select(skip,...))) end
		function result.dump(value,desc)
				desc=desc or "Debug dump"
				pp(prefixp ,desc)
				dumpdata(value)
				if (_G.DOVEDIAVOLOSTA) then
					pp(tostring(debugstack(2,1,0)))
				end
		end
		function result.debug(...)
			if (debugs[caller]) then
				local c = GetChatFrame("ADebug")
				if (c) then c:AddMessage(strjoin(' ',date("%X"),prefixd,xformat(select(skip,...))),tostring(debugstack(2,1,0))) end
			end
		end
		function result.sdebug(...)
				local c = GetChatFrame("ADebug")
				if (c) then c:AddMessage(strjoin(' ',date("%X"),prefixs,xformat(select(skip,...))),tostring(debugstack(2,1,0))) end
		end
		function result.notify(...) pp(prefixn,xformat(select(skip,...))) end
		function result.error(...) pp(prefixe,xformat(select(skip,...))) end
		function result.debugEnable(...) if (select(skip,...)) then debugs[caller] = true else debugs[caller] =false end end
	end
	return result
end
function lib:CreateAddon(name,force,...)
		local stub
		if type(force)~="boolean" then force = true end
		if (force) then
			local mixins={}
			for i,k in  LibStub:IterateLibraries() do
					if (i:match("Ace%w*-3%.0") and k.Embed) then
							table.insert(mixins,i)
					end
			end
			table.insert(mixins,"AlarCore-3.0")
			for i=1,select('#',...) do
					table.insert(mixins,(select(i,...)))
			end
			stub=LibStub("AceAddon-3.0"):NewAddon(name,unpack(mixins))
		else
			stub=LibStub("AceAddon-3.0"):NewAddon(name,...)
		end
		if (stub) then
			lib.debugs[name]=false
			do
				local debugs=lib.debugs
				local addon=name
				function stub:EnableDebug(status)
					debugs[addon]=status
				end

			end
				return stub
		else
			error("Unable to create stub " .. tostring(name))
		end
end
function lib:SetDebug(addon,status)
	if (addon=='*') then
		for addon,_ in pairs(self.debugs) do
			self.debugs[addon]=status
		end
	else
		self.debugs[addon]=status
	end
end
function lib:GetDebug(addon)
	if (addon=='*') then
		self:ShowDebug()
	else
		return self.debugs[addon]
	end
end
function lib:ShowDebug()
	print("AlarShared debug status")
	for addon,status in pairs(self.debugs) do
		print(addon,"debug:",(status and "|cffff1010ON|r" or "|cff20ff20OFF|r"))
	end
end
