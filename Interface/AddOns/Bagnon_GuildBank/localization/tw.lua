--[[
	Bagnon Guild Bank Localization: Chinese Traditional by 米利亞爾特 雷鱗TW
--]]


local L = LibStub('AceLocale-3.0'):NewLocale('Bagnon-GuildBank', 'zhTW')
if not L then return end

L.Title = [[%s的公會銀行]]
L.Log1 = '記錄'
L.Log3 = '訊息'
L.TipFunds = '公會資金'
L.TipDeposit = '<左鍵點擊> 存款'
L.TipWithdrawRemaining = '<右鍵點擊> 提取(%s 今日餘額)'
L.TipWithdraw = '<右鍵點擊> 提取'

-- Automatically localized - do not translate!
L.Log2 = GUILD_BANK_MONEY_LOG