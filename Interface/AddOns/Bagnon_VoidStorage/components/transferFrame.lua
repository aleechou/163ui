--[[
	transferFrame.lua
		Overview frame of void storage transfers
--]]

local L = LibStub('AceLocale-3.0'):GetLocale('Bagnon-VoidStorage')
local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local TransferFrame = Bagnon:NewClass('TransferFrame', 'Frame')

function TransferFrame:New(frameID, parent)
	local f = self:Bind(CreateFrame('Frame', nil, parent))
	f.frameID = frameID
	
	local deposit = f:NewSection(DEPOSIT)
	deposit:SetPoint('TOPLEFT', 10, -20)
	
	local withdraw = f:NewSection(WITHDRAW)
	withdraw:SetPoint('TOPLEFT', deposit, 'BOTTOMLEFT', 0, -20)
	
	return f
end

function TransferFrame:NewSection(title)
	local frame = Bagnon.VaultItemFrame:New(self.frameID, self, title)
	frame.title:SetText(title)
	frame.COLUMN_OFF = 1
	return frame
end