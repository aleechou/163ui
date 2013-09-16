U1RegisterAddon("RatingSummary", {
    title = "装备统计对比",
    tags = {TAG_ITEM, },
    deps = {"libstatlogic-1.2"},
    author = "|cffcd1a1c[网易原创]|r",

    icon = [[Interface\Icons\INV_Shoulder_02]],
    desc = "在玩家面板或观察面板旁边显示自己与对方的装备统计对比，并可显示GS和天赋。此插件只计算装备上确实存在的属性，而不会计算天赋和BUFF的加成，所以和人物面板的数值是不同的。插件的主要目的是比较装备的属性，而不是人物的属性。`网易有爱特别提供查看对方精通属性的详细说明，以及显示宝石和附魔缺失情况的功能。",

    defaultEnable  = 1,

    toggle = function(name, info, enable, justload)
        if(justload and IsAddOnLoaded("Blizzard_InspectUI")) then
            RatingSummary_SetupHook();
        end
        togglehook(nil, "RatingSummary_ShowFrame", noop, not enable);
        return true;
    end,
});
