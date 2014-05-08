U1RegisterAddon("WowSocial", {
    title = "友团群聊",
    tags = {TAG_CHAT,TAG_GOOD,},
    icon = [[Interface\ICONS\INV_Drink_05]],
    nopic = 1,
    desc = "你还在为上线不知道做什么而郁闷么，你还在为身在鬼服组不到队伍而烦恼么，你还在为组个团要等1个多小时纠结么，那么就让我们一起“友团插件”吧！跨区服组队无需手动添加战网实名好友，“只要你敢申请，我就敢组你”，重燃你的游戏热情，让鬼服的玩家重生，让漫长的等待成为历史。大家一起鉴证史上最强大的组队插件——友团插件！",

});

U1RegisterAddon("WowSocial_ChatLog", {
    parent = "WowSocial",
    protected = 1,
    hide = 1,
});
U1RegisterAddon("WowSocial_UI", {
    parent = "WowSocial",
    protected = 1,
    hide = 1,
});