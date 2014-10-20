------------------------------------------------------------
-- Supports.lua
--
-- Abin
-- 2014/10/17
------------------------------------------------------------

local _, addon = ...

-- API for adding third-party editbox supports:

-- addon:AddSupport("editbox", isTradeSkill, OnCommand)

addon:AddSupport("BuyName") -- AuctionLite
addon:AddSupport("Atr_Search_Box") -- Auctionator
addon:AddSupport("SkilletFilterBox", 1) -- Skillet