--[[
Copyright 2008-2013 João Cardoso
Combuctor Scrap is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this addon do not give permission to
redistribute and/or modify it.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the addon. If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>.

This file is part of Combuctor Scrap.
--]]

local Addon = Combuctor
local ItemSlot = Addon.ItemSlot
local UpdateBorder = ItemSlot.UpdateBorder
local r, g, b  = GetItemQualityColor(0)

local function CreateIcon(slot)
	local icon = slot:CreateTexture(nil, 'OVERLAY')
	icon:SetTexture('Interface\\Buttons\\UI-GroupLoot-Coin-Up')
	icon:SetPoint('TOPLEFT', 2, -2)
	icon:SetSize(15, 15)

  	slot.scrapIcon = icon
	return icon
end

local function SetShown(element, shown)
	if shown then
		element:Show()
	else
		element:Hide()
	end
end

function ItemSlot:UpdateBorder()
	local link = select(7, self:GetInfo())
	local icon = self.scrapIcon or CreateIcon(self)
	local isJunk

	if link then
		local id = tonumber(strmatch(link, 'item:(%d+)'))
		local bag, slot
		
		if not self:IsCached() then
			bag, slot = self:GetBag(), self:GetID()
		end
		
		isJunk = Scrap:IsJunk(id, bag, slot)
	end
	
	SetShown(self.border, isJunk and Scrap_Glow)
	SetShown(icon, isJunk and Scrap_Icons)
	
	if isJunk then
		self.questBorder:Hide()
		self.border:SetVertexColor(r, g, b, self:GetHighlightAlpha())
		return
	end
	
	UpdateBorder(self)
end


-- Update Bags
local function UpdateBags()
	Addon:UpdateFrames()
end

hooksecurefunc(Scrap, 'SettingsUpdated', UpdateBags)
hooksecurefunc(Scrap, 'ToggleJunk', UpdateBags)
Scrap.HasSpotlight = true