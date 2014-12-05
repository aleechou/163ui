local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local Type,Version,Ancestor = "AlarCastHeader",4
local me, ns = ...
--[===[@debug@
LibStub("AlarLoader-3.0"):loadingList(__FILE__,me)
--@end-debug@]===]
if (LibDebug) then LibDebug() end
local function debug(...)
--[===[@debug@
	print(...)
--@end-debug@]===]
end
local toc=select(4,GetBuildInfo())
local TooltipHeader=SHIFT_KEY .. '+' ..KEY_BUTTON1 .. ': ' .. DRAG_MODEL
--[[ Standard prologue end --]]
local AWG=LibStub("AlarWidgets-3.0")
local AceGUI=LibStub("AceGUI-3.0")
local C=LibStub("AlarCrayon-3.0"):GetColorTable()
local InjectStandardMethods=AWG.InjectStandardMethods
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end
local cc={} --# Control
function cc:SetBackdrop(backdrop)
	self.frame:SetBackdrop(backdrop)
end
function cc:OnAcquire()
	self:Parent(Ancestor,"OnAcquire")
	self.frame.tooltipText=C(TooltipHeader,"yellow")
	self.content:Show()
end
function cc:Append(frame)
	self:SetUserData(frame,'frame')
	frame:SetParent(self.frame)
end
function cc:SetTitle(...)
	self.frame:SetText(...)
end
function cc:AutoSize()
	self.frame:SetWidth(self.frame:GetFontString():GetStringWidth()+20)
end
function cc:SetTooltipText(text)
	self.frame.tooltipText=C(TooltipHeader,"yellow") .. "\n" .. text
end
function cc:SetOnAttributeChanged(snippet)
	self.frame:SetAttribute('_onattributechanged',snippet)
end
function cc:ApplyStatus()
	local status = self:Status()
	local frame = self.frame
	self:SetWidth(status.width or 100)
	self:SetHeight(status.height or 30)
	if status.top and status.left then
		frame:SetPoint("TOP",UIParent,"BOTTOM",0,status.top)
		frame:SetPoint("LEFT",UIParent,"LEFT",status.left,0)
	else
		frame:SetPoint("CENTER",UIParent,"CENTER")
	end
end
function cc:SetModifiedCast(modifier,actiontype,button,value)
	local attribute=actiontype
	if (actiontype=="macrotext") then actiontype ="macro" end
	self.frame:SetAttribute(modifier .. "type" .. button,actiontype)
	self.frame:SetAttribute(modifier .. attribute .. button,value)
end
do
	local serial=0
	---@function [parent=#Control] _Constructor
	local function Constructor()
		local frame=CreateFrame("Button",Type..serial,UIParent,"UIPanelButtonTemplate,SecureActionButtonTemplate,SecureHandlerAttributeTemplate")
		serial =serial +1
		local widget={frame=frame}
		frame.obj=widget
		widget.buttontText=_G[Type .. serial .. 'Text']
		frame:SetClampedToScreen(true)
		frame:SetMovable(true)
		frame:EnableMouse(true)
		frame:RegisterForClicks("AnyDown")
		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnDragStart", function (frame) if (IsShiftKeyDown()) then frame:StartMoving() end end)
		frame:SetScript("OnDragStop", frame.StopMovingOrSizing)
		frame:SetScript("PostClick",function(this) if (not IsShiftKeyDown()) then this.obj:Fire("OnClick") end end )
		--Container Support
		local content = CreateFrame("Frame",nil,frame)
		widget.content = content
		content.obj = widget
		content:SetPoint("TOPLEFT",frame,"TOPLEFT",12,-20)
		content:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-12,13)

		widget.type = Type
		InjectStandardMethods(widget)
		widget:Inject(cc,Ancestor)
		widget.localstatus = {}
		frame:SetWidth(100)
		frame:SetHeight(20)
		frame:SetMovable(true)
		if (not frame:GetPoint()) then frame:SetPoint("CENTER",UIParent) end
		widget:Show()
		return AceGUI:RegisterAsContainer(widget)
	end
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
	AWG.widgets[Type]=Version
end
