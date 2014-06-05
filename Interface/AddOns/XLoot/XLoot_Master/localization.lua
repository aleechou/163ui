-- See: http://wow.curseforge.com/addons/xloot/localization/ to create or fix translations
local locales = {
	enUS = {
		ML_RANDOM = "Raid Roll",
		ML_SELF = "Self Loot",
		ML_BANKER = "Banker",
		ML_DISENCHANTER = "Disenchanter",
		RECIPIENTS = "Special Recipients",
		SPECIALROLLS = "Special Rolls",
		BINDING_BANKER = "Set Banker",
		BINDING_DISENCHANTER = "Set Disenchanter",
		ITEM_AWARDED = "%s awarded: %s",
	},
	-- Possibly localized
	ptBR = {

	},
	frFR = {

	},
	deDE = {

	},
	koKR = {

	},
	esMX = {

	},
	ruRU = {

	},
	zhCN = {

	},
	esES = {

	},
	zhTW = {

	},
}

-- Automatically inserted translations


locales.deDE["BINDING_BANKER"] = "Setze Bankier" -- Needs review
locales.deDE["BINDING_DISENCHANTER"] = "Setze Entzauberer" -- Needs review
locales.deDE["ITEM_AWARDED"] = "%s ausgezeichnet: %s" -- Needs review
locales.deDE["ML_BANKER"] = "Bankier" -- Needs review
locales.deDE["ML_DISENCHANTER"] = "Entzauberer" -- Needs review
locales.deDE["ML_RANDOM"] = "Schlachtzugs Wurf" -- Needs review
locales.deDE["ML_SELF"] = "Eigenständiges plündern" -- Needs review
locales.deDE["RECIPIENTS"] = "Spezieller Empfänger" -- Needs review
locales.deDE["SPECIALROLLS"] = "Spezielle Würfe" -- Needs review

locales.koKR["ITEM_AWARDED"] = "%s 아이템을 획득했습니다: %s" -- Needs review


locales.ruRU["BINDING_BANKER"] = "Назначить банкира"
locales.ruRU["BINDING_DISENCHANTER"] = "Назначить дизенчантера"
locales.ruRU["ITEM_AWARDED"] = "%s получает: %s"
locales.ruRU["ML_BANKER"] = "Банкир"
locales.ruRU["ML_DISENCHANTER"] = "Дизенчантер"
locales.ruRU["ML_RANDOM"] = "Raid Roll"
locales.ruRU["ML_SELF"] = "Своя добыча" -- Needs review
locales.ruRU["RECIPIENTS"] = "Особые получатели" -- Needs review
locales.ruRU["SPECIALROLLS"] = "Особые броски" -- Needs review

locales.zhCN["BINDING_BANKER"] = "设置银行存放者"
locales.zhCN["BINDING_DISENCHANTER"] = "设置附魔分解者"
locales.zhCN["ITEM_AWARDED"] = "%s 获得了： %s"
locales.zhCN["ML_BANKER"] = "分配给银行存放者"
locales.zhCN["ML_DISENCHANTER"] = "分配给附魔分解者"
locales.zhCN["ML_RANDOM"] = "随机分配"
locales.zhCN["ML_SELF"] = "分配给自己"
locales.zhCN["RECIPIENTS"] = "指定分配"
locales.zhCN["SPECIALROLLS"] = "特殊分配"


locales.zhTW["BINDING_BANKER"] = "設定存放銀行者"
locales.zhTW["BINDING_DISENCHANTER"] = "設定附魔分解者"
locales.zhTW["ITEM_AWARDED"] = "%s 給與: %s"
locales.zhTW["ML_BANKER"] = "銀行存放者"
locales.zhTW["ML_DISENCHANTER"] = "附魔分解者"
locales.zhTW["ML_RANDOM"] = "團隊擲骰"
locales.zhTW["ML_SELF"] = "自己拾取"
locales.zhTW["RECIPIENTS"] = "特殊接受者"
locales.zhTW["SPECIALROLLS"] = "特殊擲骰"


XLoot:Localize("Master", locales)
