
BuildEnv(...)

if ... == 'RaidBuilder' then
    L = LibStub('AceLocale-3.0'):GetLocale('RaidBuilder')
end

MAX_PLAYER_LEVEL = MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()]

DIFF_MATCH = 0xFF000000
TYPE_MATCH = 0x00FF0000
NAME_MATCH = 0x0000FFFF

EVENT_TYPE_RAID     = 0x010000
EVENT_TYPE_DUNGEON  = 0x020000
EVENT_TYPE_SCENARIO = 0x040000
EVENT_TYPE_BG       = 0x080000
EVENT_TYPE_ARENA    = 0x100000
EVENT_TYPE_RECOMMEND= 0x200000
EVENT_TYPE_MISC     = 0x400000

EVENT_CODE_RECOMMEND= 0x200001

INVITE_STATUS_UNKNOWN   = 0x00
INVITE_STATUS_QUEUE     = 0x01
INVITE_STATUS_BNETTING  = 0x02
INVITE_STATUS_INVITING  = 0x04
INVITE_STATUS_JOINED    = 0x08

INVITE_STATUS_NAMES = {
    [INVITE_STATUS_QUEUE]       = L['队列中'],
    [INVITE_STATUS_BNETTING]    = L['好友申请中'],
    [INVITE_STATUS_INVITING]    = L['邀请组队中'],
    [INVITE_STATUS_JOINED]      = L['已加入'],
    [INVITE_STATUS_UNKNOWN]     = L['未组队'],
}

EVENT_NAMES = setmetatable({

    [EVENT_TYPE_RAID]       = L['团队副本'],
    [EVENT_TYPE_DUNGEON]    = L['地下城'],
    [EVENT_TYPE_SCENARIO]   = L['场景战役'],
    [EVENT_TYPE_BG]         = L['战场'],
    [EVENT_TYPE_ARENA]      = L['PvP'],
    [EVENT_TYPE_RECOMMEND]  = L['本周悬赏'],
    [EVENT_TYPE_MISC]       = L['其他'],

    [0x01011a52] = L['决战奥格瑞玛-25人'],
    [0x02011a52] = L['决战奥格瑞玛-10人'],
    [0x04011a52] = L['决战奥格瑞玛-弹性'],
    [0x000119de] = L['雷电王座'],
    [0x000117b3] = L['永春台'],
    [0x00011899] = L['恐惧之心'],
    [0x000117ed] = L['魔古山宝库'],

    [0x0001ffff] = L['斡耳朵斯'],
    [0x0001fffe] = L['四大天神'],
    [0x0001fffd] = L['世界Boss一波流'],

    [0x00011704] = L['巨龙之魂'],
    [0x0001165b] = L['火焰之地'],
    [0x00011606] = L['风神王座'],
    [0x000113e6] = L['黑翼血环'],
    [0x000114d6] = L['暮光堡垒'],
    [0x000115e0] = L['巴拉丁监狱'],

    [0x000112cc] = L['冰冠堡垒'],
    [0x0001137b] = L['红玉圣殿'],
    [0x00011272] = L['十字军的试炼'],
    [0x000110b1] = L['奥杜尔'],
    [0x0001118d] = L['黑曜石圣殿'],
    [0x00011194] = L['永恒之眼'],
    [0x000111fb] = L['阿尔卡冯的宝库'],

    [0x0008ffff] = L['随机战场 '],
    [0x000801e9] = L['战歌峡谷'],
    [0x000802d6] = L['双子峰'],
    [0x000802f9] = L['吉尔尼斯之战'],
    [0x000803e6] = L['寇魔古寺'],
    [0x000802d7] = L['碎银矿脉'],
    [0x00080211] = L['阿拉希盆地'],
    [0x00080236] = L['风暴之眼'],
    [0x0008025f] = L['远古海滩'],
    [0x00080451] = L['深风峡谷'],
    [0x0008001e] = L['奥特兰克山谷'],
    [0x00080274] = L['征服之岛'],

    [0x00100001] = L['2v2'],
    [0x00100002] = L['3v3'],
    [0x00100003] = L['5v5'],
    [0x00100004] = L['评级战场'],
    [0x00100005] = L['随机战场'],

}, {__index = function(o, code)
    if code == EVENT_CODE_RECOMMEND then
        return RemoteDataCache:GetCurrentRecommend() or UNKNOWN
    end
    return UNKNOWN
end})

EVENT_TYPES = {}

for code, name in pairs(EVENT_NAMES) do
    EVENT_TYPES[name] = code
end

