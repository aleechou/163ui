
U1RegisterAddon("EasyMount", { 
    title = "一键坐骑",
    defaultEnable = 1,
    tags = { TAG_GOOD, TAG_ITEM, },
    secure = 1,

    desc = "预先选择一些坐骑，点击按钮或按下热键时，自动从这些坐骑中随机选择。启用'职业快捷按钮'插件后，随机坐骑按钮会出现在快捷按钮上，如果未启用，暂时只能通过绑定热键的方式来使用。",
    icon = [[Interface\Icons\ability_mount_dreadsteed]],

    optionsAfterVar = 1,

    {
        type = 'button',
        text = '选择使用的坐骑',
        callback = function()
            return SlashCmdList["EASYMOUNT"]()
        end,
    },

    {
        type = 'button',
        text = '绑定热键',
        callback = function()
            CoreUIShowKeyBindingFrame("HEADER_EASYMOUNT_TITLE")
        end,
    },


});

