
BuildEnv(...)

Data = RaidBuilder:NewClass('Data')

function Data:Constructor(key)
    if type(key) ~= 'string' then
        error(([[bad argument #1 to 'New' (string expected, got %s)]]):format(type(key)), 3)
    end
    self.key = key
end

function Data:GetKey()
    return self.key
end

function Data:GetData()
    return self.data
end

function Data:SetData(data)
    self.data = data
    self:Fire('OnDataChanged', data)
end

function Data:SetCache(cache)
    self.cache = cache
end

function Data:GetCache()
    return self.cache or {}
end

function Data:IsNew()
    return self.new
end

function Data:SetIsNew(flag)
    self.new = flag or nil
end

DataCache = RaidBuilder:NewModule('DataCache', 'AceSerializer-3.0')

function DataCache:OnInitialize()
    self.hashCache = {}
    self.objects = {}
    self.db = Profile:GetGlobalDB().global.serverDatas
end

function DataCache:NewObject(key)
    if not self.objects[key] then
        self:SetObject(key, Data:New(key))
    end
    return self:GetObject(key)
end

function DataCache:SetObject(key, object)
    self.objects[key] = object
end

function DataCache:GetObject(key)
    return self.objects[key]
end

function DataCache:SaveHash(key, hash)
    self.hashCache[key] = hash

    local data = self.db[key]
    if data then
        self:SaveData(key, data)
    end
end

function DataCache:SaveData(key, data)
    if not self.hashCache[key] then
        return
    end
    if self.hashCache[key] ~= crc32(data) then
        return
    end

    local ok, dataKey, cache = self:Deserialize(data)
    if not ok or dataKey ~= key then
        return
    end

    local isNew = self.db[key] ~= data

    self.hashCache[key] = nil
    self.db[key] = data

    local object = self:GetObject(key)
    if not object then
        return
    end

    object:SetIsNew(isNew)
    object:Fire('OnCacheChanged', cache, isNew)
end
