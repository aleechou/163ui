U1RegisterAddon("Parrot", {
    title = "浮动战斗信息",
    defaultEnable = 0,

    tags = { TAG_BIG, TAG_COMBATINFO, },
    icon = [[Interface\Icons\Spell_Nature_ForceOfNature]],

    desc = "战斗信息滚动显示插件，可以显示技能图标等酷炫效果，通过命令：/parrot进入设置页面，可以设置滚动区域、条件触发等高级功能。",
    --toggle = function(name, info, enable, justload) end,

    {
        text = "配置选项",
        tip = "快捷命令`/parrot",
        callback = function(cfg, v, loading) SlashCmdList["ACECONSOLE_PARROT"]() end,
    },
    --[[------ Options --------
    {
        var = "",
        default = "",
        text = "",
        callback = function(cfg, v, loading) end,
    },
    --]]
});
