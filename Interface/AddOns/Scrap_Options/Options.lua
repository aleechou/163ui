--[[
Copyright 2008-2013 João Cardoso
Scrap is distributed under the terms of the GNU General Public License (Version 3).
As a special exception, the copyright holders of this addon do not give permission to
redistribute and/or modify it.

This addon is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the addon. If not, see <http://www.gnu.org/licenses/gpl-3.0.txt>.

This file is part of Scrap.
--]]

local NoVisuals = not Scrap.HasSpotlight
local HasPawn = IsAddOnLoaded('Pawn_Scrap')
local Options = SushiMagicGroup(ScrapOptions)

Options:SetAddon('Scrap')
Options:SetFooter('Copyright 2008-2013 João Cardoso')
Options:SetChildren(function(self)
	self:CreateHeader('Behaviour', 'GameFontHighlight', true)
	self:Create('CheckButton', 'AutoSell')
	self:Create('CheckButton', 'AutoRepair')
	self:Create('CheckButton', 'GuildRepair', nil, Scrap_AutoRepair, true)
	self:Create('CheckButton', 'SafeMode', 'Safe')
	self:Create('CheckButton', 'Learn')
	
	self:CreateHeader('Filters', 'GameFontHighlight', true)
	self:Create('CheckButton', 'LowEquip', nil, HasPawn)
	self:Create('CheckButton', 'LowConsume')
	
	self:CreateHeader('Visuals', NoVisuals and 'GameFontNormalLeftGrey' or 'GameFontHighlight', true)
	self:Create('CheckButton', 'Glow', nil, NoVisuals)
	self:Create('CheckButton', 'Icons', nil, NoVisuals)
	
	Scrap:SettingsUpdated()
end)