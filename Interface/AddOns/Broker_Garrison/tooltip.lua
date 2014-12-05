local ADDON_NAME, private = ...

local _G = getfenv(0)
local LibStub = _G.LibStub

local Garrison = LibStub("AceAddon-3.0"):GetAddon(ADDON_NAME)
local L = LibStub:GetLibrary( "AceLocale-3.0" ):GetLocale(ADDON_NAME)
local LibQTip = LibStub('LibQTip-1.0')


local iconProvider, iconCellPrototype = LibQTip:CreateCellProvider()
Garrison.iconProvider = iconProvider

function iconCellPrototype:InitializeCell()
   if not self.icon then
      self.icon = self:CreateTexture()
      --self.icon:SetAllPoints(self)

      self.icon:SetPoint("TOPLEFT", self ,"TOPLEFT", 0, 0)

   end
end

function iconCellPrototype:SetupCell(tooltip, value, justification, font, l_pad, r_pad, max_width, min_width, texture, size)

   self.size = size

   if(_G.type(texture) == "number") then
      self.icon:SetToFileData(texture)
   else
      self.icon:SetTexture(texture)
   end   

   self.icon:SetWidth(size)
   self.icon:SetHeight(size)
   self.icon:Show()

   --Garrison.debugPrint(("%s, %s: %s (%s)"):format(self._line, self._column, self.icon:GetHeight(), texture))

   return size, size
end
   
function iconCellPrototype:getContentHeight()
   return self.size
end

function iconCellPrototype:ReleaseCell()
   if self.icon then      
      self.icon:Hide()
      self.icon:SetTexture(nil)
   end
end

