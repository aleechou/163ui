
local tCD = tdCooldown2;

tCD:SetAddOn("LoseControl", function()
    --old version
    --if _G.LoseControlFrame then
    --    local l = _G.LoseControlFrame;
    --    l.button = CreateFrame("Frame");
    --    l.button:SetAllPoints(l);
    --    l.button:SetFrameStrata("LOW");
    --    l.type = "ACTION";
    --    l:SetParent(l.button);
    --end

    if _G.LoseControlDB and _G.LoseControlDB.frames then
        for k in pairs(_G.LoseControlDB.frames) do
            local l = _G["LoseControl"..k]
            if l then
                local parent = CreateFrame("Frame", nil)
                l.button = parent;
                parent.icon = l.texture
            	l.type = "ACTION";
            end
        end
    end
end)