U1RegisterAddon("ChannelClean", { 
    title = "广告过滤",
    tags = {TAG_CHAT},
    defaultEnable = 0,

    icon = [[Interface\Icons\Spell_Holy_PowerInfusion]],
    desc = "提供多样的聊天信息过滤设置，可以过滤掉相同或相似的重复信息，也可以根据关键字或者内容进行规则过滤。请通过'配置选项'界面自行添加规则。",

    toggle = function(name, info, enable, justload)
        if(not justload) then
            if(enable) then
                return ChannelClean:Enable()
            else
                return ChannelClean:Disable()
            end
        end
    end,

    ------- Options --------
    {
        type="button",
        text="配置选项",
        callback = function(cfg, v, loading)
            local L = LibStub("AceLocale-3.0"):GetLocale("ChannelClean")
            LibStub("AceConfigDialog-3.0"):Open(L.ChannelClean)
        end,
    },
});
