local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local toc=select(4,GetBuildInfo())
local me, ns = ...
local pp=print
local L=LibStub("AceLocale-3.0"):GetLocale(me,true)
local C=LibStub("AlarCrayon-3.0"):GetColorTable()
LibStub("AlarLoader-3.0")(__FILE__,me,ns)
local print=ns.print or print
local debug=ns.debug or print
local AWG=LibStub("AlarWidgets-3.0")
local AceGUI=LibStub("AceGUI-3.0")
local C=LibStub("AlarCrayon-3.0"):GetColorTable()
local L=LibStub("AceLocale-3.0"):GetLocale("AlarShared")
--[[ Standard prologue end --]]
local Type,Version,Ancestor = "AlarHeader",8
local InjectStandardMethods=AWG.InjectStandardMethods
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end
local methods={} --#Control
function methods:SetBackdrop(backdrop)
	self.frame:SetBackdrop(backdrop)
end
function methods:OnAcquire()
	self:Parent(Ancestor,"OnAcquire")
	self.frame.tooltipText=C(KEY_BUTTON1 ..': ' .. DRAG_MODEL,"yellow") .. "\n" .. C(L["Double Click to shrink"],"green")
	self.content:Show()
end
function methods:Append(frame)
	self:SetUserData(frame,'frame')
	frame:SetParent(self.frame)
end
function methods:SetTitle(...)
	self.frame:SetText(...)
end
function methods:ApplyStatus()
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
do
	local serial=0
	---@function [parent=#Control] _frameOnMouseDown
	local function frameOnMouseDown(this)
		this:StartMoving()
		AceGUI:ClearFocus()
	end
	---@function [parent=#Control] _shrink
	local function shrink(this)
		if this.obj:IsRestricted() then return end
		local content=this.obj.content
		local u=this.obj:GetUserDataTable()
		if (content:IsShown()) then
			this:SetNormalFontObject(GameFontDisable)
			this:SetHighlightFontObject(GameFontDisable)
			content:Hide()
			for k,v in pairs(u) do
				if v=='frame' then k:Hide() end
			end
		else
			this:SetNormalFontObject(GameFontNormal)
			this:SetHighlightFontObject(GameFontNormal)
			content:Show()
			for k,v in pairs(u) do
				if v=='frame' then k:Show() end
			end
		end
	end
	---@function [parent=#Control] _frameOnMouseUp
	local function frameOnMouseUp(this)
		this:StopMovingOrSizing()
		local self = this.obj
		self:SaveStatus()
	end
	local function tooltipshow(this,r,g,b)
		if(this.tooltipText ~= nil) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetText(this.tooltipText, r or 1, g or 0.82, b or 0);
			if (this.obj:IsRestricted()) then
				GameTooltip:AddLine(ERR_NOT_IN_COMBAT,1,0,0) -- You can't do that while in combat
			end
			GameTooltip:Show()
		end
	end
	local function tooltiphide(this)
			if(this.tooltipText ~= nil) then
			GameTooltip:Hide();
			end
	end
	---@function [parent=#Control] _Constructor
	local function Constructor()
		local frame=CreateFrame("Button",Type..serial,UIParent,"UIPanelButtonTemplate")
		serial =serial +1
		local widget={frame=frame}
		frame.obj=widget
		frame:SetClampedToScreen(true)
		frame:SetScript("OnMouseDown",frameOnMouseDown)
		frame:SetScript("OnMouseUp", frameOnMouseUp)
		frame:SetScript("OnDoubleClick",shrink)
		--frame:SetScript("OnEnter",tooltipshow)
		--frame:SetScript("OnLeave",tooltiphide)
		--Container Support
		local content = CreateFrame("Frame",nil,frame)
		widget.content = content
		content.obj = widget
		content:SetPoint("TOPLEFT",frame,"TOPLEFT",12,-20)
		content:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-12,13)

		widget.type = Type
		InjectStandardMethods(widget)
		widget:Inject(methods,Ancestor)
		widget.localstatus = {}
		frame:SetWidth(100)
		frame:SetHeight(20)
		frame:SetMovable(true)
		widget:Show()
		return AceGUI:RegisterAsContainer(widget)
	end
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
	AWG.widgets[Type]=Version
end
