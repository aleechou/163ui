U1RegisterAddon("_NPCScan", {
    title = "稀有精英探测",
    defaultEnable = 0,
    load = 'NORMAL',
    secure = 1, --_NPCScanButton

    tags = { TAG_MAPQUEST },
    icon = [[Interface\Icons\ABILITY_HUNTER_HUNTERVSWILD]],
    desc = "搜寻附近的NPC，当发现稀有精英的时候给出提示。` `其原理是当稀有怪物的模型第一次加载时报警，所以当插件提示某些怪物已缓存、需要清理缓存时，请删除魔兽里的Cache目录(或仅删除creaturecache.wdb)，再重进游戏。",

    --author = "|cffcd1a1c[网易原创]|r",
    --modifier = "|cffcd1a1c[网易]|r",

    toggle = function(name, info, enable, justload)
        if justload then
            if GetModifiedClick( "_NPCSCAN_BUTTONDRAG" ) == "NONE" then
                SetModifiedClick( "_NPCSCAN_BUTTONDRAG", "CTRL" )
            end
        end
    end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading) SlashCmdList[ "_NPCSCAN" ]("") end,
    },
    {
        text = "测试警报",
        tip = "说明`模拟一次|cff808080“发现 NPC”|r警报让你知道它看起来什么样子。",
        callback = function(cfg, v, loading) _NPCScanTest:Click() end,
    },
    {
        text = "列出已缓存怪物",
        callback = function(cfg, v, loading) SlashCmdList[ "_NPCSCAN" ]("cache") end,
    },
});

U1RegisterAddon("_NPCScan.Overlay", {title = "稀有精英路径", desc = "在地图上标记出稀有精英的活动范围", parent="_NPCScan", defaultEnable = 0, protected = 1, hide = 1, });
