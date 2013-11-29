-----------------------------------------------------------------------
-- Upvalued Lua API.
-----------------------------------------------------------------------
local _G = getfenv(0)

local pairs = _G.pairs

-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub

local Archy = LibStub("AceAddon-3.0"):GetAddon("Archy")
local L = LibStub("AceLocale-3.0"):GetLocale("Archy", false)
local LSM = LibStub("LibSharedMedia-3.0")

-----------------------------------------------------------------------
-- Constants.
-----------------------------------------------------------------------
local FRAME_ANCHOR_OPTIONS = {
	["TOPLEFT"] = L["Top Left"],
	["TOPRIGHT"] = L["Top Right"],
	["BOTTOMRIGHT"] = L["Bottom Right"],
	["BOTTOMLEFT"] = L["Bottom Left"],
}

local FONT_OUTLINES = {
	[""] = _G.NONE,
	["OUTLINE"] = L["Outline"],
	["THICKOUTLINE"] = L["Thick Outline"],
}

-----------------------------------------------------------------------
-- Config option functions.
-----------------------------------------------------------------------
local general_options

local function GetGeneralOptions()
	if not general_options then
		local LDBI = LibStub("LibDBIcon-1.0")
		local db = private.db

		general_options = {
			type = "group",
			order = 1,
			name = _G.GENERAL_LABEL,
			desc = L["General Options"],
			args = {
				desc = {
					order = 0,
					type = "description",
					name = "Archy",
				},
				show = {
					order = 1,
					name = L["Show Archy"],
					desc = L["Toggle the display of Archy"],
					type = "toggle",
					get = function()
						return db.general.show
					end,
					set = function(_, value)
						db.general.show = value
						Archy:ConfigUpdated()
					end,
				},
				reset = {
					order = 2,
					name = L["Reset Positions"],
					desc = L["Reset the window positions to defaults"],
					type = "execute",
					func = function()
						private:ResetPositions()
					end,
				},
				lock = {
					order = 3,
					name = L["Lock Positions"],
					desc = L["Locks the windows so they cannot be repositioned by accident"],
					type = "toggle",
					get = function()
						return db.general.locked
					end,
					set = function(_, value)
						db.general.locked = value
						Archy:ConfigUpdated()
					end,
					width = "double",
				},
				archyTheme = {
					order = 4,
					type = "select",
					name = L["Style"],
					desc = L["The style of display for Archy.  This will reload your UI after selecting"],
					get = function() return db.general.theme end,
					set = function(_, value)
						db.general.theme = value
						_G.ReloadUI()
					end,
					values = {
						["Graphical"] = L["Graphical"],
						["Minimal"] = L["Minimal"],
					},
				},				
				combathide = {
					order = 5,
					name = L["Auto Hide in Combat"],
					desc = L["Auto Hide Archy Frames in Combat"],
					type = "toggle",
					get = function() return db.general.combathide end,
					set = function(k, v)
						db.general.combathide = v
						if db.general.combathide then
							private.regen_update_visibility = true
						else
							private.regen_update_visibility = nil
						end
					end,
					width = "double"
				},				
				icon = {
					order = 6,
					name = L["Hide Minimap Button"],
					desc = L["Toggles the display of the Minimap Icon"],
					type = "toggle",
					get = function()
						return db.general.icon.hide
					end,
					set = function(k, v)
						db.general.icon.hide = v
						if db.general.icon.hide then
							LDBI:Hide("Archy")
						else
							LDBI:Show("Archy")
						end
					end,
					width = "double"
				},
				easyCast = {
					order = 7,
					name = L["Enable EasyCast"],
					desc = L["Double right-click on the screen to cast Survey.  This is experimental and may interfere with other addons with similar functionality when enabled."],
					type = "toggle",
					get = function() return db.general.easyCast end,
					set = function(_, value)
						db.general.easyCast = value
						Archy:ConfigUpdated()
					end,
					width = "full",
				},
				autoLoot = {
					order = 8,
					name = L["AutoLoot Fragments and Key Stones"],
					desc = L["Enable the addon to auto-loot fragments and key stones for you."],
					type = "toggle",
					get = function() return db.general.autoLoot end,
					set = function(_, value)
						db.general.autoLoot = value
						Archy:ConfigUpdated()
					end,
					width = "full",
				},
				manualTracking = {
					order = 9,
					name = L["Manual tracking"],
					desc = L["Archy will not automate dig site tracking on the minimap, world map and battlefield map."],
					type = "toggle",
					get = function() return db.general.manualTrack end,
					set = function(_, value)
						db.general.manualTrack = value
					end,
					width = "full",
				},
			},
		}
		general_options.args.output = Archy:GetSinkAce3OptionsDataTable()
		general_options.args.output.guiInline = true
		general_options.args.output.name = L["Announcements Output"]
	end
	return general_options
end

local artifact_options

