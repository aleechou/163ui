local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local MAJOR_VERSION = "AlarFrames-3.0"
local MINOR_VERSION = 1000
local me, ns = ...
local toc=select(4,GetBuildInfo())
local pp=print
--[[
Name: AlarFrames-3.0.lua
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
if (not LibStub) then
		error("Couldn't find LibStub. Please reinstall " .. MAJOR_VERSION )
end
local lib,old=LibStub:NewLibrary(MAJOR_VERSION,MINOR_VERSION)
if (not lib) then
		debug("Already loaded a newer or equal version of " .. MAJOR_VERSION)
		return -- Already loaded
end
if (old) then
		debug(format("Upgrading %s from %s to %s",MAJOR_VERSION,old,MINOR_VERSION))
end
debugEnable(false)
local L=LibStub("AceLocale-3.0"):GetLocale('AlarShared',true)
-- End standard header stuff
local AceTimer=LibStub("AceTimer-3.0",true)
local C=LibStub('AlarCrayon-3.0'):GetColorTable()
local L=LibStub("AceLocale-3.0"):GetLocale('AlarShared',true)
local _G=_G
local lib=lib --#lib
local new, del
do
	local list = setmetatable({}, {__mode="k"})
	function new()
		local t = next(list)
		if t then
			list[t] = nil
			return t
		else
			return {}
		end
	end
	function del(t)
		setmetatable(t, nil)
		for k in pairs(t) do
			t[k] = nil
		end
		list[t] = true
	end
end
lib.mix=lib.mix or {}
local mix=lib.mix --# Mix
lib.mixinTargets = lib.mixinTargets or {}
lib.frames=lib.frames or setmetatable({},{__index={}})
lib.CastPanels=lib.CastPanels or {}
--local C=LibStub("AlarCore-3.0").mix.C -- color system
local buttonmetatable={
		x=0,
		y=0,
		position=-90,
		clamped=true,
		custom=false,
}
local framemetatable={
}
lib.texture=lib.texture or UIParent:CreateTexture()
lib.fontstring=lib.fontstring or UIParent:CreateFontString()
-- Backdrops definition
lib.Backdrops=setmetatable({
dialog = {
		bgFile="Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile="Interface\\DialogFrame\\UI-DialogBox-Border",
		tile=true,
		tileSize=32,
		edgeSize=32,
		insets={bottom=5,left=5,right=5,top=5}
},
bubble={
	bgFile = "Interface\\Tooltips\\ChatBubble-Background",
	edgeFile = "Interface\\Tooltips\\ChatBubble-BackDrop",
	tile = true, tileSize = 32, edgeSize = 32,
	insets = { left = 32, right = 32, top = 32, bottom = 32 }
},
party = {
		bgFile="Interface\\CharacterFrame\\UI-Party-Background",
		edgeFile="Interface\\CharacterFrame\\UI-Party-Border",
		tile=true,
		tileSize=32,
		edgeSize=32,
		insets={bottom=32,left=32,right=32,top=32}
},
tooltip = {
		bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
		tile=true,
		tileSize=16,
		edgeSize=16,
		insets={bottom=5,left=5,right=5,top=5}
},
border = {
		bgFile="",
		edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
		tile=true,
		tileSize=16,
		edgeSize=16,
		insets={bottom=5,left=5,right=5,top=5}
},
tutorial = {
		bgFile="Interface\\TutorialFrame\\TutorialFrameBackground",
		edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
		tile=true,
		tileSize=16,
		edgeSize=16,
		insets={bottom=7,left=7,right=7,top=7}
},
background = {
		bgFile="Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile="",
		tile=false,
		tileSize=8,
		edgeSize=8,
		insets={bottom=3,left=3,right=3,top=3}
},
minimal = {
		bgFile="Interface\\TutorialFrame\\TutorialFrameBackground",
		edgeFile="Interface\\Tooltips\\UI-Tooltip-Border",
		tile=false,
		tileSize=8,
		edgeSize=8,
		insets={bottom=3,left=3,right=3,top=3}

}
},
{__index=function(table) return rawget(table,'tutorial') end}) -- default backdrop
setmetatable(lib,{
		__index=function(table,key)

				local f=rawget(table,key:gsub("Frame",""))
				if (f) then
						rawset(table,key,f)
				end
				return f
		end
})
local Backdrops=lib.Backdrops
local SetBackdrop
--[[
Calculates the offset in a squared multitexture

--]]
function lib:GetTexCoord(typ,splitter)
		typ=typ or 1
		splitter=splitter or 8
		local row,col=self:Split(typ,splitter) -- 8 icons each row
		return 1/splitter*col,1/splitter*(col+1),1/splitter*row,1/splitter*(row+1)
end
function lib:SetTexCoord(f,typ,splitter)
		f:SetTexCoord(unpack({self:GetTexCoord(typ,splitter)}))
end
lib.SetPoiiOffset=lib.SetTexCoord
lib.ScrollPanelMethods={
SetText=function(frame,stringa)
				frame.testo:SetText(tostring(stringa))
				frame.child:SetHeight(frame.testo:GetHeight())
				frame:SetVerticalScroll(0)
				frame.child:SetWidth(frame:GetWidth())
		end,
SetWidth=function(frame,width,...)
		frame.org.SetWidth(frame,width)
		frame.child:SetWidth(frame:GetWidth())
end,
SetTextColor=function(frame,...) frame.testo:SetTextColor(...) end,
SetFormattedText=function(frame,...) frame.testo:SetFormattedText(...) end,
SetJustifyH=function(frame,...) frame.testo:SetJustifyH(...) end,
SetJustifyV=function(frame,...) frame.testo:SetJustifyV(...) end,
SetFontObject=function(frame,font,...) frame.testo:SetFontObject(font) end,
}
function lib:CreateScrollPanel(nome,title)
		local frame=CreateFrame("ScrollFrame",nome,UIParent,"UIPanelScrollFrameTemplate")
		local child=CreateFrame("EditBox",nil,frame)
		child:SetAutoFocus(false)
		child:SetMultiLine(true)
		child:EnableKeyboard(false)
		child:EnableMouse(false)
		child:SetFontObject("GameFontNormalSmall")
		child:SetTextInsets(5,5,0,0)
		frame:SetScrollChild(child)
		frame.child=child
		frame.testo=child
		frame.org={}
		for method,func in pairs(self.ScrollPanelMethods) do
				frame.org[method]=frame[method]
				frame[method]=func
		end
		frame:SetScript("OnShow",function(frame) frame.child:SetWidth(frame:GetWidth()) end )
		frame:SetScript("OnSizeChanged",function(frame) frame.child:SetWidth(frame:GetWidth()) end )
		frame:Show()
		return frame

end

function lib:SetBackdrop(f,tipo,alpha)
		if (not f) then
				return
		end
		if (not tipo and f.storage) then
				tipo=f.storage.Backdrop
		end
		if (type(tipo) == "table") then
				pcall(f.SetBackdrop,f,tipo)
		elseif (type("tipo") == "string") then
				pcall(f.SetBackdrop,f,Backdrops[tipo])
		else
				f:SetBackdrop(nil)
		end
		if (f.storage) then
				f.storage.Backdrop=tipo
		end
		if (alpha) then
				local r,g,b,a=f:GetBackdropColor()
				f:SetBackdropColor(r,g,b,alpha)
		end
		return f:GetBackdrop()
end
-------------------------------------------------------------------------------
-- Transitional compatibility with AlarLib-2.0
-------------------------------------------------------------------------------
local OnDragStart,OnDragStartNoAlt,OnDragStop,OnDragInfoOn,OnDragInfoOff,savepanel,restorepanel
local ClipChildren,FitChildren,ScanChildren,AddScript
function AddScript(frame,hook,script)
		local oldscript=frame:GetScript(hook)
		frame:EnableMouse(true)
		if (oldscript) then
				frame:SetScript(hook,function(...) oldscript(...) script(...) end)
		else
				frame:SetScript(hook,function(...) script(...) end)
		end
end
function ClipChildren(frame)
		ScanChildren(frame,
										function(frame,v,insideform)
												if (type(v.compact) == "nil") then
														if (insideform) then
																v:Show()
														else
																v:Hide()
														end
												end
										end
								)
end
function FitChildren(frame)
		ScanChildren(frame,
										function(frame,v,insideform)
												if (not insideform) then
														frame:SetHeight(v:GetTop()-v:GetBottom() + 10)
														frame:SetWidth(v:GetRight()-v:GetLeft() + 10)
												end
										end
								)
end
function ScanChildren(frame,op)
		frame.lastclip=tonumber(frame.lastclip) or 0
		if (GetTime() - frame.lastclip < 0.5) then
				return
		end
		frame.lastclip=GetTime()
		local t=frame:GetTop()
		local b=frame:GetBottom()
		if (tonumber(t) and tonumber(b)) then
				for i,v in ipairs({frame:GetChildren()}) do
						if (not v.ignore) then
								local vt=v:GetTop()
								local vb=v:GetBottom()
								if (vt and vb) then
										if (vt <= t and vb >= b) then
												op(frame,v,true)
										else
												op(frame,v,false)
										end
								end
						end
				end
		end
		for i,v in ipairs({frame:GetRegions()}) do
				if (not v) then
						break
				end
				if (not v.ignore) then
						local vt=v:GetTop()
						local vb=v:GetBottom()
						if (vb and vt) then
								if (vt <= t and vb >= b) then
										op(frame,v,true)
								else
										op(frame,v,false)
								end
						end
				end
		end
end


function OnDragStart(this,button,...)
		if (IsAltKeyDown()) then
				OnDragStartNoAlt(this,button,...)
		else
				lib:TTOpen(this,button,"Moving....")
				this:StartMoving()
		end
end
function OnDragStartNoAlt(this,button,...)
		lib:TTOpen(this,button,"Sizing....")
		this.Sizing=true
		this:StartSizing("BOTTOMRIGHT")
end
function OnDragInfoOn(old,this,button)
		if (IsAltKeyDown()) then
				lib:TTOpen(this,"Ready to resize")
		else
				lib:TTOpen(this,C("Right-click and drag:",'green') .. " move\n" .. C("Alt-Right-Click and drag:",'green') .. "resize")
		end
		if (type(old) == "function") then old(this,button) end
end
function OnDragInfoOff(old,this,button)
		lib:TTFade()
		if (type(old) == "function") then old(this,button) end
end
function OnDragStop(this,...)
		lib:TTFade()
		this:StopMovingOrSizing();
		this.lastclip=0 -- forcing clip
		if (this.Sizing) then
				if (not this.IsCompact) then
						this:ClipChildren()
				end
				this.Sizing=false
		end
		if (type(this.storage)=="table") then
				savepanel(this)
		end
		local f=this:GetParent()
		if (f) then
				if (f:GetName() ~= "UIParent" and not InCombatLockdown()) then
						this:ClearAllPoints()
						this:SetPoint("TOPLEFT",
								this:GetLeft()-f:GetLeft(),
								this:GetTop()-f:GetTop())
				end
		end
end
local OnDragStopParent
function OnDragStopParent(this,...)
		OnDragStop(this:GetParent(),'parent')
end
local OnDragStartParent
function OnDragStartParent(this)
		OnDragStart(this:GetParent(),'parent')
end
local OnDragStartParentNoAlt
function OnDragStartParentNoAlt(this)
		OnDragStartNoAlt(this:GetParent(),'parent')
end

function restorepanel(f)
		if (f and f.storage and f.storage.Manage) then
				local rc,message
				if (type(f.storage.Point)=="table") then
						local p=f.storage.Point
						if (not p.anchor) then
								p.anchor=p[1] or "CENTER"
								p.parent=f:GetParent()
								if (p.parent) then
										p.parent=p.parent:GetName()
								else
										p.parent='UIParent'
								end
								p.relanchor=p[2] or "CENTER"
								p.x=p[3] or 0
								p.y=p[4] or 0
								p[1]=nil
								p[2]=nil
								p[3]=nil
								p[4]=nil
						end
						local parent=getglobal(p.parent) or UIParent
						rc,message=pcall(function(f,p)
								f:SetPoint(p.anchor,parent,p.relanchor,p.x,p.y)
								end,f,p)
				end
				if (f.storage.Width) then
						if (f.storage.MinWidth) then
								f:SetWidth(max(f.storage.Width,f.storage.MinWidth))
						else
								f:SetWidth(f.storage.Width)
						end
				end
				if (f.storage.Height) then
						if (f.storage.MinHeight) then
								f:SetHeight(max(f.storage.Height,f.storage.MinHeight))
						else
								f:SetHeight(f.storage.Height)
						end
				end
				f:SetScale(f.storage.Scale)
				f:SetBackdrop(Backdrops[f.storage.Backdrop])
		else
				f:SetPoint("CENTER")
		end
end
function savepanel(f)

		if (not f or not f.storage) then return end
		f.storage.Scale=f:GetScale()
		debug("Saving " .. f:GetName())
		local anchor,parent,relanchor,x,y=f:GetPoint(1)
		if (parent) then
				parent=parent:GetName()
		else
				parent=nil
		end
		f.storage.Point=nil
		f.storage.Point={anchor=anchor,parent=parent,relanchor=relanchor,x=x,y=y}
		f.storage.Width=f:GetWidth()
		f.storage.Height=f:GetHeight()
		f.storage.Manage=1
		if (f.storage.MinHeight) then
				f:SetHeight(max(f.storage.Height,f.storage.MinHeight))
		end
		if (f.storage.MinWidth) then
				f:SetWidth(max(f.storage.Width,f.storage.MinWidth))
		end
end


function lib:CreateMiniPanel(nome,titolo)
		return self:CreatePanel(nome,{
				Cancel=true,
				Save=true,
				backdrop='minimal',
				Rescale=false,Resize=true,Config=false,
				Header=titolo,
				Width=300,
})
end
function lib:CreateTrackerPanel(nome,titolo)
		return self:CreatePanel(nome,{
				noCancel=1,
				noSave=1,
				backdrop='none',
				noRescale=true,
				noResize=true,
				noConfig=true,
				noMin=true,
				MiniHeader=titolo,
				Width=250,
})
end
function lib:CreatePanel(nome,p,show)
		p=p or {}
		p.name=nome or "Panel" .. math.ceil(time())
		local f=self:Create("Panel",p.name,UIParent)
		self:SetBackdrop(f,p.backdrop)
		f:SetParent(UIParent)
		f:SetHeight(p.Height or 400)
		f:SetWidth(p.Width or 400)
		f:SetPoint("CENTER")
		if (p.minsize) then
				self:PanelMinSize(f,f:GetWidth(),f:GetHeight())
		end
		f:SetScale(0.8) -- My default scale
		self:PanelRestore(f) -- If it was never saved, Panel restore does nothing
		-- I DONT save panel now, because the creation process could be change it
		-- and I dont want to create false defaults
		-- X Button

		f.rightmost=0
		f.leftmost=0
		local bx
		if (p.X or not p.noX) then --default: yes
				local b,x,y=self:AddXButton(f)
				f.rightmost=f.rightmost - 30
				bx=b
		end
		if (p.Min or not p.noMin) then --default: yes
				local b,x,y=self:AddMinButton(f)
				f.rightmost=f.rightmost - b:GetWidth() -2
		end
		if (p.Config and not p.noConfig) then --default: no
				local b,x,y=self:AddConfigButton(f)
				f.rightmost=f.rightmost - b:GetWidth() -2
		end
		if (p.Close and not p.noClose ) then --default: no
				local b,x,y=self:AddCloseButton(f)
				if (type(p.closefunc) == "function") then
						b:SetScript("OnClick",p.closefunc)
				end
				b.compact=true
				f.BtClose=b
		end
		if (p.Save or not p.noSave) then --default yes
				local b,x,y=self:AddSaveButton(f)
				if (type(p.savefunc) == "function") then
						b:SetScript("OnClick",p.savefunc)
				end
				b.compact=true
				f.BtSave=b
		end
		if (p.Cancel or not p.noCancel) then --default yes
				local b,x,y=self:AddCancelButton(f)
				if (type(p.cancelfunc) == "function") then
						b:SetScript("OnClick",p.cancelfunc)
				end
				b.compact=true
		end
		if (p.Rescale or not p.noRescale) then --default: true
				local b,x,y=self:AddRescaleButton(f)
				b.compact=true
				f.leftmost=f.leftmost+b:GetWidth()+2
		end
		if (p.Help and not p.noHelp) then --default: no
				if (p.Helptext) then
						self:AttachHelp(f,p.Helptext)
				end
		end
		if (p.Movable and not p.noMovable) then --default: no
				self:MakeMovable(p.name,p.noTip)
		end
		if (p.Resize or not p.noResize) then -- default: yes
				self:AddResizer(f)
		end
		if ((p.Header or not p.noHeader) and not p.MiniHeader) then
				self:AddHeader(f,p.Header)
		end
		if (p.MiniHeader and  not p.noMiniHeader) then
				self:AddMiniHeader(f,p.MiniHeader)
				if (bx) then
						bx:SetPoint("TOPRIGHT",5,5)
				end
		end
		if (show) then
				f:Show()
		end
		if (p.db) then
				self:AttachStorage(f,p.db)
		end
		f:SetScript("OnSizeChanged",ClipChildren)
		return f
end
local formsdb={['*']=
								{
										Scale=1.0,
										Point={
												anchor="CENTER",
												relanchor="CENTER",
												x=0,
												y=0
										},
								}
}
function lib:GetDefault()
		return formsdb
end
function lib:CreateTargetPanel(nome,show,unit)
		local f=self:Create("Panel",nome,UIParent)
		self:SetBackdrop(f,"border")
		f:SetParent(UIParent)
		f:SetHeight(37)
		f:SetWidth(94)
		self:AddXButton(f)
		f.button=self:AddUnitButton(f,"target",unit,unit,0,-5)
		f.SetUnit=(function(this,unit)
				this.button:SetUnit(unit)
				end)
end
function lib:CreateButtonPanel(nome,show,message,func)
		local f=self:Create("Frame",nome,UIParent)
		local x=0
		local y=0
		self.CastPanels[f]=1
		self:SetBackdrop(f,nil)
		f:SetParent(UIParent)
		f:SetPoint("CENTER",UIParent,"CENTER",x,y)
		f:SetHeight(64)
		f:SetWidth(64)
		local b=self:AddXButton(f)
		if (type(func) ~= "function") then
				func=function(...) print(...) end
		end
		if (type(message) ~= "string") then
				message="Click!"
		end
		b=self:AddButton(f,"",message,-10,-18)
		self:TTAdd(b,message)
		f.Button=b
		f.SetText=function(this,...) f.b:SetText(...) end
		b:SetHeight(32)
		b:SetWidth(64)
		b:SetScript("OnClick",function(...)
						func(...)
						this:GetParent():Hide()
						end
		)
		f.Pop=function(this,delay)
				delay=delay or 30
				local x=0
				for p in pairs(self.CastPanels) do
						if (p:IsShown() and p ~= this) then
								x=x+64
						end
				end
				this:SetPoint("CENTER",UIParent,"CENTER",x,0)
				this:Show()
				UIFrameFadeOut(this,delay,1.0,0.5)
				if (AceTimer) then AceTimer:ScheduleTimer(function() this:Hide() this:SetAlpha(1.0) end,delay) end
		end
		if (show) then
				f:Pop()
		end
		return f
end
function lib:CreateCastPanel(nome,show,spell)
		local f=self:Create("Frame",nome,UIParent)
		local x=0
		local y=0
		self.CastPanels[f]=1
		self:SetBackdrop(f,nil)
		f:SetParent(UIParent)
		f:SetPoint("CENTER",UIParent,"CENTER",x,y)
		f:SetHeight(48)
		f:SetWidth(64)
		local b=self:AddXButton(f)
		b=self:AddCastButton(f,"",5,-5)
		f.SpellButton=b
		b:SetScript("PostClick",function(this)
					this:GetParent():Hide()

		end)
		if (spell) then
				b:SetSpell(spell)
		end
		f.SetSpell=function(this,t) this.SpellButton:SetSpell(t) end
		f.Pop=function(this,delay)
				delay=delay or 30
				local x=0
				for p in pairs(self.CastPanels) do
						if (p:IsShown() and p ~= this) then
								x=x+64
						end
				end
				this:SetPoint("CENTER",UIParent,"CENTER",x,0)
				this:Show()
				UIFrameFadeOut(this,delay,1.0,0.5)
				if (AceTimer) then AceTimer:ScheduleTimer(function() this:Hide() this:SetAlpha(1.0) end,delay) end
		end
		if (show) then
				f:Pop()
		end
		return f
end
function lib:AttachStorage(frameObject,db)
		local f=self:IsFrame(frameObject)
		if (f) then
				f.storage=db
				restorepanel(f)
		end
end
function lib:AttachHelp(f,helptext)
	--UiFrameFadeIn(f,secondi,Alfada,Alfaa)
	helptext=helptext or ""
	helptext=tostring(helptext)
	if (type(f) == "string") then
		f=_G[f]
	end
	if (not f) then
		self:Print(tostring(f) .. " is not a global name")
		return
	end
	if (type(f) ~= "table") then
		self:Print(tostring(f) .. " is not a frame")
		return
	end
	local canoperate=f:IsObjectType("Frame")
	if (canoperate) then
		local b=self:FrameAddHelpButton(f)
		b:SetPoint("TOPLEFT",f,"TOPRIGHT",-5,17)
		b:Show()
		self:TTAdd(b,helptext,true)
	end
end

function lib:Create(tipo,nome,frameobject,template)
		local frameobject=frameobject or UIParent
		local isPanel
		if (tipo=="Panel") then
				isPanel=true
				tipo="Frame"
		end
		local f,r=_G[nome],nil
		if (not f) then
				r,f=pcall(CreateFrame,tipo,nome,frameobject,template)
				if (not r) then
						print(tipo,nome,frameobject,template)
						self:Error("Error AlarFrames: " .. f .. "-" ..tostring(nome))
						return nil
				end
		end
		f.Loaded=true
		f.objectname=nome
		f.ClipChildren=ClipChildren
		f.FitChildren=FitChildren
		f.AddScript=AddScript
		return f
end

function lib:AddButton(f,tipo,testo,x,y,moretemplate)
		moretemplate = moretemplate or ''
		tipo=tipo or 'AMO'
		testo=testo or tipo
		tipo=string.capitalize(tipo)
		local fname=f:GetName() .. "Bt" .. tipo
		local b=self:Create("Button",fname,f,"UIPanelButtonTemplate" .. moretemplate)
		local width=0
		b:SetText(testo)
		width=b:GetTextWidth() + 5 -- Allow for button border
		if (width < 32) then
				width=32
		elseif (width >200) then
				width=200
		end
		b:SetHeight(32)
		b:SetFrameLevel(10)
		b:SetWidth(width)
		local fs=nil
		local function closefunc(this)
				local a=this:GetParent()
				if (a) then
						a:Hide()
				end
		end
		if (tipo=="Close") then
				self:TTAdd(b,"Close this panel")
				b:SetPoint("BOTTOM",f,"BOTTOM",0,10)
				b:SetScript("PostClick",closefunc)
		elseif (tipo == "Cancel") then
				self:TTAdd(b,"Exit without saving your changes")
				b:SetPoint("BOTTOMLEFT",f,"BOTTOMLEFT",30,15)
				b:SetScript("PostClick",closefunc)
		elseif (tipo=="Save") then
				self:TTAdd(b,"Save your changes and exit")
				b:SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT",-30,15)
				b:SetScript("PostClick",closefunc)
		else
				local x = x or 0
				local y = y or 0
				b:SetPoint("TOPLEFT",x,y)
		end
		b:Show()
		return b,self:GetXY(f,b)
end
local function enhance(this,c,v)
		this:SetBackdropColor(c.r,c.g,c.b,v)
end
function lib:SetClick(f,func,color,alpha)
		self:argCheck(f,1,"table","string")
		self:argCheck(func,2,"function","nil")
		self:argCheck(alpha,4,"number","nil")
		alpha=alpha or 0.5
		f=self:IsFrame(f)
	local highlight = f:CreateTexture(nil, "HIGHLIGHT")
	highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	highlight:SetBlendMode("ADD")
	highlight:SetAllPoints(f)
		f:EnableMouse(true)
		if (func) then
				f:SetScript("OnMouseUp",func)
		end
end
function lib:BOTH(f,x)
		x=x or 5
		if (type(f)=="string") then
				f=getglobal(f)
		end
		if (f) then
				local a1,p,a2,x,y=f:GetPoint()
				f:SetPoint("LEFT",p,"LEFT" ,x,y)
				f:SetPoint("RIGHT",p,"RIGHT" ,-x,y)
		end
end
function lib:RIGHT(f,themost)
		if (type(f)=="string") then
				f=getglobal(f)
		end
		if (f) then
				local a1,p,a2,x,y=f:GetPoint()
				if (themost) then
						x=-10
				else
						x=x-p:GetWidth()
				end
				a1=a1:gsub("LEFT","RIGHT")
				a2=a2:gsub("LEFT","RIGHT")
				f:ClearAllPoints()
				f:SetPoint(a1,p,a2 ,x,y)
		end
end
function lib:BOTTOM(f)
		if (type(f)=="string") then
				f=getglobal(f)
		end
		if (f) then
				local a1,p,a2,x,y=f:GetPoint()
				if (themost) then
						y=y+10
				else
						y=y+p:GetHeight()
				end
				a1=a1:gsub("TOP","BOTTOM")
				a2=a2:gsub("TOP","BOTTOM")
				f:SetPoint(a1,p,a2 ,x,y)
		end
end
function lib:Move(f,x,y,rightalign)
		if (type(f)=="string") then
				f=getglobal(f)
		end
		if (f) then
				local a1,p,a2,ox,oy=f:GetPoint()
				f:SetPoint(a1,p,a2 ,x or ox,y or oy)
		end
end
function lib:AddCloseButton(f)
		return self:AddButton(f,"Close")
end
function lib:AddSaveButton(f)
		return self:AddButton(f,"Save")
end
function lib:AddCancelButton(f)
		return self:AddButton(f,"Cancel")
end
function lib:TTAdd(frame,message,autohide)
		frame=self:IsFrame(frame,true)
		if (frame) then
				if (message) then
						frame:EnableMouse(true)
						frame:SetScript("OnEnter",
														function(...)
																frame:SetAlpha(1)
																self:TTOpen(...)
														end)
						frame:SetScript("OnLeave",
														function(...)
														self:TTClose(...)
																if (autohide) then
																		frame:SetAlpha(0)
																end
														end)
						frame.Tooltip=tostring(message)
				else
						frame:SetScript("OnEnter",nil)
						frame:SetScript("OnLeave",nil)
				end
		end
end

function lib:AddLabel(f,nome,testo,x,y)
		local width
		local fname=(f:GetName() or '') .. nome
		local frame=self:Create("Frame",fname,f)
		if (type(testo) == "number") then
				width=testo
				testo=nil
		end
		frame:SetPoint("TOPLEFT",x or 0,y or 0)
		frame:SetHeight(16)
		if (not frame.Label) then
				frame.Label=frame:CreateFontString(fname .. "Label","OVERLAY","GameFontNormal")
		end
		if (testo) then
				frame.Label:SetText(testo)
				if (not width) then
						width=frame.Label:GetStringWidth()
				end
		end
		if (not width) then
				width=f:GetWidth()
		end
		frame:SetWidth(width)
		frame.Label:SetAllPoints(frame)
		frame.SetText=function(this,text) this.Label:SetText(text) end
		frame.SetFormattedText=function(this,fmt,...) this.Label:SetFormattedText(fmt,...) end
		frame.SetTextColor=function(this,r,g,b,a) this.Label:SetTextColor(r,g,b,a) end
		frame.GetText=function(this) return this.Label:GetText() end
		return frame
end

function lib:AddTitle(f,nome,testo,x,y)
		x=0
		y=y or 0
		local frame=self:AddLabel(f,nome,testo,x,y)
		frame:SetPoint("TOPRIGHT",x,y) -- So it's resized automaigcally
		frame.Label:SetJustifyH("CENTER")
		return frame
end

function lib:AddCLabel(f,nome,testo,x,y)
		local frame=self:AddLabel(f,nome,testo,x,y)
		frame.Label:SetJustifyH("CENTER")
		frame.Label:SetNonSpaceWrap(false)
		return frame
end

function lib:AddLLabel(f,nome,testo,x,y)
		local frame=self:AddLabel(f,nome,testo,x,y)
		frame.Label:SetJustifyH("LEFT")
		frame.Label:SetNonSpaceWrap(false)
		return frame
end


function lib:AddRLabel(f,nome,testo,x,y)
		local frame=self:AddLabel(f,nome,testo,x,y)
		frame.Label:SetNonSpaceWrap(false)
		frame.Label:SetJustifyH("RIGHT")
		return frame
end


function lib:AddIcon(f,tipo,texture,x,y)
		local b=f:CreateTexture((f:GetName() or '')  .. tipo .. "Icon")
		x=x or 0
		y=y or 0
		b:SetPoint("TOPLEFT",x,y)
		b:SetWidth(16)
		b:SetHeight(16)
		b:SetTexture(texture)
		--b:SetHeight(32)
		--b:SetWidth(32)
		return b
end
function lib:AddPanel(f,nome,attach,x,y)
		local width=f:GetWidth()
		x = x or 0
		y = y or 0
		attach=attach or 'none'
		attach=strupper(attach)
		local fname=f:GetName() .. nome
		local frame=self:Create("Frame",fname,f)
		self:SetBackdrop(frame,f.storage.Backdrop)
		if (attach=='LEFT') then
				frame:SetPoint("TOPRIGHT",f,"TOPLEFT",0,0)
				frame:SetPoint("BOTTOMRIGHT",f,"BOTTOMLEFT",0,0)
		elseif (attach=='TOP') then
				frame:SetPoint("BOTTOMLEFT",f,"TOPLEFT",0,0)
				frame:SetPoint("BOTTOMRIGHT",f,"TOPRIGHT",0,0)
		elseif (attach=='RIGHT') then
				frame:SetPoint("TOPLEFT",f,"TOPRIGHT",0,0)
				frame:SetPoint("BOTTOMLEFT",f,"BOTTOMRIGHT",0,0)
		elseif (attach=='BOTTOM') then
				frame:SetPoint("TOPLEFT",f,"BOTTOMLEFT",0,0)
				frame:SetPoint("TOPRIGHT",f,"BOTTOMRIGHT",0,0)
		else
				f:SetPoint("TOPLEFT",x,y)
		end
		frame:SetWidth(width)
		frame:SetHeight(100)
		return frame
end
function lib:TRACK(...)
	local event = AceLibrary("AceEvent-2.0").currentEvent
	print(event,...)
end
function lib:TTClose()
	GameTooltip:FadeOut()
end

function lib:TTFade()
	GameTooltip:FadeOut()
end
function lib:TTFormat(this,button,lmessage,rmessage)
		lmessage=lmessage or ''
		rmessage=rmessage or ''
		self:TTOpen(this,button,
				C(lmessage ..  rmessage,'green')
		)
end
function lib:TTOpen(this,button,message)
	debug('TTOpen',this,button,message)
		if (this:GetAlpha() < 0.1) then
				return
		end
		local ex=0
		if (type(message)~="string") then
				if (type(this.tooltipFunction) == "function") then
						message=this:tooltipFunction(message)
						ex=1
				elseif (type(this.tooltipText)=="string") then
						message=this.tooltipText
						ex=2
				elseif (type(this.Tooltip)=="string") then
						message=this.Tooltip
						ex=3
				else
						message=nil
						ex=4
				end
		end
		if (not message) then
				return
		end
		if (tostring(message) == "nil") then
				return
		end
	local p=this:GetParent()
	if (p and p:GetFrameStrata() == "TOOLTIP") then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT",0,-40)
				GameTooltip:SetFrameLevel(p:GetFrameLevel()-1)
		else
		GameTooltip:SetOwner(this, "ANCHOR_CURSOR",50,0)
		end
	GameTooltip:SetText(message, C.Yellow.r,C.Yellow.g,C.Yellow.b,0.9, 1)
	if ( this.tooltipRequirement ) then
		GameTooltip:AddLine(this.tooltipRequirement, "", 1.0, 1.0, 1.0);
	end
		GameTooltip:Show()

end
lib.PoiiOffsets={
MiNN=0, -- Neutral mine
MiHH=1,   -- Horde mine
MiAA=2,   -- Ally mine
GyAN=3,   -- Ally contested Graveyard
HoNN=4,   -- Neutral Home
ToNN=5,   -- Neutral Tower
ObNN=6,   -- Objective
GyNN=7,   -- Neutral Graveyard
ToAN=8,   -- Ally contested Tower
ToHH=9,   -- Horde Tower
ToAA=10,  -- Ally Tower
ToHN=11,  -- Horde Contested Tower
GyHH=12,  -- Horde Graveyard
GyHN=13,  -- Horde Contested Graveyard
GyAA=14,  -- Ally Graveyard
GmNN=16,  --Golden Mine
GmAN=17,
GmAA=18,
GmHN=19,
GmHH=20,
LmNN=21,  --Lumber Mill
LmAN=22,
LmAA=23,
LmHN=24,
LmHH=25,
BsNN=26,  --BlackSmith
BsAN=27,
BsAA=28,
BsHN=29,
BsHH=30,
FaAA=31,  --Farm
FaAN=32,
FaAA=33,
FaHN=34,
FaHH=35,
StAA=36,  --Stables
StAN=37,
StAA=38,
StHN=39,
StHH=40,
SkNN=41,  -- Skull
SkXX=42,  --Dunno...
FlAA=43,
FlHH=44,
FlNN=45,
BaAA=46,
BaAN=47,
BaHH=48,
BaHA=49,
INVI=55
}
function lib:Split(id,rowlen)
		local row=math.floor(id/rowlen);
		local col=id-(row*rowlen)
		return row,col
end
function lib:GetTexCoord(typ,splitter)
		self:argCheck(typ,1,"number","nil")
		self:argCheck(splitter,2,"number","nil")
		typ=typ or 1
		splitter=splitter or 8
		local row,col=self:Split(typ,splitter) -- 8 icons each row
		return 1/splitter*col,1/splitter*(col+1),1/splitter*row,1/splitter*(row+1)
end
function lib:SetPoiiOffset(f,typ,splitter)
		self:argCheck(f,1,"table")
		f:SetTexCoord(unpack({self:GetTexCoord(typ,splitter)}))
end
lib.SetTexCoord=lib.SetPoiiOffset

function lib:MakeParentMovable(tf)
		local f=self:IsFrame(tf,true)
		local p=f:GetParent()
		if (not p) then
				return
		end
		self:MakeMovable(p,true)
		f:SetScript("OnDragStart",OnDragStartParent)
		f:SetScript("OnDragStop",OnDragStopParent)
end
function lib:MakeMovable(tf,noinfo)
		local f=self:IsFrame(tf,true)
		if (f) then
				f.oldparent=f:GetParent()
				if (not f.FitChildren) then
						f.FitChildren=function() end
				end
				if (not f.ClipChildren) then
						f.ClipChildren=function() end
				end
				f:SetMovable(true)
				f:EnableMouse(true)
				if (f:GetFrameStrata() == "BACKGROUND") then
						f:SetFrameStrata("LOW")
				end
				f:SetMovable(true)
				f:SetResizable(true)
				f:SetClampedToScreen(true)
				f:RegisterForDrag("RightButton")
				local fname=f:GetName()
				if (not noinfo) then
						local omd=f:GetScript("OnMouseDown")
						local omu=f:GetScript("OnMouseUp")
						f:SetScript("OnMouseDown",function(...) OnDragInfoOn(omd,...) end)
						f:SetScript("OnMouseUp",function(...) OnDragInfoOff(omu,...) end)
				end
				f:SetScript("OnDragStart",OnDragStart)
				f:SetScript("OnDragStop",OnDragStop)
		else
				print("Sorry, ",tf," is not a frame object")
		end
end
function lib:AddXButton(f)
		local fname=f:GetName() .. "XButton"
		local b=self:Create("Button",fname,f,"UIPanelCloseButton")
		b:SetHeight(32)
		b:SetWidth(32)
		b:SetPoint("TOPRIGHT",f,"TOPRIGHT",f.rightmost,0)
		b:SetFrameLevel(10)
		b.ignore=true
		b:Show()
		return b
end
local Minimize
function Minimize(self,this)
		local base=16
		local height=32
		if (this.minimized) then
				base=3
				this.minimized=false
				height=this.oldwidth or 100
		else
				this.minimized=true
				this.oldwidth=this:GetParent():GetHeight()
		end
		self:SetTexCoord(this:GetNormalTexture(),base,8)
		self:SetTexCoord(this:GetPushedTexture(),base+1,8)
		this:GetParent():SetHeight(height)
end
function lib:AddMinButton(f)
		local fname=f:GetName() .. "MinButton"
		local b=self:Create("Button",fname,f,"UIPanelCloseButton")
		b.ignore=true
		local t
		--------------- Normal
		t=b:CreateTexture()
		t:SetTexture("Interface/BUTTONS/UI-Panel-CollapseButton-Up")
		t:SetAllPoints(b)
		b:SetNormalTexture(t)
		--------------- Pushed
		t=b:CreateTexture()
		t:SetTexture("Interface/BUTTONS/UI-Panel-CollapseButton-Up")
		t:SetAllPoints(b)
		b:SetPushedTexture(t)
		--------------- HighLight
		t=b:CreateTexture()
		t:SetTexture("Interface/BUTTONS/UI-Panel-CollapseButton-Up")
		t:SetBlendMode("ADD")
		t:SetAllPoints(b)
		b:SetHighlightTexture(t)
		b:SetScript("OnClick",function(this) Minimize(self,this) end)
		b:SetHeight(24)
		b:SetWidth(24)
		b:SetScale(1)
		b:SetPoint("TOPRIGHT",f,"TOPRIGHT",f.rightmost,-2)
		b:SetFrameLevel(10)
		b:Show()
		return b
end
function lib:AddConfigButton(f)
		local fname=f:GetName() .. "ConfigButton"
		local b=self:Create("Button",fname,f,"UIPanelCloseButton")
		b.ignore=true
		local t
		local ButtonsTexture=self:LoadTexture("Buttons")
		--------------- Normal
		t=b:CreateTexture()
		t:SetTexture(ButtonsTexture)
		self:SetTexCoord(t,22,8)
		t:SetAllPoints(b)
		b:SetNormalTexture(t)
		--------------- Pushed
		t=b:CreateTexture()
		t:SetTexture(ButtonsTexture)
		self:SetTexCoord(t,23,8)
		t:SetAllPoints(b)
		b:SetPushedTexture(t)
		--------------- HighLight
		t=b:CreateTexture()
		t:SetTexture(ButtonsTexture)
		self:SetTexCoord(t,2,8)
		t:SetBlendMode("ADD")
		t:SetAllPoints(b)
		b:SetHighlightTexture(t)
		if (type(f.Configure) ~= "function") then
				f.Configure=function() end
		end
		b:SetScript("OnClick",function(...) f:Configure(...) end)
		b:SetHeight(24)
		b:SetWidth(24)
		b:SetScale(1)
		b:SetPoint("TOPRIGHT",f,"TOPRIGHT",f.rightmost,-2)
		b:SetFrameLevel(10)
		b:Show()
		return b
end
function lib:LoadTexture(v)
		print("Toc is ",toc," me is ", me)
		self.texture:SetTexture(nil)
		local path="Interface\\Addons\\".. me .."\\Media\\%s"
		print("1",path:format(v))
		local rc=self.texture:SetTexture(path:format(v))
		print("rc",rc)
		if self.texture:SetTexture(path:format(v)) then return self.texture:GetTexture() end
		path="Interface\\Addons\\%s\\libs\\AlarShared-3.0\\%s"
		for _,i in pairs{"AlarArtRemover",me} do
				print("2",path:format(i,v))
				if self.texture:SetTexture(path:format(i,v)) then return self.texture:GetTexture() end
		end
end
function lib:argCheck(...)
		return true
end
function lib:GetXY(...)
		return 0,0
end
local flipbutton
function lib:AddRescaleButton(f)
		f=self:IsFrame(f)
		local fname=f:GetName() .. "BtResize"
		-- Adding Button
		local b=self:Create("Button",fname,f,"UIPanelCloseButton")
		b:SetFrameLevel(10)
		b.ignore=true
		b:SetHeight(16)
		b:SetWidth(16)
		b:SetPoint("TOPLEFT",f,"TOPLEFT",0,0)
		flipbutton(b,"plus")
		self:TTAdd(b,"Rescale\n(Panel could look 'funny' until you reloadUI)")
		b:SetScript("OnClick",function(...) self:DoResize(...) end)
		b:Show()
		-- Adding Slider
		local s =self:AddSlider(f,"Resizer","Scale",50,200,f:GetScale()*100)
		s:SetParent(UIParent)
		s.percentage=true
		s.decimals=1
		s:Hide()
		s:SetScript("OnMouseUp",function(this)
								self:DoResize(b,"LeftButton")
								end)
		local func=f:GetScript("OnHide")
		f:SetScript("OnHide",function ()
				s:Hide()
				pcall(func)
				flipbutton(b,"plus")
		end)
		s.OnRescaled=function(...) self:FormRescale(...) end
		return b
end
lib.AddResizeButton=lib.AddRescaleButton -- Compatibility
function lib:IsFrame(tf,verbose)
		local f
		if (type(tf) == "table") then
				f=tf
		else
				f=_G[tf]
		end
		if (not f) then
				return verbose and print(tf , " is not a global name")
		end
		if (type(f) ~= "table") then
				return verbose and print(tf .. " is not a table")
		end
		local canoperate=f.IsObjectType and f:IsObjectType("Frame")
		if (canoperate) then
				return f
		else
				return verbose and print(tf .. " is not a frame")
		end
end
function lib:AddHelpButton(f,testo,proc)
		self:argCheck(f,1,"table")
		self:argCheck(testo,2,"string","nil")
		local fname=f:GetName() .. "BtHelp"
		local b=self:Create("Button",fname,f,"UIPanelCloseButton")
		b.ignore=true
		b:SetFrameLevel(10)
		b:SetNormalTexture("interface\\buttons\\ui-microbutton-help-up")
		b:SetPushedTexture("interface\\buttons\\ui-microbutton-help-down")
		b:SetHighlightTexture("interface\\buttons\\ui-microbutton-hilight")
		b:SetHeight(48)
		b:SetWidth(32)
		b:SetPoint("TOPLEFT",f,"TOPRIGHT",-5,16)
		if (type(proc)=="function") then
			b:SetScript("OnClick",proc)
		end
		b:RegisterForClicks("LeftButtonUp")
		local h=getglobal(f:GetName() .. 'Header')
		if (h) then
				h:AddScript("OnEnter",function() b:SetAlpha(1) end)
				h:AddScript("OnLeave",function() b:SetAlpha(0) end)
		else
				f:AddScript("OnEnter",function() b:SetAlpha(0.5) end)
				f:AddScript("OnLeave",function() b:SetAlpha(0) end)
		end
		if (testo) then
				self:TTAdd(b,testo,true)
		end
		b:SetAlpha(0)
		b:Show()
		return b
end
local bminus="interface\\buttons\\ui-minusbutton-"
local bplus="interface\\buttons\\ui-plusbutton-"
function flipbutton(this,status)
		status=status or ''
		if (this.texture == 'plus' or status == 'minus') then
				this:SetNormalTexture(bminus .. "up")
				this:SetPushedTexture(bminus.. "down")
				this:SetHighlightTexture(bminus .. "hilight")
				this.texture="minus"
		else
				this:SetNormalTexture(bplus .. "up")
				this:SetPushedTexture(bplus .. "down")
				this:SetHighlightTexture(bplus .. "hilight")
				this.texture="plus"
		end
end
function lib:DoResize(this,button)
		if (button == "LeftButton") then
				flipbutton(this)
				local form=this:GetParent()
				local current=math.floor(form:GetScale()*100)
				local min=50
				local max=200
				local fname=form:GetName() .. "SliderResizer"
				local s=getglobal(fname)

				if (s) then
						s:ClearAllPoints()
						s.percentage=true
						s.decimals=1
						if (s:IsShown()) then
								s:Hide()
								return
						end
						s:SetPoint("BOTTOMLEFT",form,"TOPLEFT", 0, 5)
						s:Show()
						s:ClearAllPoints()
				end
		elseif (button == "RightButton") then
				dump("Frame data:",f.storage)
		end
end
function lib:AddMiniHeader(f,titolo)
		local h=self:AddHeader(f,titolo)
		h:SetHeight(16)
		h.ntexture:SetTexture(0,0,0,0)
		if (h.Label) then
				h:SetFontObject(GameFontNormal)
		end
end
function lib:AddHeader(f,titolo,noTexture)
		self:argCheck(f,1,"table")
		self:argCheck(titolo,2,"string","nil")
		self:argCheck(noTexture,3,"nil","boolean")
		local fname=f:GetName() .. 'Header'
		local r=getglobal(fname)
		if (not r) then
				r=self:Create("Frame",fname,f)
				r.compact=true
				f:SetMovable(true)
				f:SetClampedToScreen(true)
				r.ignore=true
				r:SetMovable(true)
				r:EnableMouse(true)
				r:RegisterForDrag("LeftButton")
				r:SetHeight(24)
				r:SetPoint("TOPLEFT",3,-3)
				r:SetPoint("TOPRIGHT",-3,3)
				r:SetScript("OnDragStart",OnDragStartParent)
				r:SetScript("OnDragStop",OnDragStopParent)
				self:TTAdd(r,"Drag to move")
				if (not noTexture) then
						---------------
						r.ntexture=r:CreateTexture(nil,"ARTWORK")
						r.ntexture:SetTexture(0.5,0.1,0.1)
						r.ntexture:SetGradient("vertical",0.4,0.1,0.1,0.8,0.2,0.2)
						r.ntexture:SetAllPoints(r)
						---------------
						r.htexture=r:CreateTexture(nil,"HIGHLIGHT")
						r.htexture:SetTexture(0.5,0.1,0.1)
						r.htexture:SetGradient("vertical",0.8,0.2,0.2,0.4,0.1,0.1)
						r.htexture:SetBlendMode("ADD")
						r.htexture:SetAllPoints(r)
				end
		end
		if (titolo) then
				f.Label=f:CreateFontString(fname .. "Label","OVERLAY","GameFontNormal")
				local s=r:CreateFontString(nil,"OVERLAY","GameFontNormalLarge")
				s:SetPoint("TOPLEFT",f.leftmost,0)
				s:SetPoint("BOTTOMRIGHT",f.rightmost,0)
				s:SetJustifyH("LEFT")
				s:SetJustifyV("TOP")
				s:SetText(titolo)
		end
		return r
end
function lib:AddResizer(f)
		local fname=f:GetName() .. 'Resizer'
		local r=self:Create("Frame",fname,f)
		f:SetResizable(true)
		f:SetClampedToScreen(true)
		r.ignore=true
		r:SetResizable(true)
		r:EnableMouse(true)
		r:RegisterForDrag("LeftButton")
		r:SetWidth(64)
		r:SetHeight(32)
		r:SetPoint("BOTTOMRIGHT",f,"BOTTOMRIGHT",18,-10)
		-----------------
		r.ntexture=r:CreateTexture()
		r.ntexture:SetTexture(self:LoadTexture("Buttons"))
		r.ntexture:SetTexCoord(0.75,0.875,0,0.125)
		r.ntexture:SetAllPoints(r)
		-----------------
		r.htexture=r:CreateTexture(nil,"HIGHLIGHT")
		r.htexture:SetTexture(self:LoadTexture("Buttons"))
		r.htexture:SetTexCoord(0.75,0.875,0,0.125)
		r.htexture:SetBlendMode("ADD")
		r.htexture:SetAllPoints(r)
		r:SetScript("OnDragStart",OnDragStartParentNoAlt)
		r:SetScript("OnDragStop",OnDragStopParent)
		return r
end
function lib:AddSlider(f,tipo,testo,min,max,current,x,y)
		local fname=f:GetName() .. 'Slider' .. tipo
		min=min or 0
		max=max or 100
		current=current or 50
		local s=self:Create("Slider",fname,f,"OptionsSliderTemplate")
		s.father=f
		s:SetScript("OnShow",function(this) self:SliderUpdate(this) end)
		s:SetScript("OnValueChanged",function(this) self:SliderUpdate(this) end)
		s:SetMinMaxValues(min,max)
		s:SetValue(current)
		s:SetPoint("TOPLEFT",x or 0,y or 0)
		s:Show()
		return s
end
function lib:SliderUpdate(Slider)
		local frame=Slider.father
		if (frame) then
				if (not Slider.percentage and not Slider.decimals) then
						Slider.decimals=1
				end
			local vcurrent=Slider:GetValue()
				local formato="%"
				if (Slider.decimals) then
						formato=formato.. "." .. Slider.decimals .. "f"
						vcurrent=math.floor(vcurrent * 10 ^ Slider.decimals)/10 ^ Slider.decimals
				else
						formato=formato .. "d"
						vcurrent=math.floor(vcurrent)
				end
				local perc=""
				if (Slider.percentage) then
						perc="%"
				end
				local sn=Slider:GetName()
			local vmin,vmax=Slider:GetMinMaxValues()
			local x=getglobal(sn .. "Low")
			if (x) then
				x:SetText(format(formato,vmin) .. perc)
			end
			x=getglobal(sn .. "High")
			if (x) then
				x:SetText(format(formato,vmax) .. perc)
			end
			x =getglobal(sn .. "Text")
			if (x) then
				x:SetText(format(formato,vcurrent) .. perc)
			end
			if (type(Slider.OnRescaled) == "function") then
						Slider:OnRescaled(frame)
			end
		end
end
function lib:AddUnitButton(f,name,testo,unit,x,y)
		local b=self:AddButton(f,name,testo,x,y,",SecureActionButtonTemplate")
		b:SetAttribute("type1","macro")
		b:SetAttribute("macrotext1","/target " .. unit)
		b.SetUnit=function(this,unit,extra)
				this:SetAttribute("macrotext1","/target " .. unit)
				this:SetText(unit .. (extra or  ''))
				this.Unit=unit
				end
		b.GetUnit=function(this) return this.Unit or 'none' end
		b:RegisterForClicks("AnyUp")
		return b
end
function lib:AddText(...)
		local tt=new()
		for i=1,select('#',...),2 do
				local key,value=select(i,...)
				tt[key]=value
		end
		local f
		if (tt.clickable) then
				f=self:CreateFrame("Button")
		else
				f=self:CreateFrame("EditBox")
				f:SetMultiLine(true)
				f:SetAutoFocus(false)
		end
		del(tt)
end
function lib:PanelRestore(f)
		restorepanel(self:IsFrame(f))
end
function lib:PanelSave(f)
		savepanel(self:IsFrame(f))
end
function lib:PanelMinSize(f,x,y)
		if (not f.storage) then
				--f.storage=self.db.profile.forms[f:GetName()]
				f.storage={}
		end
		f.storage.MinWidth=x or f.storage.MinWidth or f:GetWidth()
		f.storage.MinHeight=y or f.storage.MinHeight or f:GetHeight()
end
-- CastButton
function lib:ResetCastButtonList(f,rowlength)
		f.buttonlist=0
		f.rowlength=rowlength or 99
		local rowsize = 18 * f.rowlength
		local formsize=f:GetWidth()
		if ( rowsize >= formsize) then
				f.offset=0
		else
				f.offset =math.floor( (formsize -rowsize) /2)
		end
end
function lib:AddCastButtonList(f,ord,spelltableorname,target,rank,tipo,mouse)
		if (not f.buttonlist) then
				self:ResetCastButtonList(f)
		end
		local x,y
		y=0
		ord =ord or f.buttonlist
		x=mod(ord,f.rowlength)
		y=math.floor(ord /f.rowlength)
		local spelltable=spelltableorname
		if (type(spelltableorname)=="string") then
				spelltable={spellname=spelltableorname,spelltarget=target,spellrank=rank,spelltype=tipo,spellmouse=mouse}
		end
		local b=self:AddCastButton(f,f.buttonlist)
		f.buttonlist=f.buttonlist +1
		b:SetPoint("TOPLEFT",f,"BOTTOMLEFT",f.offset + x * 36,y * -36)
		b:SetScale(0.5)
		b:SetSpell(spelltable)
		b:Show()
		return b
end

local AddCastButton_SetSpell
-- Valid spelltype are: spell, macro, macrotext
function AddCastButton_SetSpell(this,t)
		if (type(t) == "string") then
				t={spellname=t,spelltype="spell"}
				t.spellname=GetSpellInfo(t.spellname)
		end
		t=t or {spelltype='none'}
		local nome=this:GetName()
		local icon=_G[nome.. "Icon"]
		if (t.spelltype=='none') then
				this.spelltarget=nil
				this.spellmouse=nil
				this.spelltype=nil
				this.spellname=nil
				this.spellrank=nil
				this.spelltexture=nil
				this.tooltipText=nil
				this.icon=icon
				if (this.icon) then
						this.icon:SetTexture(nil)
				end
				return
		end
		this.spelltarget=t.spelltarget or "target"
		this.spellmouse=t.spellmouse or ""
		this.spelltype=t.spelltype or "spell"
		this.spellname=t.spellname or ""
		this.spellrank=t.spellrank or ""
		this.spelltexture=t.spelltexture
		if (this.spelltype~="spell") then
				this.spellrank=""
				this.spellmouse=""
		end
		local rank=this.spellrank or ''
		if (rank ~= "") then
				rank=" ("..this.spellrank..")"
		end
		this.icon=icon
		if (icon) then
				local texture=this.spelltexture
				if (not texture) then
						if (this.spelltype == "macro") then
								_,texture=GetMacroInfo(this.spellname)
						elseif (this.spelltype == "spell") then
								texture=GetSpellTexture(this.spellname)
								if (not texture) then
										texture=GetSpellTexture(this.spellname .. rank)
								end
						end
				end
				texture = texture or "Interface\\Icons\\INV_Misc_QuestionMark"
				icon:SetTexture(texture)
		else
				--ACE:Print("%sIcon not found",nome)
		end
		this.tooltipText=this.spellname .. rank
		if (t.noCast) then
				return
		end
		if (this.target) then
				self:SetAttribute("unit",this.target)
		end
		if (not this.spelltype) then
				return
		end
		local tipo=this.spelltype
		if (tipo=="macrotext") then
				tipo="macro"
		end
		this:SetAttribute("type"..this.spellmouse,tipo)
		this:SetAttribute(this.spelltype .. this.spellmouse,this.spellname .. strtrim(rank))
end
local UpdateCooldown
function UpdateCooldown(spellbutton)
		local type=spellbutton.spelltype
		if (not type) then return end
		if (type == "spell") then
				local c=spellbutton.cooldown
				if (c) then
						local start,duration,enable=GetSpellCooldown(spellbutton.spellname)
						if (start and duration) then
								CooldownFrame_SetTimer(c,start,duration,enable)
						end
				end
		end
end
local function CheckRange(this)
		if (this.spellname) then
				if (SpellHasRange(this.spellname)) then
						if (IsSpellInRange(this.spellname,this.unit) == 0) then
				this.icon:SetVertexColor(1.0, 0.1, 0.1);
			elseif (IsUsableSpell(this.spellname)) then
					this.icon:SetVertexColor(1.0, 1.0, 1.0);
						else
								this.icon:SetVertexColor(0.1,0.1,1.0)
			end
				end
		end
end
function lib:AddCastButton(f,name,x,y,spell)
		name=name or ""
		local fname=f:GetName() .. "Cast" ..name
		local b=self:Create("CheckButton",fname,f,"SecureHandlerStateTemplate,SecureActionButtonTemplate,ActionButtonTemplate")
		--b:RegisterForClicks("AnyUp")
		b:SetHeight(32)
		b:SetWidth(32)
		b:SetAttribute("_onstate-hidden",[[
				if (newstate=='1') then
						self:Hide()
				else
						self:Show()
				end
		]])
		b:SetAttribute("_onstate-visible",[[
				if (self:GetAttribute("showstates"):match(newstate)) then
						self:SetAttribute("state-hidden","0")
				else
						self:SetAttribute("state-hidden","1")
				end
		]])

		b:SetAttribute("useparent-unit", true);
		b.unit=b:GetAttribute("unit") or f:GetAttribute("unit")
		b.SetSpell=AddCastButton_SetSpell
		b.cooldown=getglobal(fname .. "Cooldown")
		b:SetScript("OnEnter",self.TTOpen)
		b:SetScript("OnLeave",self.TTClose)
		b:SetScript("PostClick",function(this)
										UpdateCooldown(this)
										this:SetChecked(false)
								end)
		b:SetScript("OnEvent",
				function(this,event)
						if (event == "ACTIONBAR_UPDATE_COOLDOWN") then
								UpdateCooldown(this)
								this:SetChecked(false)
						end
				end
				)
		b.rangetimer=0.5
		b:SetScript("OnUpdate",
				function(this,elapsed)
				this.rangetimer = this.rangetimer - elapsed;
				if ( this.rangetimer <= 0 ) then
					CheckRange(this)
					this.rangetimer=0.5
						end
		end
		)
		b:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
		if (x and y) then
				b:SetPoint("TOPLEFT",x,y)
		end
		if (spell) then
				b:SetSpell(spell)
		end
		b:Show()
		return b
end
local AddSpellButton_OnReceiveDrag
local AddSpellButton_SetSpell
local AddSpellButton_OnMouseUp
local AddSpellButton_SetText
function AddSpellButton_OnMouseUp(this,button)
		this:SetChecked(nil)
		if (not CursorHasMacro() and not CursorHasSpell()) then
				if (button == "RightButton") then
						this:SetSpell(nil)
						return
				end
		end
		AddSpellButton_OnReceiveDrag(this)
end
function AddSpellButton_OnReceiveDrag(this)
		this:SetChecked(nil)
		if (not CursorHasMacro() and not CursorHasSpell()) then
				return
		end
		local tipo,slot,book=GetCursorInfo()
		local spellname
		local rank
		if (tipo == "spell") then
				spellname=GetSpellInfo(slot,book)
		end
		if (tipo == "macro") then
				spellname=GetMacroInfo(slot)
				rank=""
		end
		if (not spellname) then
				return
		end
		this.spelltype=tipo
		this.spellrank=rank
		this.spellname=spellname
		this:SetSpell{spelltype=tipo,spellrank=rank,spellname=spellname}
		ClearCursor()
end

function AddSpellButton_SetSpell(this,t)
		t=t or {spelltype='none'}
		t.noCast=true
		if (not t.spellttype and not t.spellname) then
				t.spelltype='none'
		end
		AddCastButton_SetSpell(this,t)
		if (t.spelltype=="none") then
				this:SetText('')
				return
		end
		local rank=this.spellrank or ''
		if (rank ~= "") then
				rank=" ("..this.spellrank..")"
		end
		this:SetText(t.spellname .. rank)
		local c="Yellow"
		if (t.spellname and IsHelpfulSpell(t.spellname)) then
				c="Green"
		end
		if (t.spellname and IsHarmfulSpell(t.spellname)) then
				c="Red"
		end
		local r,g,b=C[c]()
		_= this.Label and this.Label:SetTextColor(r,g,b)
end
function lib:AddSpellButton(f,name,x,y,spell,label)
		name=name or ""
		local fname=f:GetName() .. "Spell" ..name
		local b=self:Create("CheckButton",fname,f,"ActionButtonTemplate")
		b.spelltype=nil
		b.name="Empty"
		b:RegisterForClicks("RightButtonUp")
		b:SetScript("OnDragStart",function(this) this:SetSpell(nil) end );
	b:SetScript("OnReceiveDrag",AddSpellButton_OnReceiveDrag)
	b:SetScript("OnMouseUp",AddSpellButton_OnMouseUp)
	b:SetScript("OnClick",function(this) AddSpellButton_SetSpell(this,nil) end)
	b:SetScript("OnEnter",function(...) self:TTOpen(...) end)
	b:SetScript("OnLeave",self.TTClose)
	b:SetScript("PostClick",function(this) this:SetChecked(nil) end)
	b.SetSpell=AddSpellButton_SetSpell
		b:SetHeight(32)
		b:SetWidth(32)
		b:SetPoint("TOPLEFT",x or 0,y or 0)
		if (label) then
				b.Label=self:AddLLabel(b,"Text" ,150,34,0)
			b.SetText=function(this,...) this.Label:SetText(...) end
			b.SetTextColor=function(this,...) this.Label:SetTextColor(...) end
		else
				b.SetText=function() return end
		end
		if (spell) then
				b:SetSpell(spell)
		end
		b:Show()
		return b
end
function lib:FrameResetCastButtonList(f,rowlength)
	f.buttonlist=0
	f.rowlength=rowlength or 99
	local rowsize = 18 * f.rowlength
	local formsize=f:GetWidth()
	if ( rowsize >= formsize) then
		f.offset=0
	else
		f.offset =math.floor( (formsize -rowsize) /2)
	end
end

-- In case of upgrade, we need to redo embed for ALL Addons
-- This function get called on addon creation
-- Anything I define here is immediately available to addon code
function lib:Embed(target)
		debug("Embedding " .. MAJOR_VERSION .. " " .. MINOR_VERSION)
		-- Standard Mixins
		for name,method in pairs(mix) do
				target[name] = method
		end
		lib.mixinTargets[target] = true
end
--- reembed routine
for target,_ in pairs(lib.mixinTargets) do
	lib:Embed(target)
end

