U1RegisterAddon("TradeskillInfo", {
    title = "商业技能百科",
    defaultEnable = 0,
    deps = {"libbabble-3.0"},
    --load = "LOGIN",
    --minimap = "",

    tags = { TAG_TRADING, TAG_BIG, },
    icon = [[Interface\Icons\INV_Elemental_Mote_Nether]],
    desc = "完整的商业技能库，运行/tsi命令打开界面。可以显示所有已学和未学的商业技能配方，提供学习方法、配方出售处、冲技能时可以提升的颜色范围。有较为全面的搜索功能。`同时还可以在物品的鼠标提示中显示哪些配方需要此物品，甚至显示拍卖的价格。`内存占用较高，请在需要时启用。配置命令为/tsi config。",

    -------- Options --------
    {
        text = "显示快捷按钮",
        var = "showbutton",
        alwaysEnable = 1,
        default = 1,
        tip = "说明`是否在技能面板右上角显示加载按钮。",
        callback = function(cfg, v, loading) if TradeskillInfoLaunchButton then CoreUIShowOrHide(TradeskillInfoLaunchButton, v) end end,
    },
    {
        text = "开启商业技能百科",
        tip = "快捷命令`/tsi",
        callback = function(cfg, v, loading) SlashCmdList["ACECONSOLE_TSI"]("") end,
    },
    {
        text = "配置选项",
        tip = "快捷命令`/tsi config",
        callback = function(cfg, v, loading) SlashCmdList["ACECONSOLE_TSI"]("config") end,
    },
    --]]
});

U1RegisterAddon("TradeskillInfoUI", {title = "TradeskillInfoUI", protected = 1, hide = 1, });


if(not GetBuildInfo) then return end

CoreOnEvent('TRADE_SKILL_SHOW', function()
    if not TradeskillInfoLaunchButton then
        local btn = TplPanelButton(TradeSkillFrame, "TradeskillInfoLaunchButton"):SetText("百科查询"):AutoWidth():BR(TradeSkillFrameCloseButton, "TR", -3, -5):un()
        btn:RegisterForClicks("AnyUp");
        local _addon = 'TradeskillInfo'
        CoreHookScript(btn, 'OnClick', function(self, button)
            if button=="RightButton" then
                UUI.OpenToAddon("TradeskillInfo", true)
                return
            end
            if(not IsAddOnLoaded(_addon)) then
                U1LoadAddOn(_addon)
            end
            if TradeskillInfo then
                TradeskillInfo:UI_Toggle()
                if TradeSkillFrame:IsVisible() and TradeSkillFrame.selectedSkill then
                    TradeskillInfo:TradeSkillFrame_SetSelection(TradeSkillFrame.selectedSkill)
                end
            end
        end)

        CoreUIEnableTooltip(btn, '商业技能百科', '即时加载商业技能百科插件，可以看到技能变绿的级别等。（右键点击可设置隐藏此按钮）')
    end

    CoreUIShowOrHide(TradeskillInfoLaunchButton, U1GetCfgValue("tradeskillinfo", "showbutton"));
end)



