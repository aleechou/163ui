local Ellipsis = _G.Ellipsis
local L = LibStub('AceLocale-3.0'):GetLocale('Ellipsis_Options')
local Media = LibStub('LibSharedMedia-3.0')

local options = {
	name = "Ellipsis",
	handler = Ellipsis,
	type = "group",
	args = {
		lock = {
			name = L.Lock,
			desc = L.LockDesc,
			type = 'toggle',
			order = 1,
			width = 'half',
			get = 'GetOption',
			set = 'SetOption',
		},
		sampleTimers = {
			name = L.SampleTimers,
			desc = L.SampleTimersDesc,
			type = 'execute',
			order = 2,
			width = 'half',
			func = 'SampleTimers',
		},
		display = {
			name = L.Display,
			desc = L.DisplayDesc,
			type = 'group',
			order = 3,
			args = {
				tooltips = {
					name = L.Tooltips,
					desc = L.TooltipsDesc,
					type = 'toggle',
					order = 1,
					get = 'GetOption',
					set = 'SetOption',
				},
				clickable = {
					name = L.Clickable,
					desc = L.ClickableDesc,
					type = 'toggle',
					order = 2,
					get = 'GetOption',
					set = 'SetOption',
				},
				auraAlpha = {
					name = L.AuraAlpha,
					desc = L.AuraAlphaDesc,
					type = 'range',
					order = 3,
					min = 0.0,
					max = 1.0,
					step = 0.1,
					bigStep = 0.1,
					get = 'GetOption',
					set = 'SetOption',
				},
				auraScale = {
					name = L.AuraScale,
					desc = L.AuraScaleDesc,
					type = 'range',
					order = 4,
					min = 0.5,
					max = 1.5,
					step = 0.1,
					bigStep = 0.1,
					get = 'GetOption',
					set = 'SetOption',
				},
				width = {
					name = L.AuraWidth,
					desc = L.AuraWidthDesc,
					type = 'range',
					order = 5,
					min = 50,
					max = 250,
					step = 5,
					bigStep = 5,
					get = 'GetOption',
					set = 'SetOption',
				},
				cdAlpha = {
					name = L.CDAlpha,
					desc = L.CDAlphaDesc,
					type = 'range',
					order = 6,
					min = 0.0,
					max = 1.0,
					step = 0.1,
					bigStep = 0.1,
					get = 'GetOption',
					set = 'SetOption',
				},
				cdScale = {
					name = L.CDScale,
					desc = L.CDScaleDesc,
					type = 'range',
					order = 7,
					min = 0.5,
					max = 1.5,
					step = 0.1,
					bigStep = 0.1,
					get = 'GetOption',
					set = 'SetOption',
				},
				displayTarget1 = {
					name = L.DisplayTarget1,
					desc = L.DisplayTargetDesc,
					type = 'group',
					order = 8,
					args = {
						configTargetDisplay = {
							name = L.ConfigTargetDisplay,
							desc = L.ConfigTargetDisplayDesc,
							type = 'select',
							order = 1,
							get = 'GetConfigTargetDisplay',
							set = 'SetConfigTargetDisplay',
							values = {
								['all'] = L.ConfigTargetDisplayAll,
								['alltarget'] = L.ConfigTargetDisplayAllTarget,
								['allfocus'] = L.ConfigTargetDisplayAllFocus,
								['allboth'] = L.ConfigTargetDisplayAllBoth,
								['target'] = L.ConfigTargetDisplayTarget,
								['focus'] = L.ConfigTargetDisplayFocus,
								['both'] = L.ConfigTargetDisplayBoth,
							},
						},
						showNumTargets = {
							name = L.ShowNumTargets,
							desc = L.ShowNumTargetsDesc,
							type = 'range',
							order = 2,
							min = 2,
							max = 20,
							step = 1,
							bigStep = 1,
							get = 'GetOption',
							set = 'SetOption',
						},
						targetFont = {
							name = L.TargetFont,
							desc = L.TargetFontDesc,
							type = 'select',
							order = 3,
							get = 'GetOption',
							set = 'SetOption',
							values = Media:HashTable('font'),
							dialogControl = 'LSM30_Font',
						},
						targetFontHeight = {
							name = L.TargetFontHeight,
							desc = L.TargetFontHeightDesc,
							type = 'range',
							order = 4,
							min = 6,
							max = 20,
							step = 1,
							bigStep = 1,
							get = 'GetOption',
							set = 'SetOption',
						},
						targetPadding = {
							name = L.TargetPadding,
							desc = L.TargetPaddingDesc,
							type = 'range',
							order = 5,
							min = 0,
							max = 15,
							step = 1,
							bigStep = 1,
							get = 'GetOption',
							set = 'SetOption',
						},
						growTargets = {
							name = L.GrowTargets,
							desc = L.GrowTargetsDesc,
							type = 'select',
							order = 6,
							width = 'half',
							get = 'GetOption',
							set = 'SetOption',
							values = {
								['UP'] = L.GrowUP,
								['DOWN'] = L.GrowDOWN,
								['LEFT'] = L.GrowLEFT,
								['RIGHT'] = L.GrowRIGHT,
							},
						},
					},
				},
				displayTarget2 = {
					name = L.DisplayTarget2,
					desc = L.DisplayTargetDesc,
					type = 'group',
					order = 9,
					args = {
						showLevel = {
							name = L.ShowLevel,
							desc = L.ShowLevelDesc,
							type = 'toggle',
							order = 1,
							get = 'GetOption',
							set = 'SetOption',
						},
						showClassColours = {
							name = L.ShowClassColours,
							desc = L.ShowClassColoursDesc,
							type = 'toggle',
							order = 2,
							get = 'GetOption',
							set = 'SetOption',
						},
						showRaidIcons = {
							name = L.ShowRaidIcons,
							desc = L.ShowRaidIconsDesc,
							type = 'toggle',
							order = 3,
							get = 'GetOption',
							set = 'SetOption',
						},
						prominentHeader = {
							name = L.ProminentTargetsHeader,
							type = 'header',
							order = 4,
						},
						prominentDesc = {
							name = L.ProminentTargetsDesc,
							type = 'description',
							order = 5,
						},
						notarget = {
							name = L.ProminentNoTarget,
							desc = L.ProminentItemsDesc,
							type = 'toggle',
							order = 6,
							get = 'GetProminenceOption',
							set = 'SetProminenceOption',
						},
						player = {
							name = L.ProminentPlayer,
							desc = L.ProminentItemsDesc,
							type = 'toggle',
							order = 7,
							get = 'GetProminenceOption',
							set = 'SetProminenceOption',
						},
						pet = {
							name = L.ProminentPet,
							desc = L.ProminentItemsDesc,
							type = 'toggle',
							order = 8,
							get = 'GetProminenceOption',
							set = 'SetProminenceOption',
						},
					},
				},
				displayTimer1 = {
					name = L.DisplayTimer1,
					desc = L.DisplayTimerDesc,
					type = 'group',
					order = 10,
					args = {
						sortTimerMethod = {
							name = L.SortTimerMethod,
							desc = L.SortTimerMethodDesc,
							type = 'select',
							order = 1,
							get = 'GetOption',
							set = 'SetOption',
							values = {
								[1] = L.SortTimerMethod1,
								[2] = L.SortTimerMethod2,
								[3] = L.SortTimerMethod3,
								[4] = L.SortTimerMethod4,
								[5] = L.SortTimerMethod5,
							},
						},
						timerFormat = {
							name = L.TimerFormat,
							desc = L.TimerFormatDesc,
							type = 'select',
							order = 2,
							get = 'GetOption',
							set = 'SetOption',
							values = {
								[1] = L.TimerFormat1,
								[2] = L.TimerFormat2,
								[3] = L.TimerFormat3,
								[4] = L.TimerFormat4,
							},
						},
						showTenths = {
							name = L.ShowTenths,
							desc = L.ShowTenthsDesc,
							type = 'toggle',
							order = 3,
							get = 'GetOption',
							set = 'SetOption',
						},
						mode = {
							name = L.Mode,
							desc = L.ModeDesc,
							type = 'select',
							order = 4,
							width = 'half',
							get = 'GetOption',
							set = 'SetOption',
							values = {
								['bars'] = L.ModeBars,
								['icons'] = L.ModeIcons,
							},
						},
						growTimers = {
							name = L.GrowTimers,
							desc = L.GrowTimersDesc,
							type = 'select',
							order = 5,
							width = 'half',
							get = 'GetOption',
							set = 'SetOption',
							values = {
								['DOWN'] = L.GrowDOWN,
								['LEFT'] = L.GrowLEFT,
								['RIGHT'] = L.GrowRIGHT,
							},
						},
						ghostShow = {
							name = L.GhostShow,
							desc = L.GhostShowDesc,
							type = 'toggle',
							order = 6,
							get = 'GetOption',
							set = 'SetOption',
						},
						ghostDuration = {
							name = L.GhostDuration,
							desc = L.GhostDurationDesc,
							type = 'range',
							order = 7,
							min = 2,
							max = 10,
							step = 1,
							bigStep = 1,
							get = 'GetOption',
							set = 'SetOption',
						},
					},
				},
				displayTimer2 = {
					name = L.DisplayTimer2,
					desc = L.DisplayTimerDesc,
					type = 'group',
					order = 11,
					args = {
						barHeight = {
							name = L.BarHeight,
							desc = L.BarHeightDesc,
							type = 'range',
							order = 1,
							min = 8,
							max = 24,
							step = 2,
							bigStep = 2,
							get = 'GetOption',
							set = 'SetOption',
						},
						iconHeight = {
							name = L.IconHeight,
							desc = L.IconHeightDesc,
							type = 'range',
							order = 2,
							min = 8,
							max = 32,
							step = 2,
							bigStep = 2,
							get = 'GetOption',
							set = 'SetOption',
						},
						timerPadding = {
							name = L.TimerPadding,
							desc = L.TimerPaddingDesc,
							type = 'range',
							order = 3,
							min = 0,
							max = 15,
							step = 1,
							bigStep = 1,
							get = 'GetOption',
							set = 'SetOption',
						},
						texture = {
							name = L.Texture,
							desc = L.TextureDesc,
							type = 'select',
							order = 4,
							get = 'GetOption',
							set = 'SetOption',
							values = Media:HashTable('statusbar'),
							dialogControl = 'LSM30_Statusbar',
						},
						timerFont = {
							name = L.TimerFont,
							desc = L.TimerFontDesc,
							type = 'select',
							order = 5,
							get = 'GetOption',
							set = 'SetOption',
							values = Media:HashTable('font'),
							dialogControl = 'LSM30_Font',
						},
						timerFontHeight = {
							name = L.TimerFontHeight,
							desc = L.TimerFontHeightDesc,
							type = 'range',
							order = 6,
							min = 6,
							max = 20,
							step = 1,
							bigStep = 1,
							get = 'GetOption',
							set = 'SetOption',
						},
						showStackInName = {
							name = L.ShowStackInName,
							desc = L.ShowStackInNameDesc,
							type = 'toggle',
							order = 7,
							get = 'GetOption',
							set = 'SetOption',
						},
					},
				},
				displayCooldown1 = {
					name = L.DisplayCooldown1,
					desc = L.DisplayCooldownDesc,
					type = 'group',
					order = 12,
					args = {
						cdHorizontal = {
							name = L.CDHorizontal,
							desc = L.CDHorizontalDesc,
							type = 'toggle',
							order = 1,
							get = 'GetOption',
							set = 'SetOption',
						},
						cdHideWhenNone = {
							name = L.CDHideWhenNone,
							desc = L.CDHideWhenNoneDesc,
							type = 'toggle',
							order = 2,
							get = 'GetOption',
							set = 'SetOption',
						},
						cdLength = {
							name = L.CDLength,
							desc = L.CDLengthDesc,
							type = 'range',
							order = 3,
							min = 100,
							max = 500,
							step = 5,
							bigStep = 5,
							get = 'GetOption',
							set = 'SetOption',
						},
						cdThickness = {
							name = L.CDThickness,
							desc = L.CDThicknessDesc,
							type = 'range',
							order = 4,
							min = 12,
							max = 32,
							step = 1,
							bigStep = 1,
							get = 'GetOption',
							set = 'SetOption',
						},
						cdTimeDetail = {
							name = L.CDTimeDetail,
							desc = L.CDTimeDetailDesc,
							type = 'toggle',
							order = 5,
							get = 'GetOption',
							set = 'SetOption',
						},
						cdMaxTimeDisplay = {
							name = L.CDMaxTimeDisplay,
							desc = L.CDMaxTimeDisplayDesc,
							type = 'range',
							order = 6,
							min = 30,
							max = 3600,
							step = 30,
							bigStep = 30,
							get = 'GetOption',
							set = 'SetOption',
						},
						cdFontHeight = {
							name = L.CDFontHeight,
							desc = L.CDFontHeightDesc,
							type = 'range',
							order = 7,
							min = 6,
							max = 20,
							step = 1,
							bigStep = 1,
							get = 'GetOption',
							set = 'SetOption',
						},
					},
				},
				displayCooldown2 = {
					name = L.DisplayCooldown2,
					desc = L.DisplayCooldownDesc,
					type = 'group',
					order = 13,
					args = {
						cdTexture = {
							name = L.CDTexture,
							desc = L.CDTextureDesc,
							type = 'select',
							order = 1,
							get = 'GetOption',
							set = 'SetOption',
							values = Media:HashTable('statusbar'),
							dialogControl = 'LSM30_Statusbar',
						},
						cdShowOffsetTags = {
							name = L.CDShowOffsetTags,
							desc = L.CDShowOffsetTagsDesc,
							type = 'toggle',
							order = 2,
							get = 'GetOption',
							set = 'SetOption',
						},
						cdOffset1 = {
							name = L.CDOffset1,
							desc = L.CDOffset1Desc,
							type = 'range',
							order = 3,
							min = -60,
							max = 60,
							step = 2,
							bigStep = 2,
							get = 'GetOption',
							set = 'SetOption',
						},
						cdOffset3 = {
							name = L.CDOffset3,
							desc = L.CDOffset3Desc,
							type = 'range',
							order = 4,
							min = -60,
							max = 60,
							step = 2,
							bigStep = 2,
							get = 'GetOption',
							set = 'SetOption',
						},
						cdOffset2 = {
							name = L.CDOffset2,
							desc = L.CDOffset2Desc,
							type = 'range',
							order = 5,
							min = -60,
							max = 60,
							step = 2,
							bigStep = 2,
							get = 'GetOption',
							set = 'SetOption',
						},
					},
				},
				colours = {
					name = L.DisplayColours,
					desc = L.DisplayColoursDesc,
					type = 'group',
					order = 14,
					args = {
						colourTimerDesc = {
							name = L.ColourTimerDesc,
							type = 'description',
							order = 1,
						},
						background = {
							name = L.ColourBackground,
							desc = L.ColourBackgroundDesc,
							type = 'color',
							order = 2,
							hasAlpha = true,
							get = 'GetOptionTransparentColour',
							set = 'SetOptionTransparentColour',
						},
						ghost = {
							name = L.ColourGhost,
							desc = L.ColourGhostDesc,
							type = 'color',
							order = 3,
							hasAlpha = false,
							get = 'GetOptionColour',
							set = 'SetOptionColour',
						},
						targettext = {
							name = L.ColourTargetText,
							desc = L.ColourTargetTextDesc,
							type = 'color',
							order = 4,
							hasAlpha = false,
							get = 'GetOptionColour',
							set = 'SetOptionColour',
						},
						timertext = {
							name = L.ColourTimerText,
							desc = L.ColourTimerTextDesc,
							type = 'color',
							order = 5,
							hasAlpha = false,
							get = 'GetOptionColour',
							set = 'SetOptionColour',
						},
						colourCDDesc = {
							name = L.ColourCDDesc,
							type = 'description',
							order = 6,
						},
						cdbar = {
							name = L.ColourCDBar,
							desc = L.ColourCDBarDesc,
							type = 'color',
							order = 7,
							hasAlpha = true,
							get = 'GetOptionTransparentColour',
							set = 'SetOptionTransparentColour',
						},
						cdborder = {
							name = L.ColourCDBorder,
							desc = L.ColourCDBorderDesc,
							type = 'color',
							order = 8,
							hasAlpha = true,
							get = 'GetOptionTransparentColour',
							set = 'SetOptionTransparentColour',
						},
						cdbackdrop = {
							name = L.ColourCDBackdrop,
							desc = L.ColourCDBackdropDesc,
							type = 'color',
							order = 9,
							hasAlpha = true,
							get = 'GetOptionTransparentColour',
							set = 'SetOptionTransparentColour',
						},
						cdtext = {
							name = L.ColourCDText,
							desc = L.ColourCDTextDesc,
							type = 'color',
							order = 10,
							hasAlpha = false,
							get = 'GetOptionColour',
							set = 'SetOptionColour',
						},
						cd1 = {
							name = L.ColourCD1,
							desc = L.ColourCD1Desc,
							type = 'color',
							order = 11,
							hasAlpha = false,
							get = 'GetOptionColour',
							set = 'SetOptionColour',
						},
						cd3 = {
							name = L.ColourCD3,
							desc = L.ColourCD3Desc,
							type = 'color',
							order = 12,
							hasAlpha = false,
							get = 'GetOptionColour',
							set = 'SetOptionColour',
						},
						cd2 = {
							name = L.ColourCD2,
							desc = L.ColourCD2Desc,
							type = 'color',
							order = 13,
							hasAlpha = false,
							get = 'GetOptionColour',
							set = 'SetOptionColour',
						},
					},
				},
			},
		},
		auraTracking = {
			name = L.AuraTracking,
			desc = L.AuraTrackingDesc,
			type = 'group',
			order = 4,
			args = {
				trackBuffs = {
					name = L.TrackBuffs,
					desc = L.TrackBuffsDesc,
					type = 'toggle',
					order = 1,
					get = 'GetOption',
					set = 'SetOption',
				},
				trackDebuffs = {
					name = L.TrackDebuffs,
					desc = L.TrackDebuffsDesc,
					order = 2,
					type = 'toggle',
					get = 'GetOption',
					set = 'SetOption',
				},
				trackPlayer = {
					name = L.TrackPlayer,
					desc = L.TrackPlayerDesc,
					order = 3,
					type = 'toggle',
					get = 'GetOption',
					set = 'SetOption',
				},
				trackPet = {
					name = L.TrackPet,
					desc = L.TrackPetDesc,
					order = 4,
					type = 'toggle',
					get = 'GetOption',
					set = 'SetOption',
				},
				minAuraDuration = {
					name = L.MinAuraDuration,
					desc = L.MinAuraDurationDesc,
					type = 'range',
					order = 5,
					min = 0,
					max = 30,
					step = 1,
					bigStep = 1,
					get = 'GetOption',
					set = 'SetOption',
				},
				maxAuraDuration = {
					name = L.MaxAuraDuration,
					desc = L.MaxAuraDurationDesc,
					type = 'range',
					order = 6,
					min = 0,
					max = 30,
					step = 2,
					bigStep = 2,
					get = 'GetOption',
					set = 'SetOption',
				},
				doNotTrackAdd = {
					name = L.DNTAdd,
					desc = L.DNTAddDesc,
					type = 'input',
					order = 7,
					pattern = '%a+',
					get = function(info) return '' end,
					set = 'SetDNTAddition',
					multiline = false,
				},
				doNotTrackList = {
					name = L.DNTList,
					desc = L.DNTListDesc,
					type = 'select',
					order = 8,
					get = function(info) return nil end,
					set = 'RemoveDNTEntry',
					values = 'GetDNTList',
				},
			},
		},
		cooldownTracking = {
			name = L.CooldownTracking,
			desc = L.CooldownTrackingDesc,
			type = 'group',
			order = 5,
			args = {
				trackCooldownsFor = {
					name = L.TrackCooldownsFor,
					type = 'description',
					order = 1,
				},
				cdSpell = {
					name = L.CDSpell,
					desc = L.CDSpellDesc,
					type = 'toggle',
					order = 2,
					get = 'GetOption',
					set = 'SetOption',
				},
				cdItem = {
					name = L.CDItem,
					desc = L.CDItemDesc,
					type = 'toggle',
					order = 3,
					get = 'GetOption',
					set = 'SetOption',
				},
				cdPet = {
					name = L.CDPet,
					desc = L.CDPetDesc,
					type = 'toggle',
					order = 4,
					get = 'GetOption',
					set = 'SetOption',
				},
				cdMinDuration = {
					name = L.CDMinDuration,
					desc = L.CDMinDurationDesc,
					type = 'range',
					order = 5,
					min = 2,
					max = 30,
					step = 1,
					bigStep = 1,
					get = 'GetOption',
					set = 'SetOption',
				},
				cdMaxDuration = {
					name = L.CDMaxDuration,
					desc = L.CDMaxDurationDesc,
					type = 'range',
					order = 6,
					min = 0,
					max = 30,
					step = 2,
					bigStep = 2,
					get = 'GetOption',
					set = 'SetOption',
				},
				cdDoNotTrackAdd = {
					name = L.DNTAdd,
					desc = L.CDDNTAddDesc,
					type = 'input',
					order = 7,
					pattern = '%a+',
					get = function(info) return '' end,
					set = 'SetCDDNTAddition',
					multiline = false,
				},
				cdDoNotTrackList = {
					name = L.DNTList,
					desc = L.CDDNTListDesc,
					type = 'select',
					order = 8,
					get = function(info) return nil end,
					set = 'RemoveCDDNTEntry',
					values = 'GetCDDNTList',
				},
			},
		},
		outputAudio = {
			name = L.OutputAudio,
			desc = L.OutputAudioDesc,
			type = 'group',
			order = 6,
			args = {
				playSounds = {
					name = L.OAPlaySounds,
					desc = L.OAPlaySoundsDesc,
					type = 'toggle',
					order = 1,
					get = 'GetOption',
					set = 'SetOption',
				},
				playSoundsOn = {
					name = L.OAPlaySoundsOn,
					type = 'description',
					order = 2,
				},
				expired = {
					name = L.OAVExpired,
					desc = L.OAExpiredDesc,
					type = 'select',
					order = 3,
					get = 'GetSoundOption',
					set = 'SetSoundOption',
					values = Media:HashTable('sound'),
					dialogControl = 'LSM30_Sound',
				},
				broken = {
					name = L.OAVBroken,
					desc = L.OABrokenDesc,
					type = 'select',
					order = 4,
					get = 'GetSoundOption',
					set = 'SetSoundOption',
					values = Media:HashTable('sound'),
					dialogControl = 'LSM30_Sound',
				},
				cdexpired = {
					name = L.OAVCDExpired,
					desc = L.OACDExpiredDesc,
					type = 'select',
					order = 5,
					get = 'GetSoundOption',
					set = 'SetSoundOption',
					values = Media:HashTable('sound'),
					dialogControl = 'LSM30_Sound',
				},
			},
		},
		outputVisual = {
			name = L.OutputVisual,
			desc = L.OutputVisualDesc,
			type = 'group',
			order = 7,
			args = {
				outputTo = {}, -- filled out by LibSink options
				notifyOn = {
					name = L.OVNotifyOn,
					type = 'description',
					order = 1,
				},
				notifyExpire = {
					name = L.OAVExpired,
					desc = L.OVNotifyExpireDesc,
					type = 'toggle',
					order = 2,
					get = 'GetOption',
					set = 'SetOption',
				},
				notifyBreak = {
					name = L.OAVBroken,
					desc = L.OVNotifyBreakDesc,
					type = 'toggle',
					order = 3,
					get = 'GetOption',
					set = 'SetOption',
				},
				notifyCDExpire = {
					name = L.OAVCDExpired,
					desc = L.OVNotifyCDExpireDesc,
					type = 'toggle',
					order = 4,
					get = 'GetOption',
					set = 'SetOption',
				},
			},
		},
		advanced = {
			name = L.Advanced,
			desc = L.AdvancedDesc,
			type = 'group',
			order = 9,
			args = {
				warning = {
					name = L.AdvancedWarning,
					type = 'description',
					order = 1,
				},
				timerUpdateRate = {
					name = L.TimerUpdateRate,
					desc = L.TimerUpdateRateDesc,
					type = 'range',
					order = 2,
					min = 0.01,
					max = 0.25,
					step = 0.01,
					bigStep = 0.01,
					get = 'GetOption',
					set = 'SetOption',
				},
				secondaryScan = {
					name = L.SecondaryScan,
					desc = L.SecondaryScanDesc,
					type = 'toggle',
					order = 3,
					get = 'GetOption',
					set = 'SetOption',
				},
				secondaryScanRate = {
					name = L.SecondaryScanRate,
					desc = L.SecondaryScanRateDesc,
					type = 'range',
					order = 4,
					min = 0.5,
					max = 2.0,
					step = 0.1,
					bigStep = 0.1,
					get = 'GetOption',
					set = 'SetOption',
				},
			},
		},
	},
}

