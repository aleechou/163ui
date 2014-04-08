local setProfanityFilter
local L = select(2,...).L
U1RegisterAddon("!!!163UI!!!", {
    title = L["网易有爱"],
    tags = {TAG_MANAGEMENT},
    desc = L["网易有爱（163UI）插件是由网易游戏频道官方推出的一款新一代整合插件。其设计理念是兼顾整合插件的易用性和单体插件的灵活性，同时适合普通和高级用户群体。``插件中心控制台是网易有爱团队全力打造的管理界面，整合了'插件加载管理'、'插件选项配置'、'标签式分类'、'实时全文搜索'、'小地图按钮收集'等一系列先进功能。而且任意插件均可'一键启用'，不需重载界面。``网易有爱将依靠强大的技术实力，让插件更少的报错、让问题更快的回复、让建议更快的实现，为您提供更新更快更强大的新一代整合插件。"],
    protected = 1,
    icon = "Interface\\AddOns\\!!!163UI!!!\\Textures\\IconNetEase",

    author = L["|cffcd1a1c[网易原创]|r"],

    {
        var = "extrabutton",
        text = "显示替代的额外按钮",
        tip = "说明`4.3的部分副本战斗中，屏幕中央会出现一个动作按钮，例如巨龙副本的5号BOSS，需要玩家点击'英勇意志'技能。`但问题是很多动作条插件还不支持这一特殊按钮，经常导致看不到。如果您属于这种情况，可以打开此选项，使用替代按钮即可。",
        default = nil,
        callback = function(cfg, v, loading)
            CoreLeaveCombatCall(cfg._path, "战斗中无法显示或隐藏。", function() CoreUIShowOrHide(U1ExtraAction1, v) end)
        end,
    },
    {
        var = "disableLaterLoading",
        text = L["进入世界后再加载插件"],
        tip = L["说明`网易有爱独家支持，可以先读完蓝条然后再逐一加载插件。会大大加快读条速度，但是加载大型插件时会有卡顿。如果不喜欢这种方式，请取消勾选即可，下次进游戏时就会采用新设置。` `对比测试：`未开启时，在第7.5秒后读完蓝条同时加载完全部插件`开启后，在第3.8秒读完蓝条，第8.0秒加载完全部插件"],
        default = 1,
        getvalue = function() return not U1DB.disableLaterLoading end,
        callback = function(cfg, v, loading)
            U1DB.disableLaterLoading = not v;
        end,
        {
            var = "speed",
            text = L["插件加载速度（个/秒）"],
            tip = L["说明`　控制进入游戏时插件加载的速度，如果数值大，则单次卡顿的时间长，但总的加载时间会短，比如设置成100就会大卡一下后插件就全部加载好了。而设置成5则是每秒只会小卡一下，但要很久才能加载完全部插件。` `　另外可以使用/rl2命令来强制最慢速度加载，适合副本战斗中界面出错后（比如上载具没出动作条）迅速重载界面。"],
            default = 20,
            reload = 1,
            type = "spin",
            range = {5, 100, 5},
            getvalue = function() return U1DB.loadSpeed end,
            callback = function(cfg, v, loading)
                U1DB.loadSpeed = v
            end,
        }
    },
    {
        --处理函数是 _G[cfgName] = toggle; 通过metatable调用的
        var = "name",
        text = "仅开启插件声音",
        tip = "说明`网易有爱独家研发实现` `开启此选项后，只能听到插件（比如DBM语音版）发出的声音，听不到游戏中的其他音效，最大限度的跟4.0之前的游戏效果一致。` `不需替换任何游戏文件，完全是插件实现的。` `注意，如果背景音乐没有停止，请按两次Ctrl+M，即打开音乐再关闭。",
        default = nil,
    },
    {
        var = "checkAddonVersion",
        text = L["允许加载过期插件"],
        tip = L["说明`和人物选择功能插件界面上的选项一致"],
        default = "0",
        getvalue = function() return GetCVar("checkAddonVersion")=="0" end,
        callback = function(cfg, v, loading)
            SetCVar("checkAddonVersion", v and "0" or "1")
        end,
    },
    {
        var = "TooltipReforgeStat",
        text = "显示已重铸物品的属性变化",
        default = 1,
    },
    {
        var = 'profanityFilter',
        text = '强制关闭语言过滤器',
        tip = '说明`4.3版本后出现的BUG，玩家即使不开启过滤器，系统有时也会强制过滤，而且在界面选项里无法修改。开启此选项后，网易有爱会强制关闭语言过滤器选项。',
        default = false,
        --getvalue = function()
        --    return GetCVar'profanityFilter' == '1'
        --end,
        callback = function(cfg, v, loading)
            return setProfanityFilter()
        end
    },
    {
        var = "lootenh",
        text = "启用ROLL点界面增强",
        tip = "说明`在物品等待分配的界面上显示已选择'贪婪'、'需求'、'放弃'的队员人数及职业。并可以在获胜时生成Roll点结果链接供点击查看。|cff00ff00开启此选项后，界面-显示-详细拾取信息将保持开启。|r",
        default = 1,
        reload = 1,
        callback = function(cfg, v, loading)
            if loading and v then
                CoreCall("U1GroupLootRoll");
            end
            U1GroupLootRoll = nil;
        end,
        {
            var = "filter",
            text = "屏蔽ROLL点时的详细信息",
            tip = "说明`Roll点界面增强要求始终显示详细的拾取信息，如果觉得太乱可以开启此选项屏蔽这些信息，可以通过物品选择界面看到需求选择情况，最后结果中的链接可以点击查看详情。",
            default = false,
            callback = function(cfg, v, loading)
                U1_GROUP_LOOT_FILTER = v
            end,
        },
    },
    {
        var = "ahkeep",
        text = "保持拍卖行界面开启",
        tip = "说明`打开交易技能等界面时保持拍卖行界面开启，适用于屏幕分辨率不高的玩家。如果遇到拍卖行无法打开的情况，请尝试关闭此选项。",
        default = false,
        callback = function(cfg, v, loading)
            if loading and not v then return end
            --- 拍卖行不会自动关闭
            CoreDependCall("Blizzard_AuctionUI", function()
                if v then
                    AuctionFrame:SetAttribute("UIPanelLayout-area", false);
                    tinsertdata(UISpecialFrames, "AuctionFrame")
                else
                    AuctionFrame:SetAttribute("UIPanelLayout-area", "doublewide");
                    tremovedata(UISpecialFrames, "AuctionFrame")
                end
                if not AuctionFrame._hooked163 then
                    AuctionFrame._hooked163 = true
                    hooksecurefunc(AuctionFrame, "SetAttribute", function(self, arg1, value)
                        if (arg1 == "UIPanelLayout-area" and value and U1GetCfgValue(cfg._path)) then
                            self:SetAttribute(arg1, false);
                        end
                    end)
                end
            end)
        end,
    },
    {
        var = "fixhot",
        text = "临时修复动作条热键乱码",
        tip = "说明`暴雪给动作条热键设置的默认字体不支持中文，所以遇到'鼠标滚轮'之类的就会显示????，这个选项是用来临时修复的，如果自己修改了字体，请关闭。",
        default = nil,
        callback = function(cfg, v, loading)
            U1NumberFontNormalSmallGray = U1NumberFontNormalSmallGray or WW:Font("U1NumberFontNormalSmallGray", ChatFontNormal, 11, .6, .6, .6, 1):SetFontFlags("OUTLINE, MONOCHROME"):un()
            if loading then
                CoreDependCall("ExtraActionBar", function()
                    hooksecurefunc("U1BAR_CreateBar", function(name)
                        local font, height, flags
                        if U1GetCfgValue(cfg._path) then
                            font, height, flags = U1NumberFontNormalSmallGray:GetFont()
                        else
                            font, height, flags = NumberFontNormalSmallGray:GetFont()
                        end
                        for i=1, 12 do _G[name.."AB"..i.."HotKey"]:SetFont(font, height, flags) end
                    end)
                end)
            end
            if loading and not v then return end

            local font, height, flags
            if v then
                font, height, flags = U1NumberFontNormalSmallGray:GetFont()
            else
                font, height, flags = NumberFontNormalSmallGray:GetFont()
            end
            for _, btn in next, ActionBarButtonEventsFrame.frames do
                if btn:GetName() then
                    local hotkey = _G[btn:GetName().."HotKey"]
                    if hotkey then
                        hotkey:SetSize(37, 10)
                        --载具的会看不到
                        --hotkey:ClearAllPoints();
                        --hotkey:SetPoint("TOPRIGHT", 1, -2);
                        hotkey:SetFont(font, height, flags)
                    end
                end
            end
            for i=1, 10 do
                if _G["U1BAR"..i] then
                    for j =1, 12 do _G["U1BAR"..i.."AB"..j.."HotKey"]:SetFont(font, height, flags) end
                end
            end
        end,
    },
    {
        var = "hideCompactRaid",
        text = L["完全屏蔽默认的团队框架"],
        tip = L["说明`完全屏蔽暴雪团队框架及屏幕左侧的控制条，在使用Grid等团队框架时可以减少占用。` `注意此选项不能在战斗中设置"],
        default = nil,
        secure = 1,
        callback = function(cfg, v, loading)
            if loading and not v then return end
            if not GetDisplayedAllyFrames or not CompactRaidFrameManager or not CompactRaidFrameContainer then
                U1Message(L["此选项不适合此游戏版本"])
                return
            end
            if InCombatLockdown() then U1Message(L["此选项无法在战斗中设置，请脱战后重试"]) return end

            if not U1StoreHideCompactRaid then
                U1StoreHideCompactRaid = { onUpdateFrames = {} } --first time --CompactUnitFrame.lua:142 --if show target then there will be tainting
                for i=1, 100 do
                    local frame = _G["CompactRaidFrame"..i]
                    if frame and frame.onUpdateFrame then U1StoreHideCompactRaid.onUpdateFrames[frame.onUpdateFrame] = true end
                end
                hooksecurefunc("CompactUnitFrame_SetUpdateAllOnUpdate", function(frame)
                    if frame and frame.onUpdateFrame then U1StoreHideCompactRaid.onUpdateFrames[frame.onUpdateFrame] = true end
                end)
            end

            --togglescripthook(U1StoreHideCompactRaid, CompactRaidFrameManager, "OnShow", function(self) self:Hide() end, v)
            togglescripthook(U1StoreHideCompactRaid, CompactRaidFrameContainer, "OnShow", function(self) self:Hide() end, v)
            if v then
                CompactRaidFrameManager:SetAlpha(0) --CompactRaidFrameManager 不能Hide，会污染
                CompactRaidFrameManager:UnregisterAllEvents();
                CompactRaidFrameContainer:Hide()
                CompactRaidFrameContainer:UnregisterAllEvents();
                for frame, _ in pairs(U1StoreHideCompactRaid.onUpdateFrames) do frame:Hide() end
            else
                for frame, _ in pairs(U1StoreHideCompactRaid.onUpdateFrames) do frame:Show() end
                CompactRaidFrameManager:RegisterEvent("DISPLAY_SIZE_CHANGED");
                CompactRaidFrameManager:RegisterEvent("UI_SCALE_CHANGED");
                CompactRaidFrameManager:RegisterEvent("GROUP_ROSTER_UPDATE");
                CompactRaidFrameManager:RegisterEvent("UNIT_FLAGS");
                CompactRaidFrameManager:RegisterEvent("PLAYER_FLAGS_CHANGED");
                CompactRaidFrameManager:RegisterEvent("PLAYER_ENTERING_WORLD");
                CompactRaidFrameManager:RegisterEvent("PARTY_LEADER_CHANGED");
                CompactRaidFrameManager:RegisterEvent("RAID_TARGET_UPDATE");
                CompactRaidFrameContainer:RegisterEvent("GROUP_ROSTER_UPDATE");
                CompactRaidFrameContainer:RegisterEvent("UNIT_PET");
                --local sub = U1CfgFindChild(cfg, "always")
                if GetDisplayedAllyFrames()=="raid" or true then --(sub and U1LoadDBValue(sub)) then
                    CompactRaidFrameContainer:Show()
                    CompactRaidFrameManager:SetAlpha(1)
                end
            end
        end,
--[[
        {
            var = "always",
            default = nil,
            text = "无条件显示团队框架",
            tip = "说明`无论单人还是小队，只要解除屏蔽，就总是显示默认的团队框架。`修改此选项后必须切换次上一选项。",
        }
]]
    },
    {
        var = 'bfautorelease',
        default = false,
        text = '自动释放灵魂(战场)',
    },
    {
        var = 'map_raid_color',
        default = true,
        text = '将地图上队友图标用职业颜色显示',
        reload = 1,
        callback = function(cfg, v, loading)
            local mod = _G['_163_MAP_RAID_COLOR']
            if(mod and mod.Init) then
                return mod:Init()
            end
        end,
    },
    {
        var = "cameraDistancemax",
        text = L["设置最远镜头距离"],
        tip = L["说明`这个值是修改\"界面-镜头-最大镜头距离\"绝对值, 比如, 系统默认为15, 界面设置里调到最大是15，调到中间是7.5。当设置此选项为25时，调到最大是25，调到中间是12.5"],
        type = "spin",
        range = {10, 25, 5},
        cols = 3,
        default = "20",
        getvalue = function() return GetCVar("cameraDistancemax") end,
        callback = function(cfg, v, loading) SetCVar("cameraDistancemax", v) SetCVar("cameraDistanceMaxFactor", 2) end,
    },
    {
        text = "重置界面框体顺序",
        confirm = "此操作需要重载界面，您是否确定？",
        tip = "说明`经过网易有爱团队的测试，暴雪目前的界面存在一个BUG，当打开过多界面时，框体层次顺序可能会出错，使得某些按钮被遮挡无法看到，或者无法点击。` `当出现类似问题的时候，尝试点击此按钮，会重置所有框体的层次并重载界面，问题一般就会修复。",
        callback = function(cfg, v, loading)
            local f = EnumerateFrames()
            while f do
                if f:IsUserPlaced() then
                    f:SetFrameLevel(1)
                end
                f = EnumerateFrames(f)
            end
            ReloadUI()
        end
    },
    {
        text = L["控制台设置"], type = "text",
        {
            var = "english",
            text = L["显示插件英文名"],
            default = false,
            tip = L["说明`选中显示插件目录的名字，适合中高级用户快速选择所需插件。"],
            getvalue = function() return U1GetShowOrigin() end,
            callback = function(cfg, v, loading)
                U1SetShowOrigin(v);
                if not loading then
                    U1SortAddons();
                    UUI.Right.ADDON_SELECTED();
                end
            end,
        },
        {
            var = "sortmem",
            text = L["按插件所用内存排序"],
            default = false,
            tip = L["说明`选中则按插件(包括子模块)所占内存大小进行排序，否则按插件名称排序。"],
            getvalue = function() return not U1DB.sortByName end,
            callback = function(cfg, v, loading)
                U1DB.sortByName = not v;
                if not loading then
                    UpdateAddOnMemoryUsage();
                    U1SortAddons()
                end
            end,
        },
    },
    {
        text = L["小地图相关"], type = "text",
        {
            var = "changeClip",
            default = false,
            text = "修改小地图目标标记",
            tip = "说明`默认的小地图目标标记太大，容易遮挡周围图标，选中此项可简化一下。",
            callback = function(cfg, v, loading)
                CoreCall("ToggleMinimapBlips", v)
            end
        },
        {
            lower = true,
            text = L["收集全部小地图图标"],
            callback = function(cfg, v, loading)
                CoreCall("U1_MMBCollectAll");
                CoreCall("U1_MMBUpdateUI");
            end
        },
        {
            text = L["还原全部小地图图标"],
            callback = function(cfg, v, loading)
                CoreCall("U1_MMBRestoreAll");
                CoreCall("U1_MMBUpdateUI");
            end
        },
        {
            var = "coord",
            default = 1,
            text = "显示坐标小窗",
            callback = function(cfg, v, loading) if not MinimapCoordsButton then return end if v then MinimapCoordsButton:Show() else MinimapCoordsButton:Hide() end end,
        },
        {
            var = "zoom",
            default = 1,
            text = L["隐藏缩小放大按钮"],
            tip = L["说明`隐藏后用鼠标滚轮缩放小地图"],
            callback = function(cfg, v, loading) CoreCall("U1MMB_MinimapZoom_Toggle", v) end,
        },
        {
            var = 'minimap_ping',
            default = 1,
            text = '显示小地图点击者名字',
            callback = function(_, v, loading)
                if(not loading) then
                    local addon = LibStub('AceAddon-3.0'):GetAddon('163PingPing')
                    if(addon) then
                        if(v) then
                            addon:Enable()
                        else
                            addon:Disable()
                        end
                    end
                end
            end,
        },
        {
            var = 'print_huangli_onload',
            default = 1,
            text = '每天第一次登陆时显示老黄历',
        },
    },
});

U1RegisterAddon("!!!163UI.pics!!!", { title = "插件说明图片", hide = 1, defaultEnable = 0 });

if(not GetCVar) then return end

do
    setProfanityFilter = function()
        if(U1GetCfgValue('!!!163ui!!!', 'profanityFilter')) then
            SetCVar('profanityFilter', '0')
            --if BNConnected() then
            pcall(BNSetMatureLanguageFilter, false)
        end
    end

--     for _, e in next, {
--         'CVAR_UPDATE',
--         'PLAYER_ENTERING_WORLD',
--         'BN_MATURE_LANGUAGE_FILTER',
--         -- events that might cause problem
--         -- 'MINIMAP_UPDATE_ZOOM',
--         -- 'UPDATE_CHAT_COLOR_NAME_BY_CLASS',
--     } do
--         CoreOnEvent(e, setProfanityFilter)
--     end
end

