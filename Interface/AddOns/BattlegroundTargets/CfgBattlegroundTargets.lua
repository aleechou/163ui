U1RegisterAddon("BattlegroundTargets", {
    title = "PVP战场框体",
    defaultEnable = 1,
    load = "LOGIN",

    tags = { TAG_PVP },
    icon = [[Interface\Icons\INV_Gizmo_Poltryiser_01]],
    desc = "显示全部战场敌人。战场简洁敌对单位框体.`` 设置方法： 点选开启后，点击信息条上的红色靶标图形，叫出设置。",
    pics = 2,

    {
        text = "重置所有控制台设定",
        callback = function(cfg, v, loading)
            BattlegroundTargets_Options = nil;
            ReloadUI();
        end,
    },

});
