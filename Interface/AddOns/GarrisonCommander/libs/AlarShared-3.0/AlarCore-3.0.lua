local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local MAJOR_VERSION = "AlarCore-3.0"
local MINOR_VERSION = 1006
local pp=print
local toc=select(4,GetBuildInfo())
local me, ns = ...
local rc=LibStub("AlarLoader-3.0")(__FILE__,me):GetPrintFunctions(MAJOR_VERSION)
if (LibDebug) then LibDebug() end
local print=rc.print
local debug=rc.debug
local dump=rc.dump
local notify=rc.notify
local error=rc.error
local debugEnable=rc.debugEnable
rc=nil
--[[ Standard prologue end --]]
local app,old=LibStub:NewLibrary(MAJOR_VERSION,MINOR_VERSION)
local lib=app --#lib
if (not lib) then
	debug("Already loaded a newer or equal version of " .. MAJOR_VERSION)
	return -- Already loaded
end
if (old) then
	debug(format("Upgrading %s from %s to %s",MAJOR_VERSION,old,MINOR_VERSION))
else
	lib.list = setmetatable({}, {__mode="k"})
end
local L=LibStub("AceLocale-3.0"):GetLocale('AlarShared',true)
local C=LibStub("AlarCrayon-3.0"):GetColorTable()
local _G=_G
local floor=floor
local abs=abs
-- Help sections
local titles={
	RELNOTES=L["Release Notes"],
	LIBRARIES=L["Libraries"],
	TOGGLES=L["Toggles"],
	PROFILE=L["Profile"]
}
local RELNOTES='RELNOTES'
local LIBRARIES='LIBRARIES'
local TOGGLES='TOGGLES'
local PROFILE='PROFILE'
local HELPSECTIONS={RELNOTES,TOGGLES,PROFILE,LIBRARIES}
local AceConfig = LibStub("AceConfig-3.0",true) or debug("Missing AceConfig-3.0")
local AceRegistry = LibStub("AceConfigRegistry-3.0",true) or debug("Missing AceConfigRegistry-3.0")
local AceDBOptions=LibStub("AceDBOptions-3.0",true) or debug ("Missing AceDBOptions-3.0")
local AceConfigDialog=LibStub("AceConfigDialog-3.0",true) or debug("Missing gui support")
local AceGUI=LibStub("AceGUI-3.0",true)
local next = next
local pairs = pairs
local pcall = pcall
local type = type
local GetTime = GetTime
local gcinfo = gcinfo
local unpack = unpack
local geterrorhandler = geterrorhandler
local GetContainerNumSlots=GetContainerNumSlots
local GetContainerItemID=GetContainerItemID
local GetItemInfo=GetItemInfo
local UnitHealth=UnitHealth
local UnitHealthMax=UnitHealthMax
local GetItemInfo=GetItemInfo
local CachedGetItemInfo
local wipe=wipe
local setmetatable=setmetatable
local NUM_BAG_SLOTS=NUM_BAG_SLOTS

-- Recycling function from ACE3
----newcount, delcount,createdcount,cached = 0,0,0
local new, del, copy
do
	local pool = setmetatable({},{__mode="k"})
	function new()
		--newcount = newcount + 1
		local t = next(pool)
		if t then
			pool[t] = nil
			return t
		else
			--createdcount = createdcount + 1
			return {}
		end
	end
	function copy(t)
		local c = new()
		for k, v in pairs(t) do
			c[k] = v
		end
		return c
	end
	function del(t)
		--delcount = delcount + 1
		wipe(t)
		pool[t] = true
	end
--	function cached()
--		local n = 0
--		for k in pairs(pool) do
--			n = n + 1
--		end
--		return n
--	end
end
lib.mix=lib.mix or {}
local mix=lib.mix --#mix
lib.virt=lib.virt or {}
local virt=lib.virt --#virt
lib.mixinTargets=lib.mixinTargets or {}
lib.frame=lib.frame or CreateFrame("Frame")
lib.combatSchedules = lib.combatSchedules or {}

if (not lib.wow) then
	local v,b,d,t=GetBuildInfo()
	lib.wow={version=v,build=b,date=d,toc=t}
end
local wow=lib.wow

local combatSchedules = lib.combatSchedules

local function nop(self,...)
	if (_G.ALARDEVELOPMENTPC) then
			--self:Print('nop',...)
	end
end
local function str2num(versione)
	versione =versione or 0
	if (type(versione) == "string") then
		local a,b,c=versione:match("(%d*)%D?(%d*)%D?(%d*)%D*")
		a=tonumber(a) or 0
		b=tonumber(b) or 0
		c=tonumber(c) or 0
		return a*1000+b+c/100
	else
		return versione
	end
end
-- Gestione variabili
local varmeta={}
do
	local nop=nop
		local function f1(self,flag,value)
			return self:Apply(flag,value)
		end
		local function f2(self,flag,value)
			return self['Apply' .. flag](self,value)
		end
		varmeta={
			__index =
			function(table,cmd)
				local self=rawget(table,'_handler')
				if (type(self["Apply" .. cmd]) =='function') then
					rawset(table,cmd,f2)
				elseif (type(self.Apply)=='function') then
					rawset(table,cmd,f1)
				else
					rawset(table,cmd,function(...) end)
				end
				return rawget(table,cmd)
			end
		}
end
local function versiontonumber(version)
		if (type(version)=="number") then
				return version
		end
		local s,e,svn=version:find("$Rev%D*(%d+)%D*%$")
		version=version:gsub("$Rev%D*(%d+)%D*%$","")
		local res=0
		local fractpart=0
		local mult=1
		for i in version:gmatch("%d+") do
				local n=tonumber(i) or 0
				if (n < 1000) then
						res=res*1000
						res=res+n
				end
		end
		return tonumber(res .. '.' .. (svn or '0'))
end
function mix:NewTable(...)
	return new(...)
end
function mix:DelTable(...)
	return del(...)
end
function mix:VersionCompare(otherversion,strict)
		oterhversion=versiontonumber(otherversion)
		if (strict) then
				return self.numericversion-otherversion
		else
				return floor(self.numericversion - otherversion)
		end
