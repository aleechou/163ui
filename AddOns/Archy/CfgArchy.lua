U1RegisterAddon("Archy", {
    title = "考古助手",
    defaultEnable = 0,
    minimap = "LibDBIcon10_Archy",
    nopic = true,

    desc = "",
    tags = { TAG_TRADING, },
    icon = [[Interface\Icons\trade_archaeology]],

    toggle = function(name, info, enable, justload)
        if(justload) then return end
        if(enable) then
            Archy:Enable()
			if (Archy.db.profile.general.stealthMode) then
                Archy.db.profile.general.stealthMode = false
                Archy:ConfigUpdated()
            end
        else
			if (not Archy.db.profile.general.stealthMode) then
                Archy.db.profile.general.stealthMode = true
                Archy:ConfigUpdated()
            end
            Archy:Disable()
        end
    end,
});
