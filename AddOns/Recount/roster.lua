-- A quick replacement for what RosterLib-2.1 used to do for us.

local revision = tonumber(string.sub("$Revision: 1198 $", 12, -3))
local Recount = _G.Recount
if Recount.Version < revision then Recount.Version = revision end


local raids = {}
local raidpets = {}
local raidtargets = {}
local raidpettargets = {}
local party = {}
local partypet = {}
local partytargets = {}
local partypettargets = {}

for i = 1, 40 do
    raids[i] = 'raid'..i
    raidpets[i] = 'raidpet'..i
    raidtargets[i] = 'raid'..i..'target'
    raidpettargets[i] = 'raidpet'..i..'target'
end

for i = 1, 4 do
    party[i] = 'party'..i
    partypet[i] = 'partypet'..i
    partytargets[i] = 'party'..i..'target'
    partypettargets[i] = 'partypet'..i..'target'
end


local GetNumRaidMembers = GetNumRaidMembers or GetNumGroupMembers
local GetNumPartyMembers = GetNumPartyMembers or GetNumSubgroupMembers
local UnitAffectingCombat = UnitAffectingCombat
local UnitExists = UnitExists
local UnitName = UnitName
local UnitGUID = UnitGUID
local strsplit,type = strsplit,type

---warbaby add UpdateRoster, mainly for FindOwnerPetFromGUID, called too much, every Recount:DetectPet
local pet_owner, guid_name, unit_guid = {}, {}, {}
local wipe,UNKNOWNOBJECT,UNKNOWN=wipe,UNKNOWNOBJECT,UNKNOWN

local OriginOnEnable = Recount.OnEnable
local _event_frame = CreateFrame("Frame")
_event_frame:SetScript("OnEvent", function() Recount:UpdateRoster() end)
function Recount:OnEnable(...)
    _event_frame:RegisterEvent("UNIT_PET")
    _event_frame:RegisterEvent("GROUP_ROSTER_UPDATE")
    _event_frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    _event_frame:RegisterEvent("UNIT_NAME_UPDATE")
    _event_frame:RegisterEvent("UNIT_PORTRAIT_UPDATE")

    self._player_guid = UnitGUID("player")
    self.pet_owner = pet_owner
    self.guid_name = guid_name
    self.unit_guid = unit_guid
    self.guid_name[self._player_guid] = UnitName("player")
    OriginOnEnable(...)
end

function Recount:UpdateRoster()
    wipe(pet_owner)
    wipe(unit_guid) unit_guid["player"] = self._player_guid

    local units, unitpets, guid
    if GetNumRaidMembers() == 0 then
        units, unitpets = party, partypet
    else
        units, unitpets = raids, raidpets
    end

    for i=1, #units do
        local unit = units[i]
        guid = UnitGUID(unit)
        if not guid then break end
        unit_guid[unit] = guid
        if not guid_name[guid] then
            local name, realm = UnitName(unit) if realm=="" then realm=nil end
            if name and name~=UNKNOWNOBJECT and name~=UNKNOWN then
                if realm then
                    guid_name[guid] = name .. "-" .. realm
                else
                    guid_name[guid] = name
                end
            end
        end
    end

    guid = UnitGUID("pet") if guid then pet_owner[guid] = self._player_guid end

    for i=1, #unitpets do
        local owner_guid = unit_guid[units[i]]
        if not owner_guid then break end
        guid = UnitGUID(unitpets[i])
        if guid then
            pet_owner[guid] = owner_guid
        end
    end
end

function Recount:FindOwnerPetFromGUID(petName,petGUID)
    local owner_guid = pet_owner[petGUID]
    if owner_guid then
        --print("FindOwnerPetFromGUID", petName, petGUID, guid_name[owner_guid], owner_guid)
        return guid_name[owner_guid], owner_guid
    end
    --if UnitPlayerControlled(petName) and not UnitIsPlayer(petName) then print("FindOwnerPetFromGUID NotFound", petName, petGUID) end
end

function Recount:CheckPartyCombatWithPets()

    if UnitAffectingCombat("player") then
        return true
    end

    local raidNum = GetNumRaidMembers()
    if raidNum > 0 then
        for i = 1, raidNum , 1 do -- GetNumRaidMembers() per arrowmaster, raid40 can be set even if there are fewer than 40 people in raid. <- Tested this and this is incorrect.
            if UnitAffectingCombat(raids[i]) then
                return true
            end
            if UnitAffectingCombat(raidpets[i]) then
                return true
            end
        end
    else
        local partyNum = GetNumPartyMembers()
        if partyNum > 0 then
            for i = 1, partyNum, 1 do -- If arrow is correct this is not the case and we are good to use GetNumPartyMembers()
                if UnitAffectingCombat(party[i]) then
                    return true
                end
                if UnitAffectingCombat(partypet[i]) then
                    return true
                end
            end
        end
    end

    return false
