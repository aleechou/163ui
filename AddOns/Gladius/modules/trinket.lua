local Gladius = _G.Gladius
if not Gladius then
  DEFAULT_CHAT_FRAME:AddMessage(format("Module %s requires Gladius", "Trinket"))
end
local L = Gladius.L
local LSM

-- global functions
local strfind = string.find
local pairs = pairs
local strformat = string.format
local UnitName, UnitClass, UnitFactionGroup, UnitLevel = UnitName, UnitClass, UnitFactionGroup, UnitLevel

local Trinket = Gladius:NewModule("Trinket", false, true, {
   trinketAttachTo = "Frame",
   trinketAnchor = "TOPLEFT",
   trinketRelativePoint = "TOPRIGHT",
   trinketGridStyleIcon = false,
   trinketGridStyleIconColor = { r = 0, g = 1, b = 0, a = 1 },
   trinketGridStyleIconUsedColor = { r = 1, g = 0, b = 0, a = 1 },
   trinketAdjustSize = true,
   trinketSize = 52,
   trinketOffsetX = 1,
   trinketOffsetY = 0,
   trinketFrameLevel = 2,
   trinketIconCrop = false,
   trinketGloss = true,
   trinketGlossColor = { r = 1, g = 1, b = 1, a = 0.4 },
   trinketCooldown = true,
   trinketCooldownReverse = false,
   trinketFaction = true,
}, { "Trinket icon", "Grid style health bar", "Grid style power bar" })

function Trinket:OnEnable()   
   self:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
   
   LSM = Gladius.LSM   
   
   if (not self.frame) then
      self.frame = {}
   end 
end

function Trinket:OnDisable()
   self:UnregisterAllEvents()
   
   for unit in pairs(self.frame) do
      self.frame[unit]:SetAlpha(0)
   end
end

function Trinket:GetAttachTo()
   return Gladius.db.trinketAttachTo
end

function Trinket:GetFrame(unit)
   return self.frame[unit]
end

function Trinket:SetTemplate(template)
   if (template == 1) then
      -- reset width
      if (Gladius.db.targetBarAttachTo == "HealthBar" and not Gladius.db.healthBarAdjustWidth) then
         Gladius.db.healthBarAdjustWidth = true
      end
   
      -- reset to default
      for k, v in pairs(self.defaults) do
         Gladius.db[k] = v
      end
   elseif (template == 2) then
      if (Gladius.db.modules["HealthBar"]) then
         if (Gladius.db.healthBarAdjustWidth) then
            Gladius.db.healthBarAdjustWidth = false
            Gladius.db.healthBarWidth = Gladius.db.barWidth - Gladius.db.healthBarHeight
         else
            Gladius.db.healthBarWidth = Gladius.db.healthBarWidth - Gladius.db.healthBarHeight
         end
         
         Gladius.db.trinketGridStyleIcon = true
           
         Gladius.db.trinketAdjustHeight = false   
         Gladius.db.trinketHeight = Gladius.db.healthBarHeight
         
         Gladius.db.trinketAttachTo = "HealthBar"
         Gladius.db.trinketAnchor = "TOPLEFT"
         Gladius.db.trinketRelativePoint = "TOPRIGHT"
         
         Gladius.db.trinketOffsetX = 0
         Gladius.db.trinketOffsetY = 0         
      end
   else
      if (Gladius.db.modules["PowerBar"]) then
         if (Gladius.db.powerBarAdjustWidth) then
            Gladius.db.powerBarAdjustWidth = false
            Gladius.db.powerBarWidth = Gladius.db.powerBarWidth - Gladius.db.powerBarHeight
         else
            Gladius.db.powerBarWidth = Gladius.db.powerBarWidth - Gladius.db.powerBarHeight
         end
         
         Gladius.db.trinketGridStyleIcon = true
           
         Gladius.db.trinketAdjustHeight = false   
         Gladius.db.trinketHeight = Gladius.db.powerBarHeight
         
         Gladius.db.trinketAttachTo = "PowerBar"
         Gladius.db.trinketAnchor = "TOPLEFT"
         Gladius.db.trinketRelativePoint = "TOPRIGHT"
         
         Gladius.db.trinketOffsetX = 0
         Gladius.db.trinketOffsetY = 0         
      end      
   end
