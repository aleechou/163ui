local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local pp=print
local Type,Version,ancestor='AlarCastSingleButton',7,'AlarCastButton'
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
local cc={} --#Control


function cc:SetIcon(texture)
	self.texture=texture
	self:Update()
end
function cc:HideOnClick()
	debug("HideOnCLick to be implemented")
end
function cc:Pop(duration,speed)
		local status = self.status or self.localstatus
		local frame = self.frame
		local offset=AWG:Pop(self,status.size or 32)
		frame:ClearAllPoints()
		frame:SetPoint("CENTER",UIParent,"CENTER",offset,0)
		self:Show()
		if (type(duration) == 'number') then
			speed=5
			self:FadeOut()
		end
end
function cc:FadeOut(speed,delay)
		local fade=self.fade
		local animation=self.animation
		local frame=self.frame
		self.faded=true
		if (not frame:IsShown() or frame:GetAlpha()==0) then return end
		delay=delay or 5
		speed=speed or 25
		fade:SetChange(-1)
		fade:SetStartDelay(delay)
		fade:SetDuration(speed)
		animation:Play()
end
function cc:FadeStop()
		local animation=self.animation
		animation:Stop()
end
function cc:FadeIn(speed,delay)
		local fade=self.fade
		local frame=self.frame
		local animation=self.animation
		self.faded=false
		if (frame:IsShown() and frame:GetAlpha()==1) then return end
		if (not frame:IsShown()) then
			frame:SetAlpha(0)
			if (not InCombatLockdown()) then
				frame:Show()
			end
		end
		delay=delay or 5
		speed=speed or 25
		fade:SetChange(1)
		fade:SetStartDelay(delay)
		fade:SetDuration(speed)
		animation:Play()
end
function cc:OnRelase()
	self.xbutton:SetAttribute("type",nil)
	self.xbutton:SetAttribute("macrotext",nil)
	self:Parent(ancestor,'OnRelease')
end
function cc:SetCloseMacro(body)
	self.xbutton:SetAttribute("type","macro")
	self.xbutton:SetAttribute("macrotext",body)
end
do
	-- Scripts
	---@function [parent=#Control] _AnimationComplete
	local function AnimationComplete(this)
		local i=this:GetChange()
		local self=this.obj
		self:Fire("OnFadeEnd")
		if (not InCombatLockdown()) then
			if (i > 0) then
				self:Show()
			else
				self:Hide()
			end
		end
		self:SetAlpha(1)
	end
	local Serial=0
	---@function [parent=#Control] _Constructor
	local function Constructor()
		local self=AceGUI:Create(ancestor)
		self.standalone=true
		self.active=true
		self:Inject(cc,ancestor)
		local frame=self.frame
		local fname=frame:GetName() .. "XButton"
		local b=CreateFrame("Button",fname,frame,"UIPanelCloseButton,SecureActionButtonTemplate")
		b:SetHeight(16)
		b:SetWidth(16)
		b:SetPoint("TOPRIGHT",frame,"TOPRIGHT",0,0)
		b:SetFrameLevel(10)
		b.obj=self
		b:SetScript("PostClick",function(this)  this.obj:Fire("OnClose") end )
		local ag=frame:CreateAnimationGroup(frame:GetName()..'fade')
		local fade=ag:CreateAnimation('Alpha')
		fade:SetChange(-1)
		fade:SetStartDelay(0)
		fade:SetDuration(0)
		fade:SetScript("OnFinished",AnimationComplete)
		--fade:SetScript("OnUpdate",function(this,elapsed) print( elapsed) end )
		fade.obj=self
		self.fade=fade
		self.animation=ag
		self.xbutton=b
		return self

	end
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
	AWG.widgets[Type]=Version
end
