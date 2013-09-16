U1RegisterAddon("EnhancedTradeSkillUI", {
    title = "专业面板增强",
    defaultEnable = 1,

    tags = { TAG_TRADING },
    icon = [[Interface\Icons\Ability_Racial_BetterLivingThroughChemistry]],
    desc = "修改专业技能面板显示的技能行数。",

    modifier = "|cffcd1a1c[网易]|r",

    -------- Options --------
    {
        var = "skills",
        default = 16,
        text = "专业面板技能行数",
        type = "radio",
        options = {"8", 8, "12", 12, "16", 16, "20", 20, "24", 24},
        cols = 5,
        callback = function(cfg, v, loading)
            EnhancedTradeSkillUI_Options.ShownSkills = v;
            EnhancedTradeSkillUI:Resize(v, EnhancedTradeSkillUI_Options.scale)
            if not loading then
                if not IsAddOnLoaded("Blizzard_TradeSkillUI") then TradeSkillFrame_LoadUI(); end
                TradeSkillFrame:Show();
            end
        end,
    },
    --]]
});
