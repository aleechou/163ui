
local DBTCreateBar_Origin
local function DBTCreateBar_Hacker (...)
    if not DBTCreateBar_Origin then return end
    local bar = DBTCreateBar_Origin(...)
    if bar then
        bar.frame:Hide() -- 隐藏计时条
    end
    return bar
end

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
        var="timerbar",
        text="显示DBM计时条(包括小型计时条和大型计时条)",
        tip="说明`显示DBM的计时条。",
        callback = function(cfg, v, loading)

            -- 初始化
            if loading then
                DBTCreateBar_Origin = DBT.CreateBar
            end
            
            if(v)then
                DBT.CreateBar = DBTCreateBar_Origin
            else
                DBT.CreateBar = DBTCreateBar_Hacker
            end

            -- 遍历所有已经创建的计时条，显示或隐藏他们
            if not loading then
                for bar in DBM.Bars:GetBarIterator() do
                    if v then
                        bar.frame:Show()
                    else
                        bar.frame:Hide()
                    end
                end
            end
        end,
    },
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
U1RegisterAddon("DBM-Sound-Yike", {title = "夏一可語音包", protected = nil, hide = nil, });
U1RegisterAddon("DBM-PvP", {title = "PVP模块", protected = nil, hide = nil, });
U1RegisterAddon("DBM-WorldEvents", {title = "世界事件模块", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Party-MoP", {title = "潘达利亚-小队副本", protected = nil, hide = nil, });
U1RegisterAddon("DBM-HeartofFear", {title = '恐惧之心', protected = nil, hide = nil, });
U1RegisterAddon("DBM-MogushanVaults", {title = '魔古山宝库', protected = nil, hide = nil, });
U1RegisterAddon("DBM-Pandaria", {title = '潘达利亚', protected = nil, hide = nil, });
U1RegisterAddon("DBM-Scenario-MoP", {title = '场景战役', protected = nil, hide = nil, });
U1RegisterAddon("DBM-TerraceofEndlessSpring", {title = '永春台', protected = nil, hide = nil, });
U1RegisterAddon("DBM-Brawlers", {title = '搏击俱乐部', protected = nil, hide = nil, });
U1RegisterAddon("DBM-ThroneofThunder", {title = "雷电王座", protected = nil, hide = nil, });
U1RegisterAddon("DBM-SiegeOfOrgrimmar", {title = "决战奥格瑞玛", protected = nil, hide = nil, });
U1RegisterAddon("DBM-BaradinHold", {title = "巴拉丁监狱", protected = nil, hide = nil, });
U1RegisterAddon("DBM-DBM-BastionTwilight", {title = "暮光堡垒", protected = nil, hide = nil, });
U1RegisterAddon("DBM-BlackwingDescent", {title = "黑翼血环", protected = nil, hide = nil, });
U1RegisterAddon("DBM-ChamberOfAspects", {title = "龙眠神殿", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Coliseum", {title = "十字军的试炼", protected = nil, hide = nil, });
U1RegisterAddon("DBM-DragonSoul", {title = "巨龙之魂", protected = nil, hide = nil, });
U1RegisterAddon("DBM-EyeOfEternity", {title = "永恒之眼", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Firelands", {title = "火源之地", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Icecrown", {title = "冰冠堡垒", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Naxx", {title = "纳克萨玛斯", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Onyxia", {title = "奥妮克希亚", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Party-Cataclysm", {title = "大灾变5人本", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Party-WotLK", {title = "巫妖王5人本", protected = nil, hide = nil, });
U1RegisterAddon("DBM-ProvingGrounds-MoP", {title = "白虎寺试炼场", protected = nil, hide = nil, });
U1RegisterAddon("DBM-SpellTimers", {title = "冷却监控", protected = nil, hide = nil, });
U1RegisterAddon("DBM-Ulduar", {title = "奥杜尔", protected = nil, hide = nil, });
U1RegisterAddon("DBM-VoA", {title = "阿尔卡冯的宝库", protected = nil, hide = nil, });
