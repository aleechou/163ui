
local tdPack = tdCore(...)

local L = tdPack:GetLocale()

local Weapons, Armor, Containers, Consumables, Glyphs, TradeGoods, Recipes, Gems, Miscellaneous, Quest, BattlePet = GetAuctionItemClasses()
local FishingPoles = select(17, GetAuctionItemSubClasses(1))
local Devices = select(10, GetAuctionItemSubClasses(6))

tdPack.DefaultCustomOrder = {
    HEARTHSTONE_ITEM_ID,                    -- 炉石
    64488,                                  -- 旅店老板的女儿
    79104,                                  -- 水壶
    2901,                                   -- 矿工锄
    5956,                                   -- 铁匠锤
    7005,                                   -- 剥皮刀
    20815,                                  -- 珠宝制作工具
    39505,                                  -- 学者的书写工具
    '#'  .. TradeGoods .. '##' .. Devices,  -- #商品##装置
    '##' .. FishingPoles,                   -- ##鱼竿
    '#'  .. BattlePet,                      -- #战斗宠物
    '#'  .. Weapons,                        -- #武器
    '#'  .. Armor,                          -- #护甲
    '#'  .. Containers,                     -- #容器
    '#'  .. Gems,                           -- #珠宝
    '#'  .. Glyphs,                         -- #雕文
    '#'  .. Recipes,                        -- #配方
    '#'  .. TradeGoods,                     -- #商品
    '#'  .. Consumables,                    -- #消耗品
    '#'  .. Miscellaneous,                  -- #其它
    '#'  .. Quest,                          -- #任务
}

tdPack.DefaultEquipLocOrder = {
    'INVTYPE_2HWEAPON',         --双手
    'INVTYPE_WEAPON',           --单手
    'INVTYPE_WEAPONMAINHAND',   --主手
    'INVTYPE_WEAPONOFFHAND',    --副手
    'INVTYPE_SHIELD',           --副手
    'INVTYPE_HOLDABLE',         --副手物品
    'INVTYPE_RANGED',           --远程
    'INVTYPE_RANGEDRIGHT',      --远程
    'INVTYPE_THROWN',           --投掷
    
    'INVTYPE_HEAD',             --头部
    'INVTYPE_SHOULDER',         --肩部
    'INVTYPE_CHEST',            --胸部
    'INVTYPE_ROBE',             --胸部
    'INVTYPE_HAND',             --手
    'INVTYPE_LEGS',             --腿部
    
    'INVTYPE_WRIST',            --手腕
    'INVTYPE_WAIST',            --腰部
    'INVTYPE_FEET',             --脚
    'INVTYPE_CLOAK',            --背部
    
    'INVTYPE_NECK',             --颈部
    'INVTYPE_FINGER',           --手指
    'INVTYPE_TRINKET',          --饰品
    
    'INVTYPE_BODY',             --衬衣
    'INVTYPE_TABARD',           --战袍
    
    --  这些应该不需要了
    --  'INVTYPE_RELIC',                --圣物
    --  'INVTYPE_WEAPONMAINHAND_PET',   --主要攻击
    --  'INVTYPE_AMMO',                 --弹药
    --  'INVTYPE_BAG',                  --背包
    --  'INVTYPE_QUIVER',               --箭袋
}