end

function Trinket:UNIT_SPELLCAST_SUCCEEDED(event, unit, spell, rank)
   if (not strfind(unit, "arena") or strfind(unit, "pet")) then return end
   
   -- pvp trinket
   if (spell == GetSpellInfo(59752) or spell == GetSpellInfo(42292)) then
      self:UpdateTrinket(unit, 120)
   end

   -- wotf
   if (spell == GetSpellInfo(7744)) then	
      self:UpdateTrinket(unit, 45)
   end
end

function Trinket:UpdateTrinket(unit, duration)
   -- grid style icon
   if (Gladius.db.trinketGridStyleIcon) then
      self.frame[unit].texture:SetVertexColor(Gladius.db.trinketGridStyleIconUsedColor.r, Gladius.db.trinketGridStyleIconUsedColor.g, Gladius.db.trinketGridStyleIconUsedColor.b, Gladius.db.trinketGridStyleIconUsedColor.a)
   end
   
   -- announcement
   if (Gladius.db.announcements.trinket) then
      Gladius:Call(Gladius.modules.Announcements, "Send", strformat(L["TRINKET USED: %s (%s)"], UnitName(unit) or "test", UnitClass(unit) or "test"), 2, unit)   
   end
   
   if (Gladius.db.announcements.trinket or Gladius.db.trinketGridStyleIcon) then
      self.frame[unit].timeleft = duration
      self.frame[unit]:SetScript("OnUpdate", function(f, elapsed)
         self.frame[unit].timeleft = self.frame[unit].timeleft - elapsed
         
         if (self.frame[unit].timeleft <= 0) then
            -- trinket
            if (Gladius.db.trinketGridStyleIcon) then
               self.frame[unit].texture:SetVertexColor(Gladius.db.trinketGridStyleIconColor.r, Gladius.db.trinketGridStyleIconColor.g, Gladius.db.trinketGridStyleIconColor.b, Gladius.db.trinketGridStyleIconColor.a)
            end
            
            -- announcement
            if (Gladius.db.announcements.trinket) then
               Gladius:Call(Gladius.modules.Announcements, "Send", strformat(L["TRINKET READY: %s (%s)"], UnitName(unit) or "", UnitClass(unit) or ""), 2, unit)
            end
            
            self.frame[unit]:SetScript("OnUpdate", nil)
         end
      end)
   end
   
   -- cooldown
   Gladius:Call(Gladius.modules.Timer, "SetTimer", self.frame[unit], duration)   
end

function Trinket:CreateFrame(unit)
   local button = Gladius.buttons[unit]
   if (not button) then return end       
   
   -- create frame
   self.frame[unit] = CreateFrame("CheckButton", "Gladius" .. self.name .. "Frame" .. unit, button, "ActionButtonTemplate")
   self.frame[unit]:EnableMouse(false)
   self.frame[unit]:SetNormalTexture("Interface\\AddOns\\Gladius\\images\\gloss")
   self.frame[unit].texture = _G[self.frame[unit]:GetName().."Icon"]
   self.frame[unit].normalTexture = _G[self.frame[unit]:GetName().."NormalTexture"]
   self.frame[unit].cooldown = _G[self.frame[unit]:GetName().."Cooldown"]
end

