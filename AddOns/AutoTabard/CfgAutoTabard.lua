U1RegisterAddon("AutoTabard", {
    title = "自动战袍切换",
    defaultEnable = 1,
    --optionsAfterVar = 1,
    --load = "LOGIN",

    tags = { TAG_MAPQUEST },
    icon = [[Interface\Icons\INV_Misc_Tabard_GuardiansofHyjal]],
    desc = "进入英雄副本自动换成预设声望的战袍，请通过配置选项打开设置界面，选择对应的声望，如果选择了最后的'先遣军'声望则暂停插件。",

    --author = "|cffcd1a1c[网易原创]|r",
    modifier = "阿奇巴德曙光(简体汉化)",

    --toggle = function(name, info, enable, justload) end,

    {
        text = "配置选项",
        callback = function(cfg, v, loading) SlashCmdList["AUTOTABARD"]() end,
    },
    --[[------ Options --------
    {
        var = "",
        default = "",
        text = "",
        callback = function(cfg, v, loading) end,
    },
    --]]
});

if not ReputationFrame then return end
--ReputationFrameFactionLabel:Hide()
--ReputationFrameStandingLabel:Hide()
local function create(parent)
    local btn = TplPanelButton(parent, parent:GetName().."AutoTabard", 20):SetText("自动战袍:未启用"):AutoWidth()
    :SetScript("OnShow", function(self) WW(self):SetText(format("自动战袍: |cffffffff%s|r",IsAddOnLoaded("AutoTabard") and (AutoTabard_DesiredFaction or "无") or "未启用")):AutoWidth():un() end)
    :SetScript("OnClick", function(self) if(IsAddOnLoaded("AutoTabard"))then CoreIOF_OTC(AutoTabard_panel) else U1LoadAddOn("AutoTabard") end WW(self):On("Show"):un() end)
    --:CreateFontString():RIGHT(btn, "L", 0, 0):SetFontObject(ChatFontSmall):SetText("未启用"):up()
    --:un()
    CoreDependCall("AutoTabard", function() hooksecurefunc("AutoTabard_Click", function() WW(_G[parent:GetName().."AutoTabard"]):On("Show"):un() end ) end)
    return btn
end
create(ReputationFrame):TR(-3,-21):un()
create(LFDParentFrame):TR(LFDParentFrame, "TR",-23,0):un()
