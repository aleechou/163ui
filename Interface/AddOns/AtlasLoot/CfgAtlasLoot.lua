U1RegisterAddon("AtlasLoot_Loader", { 
    title = "副本掉落查询",
    tags = {TAG_ITEM, TAG_BIG, TAG_GOOD },
    deps = {"libbabble-3.0"},
    minimap = "LibDBIcon10_AtlasLoot",
    defaultEnable = 1,

    author = "Hegarol",
    desc = "显示副本中的首领与小怪可能掉落的物品，并且可以查询各种声望、战场、兑换物的奖励物品等。`快捷命令：/al 或 /atlasloot``|cff00d100本插件下的子模块全部开启即可，会自动加载需要的部分|r",
    icon = [[Interface\Icons\INV_Box_01]],

    --children = {"^AtlasLoot$", "AtlasLoot_.*"}, --AtlasLootReverse, AtlasLoot_Tooltip

    {
        type="button",
        text="开启主界面",
        tip="快捷命令`/al 或 /atlasloot",
        callback = function() AtlasLoot:ShowFrame_MiniMap(); end
    },
    {
        type="button",
        text="配置选项",
        callback = function() AtlasLoot:LoadModule("AtlasLoot") AtlasLoot:OptionsToggle(); end
    },
});

U1RegisterAddon("AtlasLoot", {
    title = "副本掉落主模块",
    parent = "AtlasLoot_Loader",
    protected = 1,
    hide = 1,
});

U1RegisterAddon("AtlasLoot_BurningCrusade", {title = "燃烧的远征数据", parent = "AtlasLoot_Loader",});
U1RegisterAddon("AtlasLoot_Cataclysm", {title = "大地的裂变数据", parent = "AtlasLoot_Loader",});
U1RegisterAddon("AtlasLoot_ClassicWoW", {title = "艾泽拉斯数据", parent = "AtlasLoot_Loader",});
U1RegisterAddon("AtlasLoot_Crafting", {title = "商业制造物品数据", parent = "AtlasLoot_Loader",});
U1RegisterAddon("AtlasLoot_WorldEvents", {title = "世界事件数据", parent = "AtlasLoot_Loader",});
U1RegisterAddon("AtlasLoot_WrathoftheLichKing", {title = "巫妖王之怒数据", parent = "AtlasLoot_Loader",});
U1RegisterAddon("AtlasLoot_MistsofPandaria", {title = "熊猫人之谜数据", parent = "AtlasLoot_Loader",});

