local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local pp=print
local Type,Version,Ancestor='AlarCastButton',9,'AlarCast'
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
local print=pp
local toc=select(4,GetBuildInfo())
--[[ Standard prologue end --]]

local _G=_G
local AWG=LibStub("AlarWidgets-3.0")
local AceGUI=LibStub("AceGUI-3.0")
local InjectStandardMethods=AWG.InjectStandardMethods
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end
local methods={} --# Control
function methods:OnAcquire()
	self:Parent(Ancestor,"OnAcquire")
	self.active=true
end
function methods:SetTitle(title)
	title=title or ""
	self.text:SetText(title)
end
function methods:GetTitle()
	return self.text:GetText() or ''
end
function methods:SetTitleWidth(size)
	local title=self.title
	size=tonumber(size) or 180
	if (not InCombatLockdown()) then
		self.title:SetWidth(size)
	end
end
function methods:SetTitleColor(...)
	local text=self.text
	self.text:SetVertexColor(...)
end
do
	local Serial=0
	local function Constructor()
		local self=AceGUI:Create(Ancestor)
		self:Inject(methods,Ancestor)
		self.active=true
		self.type=Type
		Serial=Serial+1
		self.standalone=false
		self:ApplyStatus()
		local frame=self.frame
		frame.obj=self
		local title=CreateFrame("Button",nil,frame,"SecureActionButtonTemplate")
		title.obj=self
		title:EnableMouse(true)
		title:RegisterForClicks("AnyDown")
		title:SetHeight(16)
		title:SetWidth(200)
		title:SetPoint("TOPLEFT",frame,"TOPRIGHT",10,0)
		title:SetPoint("BOTTOMLEFT",frame,"BOTTOMRIGHT",10,0)
		title:SetAttribute("useparent-unit", true)
		local highlight = title:CreateTexture(nil, "HIGHLIGHT")
		highlight:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
		highlight:SetBlendMode("ADD")
		highlight:SetAllPoints(title)
		local text = title:CreateFontString(nil,"OVERLAY","GameFontNormal")
		text:SetAllPoints(title)
		text:SetJustifyV("CENTER")
		text:SetJustifyH("LEFT")
		title.text=text
		title:SetAttribute("type","click")
		title:SetAttribute("clickbutton",self:GetButton())
		title:SetScript("PostClick",function(this,...) this.obj:Fire("OnClick",...) end)
		self.title=title
		self.text=text
		self.label=title
		self:SetTitle('')
		return AceGUI:RegisterAsWidget(self)
	end
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
	AWG.widgets[Type]=Version
end