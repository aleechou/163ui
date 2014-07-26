U1RegisterAddon("WowSocial", {
    title = "友团群聊",
    tags = {TAG_CHAT,TAG_GOOD,},
    icon = [[Interface\ICONS\INV_Drink_05]],
	defaultEnable = 1,
	load="NORMAL",
    nopic = 1,
    desc = "【友团群组聊天】让你不用组队也能群聊，参与自己感兴趣的群组或是自己创建群组，吸引更多志趣相投的玩家一起探讨游戏。而全新的聊天界面，让你的沟通不再是枯燥的文字刷屏。现在就点击小地图或顶部信息条的按钮开启“友聊时代”吧！",

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