ROLE_DATA = {
    TANK = {
        texture = [[INTERFACE\LFGFRAME\UI-LFG-ICON-ROLES]],
        coords = {0, 0.2617, 0.2617, 0.5234},
        text = L['坦克'],
        note = ROLE_DESCRIPTION2,
    },
    HEALER = {
        texture = [[INTERFACE\LFGFRAME\UI-LFG-ICON-ROLES]],
        coords = {0.2617, 0.5234, 0, 0.2617},
        text = L['治疗'],
        note = ROLE_DESCRIPTION3,
    },
    DAMAGER = {
        texture = [[INTERFACE\LFGFRAME\UI-LFG-ICON-ROLES]],
        coords = {0.2617, 0.5234, 0.2617, 0.5234},
        text = L['输出'],
        note = ROLE_DESCRIPTION1,
    },
    NONE = {
        texture = [[Interface\AddOns\RaidBuilder\Media\RoleNoneLarge]],
        coords = {0, 0.5234, 0, 0.5234},
        text = L['其他'],
        note = L['表示你愿意以其他的身份参加该活动。'],
    },
}

RAID_ROLE_LIST = {
    'TANK',
    'HEALER',
    'DAMAGER',
    'NONE',
}

CLASS_NAMES = {}

for i = 1, GetNumClasses() do
    local name, tag, id = GetClassInfo(i)
    CLASS_NAMES[tag] = name
end

EVENT_MODE_TYPES = {}
EVENT_MODE_NAMES = {
    [ 1] = L['Roll'],
    [ 2] = L['金团'],
    [ 3] = L['成就'],
    [ 4] = L['开荒'],
    [ 5] = L['冲分'],
    [ 6] = L['屠城'],
    [ 7] = L['其他'],
    [ 8] = L['幻化'],
    [ 9] = L['自强'],
    [10] = L['刷勇气'],
    [11] = L['刷正义'],
    [12] = L['刷征服'],
    [13] = L['刷荣誉'],
    [14] = L['挑战'],
    [15] = L['冲分'],
    [16] = L['混分'],
}
EVENT_MODE_MENUTABLE = {}

for i, v in ipairs(EVENT_MODE_NAMES) do
    EVENT_MODE_TYPES[v] = i
end

SPEC_STATS = {
    [ 62] = 'CASTER',
    [ 63] = 'CASTER',
    [ 64] = 'CASTER',
    [ 65] = 'CASTER',
    [ 66] = 'TANK',
    [ 70] = 'MDPS',
    [ 71] = 'MDPS',
    [ 72] = 'MDPS',
    [ 73] = 'TANK',
    [102] = 'CASTER',
    [103] = 'MDPS',
    [104] = 'TANK',
    [105] = 'CASTER',
    [250] = 'TANK',
    [251] = 'MDPS',
    [252] = 'MDPS',
    [253] = 'RDPS',
    [254] = 'RDPS',
    [255] = 'RDPS',
    [256] = 'CASTER',
    [257] = 'CASTER',
    [258] = 'CASTER',
    [259] = 'MDPS',
    [260] = 'MDPS',
    [261] = 'MDPS',
    [262] = 'CASTER',
    [263] = 'MDPS',
    [264] = 'CASTER',
    [265] = 'CASTER',
    [266] = 'CASTER',
    [267] = 'CASTER',
    [268] = 'TANK',
    [269] = 'MDPS',
    [270] = 'CASTER',
}

-- 属性

STAT_HIT        = 'T'       -- 命中
STAT_CRIT       = 'C'       -- 暴击
STAT_MASTERY    = 'M'       -- 精通
STAT_HASTE      = 'H'       -- 急速
STAT_DODGE      = 'D'       -- 躲闪
STAT_PARRY      = 'P'       -- 招架
STAT_BLOCK      = 'B'       -- 格档
STAT_ATTACK     = 'A'       -- 攻强
STAT_SPELL      = 'S'       -- 法伤
STAT_EXP        = 'E'       -- 精准
STAT_ARMOR      = 'R'       -- 护甲
STAT_MONEY      = 'G'       -- 金币

STAT_LIST = {
    STAT_ARMOR  ,
    STAT_DODGE  ,
    STAT_PARRY  ,
    STAT_BLOCK  ,
    STAT_ATTACK ,
    STAT_SPELL  ,
    STAT_MASTERY,
    STAT_HIT    ,
    STAT_EXP    ,
    STAT_CRIT   ,
    STAT_HASTE  ,
    STAT_MONEY  ,
}

STAT_NAMES = {
    [STAT_HIT    ] = L['命中：'],
    [STAT_CRIT   ] = L['暴击：'],
    [STAT_MASTERY] = L['精通：'],
    [STAT_HASTE  ] = L['急速：'],
    [STAT_DODGE  ] = L['躲闪：'],
    [STAT_PARRY  ] = L['招架：'],
    [STAT_BLOCK  ] = L['格档：'],
    [STAT_ATTACK ] = L['攻强：'],
    [STAT_SPELL  ] = L['法伤：'],
    [STAT_EXP    ] = L['精准：'],
    [STAT_ARMOR  ] = L['护甲：'],
    [STAT_MONEY  ] = L['金币：'],
}

---- 队伍列表

_RAID_UNITS = {}
_PARTY_UNITS = { 'player' }

for i = 1, 40 do
    tinsert(_RAID_UNITS, 'raid' .. i)
