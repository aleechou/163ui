local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local Type,Version,ancestor = "AlarConfig",8,"Window"
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
local methods={} --#methods
function methods:SetStatusText(text)
	self.statustext:SetText(text)
end
function methods:SetStatusFormattedText(format,...)
	self.statustext:SetFormattedText(format,...)
end
--[[
	Pannello di configurazione
	Ha una casella di stato e un pulsante save
	Eventi:
		OnSave
		OnCancel
--]]
do
	local function OnCancel(obj)
		obj:Fire("OnCancel")
	end
	local function OnSave(this)
		this.obj:Fire("OnSave")
	end
	local PanelBackdrop  = {
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true, tileSize = 16, edgeSize = 16,
		insets = { left = 3, right = 3, top = 5, bottom = 3 }
	}

	local function Constructor()
		local self=AceGUI:Create(ancestor)
		self.type=Type
		local frame=self.frame
		self:SetCallback("OnClose",OnCancel)
		InjectStandardMethods(self)
		self:Inject(methods,ancestor)
		-- Save button
		local closebutton = CreateFrame("Button",nil,frame,"UIPanelButtonTemplate")
		closebutton:SetScript("OnClick", OnSave)
		closebutton:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-27,17)
		closebutton:SetHeight(20)
		closebutton:SetWidth(100)
		closebutton:SetText(SAVE)
		self.closebutton = closebutton
		closebutton.obj = self
		--Status
		local statusbg = CreateFrame("Frame",nil,frame)
		statusbg:SetPoint("BOTTOMLEFT",frame,"BOTTOMLEFT",15,15)
		statusbg:SetPoint("BOTTOMRIGHT",frame,"BOTTOMRIGHT",-132,15)
		statusbg:SetHeight(24)
		statusbg:SetBackdrop(PanelBackdrop)
		statusbg:SetBackdropColor(0.1,0.1,0.1)
		statusbg:SetBackdropBorderColor(0.4,0.4,0.4)
		self.statusbg = statusbg
		local statustext = statusbg:CreateFontString(nil,"OVERLAY","GameFontNormal")
		self.statustext = statustext
		statustext:SetPoint("TOPLEFT",statusbg,"TOPLEFT",7,-2)
		statustext:SetPoint("BOTTOMRIGHT",statusbg,"BOTTOMRIGHT",-7,2)
		statustext:SetHeight(20)
		statustext:SetJustifyH("LEFT")
		statustext:SetText("")
		return self

	end
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
	AWG.widgets[Type]=Version
end