end
local Myclass
---
-- Check if the unit in target hast the requested clas
-- @param #string class Requested Class
-- @param #string target Requested Unit (default 'player')
-- @return #boolean true if target has the requeste class
function mix:Is(class,target)
	target=target or "player"
	if (target == "player") then
		if (not Myclass) then
			Myclass=select(2,UnitClass('player'))
		end
		return Myclass==strupper(class)
	else
		local    rc,_,unitclass=pcall(UnitClass,target)
		if (rc) then
			return unitclass==strupper(class)
		else
			return false
		end
	end
end
---
-- Parses a chat command
-- @param msg Message returned from wow chat '/' command
-- @return command,subcommand,arg,ffull string after command
function mix:Parse(msg)
	if (not msg) then
		return nil
	end
	if (type(msg) == 'table' and msg.input ) then msg=msg.input end
	if (type(msg) ~= 'string') then return end
	local cmd,subcmd,param = strsplit(" ",msg,3)
	local _,fullarg=strsplit(" ",msg,2)
	return cmd,subcmd,param,fullarg
end
---
-- Parses an itenlink and returns itemId without calling API again
-- @param string itemlink
-- @return number itemId or 0
function mix:GetItemID(itemlink)
	if (type(itemlink)=="string") then
			return tonumber(itemlink:match("Hitem:(%d+):")) or 0
	else
			return 0
	end
end
---
-- Scans Bags for an item based on different criteria
--
-- All parameters are optional.
-- With no params ScanBags returns the first empty slot
--
-- @param index is index in GetItemInfo result. 0 is a special case to match just itemid
-- @param value is the value against to match. 0 is a special case for empty slot
-- @param startbag and starslot are used to restart scan from the last item found
-- @param startslot
-- @return Found ItemId,bag,slot,full GetItemInfo result
function mix:ScanBags(index,value,startbag,startslot)
	index=index or 0
	value=value or 0
	startbag=startbag or 0
	startslot=startslot or 1
	for bag=startbag,NUM_BAG_SLOTS,1 do
		for slot=startslot,GetContainerNumSlots(bag),1 do
			local itemlink=GetContainerItemLink(bag,slot)
			if (itemlink) then
				if (index==0) then
					if (self:GetItemID(itemlink)==value) then
						return itemlink,bag,slot
					end
				else
					local test=CachedGetItemInfo(itemlink,index)
					if (value==test) then
						return itemlink,bag,slot
					end
				end
			end
		end
	end
	return false
end

function mix:GetArg(msg,arg)
	if (not msg) then
		return nil
	end
	if (type(msg) == 'table' and msg.input ) then msg=msg.input end
	if (type(msg) ~= 'string') then return end
	if (not arg) then arg=1 end
	return select(arg+1,strsplit(" ",msg))
end
function mix:Health(unit)
		local totale=UnitHealthMax(unit) or 1
		local corrente=UnitHealth(unit) or 1
		if (corrente == 0) then corrente =1 end
		if (totale==0) then totale = corrente end
		local life=corrente/totale*100
		return math.ceil(life)
end
function mix:Age(secs)
		return self:TimeToStr(GetTime() - secs)
end
function mix:Mana(unit)
		local totale=UnitManaMax(unit) or 1
		local corrente=UnitMana(unit) or 1
		if (corrente == 0) then corrente =1 end
		if (totale==0) then totale = corrente end
		local life=corrente/totale*100
		return math.ceil(life)
end
function mix:IsFriend(player)
	local i
	for i =1,GetNumFriends() do
		local name,_,_,_,_ =GetFriendInfo(i)
		if (name == player) then
			return true
		end
	end
	return false
end
function mix:GetDistanceFromMe(unit)
	if not unit then return 99999 end
	local x,y=GetPlayerMapPosition(unit)
	return self:GetUnitDistance(x,y)
end
function mix:GetUnitDistance(x,y,unit)
		unit=unit or "player"
		local from={}
		local to={}
		from.x,from.y=GetPlayerMapPosition(unit)
		to.x=x
		to.y=y
		return self:GetDistance(from,to) * 10000
end
function mix:GetDistance(a,b)
--------------
-- Calculates distance betweeb 2 points given as
-- a.x,a.y and b.x,b.y
	local x=b.x - a.x
	local y=b.y -a.y
	local d=x*x + y* y
	local rc,distance=pcall(math.sqrt,d)
	if (rc) then
				return distance
		else
				return 99999
		end
end
local function _DebugEnable(info)
	local self=info.handler
	local status=info.arg
	pp("Called _DebugeEnable",self,status)
	self:EnableDebug(status)
end
local function LoadDefaults(self)
	self.OptionsTable={
		handler=self,
		type="group",
		childGroups="tab",
		name=self.title,
		desc=self.notes,
		args={
			gui = {
				name="GUI",
				desc="Activates gui",
				type="execute",
				func="Gui",
				guiHidden=true,
			},
			help = {
				name="HELP",
				desc="Show help",
				type="execute",
				func="Help",
				guiHidden=true,
			},
			on = {
				name="On",
				desc="Activates " .. self.title,
				type="execute",
				func="Enable",
				guiHidden=true,
			},
			off = {
				name="Off",
				desc="Deactivates " .. self.title,
				type="execute",
				func="Disable",
				guiHidden=true,
				arg='Active'
			},
			debug ={
				name="debug",
				desc="Toggles debug for " .. self.title,
				type="input",
				set="_SwitchDebug",
				hidden=true
			},
			standby = {
				name="Enabled",
				desc="Toggle " .. self.title .. " status",
				type="toggle",
				get="IsEnabled",
				set="Toggle",
				cmdHidden=true,
				arg='Active'
			},
			toggle={
				type="group",
				name="toggle",
				desc="configuration switches",
				guiHidden=true,
				args={}
			}
		}
	}
	self.DbDefaults={
		global={
			currentversion=self.version,
			firstrun=true,
			lastversion=0,
			lastinterface=60000,

		},
		profile={
			toggles={
					Active=true,
			},
			["*"]={},
		}
	}
	self.MenuLevels={"root"}
	self.ItemOrder=setmetatable({},{
		__index=function(table,key) rawset(table,key,1)
			return 1
		end
		}
	)
	local AceDB  = LibStub("AceDB-3.0",true) or debug("Missing AceDB-3.0")
	if (AceDB and not self.db) then
		self.db=AceDB:New(self.DATABASE)
		--self.localdb=self.db:RegisterNamespace(self.name)
	end
	self.db:RegisterDefaults(self.DbDefaults)
	self:SetEnabledState(self:GetBoolean("Active"))
	-- I have for sure some library that needs to be intialized Before the addon
	for _,library in self:IterateEmbeds(self) do
		local lib=LibStub(library)
		if (lib.OnEmbedPreInitialize) then
			lib:OnEmbedPreInitialize(self)
		end
	end