end
for i = 1, 4 do
    tinsert(_PARTY_UNITS, 'party' .. i)
end

EVENT_MINLEVELS = {}
EVENT_MAXMEMBERS = {}
EVENT_DEFAULT_MEMBERROLES = {}
EVENT_ALLOW_CROSSREALMS = {}

-- UNIT_LOGO
UNIT_LOGO_NETEASE   = 10
UNIT_LOGO_DEV       = 20
UNIT_LOGO_TOTAL     = 100
UNIT_LOGO_MONTH     = 101
UNIT_LOGO_90303A    = 200
UNIT_LOGO_90303B    = 201
UNIT_LOGO_90303C    = 202
UNIT_LOGO_FAMOUS    = 300
UNIT_LOGO_WEB       = 400
UNIT_LOGO_PVP       = 500
UNIT_LOGO_RAID      = 600
UNIT_LOGO_GOOD      = 700
UNIT_LOGO_NONE      = 9999

local function MakeLogo(id, width, height)
    return ([[|TInterface\AddOns\RaidBuilder\Media\Logo\%d:%d:%d|t]]):format(id, width, height)
end

local LOGO_SIZE = 20

UNIT_LOGO_TEXTURE   = {
    [UNIT_LOGO_NONE     ] = [[]],
    [UNIT_LOGO_NETEASE  ] = MakeLogo(UNIT_LOGO_NETEASE, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_DEV      ] = MakeLogo(UNIT_LOGO_DEV, LOGO_SIZE/2, LOGO_SIZE),
    [UNIT_LOGO_TOTAL    ] = [[|TINTERFACE\Challenges\challenges-gold-sm:20:20:0:0:64:64:18:46:16:44|t]],
    [UNIT_LOGO_MONTH    ] = [[|TINTERFACE\Challenges\challenges-plat-sm:20:20:0:0:64:64:18:46:16:44|t]],
    [UNIT_LOGO_90303A   ] = MakeLogo(UNIT_LOGO_90303A, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_90303B   ] = MakeLogo(UNIT_LOGO_90303B, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_90303C   ] = MakeLogo(UNIT_LOGO_90303C, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_FAMOUS   ] = [[]],
    [UNIT_LOGO_WEB      ] = MakeLogo(UNIT_LOGO_WEB, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_PVP      ] = MakeLogo(UNIT_LOGO_PVP, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_RAID     ] = MakeLogo(UNIT_LOGO_RAID, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_GOOD     ] = MakeLogo(UNIT_LOGO_GOOD, LOGO_SIZE, LOGO_SIZE),
}

UNIT_LOGO_LIST = {}

local UNIT_LOGO_DATA = '\064\085\078\073\084\095\076\079\071\079\095\078\069\084\069\065\083\069\010\035\230\162\166\229\162\131\035\053\055\050\049\010\035\232\163\129\229\134\179\035\053\056\056\053\010\035\233\190\153\233\170\145\229\163\171\035\053\051\051\048\010\035\231\170\129\231\160\180\229\164\169\233\153\133\035\053\053\052\049\010\064\085\078\073\084\095\076\079\071\079\095\057\048\051\048\051\065\010\035\073\100\101\097\108\101\035\053\056\049\056\010\035\109\101\108\112\111\109\101\110\101\035\053\055\052\049\010\035\078\111\118\035\053\057\055\057\010\035\228\187\129\230\133\136\035\053\053\050\056\010\035\229\147\136\232\191\170\230\150\175\035\053\056\053\052\010\035\229\156\139\231\170\150\035\053\054\055\054\010\035\229\164\167\228\184\183\231\153\189\035\053\053\054\049\010\035\229\164\167\231\153\189\035\053\057\048\055\010\035\229\173\166\229\167\144\231\148\168\232\191\135\231\154\132\035\053\053\054\053\010\035\230\138\147\228\184\170\229\176\143\229\190\183\229\174\157\229\174\157\035\053\051\052\054\010\035\230\149\143\230\132\159\228\185\139\231\159\174\228\186\186\035\053\050\050\056\057\010\035\230\156\168\229\164\180\228\186\186\035\053\053\051\057\010\035\230\173\187\228\186\161\230\168\177\232\138\177\035\053\052\052\056\010\035\230\184\133\233\162\168\231\172\145\231\133\153\233\155\168\035\053\050\049\052\010\035\231\129\171\233\186\146\233\186\159\035\053\051\050\050\010\035\232\137\190\229\176\148\228\185\139\229\173\144\035\053\055\049\048\055\010\035\233\151\170\228\186\174\228\185\139\231\191\188\035\053\049\053\054\051\051\010\035\233\156\141\230\160\188\035\053\050\054\052\053'

do
    local currentId
    for line in UNIT_LOGO_DATA:gmatch('[^\r\n]+') do
        local control, data = line:match('^([#@])(.+)$')
        if control then
            if control == '@' then
                currentId = _ENV[data]
            elseif control == '#' then
                UNIT_LOGO_LIST[data] = currentId
            end
        end
    end
end
