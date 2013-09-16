U1RegisterAddon("tdCooldown2", {
    title = "技能冷却",
    defaultEnable  = 1,
    -- load = "LOGIN", --LATER会导致屏幕大闪

    tags = {TAG_COMBATINFO,},
    icon = [[Interface\Icons\INV_Qiraj_JewelGlyphed]],
    modifier = "多玩魔盒",
    desc = "给所有的技能冷却动画添加文字显示及冷却后的效果，同时可以将超出范围的技能图标设置为暗红色。",

    toggle = function(name, info, enable, justload)
        CoreCall("tdCooldownUpdateCooldowns");
        return true
    end,

    ------- Options --------
    {
        type="checkbox",
        var = "redout",
        default = 1,
        text="超出技能范围图标显示为红色",
        callback = function(cfg, v, loading) tdCooldown2:SetCurVal("redout", nil, v) end,
    },
    {
        type="checkbox",
        var = "flash",
        default = 1,
        text="显示动作条上的技能冷却数字",
        callback = function(cfg, v, loading) tdCooldown2:SetCurVal("ACTION", "config", v) end,
        {
            text = '动作条计时文字大小',
            var = 'textSize',
            type = 'spin',
            range = {10, 60, 1},
            default = 24,
            callback = function(cfg, v, loading)
                tdCooldown2:SetCurVal('ACTION', 'size', v)
            end,
        },
    },
    {
        type="checkbox",
        var = "buff",
        default = 1,
        text="显示状态图标的计时数字",
        tip = "说明`目标头像下的状态图标的数字",
        callback = function(cfg, v, loading) tdCooldown2:SetCurVal("BUFF", "config", v) end,
        {
            type="checkbox",
            var = "hidecd",
            default = false,
            text="隐藏系统冷却动画",
            tip="说明`显示冷却倒计时文字后，可以选择隐藏系统的冷却转圈动画。",
            callback = function(cfg, v, loading)
                tdCooldown2:SetCurVal("BUFF", "hidecooldown", v)
                tdCooldown2:SetCurVal("ACTION", "hidecooldown", v)
            end,
        },
        {
            type="checkbox",
            var = "mine",
            default = 1,
            text="只显示自己施放的",
            callback = function(cfg, v, loading) tdCooldown2:SetCurVal("mine", nil, v) end,
        },
        {
            type="checkbox",
            var = "compactRaid",
            default = 1,
            text="忽略暴雪团队框架",
            tip="说明`暴雪的团队框架的状态图标实在太小了, 默认关闭显示计时, 如果有特殊需要, 请修改此选项",
            reload = 1,
            callback = function(cfg, v, loading) tdCooldown2:SetCurVal("ignoreCompactRaid", nil, v) end,
        },
        {
            type = "custom",
            text = "",
            place = function(parent, cfg, last)
                if not cfg.f then
                    local f = WW:Frame():Size(1,1)
                    local text = f:CreateFontString():SetFontObject(CtlFontNormalSmall):SetText(cfg.text):LEFT(CTL_INDENT, -10)
                    local buff1 = f:Frame("TdCooldownTestBuff", "TargetofTargetDebuffFrameTemplate"):LEFT(text, "R", 88, 0):Size(21,21):Show():un()
                    buff1:SetScript("OnEnter", nil)
                    local buff2 = f:Frame("TdCooldownTestBuff2", "TargetofTargetDebuffFrameTemplate"):LEFT(buff1, "R", 10, 0):Size(12,12):Show():un()
                    buff2:SetScript("OnEnter", nil)
                    TdCooldownTestBuffIcon:SetTexture("Interface\\Icons\\Achievement_Reputation_KirinTor")
                    TdCooldownTestBuff2Icon:SetTexture("Interface\\Icons\\Achievement_Reputation_KirinTor")
                    f.CtlSetEnabled = CoreUIShowOrHide
                    cfg.f = f:un()
                end
                CtlCustomPlace(cfg.f, parent, cfg, last)
                TdCooldownTestBuffCooldown:SetCooldown(GetTime(), 60)
                TdCooldownTestBuff2Cooldown:SetCooldown(GetTime(), 60)
                return cfg.f
            end
        },
        {
            text = '文字大小',
            var = 'textSize',
            type = 'spin',
            range = {10, 60, 1},
            default = 30,
            callback = function(cfg, v, loading)
                tdCooldown2:SetCurVal('BUFF', 'size', v)
                if TdCooldownTestBuff and TdCooldownTestBuff:IsVisible() then
                    TdCooldownTestBuffCooldown:SetCooldown(GetTime(), 12)
                    TdCooldownTestBuff2Cooldown:SetCooldown(GetTime(), 12)
                end
            end,
        },
        {
            text = "横向偏移量",
            var = "buffx",
            type = "spin",
            range = {-30, 30, 1},
            default = -2,
            callback = function(cfg, v, loading)
                tdCooldown2:SetCurVal("BUFF", "x", v)
                if TdCooldownTestBuff and TdCooldownTestBuff:IsVisible() then
                    TdCooldownTestBuffCooldown:SetCooldown(GetTime(), 12)
                    TdCooldownTestBuff2Cooldown:SetCooldown(GetTime(), 12)
                end
            end,
        },
        {
            text = "纵向偏移量",
            var = "buffy",
            type = "spin",
            range = {-30, 30, 1},
            default = 2,
            callback = function(cfg, v, loading)
                tdCooldown2:SetCurVal("BUFF", "y", v)
                if TdCooldownTestBuff and TdCooldownTestBuff:IsVisible() then
                    TdCooldownTestBuffCooldown:SetCooldown(GetTime(), 12)
                    TdCooldownTestBuff2Cooldown:SetCooldown(GetTime(), 12)
                end
            end,
        },
    },
    {
        var = "shine",
        type = "radio",
        text = "选择冷却完毕的闪光动画：",
        tip = "说明`选择'仅默认'则只播放暴雪自带的小闪光动画，没有额外占用，适合性能较差的机器。",
        default = 0,
        options = {"仅默认动画", -1, "图标", 0, "小闪光", 1, "雷达", 2, "大闪光", 3, },
        indent = 1,
        cols = 2,
        callback = function(cfg, v, loading) tdCooldown2:SetShineType(v); if TdCooldownTestAction and TdCooldownTestAction:IsVisible() then TdCooldownTestActionCooldown:SetCooldown(GetTime()-4, 4) end end,
        {
            type = "custom",
            text = "",
            place = function(parent, cfg, last)
                if not cfg.f then
                    local f = WW:Frame():Size(1,1)
                    local text = f:CreateFontString():SetFontObject(CtlFontNormalSmall):SetText(cfg.text):LEFT(0, 0)
                    f:Frame("TdCooldownTestAction", "ActionButtonTemplate"):Key("action"):CENTER(-13, 25):Size(28,28):Show():un()
                    f.action.icon:SetTexture("Interface\\Icons\\Ability_UpgradeMoonGlaive")
                    f.CtlSetEnabled = CoreUIShowOrHide
                    cfg.f = f:un()
                end
                CtlCustomPlace(cfg.f, parent, cfg, last)
                TdCooldownTestActionCooldown:SetCooldown(GetTime(), 60)
                return cfg.f
            end
        },
    },
    {
        var = "center",
        text="显示中心冷却图标",
        tip = "说明`技能冷却结束后在屏幕中央显示一个大图标",
        default = nil,
        callback = function(cfg, v, loading) tdCooldown2:SetCurVal("center", "config", not not v); tdCooldown2:ToggleCenter(not not v) end,
        {
            text = "调整图标位置",
            callback = function(cfg, v, loading) tdCooldown2:ShowCenterPos(); end,
        },
        {
            var = "size",
            text = "图标大小",
            default = 100,
            type = "spin",
            range = {20, 200, 10},
            callback = function(cfg, v, loading)
                tdCooldown2:SetCurVal("center", "width", v);
                if not loading then tdCooldown2:Demo() end
            end,
        },
        {
            var = "text",
            text = "下方显示技能名称",
            default = 1,
            callback = function(cfg, v, loading) tdCooldown2:SetCurVal("center", "text", not not v); end,
            {
                var = "textsize",
                text = "文字大小",
                default = 30,
                type = "spin",
                range = {9, 30, 1},
                callback = function(cfg, v, loading)
                    tdCooldown2:SetCurVal("center", "size", v);
                    if not loading then tdCooldown2:Demo() end
                end,
            },
        },
    },
    -- {
    --     type="checkbox",
    --     var = "coolline",
    --     text="显示线性技能冷却条",
    --     default = 1,
    --     callback = function(cfg, v, loading) CoolLine_Toggle(v) end,
    --     {
    --         type="checkbox",
    --         var = "lock",
    --         text = "锁定线性冷却条位置",
    --         tip = "说明`锁定/解锁屏幕下方的线性技能冷却条，除可以移动外，还可以拖动右下的红色方块调整大小。",
    --         default = false,
    --         callback = function(cfg, v, loading) CoolLine_ToggleLock(v) end,
    --     },
    -- },
});
