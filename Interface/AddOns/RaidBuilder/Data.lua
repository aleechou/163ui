
BuildEnv(...)

L = LibStub('AceLocale-3.0'):GetLocale('RaidBuilder')

ADDON_NAME = ...
ADDON_LOGO = [[Interface\AddOns\]] .. ADDON_NAME .. [[\Media\Logo]]
ADDON_VERSION = GetAddOnMetadata(ADDON_NAME, 'Version')
ADDON_VERSION_SHORT = ADDON_VERSION:gsub('(%d)%d(%d)%d%d%.(%d%d)','%1%2%3')

MAX_PLAYER_LEVEL = MAX_PLAYER_LEVEL_TABLE[GetExpansionLevel()]

EVENT_MATCH_TYPE = 0x0F000000
EVENT_MATCH_WVER = 0x00F00000
EVENT_MATCH_ID   = 0x000FF000

EVENT_TYPE_RAID     = 0x01000000

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

---- 队伍列表

_RAID_UNITS = {}
_PARTY_UNITS = { 'player' }

for i = 1, 40 do
    tinsert(_RAID_UNITS, 'raid' .. i)
end
for i = 1, 4 do
    tinsert(_PARTY_UNITS, 'party' .. i)
end

-- UNIT_LOGO
UNIT_LOGO_NETEASE   = 10
UNIT_LOGO_DEV       = 20
UNIT_LOGO_TOTAL     = 100
UNIT_LOGO_MONTH     = 101
UNIT_LOGO_90303A    = 200
UNIT_LOGO_90303B    = 201
UNIT_LOGO_90303C    = 202
UNIT_LOGO_90303D    = 203
UNIT_LOGO_90303E    = 204
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

UNIT_LOGO_NAMES = {
    -- [UNIT_LOGO_NONE     ] = NONE,
    [UNIT_LOGO_NETEASE  ] = L['网易官方活动'],
    [UNIT_LOGO_DEV      ] = L['集合石开发团队'],
    [UNIT_LOGO_TOTAL    ] = L['集合石总榜团长'],
    [UNIT_LOGO_MONTH    ] = L['集合石月榜团长'],
    [UNIT_LOGO_90303A   ] = L['90303人气团长'],
    [UNIT_LOGO_90303B   ] = L['90303人气团长'],
    [UNIT_LOGO_90303C   ] = L['90303人气团长'],
    [UNIT_LOGO_90303D   ] = '',
    [UNIT_LOGO_90303E   ] = L['人气主播'],
    [UNIT_LOGO_FAMOUS   ] = '',
    [UNIT_LOGO_WEB      ] = L['集合石人气团长'],
    [UNIT_LOGO_PVP      ] = L['PVP人气团长'],
    [UNIT_LOGO_RAID     ] = L['PVE人气团长'],
    [UNIT_LOGO_GOOD     ] = L['好团长'],
}

UNIT_LOGO_TEXTURE   = {
    [UNIT_LOGO_NONE     ] = [[]],
    [UNIT_LOGO_NETEASE  ] = MakeLogo(UNIT_LOGO_NETEASE, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_DEV      ] = MakeLogo(UNIT_LOGO_DEV, LOGO_SIZE/2, LOGO_SIZE),
    [UNIT_LOGO_TOTAL    ] = [[|TINTERFACE\Challenges\challenges-gold-sm:20:20:0:0:64:64:18:46:16:44|t]],
    [UNIT_LOGO_MONTH    ] = [[|TINTERFACE\Challenges\challenges-plat-sm:20:20:0:0:64:64:18:46:16:44|t]],
    [UNIT_LOGO_90303A   ] = MakeLogo(UNIT_LOGO_90303A, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_90303B   ] = MakeLogo(UNIT_LOGO_90303B, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_90303C   ] = MakeLogo(UNIT_LOGO_90303C, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_90303D   ] = MakeLogo(UNIT_LOGO_90303D, LOGO_SIZE*0.8, LOGO_SIZE),
    [UNIT_LOGO_90303E   ] = MakeLogo(UNIT_LOGO_90303E, LOGO_SIZE-2, LOGO_SIZE+1),
    [UNIT_LOGO_FAMOUS   ] = [[]],
    [UNIT_LOGO_WEB      ] = MakeLogo(UNIT_LOGO_WEB, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_PVP      ] = MakeLogo(UNIT_LOGO_PVP, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_RAID     ] = MakeLogo(UNIT_LOGO_RAID, LOGO_SIZE, LOGO_SIZE),
    [UNIT_LOGO_GOOD     ] = MakeLogo(UNIT_LOGO_GOOD, LOGO_SIZE, LOGO_SIZE),
}

UNIT_LOGO_LIST = {}


--[[
local UNIT_LOGO_DATA = ''

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

--]]

EVENT_TYPES = {}

for i, v in pairs(EVENT_NAMES) do
    EVENT_TYPES[v] = i
end

SOURCE_ICONS = {
    [2] = [[Interface\AddOns\RaidBuilder\Media\Mark\2]],
    [3] = [[Interface\AddOns\RaidBuilder\Media\Mark\3]],
    [5] = [[Interface\AddOns\RaidBuilder\Media\Mark\5]]
}

MALL_CATEGORY_ICON_LIST = {
    [0] = {0, 0.25, 0, 0.5},
    [1] = {0.5, 0.75, 0.5, 1},
    [2] = {0.25, 0.5, 0.5, 1},
    [3] = {0, 0.25, 0.5, 1},
    [4] = {0.75, 1, 0, 0.5},
    [5] = {0.5, 0.75, 0, 0.5},
    [6] = {0.25, 0.5, 0, 0.5},
}
