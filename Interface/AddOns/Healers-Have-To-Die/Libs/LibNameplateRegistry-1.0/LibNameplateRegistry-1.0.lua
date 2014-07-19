--[[
        LibNameplateRegistry-1.0

        An embeddable library providing an abstraction layer for tracking and
        querying Blizzard's Nameplate frames with ease and efficiency.

        Copyright (c) 2013 by John Wellesz (Archarodim@teaser.fr)
        
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Lesser Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Lesser Public License for more details.

    You should have received a copy of the GNU Lesser Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

This file was last updated on 2013-12-08T18:36:12Z by John Wellesz

--]]



--========= coding NAMING Convention ==========
--      VARIABLES AND FUNCTIONS (upvalues excluded)
-- Constants                      == NAME_WORD2 (full upper-case)
-- locals to closures or members  == NameWord2
-- locals to functions            == nameWord2
--
--      TABLES
--  Closure or file locals        == Name_Word2
--  locals                        == name_word2
--  members                       == Name_Word2

--
-- TODO:
-- - Create a frame underneath the main nameplate and use setscript on it as proposed by Adirelle
-- - Add args error checking on public API (at least in debug mode?)
-- - Add a method to decommission properly a Blizzard nameplate
-- - Add a documentation snippet on nameplate modifications
-- - Add a :GetPlateClass() method
--

-- Library framework {{{
local MAJOR, MINOR = "LibNameplateRegistry-1.0", 8

if not LibStub then
    error(MAJOR .. " requires LibStub");
    return
end

if not LibStub("CallbackHandler-1.0") then
    error(MAJOR .. " requires CallbackHandler-1.0");
    return;
end

local _, oldMinor =  LibStub:GetLibrary(MAJOR, true);

-- I do not want to expose the library internals to the outside world in order
-- to limit Murphy's law influence. This is unusual for a WoW library but still, it's worth trying.

local LNR_Private; -- holder for all our private workset

if oldMinor and oldMinor < MINOR then
    LNR_Private = LibStub(MAJOR):Quit(); -- ask the older library to destroy itself properly clearing all its local caches.
    if not LNR_Private.UpgradeHistory then
        LNR_Private.UpgradeHistory = "";
    end
    LNR_Private.UpgradeHistory = LNR_Private.UpgradeHistory .. oldMinor .. "-";
end

LNR_Private = LNR_Private or {};

local LNR_Public, oldMinor = LibStub:NewLibrary(MAJOR, MINOR)
if not LNR_Public then return end -- no upgrade required

local LNR_ENABLED = false; -- must stay local to the file, it's used to disable hooked Scripts which cannot be removed

LNR_Private.callbacks = LNR_Private.callbacks or LibStub("CallbackHandler-1.0"):New(LNR_Private);
LNR_Private.Fire      = LNR_Private.callbacks.Fire;


-- Manage embedding
LNR_Private.mixinTargets = LNR_Private.mixinTargets or {};

local Mixins = {"GetPlateName", "GetPlateReaction", "GetPlateType", "GetPlateGUID", "GetPlateByGUID", "GetPlateRegion", "EachPlateByName", "LNR_RegisterCallback", "LNR_UnregisterCallback", "LNR_UnregisterAllCallbacks" };

function LNR_Public:Embed(target)

    for _,name in pairs(Mixins) do
        target[name] = LNR_Public[name];
    end

    LNR_Private.mixinTargets[target] = true;

end

local function Debug(level, ...)
    LNR_Private:Fire("LNR_DEBUG", level, MINOR, ...);
end



--}}}

-- Lua and Blizzard upvalues {{{
local _G                    = _G;
local pairs                 = _G.pairs;
local select                = _G.select;
local setmetatable          = _G.setmetatable;
local twipe                 = _G.table.wipe;
local GetMouseFocus         = _G.GetMouseFocus;
local UnitExists            = _G.UnitExists;
local UnitGUID              = _G.UnitGUID;
local UnitName              = _G.UnitName;
local InCombatLockdown      = _G.InCombatLockdown;

local WorldFrame            = _G.WorldFrame;

--[===[@debug@
local tostring              = _G.tostring;
local assert                = _G.assert;
local unpack                = _G.unpack;
--@end-debug@]===]
-- }}}

-- CONSTANTS and library local variables {{{

-- Debug templates

local ERROR     = 1;
local WARNING   = 2;
local INFO      = 3;
local INFO2     = 4;



-- State variable that we keep local, when upgrading we restart from scratch
local PlateRegistry_per_frame   =  {};
local ActivePlates_per_frame    =  {};
local CurrentTarget             = false;
local HasTarget                 = false;
local TargetCheckScannedAll     = false;

--[===[@debug@
local callbacks_consisistency_check = {}; -- XXX
--@end-debug@]===]
--}}}

-- Clever cache tables: Frame_Children_Cache, Frame_Regions_Cache, Plate_Parts_Cache {{{ 

-- Various cache tables (WARNING: those shall be destroyed upon upgrading using :Quit())



local Frame_Children_Cache = setmetatable({}, {__index =
-- frame cache
function(t, frame)

    t[frame] = setmetatable({}, {__index =
            -- children per number cache
            function(t, childNum)

                t[childNum] = (select(childNum, frame:GetChildren())) or false;

                if not t[childNum] then
                    t[childNum] = nil;
                    LNR_Private:FatalIncompatibilityError('NAMEPLATE_MANIFEST');
                    error("CFCache: Child" .. childNum .. " not found.");
                end

                --[===[@debug@
                Debug(INFO, 'cached a new frame child', childNum);
                --@end-debug@]===]
                return  t[childNum];

            end
        })
    
    return t[frame];
end

});

local Frame_Regions_Cache = setmetatable({}, {__index =
-- frame cache
function(t, frame)
    -- region cache
    t[frame] = setmetatable({}, {__index =
            -- children per number cache
            function(t, regionNum)

                t[regionNum] = (select(regionNum, frame:GetRegions())) or false;

                if not t[regionNum] then
                    t[regionNum] = nil;
                    LNR_Private:FatalIncompatibilityError('NAMEPLATE_MANIFEST');
                    error( "CFCache: Region" .. regionNum .. " not found.");
                end

                --[===[@debug@
                Debug(INFO, 'cached a new frame region', regionNum);
                --@end-debug@]===]
                return t[regionNum];

            end
        })
        return t[frame];
    end
});


-- we could fuse Frame_Regions_Cache and Frame_Children_Cache into this one but
-- it's best to keep the three of them for better clarity
local Plate_Parts_Cache = setmetatable ({}, {__index =

function (t, plateFrame)
    t[plateFrame] = setmetatable({}, {__index =
        function (t, regionName)
            if regionName == 'name' then
                t[regionName] = Frame_Regions_Cache[  Frame_Children_Cache[plateFrame][2]  ][1];
            elseif regionName == 'statusBar' then
                t[regionName] = Frame_Children_Cache[  Frame_Children_Cache[plateFrame][1]  ][1];
            elseif regionName == 'highlight' then
                t[regionName] = Frame_Regions_Cache[  Frame_Children_Cache[plateFrame][1]  ][3];
            elseif regionName == 'level' then
                t[regionName] = Frame_Regions_Cache[  Frame_Children_Cache[plateFrame][1]  ][4];
            elseif regionName == 'raidIcon' then
                t[regionName] = Frame_Regions_Cache[  Frame_Children_Cache[plateFrame][1]  ][6];
            elseif regionName == 'eliteIcon' then
                t[regionName] = Frame_Regions_Cache[  Frame_Children_Cache[plateFrame][1]  ][7];
            else
                return false;
            end
            --[===[@debug@
            Debug(INFO, 'cached a new plateFrame part:', regionName);
            --@end-debug@]===]
            return t[regionName];
        end
    })
    return t[plateFrame];
end
})

-- }}}