function Trinket:Update(unit)   
   -- create frame
   if (not self.frame[unit]) then 
      self:CreateFrame(unit)
   end
   
   -- update frame   
   self.frame[unit]:ClearAllPoints()
   
   -- anchor point 
   local parent = Gladius:GetParent(unit, Gladius.db.trinketAttachTo)     
   self.frame[unit]:SetPoint(Gladius.db.trinketAnchor, parent, Gladius.db.trinketRelativePoint, Gladius.db.trinketOffsetX, Gladius.db.trinketOffsetY)
   
   -- frame level
   self.frame[unit]:SetFrameLevel(Gladius.db.trinketFrameLevel)
   
   if (Gladius.db.trinketAdjustSize) then
      if (self:GetAttachTo() == "Frame") then   
         local height = false
         --[[ need to rethink that
         for _, module in pairs(Gladius.modules) do
            if (module:GetAttachTo() == self.name) then
               height = false
            end
         end]]
         
         if (height) then
            self.frame[unit]:SetWidth(Gladius.buttons[unit].height)   
            self.frame[unit]:SetHeight(Gladius.buttons[unit].height)   
         else
            self.frame[unit]:SetWidth(Gladius.buttons[unit].frameHeight)              
            self.frame[unit]:SetHeight(Gladius.buttons[unit].frameHeight)   
         end
      else
         self.frame[unit]:SetWidth(Gladius:GetModule(self:GetAttachTo()).frame[unit]:GetHeight() or 1)   
         self.frame[unit]:SetHeight(Gladius:GetModule(self:GetAttachTo()).frame[unit]:GetHeight() or 1) 
      end
   else
      self.frame[unit]:SetWidth(Gladius.db.trinketSize)         
      self.frame[unit]:SetHeight(Gladius.db.trinketSize)  
   end 
   
   -- set frame mouse-interactable area
   if (self:GetAttachTo() == "Frame") then
      local left, right, top, bottom = Gladius.buttons[unit]:GetHitRectInsets()
      
      if (strfind(Gladius.db.trinketRelativePoint, "LEFT")) then
         left = -self.frame[unit]:GetWidth() + Gladius.db.trinketOffsetX
      else
         right = -self.frame[unit]:GetWidth() + -Gladius.db.trinketOffsetX
      end
      
      -- search for an attached frame
      --[[for _, module in pairs(Gladius.modules) do
         if (module.attachTo and module:GetAttachTo() == self.name and module.frame and module.frame[unit]) then
            local attachedPoint = module.frame[unit]:GetPoint()
            
            if (strfind(Gladius.db.trinketRelativePoint, "LEFT") and (not attachedPoint or (attachedPoint and strfind(attachedPoint, "RIGHT")))) then
               left = left - module.frame[unit]:GetWidth()
            elseif (strfind(Gladius.db.trinketRelativePoint, "RIGHT") and (not attachedPoint or (attachedPoint and strfind(attachedPoint, "LEFT")))) then
               right = right - module.frame[unit]:GetWidth()
            end
         end
      end]]
      
      -- top / bottom
      if (self.frame[unit]:GetHeight() > Gladius.buttons[unit]:GetHeight()) then
         bottom = -(self.frame[unit]:GetHeight() - Gladius.buttons[unit]:GetHeight()) + Gladius.db.trinketOffsetY
      end

      Gladius.buttons[unit]:SetHitRectInsets(left, right, 0, 0) 
      Gladius.buttons[unit].secure:SetHitRectInsets(left, right, 0, 0)
   end
   
   -- style action button   
   self.frame[unit].normalTexture:SetHeight(self.frame[unit]:GetHeight() + self.frame[unit]:GetHeight() * 0.4)
	self.frame[unit].normalTexture:SetWidth(self.frame[unit]:GetWidth() + self.frame[unit]:GetWidth() * 0.4)
	
	self.frame[unit].normalTexture:ClearAllPoints()
	self.frame[unit].normalTexture:SetPoint("CENTER", 0, 0)
	self.frame[unit]:SetNormalTexture("Interface\\AddOns\\Gladius\\images\\gloss")
	
	self.frame[unit].texture:ClearAllPoints()
	self.frame[unit].texture:SetPoint("TOPLEFT", self.frame[unit], "TOPLEFT")
	self.frame[unit].texture:SetPoint("BOTTOMRIGHT", self.frame[unit], "BOTTOMRIGHT")
	
	if (not Gladius.db.trinketIconCrop and not Gladius.db.trinketGridStyleIcon) then
      self.frame[unit].texture:SetTexCoord(0, 1, 0, 1)
   else
      self.frame[unit].texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
   end
	
	self.frame[unit].normalTexture:SetVertexColor(Gladius.db.trinketGlossColor.r, Gladius.db.trinketGlossColor.g, 
      Gladius.db.trinketGlossColor.b, Gladius.db.trinketGloss and Gladius.db.trinketGlossColor.a or 0)
      
   -- cooldown
   if (Gladius.db.trinketCooldown) then
      self.frame[unit].cooldown:Show()
   else
      self.frame[unit].cooldown:Hide()
   end
   
   self.frame[unit].cooldown:SetReverse(Gladius.db.trinketCooldownReverse)
   Gladius:Call(Gladius.modules.Timer, "RegisterTimer", self.frame[unit], Gladius.db.trinketCooldown)
   
   -- hide
   self.frame[unit]:SetAlpha(0)
