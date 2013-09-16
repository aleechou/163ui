--[[------------------------------------------------------------
默认银行界面打开全部银行背包
---------------------------------------------------------------]]
CoreOnEvent("BANKFRAME_OPENED", function()
    if BankFrame:IsVisible() then
        for i = NUM_BAG_SLOTS+1, (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) do
            OpenBag(i)
        end
    end
end)