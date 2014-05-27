function TargetButton_Redraw(self)
    if not InCombatLockdown() then
        TargetButtonsFrame_InspectButton:SetPoint("CENTER", "TargetFrame", "TOPLEFT", 113, -13);  -- euf 113, -16 other 103, -15
    end
    TargetButtonsFrame_FollowButton:SetPoint("RIGHT", "$parent_InspectButton", "LEFT", 1, 0);
    TargetButtonsFrame_TradeButton:SetPoint("RIGHT", "$parent_FollowButton", "LEFT", 1, 0);  -- euf 92, -16 other 82, -15
    if(UnitIsFriend("player","target") and UnitIsPlayer("target") and not UnitIsUnit("player","target")) then
        TargetButtonsFrame_TradeButton:Show();
        if not InCombatLockdown() then
            TargetButtonsFrame_InspectButton:Show();
        end
        TargetButtonsFrame_FollowButton:Show();
    else
        TargetButtonsFrame_FollowButton:Hide();
        TargetButtonsFrame_TradeButton:Hide();
        if not InCombatLockdown() then
            TargetButtonsFrame_InspectButton:Hide();
        end
    end
end

local timer = 0
function TargetButton_CheckRange(self, elapsed)
    timer = timer + elapsed
    if timer >= 0.2 then
        timer = 0
        if CheckInteractDistance("target",1) then
            if not InCombatLockdown() then
                TargetButtonsFrame_InspectButton:Enable();
            end
            TargetButtonsFrame_FollowButton:Enable();
        else
            if not InCombatLockdown() then
                TargetButtonsFrame_InspectButton:Disable();
            end
            TargetButtonsFrame_FollowButton:Disable();
        end
        if CheckInteractDistance("target",2) then
            TargetButtonsFrame_TradeButton:Enable();
            if ( UnitIsDeadOrGhost("player") or UnitIsDeadOrGhost("target") ) then
                TargetButtonsFrame_TradeButton:Disable();
            end
        else
            TargetButtonsFrame_TradeButton:Disable();
        end
    end
end

function Trade_onClick(self)
    InitiateTrade("target");
end

function Inspect_OnLoad(self)
    self:SetAttribute("type*", "macro")
    self:SetAttribute("macrotext", "/inspect")
    self:RegisterEvent("PLAYER_REGEN_DISABLED");
    self:RegisterEvent("PLAYER_REGEN_ENABLED");
    self:SetScript("OnEvent", function(self, event) 
        if event == "PLAYER_REGEN_DISABLED" then 
            TargetButtonsFrame_InspectButton:Hide() 
        else
            TargetButton_Redraw() 
            TargetButton_CheckRange(nil, 1) 
        end
    end)

    --InspectUnit("target");
end
