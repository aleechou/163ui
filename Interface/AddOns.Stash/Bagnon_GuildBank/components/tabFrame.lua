--[[
	tabFrame.lua
		A container object for tabs
--]]

local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
local TabFrame = Bagnon:NewClass('GuildTabFrame', 'Frame', Bagnon.BagFrame)
TabFrame.Button = Bagnon.GuildTab