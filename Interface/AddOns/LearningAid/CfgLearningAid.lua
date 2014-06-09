U1RegisterAddon("LearningAid", {
    title = "新技能提示",
    defaultEnable = 1,

    tags = { TAG_INTERFACE },
    icon = [[Interface\Icons\Spell_BurningSoul]],
    desc = "当学习到新技能、获得新坐骑、新宠物后，弹出小窗口列出这些新学会的法术。`运行/la search搜寻不在技能栏上的技能。`命令/la config可以打开详细配置界面。",

    -------- Options --------
    {
        text = "列出所有技能",
        tip = "说明`列出当前不在技能栏上的所有技能`快捷命令：/la search",
        callback = function(cfg, v, loading) LearningAid:FindMissingActions(); end,
    },
    {
        text = "配置选项",
        tip = "快捷命令`/learningaid config",
        callback = function(cfg, v, loading) SlashCmdList["ACECONSOLE_LEARNINGAID"]("config"); end,
    },
    --]]
});
