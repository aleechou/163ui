U1RegisterAddon("DynRepBar", {
    title = "自动切换声望条",
    defaultEnable = 1,
    parent = "163UI_Chat",

    tags = { TAG_CHAT },
    icon = [[Interface\Icons\Ability_Druid_EmpoweredRejuvination]],

    toggle = function(name, info, enable, justload)
        if enable then
            DynRepBar:RegisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
        else
            DynRepBar:UnregisterEvent("CHAT_MSG_COMBAT_FACTION_CHANGE");
        end
    end,
});
