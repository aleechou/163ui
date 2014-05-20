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

local CombuctorSets = Combuctor:GetModule('Sets')
local texture = 'Interface\\Addons\\Scrap\\Art\\Enabled Box'

CombuctorSets:Register('Scrap', texture, function(...)
	local bag, slot = select(12, ...)
	if bag and slot then
		return Scrap:IsJunk(GetContainerItemID(bag, slot), bag, slot)
	end
end)