-- -------------------------------------------------------------------------- --
-- EnhancedTradeSkillUI DEFAULT (english) Localization                        --
-- Please make sure to save this file as UTF-8. ¶                             --
-- -------------------------------------------------------------------------- --

EnhancedTradeSkillUI_Locales = {

["EnhancedTradeSkillUI"] = true,
["Shows more recipies in the profession window."] = true,
["Shown Skills"] = true,
["Scale"] = true,
["WoW Default"] = true,
["Lock"] = true,
["Locks or unlocks the TradeSkillFrame for movement."] = true,
["Portrait Tooltip"] = true,
["Left-Click: Move"] = true,
["Right-Click: Options"] = true,

}

function EnhancedTradeSkillUI_Locales:CreateLocaleTable(t)
	for k,v in pairs(t) do
		self[k] = (v == true and k) or v
	end
end

EnhancedTradeSkillUI_Locales:CreateLocaleTable(EnhancedTradeSkillUI_Locales)