U1RegisterAddon("Omen", {
    title = "仇恨监视",
    defaultEnable = 0,
    minimap = "LibDBIcon10_Omen",

    tags = { TAG_RAID, },
    icon = "Interface\\AddOns\\Omen\\icon",
    desc = "一个灵活的，多目标的，低资源占用的威胁值计量器。`快捷命令：/omen",

    -------- Options --------
    {
        text = "显示/隐藏监视窗",
        callback = function(cfg, v, loading) SlashCmdList["ACECONSOLE_OMEN"]("toggle") end,
    },
    {
        text = "配置选项",
        callback = function(cfg, v, loading) SlashCmdList["ACECONSOLE_OMEN"]("config") end,
    },
    --]]
});