--Name to GUID cache mechanism for players (their GUID are constant) -- AddGUIDToCache, GetGUIDFromCache, GUIDCacheQuit {{{
do
    local NameToGUID = {['FRIENDLY'] = {}, ['HOSTILE'] = {}, ["NEUTRAL"] = {}};
    local KnownNames = {};
    local data, oldName;
    local LIMIT = 200;
    local CurrentCacheIndex = 1;


    function LNR_Private:AddGUIDToCache(data)

        if data.type ~= 'PLAYER' then
            return;
        end

        oldName = KnownNames[CurrentCacheIndex];

        if oldName then
            if NameToGUID['FRIENDLY'][oldName] then NameToGUID['FRIENDLY'][oldName] = nil; end
            if NameToGUID['HOSTILE'][oldName]  then NameToGUID['HOSTILE'] [oldName] = nil; end
            if NameToGUID['NEUTRAL'][oldName]  then NameToGUID['NEUTRAL'] [oldName] = nil; end
        end

        KnownNames[CurrentCacheIndex] = data.name;

        NameToGUID[data.reaction][data.name] = data.GUID;

        CurrentCacheIndex = CurrentCacheIndex % LIMIT + 1;
        Debug(INFO, 'AddGUIDToCache() CurrentCacheIndex=', CurrentCacheIndex);
    end


    function LNR_Private:GetGUIDFromCache(frame)
        data = PlateRegistry_per_frame[frame];

        if data.type ~= 'PLAYER' then
            return false;
        end

        return NameToGUID[data.reaction][data.name] or false;
    end

    function LNR_Private:GUIDCacheQuit()
        twipe(NameToGUID); NameToGUID = nil;
        twipe(KnownNames); KnownNames = nil;
    end

end -- }}}

-- Internal helper private methods {{{

-- This method shall never be made public for it must be used in a particular
-- way to be reliable. To find if a nameplate is targeted the user needs to use
-- the callback LNR_ON_TARGET_PLATE_ON_SCREEN
function LNR_Private:IsPlateTargeted (frame)
    if not HasTarget then
        return false;
    end

    if CurrentTarget == frame then -- we already told you
        --[===[@debug@
        Debug(WARNING, 'CurrentTarget == frame');
        --@end-debug@]===]
        return true;
    elseif CurrentTarget then -- we know it's not that one
        return false;
    end

    if not ActivePlates_per_frame[frame] or not ActivePlates_per_frame[frame].name then -- it's not even on the screen...
        return false;
    end

    if frame:GetAlpha() == 1 then
        CurrentTarget = frame;
        --[===[@debug@
        Debug(WARNING, 'frame:GetAlpha() == 1');
        --@end-debug@]===]
        return true;
    else
        CurrentTarget = false;
        return false;
    end

end


function LNR_Private.RawGetPlateName (frame)

    local name = Plate_Parts_Cache[frame].name:GetText();

    -- remove the " (*)" if necessary
    if name:sub(-4) == " (*)" then
        name = name:sub(1, -5);
    end

    return name;
end


--[===[@debug@
-- this is used to diagnos colors when debugging
local DiffColors = { ['r'] = {}, ['g'] = {}, ['b'] = {}, ['a'] = {} };
local DiffColors_ExpectedDiffs = 0;
--@end-debug@]===]

function LNR_Private.RawGetPlateType (frame)

    local r, g, b, a = Plate_Parts_Cache[frame].statusBar:GetStatusBarColor();

    --[===[@debug@
    DiffColors['r'][r] = true;
    DiffColors['g'][g] = true;
    DiffColors['b'][b] = true;
    DiffColors['a'][a] = true;
    --@end-debug@]===]

    -- the following block is borrowed from TidyPlates
    if r < .01 then 	-- Friendly
        if b < .01 and g > .99 then return "FRIENDLY", "NPC" 
        elseif b > .99 and g < .01 then return "FRIENDLY", "PLAYER"
        end
    elseif r > .99 then
        if b < .01 and g > .99 then return "NEUTRAL", "NPC"
        elseif b < .01 and g < .01 then return "HOSTILE", "NPC" 
        end
    elseif r > .53 then
        if g > .5 and g < .6 and b > .99 then return "TAPPED", "NPC" end 	-- .533, .533, .99	-- Tapped Mob
    end

    return "HOSTILE", "PLAYER" 
end


do

    local PlateData;

    function LNR_Private:UpdateCache (plateFrame) -- can be used on both active and hidden plates
        PlateData = PlateRegistry_per_frame[plateFrame]; -- data can only be true if the plate is actually shown

        PlateData.name = LNR_Private.RawGetPlateName(plateFrame);
        PlateData.reaction, PlateData.type = LNR_Private.RawGetPlateType(plateFrame);
        PlateData.GUID = LNR_Private:GetGUIDFromCache(plateFrame);
    end

    local function IsGUIDValid (plateFrame)
        if ActivePlates_per_frame[plateFrame].GUID and ActivePlates_per_frame[plateFrame].name == LNR_Private.RawGetPlateName(plateFrame) then
            return ActivePlates_per_frame[plateFrame].GUID;
        else
            ActivePlates_per_frame[plateFrame].GUID = false;
            return false;
        end
    end

    local Getters = {
        ['name'] = LNR_Private.RawGetPlateName,
        ['reaction'] = LNR_Private.RawGetPlateType, -- 1st
        ['type'] = function (plateFrame) return select(2, LNR_Private.RawGetPlateType(plateFrame)); end, -- 2nd
        ['GUID'] = IsGUIDValid,
    };
    function LNR_Private:ValidateCache (plateFrame, entry)
        PlateData = ActivePlates_per_frame[plateFrame];

        if not PlateData then
            return -1;
        end

        if not PlateData[entry] then
            return -2;
        end

        if PlateData[entry] == (Getters[entry](plateFrame)) then
            return 0;
        else
            Debug(WARNING, 'Cache validation failed for entry', entry, 'on plate named', PlateData.name);
            self:UpdateCache(plateFrame);
            return 1;
        end
    end
end

-- }}}


