local _, U1 = ...;
local L = U1.L

local __, engClass = UnitClass("player");

--判断是否是网易官方插件
function U1IsNeteaseVendor(name)
    local reg, vendor = U1IsAddonRegistered(name)
    if U1AddonHasTag(name, "BETA") then return nil end
    if not UI163_USER_MODE then
        return reg and (vendor or not U1GetAddonInfo(name).installed) and true
    else
        return reg and true
    end
end

local function loadedFilter(name)
    local info = U1GetAddonInfo(name);
    return (not U1DB or not U1DB.selectedTag or U1AddonHasTag(name, U1DB.selectedTag)) and U1IsAddonEnabled(name)
end
local function notLoadedFilter(name)
    local info = U1GetAddonInfo(name);
    return (not U1DB or not U1DB.selectedTag or U1AddonHasTag(name, U1DB.selectedTag)) and not U1IsAddonEnabled(name)
end

--PLAYER_LOGIN时计算有filter的标签的插件数量
local hide = {hide = 1,} --隐藏(show=nil)
--所有的标签都以别名的方式列在这里, 如果不提供text，则自动使用L["TAG_<ID>"]的本地化
U1.TAGS = {
    ALL = {
        text = L["全部插件"], --显示的文字, 如果没有就直接用注册时的文本了
        order = 1, --顺序, 数值小的排在前面
        hide = 1, --是否列在标签里,对于各个职业的标签是不需要显示的.
        filter = function(name) return true end, --过滤是否显示
    },

    GOOD = {
        text = L["精新推荐"],
        order = 2,
    },

    NETEASE = {
        text = L["网易有爱"],
        order = 5,
        filter = U1IsNeteaseVendor,
        hide = 1,
    },

    SINGLE = {
        order = 6,
        text = L["单体插件"],
        filter = function(name) return not U1AddonHasTag(name, "BETA") and not U1IsNeteaseVendor(name) end,
        hide = 1,
    },

    CLASS = {
        order = 15,
        text = _G["U1"..engClass]..L["专用"],
        filter = function(name)
            return U1AddonHasTag(name, "CLASS") and U1AddonHasTag(name, engClass);
        end
    },

    LOADED = {
        text = L["已启用"],
        order = 8,
        filter = loadedFilter,
        hide = 1,
    },

    NLOADED = {
        text = L["未启用"],
        order = 9,
        filter = notLoadedFilter,
        hide = 1,
    },

    RAID = 1,
    BIG = 1,
    TRADING = 1,
    INTERFACE = 1,
    CHAT = 1,
    PVP = 1,
    --COMBAT = 1,
    COMBATINFO = 1,
    MAPQUEST = 1,
    MANAGEMENT = 1,
    UNIQUE = 1,
    NEW = 1,
    ITEM = 1,
    DATA = 1,
    DEV = DEBUG_MODE and {order=-1} or hide,
    BETA = DEBUG_MODE and {order=0} or hide,

    HUNTER = hide,
    WARLOCK = hide,
    PRIEST = hide,
    PALADIN = hide,
    MAGE = hide,
    ROGUE = hide,
    DRUID = hide,
    SHAMAN = hide,
    WARRIOR = hide,
    DEATHKNIGHT = hide,
    MONK = hide,
    --如果有其他的别名比如TRADE, 则增加TRADE={text="交易"}即可
}

--"商业技能", "地图任务", "界面增强", "RAID", "战斗辅助", "技能相关", "聊天交流", "CLASS", "DEATHKNIGHT", "其他", "PVP竞技场", "大型插件", "常用", "战斗信息"

TAG_BETA = "BETA"
TAG_TRADING = "TRADING"
TAG_ITEM = "ITEM"
TAG_DATA = "DATA"
TAG_RAID = "RAID"
--TAG_COMBAT = "COMBAT"
TAG_COMBATINFO = "COMBATINFO"
TAG_PVP = "PVP"
TAG_INTERFACE = "INTERFACE"
TAG_CHAT = "CHAT"
TAG_BIG = "BIG"
TAG_MAPQUEST = "MAPQUEST"
TAG_MANAGEMENT = "MANAGEMENT"
--TAG_NEW = "NEW"
--TAG_UNIQUE = "UNIQUE"
TAG_GOOD = "GOOD"
TAG_DEV = "DEV"

TAG_CLASS = "CLASS"
TAG_HUNTER      = "HUNTER"
TAG_WARLOCK     = "WARLOCK"
TAG_PRIEST      = "PRIEST"
TAG_PALADIN     = "PALADIN"
TAG_MAGE        = "MAGE"
TAG_ROGUE       = "ROGUE"
TAG_DRUID       = "DRUID"
TAG_SHAMAN      = "SHAMAN"
TAG_WARRIOR     = "WARRIOR"
TAG_DEATHKNIGHT = "DEATHKNIGHT"
TAG_MONK        = "MONK"

