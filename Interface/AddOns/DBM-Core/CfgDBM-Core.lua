U1RegisterAddon("DBM-Core", {
    title = "首领模块",
    defaultEnable = 1,
    load = "NORMAL", --很奇怪的问题, DBM-Core.lua:1142
    minimap = "DBMMinimapButton",
    frames = {"DBMMinimapButton"},
    modifier = "CallMeJames",
    tags = { TAG_RAID, TAG_BIG },
    icon = [[Interface\Icons\INV_Helmet_06]],
    desc = "DBM是一款强大的老牌首领报警插件，让你在RAID副本中游刃有余。可以在屏幕上显示各种计时条，BOSS血量、警报信息等；团长使用时还可以自动对怪物标记团队目标。同时提供距离监视模块，可以选择文字框架和雷达框架。``网易有爱提供了大裂变所需的各个模块，并采用|cffffffffCallMeJames|r发布的语音版，在屏幕提示的同时给出详细的语音警报。老副本的模块需自行下载。``注：各个子模块不要手工启用/停用，会根据当前副本自动加载。",
    pics = 3,

    --toggle = function(name, info, enable, justload) end,

    iconTip = "$title`显示距离提示窗",
    iconFunc = function()
        if DBM.RangeCheck:IsShown() then DBM.RangeCheck:Hide() else DBM.RangeCheck:Show() end
    end,
    --children = {"^DBM%-*"},

    --[------ Options --------
    {
        var="range",
        text="显示DBM距离提示窗",
        tip="说明`显示一个窗口显示和其他团员之间的距离。右键点击窗口可以设置距离、雷达模式等选项。",
        callback = function(cfg, v, loading) if(v)then DBM.RangeCheck:Show() else DBM.RangeCheck:Hide() end end,
    },
    {
        var="movie",
        text="禁用所有过场电影",
        getvalue = function() return DBM.Options.DisableCinematics end,
        callback = function(cfg, v, loading) DBM.Options.DisableCinematics = not not v end,
    },
    {
        text="测试计时条",
        callback = function(cfg, v, loading) DBM:DemoMode() end,
    },
    {
        text="配置选项",
        callback = function(cfg, v, loading) SlashCmdList["DEADLYBOSSMODS"]("") end,
    },
    --]]
});

