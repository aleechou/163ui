local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local Type,Version,Ancestor='AlarCast',9,nil
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
local _G=_G
local AWG=LibStub("AlarWidgets-3.0")
local AceGUI=LibStub("AceGUI-3.0")

local InjectStandardMethods=AWG.InjectStandardMethods
local questionmark="Interface\\Icons\\INV_Misc_QuestionMark"
local macroicon="Interface\\Icons\\spell_shadow_soulgem"

--[[
A base type.
Generates a standalond spell button, with NO click action enabled
It mirrors cooldown and effect , but if you click it the spell doesn not fire
--]]
if not AceGUI or (AceGUI:GetWidgetVersion(Type) or 0) >= Version then return end

local cc={} --#Control
function cc:OnAcquire()
	self.LockedImage=nil
	self.texture=nil
	self.action=nil
	self.actionType=nil
	self.spell=nil
	self.active=nil
	self.keybinding=nil
	self:BindToKey()
	self.attributes={}
end
function cc:OnRelease()
	self:BindToKey()
	self:ClearAttributes()
end
function cc:SetAlpha(...)
	self.frame:SetAlpha(...)
end
function cc:BindToKey(key)
	local oldkey=self.keybinding
	if (key) then
		SetBinding(key,self.bindinglabel)
	elseif (self.keybinding) then
		SetBinding(self.keybinding)
	end
	if (self.bindinglabel) then
		self.keybinding=GetBindingKey(self.bindinglabel)
	end
	return oldkey
end
function cc:GetBoundKey()
	return self.keybinding
end
function cc:SetSpell(spellname,modifier,button)
	self.actionType="spell"
	self.action=spellname
	self.spell=spellname
	if (self.active) then self:SetCast(nil,nil,modifier,button) end
	self:Update()
end
function cc:SetMacro(macro,modifier,button)
	self.actionType="macro"
	self.spell=nil
	self.action=macro
	if (self.active) then self:SetCast(nil,nil,modifier,button) end
	self:Update()
end
function cc:SetMacrotext(body,modifier,button)
	self.actionType="macrotext"
	self.action=body
	self.spell=nil
	if (self.active) then self:SetCast(nil,nil,modifier,button) end
	self:Update()
end
function cc:SetCast(actionType,action,modifier,button)
	actionType=actionType or self.actionType
	action=action or self.action
	modifier=modifier or ''
	button=button or ''
	debug("SetCast",actionType,action,modifier,button)
	local frame=self.frame
	self:SetModifiedCast(frame,modifier,actionType,button,action)
	local label=self.label
	if (label) then
		self:SetModifiedCast(label,modifier,actionType,button,action)
	end
end
function cc:SetImage(texture)
	self.ImageLocked=true
	self.texture=texture
end
function cc:SetImageCoord(...)
	self.Icon:SetTexCoord(...)
end
function cc:SetModifiedCast(frame,modifier,actiontype,button,value)
	local attribute=actiontype
	if (actiontype=="macrotext") then actiontype ="macro" end
	self.attributes[modifier .. "type" .. button]=actiontype
	self.attributes[modifier .. attribute .. button]=value
	frame:SetAttribute(modifier .. "type" .. button,actiontype)
	frame:SetAttribute(modifier .. attribute .. button,value)
end
function cc:GetAttributes()
return self.attributes
end
function cc:ClearAttributes()
local frame=self.frame
for k,_ in pairs(self.attributes) do
	frame:SetAttribute(k,nil)
end
end
function cc:SetUnit(unit,modifier,button)
	modifier=modifier or ''
button=button or ''
debug("Setting unit to",unit,self.action)
local attribute=modifier .. 'unit' .. button
	local frame=self.frame
	frame:SetAttribute(attribute,unit)
	local label=self.label
	if (label) then
		label:SetAttribute(attribute,unit)
	end
end
function cc:SetSize(size)
	local status=self:Status()
	local frame=self.frame
	local label=self.label
	status.size=size
	local scale=size/frame:GetWidth()
	frame:SetScale(scale)
	debug("Icon scale:",scale)
