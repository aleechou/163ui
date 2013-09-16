U1RegisterAddon("NPCMark", {
    title = "NPC标记",
    defaultEnable = 1,
    --optionsAfterVar = 1,
    --load = "LOGIN",
    --secure = 1,
    --minimap = "",
    --frames = {""}, --需要保存位置的框体

    tags = { TAG_MAPQUEST },
    icon = [[Interface\ICONS\INV_Misc_Map_01]],

    author = "大脚Terry",
    --modifier = "|cffcd1a1c[网易]|r",

    --toggle = function(name, info, enable, justload) end,

    --[[------ Options --------
    {
        var = "",
        default = "",
        text = "", 
        callback = function(cfg, v, loading) end, 
    },
    {
        var = "",
        default = "",
        text = "",
        callback = function(cfg, v, loading) end,
    },
    --]]
});
