
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

INVITE_STATUS_QUEUE     = 1
INVITE_STATUS_BNETTING  = 2
INVITE_STATUS_INVITING  = 3
INVITE_STATUS_JOINED    = 4
INVITE_STATUS_UNKNOWN   = 5

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
    [EVENT_TYPE_RECOMMEND]  = L['主题活动'],
    [EVENT_TYPE_MISC]       = L['其他'],

    [0x01011a52] = L['决战奥格瑞玛-25人'],
    [0x02011a52] = L['决战奥格瑞玛-10人'],
    [0x04011a52] = L['决战奥格瑞玛-弹性'],
    [0x000119de] = L['雷电王座'],
    [0x000117b3] = L['永春台'],
    [0x00011899] = L['恐惧之心'],
    [0x000117ed] = L['魔古山宝库'],

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
    local type = bit.band(code, TYPE_MATCH)
    if type ~= EVENT_TYPE_RECOMMEND then
        return UNKNOWN
    end
    local name = RECOMMEND_NAMES[bit.band(code, NAME_MATCH)]
    if name then
        o[code] = name:match('^([^#]+)#')
        return o[code]
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

RECOMMEND_NAMES = {
    [ 1] = '永恒岛香炉持久战#90#40#0,0,0,40',
    [ 2] = '潘达莉亚全日常#90#40#0,0,0,40',
    [ 3] = '世界boss一波流#90#40#0,0,0,40',
    [ 4] = '40同职业大战场#1#45#0,0,0,40',
    [ 5] = '为了联盟，进攻幽暗城#1#40#0,0,0,40',
    [ 6] = '为了部落，进攻达纳苏斯#1#40#0,0,0,40',
    [ 7] = '为了部落，进攻铁炉堡#1#40#0,0,0,40',
    [ 8] = '为了联盟，进攻雷霆崖#1#40#0,0,0,40',
    [ 9] = '为了联盟，进攻银月城#1#40#0,0,0,40',
    [10] = '为了部落，进攻埃索达#1#40#0,0,0,40',
    [11] = '为了联盟，进攻双月殿#85#40#0,0,0,40',
    [12] = '为了部落，进攻七星殿#85#40#0,0,0,40',
    [13] = '地狱火半岛抢占三塔#58#40#0,0,0,40',
    [14] = '赞加沼泽双塔#58#40#0,0,0,40',
    [15] = '纳格兰抢夺哈兰#58#40#0,0,0,40',
    [16] = '决战蓝天伐木场#68#40#0,0,0,40',
    [17] = '勇斗冬拥湖#68#40#0,0,0,40',
    [18] = '智斗托尔巴拉德#85#40#0,0,0,40',
    [19] = '决战荆棘谷：格罗姆高营地/反抗军营地#1#40#0,0,0,40',
    [20] = '决战阿拉希：蛮锤要塞VS避难谷地#1#40#0,0,0,40',
    [21] = '决战嚎风峡湾：瓦加德/复仇港#68#40#0,0,0,40',
    [22] = '决战北风苔原：战歌要塞/无畏要塞#68#40#0,0,0,40',
    [23] = '决战费伍德：血毒岗哨/野性之心哨站#1#40#0,0,0,40',
    [24] = '决战艾萨拉：塔论迪斯哨兵/锈水港#1#40#0,0,0,40',
    [25] = '决战凄凉之地：弗瑞恩的哨站#1#40#0,0,0,40',
    [26] = '决战凄凉之地：尼耶尔前哨战#1#40#0,0,0,40',
    [27] = '决战灰谷：碎木岗哨/阿斯特兰纳#1#40#0,0,0,40',
    [28] = '决战辛特兰：鹰巢山/恶齿村#1#40#0,0,0,40',
    [29] = '决战燃烧平原：烈焰峰/摩根的岗哨#1#40#0,0,0,40',
    [30] = '决战菲拉斯：羽月要塞/莫沙彻营地#1#40#0,0,0,40',
    [31] = '拦截黑暗之门#58#40#0,0,0,40',
    [32] = '决战地狱火半岛：萨尔玛/荣耀堡#58#40#0,0,0,40',
    [33] = '决战赞加沼泽：萨布拉金/泰雷多尔#58#40#0,0,0,40',
    [34] = '决战泰罗卡森林：裂石堡/奥蕾莉亚要塞#58#40#0,0,0,40',
    [35] = '决战纳格兰：加拉达尔/塔拉#58#40#0,0,0,40',
    [36] = '决战刀锋山：希尔瓦纳/雷神要塞#58#40#0,0,0,40',
    [37] = '决战影月谷：影月村/蛮锤要塞#58#40#0,0,0,40',
    [38] = '挑战：雷神要塞-雷克萨#58#40#0,0,0,40',
    [39] = '挑战：羽月要塞-珊蒂斯·羽月#1#40#0,0,0,40',
    [40] = '挑战：战歌要塞-加尔鲁什·地狱咆哮#68#40#0,0,0,40',
    [41] = '决战暮光高地：滩头堡/龙喉港#84#40#0,0,0,40',
    [42] = '决战瓦斯琪尔：军团营地/静谧海滩#80#40#0,0,0,40',
}

EVENT_MINLEVELS = {}
EVENT_MAXMEMBERS = {}
EVENT_DEFAULT_MEMBERROLES = {}
EVENT_ALLOW_CROSSREALMS = {}
