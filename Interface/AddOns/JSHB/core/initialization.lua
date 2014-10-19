--
-- JSHB AddOn by JS
--

JSHB 				= LibStub("AceAddon-3.0"):NewAddon("JSHB", "AceEvent-3.0")
JSHB.F 				= {}
JSHB.Localization 	= {}
JSHB.L 				= setmetatable( JSHB.Localization, { __newindex = function(self, key, value) rawset(self, key, (value == true) and key or value) end })
