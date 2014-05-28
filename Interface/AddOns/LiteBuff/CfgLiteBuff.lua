
local wipe = wipe
local tinsert = table.insert

local db, list

U1RegisterAddon("LiteBuff", {
    title = "職業快捷按鈕",
    defaultEnable = 1,
    tags = { TAG_COMBATINFO },
    frames = { 'LiteBuffFrame' },
    optionsAfterVar = 1,
    load = "LOGIN",
    icon = [[Interface\Icons\INV_Relics_Warpring]],
    desc = "Abin的最新作品，針對每個職業配置的快捷施法條。例如潛行者有3個按鈕，分別代表主手、副手、遠程武器，鼠標滾輪選擇要使用的毒藥，左鍵點擊是上毒，右鍵點擊是移除毒藥。再比如法師開門，也是滾動選擇目的地，左鍵開門，右鍵自己傳送。部分狀態類的按鈕上，紅色表示缺失此狀態，黃色表示部分人員缺失，綠色表示齊備。`此外還提供了天賦切換、精煉合計、隨機坐騎的按鈕。插件完全使用安全模板開發，戰鬥中不會出錯，Abin出品值得信賴。",
    author = "Abin",
    modifier = "|cffcd1a1c[Warbaby@163]|r",

    toggle = function(name, info, enable, justload)
        if not justload then
            if not InCombatLockdown() then
                CoreUIShowOrHide(LiteBuffFrame, enable)
            end
        end
        if(not InCombatLockdown()) then
            return LiteBuff:RefreshLiteBuffs()
        end
    end,

    {
        var = 'growh',
        text = '橫向排列',
        default = 1,
        callback = function(cfg, v, loading)
            if(not loading) then LiteBuff:RefreshLiteBuffs() end
        end,
    },

    {
        var = 'locked',
        text = '鎖定位置',
        default = false,
        callback = function(cfg, v, loading)
            LiteBuff.chardb.lock = v
        end,
    },

    {
        var = 'iconsize',
        text = '圖標尺寸',
        default = 32,
        type = "spin",
        range = {24, 48, 1},
        callback = function(cfg, v, loading)
            if(not loading) then LiteBuff:RefreshLiteBuffs() end
        end,
    },

    {
        var = 'gap',
        text = '圖標間隔',
        default = 6,
        type = "spin",
        range = {-2, 20, 1},
        callback = function(cfg, v, loading)
            if(not loading) then LiteBuff:RefreshLiteBuffs() end
        end,
    },

    {
        type = 'spin',
        var = 'scale',
        text = '縮放',
        range = { .2, 3, .05 }, -- Limit from litebuff itself
        default = 1,
        -- getvalue = function()
        --     if(LiteBuff) then
        --         return LiteBuff.profile.scale / 100
        --     else
        --         return 1
        --     end
        -- end,
        callback = function(cfg, v, loading)
            local scale = v * 100
            if(scale > 300 or scale < 20) then
                scale = 100
            end
            LiteBuff.db.scale = scale
            LiteBuff.frame:SetScale(scale / 100)
        end,
    },
    {
        var = 'simpletip',
        text = '簡短提示',
        default = false,
        -- getvalue = function()
        --     return LiteBuff and LiteBuff.db.simpletip
        -- end,
        callback = function(cfg, v, loading)
            LiteBuff.db.simpletip = v
        end,
    },

    {
        type = 'checklist',
        text = '禁用按鈕',
        getvalue = function()
            db = db or {}
            wipe(db)
            for i = 1, LiteBuff:GetNumButtons() do
                local b = LiteBuff:GetButton(i)
                db[b.key] = LiteBuff:LoadData('disabledb', b.key)
            end
            return db
        end, 

        callback = function(cfg, v, loading)
            if(loading) then return end
            db = v
            for key, checked in next, v do
                if(checked ~= LiteBuff:LoadData('disabledb', key)) then
                    LiteBuff:SaveData("disabledb", key, checked)
                    local button = LiteBuff:GetButton(key)
                    if checked then
                        button:Disable()
                    else
                        button:Enable()
                    end
                end
            end
        end, 

        options = function()
            list = list or {}
            wipe(list)
            if(LiteBuff) then
                for i = 1, LiteBuff:GetNumButtons() do
                    local b = LiteBuff:GetButton(i)
                    tinsert(list, b.title)
                    tinsert(list, b.key)
                end
            end
            return list
        end,
        indent = nil,
        cols = 2,
    },

});


