U1RegisterAddon("zTip", { 
    title = "鼠标提示",
    tags = {TAG_INTERFACE},
    defaultEnable = 1,
    load = "NORMAL",
    optionsAfterLogin = 1,

    desc = "鼠标提示信息增强插件，可以设置鼠标提示的样式、位置，以及为鼠标提示增加额外的信息，如法力条、增益减益图标、法术ID、工会阶级等，还支持获取鼠标指向玩家的装备等级和天赋。``配置命令:/ztip 进行设置。",
    icon = [[Interface\Icons\INV_Misc_Toy_08]],
    ------- Options --------
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
            _G["zTip"].hideCompare = v
        end,
    },
    {
        var = "systemId",
        default = 0,
        text = "始终显示物品的ID",
        tip = "说明`此功能可以直接看到物品的系统ID，可以用于查询网站，或者配置技能等。",
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
        text = "高级配置选项",
        callback = function() SlashCmdList["ZTIPSLASH"]("") end,
    }
});
