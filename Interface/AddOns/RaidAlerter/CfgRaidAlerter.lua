U1RegisterAddon("RaidAlerter", {
    title = "团队警报",
    defaultEnable = 0,
    secure = 0,

    tags = { TAG_RAID, TAG_CHAT, },
    icon = [[Interface\Icons\spell_nature_tremortotem]],
    desc = "提供RAID和5人副本队伍的各种特色警报如：驱散、打断、MT血量危急、嘲讽抵抗、仇恨、猎人误导、被控制、打破控制和团队检查等。建议配合团队助手和首领模块一起使用。发送团队警报需要团长L或者助理A权限，小队报警则无需权限。``鼠标指向团队警告条可以看到快捷键操作提示。",

    frames = {"RaidAlerter_Attack_Frame"},

    -------- Options --------
    {
        var = "hide",
        text = "隐藏信息框",
        default = nil,
        callback = function(cfg, v, loading) CoreUIShowOrHide(RaidAlerter_Attack_Frame, not v)  end,
    },
    {
        text = "配置选项",
        callback = function(cfg, v, loading) SlashCmdList["RaidAlerter"]("") end,
    },
});
