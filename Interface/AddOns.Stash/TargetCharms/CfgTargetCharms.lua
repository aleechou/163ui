U1RegisterAddon("TargetCharms", {
    title = "世界标记助手",
    defaultEnable = 1,
    --optionsAfterVar = 1,
    load = "NORMAL",
    secure = 1,
    --minimap = "",

    tags = { TAG_RAID },
    icon = [[Interface\Icons\INV_Sigil_UlduarAll]],
    desc = "设置世界标记的工具条。` `现在的魔兽世界提供世界标记的功能：当在小队中或为团长时，可以通过团队面板的'小旗'按钮，在地面上设置最多5个标记。`插件使用了最新的API编写，不会再出现失效的情况。`注意：只有在小队中或是团队中有助理权限时才会显示工具条。",

    --author = "|cffcd1a1c[网易原创]|r",
    modifier = "天下牧",

    toggle = function(name, info, enable, justload)
        if not justload and not InCombatLockdown() then
            if enable then
                CheckFlareFrameViewState();
                --_G["FlareCharms"]:Show()
            else
                _G["FlareCharms"]:Hide()
            end
        end
    end,

    {
        text = "重置位置",
        callback = function(cfg, v, loading) TargetCharms_Reset() end,
    },
    --[[------ Options --------
    {
        var = "",
        default = "",
        text = "",
        callback = function(cfg, v, loading) end,
    },
    --]]
});
