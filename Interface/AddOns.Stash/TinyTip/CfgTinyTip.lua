U1RegisterAddon("TinyTip", { 
    title = "鼠标提示",
    tags = {TAG_INTERFACE},
    defaultEnable = 1,

    author = "Thrae",
    modifier = "Hughman",

    desc = "鼠标提示信息增强插件，可以设置鼠标提示的样式、位置，以及为鼠标提示增加额外的信息，如法力条、增益减益图标、法术ID、工会阶级等，还支持获取鼠标指向玩家的装备等级和天赋。`支持鼠标移到聊天链接时直接显示物品信息，不需点击。`配置项目众多，亦可通过命令行/tinytip进行更进一步的设置。",
    icon = [[Interface\Icons\INV_Misc_Toy_08]],
    ------- Options --------
    {
        var = "inspecttip",
        default = 1,
        text = "显示装备等级及天赋(新)",
        tip = "说明`网易有爱最新开发的装备等级查看模块，不需要对方安装任何插件。而且会计算对方身上的韧性总和，更好的区分PVP和PVE混穿的情况。",
        callback = function(cfg, v, loading) TTVar.InspectTip = not not v end,
    },
    {
        var = "Anchor",
        type="drop",
        text="指定鼠标提示位置",
        default = 6,
        options = {"默认", 0, "跟随人物", 1, "人物顶部", 2, "跟随人物其他顶部", 3, "全部顶部", 5, "跟随全部", 6},
        callback = function(cfg, v, loading) TTVar.Anchor=v end,
        {
            var = "x",
            type = "spin",
            text = "位置偏移量（横向）",
            tip = "说明`横向偏移量：向右为正，向左为负，跟随鼠标建议设置为30。",
            range = {-200, 200, 10},
            default = 30,
            callback = function(cfg, v, loading) TTVar.OffsetX=v end,
        },
        {
            var = "y",
            type = "spin",
            text = "位置偏移量（纵向）",
            tip = "说明`纵向偏移量：向上为正，向下为负，跟随鼠标建议设置为-30。",
            range = {-200, 200, 10},
            default = -30,
            callback = function(cfg, v, loading) TTVar.OffsetY=v end,
        },
    },
    {
        var = "tekcompare",
        default = true,
        text = "是否自动对比装备",
        tip = "说明`开启此选项则鼠标指向物品时自动对比装备，否则需要按住SHIFT才对比。",
        getvalue = function() return GetCVarBool("alwaysCompareItems") end,
        callback = function(cfg, v, loading)
            SetCVar("alwaysCompareItems", v and "1" or "0")
        end,
    },
    {
        var = "hideCompare",
        text = "隐藏对比装备时的属性变动信息",
        tip = "说明`系统现在自带的装备比较，会在下方列出更换装备后的属性变动，有时会导致列表很长，此选项可关闭此功能。",
        callback = function(cfg, v, loading)
            _G["TinyTip"].hideCompare = v
        end,
    },

--[[ --4.2 no need
    {
        var = "tekcompare",
        default = true,
        text = "是否自动对比装备",
        tip = "说明`开启此选项则鼠标指向物品时自动对比装备，否则需要按住SHIFT才对比。",
        callback = function(cfg, v, loading)
            TinyTipTekKompare_ItemRefTooltip_OnEnter = TinyTipTekKompare_ItemRefTooltip_OnEnter or ItemRefTooltip:GetScript("OnEnter")
            TinyTipTekKompare_ItemRefTooltip_OnLeave = TinyTipTekKompare_ItemRefTooltip_OnLeave or ItemRefTooltip:GetScript("OnLeave")
            togglehook(nil, "TinyTipTekKompare_SetTips", noop, not v)
            ItemRefTooltip:SetScript("OnEnter", not v and TinyTipTekKompare_ItemRefTooltip_OnEnter or nil)
            ItemRefTooltip:SetScript("OnLeave", not v and TinyTipTekKompare_ItemRefTooltip_OnLeave or nil)
        end,
    },
]]
    {
        var = "fade",
        default = false,
        text = "隐藏时使用渐隐方式",
        callback = function(cfg, v, loading) TTVar.Fade = not not v end,
    },
    {
        var = "Power",
        default = false,
        text = "显示怒气法力等状态条",
        callback = function(cfg, v, loading) TTVar.Power = not not v end,
    },
    {
        var = "StatusBarText",
        default = false,
        text = "显示状态条文字",
        callback = function(cfg, v, loading) TTVar.StatusBarText = v and 7 or 0 end,
    },
    {
        var = "PVPRank",
        default = true,
        text = "显示玩家称号",
        callback = function(cfg, v, loading) TTVar.PVPRank = not not v end,
    },
    {
        var = "Race",
        default = false,
        text = "显示玩家种族",
        callback = function(cfg, v, loading) TTVar.Race = not not v end,
    },
    {
        var = "Guild",
        default = true,
        text = "显示玩家工会",
        callback = function(cfg, v, loading) TTVar.Guild = not not v end,
        {
            var = "GuildRank",
            default = false,
            text = "显示玩家公会等级",
            callback = function(cfg, v, loading) TTVar.GuildRank = not not v end,
        },
    },
    {
        var = "Target",
        default = 1,
        text = "显示对方目标",
        type = "radio",
        options = {"禁用", 0, "目标", 1, "目标及关注的团员数量", 9},
        cols = 3,
        callback = function(cfg, v, loading) TTVar.Target = v end,
    },
    {
        var = "systemId",
        default = 1,
        text = "显示物品和法术的ID",
        tip = "说明`此功能可以直接看到物品/技能/BUFF的系统ID，可以用于查询网站，或者配置技能等。",
        callback = function(cfg, v, loading)
            TIP_SHOW_SYSTEM_ID = v;
        end,
    },
    {
        var = "itemInfo",
        default = 1,
        text = "显示物品类型和堆叠数",
        tip = "说明`鼠标指向物品时显示物品的大类-小类，一组个数。",
        callback = function(cfg, v, loading)
            TIP_ADD_ITEM_INFO = v;
        end,
    },
    {
        var="buff",
        default = 0,
        type="radio",
        text="显示人物Buff和Debuff",
        options = {"无", 0, "BUFF", 1, "DEBUFF", 2, "全部", 3},
        cols = 4,
        callback = function(cfg, v, loading) TTVar.Buff=v end,
    },
    {
        var = "scale",
        type = "spin",
        text = "鼠标提示的缩放比例",
        tip = "说明`调整系统默认的鼠标提示缩放比例",
        range = {0.5, 2, 0.1},
        default = 1,
        callback = function(cfg, v, loading) TTVar.Scale=v if GameTooltip:IsVisible() then GameTooltip:SetScale(v) end end,
    },
    {
        text = "高级设置命令",
        callback = function() SlashCmdList["TinyTip"]("") end,
    }
});
