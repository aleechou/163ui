local L =  LibStub("AceLocale-3.0"):GetLocale("PetJournalEnhanced")
local Config = PetJournalEnhanced:NewModule("Config")

function Config:OnInitialize()
	self.callbacks = LibStub("CallbackHandler-1.0"):New(self)
	
	local defaults = {
		global = {
			display = {
				uniquePetCount = true,
				coloredNames = true,
				coloredBorders = true,
				maxStatIcon = true,
				breedInfo = false,
				Extrapolate = true,
			},
		}
	}
	self.db = LibStub("AceDB-3.0"):New("PetJournalEnhancedDB", defaults, true)
	--self.db.global.filtering.unknownZone = true --always reset to true
	self.display = self.db.global.display
	
	local db = self.db.global.display
	local options = {
		name = "PetJournal Enhanced",
		handler = self,
		type = 'group',
		args = {
			showPetCount = {
				order = 1,
				name = L["Show unique pet count"],
				type = "toggle",
				width = "double",
				set = function(info,val) 
					db.uniquePetCount = val 
					self.callbacks:Fire("PETJOURNAL_ENHANCED_OPTIONS_UPDATE")
				end,
				get = function(info) return db.uniquePetCount or false end
			},
			showMaxStat = {
				order = 2,
				name = L["Show pets specialization"],
				type = "toggle",
				width = "double",
				set = function(info,val) 
					db.maxStatIcon = val 
					self.callbacks:Fire("PETJOURNAL_ENHANCED_OPTIONS_UPDATE")
				end,
				get = function(info) return db.maxStatIcon or false end
			},
			colorBorders = {
				order = 3,
				name = L["Color pet borders"],
				type = "toggle",
				width = "double",
				set = function(info,val) 
					db.coloredBorders = val 
					self.callbacks:Fire("PETJOURNAL_ENHANCED_OPTIONS_UPDATE")
				end,
				get = function(info) return db.coloredBorders or false end
			},
			colorName = {
				order = 4,
				name = L["Color pet names"],
				type = "toggle",
				width = "double",
				set = function(info,val) 
					db.coloredNames = val 
					self.callbacks:Fire("PETJOURNAL_ENHANCED_OPTIONS_UPDATE")
				end,
				get = function(info) return db.coloredNames or false end
			},
			breedInfo = {
				order = 5,
				name = L["Display pet breed"],
				type = "toggle",
				width = "double",
				set = function(info,val) 
					db.breedInfo = val 
					self.callbacks:Fire("PETJOURNAL_ENHANCED_OPTIONS_UPDATE")
				end,
				get = function(info) return db.breedInfo or false end
			},
			level25Stats = {
				order = 5,
				name = L["Display predicted pet stats"],
				type = "toggle",
				width = "double",
				set = function(info,val) 
					db.Extrapolate = val 
					self.callbacks:Fire("PETJOURNAL_ENHANCED_OPTIONS_UPDATE")
				end,
				get = function(info) return db.Extrapolate or false end
			},
		},
	}
	LibStub("AceConfig-3.0"):RegisterOptionsTable("PetJournalEnhanced", options)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PetJournalEnhanced","PetJournal Enhanced")
end





