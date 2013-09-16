U1RegisterAddon("WhisperPop", {
    title = "密语记录",
    defaultEnable = 1,
    optionsAfterVar = 1,
    load = "LOGIN", --防止恢复历史的时候清除最新的密语
    frames = {"WhisperPopFrame"}, --需要保存位置的框体

    tags = { TAG_CHAT, TAG_GOOD, },
    icon = "Interface\\Icons\\INV_Letter_05",
    desc = "Abin的老牌插件，可以记录玩家收到和发送的所有密语信息，并在有新密语到来时播放声音或闪动图标进行提醒。`在聊天窗口左上角的社交按钮上方，有此插件的提醒图标，点击即可打开密语记录窗口。所有密语信息已根据玩家名字分组，鼠标移上去即可查看。同时shift点击人名可查询详情，alt点击可以邀请入队，右键点击则可打开玩家菜单。`网易有爱特别增加了保留历史记录的功能，但请不要在网吧等公共环境使用，以免泄漏私人信息。",

    --toggle = function(name, info, enable, justload) end, --如果未开插件，则初始不会调用。
    {
        text = "打开密语窗口",
        callback = function(cfg, v, loading) WhisperPop:ToggleFrame() end,
    },

});