local function GetArtifactOptions()
	if not artifact_options then
		local db = private.db

		artifact_options = {
			order = 2,
			type = "group",
			childGroups = "tab",
			name = L["Artifacts"],
			desc = L["Artifact Options"],
			args = {
				options = {
					name = _G.GENERAL_LABEL,
					order = 0,
					type = "group",
					args = {
						desc = {
							order = 0,
							type = "description",
							name = L["Control various aspects of the Artifact options"],
						},
						show = {
							order = 1,
							type = "toggle",
							name = _G.SHOW,
							desc = L["Toggles the display of the Artifacts list"],
							get = function() return db.artifact.show end,
							set = function(_, value)
								db.artifact.show = value
								Archy:ConfigUpdated('artifact')
							end,
						},
						filter = {
							order = 2,
							type = "toggle",
							name = L["Filter by Continent"],
							desc = L["Filter the Artifact list by races on the continent"],
							get = function() return db.artifact.filter end,
							set = function(_, value)
								db.artifact.filter = value
								Archy:ConfigUpdated('artifact')
							end,
							disabled = function() return not db.artifact.show end,
						},
						announce = {
							order = 3,
							type = "toggle",
							name = L["Announce when solvable"],
							desc = L["Announce in the chat window when an artifact can be solved with fragments"],
							get = function() return db.artifact.announce end,
							set = function(_, value)
								db.artifact.announce = value
								Archy:ConfigUpdated('artifact')
							end,
						},
						keystoneAnnounce = {
							order = 4,
							type = "toggle",
							name = L["Include key stones"],
							desc = L["Announce in the chat window when an artifact can be solved with fragments and key stones"],
							get = function() return db.artifact.keystoneAnnounce end,
							set = function(_, value)
								db.artifact.keystoneAnnounce = value
								Archy:ConfigUpdated('artifact')
							end,
							disabled = function() return not db.artifact.announce end,
						},
						ping = {
							order = 5,
							type = "toggle",
							name = L["Play sound when solvable"],
							desc = L["Play a sound when an artifact can be solved with fragments"],
							get = function() return db.artifact.ping end,
							set = function(_, value)
								db.artifact.ping = value
								Archy:ConfigUpdated('artifact')
							end,
						},
						keystonePing = {
							order = 6,
							type = "toggle",
							name = L["Include key stones"],
							desc = L["Play a sound when an artifact can be solved with fragments and key stones"],
							get = function() return db.artifact.keystonePing end,
							set = function(_, value)
								db.artifact.keystonePing = value
								Archy:ConfigUpdated('artifact')
							end,
							disabled = function() return not db.artifact.ping end,
						},
						confirmSolve = {
							order = 6.5,
							type = "toggle",
							name = L["Confirm solves near skill cap"],
							desc = L["Ask for confirmation when your skill nears the cap.  When enabled, no confirmation is needed for Illustrious Archaeologists."],
							get = function() return db.general.confirmSolve end,
							set = function(_, value)
								db.general.confirmSolve = value
								Archy:ConfigUpdated()
							end,
							width = "full",
						},
						showSkillBar = {
							order = 7,
							name = L["Show Archaeology Skill"],
							desc = L["Show your Archaeology skill on the Artifacts list header"],
							type = "toggle",
							get = function() return db.general.showSkillBar end,
							set = function(_, value)
								db.general.showSkillBar = value
								Archy:ConfigUpdated()
							end,
							width = "double",
						},
					},
				},
				blacklist = {
					order = 1,
					type = "group",
					name = L["Blacklist"],
					args = {
						desc = {
							order = 0,
							type = "description",
							name = L["Allows you to blacklist races from being used by Archy"],
						},
						races = {
							order = 1,
							type = "multiselect",
							tristate = false,
							name = _G.RACES,
							desc = L["Select races to blacklist"],
							values = function()
								local races = {}
								for rid, race in pairs(private.race_data) do
									races[rid] = race.name
								end
								return races
							end,
							get = function(info, key) return db.artifact.blacklist[key] end,
							set = function(info, key, value)
								db.artifact.blacklist[key] = value
								Archy:ConfigUpdated('artifact')
							end,
							width = "full",
						},
					},
				},
				autofill = {
					order = 2,
					type = "group",
					name = L["AutoFill Key Stones"],
					args = {
						desc = {
							order = 0,
							type = "description",
							name = L["Allows Archy to autofill key stones as you receive them for you on the races you specify"],
						},
						races = {
							order = 1,
							type = "multiselect",
							tristate = false,
							name = _G.RACES,
							desc = L["Select races to autofill"],
							values = function()
								local races = {}
								for rid, race in pairs(private.race_data) do
									races[rid] = race.name
								end
								return races
							end,
							get = function(info, key) return db.artifact.autofill[key] end,
							set = function(info, key, value)
								db.artifact.autofill[key] = value
								Archy:ConfigUpdated('artifact', 'autofill')
							end,
							width = "full",
						},
					},
				},
				frameOptions = {
					order = 4,
					type = "group",
					name = L["Frame Options"],
					--            guiInline = true,
					args = {
						scale = {
							order = 7,
							type = "range",
							name = L["Size"],
							desc = L["Set how large the Artifacts list is"],
							min = 0.25,
							max = 4,
							step = 0.01,
							bigStep = 0.05,
							get = function() return db.artifact.scale end,
							set = function(_, value)
								db.artifact.scale = value
								Archy:ConfigUpdated('artifact')
							end,
						},
						alpha = {
							order = 8,
							type = "range",
							name = _G.OPACITY,
							desc = L["Set how transparent or opaque the Artifacts list is"],
							min = 0,
							max = 1,
							step = 0.01,
							bigStep = 0.05,
							get = function() return db.artifact.alpha end,
							set = function(_, value)
								db.artifact.alpha = value
								Archy:ConfigUpdated('artifact')
							end,
						},
						anchor = {
							order = 9,
							type = "select",
							name = L["Anchor"],
							desc = L["The corner of the Artifacts list that the frame will grow from."],
							get = function() return db.artifact.anchor end,
							set = function(_, value)
								db.artifact.anchor = value
								Archy:SaveFramePosition(private.races_frame)
							end,
							values = FRAME_ANCHOR_OPTIONS,
						},
						space = {
							order = 12,
							type = "description",
							name = "",
						},
						borderAlpha = {
							order = 13,
							type = "range",
							name = L["Border Opacity"],
							desc = L["Set how transparent or opaque the border for the Artifacts list is"],
							min = 0,
							max = 1,
							step = 0.01,
							bigStep = 0.05,
							get = function() return db.artifact.borderAlpha end,
							set = function(_, value)
								db.artifact.borderAlpha = value
								Archy:ConfigUpdated('artifact')
							end,
						},
						bgAlpha = {
							order = 14,
							type = "range",
							name = L["Background Opacity"],
							desc = L["Set how transparent or opaque the background for the Artifacts list is"],
							min = 0,
							max = 1,
							step = 0.01,
							bigStep = 0.05,
							get = function() return db.artifact.bgAlpha end,
							set = function(_, value)
								db.artifact.bgAlpha = value
								Archy:ConfigUpdated('artifact')
							end,
						},
						borderTexture = {
							order = 13.5,
							type = "select",
							name = L["Border Texture"],
							desc = L["Set the texture used by the frame border"],
							dialogControl = "LSM30_Border",
							values = LSM:HashTable(LSM.MediaType.BORDER),
							get = function() return db.artifact.borderTexture end,
							set = function(_, value)
								db.artifact.borderTexture = value
								Archy:ConfigUpdated('artifact')
							end,
						},
						backgroundTexture = {
							order = 14.5,
							type = "select",
							name = L["Background Texture"],
							desc = L["Set the texture used by the frame background"],
							dialogControl = "LSM30_Border",
							values = LSM:HashTable(LSM.MediaType.BACKGROUND),
							get = function() return db.artifact.backgroundTexture end,
							set = function(_, value)
								db.artifact.backgroundTexture = value
								Archy:ConfigUpdated('artifact')
							end,
						},
						fragmentBarTexture = {
							order = 20,
							type = "select",
							name = L["Progress Bar Texture"],
							desc = L["Set the texture used by the progress bars"],
							dialogControl = "LSM30_Statusbar",
							values = LSM:HashTable(LSM.MediaType.STATUSBAR),
							get = function() return db.artifact.fragmentBarTexture end,
							set = function(_, value)
								db.artifact.fragmentBarTexture = value
								Archy:ConfigUpdated('artifact')
							end,
						},
					},
				},
				fontOptions = {
					name = L["Font Options"],
					order = 5,
					type = "group",
					args = {
						mainFontOptions = {
							order = 1,
							type = "group",
							name = L["Main Font Options"],
							guiInline = true,
							args = {
								fontName = {
									order = 1,
									type = "select",
									dialogControl = 'LSM30_Font',
									name = L["Font"],
									desc = L["The font that will be used"],
									values = _G.AceGUIWidgetLSMlists.font,
									get = function() return db.artifact.font.name end,
									set = function(_, value)
										db.artifact.font.name = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontSize = {
									order = 2,
									type = "range",
									name = _G.FONT_SIZE,
									desc = L["Control the font size"],
									min = 4,
									max = 30,
									step = 1,
									get = function() return db.artifact.font.size end,
									set = function(_, value)
										db.artifact.font.size = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontOutline = {
									order = 3,
									type = "select",
									name = L["Font Outline"],
									desc = L["The outline of the font"],
									values = FONT_OUTLINES,
									get = function() return db.artifact.font.outline end,
									set = function(_, value)
										db.artifact.font.outline = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontShadow = {
									order = 4,
									type = "toggle",
									name = L["Font Shadow"],
									desc = L["Toggles if the font will have a shadow"],
									get = function() return db.artifact.font.shadow end,
									set = function(_, value)
										db.artifact.font.shadow = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontColor = {
									type = "color",
									order = 5,
									name = L["Font Color"],
									desc = L["The color of the font"],
									hasAlpha = true,
									get = function(info)
										return db.artifact.font.color.r, db.artifact.font.color.g, db.artifact.font.color.b, db.artifact.font.color.a
									end,
									set = function(info, r, g, b, a)
										db.artifact.font.color.r = r
										db.artifact.font.color.g = g
										db.artifact.font.color.b = b
										db.artifact.font.color.a = a
										Archy:ConfigUpdated('artifact')
									end,
								},
							},
						},
						fragmentFontOptions = {
							order = 2,
							type = "group",
							name = L["Fragment Font Options"],
							guiInline = true,
							disabled = function() return (db.general.theme ~= "Graphical") end,
							args = {
								fontName = {
									order = 1,
									type = "select",
									dialogControl = 'LSM30_Font',
									name = L["Font"],
									desc = L["The font that will be used"],
									values = _G.AceGUIWidgetLSMlists.font,
									get = function() return db.artifact.fragmentFont.name end,
									set = function(_, value)
										db.artifact.fragmentFont.name = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontSize = {
									order = 2,
									type = "range",
									name = _G.FONT_SIZE,
									desc = L["Control the font size"],
									min = 4,
									max = 30,
									step = 1,
									get = function() return db.artifact.fragmentFont.size end,
									set = function(_, value)
										db.artifact.fragmentFont.size = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontOutline = {
									order = 3,
									type = "select",
									name = L["Font Outline"],
									desc = L["The outline of the font"],
									values = FONT_OUTLINES,
									get = function() return db.artifact.fragmentFont.outline end,
									set = function(_, value)
										db.artifact.fragmentFont.outline = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontShadow = {
									order = 4,
									type = "toggle",
									name = L["Font Shadow"],
									desc = L["Toggles if the font will have a shadow"],
									get = function() return db.artifact.fragmentFont.shadow end,
									set = function(_, value)
										db.artifact.fragmentFont.shadow = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontColor = {
									type = "color",
									order = 5,
									name = L["Font Color"],
									desc = L["The color of the font"],
									hasAlpha = true,
									get = function(info)
										return db.artifact.fragmentFont.color.r, db.artifact.fragmentFont.color.g, db.artifact.fragmentFont.color.b, db.artifact.fragmentFont.color.a
									end,
									set = function(info, r, g, b, a)
										db.artifact.fragmentFont.color.r = r
										db.artifact.fragmentFont.color.g = g
										db.artifact.fragmentFont.color.b = b
										db.artifact.fragmentFont.color.a = a
										Archy:ConfigUpdated('artifact')
									end,
								},
							},
						},
						keystoneFontOptions = {
							order = 3,
							type = "group",
							name = L["Key Stone Font Options"],
							guiInline = true,
							disabled = function() return (db.general.theme ~= "Graphical") end,
							args = {
								fontName = {
									order = 1,
									type = "select",
									dialogControl = 'LSM30_Font',
									name = L["Font"],
									desc = L["The font that will be used"],
									values = _G.AceGUIWidgetLSMlists.font,
									get = function() return db.artifact.keystoneFont.name end,
									set = function(_, value)
										db.artifact.keystoneFont.name = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontSize = {
									order = 2,
									type = "range",
									name = _G.FONT_SIZE,
									desc = L["Control the font size"],
									min = 4,
									max = 30,
									step = 1,
									get = function() return db.artifact.keystoneFont.size end,
									set = function(_, value)
										db.artifact.keystoneFont.size = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontOutline = {
									order = 3,
									type = "select",
									name = L["Font Outline"],
									desc = L["The outline of the font"],
									values = FONT_OUTLINES,
									get = function() return db.artifact.keystoneFont.outline end,
									set = function(_, value)
										db.artifact.keystoneFont.outline = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontShadow = {
									order = 4,
									type = "toggle",
									name = L["Font Shadow"],
									desc = L["Toggles if the font will have a shadow"],
									get = function() return db.artifact.keystoneFont.shadow end,
									set = function(_, value)
										db.artifact.keystoneFont.shadow = value
										Archy:ConfigUpdated('artifact')
									end,
								},
								fontColor = {
									type = "color",
									order = 5,
									name = L["Font Color"],
									desc = L["The color of the font"],
									hasAlpha = true,
									get = function(info)
										return db.artifact.keystoneFont.color.r, db.artifact.keystoneFont.color.g, db.artifact.keystoneFont.color.b, db.artifact.keystoneFont.color.a
									end,
									set = function(info, r, g, b, a)
										db.artifact.keystoneFont.color.r = r
										db.artifact.keystoneFont.color.g = g
										db.artifact.keystoneFont.color.b = b
										db.artifact.keystoneFont.color.a = a
										Archy:ConfigUpdated('artifact')
									end,
								},
							},
						},
					},
				},
				colorOptions = {
					name = L["Color Options"],
					order = 6,
					type = "group",
					args = {
						fragmentBarColor = {
							order = 31,
							name = L["Progress Bar Color"],
							desc = L["Set the color of the progress bar for artifacts you are working on"],
							type = "color",
							get = function(info)
								return db.artifact.fragmentBarColors["Normal"].r, db.artifact.fragmentBarColors["Normal"].g, db.artifact.fragmentBarColors["Normal"].b
							end,
							set = function(info, r, g, b)
								db.artifact.fragmentBarColors["Normal"].r = r
								db.artifact.fragmentBarColors["Normal"].g = g
								db.artifact.fragmentBarColors["Normal"].b = b
								Archy:ConfigUpdated('artifact', 'color')
							end,
						},
						fragmentBarFirstTimeColor = {
							order = 32,
							name = L["First Time Color"],
							desc = L["Set the color of the progress bar for artifacts you are working on for the first time"],
							type = "color",
							get = function(info)
								return db.artifact.fragmentBarColors["FirstTime"].r, db.artifact.fragmentBarColors["FirstTime"].g, db.artifact.fragmentBarColors["FirstTime"].b
							end,
							set = function(info, r, g, b)
								db.artifact.fragmentBarColors["FirstTime"].r = r
								db.artifact.fragmentBarColors["FirstTime"].g = g
								db.artifact.fragmentBarColors["FirstTime"].b = b
								Archy:ConfigUpdated('artifact', 'color')
							end,
						},
						fragmentBarSolvableColor = {
							order = 33,
							name = L["Solvable Color"],
							desc = L["Set the color of the progress bar for artifacts you can solve"],
							type = "color",
							get = function(info)
								return db.artifact.fragmentBarColors["Solvable"].r, db.artifact.fragmentBarColors["Solvable"].g, db.artifact.fragmentBarColors["Solvable"].b
							end,
							set = function(info, r, g, b)
								db.artifact.fragmentBarColors["Solvable"].r = r
								db.artifact.fragmentBarColors["Solvable"].g = g
								db.artifact.fragmentBarColors["Solvable"].b = b
								Archy:ConfigUpdated('artifact', 'color')
							end,
						},
						fragmentBarRareColor = {
							order = 34,
							name = L["Rare Color"],
							desc = L["Set the color of the progress bar for rare artifacts you are working on"],
							type = "color",
							get = function(info)
								return db.artifact.fragmentBarColors["Rare"].r, db.artifact.fragmentBarColors["Rare"].g, db.artifact.fragmentBarColors["Rare"].b
							end,
							set = function(info, r, g, b)
								db.artifact.fragmentBarColors["Rare"].r = r
								db.artifact.fragmentBarColors["Rare"].g = g
								db.artifact.fragmentBarColors["Rare"].b = b
								Archy:ConfigUpdated('artifact', 'color')
							end,
						},
						fragmentBarKeystoneColor = {
							order = 35,
							name = L["Solvable With Key Stone Color"],
							desc = L["Set the color of the progress bar for artifacts could solve if you attach key stones to them"],
							type = "color",
							get = function(info)
								return db.artifact.fragmentBarColors["AttachToSolve"].r, db.artifact.fragmentBarColors["AttachToSolve"].g, db.artifact.fragmentBarColors["AttachToSolve"].b
							end,
							set = function(info, r, g, b)
								db.artifact.fragmentBarColors["AttachToSolve"].r = r
								db.artifact.fragmentBarColors["AttachToSolve"].g = g
								db.artifact.fragmentBarColors["AttachToSolve"].b = b
								Archy:ConfigUpdated('artifact', 'color')
							end,
						},
					},
				},
			},
		}
	end
	return artifact_options
end

local digsite_options

local function GetDigSiteOptions()
	if not digsite_options then
		local db = private.db

		digsite_options = {
			order = 3,
			type = "group",
			childGroups = "tab",
			name = L["Dig Sites"],
			desc = L["Dig Site Options"],
			args = {
				options = {
					name = _G.GENERAL_LABEL,
					order = 0,
					type = "group",
					args = {
						desc = {
							order = 0,
							type = "description",
							name = L["Control various aspects of the Dig Site options"],
						},
						show = {
							order = 1,
							type = "toggle",
							name = _G.SHOW,
							desc = L["Toggles the display of the Dig Sites list"],
							get = function() return db.digsite.show end,
							set = function(_, value)
								db.digsite.show = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						sortByDistance = {
							order = 2,
							type = "toggle",
							name = L["Sort by distance"],
							desc = L["Sort the dig sites by your distance to them"],
							get = function() return db.digsite.sortByDistance end,
							set = function(_, value)
								db.digsite.sortByDistance = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						announceNearest = {
							order = 3,
							type = "toggle",
							name = L["Announce Nearest Dig Site"],
							desc = L["Announces the nearest dig site when it is found"],
							get = function() return db.digsite.announceNearest end,
							set = function(_, value)
								db.digsite.announceNearest = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						minimalOptions = {
							name = L["Minimal Style Options"],
							type = "group",
							order = 10,
							guiInline = true,
							disabled = function() return (db.general.theme == "Graphical") end,
							args = {
								showZone = {
									order = 1,
									type = "toggle",
									name = L["Show Zone"],
									get = function() return db.digsite.minimal.showZone end,
									set = function(_, value)
										db.digsite.minimal.showZone = value
										Archy:ConfigUpdated('digsite')
									end,
								},
								announceNearest = {
									order = 3,
									type = "toggle",
									name = L["Show Distance"],
									get = function() return db.digsite.minimal.showDistance end,
									set = function(_, value)
										db.digsite.minimal.showDistance = value
										Archy:ConfigUpdated('digsite')
									end,
								},
							},
						},
					},
				},
				distanceIndicator = {
					name = L["Survey Distance Indicator"],
					order = 1,
					type = "group",
					args = {
						desc = {
							order = 0,
							type = "description",
							name = L["Control various aspects of Survey Distance Indicator options"],
						},
						enable = {
							order = 1,
							type = "toggle",
							name = _G.ENABLE,
							desc = L["Enable the Survey Distance Indicator"],
							get = function() return db.digsite.distanceIndicator.enabled end,
							set = function(_, value)
								db.digsite.distanceIndicator.enabled = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						docked = {
							order = 1.5,
							type = "toggle",
							name = L["Undock"],
							desc = L["Undock the survey distance indicator from the Dig Sites list"],
							get = function() return db.digsite.distanceIndicator.undocked end,
							set = function(_, value)
								db.digsite.distanceIndicator.undocked = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						anchor = {
							order = 1.6,
							type = "select",
							name = L["Anchor"],
							desc = L["The corner of the survey distance indicator that the frame will anchor from."],
							get = function() return db.digsite.distanceIndicator.anchor end,
							set = function(_, value)
								db.digsite.distanceIndicator.anchor = value
								Archy:SaveFramePosition(private.distance_indicator_frame)
							end,
							values = FRAME_ANCHOR_OPTIONS,
							disabled = function() return not db.digsite.distanceIndicator.undocked end,
						},
						showSurveyButton = {
							order = 2.1,
							type = "toggle",
							name = L["Show Survey Button"],
							desc = L["Shows a Survey button with the Distance Indicator."],
							get = function() return db.digsite.distanceIndicator.showSurveyButton end,
							set = function(_, value)
								db.digsite.distanceIndicator.showSurveyButton = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						showCrateButton = {
							order = 2.2,
							type = "toggle",
							name = L["Show Crate Button"],
							desc = L["Shows a Crate button with the Distance Indicator."],
							get = function() return db.digsite.distanceIndicator.showCrateButton end,
							set = function(_, value)
								db.digsite.distanceIndicator.showCrateButton = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						showLorItemButton = {
							order = 2.3,
							type = "toggle",
							name = L["Show Lorewalker Items Button"],
							desc = L["Shows Lorewalker Items with the Distance Indicator."],
							get = function() return db.digsite.distanceIndicator.showLorItemButton end,
							set = function(_, value)
								db.digsite.distanceIndicator.showLorItemButton = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						space = {
							order = 3,
							type = "description",
							name = "",
						},
						green = {
							order = 5,
							type = "range",
							name = L["Green Distance Radius"],
							desc = L["Set how large the green area of the survey distance indicator will use"],
							min = 1,
							max = 200,
							step = 1,
							get = function() return db.digsite.distanceIndicator.green end,
							set = function(_, value)
								db.digsite.distanceIndicator.green = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						yellow = {
							order = 6,
							type = "range",
							name = L["Yellow Distance Radius"],
							desc = L["Set how large the yellow area of the survey distance indicator will use"],
							min = 1,
							max = 200,
							step = 1,
							get = function() return db.digsite.distanceIndicator.yellow end,
							set = function(_, value)
								db.digsite.distanceIndicator.yellow = value
								Archy:ConfigUpdated('digsite')
							end,
						},
					},
				},
				frameOptions = {
					name = L["Frame Options"],
					order = 2,
					type = "group",
					args = {
						desc = {
							order = 0,
							type = "description",
							name = L["Control various aspects of how the Dig Site list is displayed"],
						},
						scale = {
							order = 7,
							type = "range",
							name = L["Size"],
							desc = L["Set how large the Dig Site list is"],
							min = 0.25,
							max = 4,
							step = 0.01,
							bigStep = 0.05,
							get = function() return db.digsite.scale end,
							set = function(_, value)
								db.digsite.scale = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						alpha = {
							order = 8,
							type = "range",
							name = _G.OPACITY,
							desc = L["Set how transparent or opaque the Dig Site list is"],
							min = 0,
							max = 1,
							step = 0.01,
							bigStep = 0.05,
							get = function() return db.digsite.alpha end,
							set = function(_, value)
								db.digsite.alpha = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						anchor = {
							order = 9,
							type = "select",
							name = L["Anchor"],
							desc = L["The corner of the Dig Sites list that the frame will grow from."],
							get = function() return db.digsite.anchor end,
							set = function(_, value)
								db.digsite.anchor = value
								Archy:SaveFramePosition(private.digsite_frame)
							end,
							values = FRAME_ANCHOR_OPTIONS,
						},
						space2 = {
							order = 12,
							type = "description",
							name = "",
						},
						borderAlpha = {
							order = 13,
							type = "range",
							name = L["Border Opacity"],
							desc = L["Set how transparent or opaque the border for the Dig Sites list is"],
							min = 0,
							max = 1,
							step = 0.01,
							bigStep = 0.05,
							get = function() return db.digsite.borderAlpha end,
							set = function(_, value)
								db.digsite.borderAlpha = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						bgAlpha = {
							order = 14,
							type = "range",
							name = L["Background Opacity"],
							desc = L["Set how transparent or opaque the background for the Dig Sites list is"],
							min = 0,
							max = 1,
							step = 0.01,
							bigStep = 0.05,
							get = function() return db.digsite.bgAlpha end,
							set = function(_, value)
								db.digsite.bgAlpha = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						borderTexture = {
							order = 13.5,
							type = "select",
							name = L["Border Texture"],
							desc = L["Set the texture used by the frame border"],
							dialogControl = "LSM30_Border",
							values = LSM:HashTable(LSM.MediaType.BORDER),
							get = function() return db.digsite.borderTexture end,
							set = function(_, value)
								db.digsite.borderTexture = value
								Archy:ConfigUpdated('digsite')
							end,
						},
						backgroundTexture = {
							order = 14.5,
							type = "select",
							name = L["Background Texture"],
							desc = L["Set the texture used by the frame background"],
							dialogControl = "LSM30_Border",
							values = LSM:HashTable(LSM.MediaType.BACKGROUND),
							get = function() return db.digsite.backgroundTexture end,
							set = function(_, value)
								db.digsite.backgroundTexture = value
								Archy:ConfigUpdated('digsite')
							end,
						},
					},
				},
				fontOptions = {
					name = L["Font Options"],
					order = 5,
					type = "group",
					args = {
						mainFontOptions = {
							order = 1,
							type = "group",
							name = L["Main Font Options"],
							guiInline = true,
							args = {
								fontName = {
									order = 1,
									type = "select",
									dialogControl = 'LSM30_Font',
									name = L["Font"],
									desc = L["The font that will be used"],
									values = _G.AceGUIWidgetLSMlists.font,
									get = function() return db.digsite.font.name end,
									set = function(_, value)
										db.digsite.font.name = value
										Archy:ConfigUpdated('digsite', 'font')
									end,
								},
								fontSize = {
									order = 2,
									type = "range",
									name = _G.FONT_SIZE,
									desc = L["Control the font size"],
									min = 4,
									max = 30,
									step = 1,
									get = function() return db.digsite.font.size end,
									set = function(_, value)
										db.digsite.font.size = value
										Archy:ConfigUpdated('digsite', 'font')
									end,
								},
								fontOutline = {
									order = 3,
									type = "select",
									name = L["Font Outline"],
									desc = L["The outline of the font"],
									values = FONT_OUTLINES,
									get = function() return db.digsite.font.outline end,
									set = function(_, value)
										db.digsite.font.outline = value
										Archy:ConfigUpdated('digsite', 'font')
									end,
								},
								fontShadow = {
									order = 4,
									type = "toggle",
									name = L["Font Shadow"],
									desc = L["Toggles if the font will have a shadow"],
									get = function() return db.digsite.font.shadow end,
									set = function(_, value)
										db.digsite.font.shadow = value
										Archy:ConfigUpdated('digsite', 'font')
									end,
								},
								fontColor = {
									type = "color",
									order = 5,
									name = L["Font Color"],
									desc = L["The color of the font"],
									hasAlpha = true,
									get = function(info)
										return db.digsite.font.color.r, db.digsite.font.color.g, db.digsite.font.color.b, db.digsite.font.color.a
									end,
									set = function(info, r, g, b, a)
										db.digsite.font.color.r = r
										db.digsite.font.color.g = g
										db.digsite.font.color.b = b
										db.digsite.font.color.a = a
										Archy:ConfigUpdated('digsite', 'font')
									end,
								},
							},
						},
						zoneFontOptions = {
							order = 2,
							type = "group",
							name = L["Zone Font Options"],
							guiInline = true,
							disabled = function() return (db.general.theme ~= "Graphical") end,
							args = {
								fontName = {
									order = 1,
									type = "select",
									dialogControl = 'LSM30_Font',
									name = L["Font"],
									desc = L["The font that will be used"],
									values = _G.AceGUIWidgetLSMlists.font,
									get = function() return db.digsite.zoneFont.name end,
									set = function(_, value)
										db.digsite.zoneFont.name = value
										Archy:ConfigUpdated('digsite', 'font')
									end,
								},
								fontSize = {
									order = 2,
									type = "range",
									name = _G.FONT_SIZE,
									desc = L["Control the font size"],
									min = 4,
									max = 30,
									step = 1,
									get = function() return db.digsite.zoneFont.size end,
									set = function(_, value)
										db.digsite.zoneFont.size = value
										Archy:ConfigUpdated('digsite', 'font')
									end,
								},
								fontOutline = {
									order = 3,
									type = "select",
									name = L["Font Outline"],
									desc = L["The outline of the font"],
									values = FONT_OUTLINES,
									get = function() return db.digsite.zoneFont.outline end,
									set = function(_, value)
										db.digsite.zoneFont.outline = value
										Archy:ConfigUpdated('digsite', 'font')
									end,
								},
								fontShadow = {
									order = 4,
									type = "toggle",
									name = L["Font Shadow"],
									desc = L["Toggles if the font will have a shadow"],
									get = function() return db.digsite.zoneFont.shadow end,
									set = function(_, value)
										db.digsite.zoneFont.shadow = value
										Archy:ConfigUpdated('digsite', 'font')
									end,
								},
								fontColor = {
									type = "color",
									order = 5,
									name = L["Font Color"],
									desc = L["The color of the font"],
									hasAlpha = true,
									get = function(info)
										return db.digsite.zoneFont.color.r, db.digsite.zoneFont.color.g, db.digsite.zoneFont.color.b, db.digsite.zoneFont.color.a
									end,
									set = function(info, r, g, b, a)
										db.digsite.zoneFont.color.r = r
										db.digsite.zoneFont.color.g = g
										db.digsite.zoneFont.color.b = b
										db.digsite.zoneFont.color.a = a
										Archy:ConfigUpdated('digsite', 'font')
									end,
								},
							},
						},
					},
				},
			},
		}
	end
	return digsite_options
end

local tomtom_options

local function GetTomTomOptions()
	if not tomtom_options then
		local db = private.db
		tomtom_options = {
			order = 4,
			type = "group",
			name = "TomTom",
			desc = L["TomTom Options"],
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Control various aspects of TomTom integration"],
				},
				enable = {
					order = 1,
					type = "toggle",
					name = L["Enable TomTom integration"],
					desc = L["Toggle if Archy will send the nearest dig site waypoint information to TomTom"],
					width = "double",
					get = function() return db.tomtom.enabled end,
					set = function(_, value)
						db.tomtom.enabled = value
						Archy:ConfigUpdated('tomtom')
					end,
				},
				arrivalDistance = {
					order = 2,
					type = "range",
					name = L["\"Arrival Distance\""],
					desc = L["This setting will control the distance at which the waypoint arrow switches to a downwards arrow, indicating you have arrived at your destination.\nNOTE: This may not work with emulation addons if they do not support this."],
					min = 0,
					max = 150,
					step = 5,
					get = function() return db.tomtom.distance end,
					set = function(_, value)
						db.tomtom.distance = value
						Archy:ConfigUpdated('tomtom')
					end,
					disabled = function() return not db.tomtom.enabled or not private.tomtomExists end,
					--            width = "double"
				},
				arrivalPing = {
					order = 3,
					type = "toggle",
					name = L["Play a sound when arriving at a waypoint"],
					desc = L["When you 'arrive' at a waypoint (this distance is controlled by the 'Arrival Distance' setting in this group) a sound can be played to indicate this.  You can enable or disable this sound using this setting."],
					width = "double",
					get = function() return db.tomtom.ping end,
					set = function(_, value)
						db.tomtom.ping = value
						Archy:ConfigUpdated('tomtom')
					end,
					disabled = function() return not db.tomtom.enabled or not private.tomtomExists end,
					width = "double"
				},
			},
		}
	end
	return tomtom_options
end

local minimap_options

local function GetMinimapOptions()
	if not minimap_options then
		local db = private.db

		minimap_options = {
			order = 5,
			type = "group",
			name = _G.MINIMAP_LABEL,
			desc = L["Minimap Options"],
			args = {
				desc = {
					order = 0,
					type = "description",
					name = L["Control various aspects of Minimap options"],
				},
				show = {
					order = 1,
					type = "toggle",
					name = L["Show Dig Sites"],
					desc = L["Show your dig sites on the minimap"],
					get = function() return db.minimap.show end,
					set = function(_, value)
						db.minimap.show = value
						Archy:ConfigUpdated('minimap')
					end,
				},
				nearest = {
					order = 2,
					type = "toggle",
					name = L["Nearest only"],
					desc = L["Show only the nearest dig site on the minimap"],
					get = function() return db.minimap.nearest end,
					set = function(_, value)
						db.minimap.nearest = value
						Archy:ConfigUpdated('minimap')
					end,
					disabled = function() return not db.minimap.show end,
				},
				fragmentNodes = {
					order = 3,
					type = "toggle",
					width = "full",
					name = L["Show Fragment Nodes"],
					desc = L["Show the locations where you have collected fragments"],
					get = function() return db.minimap.fragmentNodes end,
					set = function(_, value)
						db.minimap.fragmentNodes = value
						Archy:ConfigUpdated('minimap')
					end,
				},
				fragmentColorBySurveyDistance = {
					order = 3.5,
					name = L["Color Node Icons On Survey"],
					desc = L["Color code the fragment node icon based on the survey distance"],
					type = "toggle",
					width = "double",
					get = function() return db.minimap.fragmentColorBySurveyDistance end,
					set = function(_, value)
						db.minimap.fragmentColorBySurveyDistance = value
						Archy:ConfigUpdated('minimap')
					end,
				},
				fragmentIcon = {
					order = 4,
					name = L["Node Icon"],
					desc = L["Icon to use for the fragment node icon"],
					type = "select",
					values = {
						["CyanDot"] = L["Light Blue Dot"],
						["Cross"] = L["Cross"],
					},
					get = function()
						return db.minimap.fragmentIcon
					end,
					set = function(_, value)
						db.minimap.fragmentIcon = value
						Archy:ConfigUpdated('minimap')
					end,
				},
			},
		}
	end
	return minimap_options
end

local tooltip_options

local function GetTooltipOptions()
	if not tooltip_options then
		local db = private.db

		tooltip_options = {
			order = 6,
			type = "group",
			name = "Tooltips",
			desc = L["Tooltip Options"],
			args = {
				filterLDB = {
					order = 1,
					type = "toggle",
					width = "full",
					name = L["Filter tooltip to Continent"],
					desc = L["Filter the tooltip to only include the current continent"],
					get = function()
						return db.tooltip.filter_continent
					end,
					set = function(_, value)
						db.tooltip.filter_continent = value
						Archy:ConfigUpdated('digsite', 'tooltip')
					end,
				},
				scale = {
					order = 2,
					type = "range",
					width = "full",
					name = L["Tooltip Scale"],
					desc = L["Move the slider to adjust the scale of the tooltip."],
					min = 0.5,
					max = 1.5,
					step = 0.01,
					get = function()
						return db.tooltip.scale
					end,
					set = function(info, value)
						db.tooltip.scale = _G.math.max(0.5, _G.math.min(1.5, value))
					end,
				},
			},
		}
	end
	return tooltip_options
end

function Archy:SetupOptions()
	local ACFG = LibStub("AceConfig-3.0")
	ACFG:RegisterOptionsTable("Archy General", GetGeneralOptions)
	ACFG:RegisterOptionsTable("Archy Artifacts", GetArtifactOptions)
	ACFG:RegisterOptionsTable("Archy Dig Sites", GetDigSiteOptions)
	ACFG:RegisterOptionsTable("Archy TomTom", GetTomTomOptions)
	ACFG:RegisterOptionsTable("Archy Minimap", GetMinimapOptions)
	ACFG:RegisterOptionsTable("Archy Tooltips", GetTooltipOptions)
	ACFG:RegisterOptionsTable("Archy Profiles", LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db))

	local ACD = LibStub("AceConfigDialog-3.0")
	--ACD:AddToBlizOptions("Archy General", _G.GENERAL_LABEL, "Archy")
	ACD:AddToBlizOptions("Archy General", "Archy")
	ACD:AddToBlizOptions("Archy Artifacts", L["Artifacts"], "Archy")
	ACD:AddToBlizOptions("Archy Dig Sites", L["Dig Sites"], "Archy")
	ACD:AddToBlizOptions("Archy TomTom", L["TomTom Support"], "Archy")
	ACD:AddToBlizOptions("Archy Minimap", _G.MINIMAP_LABEL, "Archy")
	ACD:AddToBlizOptions("Archy Tooltips", L["Tooltip"], "Archy")
	ACD:AddToBlizOptions("Archy Profiles", L["Profiles"], "Archy")
end