-- Diagnostics related methods {{{

function LNR_Private:CheckHookSanity()

    Debug(INFO, "CheckHookSanity() called");
    if InCombatLockdown() then
        return
    end

    local count = 0;
    local hookInconsistency = false;

    for frame, data in pairs(PlateRegistry_per_frame) do

        count = count + 1;

        if frame:IsShown()then
            if not ActivePlates_per_frame[frame] then
                hookInconsistency = 'OnShow';
                Debug(ERROR, "CheckHookSanity(): OnShow hook failed");
            end
        else
            if ActivePlates_per_frame[frame] then
                hookInconsistency = 'OnHide';
                Debug(ERROR, "CheckHookSanity(): OnHide hook failed");
            end
        end
    end

    if hookInconsistency then
        self:FatalIncompatibilityError('HOOK: '..hookInconsistency);
    end

end
function LNR_Private:GetBAddon (StackLevel)
    local stack = debugstack(1 + StackLevel,2,0);
    if not stack:lower():find("\\libs\\")
        and not stack:find("[/\\]AceHook")
        and not stack:find("[/\\]CallbackHandler")
        and not stack:find("[/\\]AceTimer")
        and not stack:find("[/\\]AceEvent") then

        return stack:match("[/\\]AddOns[/\\]([^/\\]+)[/\\]"), stack;
    else
        Debug(WARNING, 'SetScript() called but not reported:', stack);
        return false;
    end
end

--[===[@debug@
do
    local ShownPlateCount = 0;
    local DiffColorsCount = 0;
    function LNR_Private:DebugTests()

        --Debug(INFO2, 'DebugTests() called');
        -- check displayed plates
        local count = 0; local names = {};
        for frame in pairs(ActivePlates_per_frame) do
            count = count + 1;
            --table.insert(names, PlateRegistry_per_frame[frame].name);
            --table.insert(names, '['.. PlateRegistry_per_frame[frame].type .. ']' .. ', ');
        end

        if count ~= ShownPlateCount then
            ShownPlateCount = count;
            Debug(INFO2, DiffColorsCount, ' dCs - ', ShownPlateCount, 'plates are shown:', unpack(names));
        end

        -- check number of different health bars colors
        local counts = {['r'] = 0, ['g'] = 0, ['b'] = 0, ['a'] = 0};
        count = 0;
        for component,values in pairs(DiffColors) do
            for value in pairs(values) do
                counts[component] = counts[component] + 1;
                count = count + 1;
            end
        end

        if count ~= DiffColorsCount then

            DiffColorsCount = count;
            Debug(INFO2, DiffColorsCount, 'health colors:', 'r=', counts['r'], 'g=', counts['g'], 'b=', counts['b'], 'a=', counts['a']);
        end

    end
end
--@end-debug@]===]

-- }}}


-- - plate hooks methods :  PlateOnShow, PlateOnHide, PlateOnChange {{{


local PlateOnShow, PlateOnHide, PlateOnChange; -- these functions cannot be upgraded
do 
    local PlateFrame, PlateData, PlateName;
    --[===[@debug@
    local testCase1 = false;
    --@end-debug@]===]

    function PlateOnShow (LNR_ShowHideHookFrame)
        --Debug(INFO, "PlateOnShow", healthBar.LNR_ParentPlate:GetName());

        if not LNR_ENABLED then
            return;
        end

        PlateFrame = LNR_ShowHideHookFrame.LNR_ParentPlate;

        -- PlateFrame = healthBar.LNR_ParentPlate;

        --[===[@debug@
        testCase1 = false;
        if ActivePlates_per_frame[PlateFrame] then -- test onHide hook
            testCase1 = true;
        end

        if not callbacks_consisistency_check[PlateFrame] then
            callbacks_consisistency_check[PlateFrame] = 1;
        else
            callbacks_consisistency_check[PlateFrame] = callbacks_consisistency_check[PlateFrame] + 1;
        end

        if callbacks_consisistency_check[PlateFrame] ~= 1 then
            Debug(ERROR, 'PlateOnShow/hide sync broken:', callbacks_consisistency_check[PlateFrame]);
        end

        --@end-debug@]===]

        PlateData = PlateRegistry_per_frame[PlateFrame];
        PlateName = LNR_Private.RawGetPlateName(PlateFrame);

        ActivePlates_per_frame[PlateFrame] = PlateData;

        if CurrentTarget == PlateFrame then
            CurrentTarget = false; -- it can't be true --> recycling occurred obviously
        end
        TargetCheckScannedAll = false;


        PlateData.name = PlateName;
        PlateData.reaction, PlateData.type = LNR_Private.RawGetPlateType(PlateFrame);
        PlateData.GUID = LNR_Private:GetGUIDFromCache(PlateFrame);

        LNR_Private:Fire("LNR_ON_NEW_PLATE", PlateFrame, PlateData);

        --[===[@debug@
        if testCase1 then
            error('onHide() failed for ' .. tostring(LNR_Private.RawGetPlateName(PlateFrame)));
        end
        --@end-debug@]===]
    end

    function PlateOnHide (LNR_ShowHideHookFrame)
        --Debug(INFO2, "PlateOnHide", healthBar.LNR_ParentPlate:GetName());

        if not LNR_ENABLED then
            return;
        end

        PlateFrame = LNR_ShowHideHookFrame.LNR_ParentPlate;

        if not ActivePlates_per_frame[PlateFrame] then
            LNR_Private:FatalIncompatibilityError('HOOK: OnShow missed');
            return;
        end

        --[===[@debug@
        if not callbacks_consisistency_check[PlateFrame] then
            callbacks_consisistency_check[PlateFrame] = 0;
        else
            callbacks_consisistency_check[PlateFrame] = callbacks_consisistency_check[PlateFrame] - 1;
        end
        --@end-debug@]===]

        PlateData = PlateRegistry_per_frame[PlateFrame];
        PlateData.GUID = false;

        LNR_Private:UpdateCache(PlateFrame); -- make sure everything is accurate
        LNR_Private:Fire("LNR_ON_RECYCLE_PLATE", PlateFrame, PlateData);


        if PlateFrame == CurrentTarget then
            CurrentTarget = false;
            Debug(INFO2, 'Current Target\'s plate was hidden');
        end

        ActivePlates_per_frame[PlateFrame] = nil;

    end

    function PlateOnChange (healthBar)

        if not LNR_ENABLED then
            return;
        end

        PlateFrame = healthBar.LNR_ParentPlate;

        PlateData = ActivePlates_per_frame[PlateFrame];

        if not PlateData then
            return;
        end

        -- if the name has changed or the reaction is different then trigger a recycling
        if PlateData.name ~= LNR_Private.RawGetPlateName(PlateFrame) or PlateData.reaction ~= (LNR_Private.RawGetPlateType(PlateFrame)) then
            --[===[@debug@
            Debug(WARNING, "PlateOnChange for '", PlateData.name, "' rawName:'", LNR_Private.RawGetPlateName(PlateFrame), 'r:', PlateData.reaction, PlateData.type, 'rawr:',  LNR_Private.RawGetPlateType(PlateFrame));
            --@end-debug@]===]
            
            -- we do not issue an LNR_ON_CHANGE_PLATE because we want to send
            -- the former PlateData to the recycling handler so add-ons can
            -- track what's happening. We could implement a LNR_ON_CHANGE_PLATE
            -- which would send both data set but this would imply a table copy
            -- operation and would be error prone... Here we prefer simplicity over elegance.
            LNR_Private:Fire("LNR_ON_RECYCLE_PLATE", PlateFrame, PlateData);

            LNR_Private:UpdateCache(PlateFrame);

            LNR_Private:Fire("LNR_ON_NEW_PLATE", PlateFrame, PlateData);

        end

    end
end -- }}}