U1RegisterAddon("DBM-StatusBarTimers", {title = "状态条计时器", load = "LOGIN",protected = 1, hide = 1, });
U1RegisterAddon("DBM-RaidLeadTools", {title = "团长工具箱", protected = nil, hide = nil, });
U1RegisterAddon("DBM-GUI", {title = "配置选项模块", protected = nil, hide = nil, });
U1RegisterAddon("DBM-DefaultSkin", {title = "默认皮肤", protected = nil, hide = nil, });
U1RegisterAddon("DBM-VPYike", {title = "夏一可語音包", protected = nil, hide = nil, });
U1RegisterAddon("DBM-SpellTimers", {title = "冷却监控", protected = nil, hide = nil, });
U1RegisterAddon("DBM-WorldEvents", {title = "世界事件模块", protected = nil, hide = nil, });
U1RegisterAddon("DBM-PvP", {title = "PVP模块", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Brawlers", {title = '搏击俱乐部', protected = nil, hide = nil, });
U1RegisterAddon("DBM-ProvingGrounds", {title = "白虎寺试炼场", protected = nil, hide = nil, });
U1RegisterAddon("DBM-DMF", {title = '暗月马戏团', protected = nil, hide = nil, });
--德拉诺之王模块
U1RegisterAddon("DBM-Party-WoD", {title = "德拉诺之王-5人本", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Draenor", {title = "德拉诺", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Highmaul", {title = "悬槌堡", protected = nil, hide = nil, });
U1RegisterAddon("DBM-BlackrockFoundry", {title = "黑石铸造厂", protected = nil, hide = nil, });
--熊猫人之谜模块
U1RegisterAddon("DBM-Pandaria", {title = '潘达利亚', protected = nil, hide = nil, });
U1RegisterAddon("DBM-Party-MoP", {title = "潘达利亚-5人本", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Scenario-MoP", {title = '熊猫人之谜场景战役', protected = nil, hide = nil, });
U1RegisterAddon("DBM-MogushanVaults", {title = '魔古山宝库', protected = nil, hide = nil, });
U1RegisterAddon("DBM-HeartofFear", {title = '恐惧之心', protected = nil, hide = nil, });
U1RegisterAddon("DBM-TerraceofEndlessSpring", {title = '永春台', protected = nil, hide = nil, });
U1RegisterAddon("DBM-ThroneofThunder", {title = "雷电王座", protected = nil, hide = nil, });
U1RegisterAddon("DBM-SiegeOfOrgrimmar", {title = "决战奥格瑞玛", protected = nil, hide = nil, });
U1RegisterAddon("DBM-SiegeOfOrgrimmarV2", {title = "决战奥格瑞玛", protected = nil, hide = nil, });
--大地的裂变模块
U1RegisterAddon("DBM-Party-Cataclysm", {title = "大灾变5人本", protected = nil, hide = nil, });
U1RegisterAddon("DBM-DragonSoul", {title = "巨龙之魂", protected = nil, hide = nil, });
U1RegisterAddon("DBM-ChamberOfAspects", {title = "龙眠神殿", protected = nil, hide = nil, });
U1RegisterAddon("DBM-BlackwingDescent", {title = "黑翼血环", protected = nil, hide = nil, });
U1RegisterAddon("DBM-DBM-BastionTwilight", {title = "暮光堡垒", protected = nil, hide = nil, });
U1RegisterAddon("DBM-ThroneFourWinds", {title = "风神王座", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Firelands", {title = "火源之地", protected = nil, hide = nil, });
U1RegisterAddon("DBM-BaradinHold", {title = "巴拉丁监狱", protected = nil, hide = nil, });
--巫妖王之怒模块
U1RegisterAddon("DBM-Party-WotLK", {title = "巫妖王5人本", protected = nil, hide = nil, });
U1RegisterAddon("DBM-VoA", {title = "阿尔卡冯的宝库", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Naxx", {title = "纳克萨玛斯", protected = nil, hide = nil, });
U1RegisterAddon("DBM-EyeOfEternity", {title = "永恒之眼", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Coliseum", {title = "十字军的试炼", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Ulduar", {title = "奥杜尔", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Icecrown", {title = "冰冠堡垒", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Onyxia", {title = "奥妮克希亚", protected = nil, hide = nil, });
U1RegisterAddon("DBM-ChamberOfAspects", {title = "黑曜石圣殿", protected = nil, hide = nil, });
--燃烧的远征模块
U1RegisterAddon("DBM-Outlands", {title = "外域", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Party-BC", {title = "燃烧的远征5人本", protected = nil, hide = nil, });
U1RegisterAddon("DBM-TheEye", {title = "风暴要塞", protected = nil, hide = nil, });
U1RegisterAddon("DBM-BlackTemple", {title = "黑暗神庙", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Hyjal", {title = "海加尔山", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Serpentshrine", {title = "毒蛇神殿", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Sunwell", {title = "太阳井", protected = nil, hide = nil, });
--魔兽世界
U1RegisterAddon("DBM-AQ20", {title = "安其拉废墟", protected = nil, hide = nil, });
U1RegisterAddon("DBM-AQ40", {title = "安其拉神殿", protected = nil, hide = nil, });
U1RegisterAddon("DBM-BWL", {title = "黑翼之巢", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Karazhan", {title = "卡拉赞", protected = nil, hide = nil, });
U1RegisterAddon("DBM-MC", {title = "熔火之心", protected = nil, hide = nil, });
U1RegisterAddon("DBM-MC", {title = "熔火之心", protected = nil, hide = nil, });
U1RegisterAddon("DBM-MC", {title = "熔火之心", protected = nil, hide = nil, });