-- INITIAL LOADER------------------------------------------

function Ellipsis:LoadOptions()
	-- Insert profiling options into the options tables
	options.args.profiles = LibStub('AceDBOptions-3.0'):GetOptionsTable(self.db)
	options.args.profiles.order = 8

	-- Configure LibSink
	options.args.outputVisual.args.outputTo = self:GetSinkAce3OptionsDataTable()
	options.args.outputVisual.args.outputTo.name = L.OVOutputTo
	options.args.outputVisual.args.outputTo.desc = L.OVOutputToDesc

	-- Setup the options table and add to blizzard gui
	LibStub('AceConfig-3.0'):RegisterOptionsTable('Ellipsis', options)
	self.optFrame = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('Ellipsis', 'Ellipsis')

	-- Register profiling callbacks
	self.db.RegisterCallback(self, 'OnProfileChanged', 'ApplyConfigSettings')
	self.db.RegisterCallback(self, 'OnProfileCopied', 'ApplyConfigSettings')
	self.db.RegisterCallback(self, 'OnProfileDeleted', 'ApplyConfigSettings')
	self.db.RegisterCallback(self, 'OnProfileReset', 'ApplyConfigSettings')
end

-- SAMPLE TIMERS ------------------------------------------

function Ellipsis:SampleTimers()
	local time = GetTime()

	if (self:GetActiveGUIDS()['sample1']) then self:DestroyTarget('sample1') end
	if (self:GetActiveGUIDS()['sample2']) then self:DestroyTarget('sample2') end
	if (self:GetActiveGUIDS()['sample3']) then self:DestroyTarget('sample3') end

	if (self:GetActiveCDTimers()[format(L.SampleTimer, 1)]) then self:DestroyCDTimer(format(L.SampleTimer, 1)) end
	if (self:GetActiveCDTimers()[format(L.SampleTimer, 2)]) then self:DestroyCDTimer(format(L.SampleTimer, 2)) end
	if (self:GetActiveCDTimers()[format(L.SampleTimer, 3)]) then self:DestroyCDTimer(format(L.SampleTimer, 3)) end
	if (self:GetActiveCDTimers()[format(L.SampleTimer, 4)]) then self:DestroyCDTimer(format(L.SampleTimer, 4)) end

	if (IsShiftKeyDown()) then return end

	self:CreateTarget('sample1', 'sample1', time, format(L.SampleTarget, 1), 68, nil, nil, nil)
	self:CreateTarget('sample2', 'sample2', time + 1, format(L.SampleTarget, 2), 69, nil, nil, nil)
	self:CreateTarget('sample3', 'sample3', time + 2, format(L.SampleTarget, 3), '??', nil, nil, nil)

	for x = 1, 3 do
		self:CreateTimer('sample' .. x, 1, format(L.SampleTimer, 1), 'Interface\\Icons\\Ability_Seal', 0, 30, time + 30, time)
		self:CreateTimer('sample' .. x, 2, format(L.SampleTimer, 2), 'Interface\\Icons\\Ability_Seal', 0, 30, time + 29.8, time)
		self:CreateTimer('sample' .. x, 3, format(L.SampleTimer, 3), 'Interface\\Icons\\Ability_Seal', 0, 30, time + 29.6, time)
		self:CreateTimer('sample' .. x, 4, format(L.SampleTimer, 4), 'Interface\\Icons\\Ability_Seal', 0, 30, time + 29.4, time)
	end

	self:CreateCDTimer(format(L.SampleTimer, 1), 'Interface\\Icons\\Ability_Seal', 15, time, time, 5)
	self:CreateCDTimer(format(L.SampleTimer, 2), 'Interface\\Icons\\Ability_Seal', 30, time, time, 6)
	self:CreateCDTimer(format(L.SampleTimer, 3), 'Interface\\Icons\\Ability_Seal', 120, time, time, 7)
	self:CreateCDTimer(format(L.SampleTimer, 4), 'Interface\\Icons\\Ability_Seal', 60, time, time, 7)
