U1RegisterAddon("TradeForwarder", {
    title = "转发交易消息",
    defaultEnable = 0,

    tags = { TAG_CHAT },
    icon = [[Interface\Icons\ACHIEVEMENT_GUILDPERK_HONORABLEMENTION_RANK2]],
    desc = "在野外也可以看到交易频道的信息，插件由网易有爱warbaby原创奉献",

    author = "|cffcd1a1c[网易原创]|r",

    toggle = function(name, info, enable, justload)
        if justload then return end
        if enable then
            SlashCmdList["TFW"]("join");
        else
            SlashCmdList["TFW"]("leave!!");
        end
    end,

    -------- Options --------
    {
        var = "show",
        default = 1,
        text = "显示转发消息",
        getvalue = function() return TFW_SHOW end,
        callback = function(cfg, v, loading)
            if loading then return end
            if not not v ~= not not TFW_SHOW then SlashCmdList["TFW"](""); end
        end,
    },
    --]]
});