if (label) then
	debug("Label scale:",1/scale)
		label:SetScale(1/scale)
	end

end
function cc:GetSize()
	return self:Status()[size]
end
function cc:UpdateUsable(frame)
	local icon = self.Icon;
	if (not icon) then return end
	local normalTexture = self.NormalTexture
	if (not normalTexture) then return end
	local rc,isUsable, notEnoughMana = pcall(IsUsableSpell,self.spell)
	if (not rc) then return end
	if ( isUsable ) then
		icon:SetVertexColor(1.0, 1.0, 1.0)
		normalTexture:SetVertexColor(1.0, 1.0, 1.0)
	elseif ( notEnoughMana ) then
		icon:SetVertexColor(0.5, 0.5, 1.0)
		normalTexture:SetVertexColor(0.5, 0.5, 1.0)
	else
		icon:SetVertexColor(0.4, 0.4, 0.4)
		normalTexture:SetVertexColor(1.0, 1.0, 1.0)
	end
end
function cc:UpdateCooldown(frame)
	local cooldown = self.Cooldown
	if (not self.spell) then return end
	local rc,start, duration, enable = pcall(GetSpellCooldown,self.spell)
	if (rc) then
		CooldownFrame_SetTimer(cooldown, start, duration, enable)
	end
end
function cc:UpdateFlash(frame)
	--not really needed
end
function cc:UpdateTooltip(frame)
	-- Not enabled for base type
end
function cc:GetButton()
	return self.frame
end
function cc:GetIconTexture()
	local actionType=self.actionType
	local action=self.action
	local texture=self.texture
	if (texture or type(texture)=="boolean") then
	return actionType,texture
end
local rc
if (actionType=="spell") then
	rc,texture=pcall(GetSpellTexture,action)
	if (not texture) then
		self.actionType=nil
		texture=questionmark
		debug("Failed","spell",action)
		return
	end
elseif (actionType=="macrotext") then
	local rc,result, target = pcall(SecureCmdOptionParse,action)
	target=target or ''
	result=result or ''
	texture=GetSpellTexture(tostring(target:gsub("\n","")))
	if not result then
		self.actionType=nil
		texture=questionmark
		debug("Failed","macrotext",action)
	end
	if (not texture) then
		texture=macroicon
	end
elseif (actionType=="macro") then
		rc,texture=pcall(GetMacroInfo,action)
		if (not texture) then
			self.actionType=nil
			texture=questionmark
		end
	end
	return self.actionType,texture

end
function cc:Update ()
	local frame=self.frame
	local action = self.action
	local icon = self.Icon;
	local buttonCooldown = self.Cooldown
	local actionType,texture=self:GetIconTexture()
	debug("Updating button for ",actionType,action)
if ( actionType) then
	if ( not frame.eventsRegistered and self.active) then
		frame:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
		frame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
		frame:RegisterEvent("PLAYER_TARGET_CHANGED");
		frame:RegisterEvent("PLAYER_ENTER_COMBAT");
		frame:RegisterEvent("PLAYER_LEAVE_COMBAT");
		frame.eventsRegistered = true;
	end
	self:UpdateUsable(frame)
	self:UpdateCooldown(frame)
	self:UpdateFlash(frame)
else
	if ( frame.eventsRegistered ) then
		frame:UnregisterEvent("ACTIONBAR_UPDATE_USABLE");
		frame:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
		frame:UnregisterEvent("PLAYER_TARGET_CHANGED");
		frame:UnregisterEvent("PLAYER_ENTER_COMBAT");
		frame:UnregisterEvent("PLAYER_LEAVE_COMBAT");
		frame.eventsRegistered = nil;
	end
	if ( frame:GetAttribute("showgrid") == 0 ) then
		frame:Hide();
	else
		buttonCooldown:Hide();
	end
end

if ( type(texture)~="boolean" ) then
	icon:SetTexture(texture);
	icon:Show();
	frame.rangeTimer = -1;
	frame:SetNormalTexture("Interface\\Buttons\\UI-Quickslot2");
