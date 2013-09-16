U1RegisterAddon("LFGForwarder", {
    title = "转发组队消息",
    defaultEnable = 1,

    tags = { TAG_CHAT },
    icon = [[Interface\Icons\ACHIEVEMENT_GUILDPERK_HONORABLEMENTION]],
    desc = "在野外也可以看到组队频道的信息，插件由网易有爱warbaby原创奉献",

    author = "|cffcd1a1c[网易原创]|r",

    toggle = function(name, info, enable, justload)
        if justload then return end
        if enable then
            SlashCmdList["LFW"]("join");
        else
            SlashCmdList["LFW"]("leave!!");
        end
    end,

    -------- Options --------
    {
        var = "show",
        default = 1,
        text = "显示转发消息",
        getvalue = function() return LFW_SHOW end,
        callback = function(cfg, v, loading)
            if loading then return end
            if not not v ~= not not LFW_SHOW then SlashCmdList["LFW"](""); end
        end,
    },
    --]]
});