-- Event handlers : PLAYER_TARGET_CHANGED, UPDATE_MOUSEOVER_UNIT, PLAYER_REGEN_ENABLED {{{


function LNR_Private:PLAYER_REGEN_ENABLED()
    self.EventFrame:UnregisterEvent('PLAYER_REGEN_ENABLED');
    self:Enable();
end


function LNR_Private:PLAYER_TARGET_CHANGED()
    
    Debug(INFO, 'Target Changed');

    if UnitExists('target') then
        HasTarget = true;
        -- Have we already cached that unit's GUID?
        CurrentTarget = (self:GetPlateByGUID(UnitGUID('target'))) or false;

        if CurrentTarget then
            self:Fire("LNR_ON_TARGET_PLATE_ON_SCREEN", CurrentTarget, ActivePlates_per_frame[CurrentTarget]);
        end

        TargetCheckScannedAll = false;
    else
        CurrentTarget = false; -- we don't know any more
        HasTarget = false;
    end

end

local HighlightFailsReported = false;
function LNR_Private:UPDATE_MOUSEOVER_UNIT()

    local unitName = "";
    if GetMouseFocus() == WorldFrame then -- the cursor is either on a name plate or on a 3d model (ie: not on a unit-frame)
        --Debug(INFO, "UPDATE_MOUSEOVER_UNIT");

        local failCount = 0;
        for frame, data in pairs(ActivePlates_per_frame) do
            if not data.GUID and Plate_Parts_Cache[frame].highlight:IsShown() then -- test for highlight among shown plates

                data.GUID = UnitGUID('mouseover');
                unitName = UnitName('mouseover');

                if unitName == data.name and self:ValidateCache(frame, 'name') == 0 then
                    self:AddGUIDToCache(data);
                    self:Fire("LNR_ON_GUID_FOUND", frame, data.GUID, 'mouseover');
                    --[===[@debug@
                    Debug(INFO, 'Guid found for', data.name, 'mouseover');
                    --@end-debug@]===]

                    break; -- we found what we were looking for, no need to continue
                else
                    Debug(HighlightFailsReported and INFO2 or WARNING, 'bad cache on highlight check:', unitName, "V/S:", data.name, 'mouseover');
                    failCount = failCount + 1;
                end
                
                
            end
        end

        if failCount > 3 and not HighlightFailsReported then
            HighlightFailsReported = true;
            self:Fire("LNR_ERROR_GUID_ID_HAMPERED", "|cFFFF0000WARNING:|r Another add-on is unduly modifying Blizzard's default nameplates' manifest (probably by using |cFFFFAA55:SetParent()|r) preventing "..MAJOR.." from identifying nameplates accurately. You should report this to the problematic add-on's author.");
        end

    end
end

-- }}}

