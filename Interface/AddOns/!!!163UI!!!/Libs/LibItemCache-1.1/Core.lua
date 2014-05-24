--[[
Copyright 2011-2014 João Cardoso
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

local Lib = LibStub:NewLibrary('LibItemCache-1.1', 9)
if not Lib then
	return
end

local PetLinkFormat = '|c%s|Hbattlepet:%sx0|h[%s]|h|r'
local PetDataFormat = '^' .. strrep('%d+:', 6) .. '%d+$'

local Cache = function(method, ...)
	if Lib.Cache[method] then
		return Lib.Cache[method](Lib.Cache, ...)
	end
end


--[[ Startup ]]--

LibStub('AceEvent-3.0'):Embed(Lib)
Lib:RegisterEvent('BANKFRAME_OPENED', function() Lib.atBank = true end)
Lib:RegisterEvent('BANKFRAME_CLOSED', function() Lib.atBank = nil end)
Lib:RegisterEvent('VOID_STORAGE_OPEN', function() Lib.atVault = true end)
Lib:RegisterEvent('VOID_STORAGE_CLOSE', function() Lib.atVault = nil end)
Lib:RegisterEvent('GUILDBANKFRAME_OPENED', function() Lib.atGuild = true end)
Lib:RegisterEvent('GUILDBANKFRAME_CLOSED', function() Lib.atGuild = nil end)

Lib.PLAYER = UnitName('player')
Lib.REALM = GetRealmName()
Lib.Cache = {}


--[[ Realms ]]--

do 
	local region = (GetCVar('realmList') or ''):match('^(%a+)%.')
	if region == 'us' then
		region = {
			{"Balnazzar", "Warsong"},
			{"Gurubashi", "Hakkar", "Daggerspine", "Aegwynn"},
			{"Dalvengyr", "Dark Iron"},
			{"Garithos", "Chromaggus"},
			{"Onyxia", "Burning Blade", "Lightning's Blade"},
			{"Gul'dan", "Black Dragonflight", "Skullcrusher"},
			{"Auchindoun", "Laughing Skull"},
			{"Dethecus", "Detheroc"},
			{"Dunemaul", "Maiev", "Boulderfist", "Bloodscalp", "Stonemaul"},
			{"Rivendare", "Firetree"},
			{"Blackwing Lair", "Detheroc", "Dethecus"},
			{"Anub'arak", "Chromaggus", "Garithos"},
			{"Malorne", "Drak'Tharon", "Firetree", "Rivendare"},
			{"Blood Furnace", "Mannoroth"},
			{"Nesingwary", "Vek'nilash"},
			{"Aggramar", "Fizzcrank"},
			{"Echo Isles", "Draenor"},
			{"Scilla", "Ursin"},
			{'Anasterian (US)', 'Broxigar (US)', 'Brill (EU)', 'Naralex (EU)'}
		}
	elseif region == 'eu' then
		region = {
			{"Hakkar", "Emeriss"},
			{"Taerar", "Echsenkessel"},
			{"Theradras", "Dethecus"}
		}
	else
		region = {}
	end

	Lib.REALMS = (function()
			for _, realms in ipairs(region) do
				for _, realm in ipairs(realms) do 
					if realm == Lib.REALM then
						return realms
					end
				end
			end
		end)() or {Lib.REALM}
end


--[[ Players ]]--

function Lib:GetPlayerInfo(player)
	if self:IsPlayerCached(player) then
		return Cache('GetPlayer', self:GetPlayerAddress(player))
	else
		local _,class = UnitClass('player')
		local _,race = UnitRace('player')
		local sex = UnitSex('player')
		
		return class, race, sex
	end
end

function Lib:GetPlayerMoney(player)
	if self:IsPlayerCached(player) then
		return Cache('GetMoney', self:GetPlayerAddress(player)) or 0, true
	else
		return GetMoney() or 0
	end
end

function Lib:GetPlayerGuild(player)
	if self:IsPlayerCached(player) then
		return Cache('GetGuild', self:GetPlayerAddress(player))
	else
		return GetGuildInfo('player')
	end
end

function Lib:GetPlayerAddress(player)
	local player, realm = strsplit('-', player or self.PLAYER)
	return realm or Lib.REALM, player
end

function Lib:IsPlayerCached(player)
	return player and player ~= self.PLAYER
end

function Lib:IteratePlayers()
	local players = {}

	for i, realm in ipairs(self.REALMS) do
		local list = Cache('GetPlayers', realm) or {}
		local suffix = realm == Lib.REALM and '' or ('-' .. realm)

		for i, player in pairs(list) do
			tinsert(players, player .. suffix)
		end
	end

	sort(players)
	return pairs(players)
end

function Lib:DeletePlayer(player)
	Cache('DeletePlayer', self:GetPlayerAddress(player))
end


--[[ Bags ]]--

function Lib:GetBagInfo(player, bag)
	local isCached, _,_, tab = self:GetBagType(player, bag)
	
	if tab then
		if isCached then
			local realm, player = self:GetPlayerAddress(player)
			return Cache('GetBag', realm, player, bag, tab, slot)
		end
		return GetGuildBankTabInfo(tab)

	elseif bag ~= BACKPACK_CONTAINER and bag ~= BANK_CONTAINER then
		local slot = ContainerIDToInventoryID(bag)

   		if isCached then
   			local realm, player = self:GetPlayerAddress(player)
			local data, size = Cache('GetBag', realm, player, bag, tab, slot)
			local link, icon = self:RestoreLink(data)
			
			return link, 0, icon, slot, tonumber(size) or 0, true
		else
			local link = GetInventoryItemLink('player', slot)
			local count = GetInventoryItemCount('player', slot)
			local icon = GetInventoryItemTexture('player', slot)

			return link, count, icon, slot, GetContainerNumSlots(bag)
		end
	end

	return nil, 0, nil, nil, GetContainerNumSlots(bag), isCached
end

function Lib:GetBagType(player, bag)
	local kind = type(bag)
	local tab = kind == 'string' and tonumber(bag:match('guild(%d+)'))
	if tab then
		return not self.atGuild or self:GetPlayerGuild(player) ~= self:GetPlayerGuild(self.PLAYER), nil,nil, tab
	end

	local vault = bag == 'vault'
	local bank = bag == BANK_CONTAINER or kind == 'number' and bag > NUM_BAG_SLOTS
	local cached = self:IsPlayerCached(player) or vault and not self.atVault or bank and not self.atBank

	return cached, bank, vault
end


--[[ Items ]]--

function Lib:GetItemInfo(player, bag, slot)
	local isCached, _, isVault, tab = self:GetBagType(player, bag)

	if isCached then
		local realm, player = self:GetPlayerAddress(player)
		local data, count = Cache('GetItem', realm, player, bag, tab, slot)
		local link, icon, quality = self:RestoreLink(data)
		
		if isVault then
			return link, icon, nil, nil, nil, true
		else
			return icon, tonumber(count) or 1, nil, quality, nil, nil, link, true
		end
		
	elseif isVault then
		return GetVoidItemInfo(slot)
	elseif tab then
		local link = GetGuildBankItemLink(tab, slot)
		local icon, count, locked = GetGuildBankItemInfo(tab, slot)
		local quality = link and self:GetItemQuality(link)

		return icon, count, locked, quality, nil, nil, link

	else
		local icon, count, locked, quality, readable, lootable, link = GetContainerItemInfo(bag, slot)
		if link and quality < 0 then
			quality = self:GetItemQuality(link)
		end
	
		return icon, count, locked, quality, readable, lootable, link
	end
end

function Lib:GetItemQuality(link)
	if link:find('battlepet') then
		return tonumber(link:match('%d+:%d+:(%d+)'))
	else
		return select(3, GetItemInfo(link))
	end
end


function Lib:GetItemCounts(player, id)
	local realm, name = self:GetPlayerAddress(player)

	if self:IsPlayerCached(player) then
		return Cache('GetItemCounts', realm, name, id)
	else
		local vault = select(4, Cache('GetItemCounts', realm, name, id))
		local id, equip = tonumber(id), 0
		local total = GetItemCount(id, true)
		local bags = GetItemCount(id)

		for i = 1, INVSLOT_LAST_EQUIPPED do
			if GetInventoryItemID('player', i) == id then
				equip = equip + 1
			end
		end

		return equip, bags - equip, total - bags, vault or 0
	end
end


--[[ Partial Links ]]--

function Lib:RestoreLink(partial)
	if partial then
		if partial:find(PetDataFormat) then
			return self:RestorePetLink(partial)
		else
			return self:RestoreItemLink(partial)
		end
	end
end

function Lib:RestorePetLink(partial)
	local id, _, quality = strsplit(':', partial)
	local name, icon = C_PetJournal.GetPetInfoBySpeciesID(id)
	
	local color = select(4, GetItemQualityColor(quality))
	local link = PetLinkFormat:format(color, partial, name)
	
	return link, icon, tonumber(quality)
end

function Lib:RestoreItemLink(partial)
	local _, link, quality = GetItemInfo('item:' .. partial)
	return link, GetItemIcon(link), quality
end


--[[ Caches ]]--

function Lib:NewCache()
	self.NewCache = nil
	return self.Cache
end

function Lib:HasCache()
	return not self.NewCache
end