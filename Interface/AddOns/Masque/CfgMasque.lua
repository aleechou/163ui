--if(true) then return end

local names = {
    ["Blizzard"] = "暴雪默认",
    ["Caith"] = "粗边框",
    ["Darion"] = "焦黑",
    ["Darion Clean"] = "焦黑（粗边）",
    ["Dream"] = "无边框",
    ["Zoomed"] = "无边框放大",
    ["HelloKitty"] = "凯蒂猫",
    ["HelloKitty Christmas"] = "圣诞凯蒂猫",
    ["Entropy: Silver"] = "质感(银)",
    ["Entropy: Adamantite"] = false, --"质感(精金)",
    ["Entropy: Bronze"] = "质感(青铜)",
    ["Entropy: Cobalt"] = "质感(钴)",
    ["Entropy: Copper"] = "质感(铜)",
    ["Entropy: Fel Iron"] = false, --"质感(魔铁)",
    ["Entropy: Gold"] = "质感(金)",
    ["Entropy: Iron"] = "质感(铁)",
    ["Entropy: Khorium"] = "质感(氪金)",
    ["Entropy: Obsidium"] = "质感(黑曜石)",
    ["Entropy: Saronite"] = false, --"质感(萨隆邪铁)",
    ["Entropy: Titanium"] = false, --"质感(泰坦神铁)",
    ["Serenity"] = "圆形白边框",
    ["Serenity Redux"] = false,
    ["Serenity: Square"] = "方形白边框",
    ["Serenity: Square Redux"] = false,
}

local SkinList = {}
local CoreGroup

local function get_option()
    wipe(SkinList)
    local Masque = LibStub('Masque', true)
    if(Masque) then
        local Skins = Masque and Masque.GetSkins and Masque:GetSkins()
        if Skins then
            for skinName in next, Skins do
                local localeName = names[skinName]
                if(localeName ~= false) then
                    table.insert(SkinList, localeName or skinName)
                    table.insert(SkinList, skinName)
                end
            end
            -- table.sort(SkinList);
            -- for i=1, #SkinList, 2 do SkinList[i] = names[SkinList[i]] or SkinList[i]; end
        else
            table.insert(SkinList, '请先启用插件')
            table.insert(SkinList, 'NONE')
        end
    end
    return SkinList
end

local function getGlobal()
    if(not CoreGroup) then
        local Masque = Masque or LibStub'AceAddon-3.0':GetAddon'Masque'
        CoreGroup = Masque and Masque.Core and Masque.Core:Group()
    end
    return CoreGroup
end


