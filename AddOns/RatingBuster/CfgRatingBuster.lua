U1RegisterAddon("RatingBuster", { 
    title = "装备属性换算",
    tags = {TAG_ITEM, TAG_BIG},
    deps = {"libstatlogic-1.2", "libbabble-3.0",},
    desc = "在装备的鼠标提示中，把各种战斗等级属性换算成百分比效果显示出来，换算时考虑了各职业的转换公式、职业的天赋加成、当前的增益效果等等，非常精确。也可以比较两件装备的属性总差异。``运行命令'/ratingbuster win'打开详细设置窗口。",

    defaultEnable = 0,
    
    toggle = function(name, info, enable, justload)
        CoreUIEnableOrDisable(RatingBuster, enable);
        return true;
    end,

    icon = [[Interface\Icons\Trade_Archaeology_Highborne_scroll]],
    ------- Options --------
    {
        var = "hidebzcomp",
        text="隐藏自带物品对比",
        tip="说明`隐藏暴雪自带的更换装备后属性改变情况的提示",
        default = true,
        getvalue = function() return RatingBuster.db.profile.hideBlizzardComparisons end,
        callback = function(cfg, v, loading) if not loading then SlashCmdList["ACECONSOLE_RATINGBUSTER"]("hidebzcomp", v and "on" or "off") end end,
    },
    {
        type="button",
        text="配置选项",
        tip="快捷命令`/ratingbuster win",
        callback = function(cfg, v, loading) SlashCmdList["ACECONSOLE_RATINGBUSTER"]("win") end,
    },
});