end
local function LoadHelp(self)
	local main=self.name
--[===[@debug@
	for libname,k in LibStub:IterateLibraries() do
		if (libname:match("Ace%w*-3%.0")) then
			self:HF_Lib(libname,'yellow')
		elseif (libname:match("Ace%w*-2%.0")) then
			self:HF_Lib(libname,'yellow')
		elseif (libname:match("Alar%w*-3%.0")) then
			self:HF_Lib(libname,'green')
		else
			self:HF_Lib(libname,'gray')
		end
	end
--@end-debug@]===]
	for _,section in ipairs(HELPSECTIONS) do
		if (section == RELNOTES) then
			self:HF_Load(section,main..section,' ' .. tostring(self.version) .. ' (r:' .. tostring(self.revision) ..')')
		else
			self:HF_Load(section,main .. section,'')
		end
	end
end
function mix:OnInitialize(...)
	CachedGetItemInfo=self:GetCachingGetItemInfo()
	self.print(format("Version %s %s loaded" ,self:Colorize(self.version,'green'),self:Colorize(format("(Revision: %s)",self.revision),"silver")))
	LoadDefaults(self)
	self.help=setmetatable(
			{},
			{__index=function(table,key)
					rawset(table,key,"")
					return rawget(table,key)
					end
			}
	)
	local ignoreProfile=self:OnInitialized(...)
	if (not self.OnDisabled) then
		self.OptionsTable.args.on=nil
		self.OptionsTable.args.off=nil
		self.OptionsTable.args.standby=nil
	end
	local main=self.name
	local profile
	if (AceDBOptions) then
		self.ProfileOpts=AceDBOptions:GetOptionsTable(self.db)
		titles.PROFILE=self.ProfileOpts.name
		self.ProfileOpts.name=self.name
		profile=main..PROFILE
	end
	LoadHelp(self)
	AceConfig:RegisterOptionsTable(main,self.OptionsTable,{main,strlower(self.ID)})
	self.CfgDlg=AceConfigDialog:AddToBlizOptions(main,main )
	if (profile and not ignoreProfile) then
		AceConfig:RegisterOptionsTable(main .. PROFILE,self.ProfileOpts)
		AceConfigDialog:AddToBlizOptions(main .. PROFILE,titles.PROFILE,main)
	end
	if (self.help[RELNOTES]~='') then
		self.CfgRel=AceConfigDialog:AddToBlizOptions(main..RELNOTES,titles.RELNOTES,main)
	end
	if (self.help[TOGGLES]~='') then
		AceConfigDialog:AddToBlizOptions(main..TOGGLES,titles.TOGGLES,main)
	end
	if (self.help[LIBRARIES]~='') then
		AceConfigDialog:AddToBlizOptions(main..LIBRARIES,titles.LIBRARIES,main)
	end
end

-- help related functions
function mix:HF_Push(section,text)
		section=section or self.lastsection or RELNOTES
		self.lastsection=section
		self.help[section]=self.help[section]  .. '\n' .. text
end
local getlibs
do
	local libs={}
		function mix:HF_Lib(libname)
				local o,minor=LibStub(libname,true)
				if (o and libs) then
						if (not libs[o] or libs[o] <minor) then
								libs[libname]=minor
						end
				end
		end
		function getlibs(self)
				local appo={}
				if (not libs) then return end
				for i,_ in pairs(libs) do
						table.insert(appo,i)
				end
				table.sort(appo)
				for _,libname in pairs(appo) do
						local minor=libs[libname]
						self:HF_Pre(format("%s release: %s",self:Colorize(libname,'green'),self:Colorize(minor,'orange')),LIBRARIES)
				end
				libs=nil
		end
end

function mix:HF_Toggle(flag,description)
	flag=C(format("/%s toggle %s: ",strlower(self.ID),flag),'orange') ..C(description,'white')
	self:HF_Push(TOGGLES,"\n" .. C(flag,'orange'))
end

function mix:HF_Title(text,section)
	self:HF_Push(section,C(text or '','yellow') .. "\n")
end
function mix:HF_Command(text,description,section)
	self:HF_Push(section,C(text or '','orange') .. ':' ..  C(description or '','yellow') .. "\n")
end

function mix:HF_Paragraph(text,section)
	self:HF_Push(section,"\n"..C(text,'green'))
end
function mix:HF_CmdA(command,description,tooltip)
	self:HF_Push(nil,
	C('/' .. command,'orange') .. ' : ' .. (description or '') .. '\n' .. C(tooltip or '','yellow'))
end
function mix:HF_Cmd(command,description,tooltip)
	command=self.ID .. ' ' .. command
	self:HF_CmdA(command,description,tooltip)
end
function mix:HF_Pre(testo,section)
	self:HF_Push(section,testo)
