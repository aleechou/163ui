U1RegisterAddon("AtlasLootReverse", {
    title = "物品来源查询",
    tags = {TAG_ITEM, TAG_BIG, },
    defaultEnable = 1,
    modifier = "|cffcd1a1c[网易]|r",

    icon = [[Interface\Icons\Ability_Hunter_SilentHunter]],
    desc = "利用副本掉落插件的数据，查询某件物品的来源。当鼠标指向一件物品时，可以在提示中显示'来源：'信息。` `占用约1.5M。",

    toggle = function(name, info, enable, justload)
        if(not justload) then
            if(enable) then
                return AtlasLootReverse:Enable()
            else
                return AtlasLootReverse:Disable()
            end
        end
    end,

});
