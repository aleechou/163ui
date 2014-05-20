U1RegisterAddon("JPack", { 
    title = "背包整理",
    tags = {TAG_ITEM},
    desc = "在背包窗口上顯示背包整理按鈕，可以按照預訂順序快速整理物品。`ctrl或shift右鍵點擊整理按鈕可以設置正序或逆序（背包的空格在前還是在後），下次整理只需要左鍵單擊就能使用之前設置的順序。",
    icon = [[Interface\Icons\INV_Misc_Bag_10_Green]],

    defaultEnable = 1,

    ------- Options --------
    {
        type="button",
        text="立即整理背包",
        callback = function(cfg, v, loading) JPack:Pack() end,
    },
});