end
function mix:Wiki(testo,section)
	section=section or self.lastsection or RELNOTES
	self.lastsection=section
	local fmtbullet=" * %s\n"
	local progressive=1
	local fmtnum=" %2d. %s\n"
	local fmthead1="|cff" .. C.Orange  .."%s|r\n \n \n"
	local fmthead2="|cff" .. C.Yellow  .."%s|r\n \n"
	local text=''
	for line in testo:gmatch("(%C*)%c+") do
		line=line:gsub("^ *","")
		line=line:gsub(" *$","")
		local i,j= line:find('^%=+')
		if (i) then
			if (j==1) then
				text=text .. fmthead1:format(line:sub(j+1,-j-1))
			else
				text=text .. fmthead2:format(line:sub(j+1,-j-1))
			end
		else
			local i,j= line:find('^%*+')
			if (i) then
				text=text.. fmtbullet:format(line:sub(j+1))
			else
				local i,j= line:find('^#+')
				if (i) then
					text=text .. fmtnum:format(progressive,line:sub(j+1))
					progressive=progressive + 1
				else
					text=text .. line.."\n"
				end
			end
		end
	end
	self.help[section]=self.help[section]  .. '\n' .. text
end

function mix:RelNotes(major,minor,revision,t)
	local fmt=self:Colorize("Release note for %d.%d.%s",'Yellow') .."\n%s"
	local lines={}
	local spacer=""
	local maxpanlen=70
	lines={strsplit("\n",t)}
	local max=5
	for i,tt in ipairs(lines) do
		local prefix,text=tt:match("^(%a+):(.*)")
		if (prefix == "Fixed" or prefix=="Fix") then
			prefix=self:Colorize("Fix: ",'Red')
			spacer="       "
		elseif (prefix == "Feature") then
			prefix=self:Colorize("Feature: ",'Green')
			spacer=             "         "
		else
			text=tt
			prefix=spacer
		end
		local tta=""
		tt=text
		while (tt:len() > maxpanlen)  do
			local p=tt:find("[%s%p]",maxpanlen -10) or maxpanlen
			tta=tta..prefix..tt:sub(1,p) .. "\n"
			prefix=spacer
			tt=tt:sub(p+1)
		end
		tta=tta..prefix..tt
		tta=tta:gsub("Upgrade:",self:Colorize("Upgrade:",'Azure'))
		lines[i]=tta:gsub("Example:",self:Colorize("Example:",'Orange'))
		max=max-1
		if (max<1) then
			break
		end
	end
	self:HF_Push(RELNOTES,fmt:format(major,minor,revision,strjoin("\n",unpack(lines))))
end

function mix:HF_Load(section,optionname,versione)
-- Creazione pannello di help
-- Livello due del
	if (section == LIBRARIES) then
		getlibs(self)
	end
	local testo =self.help[section]
	--debug(section)
	--debug(optionname)
	--debug(self.title)
	if (testo ~= '') then
		AceConfig:RegisterOptionsTable(optionname, {
			name = self.title .. (versione or ""),
			type = "group",
			args = {
				help = {
					type = "description",
					name = testo,
					fontSize='medium',
				},
			},
		})
		AceConfigDialog:SetDefaultSize(optionname, 600, 400)
	end
end
-- Compatibility
virt.EvtStart=setmetatable({},{__call=function() self:StartAutomaticEvents() end})
virt.EvtStop=setmetatable({},{__call=function() self:StopAutomaticEvents() end})
function virt:Register()
	return
end
function virt:Localize(...)
		return
end
function virt:OnInitialized(...)
		return
end
function virt:OnEnabled(...)
		return
end
function virt:OnDisabled(...)
		return
end
-- var area
local function getgroup(self)
	local group=self.OptionsTable
	local m=self.MenuLevels
	for i=2,#m do
			group=group.args[self.MenuLevels[i]]
	end
	if (type(group) ~= "table") then
			group={}
	end
	return group
end
local function getorder(self,group)
	local i=self.ItemOrder[group.name]+1
	self.ItemOrder[group.name]=i
	return i
end
local function toflag(...)
	local appo=''
	for i=1,select("#",...) do
		appo=appo .. tostring(select(i,...))
	end
		return appo:gsub("%W",'')
