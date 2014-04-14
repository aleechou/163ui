U1RegisterAddon("IDQuery", {
    title = "物品法术查询",
    defaultEnable = 1,
    optionsAfterVar = 1,
    minimap = "LibDBIcon10_IDQuery",
    frames = {"IDQueryOptionPage"},

    tags = { TAG_ITEM, TAG_MANAGEMENT, TAG_GOOD },
    icon = [[Interface\Icons\SOR-mail]],
    desc = "通过暴雪提供的接口，从客户端里获取所有法术和成就信息，并向服务器请求所有物品信息。使用方式很简单：通过控制台或运行/idq命令打开查询界面，然后选择'物品'、'法术'、'成就'之一，输入名字的部分文字或ID数字，点击搜索按钮即可。`因为不保存任何数据，所以插件占用极小，只是搜索物品时瞬间可能会占用几M内存，但马上会释放。` `需要注意的是，搜索物品会给网络和服务器带来较大压力，而且游戏会卡顿，可能导致掉线。另外第一次搜索可能无结果，因为数据尚未下载完全。",

    modifier = "|cffcd1a1c[网易]|r",

    toggle = function(name, info, enable, justload)
        if justload then
            local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("IDQuery", {
                type = "launcher",
                label = info.title,
                icon = info.icon,
                iconCoords = {0.1, 1.1, -0.06, 0.94},
                OnTooltipShow = function(tip)
                    tip:AddLine(info.title, 1, 1, 1)
                end,
                OnClick = function(self, button)
                    SlashCmdList["IDQUERY"]("")
                end,
            })
            IDQueryDB = IDQueryDB or {}
            LibStub("LibDBIcon-1.0"):Register("IDQuery", ldb, IDQueryDB);
            CoreUIEnableTooltip(LibDBIcon10_IDQuery, info.title, "可以搜索全部物品和法术。\n快捷命令/idq。");
        end
    end,

    {
        text = "打开查询界面",
        tip = "快捷命令`/idquery或/idq",
        callback = function(cfg, v, loading) SlashCmdList["IDQUERY"]("") end,
    },
});