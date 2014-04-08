--[[
	dialogs.lua
		Static dialog popups for the void storage window
--]]

local L = LibStub('AceLocale-3.0'):GetLocale('Bagnon-VoidStorage')
local Bagnon = LibStub('AceAddon-3.0'):GetAddon('Bagnon')
Bagnon.VAULT_COST = 100 * 100 * 100

StaticPopupDialogs['BAGNON_VAULT_PURCHASE'] = {
	text = format(L.PurchaseDialog, GetCoinTextureString(Bagnon.VAULT_COST)),
	button1 = UNLOCK,
	button2 = NO,
	
	OnAccept = function(self)
		PlaySound('UI_Voidstorage_Unlock')
		UnlockVoidStorage()
	end,
	
	OnCancel = CloseVoidStorageFrame,
	timeout = 0, preferredIndex = STATICPOPUP_NUMDIALOGS,
	hideOnEscape = 1
}

StaticPopupDialogs['BAGNON_CANNOT_PURCHASE_VAULT'] = {
	text = format(L.CannotPurchaseDialog, GetCoinTextureString(Bagnon.VAULT_COST)),
	button1 = CHAT_LEAVE,
	button2 = L.AskMafia,
	
	OnAccept = CloseVoidStorageFrame,
	OnCancel = CloseVoidStorageFrame,
	timeout = 0, preferredIndex = STATICPOPUP_NUMDIALOGS,
	hideOnEscape = 1
}

StaticPopupDialogs['BAGNON_COMFIRM_TRANSFER'] = {
	text = L.ConfirmTransfer,
	button1 = YES,
	button2 = NO,
	
	OnAccept = function(dialog, frame)
		ExecuteVoidTransfer()
		frame:SendMessage('SHOW_ITEM_FRAME')
	end,
	
	OnCancel = function(dialog, frame)
		frame:SendMessage('SHOW_ITEM_FRAME')
	end,
	
	timeout = 0, preferredIndex = STATICPOPUP_NUMDIALOGS,
	hideOnEscape = 1
}