end

function Recount:GetUnitIDFromName(name)

    if type(name)~="string" then return nil end -- Bandaid for raid frame issues

    --[[
        local realm = name:match("-(.-)")
        if realm then
            --Recount:DPrint("Found cross-realm: " ..name .. " on realm ".. name:match("-(.-)"))
            name = name:match("(.-)-") -- strip the realm part for this function
        end
    ]]
    local realm
    name, realm = strsplit("-", name)

    if UnitExists(name) then -- Elsia: Speed boost, yay.
        --Recount:Print(name)
        return name
    else
        --Recount:Print(name:lower():sub(1,3))
        local lname = name:lower()
        --Recount:Print(lname)
        if lname:sub(1,3)=="pet" or lname:sub(1,4)=="raid" or lname:sub(1,5)=="party" or lname:sub(1,6)=="player" or lname:sub(1,6)=="target" then
            return Recount:GetPetPrefixUnit(name, realm)
        end
        return nil
    end
end

-- This is a bandaid for Blizz' playername pet* bug for unitids.

function Recount:GetPetPrefixUnit(name, realm)

    if Recount.PlayerName==name and not realm then
        return "player"
    end

    local raidNum = GetNumRaidMembers()
    if raidNum > 0 then
        for i = 1, raidNum, 1 do -- GetNumRaidMembers() per arrowmaster, raid40 can be set even if there are fewer than 40 people in raid.
            local unitname, unitrealm = UnitName(raids[i]) if unitrealm=="" then unitrealm=nil end
            if unitname == name and unitrealm == realm then
                return raids[i]
            end
        end
    else
        local partyNum = GetNumPartyMembers()
        if partyNum > 0 then
            for i = 1, partyNum, 1 do -- GetNumRaidMembers() per arrowmaster, raid40 can be set even if there are fewer than 40 people in raid.
                local unitname, unitrealm = UnitName(party[i]) if unitrealm == "" then unitrealm = nil end
                if unitname == name and unitrealm == realm then
                    return party[i]
                end
            end
        end
    end
    return nil
end

function Recount:FindTargetedUnit(name)
    --Let take the early out here (not everywhere that was using this function called the other function and it should be combined)
    if UnitExists(name) then
        return name
    end

    --TODO: warbaby提前, 不知有何影响
    if name==UnitName("playertarget") then
        return "playertarget"
    elseif name==UnitName("focus") then
        return "focus"
    end

    local raidNum = GetNumRaidMembers()
    if raidNum > 0 then
        for i = 1, raidNum, 1 do -- GetNumRaidMembers()
            if name==UnitName(raidtargets[i]) then
                return raidtargets[i]
            elseif name==UnitName(raidpettargets[i]) then
                return raidpettargets[i]
            end
        end
    else
        local partyNum = GetNumPartyMembers()
        if partyNum > 0 then
            for i = 1, partyNum, 1 do -- If arrow is correct this is not the case and we are good to use GetNumPartyMembers()
                if name==UnitName(partytargets[i]) then
                    return partytargets[i]
                elseif name==UnitName(partypettargets[i]) then
                    return partypettargets[i]
                end
            end
        end
    end
end

--[[
function Recount:FindOwnerPetFromGUID(petName,petGUID)
    local ownerName
    local ownerGUID
    local ownerRealm

    if petGUID==UnitGUID("pet") then
        ownerName = UnitName("player")
        ownerGUID = UnitGUID("player")
        return ownerName, ownerGUID
    end

    local raidNum = GetNumRaidMembers()
    if raidNum > 0 then
        for i = 1, raidNum, 1 do -- GetNumRaidMembers()
            if petGUID == UnitGUID(raidpets[i]) then
                ownerName, ownerRealm = UnitName(raids[i])
                if ownerRealm then
                    ownerName = ownerName .. "-" .. ownerRealm
                end
                ownerGUID = UnitGUID(raids[i])
                return ownerName, ownerGUID
            end
        end
    else
        local partyNum = GetNumPartyMembers()
        if partyNum > 0 then
            for i = 1, partyNum, 1 do
                if petGUID == UnitGUID(partypet[i]) then
                    ownerName, ownerRealm = UnitName(party[i])
                    if ownerRealm then
                        ownerName = ownerName .. "-" .. ownerRealm
                    end
                    ownerGUID = UnitGUID(party[i])
                    return ownerName, ownerGUID
                end
            end
        end
    end

    return nil, nil
end
--]]