end

-- DNT LIST FUNCTIONS -------------------------------------

function Ellipsis:GetDNTList(info)
	local entries = {}
	for k in pairs(self.db.profile.doNotTrack) do entries[k] = k end
	table.sort(entries)
	return entries
end

function Ellipsis:GetCDDNTList(info)
	local entries = {}
	for k in pairs(self.db.profile.cdDoNotTrack) do entries[k] = k end
	table.sort(entries)
	return entries
end

function Ellipsis:SetDNTAddition(info, value)
	self:DoNotTrackAddition(value) -- call the main dnt addition function (takes different params)
end

function Ellipsis:SetCDDNTAddition(info, value)
	self:CooldownDoNotTrackAddition(value) -- call the main dnt addition function (takes different params)
end

function Ellipsis:RemoveDNTEntry(info, value)
	if (self.db.profile.doNotTrack[value]) then
		self.db.profile.doNotTrack[value] = nil
		self:Print(format(L.DNTWillTrack, value))
	end

	self:ApplyConfigSettings()
end

function Ellipsis:RemoveCDDNTEntry(info, value)
	if (self.db.profile.cdDoNotTrack[value]) then
		self.db.profile.cdDoNotTrack[value] = nil
		self:Print(format(L.CDDNTWillTrack, value))
	end

	self:ApplyConfigSettings()