else
	icon:Hide();
	buttonCooldown:Hide();
	frame.rangeTimer = nil;
	if (texture) then
		frame:SetNormalTexture("Interface\\Buttons\\UI-Quickslot");
		local hotkey = self.HotKey;
		if ( hotkey:GetText() == RANGE_INDICATOR ) then
			hotkey:Hide();
		else
			hotkey:SetVertexColor(0.6, 0.6, 0.6);
		end
	else
		frame:SetNormalTexture(nil);
	end
end
--ActionButton_UpdateCount(frame);	-- not really needed

-- Update tooltip
	if ( GameTooltip:GetOwner() == frame ) then
		self:SetTooltip(frame);
	end

end

function cc:SetEmpty()
	local frame=self.frame
	local status=self:Status()
	status.type="empty"
end
	function cc:ShowAtMouse()
		local frame=self.frame
		local scale=UIParent:GetScale()
		local x,y=GetCursorPosition()
		frame:SetPoint("CENTER",UIParent,"BOTTOMLEFT",x/scale + 10/scale,y/scale)
	self:Show()
end
function cc:ShowAtCenter(offset)
	offset=offset or 10
	local frame=self.frame
	frame:ClearAllPoints()
	frame:SetPoint("CENTER",UIParent,"CENTER",offset,0)
	self:Show()
end
local function OnEvent(self,event,...)
	--debug(event,self.spell,':',...)
	if (event == "ACTIONBAR_UPDATE_USABLE") then
		self.obj:UpdateUsable(self)
	elseif (event == "ACTIONBAR_UPDATE_COOLDOWN") then
		self.obj:UpdateCooldown(self)
	end
end
function cc:SetTooltipText(text)
	self.frame.tooltipText=text
end
do
	local Serial=0
	---@function [parent=#Control] _tooltipshow
	local function tooltipshow(this,r,g,b)
		if InCombatLockdown() then return end
		if(this.tooltipText ~= nil) then
			GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			GameTooltip:SetText(this.tooltipText, r or 1, g or 0.82, b or 0);
			if (this.obj:IsRestricted()) then
				GameTooltip:AddLine(ERR_NOT_IN_COMBAT,1,0,0)
			end
			GameTooltip:Show()
		end
	end
	---@function [parent=#Control] _tooltiphide
	local function tooltiphide(this)
			if(this.tooltipText ~= nil) then
			GameTooltip:Hide();
			end
	end
	---@function [parent=#Control] _Constructor
	--
	local function Constructor()
		Serial=Serial+1
		local self={}
		self.type=Type
		local name=Type..Version..Serial
		self.frame=CreateFrame("CheckButton",name,UIParent,"SecureActionButtonTemplate, ActionButtonTemplate")
		self.bindinglabel="CLICK "..name..":LeftButton"
		InjectStandardMethods(self)
		self:Inject(cc)
		self.Cooldown=_G[name..'Cooldown']
		self.Icon=_G[name..'Icon']
		self.NormalTexture=_G[name..'NormalTexture']
		self.Name=_G[name..'Name']
		self.Count=_G[name..'Count']
		self.HotKey=_G[name..'HotKey']
		self.Flash=_G[name..'Flash']
		self.Border=_G[name..'Border']
		self.frame.obj=self
		local frame=self.frame
		frame:SetAttribute("useparent-unit", true);
		frame:SetScript("PostClick",function(self,...) self:SetChecked(0) self.obj:Fire("OnClick",...) end)
		frame:SetScript("OnUpdate",ActionButton_OnUpdate)
		frame:SetScript("OnEvent",OnEvent)
		frame:SetScript("OnEnter",tooltipshow)
		frame:SetScript("OnLeave",tooltiphide)
		return AceGUI:RegisterAsWidget(self)
	end
	AWG.widgets[Type]=Version
	AceGUI:RegisterWidgetType(Type,Constructor,Version)
end