do -- - Main plate tracking mechanism : :LookForNewPlates(), :CheckPlatesForTarget() {{{

    local hooksecurefunc = _G.hooksecurefunc;
    local CreateFrame    = _G.CreateFrame;
    local WorldFrame = WorldFrame;
    local WorldFrameChildrenNumber = 0;
    local temp = 0;
    local actualChildren = 0;
    local frameName;
    local NotPlateCache = {};
    local DidSnitched = false;
    local HealthBar;

    local function SetParentAlert (frame)
        if not LNR_ENABLED then
            return;
        end

        if DidSnitched then
            return;
        end

        local baddon = LNR_Private:GetBAddon(2);

        if baddon then
            DidSnitched = true;

            local alertMessage = "|cFFFF0000WARNING:|r Apparently the add-on |cffee2222" .. baddon:upper() .. "|r is reparenting Blizzard's nameplates elements. This prevent any other add-on from reading or modifying nameplates. You should contact |cffee2222" .. baddon:upper() .. "|r's author about this.";

            LNR_Private:Fire("LNR_ERROR_SETPARENT_ALERT", baddon, alertMessage);
        end

    end

    local function SetScriptAlert(frame, script, func)
        if not LNR_ENABLED  or script ~= "OnMinMaxChanged" then
            return;
        end
        local baddon, proof = LNR_Private:GetBAddon(2);

        -- If an add-on hooks the scripts using AceHook, our original hook is
        -- still called so we mustn't rehook...
        if baddon then
            -- re-apply our hooks then...
            if script == "OnMinMaxChanged" then
                frame:HookScript("OnMinMaxChanged", PlateOnChange);
            end
        end

        --[===[@debug@
        --Debug(WARNING, "SetScript(OnSHow/Onhide) detected", frame, frame:GetName(), script);
        --@end-debug@]===]

        if not DidSnitched then
            -- try to identify and report the add-on doing this selfish and stupid thing
            if baddon then
                DidSnitched = true;

                local alertMessage = "|cFFFF0000WARNING:|r Apparently the add-on |cffee2222" .. baddon:upper() .. "|r is using |cFFFFAA55:SetScript()|r instead of |cFF00DD00:HookScript()|r on Blizzard's nameplates. This will cause many issues with other add-ons relying on nameplates. You should contact |cffee2222" .. baddon:upper() .. "|r's author about this. Offending call:";

                LNR_Private:Fire("LNR_ERROR_SETSCRIPT_ALERT", baddon, proof, alertMessage);
            end
        end
    end

    local function IsPlate (frame)

        if NotPlateCache[frame] then
            --[===[@debug@
            Debug(INFO, 'not plate cache used:', NotPlateCache[frame]);
            --@end-debug@]===]
            return false
        end

        frameName = frame:GetName();
        if frameName and frameName:sub(1,9) == 'NamePlate' then
            return true;
        end

        NotPlateCache[frame] = true;
        --[===[@debug@
        NotPlateCache[frame] = frameName;
        --@end-debug@]===]
        

        return false;
    end

    local function RegisterNewPlates (worldChild, ...)

        if not worldChild then
            --[===[@debug@
            Debug(INFO, 'No more children', temp, 'frames checked');
            --@end-debug@]===]
            return;
        end

        --[===[@debug@
        actualChildren = actualChildren + 1;
        --@end-debug@]===]

        if not PlateRegistry_per_frame[worldChild] and IsPlate(worldChild) then
            --[===[@debug@
            Debug(INFO, 'New plate frame (fname: ', worldChild:GetName() , ')');
            --@end-debug@]===]

            -- keep a reference
            PlateRegistry_per_frame[worldChild] = {};

            --HealthBar = Frame_Children_Cache[ Frame_Children_Cache[worldChild][1] ][1];
            HealthBar = Plate_Parts_Cache[worldChild].statusBar;
            HealthBar.LNR_ParentPlate = worldChild;

            if not worldChild.LNR_ShowHideHookFrame then
                worldChild.LNR_ShowHideHookFrame = CreateFrame("Frame", nil, worldChild);
                worldChild.LNR_ShowHideHookFrame.LNR_ParentPlate = worldChild;
                
            end
            worldChild.LNR_ShowHideHookFrame:Show();

            -- hooks show and hide event
            worldChild.LNR_ShowHideHookFrame:SetScript("OnShow", PlateOnShow);
            worldChild.LNR_ShowHideHookFrame:SetScript("OnHide", PlateOnHide);

            HealthBar:HookScript("OnMinMaxChanged", PlateOnChange);

            hooksecurefunc(worldChild, 'SetScript', SetScriptAlert);
            hooksecurefunc(HealthBar, 'SetParent', SetParentAlert); -- just to detect baddons

            if worldChild:IsShown() then
                PlateOnShow(worldChild.LNR_ShowHideHookFrame);
            end



            --[===[@debug@
        elseif PlateRegistry_per_frame[worldChild] then

            assert(not ActivePlates_per_frame[worldChild] == not worldChild:IsShown(), 'OnHide/Show hook failure: ' .. tostring(ActivePlates_per_frame[worldChild]).." != "..tostring(worldChild:IsShown()));
            
            --@end-debug@]===]
        end

        RegisterNewPlates(...);

    end

    function LNR_Private:LookForNewPlates()
        temp =  WorldFrame:GetNumChildren();

        if temp ~= WorldFrameChildrenNumber then

            --[===[@debug@
            Debug(INFO, "WorldFrame gave birth to", temp - WorldFrameChildrenNumber);
            --@end-debug@]===]

            WorldFrameChildrenNumber = temp;

            --[===[@debug@
            actualChildren = 0; -- used to count the number of checked frame for profiling purposes
            --@end-debug@]===]
            RegisterNewPlates(WorldFrame:GetChildren());
        end
    end

    local ForceTargetCheck = false;
    function LNR_Private.SetForceTargetCheck(bool)
        ForceTargetCheck = bool;
    end

    function LNR_Private:CheckPlatesForTarget() -- run by a timer, only active when a target exists
        if CurrentTarget or TargetCheckScannedAll or not HasTarget then
            return;
        end

        local unitName = "";

        --[===[@debug@
        Debug(INFO, 'looking for targeted plate');
        --@end-debug@]===]

        for frame, data in pairs(ActivePlates_per_frame) do
            if (not data.GUID or ForceTargetCheck) and self:IsPlateTargeted(frame) then

                unitName = UnitName('target');

                if unitName == data.name and self:ValidateCache(frame, 'name') == 0 then

                    if not data.GUID then
                        data.GUID = UnitGUID('target');
                        self:AddGUIDToCache(data);
                        self:Fire("LNR_ON_GUID_FOUND", frame, data.GUID, 'target');
                        --[===[@debug@
                        Debug(INFO, 'Guid found for', data.name, 'target');
                        --@end-debug@]===]
                    end

                    self:Fire("LNR_ON_TARGET_PLATE_ON_SCREEN", frame, data);
                else
                    CurrentTarget = false; -- IsPlateTargeted got it wrong so let's try again
                end

                break; -- there can be only one target
            end
        end

        TargetCheckScannedAll = true; -- no need to scan continuously if no new name plate are shown
    end

    function LNR_Private:QuitPlateTracking()
        twipe(NotPlateCache); NotPlateCache = nil;
        IsPlate = nil;
        RegisterNewPlates = nil;

        LNR_Private.QuitPlateTracking = nil;
    end

end -- }}}