end

function Trinket:Show(unit)
   local testing = Gladius.test
      
   -- show frame
   self.frame[unit]:SetAlpha(1)
   
   if (Gladius.db.trinketGridStyleIcon) then
      self.frame[unit].texture:SetTexture(LSM:Fetch(LSM.MediaType.STATUSBAR, "Minimalist"))
      self.frame[unit].texture:SetVertexColor(Gladius.db.trinketGridStyleIconColor.r, Gladius.db.trinketGridStyleIconColor.g, Gladius.db.trinketGridStyleIconColor.b, Gladius.db.trinketGridStyleIconColor.a)
   else
      local trinketIcon
   
      if (not testing) then    
         if (UnitFactionGroup(unit) == "Horde" and Gladius.db.trinketFaction) then
            trinketIcon = UnitLevel(unit) == 80 and "Interface\\Icons\\INV_Jewelry_Necklace_38" or "Interface\\Icons\\INV_Jewelry_TrinketPVP_02"
         else
            trinketIcon = UnitLevel(unit) == 80 and "Interface\\Icons\\INV_Jewelry_Necklace_37" or "Interface\\Icons\\INV_Jewelry_TrinketPVP_01"
         end
      else
         if (UnitFactionGroup("player") == "Horde" and Gladius.db.trinketFaction) then
            trinketIcon = "Interface\\Icons\\INV_Jewelry_Necklace_38"
         else
            trinketIcon = "Interface\\Icons\\INV_Jewelry_Necklace_37"
         end
      end
      
      self.frame[unit].texture:SetTexture(trinketIcon)
      
      if (Gladius.db.trinketIconCrop) then
         self.frame[unit].texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
      end
      
      self.frame[unit].texture:SetVertexColor(1, 1, 1, 1)
   end
end

function Trinket:Reset(unit)
   if (not self.frame[unit]) then return end

   -- reset frame
   local trinketIcon
   
   if (UnitFactionGroup("player") == "Horde" and Gladius.db.trinketFaction) then
      trinketIcon = "Interface\\Icons\\INV_Jewelry_Necklace_38"
   else
      trinketIcon = "Interface\\Icons\\INV_Jewelry_Necklace_37"
   end
   
   self.frame[unit].texture:SetTexture(trinketIcon)
   
   if (Gladius.db.trinketIconCrop) then
      self.frame[unit].texture:SetTexCoord(0.07, 0.93, 0.07, 0.93)
   end
   
   self.frame[unit]:SetScript("OnUpdate", nil)
   
   -- reset cooldown
   Gladius:Call(Gladius.modules.Timer, "HideTimer", self.frame[unit])
   
   -- hide
	self.frame[unit]:SetAlpha(0)
end

function Trinket:Test(unit)   
   -- test
   if (unit == "arena1") then
      self:UpdateTrinket(unit, 120)
   end
