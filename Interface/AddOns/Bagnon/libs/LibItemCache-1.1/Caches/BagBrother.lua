--[[
Copyright 2011-2013 João Cardoso
LibItemCache is distributed under the terms of the GNU General Public License.
You can redistribute it and/or modify it under the terms of the license as
published by the Free Software Foundation.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this library. If not, see <http://www.gnu.org/licenses/>.

This file is part of LibItemCache.
--]]

local Lib = LibStub('LibItemCache-1.1')
if not BagBrother or Lib:HasCache() then
	return
end

local Cache = Lib:NewCache()

local LAST_BANK_SLOT = NUM_BAG_SLOTS + NUM_BANKBAGSLOTS
local FIRST_BANK_SLOT = NUM_BAG_SLOTS + 1
local ITEM_COUNT = ';(%d+)$'
local ITEM_ID = '^(%d+)'


--[[ Items ]]--

function Cache:GetBag(realm, player, _, slot)
	local bag = BrotherBags[realm][player].equip[slot]
	if bag then
		return strsplit(';', bag)
	end
end

function Cache:GetItem(realm, player, bag, slot)
	local bag = BrotherBags[realm][player][bag]
	local item = bag and bag[slot]
	if item then
		return strsplit(';', item)
	end
end

function Cache:GetMoney(realm, player)
	return BrotherBags[realm][player].money
end


--[[ Item Counts ]]--

function Cache:GetItemCounts(realm, player, id)
	local player = BrotherBags[realm][player]
	local equipment = self:GetItemCount(player.equip, id, true)
	local vault = self:GetItemCount(player.vault, id, true)
	local bank = self:GetItemCount(player[BANK_CONTAINER], id)
	local bags = 0
	
	for i = BACKPACK_CONTAINER, NUM_BAG_SLOTS do
		bags = bags + self:GetItemCount(player[i], id)
	end
	
	for i = FIRST_BANK_SLOT, LAST_BANK_SLOT do
		bank = bank + self:GetItemCount(player[i], id)
    end
	
	return equipment, bags, bank, vault
end

function Cache:GetItemCount(bag, id, unique)
	local i = 0
	
	if bag then
		for _,item in pairs(bag) do
			if strmatch(item, ITEM_ID) == id then
				i = i + (not unique and tonumber(strmatch(item, ITEM_COUNT)) or 1)
			end
		end
	end
	
	return i
end


--[[ Players ]]--

function Cache:GetPlayer(realm, player)
	player = BrotherBags[realm][player]
	return player.class, player.race, player.sex
end

function Cache:DeletePlayer(realm, player)
	BrotherBags[realm][player] = nil
end

function Cache:GetPlayers(realm)
	return BrotherBags[realm]
end