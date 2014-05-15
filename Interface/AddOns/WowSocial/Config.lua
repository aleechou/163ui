
BuildEnv(...)

CURRENT_REALM = GetRealmName():gsub('%s+', '')
PLAYER_NAME = UnitName('player') .. '-' .. CURRENT_REALM

GROUPTYPE_NORMAL = 0
GROUPTYPE_NETEASE = 1

function IsSelf(target)
    return target == PLAYER_NAME
end

function GetFullName(name, realm)
    if not name then
        return
    end
    if realm == '' then
        realm = nil
    end
    local found = name:find('%-')
    if found and realm then
        error('error name', 2)
    end

    if found then
        return name
    else
        return ('%s-%s'):format(name, realm or CURRENT_REALM)
    end
end

function GetShortName(text)
    if not text then
        return
    end
    if not text:find('%-') then
        return text, CURRENT_REALM
    else
        return strsplit('-', text)
    end
end

function IsSameRealm(text)
    local name, realm = GetShortName(text)

    return realm and realm == CURRENT_REALM or nil
end

function GetUserNameInfo(text)
    local name, realm = GetShortName(text)
    local fullname = GetFullName(text)

    return name, realm, fullname, realm and realm == CURRENT_REALM or nil
end

