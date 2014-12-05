local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local Type,Version,Ancestor = "AlarPanel",7,"Window"
local pp=print
local me, ns = ...
--[===[@debug@
LibStub("AlarLoader-3.0"):loadingList(__FILE__,me)
--@end-debug@]===]
if (LibDebug) then LibDebug() end
local function debug(...)
--[===[@debug@
	--print(...)
--@end-debug@]===]
end
local print=pp
local toc=select(4,GetBuildInfo())
--[[ Standard prologue end --]]
local AWG=LibStub("AlarWidgets-3.0")
local AceGUI=LibStub("AceGUI-3.0")
local InjectStandardMethods=AWG.InjectStandardMethods
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end
local C=LibStub("AlarCrayon-3.0"):GetColorTable()
local L=LibStub("AceLocale-3.0"):GetLocale("AlarShared",true)
local Backdrops={
	FrameBackdrop = {
		bgFile = "Interface\\Tooltips\\ChatBubble-Background",
		edgeFile = "Interface\\Tooltips\\ChatBubble-BackDrop",
		tile = true, tileSize = 32, edgeSize = 32,
		insets = { left = 32, right = 32, top = 32, bottom = 32 }
	},
	PanelBackdrop  = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 3, right = 3, top = 5, bottom = 3 }
	}
}
local function OnMouseUp(this,button)
	local self=this.obj
	self.oldTitleOnMouseUp(this,button)
	if (button=="RightButton" and self:IsScalable()) then
		self:Slider(true)
	else
		self:Fire("OnClick",button)
	end
end
local function OnClose(this)
	this.obj:Slider(false)
	this.obj:Fire("OnClose")
end
local function OnEnter(this)
	if (this.tooltipText) then
		GameTooltip_AddNewbieTip(this, this.tooltipText, 1.0, 1.0, 1.0);
	end
	this.obj:Fire("OnEnter")
end
local function OnLeave(this)
	if (this.tooltipText) then
		GameTooltip:Hide()
	end
	this.obj:Fire("OnLeave")
end
-- Widget Methods
local methods={}
function methods:LayoutFinished(w,h)
	local status = self.status or self.localstatus
	local this=self.frame
	status.width = this:GetWidth()
	status.height = this:GetHeight()
	status.top = this:GetTop()
	status.left = this:GetLeft()
	status.scale=this:GetScale()
	self:Fire("OnResize")
end
function methods:SetBackdrop(backdrop)
		if (type("backdrop" == "string")) then
			self.frame:SetBackdrop(Backdrops[backdrop])
		else
			self.frame:SetBackdrop(backdrop)
		end
end

function methods:SetStatusText(text)
	if (self.statustext) then
		self.statustext:SetText(text)
	end
end

function methods:SetAlpha(value)
	self.frame:SetAlpha(value)
end

function methods:Show()
	self.frame:Show()
	if (self.xbutton) then
		self.xbutton:SetFrameStrata(self.frame:GetFrameStrata())
		self.xbutton:SetFrameLevel(99)
	end
end

function methods:Lock()
	local status = self.status or self.localstatus
	if (self.title) then
		self.title:EnableMouse(not status.locked)
	end
	if (self.sizer_se) then
		self.sizer_se:EnableMouse(not status.locked)
	end
end
function methods:ApplyStatus()
	local status = self.status or self.localstatus
	local frame = self.frame
	if status.scalable == nil then status.scalable=true end
	self.scalable=status.scalable
	if not status.scalable then
		status.scale=1
	end
	self:SetScale(status.scale or 1)
	self:SetWidth(status.width or 700)
	self:SetHeight(status.height or 500)
	if status.top and status.left then
		frame:SetPoint("TOP",UIParent,"BOTTOM",0,status.top)
		frame:SetPoint("LEFT",UIParent,"LEFT",status.left,0)
	else
		frame:SetPoint("CENTER",UIParent,"CENTER")
	end
end
function methods:SetMinResize(w,h)
	self.frame:SetMinResize(w,h)
end
function methods:OnAcquire()
	self:Parent(Ancestor,'OnAcquire')
	self.frame:SetFrameStrata("HIGH")
	self.frame:SetClampedToScreen(true)
	self.title.tooltipText=C(KEY_BUTTON1 ..': ' .. DRAG_MODEL,"yellow") .. "\n" .. C(L["Right Click to rescale"],"green")
end
local function close(this,event)
	this.obj:Slider(false)
end
local function rescale(this,event,value)
	local frame=this.obj.frame
	local y=frame:GetTop()
	local x=frame:GetRight()-frame:GetWidth()
	local s=frame:GetEffectiveScale()
	y=y*s
	x=x*s
	frame:ClearAllPoints()
	frame.obj:SetScale(value)
	s=frame:GetEffectiveScale()
	x=x/s
	y=y/s
	frame:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",x,y)
	frame.obj:Fire("OnScale",value)

end
function methods:Slider(display)
	if (display and not self.slider) then
		self.slider=AceGUI:Create("Slider")
		local slider=self.slider
		slider.obj=self
		slider.frame:SetFrameStrata("FULLSCREEN_DIALOG")
		slider.frame:SetClampedToScreen(true)
		slider:ClearAllPoints()
		local frame=self.frame
		local x,y=AWG:RescaleXY(frame:GetLeft(),frame:GetTop(),self.frame,slider.frame)
		local s2=slider.frame:GetEffectiveScale()
		slider:SetPoint("TOPLEFT",UIParent,"BOTTOMLEFT",x,y+45)
		slider:SetSliderValues(self.minscale,self.maxscale,0.1)
		slider:SetValue(self.frame:GetScale())
		slider:SetCallback("OnValueChanged",rescale)
		slider:SetCallback("OnLeave",close)
		slider.frame:Show()
	else
		if (self.slider) then
			self.slider.frame:Hide()
			AceGUI:Release(self.slider)
			self.slider=nil
		end
	end
end
function methods:SetScalable(value,minscale,maxscale)
	self.minscale=tonumber(minscale) or 0.5
	self.maxscale=tonumber(maxscale) or 2
	self.scalable=value
	self:Status().scalable=value
end
function methods:IsScalable()
	return self.scalable
end


local function mktitle(title,frame)
	local htexture=title:CreateTexture(nil,"HIGHLIGHT")
	htexture:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
	htexture:SetVertexColor(1,0,0)
	htexture:SetBlendMode("ADD")
	htexture:SetAllPoints(title)
end
do
-- Scripts
	local function Constructor()
		local self=AceGUI:Create(Ancestor)
		local frame=self.frame
		self.type = Type
		InjectStandardMethods(self)
		self:Inject(methods,Ancestor)

		self.localstatus = {}

		frame.obj = self
		frame:SetMinResize(100,100)
		frame:SetToplevel(true)
		-- title bar
		mktitle(self.title,frame)
		self.title.obj=self
		local oldscript=self.title:GetScript("OnMouseUp")
		if (type(oldscript)=="function") then
			self.oldTitleOnMouseUp=oldscript
		else
			self.oldTitleOnMouseUp=function() end
		end
		self.title:SetScript("OnMouseUp",OnMouseUp)
		self.frame:SetScript("OnHide",OnClose)
		self.title:SetScript("OnEnter",OnEnter)
		self.title:SetScript("OnLeave",OnLeave)
		return self
	end
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
	AWG.widgets.AlarPanel=Version
end