U1RegisterAddon("Masque", {
    title = "按钮美化",
    defaultEnable = 0,
    --optionsAfterVar = 1,
    minimap = "LibDBIcon10_Masque",
    load = "NORMAL", --支持其他第三方插件

    tags = { TAG_INTERFACE,},
    icon = [[Interface\Addons\Masque\Textures\Icon]],
    desc = "为动作条按钮提供样式切换，拥有众多的皮肤类扩展，是此类美化插件的第一选择。`网易有爱在原版的基础上整合了玩家增益美化，并精选了几种有代表性的皮肤样式，可以用控制台轻松选择。当然，您也可以下载任意皮肤包放到插件目录里，网易有爱对此提供良好的兼容。",

    toggle = function(name, info, enable, justload)
        local Masque = LibStub("AceAddon-3.0"):GetAddon("Masque").Core
        local v;
        v = nil if not enable then v = false end
        U1CfgCallBack(U1CfgFindChild("masque", "hidecap"), v)
        v = nil if not enable then v = false end
        U1CfgCallBack(U1CfgFindChild("masque", "hidebg"), v)

        if U1IsInitComplete() then
            --后加载的时候需要执行Enable，禁用的跳过，执行完Disable后要恢复设置
            for _, v in pairs(Masque:Group().SubList) do
                if not Masque:Group(v).db.Disabled then
                    CoreUIEnableOrDisable(Masque:Group(v), enable)
                    Masque:Group(v).db.Disabled = false
                end
            end
        end
    end,

    {
        text = "配置选项",
        callback = function() SlashCmdList["MASQUE"]() end,
    },
    {
        type = 'radio',
        var = "style",
        text = '请选择皮肤样式',
        options = get_option,
        default = 'Serenity: Square',
        indent = nil,
        cols = 2,
        getvalue = function() 
			if MasqueDB and MasqueDB.profiles and   MasqueDB.profiles.Default and  MasqueDB.profiles.Default.Groups and MasqueDB.profiles.Default.Groups.Masque and MasqueDB.profiles.Default.Groups.Masque.SkinID then
				return MasqueDB.profiles.Default.Groups.Masque.SkinID
			else
				return "Blizzard"
			end
		end,
        callback = function(cfg, v, loading)
            if v~='NONE' then
				local Masque = LibStub('Masque', true)
				local info = {"Addons","Global","SkinID",}
				local Skins = Masque and Masque.SetOption and Masque:SetOption(info,v)
            end
        end,
    },
    {
        text = "设置动作条布局",
        tip = "说明`打开多米诺动作条的设置面板。",
        callback = function() UUI.OpenToAddon("Dominos") end,

    },	
	{
        var = 'hookbuff',
        default = 1,
        text = '美化玩家增益减益图标',
        callback = function(cfg, v, loading)
            local group = LibStub("Masque"):Group('默认BUFF按钮')
            if loading then return end
            CoreUIEnableOrDisable(LibStub("Masque"):Group('默认BUFF按钮'), v)
        end,
        -- {
        --     var = "buffSize",
        --     default = 13,
        --     type = "spin",
        --     reload = 1,
        --     tip = "说明`调整美化后的增益减益下面的计时文字尺寸。",
        --     range = {9, 15, 1},
        --     text = "剩余时间文字大小",
        -- }
    },
    -- {
    --     var = "nameSize",
    --     default = 13,
    --     type = "spin",
    --     reload = 1,
    --     tip = "说明`调整技能按钮上显示的宏的字体大小。",
    --     range = {9, 15, 1},
    --     text = "默认按钮文字大小",
    -- }

   
   {
        text = "隐藏主动作条两侧材质",
        var = "hidecap",
        default = 1,
        callback = function(cfg, v, loading)
            CoreUIShowOrHide(MainMenuBarLeftEndCap, not v)
            CoreUIShowOrHide(MainMenuBarRightEndCap, not v)
        end
    },
    {
        text = "隐藏主动作条背景材质",
        var = "hidebg",
        default = 1,
        callback = function(cfg, v, loading)
            for i=0,3 do
                local tex = _G["MainMenuBarTexture"..i]
                CoreUIShowOrHide(tex, not v);
            end
            local bonus = { "SlidingActionBarTexture0", "SlidingActionBarTexture1", } --"ShapeshiftBarLeft", "ShapeshiftBarMiddle", "ShapeshiftBarRight",
            for _, tex in ipairs(bonus) do CoreUIShowOrHide(_G[tex], not v) end
            if(not MainMenuExpBar:IsVisible() and not ReputationWatchBar:IsVisible())then
                CoreUIShowOrHide(MainMenuBarMaxLevelBar, not v)
            end
            if loading then
                local function forceHide(self) if U1GetCfgValue(cfg._path) then self:Hide() end end
                for _, tex in ipairs(bonus) do if _G[tex] then hooksecurefunc(_G[tex], "Show", forceHide) end end
            end
            local tex = v and [[Interface\AddOns\Masque\Textures\UI-XP-Bar]] or [[Interface\MainMenuBar\UI-XP-Bar]]
            for i=1,19 do
		        local texture = _G["MainMenuXPBarDiv"..i];
                texture:SetTexture(tex)
            end
            MainMenuXPBarTextureLeftCap:SetTexture(tex)
            MainMenuXPBarTextureRightCap:SetTexture(tex)
            local tex = v and [[Interface\AddOns\Masque\Textures\UI-XP-Mid]] or [[Interface\MainMenuBar\UI-XP-Mid]]
            MainMenuXPBarTextureMid:SetTexture(tex)
            if v then
                ReputationWatchBarTexture0:SetPoint("TOPLEFT", -2, 2)
                MainMenuExpBar:SetScale(0.98)
                ReputationWatchBar:SetScale(0.98)
            else
                ReputationWatchBarTexture0:SetPoint("TOPLEFT", 0, 2)
                MainMenuExpBar:SetScale(1)
                ReputationWatchBar:SetScale(1)
            end

--[[
            if(loading) then
                for i = 1, 4 do
                    local f = _G['BonusActionBarFrameTexture'..i]
                    if(v) then
                        f:Hide()
                    end
                end
                BonusActionBarFrame:HookScript('OnShow', function()
                    local v = U1GetCfgValue('Masque', 'hidebg')
                    for i = 1, 4 do
                        local f = _G['BonusActionBarFrameTexture'..i]
                        if(v) then
                            f:Hide()
                        else
                            f:Show()
                        end
                    end
                end)
            end

            for i = 1, 4 do
                local f = _G['BonusActionBarFrameTexture'..i]
                if(v) then
                    f:Hide()
                else
                    f:Show()
                end
            end
--]]
        end
    
	},

 });   

U1RegisterAddon("ButtonFacade", {
    title = "ButtonFacade",
    parent = "Masque",
    desc = "为Masque提供兼容老版的接口,不可关闭",
    protected = 1,
    load = "NORMAL",
    secure = 1,
    hide = 1,
    toggle = function(name, info, enable, justload)
        if justload then
            CoreScheduleTimer(false, 0.2, UUI.Right.ADDON_SELECTED);
        end
    end,
});

if hooksecurefunc then
    --满级以后的条
    hooksecurefunc("ReputationWatchBar_Update", function(newLevel)
        local name, reaction, min, max, value = GetWatchedFactionInfo();
        local visibilityChanged = nil;
        if ( not newLevel ) then
            newLevel = UnitLevel("player");
        end
        if ( name ) then
            if not ( newLevel < MAX_PLAYER_LEVEL and not IsXPUserDisabled() ) then
                ReputationWatchStatusBar:SetHeight(11);
            end
        end
    end)
end

