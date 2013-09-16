U1RegisterAddon("Grid", {
    title = "团队框架",
    defaultEnable = 0,
    load = "NORMAL",
    minimap = "LibDBIcon10_Grid",

    tags = { TAG_RAID, TAG_BIG, },
    icon = "Interface\\AddOns\\Grid\\icon",
    desc = "强大的团队框架Grid, 使用网易有爱warbaby的整合版，提供适合大部分玩家的默认配置。`Grid插件下有许多扩展子模块，可以根据自己的需要选择开启。``如需自行配置显示的内容，需要在设置界面中给不同的|cffffffff指示器|r配置上对应的|cffffffff状态|r，有一些状态自身也有选项，要在'状态页'中进行调整。",
    pics = 2,

    modifier = "|cffcd1a1c[网易]|r",

    toggle = function(name, info, enable, justload) end,

    -------- Options --------
    {
        text = "详细设置",
        callback = function(cfg, v, loading) LibStub("AceConfigDialog-3.0"):Open("Grid") end,
    },
    --]]
});

U1RegisterAddon("GridBuffIcons", {
    desc = "在Grid的框架上显示所有增益或减益图标。",
    title = "扩展：增益减益图标", protected = nil, hide = nil,
    {
        var = "filter",
        text = "过滤状态图标",
        tip = "说明`状态图标模块是显示全部状态还是只显示自己可释放/移除的。",
        default = true,
        getvalue = function()
            local mod = Grid:GetModule("GridBuffIconStatus", true);
            return mod.db.profile.bufffilter
        end,
        callback = function(cfg, v, loading)
            local mod = Grid:GetModule("GridBuffIconStatus", true);
            if mod then
                mod.db.profile.bufffilter = v;
                mod:UpdateAllUnitsBuffs();
            end
        end,
    },
    {
        var = "buff",
        text = "切换增益/减益",
        tip = "说明`开启状态图标后，可以方便的在BUFF和DEBUFF之间切换，既可检查团队状态信息，又可关注战斗减益。",
        default = false,
        getvalue = function()
            local mod = Grid:GetModule("GridBuffIconStatus", true);
            return mod.db.profile.showbuff
        end,
        callback = function(cfg, v, loading)
            local mod = Grid:GetModule("GridBuffIconStatus", true);
            if mod then
                mod.db.profile.showbuff = v;
                mod:UpdateAllUnitsBuffs();
            end
        end,
    },
});
U1RegisterAddon("GridCooldownText", {title = "扩展：图标倒计时文字", protected = nil, hide = nil,
    desc = "在中央图标上显示倒计时数字",
});
--U1RegisterAddon("GridBorderStyle", {title = "扩展：边框美化", deps = {"GridManaBars"}, protected = nil, hide = nil, });
U1RegisterAddon("GridQuickHealth", {title = "扩展：快速血条变化", protected = nil, hide = nil,
    desc = "加快原版Grid血量变化，最高可缩短近300毫秒，赢得反应时间！",
});
U1RegisterAddon("GridIndicatorCornerText", {title = "指示器：边角数字", protected = nil, hide = nil,
    desc = "在四个角落提供显示状态倒计时的功能",
});
U1RegisterAddon("GridIndicatorSideIcons", {title = "指示器：侧边图标", protected = nil, hide = nil, });
U1RegisterAddon("GridManaBars", {title = "指示器：法力能量条", load="NORMAL", protected = nil, hide = nil, });
U1RegisterAddon("GridStatusBanzai", {title = "状态：怪物目标", protected = nil, hide = nil,
    desc = "提供最迅速的Boss目标转移警告，怪物当前目标以黄框显示（Grid自带的怪物当前仇恨目标为红框，两者有区别），并提供怪物施法进度的显示",
});
U1RegisterAddon("GridStatusHots", {title = "状态：HoTs(持续治疗)", protected = nil, hide = nil,
    desc = "提供常见持续治疗效果的倒计时及总数提示。"
});
U1RegisterAddon("GridStatusRaidIcons", {title = "状态：团队标记", protected = nil, hide = nil,
    desc = "提供显示团员的标记或团员当前目标的标记的功能。"
});
U1RegisterAddon("GridStatusTankCooldown", {title = "状态：坦克救命技能", protected = nil, hide = nil,
    desc = "提供一些救场技能的提示，例如盾墙、破釜沉舟等。默认显示在右侧图标中。"
});
U1RegisterAddon("GridStatusRaidDebuff", {title = "状态：团队减益", deps = {"libbabble-3.0"}, protected = nil, hide = false, load="NORMAL",
    desc = "提供副本Boss的主要Debuff技能的提示。"
});
U1RegisterAddon("GridStatusRD_MoP", {title = "状态：团队减益之熊猫人之迷", protected = true, hide = 1, load="NORMAL",});
