U1RegisterAddon("Dominos", {
    title = "多米诺动作条",
    optdeps = {"Masque"},
    --desc = "",
    defaultEnable = 1,
    load = "NORMAL",

minimap = "LibDBIcon10_Dominos",
    tags = { TAG_INTERFACE, TAG_BIG, },
    icon = 'Interface\\Addons\\Dominos\\Dominos',

    modifier = "|cffcd1a1c[网易]|r",

    desc = "一个简单易用的动作条移动插件，可以移动动作条、施法条、姿态条、宠物条、图腾条等等。`初次使用会自动加载我们预设的'三行紧凑型'布局，如果以前用过此插件，可能需要手工在控制台里设置一下。`可以左键点击小地图按钮进入设置模式，然后用鼠标拖动位置，或者右键点击打开设置菜单。如果按住shift点击则可以按键绑定模式，鼠标悬停在动作条按钮上就可以快速设置此按钮的热键。`建议配合按钮美化插件一起使用。`特别提示萨满同学，图腾条第一个按钮按Alt点击或鼠标中键点击，就是召回图腾，所以默认隐藏召回按钮了。`网易有爱在原版基础上进行了较彻底的中文化，增加了预设方案、修复了若干BUG，并增加了保留默认载具界面的功能，敬请试用。",

    runBeforeLoad = function(info, name)
        -- hooksecurefunc(Dominos, "ShowOptions", function() InterfaceOptionsFrame:Hide() UUI():Show() U1SelectAddon("dominos") end)
        Dominos.ShowOptions = function()
            local _ = InterfaceOptionsFrame:IsShown() and InterfaceOptionsFrame:Hide()
            UUI.OpenToAddon('dominos', true)
        end

        --对DebuffCaster的支持
        Dominos.ActionButton.oriCreate = Dominos.ActionButton.Create;
        function Dominos.ActionButton:Create(id)
            local b = self:oriCreate(id)
            if b and b.cooldown then b.cooldown.DCFlag=nil end
            return b;
        end

        --配置界面的鼠标提示
        CoreOnEvent("ADDON_LOADED", function(event, name)
            if name=="Dominos_Config" then
                local L = LibStub('AceLocale-3.0'):GetLocale('Dominos-Config');
                CoreUIEnableTooltip(_G["DominosProfiles"..L.Set], L.Set, "选择并应用所选方案的设置");
                CoreUIEnableTooltip(_G["DominosProfiles"..L.Save], L.Save, "创建一个新的方案，并将当前设置复制到其中，然后选择其为当前方案。");
                CoreUIEnableTooltip(_G["DominosProfiles"..L.Copy], L.Copy, "复制所选方案的设置到当前方案，注意当前方案的设置将无法恢复!");
                return 1;
            end
        end)

    end,

    --toggle = function(name, info, enable, justload) end, --如果未开插件，则初始不会调用。

    {
        type = 'radio',
        var = 'prestyle',
        default = 'MINI',
        options = {'三行紧凑型', 'MINI', '暴雪布局型', 'NORM'},
        text = '选择预设配置方案',
        secure = 1,
        confirm = "注意：当前的动作条设置将重置并无法恢复，您是否确定？",
        tip = "说明`网易有爱预设了几套动作条布局方案，可以选择后自行微调。",
        callback = function(cfg, v, loading)
            if(loading) then return end
            Dominos:Unload()
            Dominos.db:ResetProfile()
            -- insert out diff
            Dominos:U1_InitPreset(true)
            Dominos.isNewProfile = nil
            Dominos:Load()
        end
    },

    {
        type = 'radio',
        var = 'showbutton',
        default = 'STOR',
        options = {'显示商城按钮', 'STOR', '显示帮助按钮', 'HELP'},
        text = '选择商店按钮和帮助按钮',
        secure = 1,
        confirm = "注意：请重载界面来显示相应按钮",
        tip = "说明`网易有爱默认显示商店按钮，可以在此修改显示设置。",
        callback = function(cfg, v, loading)
            if(loading) then return end
			Dominos.db.profile['showButton'] = v
        end
    },

    {
        text = "设置按钮皮肤",
        tip = "说明`打开按钮美化插件的设置面板。",
        callback = function() UUI.OpenToAddon("masque") end,
		--callback = function() SlashCmdList["MASQUE"]() end,

    },

    {
        var = 'overrideui',
        default = true,
        text = '保留默认载具界面',
        tip = '说明`开启此选项后会使用暴雪默认的载具界面，如果不开启，则会使用动作条1来显示载具操作按钮。',
        getvalue = function() return Dominos:UsingOverrideUI() end,
        callback = function(_, v)
            return Dominos:SetUseOverrideUI(v)
        end,
    },

    {
        var = 'showgrid',
        text = '显示空按钮',
        default = false,
        getvalue = function() return Dominos:ShowGrid() end,
        callback = function(_, v) return Dominos:SetShowGrid(v) end,
    },

    {
        var = 'showbind',
        text = '显示绑定热键',
        default = true,
        getvalue = function() return Dominos:ShowBindingText() end,
        callback = function(_, v) return Dominos:SetShowBindingText(v) end,
    },

    {
        var = 'showmacro',
        text = '显示宏名字',
        default = true,
        getvalue = function() return Dominos:ShowMacroText() end,
        callback = function(_,v) return Dominos:SetShowMacroText(v) end,
    },

    {
        var = 'showtip',
        text = '显示鼠标提示',
        default = true,
        getvalue = function() return Dominos:ShowTooltips() end,
        callback = function(_,v) return Dominos:SetShowTooltips(v) end
    },

    {
        var = 'tipcombat',
        text = '战斗中显示鼠标提示',
        default = true,
        getvalue = function() return Dominos.db.profile.showTooltipsCombat end,
        callback = function(_,v) return Dominos:SetShowCombatTooltips(v) end,
    },

    {
        type = 'button',
        text = '进入布局模式',
        tip = "说明`进入布局设置模式，点击小地图旁边的多米诺按钮也可以进入。",
        callback = function() Dominos:ToggleLockedFrames() end,
    },

    {
        type = 'button',
        text = '按键绑定模式',
        tip = "说明`进入按键绑定模式，可以快速的给动作条设置绑定热键。",
        callback = function() Dominos:ToggleBindingMode() end,
    },

    {
        type = 'button',
        text = '配置方案管理',
        tip = "说明`选择不同的配置方案，可以常换常新，建议查看下操作按钮的说明。",
        callback = function()
            if(not IsAddOnLoaded'Dominos_Config') then
                LoadAddOn'Dominos_Config'
            end
            if(_G['DominosProfiles']) then
                InterfaceOptionsFrame_OpenToCategory(_G['DominosProfiles'])
            end
        end,
    },

});

U1RegisterAddon("Dominos_Config", { title = "配置界面模块", protected = 1, hide = 1, });
U1RegisterAddon("Dominos_Cast", {title = "施法条模块", load="LOGIN", desc = "令系统默认施法条可以移动和配置的多米诺模块。网易有爱叶子修改。", protected = nil, hide = nil, });
U1RegisterAddon("Dominos_Roll", {title = "掷点界面模块", load="LOGIN", desc = "让装备等待Roll点决定归属时的各个框体可以移动的多米诺模块。", protected = nil, hide = nil, });
U1RegisterAddon("Dominos_Encounter", {title = "触发模块", load="LOGIN", desc = "移动玩家能量槽的多米诺模块", protected = nil, hide = nil, });
U1RegisterAddon("Dominos_XP", {title = "经验条模块", desc = "一个可移动的经验条/声望条模块，右键点击可以切换经验/声望。", protected = nil, hide = nil, });