end
function mix:EndLabel()
	local m=self.MenuLevels
	if (#m > 1) then
			table.remove(m)
	end
end

--self:AddLabel("General","General Options",C.Green)
function mix:AddLabel(title,description,stringcolor)
	self:EndLabel()
	description=description or title
	stringcolor=stringcolor or C.yellow
	local t=self:AddSubLabel(title,description,stringcolor)
	t.childGroups="tab"
	self:AddSeparator(description)
	return t
end
--self:AddSubLabel("Local","Local Options",C.Green)
function mix:AddSubLabel(title,description,stringcolor)
	local m=self.MenuLevels
	description=description or title
	stringcolor=stringcolor or C.orange
	local group=getgroup(self)
	local flag=toflag(group.name,title)
	group.args[flag]={
			name="|cff" .. stringcolor .. title .. "|r",
			desc=description,
			type="group",
			cmdHidden=true,
			args={},
			order=getorder(self,group),
	}
	table.insert(m,flag)
	return group.args[flag]
end

--self:AddText("Testo"[,texture[,height[,width[,texcoords]]]])
function mix:AddText(text,image,imageHeight,imageWidth,imageCoords)
	local group=getgroup(self)
	local flag=toflag(group.name,text)
	local t={
			name=text,
			type="description",
			image=image,
			imageHeight=imageHeight,
			imageWidth=imageWidth,
			imageCoords=imageCoords,
			desc=text,
			order=getorder(self,group),

	}
	group.args[flag]=t
	return t
end

--self:AddToggle("AUTOLEAVE",true,"Quick Battlefield Leave","Alt-Click on hide button in battlefield alert leaves the queue")
function mix:AddBoolean(flag,defaultvalue,name,description,icon)
	description=description or name
	local group=getgroup(self)
	local t={
			name=name,
			type="toggle",
			get="OptToggleGet",
			set="OptToggleSet",
			desc=description,
			arg=flag,
			cmdHidden=true,
			icon=icon,
			order=getorder(self,group),

	}
	group.args[flag]=t
	if (self.db.profile.toggles[flag]== nil) then
			self.db.profile.toggles[flag]=defaultvalue
	end
	self.OptionsTable.args.toggle.args[flag]=t
	return t
end
function mix:AddToggle(flag,defaultvalue,name,description)
	description=description or name
	self:HF_Toggle(flag,description)
	return self:AddBoolean(flag,defaultvalue,name,description)
end
--self:AddSlider("RESTIMER",5,1,10,"Enable res timer","Shows a timer for battlefield resser",1)
function mix:AddSlider(flag,defaultvalue,min,max,name,description,step)
	description=description or name
	min=min or 0
	max=max or 100
	local group=getgroup(self)
	local isPercent=nil
	if (type(step)=="boolean") then
		isPercent=step
		step=nil
	else
		step=tonumber(step)
	end
	local t={
		name=name,
		type="range",
		get="OptToggleGet",
		set="OptToggleSet",
		desc=description,
		arg=flag,
		step=step,
		isPercent=isPercent,
		min=min,
		max=max,
		order=getorder(self,group),
	}
	group.args[flag]=t
	if (self.db.profile.toggles[flag]== nil) then
		self.db.profile.toggles[flag]=defaultvalue
	end
	return t
end
-- self:AddEdit("REFLECTTO","","Whisper reflection receiver:","All your whispers will be forwarded to this guy","How to use it")
function mix:AddEdit(flag,defaultvalue,name,description,usage)
	description=description or name
	usage = usage or description
	local group=getgroup(self)
	local t={
			name=name,
			type="input",
			get="OptToggleGet",
			set="OptToggleSet",
			desc=description,
			arg=flag,
			usage=usage,
			order=getorder(self,group),

	}
	group.args[flag]=t
	if (self.db.profile.toggles[flag]== nil) then
			self.db.profile.toggles[flag]=defaultvalue
	end
	return t
end
-- self:AddEdit("REFLECTTO",1,{a=1,b=2},"Whisper reflection receiver:","All your whispers will be forwarded to this guy")
function mix:AddSelect(flag,defaultvalue,values,name,description)
	description=description or name
	local group=getgroup(self)
	local t={
			name=name,
			type="select",
			get="OptToggleGet",
			set="OptToggleSet",
			desc=description,
			values=values,
			arg=flag,
			cmdHidden=true,
			order=getorder(self,group)
	}
	group.args[flag]=t
	if (self.db.profile.toggles[flag]== nil) then
			self.db.profile.toggles[flag]=defaultvalue
	end
	return t
end

-- self:AddAction(["btopenspells",]"openSpells","Opens spell panel","You can choose yoru spells in spell panel")
function mix:AddAction(method,label,description,private)
	label=label or method
	description=description or label
		local group=getgroup(self)
		if type(self[method]) ~="function" and type(self[label])=="function" then
			local appo=method
			method=label
			label=appo
			appo=nil
		end
		local t={
			func=method,
			name=label,
			type="execute",
			desc=description,
			confirm=false,
			cmdHidden=true,
			order=getorder(self,group)
		}
	if (private) then t.hidden=true end
		group.args[strlower(label)]=t
		return t
end

function mix:AddPrivateAction(method,name,description)
	return self:AddAction(method,name,description,true)
end
function mix:AddKeyBinding(flag,name,description)
	name=name or strlower(name)
	description=description or name
	local group=getgroup(self)
	local t={
		name=name,
		type="keybinding",
		get="OptToggleGet",
		set="OptToggleSet",
		desc=description,
		arg=flag,
		order=getorder(self,group)
	}
	group.args[flag]=t
	return t
end
function mix:AddTable(flag,table)
	local group=getgroup(self)
	group.args[flag]=table
end
function mix:_OpenCmd(info,args)
	local method=info.arg
	self[method](self,strsplit(' ',args))
end
function mix:AddOpenCmd(command,method,description,arguments,private)
	method=method or command
	description=description or command
	local group=getgroup(self)
	if (not private) then
		local command=C('/' .. self.ID .. ' ' .. command .. " (" .. description .. ")" ,'orange')
		local t={
			name=command,
			type="description",
			order=getorder(self,group),
			fontSize='medium',
			width='full'
		}
		group.args[command .. 'title']=t
	end
	local t={
		name=command,
		type="input",
		arg=method,
		get=function() end,
		set="_OpenCmd",
		desc=description,
		order=getorder(self,group),
		guiHidden=true,
		hidden=private
	}
	if (type(arguments)=="table") then
		local validate={}
		for _,v in pairs(arguments) do
			validate[v]=v
		end
		t.values=validate
		t.type="select"
	end
	self.OptionsTable.args[command]=t

	return t
end
function mix:AddPrivateOpenCmd(command,method,description,arguments)
	return self:AddOpenCmd(command,method,description,arguments,true)
end

--self:AddSubCmd(flagname,method,label,description)
function mix:AddSubCmd(flag,method,name,description,input)
	method=method or flag
	name=name or flag
	description=description or name
	local group=getgroup(self)
	debug("AddSubCmd " .. flag .. " for " .. method)
	local t={
		func=method,
		name=name,
		type="execute",
		input=input,
		desc=description,
		confirm=true,
		order=getorder(self,group),
		guiHidden=true,
	}
	group.args[flag]=t
	return t
end



--self:AddCmd(flag,method,name,description)
function mix:AddChatCmd(flag,method,name,description)
	self:RegisterChatCommand(flag,method)
	name=name or flag
	description=description or name

	local group=getgroup(self)
	local t={
			name=C('/' .. flag ..  " (" .. description .. ")",'orange'),
			type="description",
			order=getorder(self,group),
			fontSize="medium",
			width="full"
	}
	group.args[flag .. 'title']=t
	return t
end

--self:AddSeparator(text)

function mix:AddSeparator(text)
	local group=getgroup(self)
	local i=getorder(self,group)
	local flag=group.name .. i
	flag=flag:gsub('%W','')
	local t={
			name=text,
			type="header",
			order=i,
	}
	group.args[flag]=t
	return t
end

function lib:OnEmbedEnable(first)
end

function lib:OnEmbedDisable()
end


function mix:UpdateVersion()
	if (type(self.db.char) == "table") then
		self.db.char.version=str2num(self.version)
	end
	if (type(self.db.global)=="table") then
		self.db.global.lastversion=self.version
		self.db.global.firstrun=false
		self.db.global.lastinterface=self:GetTocVersion()
	end
end
function mix:IsNewVersion()
	return str2num(self.version) > str2num(self.db.char.version)
end
function mix:VersionIsAtLeast(compareto)
	return str2num(compareto) >= str2num(self.version)
end

function mix:OnEnable(first,...)
	if (self.notfirst) then
		self.print("enabled")
		self.notfirst=true
	end
		self.print("enabled")
	self:ApplySettings()
	self:OnEnabled(not self.notfirst,...)
end
function mix:OnDisable(...)
	self.print(C("disabled",'red'))
	self:OnDisabled(...)
end
local function _GetMethod(target,prefix,func)
	if (func == 'Start' or func == 'Stop') then return end
	local method=prefix .. func
	if (type(target[method])== "function") then
			return method
	elseif (type(target["_" .. prefix])) then
			return "_" .. prefix
	end
end
function mix:StartAutomaticEvents()
	for k,v in pairs(self) do
		if (type(v)=='function') then
			if (k:sub(1,3)=='Evt') then
				self:RegisterEvent(k:sub(4),k)
			end
		end
	end
end
function mix:StopAutomaticEvents(ignore)
	for k,v in pairs(self) do
		if (type(v)=='function') then
			if (k:sub(1,3)=='Evt') then
				if (ignore and k==ignore or k:sub(4)==ignore) then
					--a kickstart event not to be disabled
				else
					self:UnregisterEvent(k:sub(4))
				end
			end
		end
	end
end
function mix:Notify(...)
	return self:CustomPrint(C.orange.r,C.orange.g,C.orange.b, nil, nil, ' ', ...)
end
function mix:Debug(...)
	if (self.DebugOn or _G.ALARDEVELOPMENTPC) then
		self:Print(...)
	end
end
--[[
function mix:Print(...)
	return self:CustomPrint(nil, nil, nil, nil, nil, ' ', ...)
end
--]]
function mix:Dump(...)
	return self:CustomPrint(nil, nil, nil, nil, nil, true, ...)
end

function mix:Colorize(stringa,colore)
	return C(stringa,colore) .. "|r"
end
function mix:GetTocVersion()
	return tonumber(wow.TocVersion) or 0
end
function mix:Toggle()
	if (self:IsEnabled()) then
		self:Disable()
	else
		self:Enable()
	end
end
function mix:Vars()
	return pairs(self.db.profile.toggles)
end
function mix:SetBoolean(flag,value)
	if (value) then
		value=true
	else
		value=false
	end
	self.db.profile.toggles[flag]=value
	return not value
end
function mix:GetBoolean(flag)
	if (self.db.profile.toggles[flag]) then
		return true
	else
		return false
	end
end
mix.GetToggle=mix.GetBoolean -- alias
function mix:GetNumber(flag,default)
	return tonumber(self:GetSet(flag) or default or 0)
end
function mix:GetString(flag,default)
	return tostring(self:GetSet(flag) or default or '')
end
local CLOSE=_G.FONT_COLOR_CODE_CLOSE or '|r'
local off=(_G.RED_FONT_COLOR_CODE or '|cffff0000') .. 'Off' ..  CLOSE
local on=(_G.GREEN_FONT_COLOR_CODE or '|cff00ff00') .. 'On' ..  CLOSE
function mix:PrintBoolean(flag)
	if (type(flag) == "string") then
		flag=self:GetBoolean(flag)
	end
	if (flag) then
		return on
	else
		return off
	end
end
function mix:GetSet(...)
	local flag,value=select(1,...)
	if (select('#',...) == 2) then
		self.db.profile.toggles[flag]=value
	else
		return self.db.profile.toggles[flag]
	end
end
function mix:GetVar(flag)
	return self:GetSet(flag)
end
function mix:SetVar(flag,value)
	return self:GetSet(flag,value)
end
function mix:OptToggleSet(info,value)
	local flag=info.option.arg
	local tipo=info.option.type

	if (tipo=="toggle") then
		self:SetBoolean(flag,value)
	else
		self:GetSet(flag,value)
	end
	if (self:IsEnabled()) then
		self._Apply[flag](self,flag,value)
	end
end
function mix:OptToggleGet(info)
	local flag=info.option.arg
	local tipo=info.option.type
	if (tipo=="toggle") then
		return self:GetBoolean(flag)
	else
		return self:GetSet(flag)
	end
end
function mix:ApplySettings()
	if (type(self.ApplyAll)=="function") then
		self:ApplyAll()
	else
		for i,v in self:Vars() do
			self._Apply[i](self,i,v)
		end
	end
end
local neveropened=true
function mix:Gui(info)
	if (AceConfigDialog and AceGUI) then
		if (neveropened) then
			InterfaceAddOnsList_Update()
			neveropened=false
		end
		InterfaceOptionsFrame_OpenToCategory(self.CfgDlg)
	else
		self:Print("No GUI available")
	end
end
function mix:Help(info)
	if (AceConfigDialog and AceGUI) then
		if (neveropened) then
			InterfaceAddOnsList_Update()
			neveropened=false
		end
		InterfaceOptionsFrame_OpenToCategory(self.CfgRel)
	else
		self:Print("No GUI available")
	end
end
function mix:IsEventScheduled(flag)
	lib.timerhandles=lib.timerhandles or {}
	return lib.timerhandles[flag]
end
function mix:ScheduleRepeatingEvent(flag,...)
	lib.timerhandles=lib.timerhandles or {}
	lib.timerhandles[flag]=self:ScheduleRepeatingTimer(...)
end
function mix:CancelScheduledEvent(flag)
	lib.timerhandles=lib.timerhandles or {}
	local h=lib.timerhandles[flag]
	self:CancelTimer(h)
end
function mix:Trace(...)
--[===[@debug@
	self:_Trace(false,...)
--@end-debug@]===]
end
function mix:FullTrace(...)
	--[===[@debug@
	self:_Trace(true,...)
	--@end-debug@]===]
end
function mix:_Trace(ft,fmt,...)
		local stack={strsplit("\n",debugstack(3,5,0))}
	local info=stack[1]
		local file,line,func=tostringall(strsplit(":",info))

		local r,g,b=C.Yellow()
		_G.DEFAULT_CHAT_FRAME:AddMessage(
			format("Trace\nWhere: %s:%s%s",self:Colorize(file,'azure'),self:Colorize(line,'red'),self:Colorize(func,'orange')) ..
			format("\nWhat: "..fmt,tostringall(...)),
			r,g,b)
	if (ft) then
		print "Full stack dump"
			for i,info in ipairs(stack) do
				print (format("Stack: %d. %s",i,self:Colorize(info,'green')))
			end
			print("--------------")
		end
end
function mix:Long(msg) C:OnScreen('Yellow',msg,20) end
function mix:Onscreen_Orange(msg) C:OnScreen('Orange',msg,2) end
function mix:Onscreen_Purple(msg) C:OnScreen('Purple',msg,8) end
function mix:Onscreen_Yellow(msg) C:OnScreen('Yellow',msg,1) end
function mix:Onscreen_Azure(msg) C:OnScreen('Azure',msg,1) end
function mix:Onscreen_Red(msg) print("calling C") C:OnScreen('Red',msg,1) end
function mix:Onscreen_Green(msg) C:OnScreen('Green',msg,1) end
function mix:OnScreen(color,...) C:OnScreen(color,strjoin(' ',tostringall(...))) end
function mix:TimeToStr(time) -- Converts time data to a string format
	local p,s,m,h;
	if (not time) then
		return ("0:00")
	end
	if (time < 0) then
		time=abs(time)
		p='-'
	else
		p=''
	end
	s = floor(mod(time, 60));
	m = floor(time/ 60);
	if (m > 59) then
		h=floor(m/60)
		m=floor(mod(m,60))
	end
	if (h) then
		return format("%s%d:%02d:%02d",p,h,m,s)
	else
		return format("%s%d:%02d",p,m,s)
	end
end

function mix:getColorTable()
	return C
end
lib.emptytable={false,false}
lib.itemcache=lib.itemcache or
	setmetatable({miss=0,tot=0},{
		__index=function(table,key)
			if (not key) then return lib.emptytable end
			if (key=="miss") then return 0 end
			if (key=="tot") then return 0 end
			local p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p99,p100=GetItemInfo(key)
			if (p2) then
				if (table.I) then
					p99=table.I:GetItemLevelUpgrade(table.I:GetUpgradeID(p2))
				else
					debug("No libiteminfo")
					p99=0
				end
				p100=p4+p99
				rawset(table,p2,{p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p2,p3,[99]=p99,[100]=p100})
			else
				return lib.emptytable
			end
			table.miss=table.miss+1
			return table[p2]
		end

	})
function mix:GetCachingGetItemInfo()
	do
		local cache=lib.itemcache
		wipe(cache)
		cache.I=LibStub("LibItemUpgradeInfo-1.0",true)
		return
		function(itemlink,index)
--			if (tonumber(itemlink)) then
--				if (tonumber(index)) then
--					if (index==99) then return 0 end
--					if (index==100) then index=4 end
--					return select(index,GetItemInfo(itemlink))
--				else
--					return GetItemInfo(itemlink)
--				end
--			end
			cache.tot=cache.tot+1
			if (index) then
				return cache[itemlink][index]
			else
				return unpack(cache[itemlink])
			end
		end
	end
end
function mix:GetCacheStats()
	local c=lib.itemcache
	local h=c.tot-c.miss
	local perc=( h>0) and h/c.tot*100 or 0
	return c.miss,h,perc
end
-- In case of upgrade, we need to redo embed for ALL Addons
-- This function get called on addon creation
-- Anything I define here is immediately available to addon code
function lib:Embed(target)
	--[===[@debug@
	debug("Embedding " .. MAJOR_VERSION .. "." .. MINOR_VERSION .. " into " .. target.name)
	--@end-debug@]===]
	-- Info from TOC
	local v=GetAddOnMetadata(tostring(target),"version")
	v=v or '0'
	target.tocversion=v
	local version,revision=v:match("([^$ ]*) *(.*)")
	target.version=version or "0"
	local title=target.name or target.fullname
	if (version:sub(1,1)=='@') then
		version=GetAddOnMetadata(title,'X-Version')
	end
	if (revision:sub(1,1)=='@') then
		revision='Development'
	end
	target.version=version or "0.0.1"
	target.revision=revision or 'Development'
	target.prettyversion=format("%s (Revision: %s)",tostringall(target.version,target.revision))
	target.numericversion=versiontonumber(v)
	target.title=GetAddOnMetadata(title,"title") or 'No title'
	target.notes=GetAddOnMetadata(title,"notes") or 'No notes'
	-- Setting sensible default for mandatory fields
	target.ID=GetAddOnMetadata(title,"X-ID") or (target.name:gsub("[^%u%d]","") .. "XXXX"):sub(1,3)
	target.DATABASE=GetAddOnMetadata(title,"X-Database") or "db" .. target.ID
	--[===[@debug@
	debug("Info for",target.name,'(',target.ID,')',target.DATABASE,GetAddOnMetadata(title,"X-Database"))
	--@end-debug@]===]
	LibStub("AlarLoader-3.0"):GetPrintFunctions(title,target)
	-- Standard Mixins
	for name,method in pairs(mix) do
			target[name] = method
	end
	target._Apply=target._Apply or {}
	target._Apply._handler=target
	setmetatable(target._Apply,varmeta)
	-- virtual methods, they can be ovverriden
	-- versioning is not important, because virtual methods are always nop
	for name,_ in pairs(virt) do
			target[name]=target[name] or nop
	end
	target.registry=target.registry or {}
	local r=target.registry
	for _,subtable in pairs{'events','hooks','commands','options','icommands'} do
			r[subtable]=r[subtable] or {}
	end
	target.org=target.org or {}
	target.coroutines=target.coroutines or {}
	lib.mixinTargets[target] = true
	if (me == "AlarShared") then
		local as=LibStub("AceAddon-3.0"):GetAddon("AlarShared",true)
		if (as) then as:LoadOptions() end
	end
end


----- New Global Function, I check if someone already defined then
if (not string.capitalize) then
		function string.capitalize(stringa)
				return string.gsub(strlower(stringa),
								"%w",function (s) return strupper(s) end,1)
		end
end
if (not _G.capitalize) then
		_G.capitalize=string.capitalize
end
if (not _G.table.kpairs) then
		function _G.table.kpairs(t,f)
			local a = {}
			for n in pairs(t) do table.insert(a, n) end
			table.sort(a, f)
			local i = 0      -- iterator variable
			local iter = function ()   -- iterator function
				i = i + 1
				if a[i] == nil then
						return nil
				else
						local k=a[i]
						a[i]=nil -- Should optimize memory usage
						return k, t[k]
				end
			end
			return iter
		end
end
if (not _G.kpairs) then
		_G.kpairs=table.kpairs
end
-------------------------------------------------------------------------------
-- ScheduleLeaveCombatAction Port
-- Shamelessly stolen from Ace2
-------------------------------------------------------------------------------
function mix:CancelAllCombatSchedules()
	local i = 0
	while true do
		i = i + 1
		if not combatSchedules[i] then
			break
		end
		local v = combatSchedules[i]
		if v.self == self then
			v = del(v)
			table.remove(combatSchedules, i)
			i = i - 1
		end
	end
end


do
	local tmp = {}
	local doaftercombataction
	function doaftercombataction()
		for i, v in ipairs(combatSchedules) do
			tmp[i] = v
			combatSchedules[i] = nil
		end
		debugEnable(true)
		for i, v in ipairs(tmp) do
			local func = v.func
			if func then
				local success, err = pcall(func, unpack(v, 1, v.n))
				if not success then geterrorhandler()(err:find("%.lua:%d+:") and err or (debugstack():match("(.-: )in.-\n") or "") .. err) end
			else
				local obj = v.obj or v.self
				local method = v.method
				debug("Calling",method)
				local obj_method = obj[method]
				if obj_method then
					local success, err = pcall(obj_method, obj, unpack(v, 1, v.n))
					if not success then geterrorhandler()(err:find("%.lua:%d+:") and err or (debugstack():match("(.-: )in.-\n") or "") .. err) end
				end
			end
			tmp[i] = del(v)
		end
	end
	lib.frame:SetScript("OnEvent",nil)
	lib.frame:RegisterEvent("PLAYER_REGEN_ENABLED")
		lib.frame:SetScript("OnEvent",doaftercombataction)
end

function mix:ScheduleLeaveCombatAction(method, ...)
	local style = type(method)
	if style == "string" and type(self[method]) ~= "function" then
		debug("Cannot schedule a combat action to method %q, it does not exist", method)
	elseif style == "table" then
		local func = (...)
		if type(method[func]) ~= "function" then
			debug("Cannot schedule a combat action to method %q, it does not exist", func)
		end
	end

	if not InCombatLockdown() then
		local success, err
		if type(method) == "function" then
			success, err = pcall(method, ...)
		elseif type(method) == "table" then
			local func = (...)
			success, err = pcall(method[func], method, select(2, ...))
		else
			success, err = pcall(self[method], self, ...)
		end
		if not success then print(method,err) end
		return
	end
	local t
	local n = select('#', ...)
	if style == "table" then
		t = new(select(2, ...))
		t.obj = method
		t.method = (...)
		t.n = n-1
	else
		t = new(...)
		t.n = n
		if style == "function" then
			t.func = method
		else
			t.method = method
		end
	end
	t.self = self
	table.insert(combatSchedules, t)
end
function mix:_iCmd(info,args)

end
function mix:_SwitchDebug(info,p)
	local p=p or ''
	p=strlower(p)
	local target=tostring(self) or ''
	local a=LibStub("AlarLoader-3.0")
	local status
	if (p=='on') then pp("p = on") status=true end
	if (p=='off') then pp("p = off") status = false end
	if (p=='on' or p =='off') then
		self:Print("Debug was",self:PrintBoolean(a:GetDebug(target)))
		a:SetDebug(target,status)
	end
	self:Print("Debug is",self:PrintBoolean(a:GetDebug(target)))
end
function mix:ToggleDebug(switch)
	self:_SwitchDebug('UserRequest',switch and 'on' or 'off')
end
function mix:Void(...)
	if select('#',...) > 0 then print(...) end
end
function mix:Test(...)
	print(GetTime(),'Test',...)
	return "Test Ran"
end
local function Sink(durata)
	for i=1,durata do

	end
end
local function coclear(rc,...)
	if (rc) then
		return ...
	else
		return nil
	end
end
function mix:CoroutineCreate(name,method)
	print("Creating coroutine",name,"for",method)
	local c=self.coroutines
	if (c[name]) then return c[name] end
	local func
	do
		local addon=self
		local method=self[method]
		function func(...)
			method(addon,...)
		end
	end
	c[name]=coroutine.create(func)
	return c[name]
end
function mix:CoroutineExecute(name,method,tick,...)
	self:CoroutineCreate(name,method)
	self:CoroutineStart(name,tick,...)
end
function mix:CoroutineRun(name,...)
	local co=self.coroutines[name]
	if (type(co)=="thread" and coroutine.status(co) ~= "dead") then
		return(coclear(coroutine.resume(co,...)))
	else
		return nil
	end
end
function mix:CoroutineStart(name,tick,...)
	tick=tonumber(tick) or 1
	local co=self.coroutines[name]
	if (not self:IsEventScheduled(name)) then
		if (type(co)=='thread') then
			self:ScheduleRepeatingEvent(name,co,...)
		else
			print(name,'is not a coroutine')
		end
	end
end

function mix:CoroutinePause(name)
	if (self:IsEventScheduled(name)) then
		self:CancelScheduledEvent(name)
	end
end
function mix:Popup(msg,timeout)
	msg=msg or "Something strange happened"
	StaticPopupDialogs["AMO_POPUP"] = {
	text = TEXT(msg),
	button1 = TEXT("OK"),
	showAlert = 1,
	timeout = timeout or 60,
	exclusive = 1,
	whileDead = 1,
	interruptCinematic = 1
	};
	StaticPopup_Show("AMO_POPUP");
end



--- reembed routine
for target,_ in pairs(lib.mixinTargets) do
	lib:Embed(target)
end

