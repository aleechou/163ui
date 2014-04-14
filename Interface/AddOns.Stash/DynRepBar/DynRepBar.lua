--this mod sets the watched faction to the faction you last gained reputation from

function DynRepBar_OnLoad(self)
    -- Register Startup Events
    self:RegisterEvent("ADDON_LOADED");
    --DynRepBar_msg_to_chat("DynRep prep");
end

-- Event Handler
-- receives and handles the events
function DynRepBar_OnEvent(self, event, arg1)
    local faction
    --Player loaded completely
    if (event == "ADDON_LOADED") then
        if (strlower(arg1) == "dynrepbar") then
            --register faction change
            self:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
        end

    end

    --Player Reputation Gain
    if (event == "CHAT_MSG_COMBAT_FACTION_CHANGE") then
        --DynRepBar_msg_to_chat("Incoming: "..arg1);
        local _

        --Gain
        faction,_ = DynRepBarGlobalParser_ParseMessage(arg1, FACTION_STANDING_INCREASED)
        if faction then
            DynRepBar_changeBar(faction);
            return;
        end

        --LOST
        faction,_ = DynRepBarGlobalParser_ParseMessage(arg1, FACTION_STANDING_DECREASED)
        if faction then
            DynRepBar_changeBar(faction);
            return;
        end

        --Changed
        faction,_ = DynRepBarGlobalParser_ParseMessage(arg1, FACTION_STANDING_CHANGED)
        if faction then
            DynRepBar_changeBar(faction);
            return;
        end
        ---DynRepBar_msg_to_chat("Nothing matched 8["); ---todo: 公会声望 FACTION_STANDING_CHANGED_GUILD

    end

end

--Displays a message to chat
function DynRepBar_msg_to_chat(msg)
    if( DEFAULT_CHAT_FRAME ) then
        DEFAULT_CHAT_FRAME:AddMessage(msg);
    end
end

--change the watched faction
function DynRepBar_changeBar(faction)
    if faction==GUILD then faction = GetGuildInfo("player") end
    local oldName,_,_,_,_ = GetWatchedFactionInfo();
    --DynRepBar_msg_to_chat("Trying to set Faction "..faction.." from "..oldName);
    for i=1, GetNumFactions() do
        local name,_,_,_,_,_,_,_,_,_ = GetFactionInfo(i);
        --DynRepBar_msg_to_chat("found "..name.." "..i);
        if (name==faction) then
            if not(name==oldName)then
                --DynRepBar_msg_to_chat("set");
                SetWatchedFactionIndex(i);
            else  --DynRepBar_msg_to_chat("Already set to this");
            end
        else
            --DynRepBar_msg_to_chat("Not the right match")
        end
    end
end