end

-- TARGET DISPLAY FUNCTIONS -------------------------------

do
	local targetDisplay = {
		['all'] = {false, false, false, false},
		['alltarget'] = {true, false, false, false},
		['allfocus'] = {false, true, false, false},
		['allboth'] = {true, true, false, false},
		['target'] = {true, false, true, false},
		['focus'] = {false, true, false, true},
		['both'] = {true, true, true, true},
	}

	function Ellipsis:GetConfigTargetDisplay(info)
		local sT, sF, sTO, sFO = self.db.profile.sortTarget, self.db.profile.sortFocus, self.db.profile.showTargetOnly, self.db.profile.showFocusOnly

		for k, v in pairs(targetDisplay) do
			if (v[1] == sT and v[2] == sF and v[3] == sTO and v[4] == sFO) then
				return k
			end
		end
	end

	function Ellipsis:SetConfigTargetDisplay(info, value)
		self.db.profile.sortTarget = targetDisplay[value][1]
		self.db.profile.sortFocus = targetDisplay[value][2]
		self.db.profile.showTargetOnly = targetDisplay[value][3]
		self.db.profile.showFocusOnly = targetDisplay[value][4]
		self:ApplyConfigSettings()
	end
end

-- BASE OPTION GETTERS ------------------------------------

function Ellipsis:GetOption(info)
	return self.db.profile[info[#info]]
end

function Ellipsis:GetOptionColour(info)
	local optTable = self.db.profile[info[#info - 1]][info[#info]]
	return optTable[1], optTable[2], optTable[3]
end

function Ellipsis:GetOptionTransparentColour(info)
	local optTable = self.db.profile[info[#info - 1]][info[#info]]
	return optTable[1], optTable[2], optTable[3], optTable[4]
end

function Ellipsis:GetProminenceOption(info)
	return self.db.profile.prominentItems[info[#info]]
end

function Ellipsis:GetSoundOption(info)
	return self.db.profile.sounds[info[#info]]
end

-- BASE OPTION SETTERS ------------------------------------

function Ellipsis:SetOption(info, value)
	self.db.profile[info[#info]] = value
	self:ApplyConfigSettings()
end

function Ellipsis:SetOptionColour(info, r, g, b)
	local optTable = self.db.profile[info[#info - 1]][info[#info]]
	optTable[1], optTable[2], optTable[3] = r, g, b

	self:ApplyConfigSettings()
end

function Ellipsis:SetOptionTransparentColour(info, r, g, b, a)
	local optTable = self.db.profile[info[#info - 1]][info[#info]]
	optTable[1], optTable[2], optTable[3], optTable[4] = r, g, b, a

	self:ApplyConfigSettings()
end

function Ellipsis:SetProminenceOption(info, value)
	self.db.profile.prominentItems[info[#info]] = value
	self:ApplyConfigSettings()
end

function Ellipsis:SetSoundOption(info, value)
	self.db.profile.sounds[info[#info]] = value
	PlaySoundFile(Media:Fetch('sound', value))
end
