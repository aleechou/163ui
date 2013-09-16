U1RegisterAddon("WarbabyTradeLink", {
    title = "专业技能链接",
    defaultEnable = 1,

    tags = { TAG_TRADING },
    icon = [[Interface\Icons\Achievement_Level_50]],
    desc = "    显示全部专业技能的链接，都是全满的，可供随时查看。` `    采用高科技手段欺骗服务器，占用资源极小。` `    此外还有技能面板增强的功能。",

    author = "|cffcd1a1c[网易原创]|r",

    -------- Options --------
    {
        text = "在聊天窗打印链接",
        callback = function() SlashCmdList["WARBABY_TRADE_LINK"]("") end,
    },
    {
        text = "显示下拉菜单列表",
        callback = function(cfg) ToggleDropDownMenu(1, nil, WarbabyTradeLinkDropdown, cfg._ctl, 0, 0) end,
    },
    --[[--会导致游戏崩溃
    {
        type = "custom",
        text = "",
        place = function(parent, cfg, last)
            if not cfg.f then
                cfg.f =  WW:ScrollingMessageFrame("WarbabyTradeLinkCfg"):CreateTexture():SetTexture(0,0,0,0.5):ALL():up():un();
                cfg.f.CtlSetEnabled = function(self, enable) if enable then self:Show() else self:Hide() end end
                cfg.f:SetScript("OnHyperlinkClick", function(...) ChatFrame_OnHyperlinkShow(...) end);
                cfg.f:SetTimeVisible(2147483648);
                cfg.f:SetJustifyH("LEFT");
                cfg.f:SetFontObject(ChatFontNormal);
                cfg.f:SetHyperlinksEnabled(true);
            end
            cfg.f:SetParent(parent);
            CtlRegularAnchor(cfg.f, parent, cfg, last);
            cfg.f:SetSize(parent:GetWidth()-CtlGetLeftPadding(cfg.f)*2, 15);
            cfg.f:Clear();
            local count, lines = 0, 1;
            local all = "";
            for k,v in pairs(WarbabyTradeLinkData or {}) do
                local uid = ONE_GUID or UnitGUID("player")
                all = all..(" |c"..v.color.."|Htrade:"..v.id..":"..(skillLevel or WB_MAX_SKILL_LEVEL)..":"..WB_MAX_SKILL_LEVEL..":"..uid..":"..strrep("/", v.len).."|h["..v.name.."]|h|r");
                count = (count + 1) % 3;
                if count == 0 then
                    cfg.f:AddMessage(all);
                    all = "";
                    lines = lines + 1;
                end
            end
            if all == "" then lines = lines - 1 else cfg.f:AddMessage(all) end
            cfg.f:SetHeight(15*max(1,lines));
            return cfg.f;
        end,
    },
    --]]
});