-- public methods: :GetPlateName(), :GetPlateReaction(), :GetPlateType(), :GetPlateGUID(), :GetPlateByGUID(), :GetPlateRegion(), :EachPlateByName() {{{

--- ==LibNameplateRegistry-1.0 public API documentation\\\\
-- Check the [[http://www.wowace.com/addons/libnameplateregistry-1-0/pages/callbacks/|Callbacks' page]] if you want details about those.\\\\
--
-- Here is a fully working little add-on as an example displaying nameplates' information as they become available.\\
-- You can download a ready to go archive of this example add-on [[http://www.j2072.teaser-hosting.com/dropbox/example.rar|here]]\\\\
--
-- For a more advanced usage example you can take a look at the [[http://www.wowace.com/addons/healers-have-to-die/files/|latest version of Healers Have To Die]].\\
--
-- @usage
-- local ADDON_NAME, T = ...;
-- 
-- -- Create a new Add-on object using AceAddon
-- T.Example = LibStub("AceAddon-3.0"):NewAddon("Example", "LibNameplateRegistry-1.0");
--
-- -- You could also use LibNameplateRegistry-1.0 directly:
-- T.Example2 = {};
-- LibStub("LibNameplateRegistry-1.0"):Embed(T.Example2); -- embedding is optional of course but way more convenient
--
--
-- local Example = T.Example;
-- 
-- function Example:OnEnable()
--     -- Subscribe to callbacks
--     self:LNR_RegisterCallback("LNR_ON_NEW_PLATE"); -- registering this event will enable the library else it'll remain idle
--     self:LNR_RegisterCallback("LNR_ON_RECYCLE_PLATE");
--     self:LNR_RegisterCallback("LNR_ON_GUID_FOUND");
--     self:LNR_RegisterCallback("LNR_ERROR_FATAL_INCOMPATIBILITY");
-- end
-- 
-- function Example:OnDisable()
--     -- unregister all LibNameplateRegistry callbacks, which will disable it if
--     -- your add-on was the only one to use it
--     self:LNR_UnregisterAllCallbacks();
-- end
-- 
-- 
-- function Example:LNR_ON_NEW_PLATE(eventname, plateFrame, plateData)
--     print(ADDON_NAME, ":", plateData.name, "'s nameplate appeared!");
--     print(ADDON_NAME, ":", "It's a", plateData.type, "and", plateData.reaction,
--           plateData.GUID and ("we know its GUID: " .. plateData.GUID) or "GUID not yet known");
-- end
-- 
-- 
-- function Example:LNR_ON_RECYCLE_PLATE(eventname, plateFrame, plateData)
--     print(ADDON_NAME, ":", plateData.name, "'s nameplate disappeared!");
-- end
-- 
-- 
-- function Example:LNR_ON_GUID_FOUND(eventname, frame, GUID, findmethod)
--     print(ADDON_NAME, ":", "GUID found using", findmethod, "for", self:GetPlateName(frame), "'s nameplate:", GUID);
-- end
-- 
-- 
-- function Example:LNR_ERROR_FATAL_INCOMPATIBILITY(eventname, icompatibilityType)
--     -- Here you want to check if your add-on and LibNameplateRegistry are not
--     -- outdated (old TOC). if they're both up to date then it means that
--     -- another add-on author thinks his add-on is more important than yours. In
--     -- this later case you can register LNR_ERROR_SETPARENT_ALERT and
--     -- LNR_ERROR_SETSCRIPT_ALERT which will detect such behaviour and will give
--     -- you the name of the incompatible add-on so you can inform your users properly
--     -- about what's happening instead of just silently "not working".
-- end
-- 
--
-- @class file
-- @name LibNameplateRegistry-1.0.lua


--- Returns a nameplate's unit's name (removing the " (*)" suffix if present)
-- @name //addon//:GetPlateName
-- @param plateFrame the platename's root frame
-- @return The name of the unit as displayed on the nameplate or nil
function LNR_Public:GetPlateName(plateFrame)

    --[===[@debug@
    if ActivePlates_per_frame[plateFrame] and ActivePlates_per_frame[plateFrame].name and ActivePlates_per_frame[plateFrame].name ~= LNR_Private.RawGetPlateName(plateFrame) then
        error('GN: Nameplate inconsistency detected: rpn:' .. tostring(ActivePlates_per_frame[plateFrame].name) .. ' rawpn:' .. tostring(LNR_Private.RawGetPlateName(plateFrame)));
    end
    --@end-debug@]===]

    return ActivePlates_per_frame[plateFrame] and ActivePlates_per_frame[plateFrame].name or nil;
end

--- Gets a nameplate's unit's reaction toward the player
-- @name //addon//:GetPlateReaction
-- @param plateFrame the platename's root frame
-- @return either "FRIENDLY", "NEUTRAL", "HOSTILE", "TAPPED" or nil
function LNR_Public:GetPlateReaction (plateFrame)
    return ActivePlates_per_frame[plateFrame] and ActivePlates_per_frame[plateFrame].reaction or nil;
end

--- Gets a nameplate's unit's type
-- @name //addon//:GetPlateType
-- @param plateFrame the platename's root frame
-- @return either "NPC", "PLAYER" or nil
function LNR_Public:GetPlateType (plateFrame)
    return ActivePlates_per_frame[plateFrame] and ActivePlates_per_frame[plateFrame].type or nil;
end

--- Gets a nameplate's unit's GUID if known
-- @name //addon//:GetPlateGUID
-- @param plateFrame the platename's root frame
-- @return associated unit's GUID as returned by the UnitGUID() WoW API or nil if the GUID is unknown
function LNR_Public:GetPlateGUID (plateFrame)
    return ActivePlates_per_frame[plateFrame] and ActivePlates_per_frame[plateFrame].GUID or nil;
end

--- Gets a platename's frame and known associated plateData using a GUID
-- @name //addon//:GetPlateByGUID
-- @param GUID a unit GUID as returned by UnitGUID() WoW API
-- @return plateFrame, plateData or nil
function LNR_Public:GetPlateByGUID (GUID)

    if GUID then
        for frame, data in pairs(ActivePlates_per_frame) do
            if data.GUID == GUID and LNR_Private:ValidateCache(frame, 'GUID') == 0 then
                return frame, data;
            end
        end
    end

    return nil;

end
LNR_Private.GetPlateByGUID = LNR_Public.GetPlateByGUID;


--- (WIP current alpha only) Gets a platename's frame specific region using a normalized name.
--
-- Use this API to get an easy and direct access to a specific sub-frame of any
-- nameplate. This is useful if you want to access data for which
-- LibNameplateRegistry provides no API (yet).
--
-- The result is cached for each frame making subsequent identical calls very fast.
--
-- The following regions are supported: 'name', 'statusBar', 'highlight', 'level', 'raidIcon', 'eliteIcon'.
-- If you need to access a specific region which is not supported, please make
-- a feature request using the ticket system.
--
-- @name //addon//:GetPlateRegion
-- @param plateFrame the platename's root frame
-- @param internalRegionNormalizedName a normalized name referring to a specific region
-- @return region or throws an error if asked an unsupported region's name.
function LNR_Public:GetPlateRegion (plateFrame, internalRegionNormalizedName)

    local region = Plate_Parts_Cache[plateFrame][internalRegionNormalizedName];

    if region == false then
        error(("Unknown nameplate region: '%s'."):format(tostring(internalRegionNormalizedName)), 2);
    end

    return region;
end


do
    local CurrentPlate;
    local Data, Name;
    local next = _G.next;
    local function iter ()
        CurrentPlate, Data = next (ActivePlates_per_frame, CurrentPlate);

        if not CurrentPlate then
            return nil;
        end

        if Name == Data.name and LNR_Private:ValidateCache(CurrentPlate, 'name') == 0 then -- ValidateCache() will fail only rarely (upon mind control events) so it's not a big deal if we miss a few frames then... (to keep in mind)
            return CurrentPlate, Data;
        else
            return iter();
        end

    end

    --- Returns an iterator to iterate through all nameplates sharing an identical name\\
    --
    -- Used to iterate through nameplates using their names.\\\\
    -- Since nameplates are not necessary unique it's best to always use this
    -- method to get a nameplate's frame through it's name.
    --
    -- @name //addon//:EachPlateByName
    --
    -- @param name The name you want to iterate with
    --
    -- @usage
    --
    -- for frame, plateData in self:EachPlateByName(unitName) do
    -- -- code
    -- end
    --
    -- @return iterator 
    function LNR_Public:EachPlateByName (name)
        CurrentPlate = nil;
        Name = name;

        return iter;
    end
end -- }}}

--- Registers a LibNameplateRegistry callback\\
-- It's simply wrapping CallbackHandler-1.0's RegisterCallback() method.
--
-- @name //addon//:LNR_RegisterCallback
--
-- @paramsig callbackName [, method] [, extraArg]
--
-- @param callbackName name of a callback (see the [[http://www.wowace.com/addons/libnameplateregistry-1-0/pages/callbacks/|Callbacks' page]])
--
-- @param method (optional) The method to call when the callback fires, if ommitted, addon:eventname is used
--
-- @param ... (optional) An optional extra argument that is past to your handler as first argument (after 'self')

function LNR_Public:LNR_RegisterCallback (callbackName, method, ...)
    LNR_Private.RegisterCallback(self, callbackName, method, ...);
end

--- Unregisters a LibNameplateRegistry callback (see CallbackHandler-1.0 documentation)
-- @name //addon//:LNR_UnregisterCallback
-- @param callbackName the callback to stop tracking
function LNR_Public:LNR_UnregisterCallback (callbackName)
    LNR_Private.UnregisterCallback(self, callbackName);
end

--- Unregisters all LibNameplateRegistry callbacks
-- @name //addon//:LNR_UnregisterAllCallbacks
function LNR_Public:LNR_UnregisterAllCallbacks ()
    LNR_Private.UnregisterAllCallbacks(self);
end



-- == end of official public APIs ==



-- Blizzard event management
function LNR_Private.OnEvent(frame, event, ...)
    LNR_Private[event](LNR_Private, event, ...);
end

LNR_Private.EventFrame = LNR_Private.EventFrame or CreateFrame("Frame");
LNR_Private.EventFrame:Hide();
LNR_Private.EventFrame:SetScript("OnEvent", LNR_Private.OnEvent);


-- Internal timers management -- {{{
if not LNR_Private.Anim  then
  LNR_Private.Anim = LNR_Private.EventFrame:CreateAnimationGroup();
end
if not LNR_Private.Timer then
  LNR_Private.Timer = LNR_Private.Anim:CreateAnimation();
end

LNR_Private.Anim:SetLooping("REPEAT");
LNR_Private.Timer:SetDuration(0.1);

local TimerDivisor = 0
LNR_Private.Timer:SetScript('OnFinished', function()

    -- if a major incompatibility has been found
    if LNR_Private.FatalIncompatibilityDelayedFire then
        LNR_Private.FatalIncompatibilityDelayedFire();
        return;
    end

    -- Check sanity every 100th tick
    TimerDivisor = TimerDivisor % 101 + 1;

    -- Look for new plates
    LNR_Private:LookForNewPlates()

    -- Look for target plate
    if HasTarget then
        LNR_Private:CheckPlatesForTarget()
    end

    if TimerDivisor == 100 then
        LNR_Private:CheckHookSanity()
    end

    --[===[@debug@
    if TimerDivisor % 10 == 0 then
        LNR_Private:DebugTests()
    end
    --@end-debug@]===]

end); -- }}}


LNR_Private.UsedCallBacks = 0;
-- Enable or Disable depending on our main callback usage
function LNR_Private.callbacks:OnUsed(target, eventname)

    LNR_Private.UsedCallBacks = LNR_Private.UsedCallBacks + 1;

    --Debug(INFO, "OnUsed", eventname);
    if LNR_Private.UsedCallBacks == 1 then
        LNR_Private:Enable();
    end

    if eventname == "LNR_ON_TARGET_PLATE_ON_SCREEN" then
        LNR_Private.SetForceTargetCheck(true);
    end
end

function LNR_Private.callbacks:OnUnused(target, eventname)

    LNR_Private.UsedCallBacks = LNR_Private.UsedCallBacks - 1;

    --Debug(INFO2, "OnUnused", eventname);
    if LNR_Private.UsedCallBacks == 0 then
        LNR_Private:Disable();
    end

    if eventname == "LNR_ON_TARGET_PLATE_ON_SCREEN" then
        LNR_Private.SetForceTargetCheck(false);
    end
end







function LNR_Private:Enable() -- {{{
    -- if we try to enable ourself while in combat blizzard might destroy the
    -- library with a SCRIPT_RAN_TO_LONG Lua exception...
    if InCombatLockdown() then
        Debug(WARNING, ":Enable(), InCombatLockdown, will retry later...");
        self.EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
        
        return
    end

    Debug(INFO, "Enable", LNR_ENABLED, debugstack(1,2,0));
    LNR_ENABLED = true;

    self.EventFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
    self.EventFrame:RegisterEvent("UPDATE_MOUSEOVER_UNIT");

    -- Enable timer execution
    LNR_Private.EventFrame:Show();
    LNR_Private.Anim:Play();

    -- if we were just temporarily disabled then our status is wrong (plate
    -- might have been shown and hidden and thus recycled), we must set things right.
    --
    -- We need to do several passes because we need to make things happen as they
    -- would have in reality else inconsistency may happen in library's users' code...
    -- 1stly: bust ghosts frame
    -- 2ndly: update those still on screen
    -- 3rdly: show which are not

    for PlateFrame, data in pairs (PlateRegistry_per_frame) do

        -- update our cache so that the correct info about each plate is sent through our callbacks.
        self:UpdateCache(PlateFrame);

        -- plate is currently hidden
        if not PlateFrame:IsShown() then
            --  but thought as shown
            if ActivePlates_per_frame[PlateFrame] then
                PlateOnHide(PlateFrame.LNR_ShowHideHookFrame);
            end
        end
    end

    for PlateFrame, data in pairs (PlateRegistry_per_frame) do

        -- plate is currently shown
        if PlateFrame:IsShown() then
            -- it's still on screen, it might have changed though...
            if ActivePlates_per_frame[PlateFrame] then
                PlateOnChange(PlateFrame);
            end
        end
    end

    for PlateFrame, data in pairs (PlateRegistry_per_frame) do

        -- plate is currently shown
        if PlateFrame:IsShown() then
            -- but thought as hidden
            if not ActivePlates_per_frame[PlateFrame] then
                PlateOnShow(PlateFrame.LNR_ShowHideHookFrame);
            end
        end
    end


    local success, errorm = pcall(self.LookForNewPlates, self); -- make sure we do it once as soon as possible to hook things first in order to detect baddons...

    if not success and not errorm:find("CFCache") then
        Debug(WARNING, errorm);
    end

    self:PLAYER_TARGET_CHANGED(); -- a little kick in the butt to force GUID ID

end -- }}}


function LNR_Private:Disable() -- {{{
    Debug(INFO2, "Disable", debugstack(1,2,0));

    -- disable timers
    LNR_Private.Anim:Stop();
    LNR_Private.EventFrame:Hide();

    --[===[@debug@
    twipe(callbacks_consisistency_check);
    --@end-debug@]===]

    self.EventFrame:UnregisterAllEvents();

    LNR_ENABLED = false;
end -- }}}

-- /dump LibStub("LibNameplateRegistry-1.0"):GetUpgradeHistory()
function LNR_Public:GetUpgradeHistory()
    return LNR_Private.UpgradeHistory or false;
end

-- Quit the library properly and definitively destroying all private variables and functions to ensure a clean upgrade.
-- This is also called on catastrophic failure (incompatibility with WoW or other add-ons)
function LNR_Public:Quit()

    --[===[@debug@
    print("|cFFFF0000", MAJOR, MINOR, "Quitting|r");
    --@end-debug@]===]

    Debug(WARNING, "Quit called", debugstack(1,2,0));

    LNR_Private:Disable();

    -- Fire "LNR_ON_RECYCLE_PLATE" for all nameplate (all our hooks are invalid)
    for frame, data in pairs(PlateRegistry_per_frame) do

        -- play it safe if this version is bugged we want the upgraded one to behave
        if ActivePlates_per_frame[frame] or frame:IsShown() then
            LNR_Private:Fire("LNR_ON_RECYCLE_PLATE", frame, data);
        end

        -- remove our hooks and hide our hook frame
        frame.LNR_ShowHideHookFrame:SetScript("OnShow", nil);
        frame.LNR_ShowHideHookFrame:SetScript("OnHide", nil);
        frame.LNR_ShowHideHookFrame:Hide();
    end

    -- clear Blizzard Event handler
    LNR_Private.EventFrame:SetScript("OnEvent", nil);
    -- clear timer execution script
    LNR_Private.Timer:SetScript('OnFinished', nil);

    -- destroy local caches
    twipe(Frame_Children_Cache);  Frame_Children_Cache = nil;
    twipe(Frame_Regions_Cache);   Frame_Regions_Cache  = nil;
    twipe(Plate_Parts_Cache);     Plate_Parts_Cache    = nil;

    LNR_Private:GUIDCacheQuit(); -- this one could be kept but it's simpler to destroy it.
    LNR_Private:QuitPlateTracking();


    -- destroy private work state
    twipe(PlateRegistry_per_frame);    PlateRegistry_per_frame = nil;
    twipe(ActivePlates_per_frame);     ActivePlates_per_frame  = {}; -- so public method wont crash
    CurrentTarget             = nil;
    HasTarget                 = nil;
    TargetCheckScannedAll     = nil;
    TimerDivisor              = nil;

    --[===[@debug@
    callbacks_consisistency_check = nil;    
    --@end-debug@]===]


    -- clear all local methods

    Debug = nil;
    LNR_Public.Quit = function()end; -- if a previous version of the library crashes, this might be called again when upgrading
    LNR_Private.Enable = LNR_Public.Quit;
    LNR_Private.Disable = LNR_Public.Quit;

    return LNR_Private; -- return private stuff that can be useful

end
LNR_Private.Quit = LNR_Public.Quit;


function LNR_Private:FatalIncompatibilityError(icompatibilityType)
    LNR_ENABLED = false; -- will prevent hooks from hooking

    -- do not send the message right away because we don't know what's happening. (we might be inside a metatable's callback for all we know...)
    LNR_Private.FatalIncompatibilityDelayedFire = function(self)
        LNR_Private.FatalIncompatibilityDelayedFire = function()end;
        LNR_Private:Fire("LNR_ERROR_FATAL_INCOMPATIBILITY", icompatibilityType);
        LNR_Private:Quit();
        error(MAJOR..MINOR..' has died due to a serious incompatibility issue: ' .. icompatibilityType);
    end;

end


-- upgrade our mixins in all targets
for target,_ in pairs(LNR_Private.mixinTargets) do
    LNR_Public:Embed(target);
end

-- relaunch the lib if it was upgraded while enabled
if LNR_Private.UsedCallBacks ~= 0 then
    LNR_Private:Enable();
end