end

-- Add the announcement toggle
function Trinket:OptionsLoad()
   Gladius.options.args.Announcements.args.general.args.announcements.args.trinket = {
      type="toggle",
      name=L["Trinket"],
      desc=L["Announces when an enemy uses a PvP trinket."],
      disabled=function() return not Gladius.db.modules[self.name] end,
   }
end

function Trinket:GetOptions()
   return {
      general = {  
         type="group",
         name=L["General"],
         order=1,
         args = {
            widget = {
               type="group",
               name=L["Widget"],
               desc=L["Widget settings"],  
               inline=true,                
               order=1,
               args = {
                  trinketGridStyleIcon = {
                     type="toggle",
                     name=L["Trinket Grid Style Icon"],
                     desc=L["Toggle trinket grid style icon"],
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     order=5,
                  },
                  sep = {                     
                     type = "description",
                     name="",
                     width="full",
                     order=7,
                  },
                  trinketGridStyleIconColor = {
                     type="color",
                     name=L["Trinket Grid Style Icon Color"],
                     desc=L["Color of the trinket grid style icon"],
                     hasAlpha=true,
                     get=function(info) return Gladius:GetColorOption(info) end,
                     set=function(info, r, g, b, a) return Gladius:SetColorOption(info, r, g, b, a) end,
                     disabled=function() return not Gladius.dbi.profile.trinketGridStyleIcon or not Gladius.dbi.profile.modules[self.name] end,
                     order=10,
                  }, 
                  trinketGridStyleIconUsedColor = {
                     type="color",
                     name=L["Trinket Grid Style Icon Used Color"],
                     desc=L["Color of the trinket grid style icon when it's on cooldown"],
                     hasAlpha=true,
                     get=function(info) return Gladius:GetColorOption(info) end,
                     set=function(info, r, g, b, a) return Gladius:SetColorOption(info, r, g, b, a) end,
                     disabled=function() return not Gladius.dbi.profile.trinketGridStyleIcon or not Gladius.dbi.profile.modules[self.name] end,
                     order=12,
                  },                   
                  sep1 = {                     
                     type = "description",
                     name="",
                     width="full",
                     order=13,
                  },
                  trinketCooldown = {
                     type="toggle",
                     name=L["Trinket Cooldown Spiral"],
                     desc=L["Display the cooldown spiral for important auras"],
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     hidden=function() return not Gladius.db.advancedOptions end,
                     order=15,
                  },
                  trinketCooldownReverse = {
                     type="toggle",
                     name=L["Trinket Cooldown Reverse"],
                     desc=L["Invert the dark/bright part of the cooldown spiral"],
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     hidden=function() return not Gladius.db.advancedOptions end,
                     order=20,
                  },
                  sep2 = {                     
                     type = "description",
                     name="",
                     width="full",
                     order=23,
                  },
                  trinketGloss = {
                     type="toggle",
                     name=L["Trinket Gloss"],
                     desc=L["Toggle gloss on the trinket icon"],
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     hidden=function() return not Gladius.db.advancedOptions end,
                     order=25,
                  },
                  trinketGlossColor = {
                     type="color",
                     name=L["Trinket Gloss Color"],
                     desc=L["Color of the trinket icon gloss"],
                     get=function(info) return Gladius:GetColorOption(info) end,
                     set=function(info, r, g, b, a) return Gladius:SetColorOption(info, r, g, b, a) end,
                     hasAlpha=true,
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     hidden=function() return not Gladius.db.advancedOptions end,
                     order=30,
                  },
                  sep3 = {                     
                     type = "description",
                     name="",
                     width="full",
                     hidden=function() return not Gladius.db.advancedOptions end,
                     order=33,
                  },
                  trinketIconCrop = {
                     type="toggle",
                     name=L["Trinket Icon Border Crop"],
                     desc=L["Toggle if the borders of the trinket icon should be cropped"],
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     order=35,
                  },
                  trinketFaction = {
                     type="toggle",
                     name=L["Trinket Icon Faction"],
                     desc=L["Toggle if the trinket icon should be changing based on the opponents faction"],
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     order=40,
                  },
                  sep3 = {                     
                     type = "description",
                     name="",
                     width="full",
                     order=43,
                  },
                  trinketFrameLevel = {
                     type="range",
                     name=L["Trinket Frame Level"],
                     desc=L["Frame level of the trinket"],
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     hidden=function() return not Gladius.db.advancedOptions end,
                     min=1, max=5, step=1,
                     width="double",
                     order=45,
                  },
               },
            },
            size = {
               type="group",
               name=L["Size"],
               desc=L["Size settings"],  
               inline=true,                
               order=2,
               args = {
                  trinketAdjustSize = {
                     type="toggle",
                     name=L["Trinket Adjust Size"],
                     desc=L["Adjust trinket size to the frame size"],
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     order=5,
                  },
                  trinketSize = {
                     type="range",
                     name=L["Trinket Size"],
                     desc=L["Size of the trinket"],
                     min=10, max=100, step=1,
                     disabled=function() return Gladius.dbi.profile.trinketAdjustSize or not Gladius.dbi.profile.modules[self.name] end,
                     order=10,
                  },               
               },
            },
            position = {
               type="group",
               name=L["Position"],
               desc=L["Position settings"],  
               inline=true,                
               order=3,
               args = {
                  trinketAttachTo = {
                     type="select",
                     name=L["Trinket Attach To"],
                     desc=L["Attach trinket to the given frame"],
                     values=function() return Gladius:GetModules(self.name) end,
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     arg="general",
                     order=5,
                  },
                  trinketPosition = {
                     type="select",
                     name=L["Trinket Position"],
                     desc=L["Position of the trinket"],
                     values={ ["LEFT"] = L["Left"], ["RIGHT"] = L["Right"] },
                     get=function() return strfind(Gladius.db.trinketAnchor, "RIGHT") and "LEFT" or "RIGHT" end,
                     set=function(info, value)
                        if (value == "LEFT") then
                           Gladius.db.trinketAnchor = "TOPRIGHT"
                           Gladius.db.trinketRelativePoint = "TOPLEFT"
                        else
                           Gladius.db.trinketAnchor = "TOPLEFT"
                           Gladius.db.trinketRelativePoint = "TOPRIGHT"
                        end
                        
                        Gladius:UpdateFrame(info[1])
                     end,
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     hidden=function() return Gladius.db.advancedOptions end,
                     order=6,
                  },
                  sep = {                     
                     type = "description",
                     name="",
                     width="full",
                     order=7,
                  },
                  trinketAnchor = {
                     type="select",
                     name=L["Trinket Anchor"],
                     desc=L["Anchor of the trinket"],
                     values=function() return Gladius:GetPositions() end,
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     hidden=function() return not Gladius.db.advancedOptions end,
                     order=10,
                  },
                  trinketRelativePoint = {
                     type="select",
                     name=L["Trinket Relative Point"],
                     desc=L["Relative point of the trinket"],
                     values=function() return Gladius:GetPositions() end,
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     hidden=function() return not Gladius.db.advancedOptions end,
                     order=15,               
                  },
                  sep2 = {                     
                     type = "description",
                     name="",
                     width="full",
                     order=17,
                  },
                  trinketOffsetX = {
                     type="range",
                     name=L["Trinket Offset X"],
                     desc=L["X offset of the trinket"],
                     min=-100, max=100, step=1,
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     order=20,
                  },
                  trinketOffsetY = {
                     type="range",
                     name=L["Trinket Offset Y"],
                     desc=L["Y  offset of the trinket"],
                     disabled=function() return not Gladius.dbi.profile.modules[self.name] end,
                     min=-50, max=50, step=1,
                     order=25,
                  },
               },
            },
         },
      },
   }
end
