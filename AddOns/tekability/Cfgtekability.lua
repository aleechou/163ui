
U1RegisterAddon("tekability", { 
    title = "装备耐久",
    tags = {TAG_ITEM},
    defaultEnable = 1,

    desc = "在角色面板中显示各装备的耐久度百分比，并显示修理费用。支持信息条，可将当前耐久度显示在信息条上，鼠标移上去后可以查看详细情况。",
    icon = [[Interface\Icons\INV_Chest_Chain_07]],

    toggle = function(name, info, enable, justload)
        if justload then return end
        local v
        if(not enable) then
            v = false
        end
        U1CfgCallBack(U1CfgFindChild("tekability", "showdura"), v)
        U1CfgCallBack(U1CfgFindChild("tekability", "repairCost"), v)
    end,
    optionsAfterVar = 1,

    {
        type = 'checkbox',
        var = 'showdura',
        default = true,
        text = '显示耐久文字',
        callback = function(cfg, v, loading)
            for slot in next, tekability.SLOTIDS do
                -- trigger __idnex
                local fontstr = tekability.fontstrings[slot]
                if(fontstr) then
                    if(v) then
                        fontstr:Show()
                    else
                        fontstr:Hide()
                    end
                end
            end
        end,
    },

    {
        type = 'checkbox',
        var = 'repairCost',
        default = true,
        text="显示装备修理费用",
        callback = function(cfg, v, loading)
            if(v) then
                tekability.repairText:Show()
                tekability.moneyFrame:Show()
            else
                tekability.repairText:Hide()
                tekability.moneyFrame:Hide()
            end
        end,
    },

    {
        text="设置品质染色",
        callback = function(cfg, v, loading) UUI.OpenToAddon("oglow") end,
    },

});

