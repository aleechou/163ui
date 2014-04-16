﻿--GAME_LOCALE = UnitName("player") == "Cybeloras" and "zhCN" --FOR TESTING
local L = LibStub("AceLocale-3.0"):NewLocale("TellMeWhen", "enUS", true)

-- WARNING! DO NOT EXPECT TO FIND ANY DECENT LEVEL OF ORGANIZATION IN THIS FILE, BECAUSE IT SIMPLY DOES NOT EXIST. MOVE ALONG.

L["!!Main Addon Description"] = "Provides visual, auditory, and textual notifications about cooldowns, buffs, and pretty much everything else." -- put it here so it doesnt get deleted on mass imports


L["CMD_OPTIONS"] = "options"
L["CMD_ENABLE"] = "enable"
L["CMD_DISABLE"] = "disable"
L["CMD_TOGGLE"] = "toggle"
L["CMD_PROFILE"] = "profile"

L["CMD_PROFILE_INVALIDPROFILE"] = "No profile named %q exists!"
L["CMD_PROFILE_INVALIDPROFILE_SPACES"] = "Tip: If the profile name contains spaces, put quotes around it."

L["PROFILE_LOADED"] = "Loaded profile: %s"


L["ICON_TOOLTIP2NEW"] = [[|cff7fffffRight-click|r for icon options.
|cff7fffffRight-click and drag|r to another icon to move/copy.
|cff7fffffDrag|r spells or items onto the icon for quick setup.]]
L["ICON_TOOLTIP2NEWSHORT"] = [[|cff7fffffRight-click|r for icon options.]]
L["LDB_TOOLTIP1"] = "|cff7fffffLeft-click|r to toggle the group locks"
L["LDB_TOOLTIP2"] = "|cff7fffffRight-click|r to show the main TMW options"
L["LOADERROR"] = "TellMeWhen_Options could not be loaded: "
L["LOADINGOPT"] = "Loading TellMeWhen_Options."
L["ENABLINGOPT"] = "TellMeWhen_Options is disabled. Enabling..."
L["CONFIGMODE"] = "TellMeWhen is in configuration mode. Icons will not be functional until you leave configuration mode. Type '/tellmewhen' or '/tmw' to toggle configuration mode on and off."
L["CONFIGMODE_EXIT"] = "Exit config mode"
L["CONFIGMODE_NEVERSHOW"] = "Don't show again"
L["IMPORT_SUCCESSFUL"] = "Import successful!"
L["IMPORTERROR_INVALIDTYPE"] = "Attempted to import data of an unknown type. Check to see if you have the latest version of TellMeWhen installed."
L["IMPORTERROR_FAILEDPARSE"] = "There was an error processing the string. Ensure that you copied the entire string from the source."
L["ERROR_MISSINGFILE"] = [[A complete restart of WoW is required to use TellMeWhen %s:

%s was not found.

Would you like to restart WoW now?]]
L["ERROR_MISSINGFILE_REQFILE"] = "A required file"
L["ERROR_MISSINGFILE_NOREQ"] = [[A complete restart of WoW may be required to fully use TellMeWhen %s:

%s was not found.

Would you like to restart WoW now?]]
L["ERROR_ANCHORSELF"] = "%s was trying to anchor to itself, so TellMeWhen reset it's anchor to the center of the screen to prevent catastrophic failure."

L["ERROR_NO_LOCKTOGGLE_IN_LOCKDOWN"] = "Cannot unlock TellMeWhen in combat if the %q option isn't enabled (type '/tmw options')."
L["ERROR_ACTION_DENIED_IN_LOCKDOWN"] = "Cannot do that in combat if the %q option isn't enabled (type '/tmw options')."

L["ERROR_NOTLOADED_ERROR"] = "TellMeWhen has failed to load! Are you missing a required library?"
L["ERROR_NOTINITIALIZED_NO_LOAD"] = "TellMeWhen_Options cannot be loaded if TellMeWhen failed to initialize!"
L["ERROR_NOTINITIALIZED_NO_ACTION"] = "TellMeWhen cannot perform that action if the addon failed to initialize!"
L["ERROR_NOOPTIONSLOAD_INCOMBAT"] = [[Cannot load TellMeWhen's options while in combat if the %q option isn't enabled.

They will automatically be loaded when you leave combat if this window is still open.]]
L["ERROR_NOTINITIALIZED_INTERFACEPANEL_EXPLANATION"] = [[It looks like TellMeWhen has failed to initialize.

Because of this, TellMeWhen will not be able to function, and you will not be able to configure any of its settings.

If you saw a message when you logged in that said that a complete restart of WoW is required to use TMW, then please do so.

If you did not see that message, then please enable Lua errors (%s > %s > %s) if you have not already, reload your UI, and post any errors that you get that mention TellMeWhen to a ticket at http://wow.curseforge.com/addons/tellmewhen/create-ticket/

I apologize for the inconvenience, but this is a rare occurrence, and any information about it that you can provide will help to get it fixed right away!

Thank you for using TellMeWhen!]]

L["ERROR_GAMEMENU_INTERFACE_OPTIONS_FUCKED"] = [[TellMeWhen's options have successfully loaded, but something happened that is preventing them from being displayed here correctly.

Try closing the interface options (this window) and reopening them.

If that doesn't work, then you can still access TellMeWhen's options by typing "/tmw options"

Sorry about the inconvenience!]]



L["ERROR_INVALID_SPELLID"] = "%s is checking an invalid spellID: %s. Please remove it to avoid undesired icon behavior."

L["SAFESETUP_TRIGGERED"] = "Running safe & slow setup..."
L["SAFESETUP_COMPLETE"] = "Safe & slow setup complete."
L["SAFESETUP_FAILED"] = "Safe & slow setup FAILED: %s"

L["LOCKED"] = "Locked"
L["RESIZE"] = "Resize"
L["RESIZE_TOOLTIP"] = [[|cff7fffffClick-and-drag|r to resize]] -- keep this like this, used by the icon editor
L["RESIZE_TOOLTIP_SCALEXY"] = [[|cff7fffffClick-and-drag|r to resize
|cff7fffffHold Control|r to invert scale axis]]
L["RESIZE_TOOLTIP_SCALEY_SIZEX"] = [[|cff7fffffClick-and-drag|r to resize]]

L["CONDITIONORMETA_CHECKINGINVALID"] = "Warning! Group %d, Icon %d is checking an invalid icon (Group %d, Icon %d)"
L["CONDITIONORMETA_CHECKINGINVALID_GROUP"] = "Warning! Group %d is checking an invalid icon (Group %d, Icon %d)"
L["WARN_DRMISMATCH"] = [[Warning! You are checking the diminishing returns on spells from two different known categories.

All spells must be from the same diminishing returns category for the icon to function properly. The following categories and spells were detected:]]
L["FROMNEWERVERSION"] = "You are importing data that was created in a newer version of TellMeWhen than your version. Some settings might not work until you upgrade to the latest version."

-- -------------
-- ICONMENU
-- -------------

L["ICONMENU_CHOOSENAME2"] = "Choose spell(s) to check"

L["ICONMENU_CHOOSENAME_WPNENCH"] = "Choose enchant(s) to check"
L["ICONMENU_CHOOSENAME_WPNENCH_DESC"] = [=[Enter the name(s) the weapon enchants you want this icon to monitor. You can add multiple entries by separating them with semicolons (;).

|cFFFF5959IMPORTANT|r: Enchant names must be entered exactly as they appear on the tooltip of your weapon while the enchant is active (e.g. "%s", not "%s").]=]

L["ICONMENU_CHOOSENAME_ITEMSLOT2"] = "Choose item(s) to check"
L["ICONMENU_CHOOSENAME_ITEMSLOT_DESC"] = [=[Enter the Name, ID, or equipment slot of what you want this icon to monitor. You can add multiple entries (any combination of names, IDs, and equipment slots) by separating them with semicolons (;).

Equipment slots are numbered indexes that correspond to an equipped item. If you change the item equipped in that slot, the icon will reflect that.

|cff7fffffShift-click|r items and chat links or drag items to insert them into this editbox.]=]

L["ICONMENU_CHOOSENAME_MULTISTATE"] = "Choose spell to check"
L["ICONMENU_CHOOSENAME_ORBLANK"] = "|cff7fffffOR|r leave blank to track all"
L["ICONMENU_ENABLE"] = "Enabled"
L["ICONMENU_ENABLE_DESC"] = "Icons will only function when they are enabled."
--L["CHOOSENAME_EQUIVS_TOOLTIP"] = [[You can select predefined sets of buffs, debuffs, spell casts, diminishing returns, or dispel types (Magic, Curse, etc.) from this menu to insert into the "%s" editbox.]]
L["CHOOSENAME_DIALOG_DDDEFAULT"] = "Predefined Spell Sets/Dispel Types"
L["CHOOSENAME_DIALOG"] = [=[Enter the Name or ID of what you want this icon to monitor. You can add multiple entries (any combination of names, IDs, and equivalencies) by separating them with semicolons (;).

|cff7fffffShift-click|r spells/items/chat links or drag spells/items to insert them into this editbox.]=]
L["CHOOSENAME_DIALOG_PETABILITIES"] = "|cFFFF5959PET ABILITIES|r must use SpellIDs."
L["CHOOSENAME_DIALOG_MSCD"] = [=[Enter the Name or ID of what you want this icon to monitor. Only the first spell/item will be checked - semicolon-delimited lists are not valid for this icon type.]=]

L["CHOOSEICON"] = "Choose an icon to check"
L["CHOOSEICON_DESC"] = [=[|cff7fffffClick|r to choose an icon/group.
|cff7fffffLeft-Click and drag|r to rearrange.
|cff7fffffRight-Click and drag|r to swap.]=]

L["ICONMENU_ALPHA"] = "Opacity"
L["CONDITIONALPHA"] = "Failed Conditions/Reqs."
L["CONDITIONALPHA_DESC"] = "This will be used when conditions fail, or if the duration or stack requirements are not met. This setting will be ignored if the icon is already hidden by the other two opacity settings."
L["CONDITIONALPHA_CONDITIONICON"] = "Failed Duration"
L["CONDITIONALPHA_CONDITIONICON_DESC"] = "This will be used when the duration requirements are not met. This setting will be ignored if the icon is already hidden by the other two opacity settings."
L["CONDITIONALPHA_METAICON"] = "Failed Conditions"
L["CONDITIONALPHA_METAICON_DESC"] = [[This opacity will be used when conditions fail.

Conditions can be configured in the %q tab.]]

L["REQFAILED_ALPHA"] = "Opacity when failed"
L["DURATIONALPHA_DESC"] = "Set the opacity level that the icon should display at when these duration requirements fail."
L["STACKALPHA_DESC"] = "Set the opacity level that the icon should display at when these stack requirements fail."


L["ICONMENU_TYPE"] = "Icon type"

L["ICONMENU_SPELLCOOLDOWN"] = "Spell Cooldown"
L["ICONMENU_SPELLCOOLDOWN_DESC"] = [[Tracks the cooldowns of spells from your spellbook.]]

L["ICONMENU_SWINGTIMER"] = "Swing Timer"
L["ICONMENU_SWINGTIMER_SWINGING"] = "Swinging"
L["ICONMENU_SWINGTIMER_NOTSWINGING"] = "Not Swinging"
L["ICONMENU_SWINGTIMER_DESC"] = [[Tracks the swing timers of your main hand and off hand weapons.]]
L["ICONTYPE_SWINGTIMER_TIP"] = [[Looking to track the timer of your %s? The %q icon type has the functionality that you desire. Simply set a %s to track %q (spellID %d)!

You may also click the button below to automatically apply the proper settings.]]
L["ICONTYPE_SWINGTIMER_TIP_APPLYSETTINGS"] = "Apply %s Settings"

L["ICONMENU_ITEMCOOLDOWN"] = "Item Cooldown"
L["ICONMENU_ITEMCOOLDOWN_DESC"] = [[Tracks the cooldowns of items with Use effects.]]

L["ICONMENU_BUFFDEBUFF"] = "Buff/Debuff"
L["ICONMENU_BUFFDEBUFF_DESC"] = [[Tracks buffs and/or debuffs.]]

L["ICONMENU_BUFFCHECK"] = "Buff/Debuff Check"
L["ICONMENU_BUFFCHECK_DESC"] = [[Checks if a buff is absent from any unit that you check.

Use this icon type to check for missing raid buffs.

Most other situations should use the %q icon type.]]

L["ICONMENU_REACTIVE"] = "Reactive Ability"
L["ICONMENU_REACTIVE_DESC"] = [[Tracks the usability of reactive abilities.

Reactive abilities are things like %s, %s, and %s - abilities that are only usable when certain conditions are met.]]

L["ICONMENU_WPNENCHANT"] = "Weapon Enchant"
L["ICONMENU_WPNENCHANT_DESC"] = [=[Tracks temporary weapon enchants.]=]

L["ICONMENU_TOTEM"] = "Totem"
L["ICONMENU_TOTEM_DESC"] = [[Tracks your totems.]]
L["ICONMENU_GHOUL"] = "Non-%s ghoul"
L["ICONMENU_GHOUL_DESC"] = [[Tracks your ghoul if you don't have the %s talent.]]
L["ICONMENU_RUNEOFPOWER_DESC"] = [[Tracks the runes from the %s talent.]]
L["ICONMENU_MUSHROOMS"] = "%s"
L["ICONMENU_MUSHROOMS_DESC"] = [[Tracks a %s.]]

L["ICONMENU_MULTISTATECD"] = "Multi-state Ability"
L["ICONMENU_MULTISTATECD_DESC"] = [[Tracks an ability with multiple states.

This should be used when you want to track the multiple states and textures of a cooldown such as %s or %s.]]


L["ICONMENU_UNITCOOLDOWN"] = "Unit Cooldown"
L["ICONMENU_UNITCOOLDOWN_DESC"] = [[Tracks the cooldowns of someone else.

%s can be tracked using %q as the name.]]

L["ICONMENU_ICD"] = "Internal Cooldown"
L["ICONMENU_ICD_DESC"] = [=[Tracks the cooldown of a proc or a similar effect.

|cFFFF5959IMPORTANT|r: See the tooltips under the %q settings for how to track each internal cooldown type.]=]

L["ICONMENU_CAST"] = "Spell Cast"
L["ICONMENU_CAST_DESC"] = [=[Tracks spell casts and channels.]=]

L["ICONMENU_CNDTIC"] = "Condition Icon"
L["ICONMENU_CNDTIC_DESC"] = [=[Tracks the state of conditions.]=]
L["ICONMENU_CNDTIC_ICONMENUTOOLTIP"] = "(%d |4Condition:Conditions;)"

L["ICONMENU_DR"] = "Diminishing Returns"
L["ICONMENU_DR_DESC"] = [=[Tracks the length and extent of diminishing returns.]=]

--L["ICONMENU_LIGHTWELL"] = "Lightwell" -- defined in static formats
L["ICONMENU_LIGHTWELL_DESC"] = [=[Tracks the duration and charges of your %s.]=]

L["ICONMENU_RUNES"] = "Rune Cooldown"
L["ICONMENU_RUNES_DESC"] = [[Tracks rune cooldowns]]
L["ICONMENU_RUNES_CHARGES"] = "Unusable runes as charges"
L["ICONMENU_RUNES_CHARGES_DESC"] = "Enable this setting to cause the icon to treat any runes that are cooling down as an extra charge (shown in the cooldown sweep) when the icon is displaying a usable rune."

L["ICONMENU_CLEU"] = "Combat Event"
L["ICONMENU_CLEU_DESC"] = [=[Tracks combat events.

Examples include spell reflects, misses, instant casts, and deaths, but the icon can track virtually anything.]=]

L["ICONMENU_META"] = "Meta Icon"
L["ICONMENU_META_DESC"] = [=[Combines multiple icons into one.

Icons that have %q checked will still be shown in a meta icon if they would otherwise be shown.]=]
L["ICONMENU_META_ICONMENUTOOLTIP"] = "(%d |4Icon:Icons;)"

L["ICONMENU_META_INHERITANCEBEHAVIOR"] = "Advanced Inheritance Behavior"
L["ICONMENU_META_INHERITANCEBEHAVIOR_CNDTALPHA"] = "Inherit failed condition opacity"
L["ICONMENU_META_INHERITANCEBEHAVIOR_CNDTALPHA_DESC"] = [[By default, meta icons will not inherit the opacity of an icon that results from its conditions failing (unless that opacity caused the icon to be hidden).

Enable this setting to override that behavior and inherit the failed condition opacity from the icon the meta icon is inheriting from.

Please note that if you enable this setting and this meta icon is checking conditions of its own, those conditions will have no effect.]]
L["ICONMENU_META_INHERITANCEBEHAVIOR_CNDTALPHA_HELP"] = [[Hi there!

I just wanted to make sure that you are aware that the conditions of this meta icon will not function when this setting is enabled - they will yield to the conditions of the inherited icon.

That's all. Have fun configuring TMW!]]


L["ICONTYPE_DEFAULT_HEADER"] = "Instructions"
L["ICONTYPE_DEFAULT_INSTRUCTIONS"] = [[To get started configuring this icon, select an icon type from the %q dropdown menu above.

Remember that icons will only work when TellMeWhen is in its locked state, so type '/tmw' when you are finished with configuration.


As you configure TellMeWhen, make sure to read the tooltips for each setting. These tooltips often contain important information about the how the setting works!]]





L["ICONMENU_SHOWWHEN"] = "Show States & Opacity"
L["ICONMENU_SHOWWHEN_SHOWWHEN_WRAP"] = "Show when %s|r"
L["ICONMENU_SHOWWHEN_OPACITYWHEN_WRAP"] = "Opacity when %s|r"
L["ICONMENU_SHOWWHEN_SHOW_GENERIC_DESC"] = "Set whether this icon should show for this icon state."
L["ICONMENU_SHOWWHEN_OPACITY_GENERIC_DESC"] = "Set the opacity level that the icon should show at in this icon state."
L["ICONMENU_USABLE"] = "Usable"
L["ICONMENU_UNUSABLE"] = "Unusable"


L["ICONMENU_COUNTING"] = "Timer running"
L["ICONMENU_COUNTING_DESC"] = "Show the icon when the icon's timer is active."
L["ICONMENU_NOTCOUNTING"] = "Timer not running"
L["ICONMENU_NOTCOUNTING_DESC"] = "Show the icon when the icon's timer is not active."


L["ICONMENU_BUFFTYPE"] = "Buff or Debuff"
L["ICONMENU_BUFF"] = "Buff"
L["ICONMENU_DEBUFF"] = "Debuff"
L["ICONMENU_BOTH"] = "Either"

L["ICONMENU_CHECKNEXT"] = "Expand sub-metas"
L["ICONMENU_CHECKNEXT_DESC"] = [[Checking this box will cause this icon to expand all the icons of any meta icons that it might be checking at any level instead of just checking sub-meta icons as if they were just another normal icon.

In addition, this icon will not show any icons that have already been shown by another meta icon that updates before this one. Update order can be changed in the main and group options.]]

L["ICONMENU_DISPEL"] = "Dispel Type"
L["ICONMENU_CASTS"] = "Spell Casts"
L["ICONMENU_DRS"] = "Diminishing Returns"

L["ICONMENU_CUSTOMTEX"] = "Custom Texture"
L["ICONMENU_CUSTOMTEX_DESC"] = [[If you want to override the texture shown by this icon, enter the Name or ID of the spell that has the texture that you want to use.

You may also enter a texture path, such as 'Interface/Icons/spell_nature_healingtouch', or just 'spell_nature_healingtouch' if the path is 'Interface/Icons'

You can view a list of dynamic textures by typing "$" (dollar sign; ALT-36) in this box.

You can use your own textures too as long as they are placed in WoW's directory (set this field to the path to the texture relative to WoW's root folder), are .tga or .blp format, and have dimensions that are powers of 2 (32, 64, 128, etc)]]

L["ICONMENU_CUSTOMTEX_MOPAPPEND_DESC"] = [[If this texture is showing as solid green, and your custom texture is in WoW's root folder, then please move it into a subdirectory of WoW's root and update the setting here accordingly to allow it to work correctly. If the custom texture is set to a spell, and it is either a spell name or a spell that no longer exists, then you should try and change it to a spellID of a spell that does exist.]]

L["ICONMENU_BINDTEXT_DESC"] = [[Any text in this editbox will be shown on the icon where the keybinding is normally displayed on an action bar. This does NOT set a keybinding to this TellMeWhen icon. It is simply a visual reminder that will be shown on the icon. The text can be configured in this group's settings.]]


L["SUG_SUBSTITUTION_t"] = "Target's Name"
L["SUG_SUBSTITUTION_t_DESC"] = "Name of the unit you are currently targeting"
L["SUG_SUBSTITUTION_f"] = "Focus's Name"
L["SUG_SUBSTITUTION_f_DESC"] = "Name of the unit you currently have focused"
L["SUG_SUBSTITUTION_m"] = "Mouseover's Name"
L["SUG_SUBSTITUTION_m_DESC"] = "Name of the unit you are currently mousing over"
L["SUG_SUBSTITUTION_p"] = "Previous Unit"
L["SUG_SUBSTITUTION_p_DESC"] = "Name of the unit that was checked before the current unit"
L["SUG_SUBSTITUTION_u"] = "Current Unit"
L["SUG_SUBSTITUTION_u_DESC"] = "Name of current unit being checked"
L["SUG_SUBSTITUTION_s"] = "Current Spell/Item/Etc"
L["SUG_SUBSTITUTION_s_DESC"] = "Name of the current spell/item/etc being checked"
L["SUG_SUBSTITUTION_d"] = "Duration Remaining"
L["SUG_SUBSTITUTION_d_DESC"] = "The duration remaining on the icon's timer"
L["SUG_SUBSTITUTION_k"] = "Current Stacks"
L["SUG_SUBSTITUTION_k_DESC"] = "Whatever is currently displayed as the icon's stack text"
L["SUG_SUBSTITUTION_o"] = "Source Unit"
L["SUG_SUBSTITUTION_o_DESC"] = "Whatever unit caused the action in the last combat event that the icon handled."
L["SUG_SUBSTITUTION_e"] = "Destination Unit"
L["SUG_SUBSTITUTION_e_DESC"] = "Whatever unit received the action in the last combat event that the icon handled."
L["SUG_SUBSTITUTION_x"] = "Extra Spell"
L["SUG_SUBSTITUTION_x_DESC"] = "Combat events like dispels, interrupts, and aura breaking have additional data about which spell caused the event. This will substitute in that spell from the last combat log event."

L["ICONMENU_COMPONENTICONS"] = "Component Icons & Groups"


L["ICONMENU_UNITSTOWATCH"] = "Unit(s) to watch"
L["ICONMENU_UNITS"] = "Units"
L["ICONMENU_UNIT_DESC"] = [[Enter the units to watch in this box. Units can be inserted from the suggestion list at the right, or advanced users can type in their own units.

Standard units (e.g. player) and/or the names of players you are grouped with (e.g. %s) may be used as units.

Separate multiple units with semicolons (;).

For more information about units, go to http://www.wowpedia.org/UnitId]]
L["ICONMENU_UNIT_DESC_CONDITIONUNIT"] = [[Enter the unit to watch in this box. Unit can be inserted from the suggestion list at the right, or advanced users can type in their own unit.

Standard units (e.g. player) and/or the names of players you are grouped with (e.g. %s) may be used.

For more information about units, go to http://www.wowpedia.org/UnitId]]
L["ICONMENU_UNIT_DESC_UNITCONDITIONUNIT"] = [[Enter the unit to watch in this box. Unit can be inserted from the suggestion list at the right.

"unit" is an alias for each unit that the icon is checking.]]
L["ICONMENU_FOCUS"] = "Focus"
L["ICONMENU_TARGETTARGET"] = "Target's target"
L["ICONMENU_FOCUSTARGET"] = "Focus' target"
L["ICONMENU_PETTARGET"] = "Pet's target"
L["ICONMENU_MOUSEOVER"] = "Mouseover"
L["ICONMENU_MOUSEOVERTARGET"] = "Mouseover's target"
L["ICONMENU_VEHICLE"] = "Vehicle"
L["MAINTANK"] = "Main Tank"
L["MAINASSIST"] = "Main Assist"

L["ICONMENU_CHOSEICONTOEDIT"] = "Choose an icon to edit:"
L["ICONMENU_CHOSEICONTODRAGTO"] = "Choose an icon to drag to:"

L["ICONMENU_PRESENT"] = "Present"
L["ICONMENU_ABSENT"] = "Absent"
--L["ICONMENU_ALWAYS"] = "Always"

L["ICONMENU_ABSENTONANY"] = "Any Absent"
L["ICONMENU_ABSENTONANY_DESC"] = "Set the icon opacity level for when any unit being checked is missing all of the buffs/debuffs being checked."
L["ICONMENU_PRESENTONALL"] = "All Present"
L["ICONMENU_PRESENTONALL_DESC"] = "Set the icon opacity level for when all units being checked have at least one of the buffs/debuffs being checked."

L["ICONMENU_PRESENTONANY"] = "Any Present"
L["ICONMENU_PRESENTONANY_DESC"] = "Set the icon opacity level for when any unit being checked has at least one of the buffs/debuffs being checked."
L["ICONMENU_ABSENTONALL"] = "All Absent"
L["ICONMENU_ABSENTONALL_DESC"] = "Set the icon opacity level for when all units being checked are missing all of the buffs/debuffs being checked."

L["ICONMENU_CNDTSHOWWHEN"] = "Show when conditions"
L["ICONMENU_FAIL2"] = "Conditions Fail"
L["ICONMENU_SUCCEED2"] = "Conditions Succeed"
L["ICONMENU_ONFAIL"] = "On Fail"
L["ICONMENU_ONSUCCEED"] = "On Succeed"

L["ICONMENU_CASTSHOWWHEN"] = "Show when a cast is"
L["ICONMENU_ONLYINTERRUPTIBLE"] = "Only Interruptible"
L["ICONMENU_ONLYINTERRUPTIBLE_DESC"] = "Check this box to only show spell casts that are interruptible"

L["ICONMENU_ONLYMINE"] = "Only check mine"
L["ICONMENU_ONLYMINE_DESC"] = "Check this option to cause this icon to only check for buffs/debuffs that you casted"
L["ICONMENU_SHOWTIMER"] = "Show timer"
L["ICONMENU_SHOWTIMER_DESC"] = "Check this option to display the standard cooldown sweep animation on the icon."
L["ICONMENU_SHOWTIMERTEXT"] = "Show timer text"
L["ICONMENU_SHOWTIMERTEXT_DESC"] = [[Check this option to display a textual display of the remaining cooldown/duration on the icon.

This is only applicable if OmniCC (or similar) is installed.]]
L["ICONMENU_SHOWTIMERTEXT_NOOCC"] = "Show ElvUI timer text"
L["ICONMENU_SHOWTIMERTEXT_NOOCC_DESC"] = [[Check this option to display ElvUI's textual display of the remaining cooldown/duration on the icon.

This setting only affects ElvUI's timer. If you have another addon that provides timers (like OmniCC), you can control those timers with the %q setting. It is not recommended to have both of these settings enabled.]]
L["ICONMENU_ALLOWGCD"] = "Allow Global Cooldown"
L["ICONMENU_ALLOWGCD_DESC"] = [[Check this option to allow the timer to react to and show the global cooldown instead of simply ignoring it.]]

L["ICONMENU_SHOWPBAR_DESC"] = "Shows a bar that is overlaid across the top half of the icon that will indicate the power still needed to cast the spell (or the power that you have when 'Fill bars up' is checked)"
L["ICONMENU_SHOWCBAR_DESC"] = "Shows a bar that is overlaid across the bottom half of the icon that will indicate the cooldown/duration remaining (or the time that has passed if 'Fill bars up' is checked)"
L["ICONMENU_INVERTBARS"] = "Fill bar up"
L["ICONMENU_INVERTCBAR_DESC"] = "Check this option to cause the overlay bar to fill up to cover the whole width of the icon as duration reaches zero."
L["ICONMENU_INVERTPBAR_DESC"] = "Check this option to cause the overlay bar to fill up to cover the whole width of the icon as power become sufficient."
L["ICONMENU_INVERTBARDISPLAYBAR_DESC"] = "Check this option to cause the bar to fill up to cover its whole width as duration reaches zero."
L["ICONMENU_OFFS"] = "Offset"
L["ICONMENU_FAKEMAX"] = "Artificial Maximum"
L["ICONMENU_FAKEMAX_DESC"] = [[Set an artificial maximum value for the timer.

You can use this setting to cause an entire group of icons to decay at the same rate, which can provide a visual indication of what timers will run out first.

Set to 0 to disable this setting.]]
L["ICONMENU_BAROFFS"] = [[This amount will be added to the bar in order to offset it.

Useful for custom indicators of when you should begin casting a spell to prevent a buff from falling off, or to indicate the power required to cast a spell and still have some left over for an interrupt.]]

L["ICONMENU_BAR_COLOR_START"] = "Start Color"
L["ICONMENU_BAR_COLOR_START_DESC"] = "Color of the bar when the cooldown/duration has just begun."
L["ICONMENU_BAR_COLOR_MIDDLE"] = "Halfway Color"
L["ICONMENU_BAR_COLOR_MIDDLE_DESC"] = "Color of the bar when the cooldown/duration is halfway complete."
L["ICONMENU_BAR_COLOR_COMPLETE"] = "Completion Color"
L["ICONMENU_BAR_COLOR_COMPLETE_DESC"] = "Color of the bar when the cooldown/duration is complete."
L["ICONMENU_ENABLECOLORS"] = "Enable Color Overrides"
L["ICONMENU_ENABLECOLORS_DESC"] = [[Check this setting to allow the configuration and usage of the three color settings below.

If left unchecked, the color settings in TellMeWhen's main options will be used.]]
L["ICONMENU_ENABLECOLORS_HELP"] = [[Hey there!

I just wanted to let you know that you can easily copy these colors to other bar-style icons by |cff7fffffright-clicking and dragging|r this icon to another.]]
L["ICONMENU_COPYCOLORS_BARDISPLAY"] = "Copy Bar Colors"
L["ICONMENU_COPYCOLORS_BARDISPLAY_DESC"] = "Copies the three bar colors of %s to %s."

L["ICONMENU_REACT"] = "Unit Reaction"
L["ICONMENU_FRIEND"] = "Friendly"
L["ICONMENU_HOSTILE"] = "Hostile"

L["ICONMENU_ISPLAYER"] = "Unit Is Player"

L["ICONMENU_ICDTYPE"] = "Cooldown begins on..."
L["ICONMENU_SPELLCAST_COMPLETE"] = "Spell Cast Finish/Instant Cast"
L["ICONMENU_SPELLCAST_START"] = "Spell Cast Start"
L["ICONMENU_ICDBDE"] = "Buff/Debuff/Damage/Energize/Summon"
L["ICONMENU_SPELLCAST_COMPLETE_DESC"] = [[Select this option if the internal cooldown begins when:

|cff7fffff1)|r You finish casting a spell, or
|cff7fffff2)|r You cast an instant cast spell.

You need to enter the name/ID of the spell cast that triggers the internal cooldown into the %q editbox.]]
L["ICONMENU_SPELLCAST_START_DESC"] = [[Select this option if the internal cooldown begins when:

|cff7fffff1)|r You start casting a spell.

You need to enter the name/ID of the spell cast that triggers the internal cooldown into the %q editbox.]]
L["ICONMENU_ICDAURA_DESC"] = [[Select this option if the internal cooldown begins when:

|cff7fffff1)|r A buff or debuff is applied by yourself (includes procs), or
|cff7fffff2)|r Damage is dealt, or
|cff7fffff3)|r You are energized with mana/rage/etc.
|cff7fffff4)|r You summon or create an object or NPC.

You need to enter, into the %q editbox, the spell name/ID of:

|cff7fffff1)|r The buff/debuff that you gain when the internal cooldown is triggered, or
|cff7fffff2)|r The spell that does damage (check your combat log), or
|cff7fffff3)|r The the energize effect (check your combat log), or
|cff7fffff4)|r The spell that triggered the summon (check your combat log).]]

L["ICONMENU_DRPRESENT"] = "Diminished"
L["ICONMENU_DRABSENT"] = "Undiminished"

L["TOTEMS"] = "Totems to check"
L["FIRE"] = "Fire"
L["EARTH"] = "Earth"
L["WATER"] = "Water"
L["AIR"] = "Air"
L["MUSHROOMS"] = "Mushrooms to check"
L["MUSHROOM"] = "Mushroom %d"
L["RUNESOFPOWER"] = "Runes to check"
L["RUNEOFPOWER"] = "Rune %d"
L["GENERICTOTEM"] = "Totem %d"
L["RUNES"] = "Rune(s) to check"

L["ICONMENU_SHOWTTTEXT"] = "Show variable text"
L["ICONMENU_SHOWTTTEXT_DESC"] = [[Check this to display the first variable associated with the aura that is being displayed. Practical uses include monitoring damage shield amounts.

This value will be reported and shown in place of the icon's stack count.

Numbers are provided by Blizzard API and do not necessarily match numbers found on the tooltip of the aura. In most practical cases, though, the correct number will be shown.]]
L["ICONMENU_RANGECHECK"] = "Range check"
L["ICONMENU_RANGECHECK_DESC"] = "Check this to enable changing the color of the icon when you are out of range."
L["ICONMENU_MANACHECK"] = "Power check"
L["ICONMENU_MANACHECK_DESC"] = "Check this to enable changing the color of the icon when you are out of mana/rage/runic power/etc."
L["ICONMENU_COOLDOWNCHECK"] = "Cooldown check"
L["ICONMENU_COOLDOWNCHECK_DESC"] = "Check this to cause the icon to be considered unusable if it is on cooldown."
L["ICONMENU_IGNORERUNES"] = "Ignore Runes"
L["ICONMENU_IGNORERUNES_DESC"] = "Check this to treat the cooldown as usable if the only thing hindering it is a rune cooldown (or a global cooldown)."
L["ICONMENU_IGNORERUNES_DESC_DISABLED"] = "You must enable the \"Cooldown check\" setting to enable the \"Ignore Runes\" setting."
L["ICONMENU_DONTREFRESH"] = "Don't Refresh"
L["ICONMENU_DONTREFRESH_DESC"] = "Check to force the cooldown to not reset if the trigger occurs while it is still counting down."
L["ICONMENU_CLEU_NOREFRESH"] = "Don't Refresh"
L["ICONMENU_CLEU_NOREFRESH_DESC"] = "Check to cause the icon to ignore events that happen while the icon's timer is active."

L["SORTBY"] = "Prioritize"
L["SORTBYNONE"] = "Normally"
L["SORTBYNONE_DURATION"] = "Normal Duration"
L["SORTBYNONE_STACKS"] = "Normal Stacks"
L["SORTBYNONE_DESC"] = [[If checked, spells will be checked in and appear in the order that they were entered into the "%s" editbox.

If this icon is a buff/debuff icon and the number of auras being checked exceeds the efficiency threshold setting, auras will be checked in the order that they would normally appear on the unit's unit frame.]]
L["SORTBYNONE_META_DESC"] = [[If checked, icons will be checked in the order that was configured above.]]
L["ICONMENU_SORTASC"] = "Low duration"
L["ICONMENU_SORTASC_DESC"] = "Check this box to prioritize and show spells with the lowest duration."
L["ICONMENU_SORTASC_META_DESC"] = "Check this box to prioritize and show icons with the lowest duration."
L["ICONMENU_SORTDESC"] = "High duration"
L["ICONMENU_SORTDESC_DESC"] = "Check this box to prioritize and show spells with the highest duration."
L["ICONMENU_SORTDESC_META_DESC"] = "Check this box to prioritize and show icons with the highest duration."

L["ICONMENU_SORT_STACKS_ASC"] = "Low stacks"
L["ICONMENU_SORT_STACKS_ASC_DESC"] = "Check this box to prioritize and show spells with the lowest stacks."
L["ICONMENU_SORT_STACKS_DESC"] = "High stacks"
L["ICONMENU_SORT_STACKS_DESC_DESC"] = "Check this box to prioritize and show spells with the highest stacks."

L["ICONMENU_MOVEHERE"] = "Move here"
L["ICONMENU_COPYHERE"] = "Copy here"
L["ICONMENU_SWAPWITH"] = "Swap with"
L["ICONMENU_ADDMETA"] = "Add to Meta Icon"
L["ICONMENU_APPENDCONDT"] = "Add as %q condition"
L["ICONMENU_ANCHORTO"] = "Anchor to %s"
L["ICONMENU_ANCHORTO_DESC"] = [[Anchor %s to %s, so that whenever %s moves, %s will move with it.

Advanced anchor settings are available in the group options.]]
L["ICONMENU_ANCHORTO_UIPARENT"] = "Reset anchor"
L["ICONMENU_ANCHORTO_UIPARENT_DESC"] = [[Reset anchor of %s back to your screen (UIParent). It is currently anchored to %s.

Advanced anchor settings are available in the group options.]]
L["ICONMENU_SPLIT"] = "Split into new group"
L["ICONMENU_SPLIT_DESC"] = "Create a new group and move this icon into it. Many group settings will carry over to the new group."
L["ICONMENU_COPYEVENTHANDLERS"] = "Copy %d |4Event Handler:Event Handlers;"
L["ICONMENU_COPYEVENTHANDLERS_DESC"] = "Copy %s's %d |4Event Handler:Event Handlers; to %s."
L["ICONMENU_COPYCONDITIONS"] = "Copy %d |4Condition:Conditions;"
L["ICONMENU_COPYCONDITIONS_GROUP"] = "Copy %d Group |4Condition:Conditions;"
L["ICONMENU_COPYCONDITIONS_DESC"] = "Copy %s's %d |4Condition:Conditions; to %s."
L["ICONMENU_COPYCONDITIONS_DESC_OVERWRITE"] = "This will overwrite %d existing |4condition:conditions;"

L["ANCHORTO"] = "Anchor To"

L["GENERIC_NUMREQ_CHECK_DESC"] = "Check to enable and configue the %s"

L["STACKS"] = "Stacks"
L["STACKSPANEL_TITLE2"] = "Stack Requirements"
L["ICONMENU_STACKS_MIN_DESC"] = "Minimum number of stacks needed to show the icon"
L["ICONMENU_STACKS_MAX_DESC"] = "Maximum number of stacks allowed to show the icon"

L["DURATION"] = "Duration"
L["DURATIONPERC"] = "Duration Percentage"
L["DURATIONPANEL_TITLE2"] = "Duration Requirements"
L["ICONMENU_DURATION_MIN_DESC"] = "Minimum duration needed to show the icon, in seconds"
L["ICONMENU_DURATION_MAX_DESC"] = "Maximum duration allowed to show the icon, in seconds"

L["CONDITION_TIMERS_HEADER"] = "Timers"
L["CONDITION_TIMERS_SUCCEED_DESC"] = "Duration of a timer to set on the icon when conditions begin succeeding"
L["CONDITION_TIMERS_FAIL_DESC"] = "Duration of a timer to set on the icon when conditions begin failing"

L["METAPANEL_UP"] = "Move up" -- unused by meta icons; still used by conditions
L["METAPANEL_DOWN"] = "Move down" -- unused by meta icons; still used by conditions
L["METAPANEL_REMOVE"] = "Remove icon"
L["METAPANEL_REMOVE_DESC"] = "Click to remove this icon from the list that the meta icon will check."
L["META_ADDICON"] = "Add Icon"
L["META_ADDICON_DESC"] = "Click to add another icon to include in this meta icon."
L["META_GROUP_INVALID_VIEW_DIFFERENT"] = [[Icons in this group may not be checked by this meta icon because they use different display methods.

This group: %s
Target group: %s]]

L["ICONALPHAPANEL_FAKEHIDDEN"] = "Always Hide"
L["ICONALPHAPANEL_FAKEHIDDEN_DESC"] = [[Forces the icon to be hidden all the time while still allowing normal functionality:

|cff7fffff-|r The icon can still be checked by conditions of other icons.
|cff7fffff-|r Meta icons can display this icon.
|cff7fffff-|r This icon's events will still be processed.]]
L["ICONMENU_WPNENCHANTTYPE"] = "Weapon slot to monitor"
L["ICONMENU_HIDEUNEQUIPPED"] = "Hide when slot lacks weapon"
L["ICONMENU_HIDEUNEQUIPPED_DESC"] = "Check this to force the icon to be hidden if the weapon spot being checked does not have a weapon in it, or if that slot has a shield or an off-hand frill."
L["ICONMENU_USEACTIVATIONOVERLAY"] = "Check activation border"
L["ICONMENU_USEACTIVATIONOVERLAY_DESC"] = "Check this to cause the presence of the sparkly yellow border around an action to force the icon to act as usable."
L["ICONMENU_ONLYEQPPD"] = "Only if equipped"
L["ICONMENU_ONLYEQPPD_DESC"] = "Check this to make the icon show only if the item is equipped."
L["ICONMENU_SHOWSTACKS"] = "Show stacks"
L["ICONMENU_SHOWSTACKS_DESC"] = "Check this to show the number of stacks of the item you have."
L["ICONMENU_STEALABLE"] = "Only stealable"
L["ICONMENU_STEALABLE_DESC"] = "Check this to only show buffs that can be spellstolen. Best used when checking for the 'Magic' dispel type"
L["ICONMENU_HIDENOUNITS"] = "Hide if no units"
L["ICONMENU_HIDENOUNITS_DESC"] = "Check this to cause the icon to hide if all the units that this icon is checking have been invalidated because of unit conditions and/or units not existing."
L["ICONMENU_ONLYBAGS"] = "Only if in bags"
L["ICONMENU_ONLYBAGS_DESC"] = "Check this to make the icon show only if the item is in your bags (or equipped). If 'Only if equipped' is enabled, this is also forcibly enabled."
L["ICONMENU_ONLYSEEN"] = "Only if seen"
L["ICONMENU_ONLYSEEN_DESC"] = "Check this to make the icon only show a cooldown if the unit has cast it at least once. You should check this if you are checking spells from different Classes in one icon."
L["ICONMENU_SHOWWHENNONE"] = "Show if no result"
L["ICONMENU_SHOWWHENNONE_DESC"] = "Check this to allow the icon to show as Undiminished when no diminishing returns could be detected on any unit."
L["ICONMENU_CHECKREFRESH"] = "Listen for refreshes"
L["ICONMENU_CHECKREFRESH_DESC"] = [[Blizzard's combat log is very buggy when it comes to spell refreshes and fear (or other spells that break after a certain amount of damage). The combat log will say that the spell was refreshed when damage is dealt, even though it technically wasn't. Uncheck this box to disable listening to spell refreshes, but note that legitimate refreshes will be ignored as well.

It is recommended to leave this checked if the DRs you are checking for don't break after a certain amount of damage.]]
L["ICONMENU_IGNORENOMANA"] = "Ignore lack of power"
L["ICONMENU_IGNORENOMANA_DESC"] = [[Check this to cause the ability to not be treated as unusable if there is only a lack of power to use it.

Useful for abilities such as %s or %s]]
L["ICONMENU_ONLYIFCOUNTING"] = "Only show if timer is active"
L["ICONMENU_ONLYIFCOUNTING_DESC"] = "Check this to make the icon show only if there is currently an active timer running on the icon with a duration greater than 0."
L["ICONMENU_ONLYIFNOTCOUNTING"] = "Only show if timer is not active"
L["ICONMENU_ONLYIFNOTCOUNTING_DESC"] = "Check this to make the icon show only if there is NOT an active timer running on the icon with a duration greater than 0."


-- -------------
-- UI PANEL
-- -------------

L["UIPANEL_SUBTEXT2"] = [[Icons only work when locked.

When unlocked, you can move/size icon groups and right click individual icons to configure them.

You can also type /tellmewhen or /tmw to lock/unlock.]]
L["UIPANEL_MAINOPT"] = "Main Options"
L["UIPANEL_GROUPS"] = "Groups"
L["UIPANEL_GROUPS_DESC"] = "Settings for each group in this TellMeWhen profile."

L["UIPANEL_GROUPTYPE"] = "Group Display Method"
L["UIPANEL_GROUPTYPE_DESC"] = "Choose how you would like icons within this group to be displayed."
L["UIPANEL_GROUPTYPE_ICON"] = "Icon"
L["UIPANEL_GROUPTYPE_ICON_DESC"] = [[Displays the icons in the group using TellMeWhen's traditional icon display.]]
L["UIPANEL_GROUPTYPE_BAR"] = "Bar"
L["UIPANEL_GROUPTYPE_BAR_DESC"] = [[Displays the icons in the group with progress bars attached to the icons.]]

L["UIPANEL_ICONS"] = "Icons"
L["UIPANEL_COLORS"] = "Colors"
L["UIPANEL_COLORS_DESC"] = "Settings that control the coloring/tinting of icons based on their attributes."
L["UIPANEL_ENABLEGROUP"] = "Enable Group"
L["UIPANEL_GROUPNAME"] = "Rename Group"
L["UIPANEL_ROWS"] = "Rows"
L["UIPANEL_COLUMNS"] = "Columns"
L["UIPANEL_GROUPALPHA"] = "Group Opacity"
L["UIPANEL_GROUPALPHA_DESC"] = [[Set the opacity level of the entire group.

This setting has no effect on the functionality of icons themselves. It only changes the appearance of the group and its icons.

Set this setting to 0 if you want to hide the entire group will still allowing it to remain fully functional (similar to the %q setting for icons).]]

L["UIPANEL_ONLYINCOMBAT"] = "Only show in combat"
L["UIPANEL_SPEC"] = "Dual Spec"
L["UIPANEL_TREE"] = "Talent Tree"
L["UIPANEL_SPECIALIZATION"] = "Talent Specialization"
L["UIPANEL_TREE_DESC"] = "Check to allow this group to show when this talent tree is active, or uncheck to cause it to hide when it is not active."
L["UIPANEL_PTSINTAL"] = "Points in talent"
L["UIPANEL_TALENTLEARNED"] = "Talent learned"
L["UIPANEL_GLYPH"] = "Glyph active"
L["UIPANEL_GLYPH_DESC"] = "Checks if you have a particular glyph active."
L["UIPANEL_PRIMARYSPEC"] = "Primary Spec"
L["UIPANEL_SECONDARYSPEC"] = "Secondary Spec"
L["UIPANEL_GROUPRESET"] = "Reset Position"
L["UIPANEL_TOOLTIP_GROUPRESET"] = "Reset this group's position and scale"
L["UIPANEL_ALLRESET"] = "Reset all"
L["UIPANEL_TOOLTIP_ALLRESET"] = "Reset ALL SETTINGS of ALL ICONS AND GROUPS, as well as any other settings."
L["UIPANEL_LOCKUNLOCK"] = "Lock/Unlock AddOn"
L["UIPANEL_COMBATCONFIG"] = "Allow config in combat"
L["UIPANEL_COMBATCONFIG_DESC"] = [[Enable this to allow configuration of TellMeWhen while in combat.

Note that this will force the options module to be loaded all the time, resulting in increased memory usage and slightly longer load times.

This option is account-wide: all of your profiles will share this setting.

|cffff5959Changes will only be reflected after you |cff7fffffreload your UI|cffff5959.|r]]
L["UIPANEL_BARTEXTURE"] = "Bar Texture"
L["UIPANEL_BARIGNOREGCD"] = "Bars Ignore GCD"
L["UIPANEL_BARIGNOREGCD_DESC"] = "If checked, cooldown bars will not change values if the cooldown triggered is a global cooldown"
L["UIPANEL_CLOCKIGNOREGCD"] = "Timers Ignore GCD"
L["UIPANEL_CLOCKIGNOREGCD_DESC"] = "If checked, timers and the cooldown clock will not trigger from a global cooldown"
L["UIPANEL_UPDATEINTERVAL"] = "Update Interval"
L["UIPANEL_TOOLTIP_UPDATEINTERVAL"] = [[Sets how often (in seconds) icons are checked for show/hide, alpha, conditions, etc.

Zero is as fast as possible. Lower values can have a significant impact on framerate for low-end computers.]]
L["UIPANEL_EFFTHRESHOLD"] = "Buff Efficiency Threshold"
L["UIPANEL_EFFTHRESHOLD_DESC"] = "Sets the minimum number of buffs/debuffs to switch to a more efficient mode of checking them when there are a high number. Note that once the number of auras being checked exceeds this number, older auras will be prioritized instead of priority based on the order in which they were entered."
L["UIPANEL_ICONSPACINGX"] = "Horizontal Icon Spacing"
L["UIPANEL_ICONSPACINGY"] = "Vertical Icon Spacing"
L["UIPANEL_ICONSPACING_DESC"] = "Distance that icons within a group are away from each other"
L["UIPANEL_ADDGROUP"] = "+ Add Another Group +"
L["UIPANEL_ADDGROUP_DESC"] = "The new group will be assigned the next available groupID"
L["UIPANEL_DELGROUP"] = "Delete this Group"
L["UIPANEL_DELGROUP_DESC"] = [[Any groups after this group will have their ID shifted up one, and any icons that are checking icons in groups that will be shifted will have their settings automatically updated.

Hold |cff7fffffCtrl|r to bypass confirmation.]]
L["UIPANEL_GROUPMOVEUP"] = "Move up"
L["UIPANEL_GROUPMOVEUP_DESC"] = "Shifts this group's groupID up by one"
L["UIPANEL_GROUPMOVEDOWN"] = "Move Down"
L["UIPANEL_GROUPMOVEDOWN_DESC"] = "Shifts this group's groupID down by one"
L["UIPANEL_TOOLTIP_ENABLEGROUP"] = "Show and enable this group"
L["UIPANEL_TOOLTIP_ROWS"] = "Set the number of rows in this group"
L["UIPANEL_TOOLTIP_COLUMNS"] = "Set the number of columns in this group"
L["UIPANEL_TOOLTIP_ONLYINCOMBAT"] = "Check to cause this group to only be shown in combat"
L["UIPANEL_TOOLTIP_PRIMARYSPEC"] = "Check to show this group while your primary spec is active"
L["UIPANEL_TOOLTIP_SECONDARYSPEC"] = "Check to show this group while your secondary spec is active"
L["UIPANEL_DRAWEDGE"] = "Highlight timer edge"
L["UIPANEL_DRAWEDGE_DESC"] = "Highlights the edge of the cooldown timer (clock animation) to increase visibility"
L["UIPANEL_WARNINVALIDS"] = "Warn about invalid icons"


L["UIPANEL_GROUPSORT"] = "Icon Sorting"
L["UIPANEL_GROUPSORT_DESC"] = "Contains settings for sorting an positioning icons within a group based on their atributes."
L["UIPANEL_GROUPSORT_METHODNAME"] = "Icon Sort Priority %d"
L["UIPANEL_GROUPSORT_METHODNAME_DESC"] = "This will be used as the number %d priority when sorting icons to be positioned within a group."
L["UIPANEL_GROUPSORT_SORTASCENDING"] = "Low"
L["UIPANEL_GROUPSORT_SORTASCENDING_DESC"] = "Check to sort this attribute from low to high values."
L["UIPANEL_GROUPSORT_SORTDESCENDING"] = "High"
L["UIPANEL_GROUPSORT_SORTDESCENDING_DESC"] = "Check to sort this attribute from high to low values."

L["UIPANEL_GROUPSORT_METHODDISABLED_DESC"] = "|TInterface\\AddOns\\TellMeWhen\\Textures\\Alert:0:2|tThis sort method is disabled because a method above it is sorting by Icon ID, so this method will never be reached and used in sorting."

L["UIPANEL_GROUPSORT_id"] = "Icon ID"
L["UIPANEL_GROUPSORT_id_DESC"] = "Sorts the group by the ID numbers of its icons."
L["UIPANEL_GROUPSORT_duration"] = "Duration"
L["UIPANEL_GROUPSORT_duration_DESC"] = "Sorts the group by the duration remaining on its icons."
L["UIPANEL_GROUPSORT_alpha"] = "Opacity (Ignore %s)"
L["UIPANEL_GROUPSORT_alpha_DESC"] = "Sorts the group by the opacity of its icons, ignoring whether or not icons are hidden by the %s setting."
L["UIPANEL_GROUPSORT_visiblealpha"] = "Opacity (Respect %s)"
L["UIPANEL_GROUPSORT_visiblealpha_DESC"] = "Sorts the group by the opacity of its icons, using whatever opacity the icon is actually visible at."
L["UIPANEL_GROUPSORT_shown"] = "Shown (Ignore %s)"
L["UIPANEL_GROUPSORT_shown_DESC"] = "Sorts the group by whether or not an icon is shown, ignoring whether or not icons are hidden by the %s setting."
L["UIPANEL_GROUPSORT_visibleshown"] = "Shown (Respect %s)"
L["UIPANEL_GROUPSORT_visibleshown_DESC"] = "Sorts the group by whether or not an icon is visible to you."
L["UIPANEL_GROUPSORT_stacks"] = "Stacks"
L["UIPANEL_GROUPSORT_stacks_DESC"] = "Sorts the group by the stacks of each icon."



L["COLORNAMES"] = "Class Colored Names"
L["COLORNAMES_DESC"] = "Check in order to attempt to color the names of units in text displays and text icon event handlers."
L["ALWAYSSUBLINKS"] = "Always Substitute Links"
L["ALWAYSSUBLINKS_DESC"] = "By default, spell/item links will only be substituted into text event outputs. Check this setting to cause links to be substituted everywhere, including icon bind/label text."


L["COLOR_DEFAULT"] = "*Global Colors*"
L["COLOR_RESET_DESC"] = "Reset this setting to default values"
L["COLOR_MSQ_COLOR"] = "Color Masque border"
L["COLOR_MSQ_COLOR_DESC"] = "Checking this will cause the border of a Masque skin (if the skin you are using has a border) to be colored."
L["COLOR_MSQ_ONLY"] = "Only color Masque border"
L["COLOR_MSQ_ONLY_DESC"] = "Checking this will cause ONLY the border of a Masque skin (if the skin you are using has a border) to colored. Icons will NOT be colored"
L["COLOR_IGNORE_GCD"] = "Colors ignore GCD"
L["COLOR_IGNORE_GCD_DESC"] = "Checking this will prevent icon colors from changing simply because of the global cooldown."
L["COLOR_OVERRIDEDEFAULT"] = "Use"
L["COLOR_OVERRIDEDEFAULT_DESC"] = "Check this to override the *Global Colors* settings and use this setting instead."
L["COLOR_HEADER_DEFAULT"] = [[These colors will be used for any icon type that does not override them in the type's color settings.

Solid white causes no change in the texture. Solid black will cause the texture to be sold black. Any gray or color in between will tint the icon.]]
L["COLOR_HEADER"] = [[These colors will be used for %s icons if their %q settings are checked.

Solid white causes no change in the texture. Solid black will cause the texture to be sold black. Any gray or color in between will tint the icon.]]
L["COLOR_DESATURATE"] = "Grey"
L["COLOR_DESATURATE_DESC"] = "Check to desaturate the icon when this color is used, removing all color and making the icon grayscale."
L["COLOR_COLOR"] = "Color"


L["COLOR_CBC"] 		 = "Cooldown Bar - Complete"	-- cooldown bar complete
L["COLOR_CBC_DESC"]  = "Color of the cooldown/duration overlay bar when the cooldown/duration is complete"	-- cooldown bar complete
L["COLOR_CBM"] 		 = "Cooldown Bar - Half"	-- cooldown bar middle
L["COLOR_CBM_DESC"]  = "Color of the cooldown/duration overlay bar when the cooldown/duration is half complete"	-- cooldown bar middle
L["COLOR_CBS"] 		 = "Cooldown Bar - Start"	-- cooldown bar start
L["COLOR_CBS_DESC"]  = "Color of the cooldown/duration overlay bar when the cooldown/duration has just begun"	-- cooldown bar start

L["COLOR_OOR"]		 = "Out of Range"	-- out of range
L["COLOR_OOR_DESC"]	 = "Color of the icon when you are not in range to use an ability."	-- out of range
L["COLOR_OOM"]		 = "Out of Mana"	-- out of mana
L["COLOR_OOM_DESC"]	 = "Color of the icon when you lack the power to use an ability."	-- out of mana
L["COLOR_OORM"] 	 = "Out of Range & Mana"	-- out of range and mana
L["COLOR_OORM_DESC"] = "Color of the icon when you lack the power and are not in range to use an ability."	-- out of range and mana

L["COLOR_CTA"]		 = "Counting, Timer Shown, Always Shown"	-- counting with timer always
L["COLOR_CTA_DESC"]	 = [[Color of the icon when:

The timer is active (unusable/present),
%q is enabled,
Both %q settings are checked]]

L["COLOR_COA"]		 = "Counting, Timer Hidden, Always Shown"	-- counting withOUT timer always
L["COLOR_COA_DESC"]	 = [[Color of the icon when:

The timer is active (unusable/present),
%q is disabled,
Both %q settings are checked]]

L["COLOR_CTS"]		 = "Counting, Timer Shown, Sometimes Shown"	-- counting with timer somtimes
L["COLOR_CTS_DESC"]	 = [[Color of the icon when:

The timer is active (unusable/present),
%q is enabled,
Only one %q setting is checked]]

L["COLOR_COS"]		 = "Counting, Timer Hidden, Sometimes Shown"	-- counting withOUT timer somtimes
L["COLOR_COS_DESC"]	 = [[Color of the icon when:

The timer is active (unusable/present),
%q is disabled,
Only one %q setting is checked]]

L["COLOR_NA"]		 = "Finished, Always Shown"	-- not counting always
L["COLOR_NA_DESC"]	 = [[Color of the icon when:

The timer is finished (usable/absent),
Both %q settings are checked]]

L["COLOR_NS"]		 = "Finished, Sometimes Shown"	-- not counting somtimes
L["COLOR_NS_DESC"]	 = [[Color of the icon when:

The timer is finished (usable/absent),
Only one %q setting is checked]]


L["FONTCOLOR"] = "Font Color"
L["FONTSIZE"] = "Font Size"
L["DEFAULT"] = "Default"
L["NONE"] = "None of these"
L["CASTERFORM"] = "Caster Form"
L["ALPHA"] = "Alpha"

L["RESET_ICON"] = "Reset"
L["UNDO_ICON"] = "Undo"
L["UNDO_ICON_DESC"] = "Undo the last change made to this icon's settings."
L["REDO_ICON"] = "Redo"
L["REDO_ICON_DESC"] = "Redo the last change made to this icon's settings."
L["BACK_IE"] = "Back"
L["BACK_IE_DESC"] = "Load the last icon that was edited\r\n\r\n%s |T%s:0|t."
L["FORWARDS_IE"] = "Forwards"
L["FORWARDS_IE_DESC"] = "Load the next icon that was edited\r\n\r\n%s |T%s:0|t."

L["UIPANEL_MAIN_DESC"] = "Contains the main settings for the group."

L["UIPANEL_FONTFACE"] = "Font Face"
L["UIPANEL_FONT_DESC"] = "Chose the font to be used by the stack text on icons."
L["UIPANEL_FONT_SIZE"] = "Font Size"
L["UIPANEL_FONT_SIZE_DESC"] = "Change the size of the font used for stack text on icons. If Masque is used and the set skin has a font size defined, then this value will be ignored."
L["UIPANEL_FONT_SHADOW"] = "Shadow Offset"
L["UIPANEL_FONT_SHADOW_DESC"] = "Change the offset amount of the shadow behind the text. Set to zero to disable the shadow."
L["UIPANEL_FONT_OUTLINE"] = "Font Outline"
L["UIPANEL_FONT_OUTLINE_DESC"] = "Sets the outline style for the stack text on icons."
L["OUTLINE_NO"] = "No Outline"
L["OUTLINE_THIN"] = "Thin Outline"
L["OUTLINE_THICK"] = "Thick Outline"
L["OUTLINE_MONOCHORME"] = "Monochrome"
L["UIPANEL_FONT_CONSTRAINWIDTH"] = "Constrain Width"
L["UIPANEL_FONT_CONSTRAINWIDTH_DESC"] = [[Check this to force the text to fit within the width of the icon if positioned appropriately.

Uncheck to allow text to extend wider than the icon.]]
L["UIPANEL_FONT_XOFFS"] = "X Offset"
L["UIPANEL_FONT_XOFFS_DESC"] = "The x-axis offset of the anchor"
L["UIPANEL_FONT_YOFFS"] = "Y Offset"
L["UIPANEL_FONT_YOFFS_DESC"] = "The y-axis offset of the anchor"
L["UIPANEL_FONT_JUSTIFY"] = "Justification"
L["UIPANEL_FONT_JUSTIFY_DESC"] = "Set the justification (Left/Center/Right) for this text display."
L["UIPANEL_POSITION"] = "Position"
L["UIPANEL_POSITION_DESC"] = "Contains settings that control the position of the group on your screen."
L["UIPANEL_POINT"] = "Point"
L["UIPANEL_POINT_DESC"] = "The point on the group that will be anchored"
L["UIPANEL_RELATIVETO"] = "Relative To"
L["UIPANEL_RELATIVETO_DESC"] = "Type '/framestack' to toggle a tooltip that contains a list of all the frames that your mouse is over, and their names, to put into this dialog."
L["UIPANEL_RELATIVEPOINT"] = "Relative Point"
L["UIPANEL_RELATIVEPOINT_DESC"] = "The point that the group will be anchored to"
L["CHECKORDER"] = "Update Order"
L["CHECKORDER_ICONDESC"] = "Sets the order in which icons within this group will be updated. This really only matters if you are using the feature of meta icons to check sub-metas."
L["CHECKORDER_GROUPDESC"] = "Sets the order in which groups will be updated. This really only matters if you are using the feature of meta icons to check sub-metas."
L["ASCENDING"] = "Ascending"
L["DESCENDING"] = "Descending"
L["UIPANEL_SCALE"] = "Scale"
L["UIPANEL_LEVEL"] = "Frame Level"
L["UIPANEL_STRATA"] = "Frame Strata"
L["UIPANEL_LOCK"] = "Lock Position"
L["UIPANEL_LOCK_DESC"] = "Lock this group, preventing movement or sizing by dragging the group or the scale tab."

L["LAYOUTDIRECTION"] = "Layout Direction"
L["LAYOUTDIRECTION_DESC"] = "Sets the direction that icons will layout in the group."
L["LAYOUTDIRECTION_1"] = "Right then Down"
L["LAYOUTDIRECTION_2"] = "Left then Down"
L["LAYOUTDIRECTION_3"] = "Left then Up"
L["LAYOUTDIRECTION_4"] = "Right then Up"
L["LAYOUTDIRECTION_5"] = "Down then Right"
L["LAYOUTDIRECTION_6"] = "Down then Left"
L["LAYOUTDIRECTION_7"] = "Up then Left"
L["LAYOUTDIRECTION_8"] = "Up then Right"


L["TEXTLAYOUTS"] = "Text Layouts"
L["TEXTLAYOUTS_TAB"] = "Text Displays"
L["TEXTLAYOUTS_HEADER_LAYOUT"] = "Text Layout"
--L["TEXTLAYOUTS_HEADER_DISPLAY"] = "Text Display"
L["TEXTLAYOUTS_fSTRING"] = "Display %s"
L["TEXTLAYOUTS_fSTRING2"] = "Display %d: %s"
L["TEXTLAYOUTS_fSTRING3"] = "Text Display: %s"
L["TEXTLAYOUTS_fLAYOUT"] = "Text Layout: %s"
L["TEXTLAYOUTS_UNNAMED"] = "<no name>"
L["TEXTLAYOUTS_DEFAULTS_WRAPPER"] = "Default: %s"
L["TEXTLAYOUTS_LAYOUTSETTINGS"] = "Layout Settings"
L["TEXTLAYOUTS_LAYOUTSETTINGS_DESC"] = "Click to configure the text layout %q."

L["TEXTLAYOUTS_ERROR_FALLBACK"] = [[The text layout for this icon could not be found. A default layout will be used until the intended layout can be found, or until a different layout is selected.

(Did you delete the layout? Or did you import this icon without importing the layout it used?)]]

L["TEXTLAYOUTS_DEFAULTS_NOLAYOUT"] = "<No Layout>"
L["TEXTLAYOUTS_DEFAULTS_ICON1"] = "Icon Layout 1"
L["TEXTLAYOUTS_DEFAULTS_BAR1"] = "Bar Layout 1"
L["TEXTLAYOUTS_DEFAULTS_DURATION"] = "Duration"
L["TEXTLAYOUTS_DEFAULTS_SPELL"] = "Spell"
L["TEXTLAYOUTS_DEFAULTS_STACKS"] = "Stacks"
L["TEXTLAYOUTS_DEFAULTS_BINDINGLABEL"] = "Binding/Label"
L["TEXTLAYOUTS_DEFAULTS_CENTERNUMBER"] = "Center Number"
L["TEXTLAYOUTS_DEFAULTS_NUMBER"] = "Number"
L["TEXTLAYOUTS_RENAME"] = "Rename Layout"
L["TEXTLAYOUTS_RENAME_DESC"] = "Rename this layout to a name that fits its purpose so that you can easily identify it."

L["TEXTLAYOUTS_RENAMESTRING"] = "Rename Display"
L["TEXTLAYOUTS_RENAMESTRING_DESC"] = "Rename this display to a name that fits its purpose so that you can easily identify it."
L["TEXTLAYOUTS_CHOOSELAYOUT"] = "Choose Layout..."
L["TEXTLAYOUTS_CHOOSELAYOUT_DESC"] = "Pick the text layout to use for this icon."
L["TEXTLAYOUTS_ADDLAYOUT"] = "Create New Layout"
L["TEXTLAYOUTS_ADDLAYOUT_DESC"] = "Create a new text layout that you can configure and apply to your icons."
L["TEXTLAYOUTS_DELETELAYOUT"] = "Delete Layout"
L["TEXTLAYOUTS_DELETELAYOUT_DESC"] = [[Click to delete this text layout.

Hold |cff7fffffCtrl|r to bypass confirmation.]]
L["TEXTLAYOUTS_ADDANCHOR"] = "Add Anchor"
L["TEXTLAYOUTS_ADDANCHOR_DESC"] = [[Click to add another text anchor.]]
L["TEXTLAYOUTS_DELANCHOR"] = "Delete Anchor"
L["TEXTLAYOUTS_DELANCHOR_DESC"] = [[Click to delete this text anchor.]]
L["TEXTLAYOUTS_DELETELAYOUT_CONFIRM_BASE"] = "Are you sure you want to delete the layout %q?"
L["TEXTLAYOUTS_DELETELAYOUT_CONFIRM_NUM"] = "|cFFFF5959The %d |4icon:icons; that |4depends:depend; on it will revert back to using default text layouts.|r"
L["TEXTLAYOUTS_LAYOUTDISPLAYS"] = [[Displays:
%s]]
L["TEXTLAYOUTS_ADDSTRING"] = "Add Text Display"
L["TEXTLAYOUTS_ADDSTRING_DESC"] = "Adds a new text display to this text layout."
L["TEXTLAYOUTS_DELETESTRING"] = "Delete Text Display"
L["TEXTLAYOUTS_DELETESTRING_DESC"] = [[Deletes this text display from this text layout.

Hold |cff7fffffCtrl|r to bypass confirmation.]]
L["TEXTLAYOUTS_STRINGUSEDBY"] = "Used %d |4time:times;."
L["TEXTLAYOUTS_CLONELAYOUT"] = "Clone layout"
L["TEXTLAYOUTS_CLONELAYOUT_DESC"] = "Click to create a copy of this layout that you can edit separately."
L["TEXTLAYOUTS_NOEDIT_DESC"] = [[This text layout is a default layout that comes standard with TellMeWhen and cannot be modified.

If you wish to modify it, please clone it.]]
L["TEXTLAYOUTS_DEFAULTTEXT"] = "Default Text"
L["TEXTLAYOUTS_DEFAULTTEXT_DESC"] = "Edit the default text that will be used when this text layout is set on an icon."
L["TEXTLAYOUTS_SETTEXT"] = "Set Text"
L["TEXTLAYOUTS_SETTEXT_DESC"] = [[Set the text that will be used in this text display.

Text may be formatted with DogTag tags, allowing for dynamic displays of information. Type '/dogtag' or '/dt' for help on how to use tags.]]

L["TEXTLAYOUTS_STRING_COPYMENU"] = "Copy"
L["TEXTLAYOUTS_STRING_COPYMENU_DESC"] = "Click to open a list of all texts that are used in this profile that you can copy to this text display."
L["TEXTLAYOUTS_STRING_SETDEFAULT"] = "Reset to Default"
L["TEXTLAYOUTS_STRING_SETDEFAULT_DESC"] = [[Resets this display's text to the following default text, set in the current text layout's settings:

%s]]
L["TEXTLAYOUTS_BLANK"] = "(Blank)"
L["TEXTLAYOUTS_LAYOUT_SETDEFAULTS"] = "Reset to Defaults"
L["TEXTLAYOUTS_LAYOUT_SETDEFAULTS_DESC"] = [[Resets all displays' texts to their default texts, set in the current text layout's settings.]]

L["TEXTLAYOUTS_IMPORT"] = "Import Text Layout"
L["TEXTLAYOUTS_IMPORT_OVERWRITE"] = "|cFFFF5959Replace|r Existing"
L["TEXTLAYOUTS_IMPORT_OVERWRITE_DESC"] = [[A text layout already exists with the same unique identifier as this one.

Choose this option to overwrite the existing text layout with this layout. All icons that use the existing layout will be updated accordingly.]]
L["TEXTLAYOUTS_IMPORT_OVERWRITE_DISABLED_DESC"] = [[You cannot overwrite a default text layout.]]
L["TEXTLAYOUTS_IMPORT_CREATENEW"] = "|cff59ff59Create|r New"
L["TEXTLAYOUTS_IMPORT_CREATENEW_DESC"] = [[A text layout already exists with the same unique identifier as this one.

Choose this option to generate a new unique identifier and import the layout.]]
L["TEXTLAYOUTS_IMPORT_NORMAL_DESC"] = [[Click to import the text layout.]]

L["TEXTLAYOUTS_SKINAS"] = "Skin As"
L["TEXTLAYOUTS_SKINAS_DESC"] = [[Choose the Masque element that you wish to skin this text as.]]
L["TEXTLAYOUTS_SKINAS_NONE"] = "None"
L["TEXTLAYOUTS_SKINAS_COUNT"] = "Stack Text"
L["TEXTLAYOUTS_SKINAS_HOTKEY"] = "Binding Text"
L["TEXTLAYOUTS_DISABLEDBYSKIN"] = "This setting cannot be changed if you have a Masque skin set for this text display."

L["TEXTLAYOUTS_SETGROUPLAYOUT"] = "Text Layout"
L["TEXTLAYOUTS_SETGROUPLAYOUT_DESC"] = [[Set the text layout that all icons of this group will use.

The text layout can also be set individually per icon in each icon's settings.]]
L["TEXTLAYOUTS_SETGROUPLAYOUT_DDVALUE"] = "Select layout..."

L["TEXTLAYOUTS_FONTSETTINGS"] = "Font Settings"
L["TEXTLAYOUTS_POSITIONSETTINGS"] = "Position Settings"
L["TEXTLAYOUTS_RESETSKINAS"] = "The %q setting has been reset for font string %q in order to prevent conflicts with the new setting for font string %q."


L["TEXTLAYOUTS_POINT_DESC"] = "The point on the text display that will be anchored to the object"
L["TEXTLAYOUTS_RELATIVEPOINT_DESC"] = "The point on the object that will be anchored to"
L["TEXTLAYOUTS_RELATIVETO_DESC"] = "The object that the text will be anchored to"

L["UIPANEL_ANCHORNUM"] = "Anchor %d"

-- -------------
-- CONDITION PANEL
-- -------------

L["ICONTOCHECK"] = "Icon to check"
L["MOON"] = "Moon"
L["SUN"] = "Sun"
L["TRUE"] = "True"
L["FALSE"] = "False"
L["CONDITIONPANEL_DEFAULT"] = "Choose a type..."
L["CONDITIONPANEL_TYPE"] = "Type"
L["CONDITIONPANEL_UNIT"] = "Unit"
L["CONDITIONPANEL_OPERATOR"] = "Operator"
L["CONDITIONPANEL_VALUEN"] = "Value"
L["CONDITIONPANEL_AND"] = "And"
L["CONDITIONPANEL_OR"] = "Or"
L["CONDITIONPANEL_ANDOR"] = "And / Or"
L["CONDITIONPANEL_ANDOR_DESC"] = "|cff7fffffClick|r to toggle between logical operators AND and OR"
L["CONDITIONPANEL_POWER"] = "Primary Resource"
L["CONDITIONPANEL_PERCENT"] = "Percent"
L["CONDITIONPANEL_ABSOLUTE"] = "Absolute"
L["CONDITIONPANEL_MAX"] = "Max"
L["CONDITIONPANEL_COMBO"] = "Combo Points"
L["CONDITIONPANEL_ALTPOWER"] = "Alt. Power"
L["CONDITIONPANEL_ALTPOWER_DESC"] = [[This is the encounter specific power used in several encounters in Cataclysm, including Cho'gall and Atramedes]]
L["CONDITIONPANEL_EXISTS"] = "Unit Exists"
L["CONDITIONPANEL_ALIVE"] = "Unit is Alive"
L["CONDITIONPANEL_ALIVE_DESC"] = "The condition will pass if the unit specified is alive."
L["CONDITIONPANEL_COMBAT"] = "Unit in Combat"
L["CONDITIONPANEL_VEHICLE"] = "Unit Controls Vehicle"
L["CONDITIONPANEL_POWER_DESC"] = [=[Will check for energy if the unit is a druid in cat form, rage if the unit is a warrior, etc.]=]
L["ECLIPSE_DIRECTION"] = "Eclipse Direction"
L["CONDITIONPANEL_ECLIPSE_DESC"] = [=[Eclipse has a range of -100 (a lunar eclipse) to 100 (a solar eclipse).  Input -80 if you want the icon to work with a value of 80 lunar power.]=]
L["CONDITIONPANEL_ICON"] = "Icon is Shown"
L["CONDITIONPANEL_ICON_SHOWN"] = "Shown"
L["CONDITIONPANEL_ICON_HIDDEN"] = "Hidden"
L["CONDITIONPANEL_ICON_DESC"] = [=[The condition checks whether the icon specified is shown or hidden.

If you don't want to display the icon being checked, check %q in the icon editor of that icon.

The group of the icon being checked must be shown in order to check the icon, even if the condition is set to false.]=]

L["CONDITIONPANEL_ICONSHOWNTIME"] = "Icon Shown Time"
L["CONDITIONPANEL_ICONSHOWNTIME_DESC"] = [=[The condition checks how long the icon specified has been shown.

If you don't want to display the icon being checked, check %q in the icon editor of that icon.

The group of the icon being checked must be shown in order to check the icon.]=]

L["CONDITIONPANEL_ICONHIDDENTIME"] = "Icon Hidden Time"
L["CONDITIONPANEL_ICONHIDDENTIME_DESC"] = [=[The condition checks how long the icon specified has been hidden.

If you don't want to display the icon being checked, check %q in the icon editor of that icon.

The group of the icon being checked must be shown in order to check the icon.]=]

L["CONDITIONPANEL_RUNES_DESC"] = [=[Use this condition type to only show the icon when the selected runes are available.

Each rune is a check button. A check mark will require that the rune be usable, an 'X' will require that the rune be unusable, no mark will ignore the rune.

The runes in the second row are the death rune version of each rune above.]=]
L["CONDITIONPANEL_RUNES_CHECK"] = "Force top-row runes to only match non-death runes."
L["CONDITIONPANEL_RUNES_CHECK_DESC"] = [=[Normally, confuring the runes in the top row for this condition will let them match either a normal rune or a death rune in that slot.

Enable this option to force the runes in the top row to only match non-death runes.]=]
L["CONDITIONPANEL_PVPFLAG"] = "Unit is PvP Flagged"
L["CONDITIONPANEL_LEVEL"] = "Unit Level"
L["CONDITIONPANEL_CLASS"] = "Unit Class"
L["CONDITIONPANEL_CLASSIFICATION"] = "Unit Classification"
L["CONDITIONPANEL_ROLE"] = "Unit Role"
L["CONDITIONPANEL_RAIDICON"] = "Unit Raid Icon"
L["CONDITIONPANEL_UNITISUNIT"] = "Unit is Unit"
L["CONDITIONPANEL_UNITISUNIT_DESC"] = "This condition will pass if the unit in the first editbox and the second editbox are the same entity."
L["CONDITIONPANEL_UNITISUNIT_EBDESC"] = "Enter a unit in this editbox to be compared with the first unit."
L["UNITTWO"] = "Second Unit"
L["CONDITIONPANEL_THREAT_SCALED"] = "Unit Threat - Scaled"
L["CONDITIONPANEL_THREAT_SCALED_DESC"] = [[This condition checks your scaled threat percentage on a unit.

100% indicates that you are tanking the unit.]]
L["CONDITIONPANEL_THREAT_RAW"] = "Unit Threat - Raw"
L["CONDITIONPANEL_THREAT_RAW_DESC"] = [[This condition checks your raw threat percentage on a unit.

Players in melee range pull aggro at 110%
Players at range pull aggro at 130%
Players with aggro have a raw threat percentage of 255%]]
L["CONDITIONPANEL_CASTCOUNT"] = "Spell Cast Count"
L["CONDITIONPANEL_CASTCOUNT_DESC"] = [[Checks the number of times that a unit has cast a certain spell.]]
L["CONDITIONPANEL_CASTTOMATCH"] = "Spell to Match"
L["CONDITIONPANEL_CASTTOMATCH_DESC"] = [[Enter a spell name here to make the condition only pass if the spell cast matches it exactly.

You can leave this blank to check for any and all spell casts/channels]]
L["CONDITIONPANEL_INTERRUPTIBLE"] = "Interruptible"
L["CONDITIONPANEL_NAME"] = "Unit Name"
L["CONDITIONPANEL_NAMETOMATCH"] = "Name to Match"
L["CONDITIONPANEL_NAMETOOLTIP"] = "You can enter multiple names to be matched by separating each one with a semicolon (;). The condition will pass if any names are matched."
L["CONDITIONPANEL_NPCID"] = "Unit NPC ID"
L["CONDITIONPANEL_NPCID_DESC"] = [[Checks if a unit has a specified NPC ID.

The NPC ID is the number found in the URL when looking at an NPC's Wowhead page (E.g. http://www.wowhead.com/npc=62943).

Players and other units without an NPC ID will be treated as having an ID of 0 in this condition.]]
L["CONDITIONPANEL_NPCIDTOMATCH"] = "ID to Match"
L["CONDITIONPANEL_NPCIDTOOLTIP"] = "You can enter multiple NPC IDs to be matched by separating each one with a semicolon (;). The condition will pass if any IDs are matched."
L["CONDITIONPANEL_INSTANCETYPE"] = "Instance Type"
L["CONDITIONPANEL_GROUPTYPE"] = "Group Type"
L["CONDITIONPANEL_SWIMMING"] = "Swimming"
L["CONDITIONPANEL_RESTING"] = "Resting"
L["CONDITIONPANEL_INPETBATTLE"] = "In pet battle"
L["CONDITIONPANEL_MANAUSABLE"] = "Spell Usable (Mana/Energy/etc.)"
L["CONDITIONPANEL_SPELLRANGE"] = "Spell in range of unit"
L["CONDITIONPANEL_ITEMRANGE"] = "Item in range of unit"
L["CONDITIONPANEL_AUTOCAST"] = "Pet spell autocasting"
L["CONDITIONPANEL_PETMODE"] = "Pet attack mode"
L["CONDITIONPANEL_PETTREE"] = "Pet talent tree"
L["CONDITIONPANEL_PETSPEC"] = "Pet specialization"
L["CONDITIONPANEL_TRACKING"] = "Tracking active"
L["CONDITIONPANEL_BLIZZEQUIPSET"] = "Equipment set equipped"
L["CONDITIONPANEL_BLIZZEQUIPSET_DESC"] = "Checks whether or not you have a specific Blizzard equipment manager set equipped."
L["CONDITIONPANEL_BLIZZEQUIPSET_INPUT"] = "Equipment set name"
L["CONDITIONPANEL_BLIZZEQUIPSET_INPUT_DESC"] = [[Enter the name of the Blizzard equipment set that you wish to check.

Only one equipment set may be entered, and it is |cFFFF5959CASE SENSITIVE|r]]
L["EQUIPSETTOCHECK"] = "Equipment set to check (|cFFFF5959CASE SENSITIVE|r)"
L["ONLYCHECKMINE"] = "Only Check Mine"
L["ONLYCHECKMINE_DESC"] = "Check this to cause this condition to only check for buffs/debuffs that you casted"
L["LUACONDITION"] = "Lua (Advanced)"
L["LUACONDITION_DESC"] = [[This condition type allows you to evaluate Lua code to determine the state of a condition.

The input is not an 'if .. then' statement, nor is it a function closure. It is a regular statement to be evaluated, e.g. 'a and b or c'.  If complex functionality is required, use a call to a function, e.g. 'CheckStuff()', that is defined externally (perhaps using TMW's Lua snippets feature).

If more help is needed (but not help about how to write Lua code), open a ticket on CurseForge. For help on how to write Lua, go to the internet.]]
L["MACROCONDITION"] = "Macro Conditional"
L["MACROCONDITION_DESC"] = [[This condition will evaluate a macro conditional, and will pass if it passes. All macro conditionals can be prepended with "no" to reverse what they check.

Examples:
	"[nomodifier:alt]" - not holding down the alt key.
	"[@target, help][mod:ctrl]" - target is friendly OR holding down ctrl
	"[@focus, harm, nomod:shift]" - focus is hostile AND not holding down shift

For more help, go to http://www.wowpedia.org/Making_a_macro]]
L["MACROCONDITION_EB_DESC"] = "If using a single condition, opening and closing brackets are optional. Brackets are required if using multiple conditionals."
L["MOUSEOVERCONDITION"] = "Mouse is Over"
L["MOUSEOVERCONDITION_DESC"] = "This condition checks if your mouse is over the icon or group that the condition is attached to."
L["CONDITION_WEEKDAY"] = "Weekday"
L["CONDITION_WEEKDAY_DESC"] = [[Checks the current weekday.

The time checked is your local time, based off your computer's clock. It does not check against server time.]]
L["CONDITION_TIMEOFDAY"] = "Time of Day"
L["CONDITION_TIMEOFDAY_DESC"] = [[The condition checks the current time of day.

The time checked is your local time, based off your computer's clock. It does not check against server time.]]
L["CONDITION_QUESTCOMPLETE"] = "Quest Complete"
L["CONDITION_QUESTCOMPLETE_DESC"] = "Checks if a quest is completed."
L["QUESTIDTOCHECK"] = "QuestID to Check"
L["CONDITION_QUESTCOMPLETE_EB_DESC"] = [[Enter the questID of the quest that you wish to check.

QuestIDs can be obtained from the URL when viewing the quest on a database site like Wowhead.

E.g The questID for http://www.wowhead.com/quest=28716/heros-call-twilight-highlands is 28716]]
L["NOTINRANGE"] = "Not in range"
L["INRANGE"] = "In range"

L["STANCE"] = "Stance"
L["STANCE_LABEL"] = "Stance(s)"
L["STANCE_DESC"] = [[You can enter multiple stances to be matched by separating each one with a semicolon (;).

The condition will pass if any stances are matched.]]

L["AURA"] = "Aura"
L["SEAL"] = "Seal"
L["ASPECT"] = "Aspect"
L["SHAPESHIFT"] = "Shapeshift"
L["PRESENCE"] = "Presence"
L["SPEED"] = "Unit Speed"
L["SPEED_DESC"] = [[This refers to the current movement speed of the unit. If the unit is not moving, it is zero.  If you wish to track the maximum run speed of the unit, use the 'Unit Run Speed' condition instead.]]
L["RUNSPEED"] = "Unit Run Speed"
L["SPELLTOCHECK"] = "Spell to Check"
L["GLYPHTOCHECK"] = "Glyph to Check"
L["SPELLTOCOMP1"] = "First Spell to Compare"
L["SPELLTOCOMP2"] = "Second Spell to Compare"
L["ITEMTOCHECK"] = "Item to Check"
L["ITEMTOCOMP1"] = "First Item to Compare"
L["ITEMTOCOMP2"] = "Second Item to Compare"
L["BUFFTOCHECK"] = "Buff to Check"
L["BUFFTOCOMP1"] = "First Buff to Compare"
L["BUFFTOCOMP2"] = "Second Buff to Compare"
L["DEBUFFTOCHECK"] = "Debuff to Check"
L["DEBUFFTOCOMP1"] = "First Debuff to Compare"
L["DEBUFFTOCOMP2"] = "Second Debuff to Compare"
L["CODETOEXE"] = "Code to Execute"
L["MACROTOEVAL"] = "Macro Conditional(s) to Evaluate"
L["COMPARISON"] = "Comparison"
L["PERCENTAGE"] = "Percentage"

L["PET_TYPE_CUNNING"] = "Cunning"
L["PET_TYPE_TENACITY"] = "Tenacity"
L["PET_TYPE_FEROCITY"] = "Ferocity"

L["SWINGTIMER"] = "Swing Timer"
L["MELEEHASTE"] = "Melee Haste"
L["MELEECRIT"] = "Melee Crit"
L["RANGEDHASTE"] = "Ranged Haste"
L["RANGEDCRIT"] = "Ranged Crit"
L["SPELLHASTE"] = "Spell Haste"
L["SPELLCRIT"] = "Spell Crit"
L["ITEMINBAGS"] = "Item count (includes charges)"
L["ITEMEQUIPPED"] = "Item is equipped"
L["ITEMCOOLDOWN"] = "Item cooldown"
L["SPELLCOOLDOWN"] = "Spell cooldown"
L["SPELLCHARGES_FULLYCHARGED"] = "Fully charged"
L["SPELLCHARGES"] = "Spell charges"
L["SPELLCHARGES_DESC"] = "Tracks the charges of a spell like %s or %s."
L["SPELLCHARGETIME"] = "Spell charge time"
L["SPELLCHARGETIME_DESC"] = "Tracks the time remaining until a spell like %s or %s will regenerate one charge."
L["SPELLREACTIVITY"] = "Spell reactivity"
L["MP5"] = "%d MP5"
L["REACTIVECNDT_DESC"] = "This condition only checks the reactive state of the ability, not the cooldown of it."
L["BUFFCNDT_DESC"] = "Only the first spell will be checked, all others will be ignored."
L["CNDT_ONLYFIRST"] = "Only the first spell/item will be checked - semicolon-delimited lists are not valid for this condition type."
L["CNDT_TOTEMNAME"] = "Totem Name(s)"
L["CNDT_TOTEMNAME_DESC"] = [[Set blank to track any totems of the selected type.

Enter a totem name, or a list of names separated by semicolons, to only check certain totems.]]
L["GCD_ACTIVE"] = "GCD active"
L["BURNING_EMBERS_FRAGMENTS"] = "Burning Ember 'Fragments'"
L["BURNING_EMBERS_FRAGMENTS_DESC"] = [[Each whole Burning Ember consists of 10 fragments.

If you have 1 full ember and another half of an ember, for example, than you have 15 fragments.]]

L["CNDTCAT_FREQUENTLYUSED"] = "Frequently Used"
L["CNDTCAT_SPELLSABILITIES"] = "Spells/Items"
L["CNDTCAT_BUFFSDEBUFFS"] = "Buffs/Debuffs"
L["CNDTCAT_ATTRIBUTES_UNIT"] = "Unit Attributes"
L["CNDTCAT_ATTRIBUTES_PLAYER"] = "Player Attributes"
L["CNDTCAT_STATS"] = "Combat Stats"
L["CNDTCAT_RESOURCES"] = "Resources"
L["CNDTCAT_CURRENCIES"] = "Currencies"
L["CNDTCAT_ARCHFRAGS"] = "Archaeology Fragments"
L["CNDTCAT_MISC"] = "Miscellaneous"

L["CONDITIONPANEL_MOUNTED"] = "Mounted"
L["CONDITIONPANEL_EQUALS"] = "Equals"
L["CONDITIONPANEL_NOTEQUAL"] = "Not Equal to"
L["CONDITIONPANEL_LESS"] = "Less Than"
L["CONDITIONPANEL_LESSEQUAL"] = "Less Than/Equal to"
L["CONDITIONPANEL_GREATER"] = "Greater Than"
L["CONDITIONPANEL_GREATEREQUAL"] = "Greater Than/Equal to"
L["CONDITIONPANEL_REMOVE"] = "Remove this condition"
L["CONDITIONPANEL_ADD"] = "Add a condition"
L["CONDITIONPANEL_ADD2"] = "Click to Add a Condition"
L["PARENTHESIS_WARNING1"] = [[The number of opening and closing parentheses do not match!

%d more %s |4parenthesis:parentheses; |4is:are; needed.]]
L["PARENTHESIS_WARNING2"] = [[Some closing parentheses are missing openers!

%d more opening |4parenthesis:parentheses; |4is:are; needed.]]
L["PARENTHESIS_TYPE_("] = "opening"
L["PARENTHESIS_TYPE_)"] = "closing"
L["NUMAURAS"] = "Number of"
L["ACTIVE"] = "%d Active"
L["NUMAURAS_DESC"] = [[This condition checks the number of an aura active - not to be confused with the number of stacks of an aura.  This is for checking things like if you have both weapon enchant procs active at the same time.  Use sparingly, as the process used to count the numbers is a bit CPU intensive.]]
L["TOOLTIPSCAN"] = "Aura Variable"
L["TOOLTIPSCAN_DESC"] = "This condition type will allow you to check the first variable associated with an aura. Numbers are provided by Blizzard API and do not necessarily match numbers found on the tooltip of the aura. There is also no guarantee that a number will be obtained for an aura. In most practical cases, though, the correct number will be checked."

L["INCHEALS"] = "Unit Incoming heals"
L["INCHEALS_DESC"] = [[Checks the total amount of healing that is incoming to the unit (HoTs and casts in progress).

Only works for friendly units. Hostile units will always be reported as having 0 incoming heals.]]
L["ABSORBAMT"] = "Absorbtion shield amount"
L["ABSORBAMT_DESC"] = "Checks the total amount of absorbtion shields that the unit has."




L["CODESNIPPET_RENAME"] = "Code Snippet Name"
L["CODESNIPPET_RENAME_DESC"] = [[Choose a name for this snippet so it can be easily identified by you.

Names don't have to be unique.]]
L["CODESNIPPET_ORDER"] = "Run Order"
L["CODESNIPPET_ORDER_DESC"] = [[Set the order in which this snippet should be run relative to other snippets.

%s and %s will be mixed together based on this value when they are run.

Decimal amounts are valid. Consistent order is not guarenteed if two snippets share the same order.]]
L["CODESNIPPET_CODE"] = "Lua Code to Run"
L["CODESNIPPET_CODE_DESC"] = [[Set the Lua code that will be ran by this snippet when TellMeWhen is intialized.]]

L["CODESNIPPETS"] = "Lua Code Snippets"
L["CODESNIPPETS_TITLE"] = "Lua Snippets (Advanced)"
L["CODESNIPPETS_DESC"] = [[This feature allows you to write chunks of Lua code that will be ran when TellMeWhen is being initialized.

It is an advanced feature for those who have experience with Lua (or for those who have been given a snippet by another TellMeWhen user).

Uses might include writing custom functions for use in Lua conditions (be sure to define those in TMW.CNDT.Env).

Snippets can be defined either per-profile or globally (global snippets will run for all profiles).]]
L["CODESNIPPET_GLOBAL"] = "Global Snippets"
L["CODESNIPPET_PROFILE"] = "Profile Snippets"

L["CODESNIPPET_ADD"] = "Create new Snippet"
L["CODESNIPPET_DELETE"] = "Delete Snippet"
L["CODESNIPPET_DELETE_DESC"] = [[Click to delete this code snippet.

Hold |cff7fffffCtrl|r to bypass confirmation.]]
L["CODESNIPPET_DELETE_CONFIRM"] = "Are you sure you want to delete the code snippet %q?"
L["CODESNIPPET_RUNNOW"] = "Run Snippet Now"
L["CODESNIPPET_RUNNOW_DESC"] = [[Click to run this code snippet.

Hold |cff7fffffCtrl|r to bypass confirmation if the snippet has already been ran.]]
L["CODESNIPPET_RUNNOW_CONFIRM"] = [[Are you sure you want to run the code snippet %s again?

(It has already been run at least once this session)

You can hold |cff7fffffCtrl|r when clicking the %s button to bypass confirmation.]]

L["CODESNIPPETS_DEFAULTNAME"] = "New Snippet"

L["CODESNIPPETS_IMPORT_GLOBAL"] = "New Global Snippet"
L["CODESNIPPETS_IMPORT_GLOBAL_DESC"] = [[Import the snippet as a global snippet.]]
L["CODESNIPPETS_IMPORT_PROFILE"] = "New Profile Snippet"
L["CODESNIPPETS_IMPORT_PROFILE_DESC"] = [[Import the snippet as a profile-specific snippet.]]

L["fCODESNIPPET"] = "Code Snippet: %s"

-- ----------
-- STUFF THAT I GOT SICK OF ADDING PREFIXES TOO AND PUTTING IN THE RIGHT PLACE
-- ----------

L["GROUPICON"] = "Group: %s, Icon: %s"
L["ICONGROUP"] = "Icon: %s (Group: %s)"
L["fGROUP"] = "Group: %s"
L["fICON"] = "Icon: %s"
L["ICON"] = "Icon"
L["DISABLED"] = "Disabled"
L["COPYPOSSCALE"] = "Copy position/scale"
L["COPYGROUP"] = "Copy Group"
L["OVERWRITEGROUP"] = "|cFFFF5959Overwrite|r Group: %s"
L["MAKENEWGROUP"] = "|cff59ff59Create|r New Group"


--[=[L["CNDT_SLIDER_DESC_BASE"] = [[|cff7fffffMousewheel|r to adjust.
|cff7fffffShift-Mousewheel|r to adjust x10.
|cff7fffffCtrl-Mousewheel|r to adjust x60.
|cff7fffffCtrl-Shift-Mousewheel|r to adjust x600.]]]=]
L["CNDT_SLIDER_DESC_CLICKSWAP_TOMANUAL"] = [[|cff7fffffRight-Click|r to switch to manual input.]]
L["CNDT_SLIDER_DESC_CLICKSWAP_TOSLIDER"] = [[|cff7fffffRight-Click|r to switch to slider input.]]
L["CNDT_SLIDER_DESC_CLICKSWAP_TOSLIDER_DISALLOWED"] = [[Only manual input is allowed for values over %s (Blizzard's sliders can behave strangely with large values.)]]


L["IconModule_IconContainer_MasqueIconContainer"] = "Icon Container"
L["IconModule_IconContainer_MasqueIconContainer_DESC"] = "Holds the main parts of the icon, such as the texture"
L["IconModule_TimerBar_OverlayTimerBar"] = "Timer Bar Overlay"
L["IconModule_PowerBar_OverlayPowerBar"] = "Power Bar Overlay"
L["IconModule_Texture_ColoredTexture"] = "Icon Texture"
L["IconModule_CooldownSweepCooldown"] = "Cooldown Sweep"
L["IconModule_TimerBar_BarDisplayTimerBar"] = "Timer Bar (Bar display)"
L["IconModule_SelfIcon"] = "Icon"


L["GROUPADDONSETTINGS"] = "Group Settings"
L["GROUPADDONSETTINGS_DESC"] = [[Configure settings for this group, other groups, and all other general addon settings.]]
L["CONDITIONS"] = "Conditions"
L["ICONCONDITIONS_DESC"] = "Configure conditions that allow you to fine-tune when this icon is shown."
L["GROUPCONDITIONS"] = "Group Conditions"
L["GROUPCONDITIONS_DESC"] = "Configure conditions that allow you to fine-tune when this group is shown."

L["EVENTCONDITIONS"] = "Event Conditions"
L["EVENTCONDITIONS_DESC"] = "Click to configure a set of conditions that will trigger this event when they begin passing."
L["EVENTCONDITIONS_TAB_DESC"] = "Configure a set of conditions that will trigger an event when they begin passing."

L["UNITCONDITIONS"] = "Unit Conditions"
L["UNITCONDITIONS_DESC"] = "Click to configure a set of conditions that each unit will have to pass in order to be checked."
L["UNITCONDITIONS_TAB_DESC"] = "Configure conditions that each unit will have to pass in order to be checked."
L["UNITCONDITIONS_STATICUNIT"] = "<Icon Unit>"
L["UNITCONDITIONS_STATICUNIT_DESC"] = "Causes the condition to check each unit that the icon is checking."
L["UNITCONDITIONS_STATICUNIT_TARGET"] = "<Icon Unit>'s target"
L["UNITCONDITIONS_STATICUNIT_TARGET_DESC"] = "Causes the condition to check the target of each unit that the icon is checking."


L["MAIN"] = "Main"
L["MAIN_DESC"] = "Contains the main options for this icon."
L["UNNAMED"] = "((Unnamed))"
L["NOTYPE"] = "<No Icon Type>"


L["MISCELLANEOUS"] = "Miscellaneous"
L["TEXTMANIP"] = "Text manipulation"
L["DT_DOC_TMWFormatDuration"] = "Returns a string formatted by TellMeWhen's time format. Alternative to [FormatDuration]."
L["DT_DOC_gsub"] = "Gives access to Lua's string.gsub function for DogTags for powerful string manipulation capabilities."
L["DT_DOC_strfind"] = "Gives access to Lua's string.find function for DogTags for powerful string manipulation capabilities."
L["DT_DOC_Name"] = "Returns the name of the unit. This is an improved version of the default [Name] tag provided by DogTag."

L["DT_DOC_Source"] = "Returns the source unit or name of the last Combat Event that the icon processed. Best use in conjunction with the [Name] tag. (This tag should only be used with %s type icons)"
L["DT_DOC_Destination"] = "Returns the destination unit or name of the last Combat Event that the icon processed. Best use in conjunction with the [Name] tag. (This tag should only be used with %s type icons)"
L["DT_DOC_Extra"] = "Returns the extra spell from the last Combat Event that the icon processed. (This tag should only be used with %s type icons)"

L["DT_DOC_LocType"] = "Returns the type of the control loss effect that the icon is displaying for. (This tag should only be used with %s type icons)"

L["DT_DOC_IsShown"] = "Returns whether or not an icon is shown."
L["DT_DOC_Opacity"] = "Returns the opacity of an icon. Return value is between 0 and 1."
L["DT_DOC_Duration"] = "Returns the current duration remaining on the icon. It is recommended that you format this with [TMWFormatDuration]"
L["DT_DOC_Spell"] = "Returns the spell or item that the icon is showing data for."
L["DT_DOC_Stacks"] = "Returns the current stacks of the icon"
L["DT_DOC_Unit"] = "Returns the unit or the name of the unit that the icon is checking. Best use in conjunction with the [Name] tag."
L["DT_DOC_PreviousUnit"] = "Returns the unit or the name of the unit that the icon is checked prior to the current unit. Best use in conjunction with the [Name] tag."

L["ERROR_MISSINGLAYOUT"] = "Couldn't find the text layout for %s. Falling back on the default layout."

L["SENDSUCCESSFUL"] = "Sent successfully"
L["MESSAGERECIEVE"] = "%s has sent you some TellMeWhen data! You can import this data into TellMeWhen using the %q button, located at the bottom of the icon editor."
L["MESSAGERECIEVE_SHORT"] = "%s has sent you some TellMeWhen data!"
L["ALLOWCOMM"] = "Allow in-game sharing"
L["ALLOWCOMM_DESC"] = "Allow other TellMeWhen users to send you data."
L["ALLOWVERSIONWARN"] = "Notify of new version"
L["NEWVERSION"] = "A new version of TellMeWhen is available: %s"
L["PLAYER_DESC"] = "(You)"


L["IMPORT_EXPORT"] = "Import/Export/Restore"
L["IMPORT_EXPORT_DESC"] = [[Click the button to the right to import and export icons, groups, and profiles.

Importing to or from a string, or exporting to another player, will require the use of this editbox. See the tooltips within the dropdown menu for details.]]
L["IMPORT_EXPORT_BUTTON_DESC"] = "Click this button to import and export icons, groups, and profiles."
L["IMPORT_EXPORT_DESC_INLINE"] = "Import and Export profiles, groups, icons to or from strings, other players, other profiles, or a backup of your settings."

L["IMPORT_HEADING"] = "Import"
L["IMPORT_FROMLOCAL"] = "From Profile"
L["IMPORT_FROMBACKUP"] = "From Backup"
L["IMPORT_FROMBACKUP_WARNING"] = "BACKUP SETTINGS: %s"
L["IMPORT_FROMBACKUP_DESC"] = "Settings restored from this menu will be as they were at: %s"
L["IMPORT_FROMSTRING"] = "From String"
L["IMPORT_FROMSTRING_DESC"] = [[Strings allow you to transfer TellMeWhen configuration data outside the game.

To import from a string, press CTRL+V to paste the string into the editbox after you have copied it to your clipboard, and then navigate back to this sub-menu.]]
L["IMPORT_FROMCOMM"] = "From Player"
L["IMPORT_FROMCOMM_DESC"] = "If another user of TellMeWhen sends you any configuration data, you will be able to import that data from this submenu."
L["IMPORT_PROFILE"] = "Copy Profile"
L["IMPORT_PROFILE_OVERWRITE"] = "|cFFFF5959Overwrite|r %s"
L["IMPORT_PROFILE_NEW"] = "|cff59ff59Create|r New Profile"

L["EXPORT_HEADING"] = "Export"
L["EXPORT_TOSTRING"] = "To String"
L["EXPORT_TOCOMM"] = "To Player"
L["EXPORT_TOGUILD"] = "To Guild"
L["EXPORT_TORAID"] = "To Raid"
L["EXPORT_TOCOMM_DESC"] = [[Type a player's name into the editbox and choose this option to send the data to them. They must be somebody that you can whisper (same faction, server, online), and they must have TellMeWhen v4.0.0+

You can also type "GUILD" or "RAID" (case-sensitive) to send to your entire guild or raid group.]]
L["EXPORT_TOSTRING_DESC"] = "A string containing the necessary data will be pasted into the editbox.  Press Ctrl+C to copy it, and then paste it wherever you want to share it."
L["EXPORT_SPECIALDESC2"] = "Other TellMeWhen users can only import this data if they have version %s"
L["EXPORT_f"] = "Export %s"
L["fPROFILE"] = "Profile: %s"
L["fTEXTLAYOUT"] = "Text Layout: %s"


L["CONFIGPANEL_TIMER_HEADER"] = "Timer Sweep"
L["CONFIGPANEL_CBAR_HEADER"] = "Timer Bar Overlay"
L["CONFIGPANEL_TIMERBAR_BARDISPLAY_HEADER"] = "Timer Bar"
L["CONFIGPANEL_PBAR_HEADER"] = "Power Bar Overlay"
L["CONFIGPANEL_CLEU_HEADER"] = "Combat Events"
L["CONFIGPANEL_CNDTTIMERS_HEADER"] = "Condition Timers"





L["CACHING"] = [[TellMeWhen is caching and filtering all spells in the game. This only needs to be done once per WoW patch. You can speed up or slow down the process using the slider below.

You do not have to wait for this process to complete in order to use TellMeWhen. Only the suggestion list is dependent on the completion of the spell cache.]]
L["CACHINGSPEED"] = "Spells per frame:"
L["SUGGESTIONS"] = "Suggestions:"
L["SUGGESTIONS_DOGTAGS"] = "DogTags:"
L["SUG_TOOLTIPTITLE"] = [[As you type, TellMeWhen will look through its cache and determine the spells that you were most likely looking for.

Spells are categorized and colored as per the list below. Note that the categories that begin with the word "Known" will not have spells put into them until they have been seen as you play or log onto different Classes.

Clicking on an entry will insert it into the editbox.

]]--extra newlines intended
L["SUG_TOOLTIPTITLE_TEXTSUBS"] = [[The following are tags that you may wish to use in this text display. Using a substitution will cause it to be replaced with the appropriate data wherever it is displayed.

For more information about these tags, and for more tags, click this button.

Clicking on an entry will insert it into the editbox.]]
L["SUG_DISPELTYPES"] = "Dispel Types"
L["SUG_BUFFEQUIVS"] = "Buff Equivalencies"
L["SUG_DEBUFFEQUIVS"] = "Debuff Equivalencies"
L["SUG_OTHEREQUIVS"] = "Other Equivalencies"
L["SUG_MSCDONBARS"] = "Valid multi-state cooldowns"
L["SUG_PLAYERSPELLS"] = "Your spells"
L["SUG_CLASSSPELLS"] = "Known PC/pet spells"
L["SUG_NPCAURAS"] = "Known NPC buffs/debuffs"
L["SUG_PLAYERAURAS"] = "Known PC/pet buffs/debuffs"
L["SUG_MISC"] = "Miscellaneous"
L["SUG_FINISHHIM"] = "Finish Caching Now"
L["SUG_FINISHHIM_DESC"] = "|cff7fffffClick|r to immediately finish the caching/filtering process. Note that your computer may freeze for a few seconds."


L["SUG_INSERT_ANY"] = "|cff7fffffClick|r"
L["SUG_INSERT_LEFT"] = "|cff7fffffLeft-click|r"
L["SUG_INSERT_RIGHT"] = "|cff7fffffRight-click|r"
L["SUG_INSERT_TAB"] = " or |cff7fffffTab|r"

L["SUG_INSERTNAME"] = "%s to insert as a name"
L["SUG_INSERTID"] = "%s to insert as an ID"
L["SUG_INSERTITEMSLOT"] = "%s to insert as an item slot ID"
L["SUG_INSERTEQUIV"] = "%s to insert equivalency"
L["SUG_INSERTTEXTSUB"] = "%s to insert tag"

L["SUG_INSERTNAME_INTERFERE"] = [[%s to insert as a name

|TInterface\AddOns\TellMeWhen\Textures\Alert:0:2|t|cffffa500CAUTION: |TInterface\AddOns\TellMeWhen\Textures\Alert:0:2|t|cffff1111
This spell interferes with an equivalency.
It probably won't be tracked if inserted by name.
You should insert by ID instead.|r]]

L["SUG_PATTERNMATCH_FISHINGLURE"] = "Fishing Lure %(%+%d+ Fishing Skill%)" -- enUS
L["SUG_PATTERNMATCH_WEIGHTSTONE"] = "Weighted %(%+%d+ Damage%)"
L["SUG_PATTERNMATCH_SHARPENINGSTONE"] = "Sharpened %(%+%d+ Damage%)"
L["SUG_MATCH_WPNENCH_ENCH"] = "(.*) Weapon" -- inconsistent key. oops.

L["SUG_ATBEGINING"] = "Suggester: Match beginning"
L["SUG_ATBEGINING_DESC"] = "If checked, the suggestion list will only display spells that start with the same name as the spell that is being typed in. Otherwise, it will match any part of a spell."

L["SUG_FIRSTHELP_DESC"] = [[This is the suggestion list. You can insert entries from it to speed up configuration.

If you are inserting by name, you do not need to chose the entry with the correct ID - all that matters is that you pick the correct name.

In almost all cases, it is best to track things by name. You only need to track things by ID if there are multiple things with the same name but with different effects that could overlap.

Press tab at any time to insert the first entry shown. Right-click to insert an ID if you are typing a name, and vice-versa.]]



L["LOSECONTROL_ICONTYPE"] = "Loss of Control"
L["LOSECONTROL_DROPDOWNLABEL"] = "Loss of Control Types"
L["LOSECONTROL_DROPDOWNLABEL_DESC"] = "Choose the loss of control types that you would like the icon to react to."
L["LOSECONTROL_ICONTYPE_DESC"] = "Tracks effects that cause the loss of control of your character."
L["LOSECONTROL_INCONTROL"] = "In Control"
L["LOSECONTROL_CONTROLLOST"] = "Control Lost"
L["LOSECONTROL_TYPE_ALL"] = "All Types"
L["LOSECONTROL_TYPE_ALL_DESC"] = "Causes the icon to display information about all types of effects."
L["LOSECONTROL_TYPE_SCHOOLLOCK"] = "Spell School Locked"
L["LOSECONTROL_TYPE_MAGICAL_IMMUNITY"] = "Magical Immunity"
L["LOSECONTROL_TYPE_DESC_USEUNKNOWN"] = "NOTE: It is not known if this loss of control type is used or not."


L["SOUND_EVENT_ONSHOW"] = "On Show"
L["SOUND_EVENT_ONSHOW_DESC"] = "This event triggers when the icon becomes shown (even if %q is checked)."

L["SOUND_EVENT_ONHIDE"] = "On Hide"
L["SOUND_EVENT_ONHIDE_DESC"] = "This event triggers when the icon is hidden (even if %q is checked)."

L["SOUND_EVENT_ONSTART"] = "On Start"
L["SOUND_EVENT_ONSTART_DESC"] = [[This event triggers when the cooldown becomes unusable, the buff/debuff is applied, etc.]]

L["SOUND_EVENT_ONFINISH"] = "On Finish"
L["SOUND_EVENT_ONFINISH_DESC"] = [[This event triggers when the cooldown becomes usable, the buff/debuff falls off, etc.]]

L["SOUND_EVENT_ONALPHAINC"] = "On Alpha Increase"
L["SOUND_EVENT_ONALPHAINC_DESC"] = [[This event triggers when the opacity of an icon increases.

NOTE: This event will not trigger when increasing from 0% opacity (On Show).]]

L["SOUND_EVENT_ONALPHADEC"] = "On Alpha Decrease"
L["SOUND_EVENT_ONALPHADEC_DESC"] = [[This event triggers when the opacity of an icon decreases.

NOTE: This event will not trigger when decreasing to 0% opacity (On Hide).]]

L["SOUND_EVENT_ONUNIT"] = "On Unit Changed"
L["SOUND_EVENT_ONUNIT_DESC"] = [[This event triggers when the unit that that the icon is displaying information for has changed.]]

L["SOUND_EVENT_ONSPELL"] = "On Spell Changed"
L["SOUND_EVENT_ONSPELL_DESC"] = [[This event triggers when the spell/item/etc. that that the icon is displaying information for has changed.]]

L["SOUND_EVENT_ONSTACK"] = "On Stacks Changed"
L["SOUND_EVENT_ONSTACK_DESC"] = [[This event triggers when the stacks of whatever the item is tracking has changed.

This includes the amount of diminishment for %s icons.]]

L["SOUND_EVENT_ONDURATION"] = "On Duration Changed"
L["SOUND_EVENT_ONDURATION_DESC"] = [[This event triggers when the duration of the icon's timer changes.

Because this event occurs every time the icon is updated while a timer is running, you must set a condition, and the event will only occur when the state of that condition changes.]]

L["SOUND_EVENT_ONCLEU"] = "On Combat Event"
L["SOUND_EVENT_ONCLEU_DESC"] = [[This event triggers when a combat event that should be processed by the icon occurs.]]

L["SOUND_EVENT_ONICONSHOW"] = "On Other Icon Show"
L["SOUND_EVENT_ONICONSHOW_DESC"] = [[This event triggers when another icon (not this icon) is shown.

Configure the icon that should be watched using the event settings below.]]

L["SOUND_EVENT_ONICONHIDE"] = "On Other Icon Hide"
L["SOUND_EVENT_ONICONHIDE_DESC"] = [[This event triggers when another icon (not this icon) is hidden.

Configure the icon that should be watched using the event settings below.]]

L["SOUND_EVENT_ONLEFTCLICK"] = "On Left Click"
L["SOUND_EVENT_ONLEFTCLICK_DESC"] = [[This event triggers when you |cff7fffffLeft-click|r the icon while icons are locked.]]

L["SOUND_EVENT_ONRIGHTCLICK"] = "On Right Click"
L["SOUND_EVENT_ONRIGHTCLICK_DESC"] = [[This event triggers when you |cff7fffffRight-click|r the icon while icons are locked.]]

L["SOUND_EVENT_ONCONDITION"] = "On Condition Set Passing"
L["SOUND_EVENT_ONCONDITION_DESC"] = "This event triggers when a set of conditions that you can configure for this event begin passing."

L["SOUND_EVENT_ONEVENTSRESTORED"] = "On Icon Setup"
L["SOUND_EVENT_ONEVENTSRESTORED_DESC"] = [[This event triggers immediately after this icon has been setup.

This mainly happens when you leave configuration mode, but it also happens when entering/leaving a zone among several other things.

This may also be thought of as a "soft reset" of the icon.

This event may be useful in creating a default animation state for the icon.]]

L["SOUND_EVENT_GLOBALDESC"] = "Events are checked from top to bottom in this list. If an event is triggered that has a sound to play, no events below that event will play a sound."
L["SOUND_EVENT_DISABLEDFORTYPE"] = "Not available"
L["SOUND_EVENT_DISABLEDFORTYPE_DESC2"] = [[This event is not available for the current icon configuration.

This is probably due to this event not being available for the current icon type (%s).

|cff7fffffRight-click|r to change event.]]

L["SOUND_SOUNDTOPLAY"] = "Sound to Play"
L["SOUND_CUSTOM"] = "Custom sound file"
L["SOUND_CUSTOM_DESC"] = [[Insert the path to a custom sound to play. Here are some examples, where "file" is the name of your sound, and "ext" is the file's extension (ogg or mp3 only!):

- "CustomSounds\file.ext": a file placed in a new folder named "CustomSounds" that is in WoW's root directory (the same location as Wow.exe, Interface and WTF folders, etc)

- "Interface\AddOns\file.ext": a loose file in the AddOns folder

- "file.ext": a loose file in WoW's root directory

NOTE: WoW must be restarted before it will recognize files that did not exist when it was started up.]]
L["SOUND_TAB"] = "Sound"

L["EVENTS_TAB"] = "Events"
L["EVENTS_TAB_DESC"] = "Configure triggers for sounds, text ouput, and animations."
L["EVENTS_HANDLERS_HEADER"] = "Icon Event Handlers"
L["EVENTS_HANDLERS_ADD"] = "Add Event Handler..."
L["EVENTS_HANDLERS_ADD_DESC"] = "|cff7fffffClick|r to choose an event handler to add to this icon."
L["EVENTS_HANDLERS_GLOBAL_DESC"] = [[|cff7fffffClick|r for event handler options
|cff7fffffRight-click|r to change event
|cff7fffffClick-and-drag|r to rearrange]]
L["EVENTS_HANDLERS_PLAY"] = "Test Event"
L["EVENTS_HANDLERS_PLAY_DESC"] = "|cff7fffffClick|r to test the event handler"

L["EVENTS_SETTINGS_HEADER"] = "Event Settings"

L["EVENTS_INSTRUCTIONS"] = [[In this tab, you can configure extra functionality for this icon with effects like sounds, animations, and text outputs.

All these effects are triggered by an event of your choosing. Most events are triggered in response to a change in the icon's status, but there are other events too.

To get started configuring these effects, click the button to the left and chose the combination of event and effect that you would like.

The settings for the event and the effect will then appear, and you can configure them as desired.]]

L["EVENTS_SETTINGS_ONLYSHOWN"] = "Only handle if icon is shown"
L["EVENTS_SETTINGS_ONLYSHOWN_DESC"] = "Prevents the event from being handled if the icon is not shown."

L["EVENTS_SETTINGS_PASSINGCNDT"] = "Only handle if condition is passing:"
L["EVENTS_SETTINGS_PASSINGCNDT_DESC"] = "Prevents the event from being handled unless the condition configured below succeeds."

L["EVENTS_SETTINGS_CNDTJUSTPASSED"] = "And it just began passing"
L["EVENTS_SETTINGS_CNDTJUSTPASSED_DESC"] = "Prevents the event from being handled unless the condition configured above has just begun succeeding."

L["EVENTS_SETTINGS_PASSTHROUGH"] = "Continue to lower events"
L["EVENTS_SETTINGS_PASSTHROUGH_DESC"] = [[Check to allow another event to be handled after this one.
If left unchecked, the icon will not process any more events after this event if it successfully processes and outputs/displays something.

Exeptions may apply, see individual event descriptions for details.]]



L["SOUND_CHANNEL"] = "Sound Channel"
L["SOUND_CHANNEL_DESC"] = [[Choose the sound channel and volume setting that you would like to use to play sounds.

Selecting %q will let sounds be played even when sounds are turned off.]]
L["SOUND_CHANNEL_MASTER"] = "Master"

L["SOUND_ERROR_ALLDISABLED"] = [[This sound cannot be tested because the game sounds are completely disabled.

Change this setting in Blizzard's sound options.]]
L["SOUND_ERROR_DISABLED"] = [[This sound cannot be tested because the %q sound channel is disabled.

Change this setting in Blizzard's sound options.

You can also change the sound channel that TellMeWhen is configured to use in TellMeWhen's main options ('/tmw options')]]
L["SOUND_ERROR_MUTED"] = [[This sound cannot be tested because the volume for the %q sound channel is set to zero.

Change this setting in Blizzard's sound options.

You can also change the sound channel that TellMeWhen is configured to use in TellMeWhen's main options ('/tmw options')]]

L["SOUNDERROR1"] = "File must have an extension!"
L["SOUNDERROR2"] = [[Custom WAV files are not supported by WoW 4.0+

(Sounds build into WoW will still work, though)]]
L["SOUNDERROR3"] = "Only OGG and MP3 files are supported!"

L["ANN_TAB"] = "Text"
L["HELP_ANN_LINK_INSERTED"] = [[The link you just inserted might look strange, but this is how it must be formatted with DogTag.

Changing the color code if you are outputting to a Blizzard channel will break the link.]]
L["ANN_NOTEXT"] = "<No Text>"
L["ANN_CHANTOUSE"] = "Channel to Use"
L["ANN_EDITBOX"] = "Text to be outputted"
L["ANN_EDITBOX_WARN"] = "Type the text you wish to be outputted here"
L["ANN_EDITBOX_DESC"] = [[Type the text that you wish to be outputted when the event triggers.]]
L["MOUSEOVER_TOKEN_NOT_FOUND"] = "<no mouseover>"
L["ANN_STICKY"] = "Sticky"
L["ANN_SHOWICON"] = "Show icon texture"
L["ANN_SHOWICON_DESC"] = "Some text destinations can show a texture along with the text. Check this to enable that feature."
L["ANN_SUB_CHANNEL"] = "Sub section"
L["ANN_WHISPERTARGET"] = "Whisper target"
L["ANN_WHISPERTARGET_DESC"] = [[Input the name of the player that you would like to whisper.

Normal server/faction whisper requirements apply.]]
L["ANN_EVENT_GLOBALDESC"] = "Events are checked from top to bottom in this list. If an event is triggered that has text to output, no events below that event will output any text."
L["ANN_FCT_DESC"] = "Outputs to Blizzard's Floating Combat Text feature. It MUST be enabled in your interface options for the text to be outputted."
L["CHAT_MSG_SMART"] = "Smart Channel"
L["CHAT_MSG_SMART_DESC"] = "Will output to Battleground, Raid, Party, or Say - whichever is appropriate."
L["CHAT_MSG_CHANNEL"] = "Chat Channel"
L["CHAT_MSG_CHANNEL_DESC"] = "Will output to a chat channel, such as Trade, or a custom channel that you have joined."


L["CHAT_FRAME"] = "Chat Frame"
L["RAID_WARNING_FAKE"] = "Raid Warning (Fake)"
L["RAID_WARNING_FAKE_DESC"] = "Outputs a message as a raid warning, but nobody else will see it, and you do not have to be in a raid or have raid warning privelages"
L["ERRORS_FRAME"] = "Errors Frame"
L["ERRORS_FRAME_DESC"] = "Outputs the text to the standard errors frame that normally displays messages such as %q"



L["ANIM_TAB"] = "Animation"
L["ANIM_ANIMTOUSE"] = "Animation To Use"
L["ANIM_ANIMSETTINGS"] = "Settings"

L["ANIM_SECONDS"] = "%s Seconds"
L["ANIM_PIXELS"] = "%s Pixels"
L["ANIM_DURATION"] = "Animation Duration"
L["ANIM_DURATION_DESC"] = "Set how long the animation should last after it is triggered."
L["ANIM_PERIOD"] = "Flash Period"
L["ANIM_PERIOD_DESC"] = [[Set how long each flash should take - the time that the flash is shown or fading in.

Set to 0 if you don't want fading or flashing to occur.]]
L["ANIM_MAGNITUDE"] = "Shake Magnitude"
L["ANIM_MAGNITUDE_DESC"] = "Set how violent the shake should be."
L["ANIM_THICKNESS"] = "Border Thickness"
L["ANIM_THICKNESS_DESC"] = "Set how thick the border should be."
L["ANIM_SIZE_ANIM"] = "Border Outset Amount"
L["ANIM_SIZE_ANIM_DESC"] = "Set how big the entire border should be."
L["ANIM_ALPHASTANDALONE"] = "Alpha"
L["ANIM_ALPHASTANDALONE_DESC"] = "Set the maximum opacity of the animation."
L["ANIM_SIZEX"] = "Image Width"
L["ANIM_SIZEX_DESC"] = "Set how wide the image should be."
L["ANIM_SIZEY"] = "Image Height"
L["ANIM_SIZEY_DESC"] = "Set how tall the image should be."
L["ANIM_COLOR"] = "Color/Opacity"
L["ANIM_COLOR_DESC"] = "Configure the color and the opacity of the flash."
L["ANIM_FADE"] = "Fade Flashes"
L["ANIM_FADE_DESC"] = "Check to have a smooth fade between each flash. Uncheck to instantly flash."
L["ANIM_INFINITE"] = "Play Indefinitely"
L["ANIM_INFINITE_DESC"] = "Check to cause the animation to play until it is overwritten by another animation on the icon of the same type, or until the %q animation is played."
L["ANIM_TEX"] = "Texture"
L["ANIM_TEX_DESC"] = [[Choose the texture that should be overlaid.

You may enter the Name or ID of a spell that has the texture that you want to use, or you may enter a texture path, such as 'Interface/Icons/spell_nature_healingtouch', or just 'spell_nature_healingtouch' if the path is 'Interface/Icons'

You can use your own textures too as long as they are placed in WoW's directory (set this field to the path to the texture relative to WoW's root folder), are .tga or .blp format, and have dimensions that are powers of 2 (32, 64, 128, etc)]]

L["ANIM_SCREENSHAKE"] = "Screen: Shake"
L["ANIM_SCREENSHAKE_DESC"] = [[Shakes your entire screen when it is triggered.

NOTE: This will only work if you are either out of combat or if nameplates have not been enabled at all since you logged in.]]

L["ANIM_ICONSHAKE"] = "Icon: Shake"
L["ANIM_ICONSHAKE_DESC"] = "Shakes the icon when it is triggered."
L["ANIM_ACTVTNGLOW"] = "Icon: Activation Border"
L["ANIM_ACTVTNGLOW_DESC"] = "Displays the Blizzard spell activation border on the icon."
L["ANIM_ICONFLASH"] = "Icon: Color Flash"
L["ANIM_ICONFLASH_DESC"] = "Flashes a colored overlay across the icon."
L["ANIM_ICONALPHAFLASH"] = "Icon: Alpha Flash"
L["ANIM_ICONALPHAFLASH_DESC"] = "Flashes the icon itself by changing its opacity."
L["ANIM_SCREENFLASH"] = "Screen: Flash"
L["ANIM_SCREENFLASH_DESC"] = "Flashes a colored overlay across the screen."
L["ANIM_ICONFADE"] = "Icon: Fade In/Out"
L["ANIM_ICONFADE_DESC"] = "Smoothly applies any opacity changes that occured with the selected event."
L["ANIM_ICONBORDER"] = "Icon: Border"
L["ANIM_ICONBORDER_DESC"] = "Overlays a colored border on the icon."
L["ANIM_ICONOVERLAYIMG"] = "Icon: Image Overlay"
L["ANIM_ICONOVERLAYIMG_DESC"] = "Overlays a custom image over the icon."
L["ANIM_ICONCLEAR"] = "Icon: Stop Animations"
L["ANIM_ICONCLEAR_DESC"] = "Stops all animations that are playing on the current icon."

L["ANIM_ANCHOR_NOT_FOUND"] = "Couldn't find frame named %q to anchor an animation to. Is this frame not used by the icon's current view?"


L["EVENTHANDLER_LUA_TAB"] = "Lua (Advanced)"
L["EVENTHANDLER_LUA_LUA"] = "Lua"
L["EVENTHANDLER_LUA_CODE"] = "Lua Code to Execute"
L["EVENTHANDLER_LUA_CODE_DESC"] = "Type the Lua code that should be executed when the event is triggered here."



L["CLEU_"] = "Any event" -- match any event
L["CLEU_DAMAGE_SHIELD"] = "Damage Shield"
L["CLEU_DAMAGE_SHIELD_DESC"] = "Occurs when a damage shield (%s, %s, etc., but not %s) damage a unit."
L["CLEU_DAMAGE_SHIELD_MISSED"] = "Damage Shield Missed"
L["CLEU_DAMAGE_SHIELD_MISSED_DESC"] = "Occurs when a damage shield (%s, %s, etc., but not %s) fails to damage a unit."
L["CLEU_DAMAGE_SPLIT"] = "Damage Split"
L["CLEU_DAMAGE_SPLIT_DESC"] = "Occurs when damage is split between two or more targets."
L["CLEU_ENCHANT_APPLIED"] = "Enchant Applied"
L["CLEU_ENCHANT_APPLIED_DESC"] = "Covers temporary weapon enchants like rogue poisons and shaman imbues."
L["CLEU_ENCHANT_REMOVED"] = "Enchant Removed"
L["CLEU_ENCHANT_REMOVED_DESC"] = "Covers temporary weapon enchants like rogue poisons and shaman imbues."
L["CLEU_ENVIRONMENTAL_DAMAGE"] = "Environmental Damage"
L["CLEU_ENVIRONMENTAL_DAMAGE_DESC"] = "Includes damage from lava, fatigue, downing, and falling."
L["CLEU_RANGE_DAMAGE"] = "Ranged Damage"
L["CLEU_RANGE_MISSED"] = "Ranged Miss"
L["CLEU_SPELL_AURA_APPLIED"] = "Aura Applied"
L["CLEU_SPELL_AURA_APPLIED_DOSE"] = "Aura Stack Applied"
L["CLEU_SPELL_AURA_BROKEN"] = "Aura Broken"
L["CLEU_SPELL_AURA_BROKEN_SPELL"] = "Aura Broken by Spell"
L["CLEU_SPELL_AURA_BROKEN_SPELL_DESC"] = [[Occurs when an aura, usually some form of crowd control, is broken by damage from a spell.

The aura that was broken is what the icon filters by; the spell that broke it can be accessed with the substitution [Extra] in text displays.]]
L["CLEU_SPELL_AURA_REFRESH"] = "Aura Refreshed"
L["CLEU_SPELL_AURA_REMOVED"] = "Aura Removed"
L["CLEU_SPELL_AURA_REMOVED_DOSE"] = "Aura Stack Removed"
L["CLEU_SPELL_STOLEN"] = "Aura Stolen"
L["CLEU_SPELL_STOLEN_DESC"] = [[Occurs when a buff is stolen, probably by %s.

Icon can be filtered by the spell that was stolen.]]
L["CLEU_SPELL_CAST_FAILED"] = "Spell Cast Failed"
L["CLEU_SPELL_CAST_START"] = "Spell Cast Start"
L["CLEU_SPELL_CAST_START_DESC"] = [[Occurs when a spell begins casting.

NOTE: To prevent potential abuse, Blizzard has excluded the destination unit from this event, so you cannot filter by it.]]

L["CLEU_SPELL_CAST_SUCCESS"] = "Spell Cast Success"
L["CLEU_SPELL_CAST_SUCCESS_DESC"] = [[Occurs when an spell is successfully cast.]]

L["CLEU_SPELL_DAMAGE"] = "Spell Damage"
L["CLEU_SPELL_DAMAGE_DESC"] = [[Occurs when any spell does any damage.]]
L["CLEU_SPELL_DAMAGE_CRIT"] = "Spell Crit"
L["CLEU_SPELL_DAMAGE_CRIT_DESC"] = [[Occurs when any spell does critical damage. This may occur at the same time as the %q event.]]
L["CLEU_SPELL_DISPEL"] = "Dispel"
L["CLEU_SPELL_DISPEL_DESC"] = [[Occurs when an aura is dispelled.

Icon can be filtered by the aura that was dispelled. The spell that dispelled it can be accessed with the substitution [Extra] in text displays.]]
L["CLEU_SPELL_DISPEL_FAILED"] = "Dispel Failed"
L["CLEU_SPELL_DISPEL_FAILED_DESC"] = [[Occurs when an aura fails to be dispelled.

Icon can be filtered by the aura that was attempted to be dispelled. The spell that attempted it can be accessed with the substitution [Extra] in text displays.]]
L["CLEU_SPELL_DRAIN"] = "Resource Drain"
L["CLEU_SPELL_DRAIN_DESC"] = "Occurs when resources (health/mana/rage/energy/etc) are removed from a unit."
L["CLEU_SPELL_ENERGIZE"] = "Resource Gain"
L["CLEU_SPELL_ENERGIZE_DESC"] = "Occurs when resources (health/mana/rage/energy/etc) are gained by a unit."
L["CLEU_SPELL_EXTRA_ATTACKS"] = "Extra Attacks Gained"
L["CLEU_SPELL_EXTRA_ATTACKS_DESC"] = "Occurs when extra melee swings are granted by procs."
L["CLEU_SPELL_HEAL"] = "Heal"
L["CLEU_SPELL_INSTAKILL"] = "Instant Kill"
L["CLEU_SPELL_INTERRUPT"] = "Interrupt - Spell Interrupted"
L["CLEU_SPELL_INTERRUPT_DESC"] = [[Occurs when a spell cast is interrupted.

Icon can be filtered by the spell that was interrupted. The interrupt spell that interrupted it can be accessed with the substitution [Extra] in text displays.

Note the difference between the two interrupt events - both will always occur when a spell is interrupted, but each filters the spells involved differently.]]
L["CLEU_SPELL_INTERRUPT_SPELL"] = "Interrupt - Interrupt Spell Used"
L["CLEU_SPELL_INTERRUPT_SPELL_DESC"] = [[Occurs when a spell cast is interrupted.

Icon can be filtered by the spell that caused the interrupt. The spell that was interrupted can be accessed with the substitution [Extra] in text displays.

Note the difference between the two interrupt events - both will always occur when a spell is interrupted, but each filters the spells involved differently.]]
L["CLEU_SPELL_LEECH"] = "Resource Leech"
L["CLEU_SPELL_LEECH_DESC"] = "Occurs when resources (health/mana/rage/energy/etc) are removed from one unit and simultaneously given to another."
L["CLEU_SPELL_MISSED"] = "Spell Miss"
L["CLEU_SPELL_CREATE"] = "Spell Create"
L["CLEU_SPELL_CREATE_DESC"] = "Occurs when an object, such as a hunter trap or a mage portal, is created."
L["CLEU_SPELL_SUMMON"] = "Spell Summon"
L["CLEU_SPELL_SUMMON_DESC"] = "Occurs when an NPC, such as a pet or a totem, is summoned or spawned."
L["CLEU_SPELL_RESURRECT"] = "Resurrection"
L["CLEU_SPELL_RESURRECT_DESC"] = "Occurs when a unit is resurrected from death."
L["CLEU_SPELL_REFLECT"] = "Spell Reflect" -- custom event
L["CLEU_SPELL_REFLECT_DESC"] = [[Occurs when you reflect a spell back at its caster.

The source unit is whoever reflected it, the destination unit is whoever it was reflected back at]]
L["CLEU_SPELL_PERIODIC_DAMAGE"] = "Periodic Damage"
L["CLEU_SPELL_PERIODIC_DRAIN"] = "Periodic Resource Drain"
L["CLEU_SPELL_PERIODIC_ENERGIZE"] = "Periodic Resource Gain"
L["CLEU_SPELL_PERIODIC_LEECH"] = "Periodic Leech"
L["CLEU_SPELL_PERIODIC_HEAL"] = "Periodic Heal"
L["CLEU_SPELL_PERIODIC_MISSED"] = "Periodic Miss"
L["CLEU_SWING_DAMAGE"] = "Swing Damage"
L["CLEU_SWING_MISSED"] = "Swing Miss"
L["CLEU_UNIT_DESTROYED"] = "Unit Destroyed"
L["CLEU_UNIT_DESTROYED_DESC"] = "Occurs when a unit such as a totem is destroyed."
L["CLEU_UNIT_DIED"] = "Unit Died"
L["CLEU_PARTY_KILL"] = "Party Kill"
L["CLEU_PARTY_KILL_DESC"] = "Occurs when someone in your party kills something."

L["CLEU_CAT_CAST"] = "Casts"
L["CLEU_CAT_SWING"] = "Melee/Ranged"
L["CLEU_CAT_SPELL"] = "Spells"
L["CLEU_CAT_AURA"] = "Buffs/Debuffs"
L["CLEU_CAT_MISC"] = "Miscellaneous"


L["CLEU_COMBATLOG_OBJECT_NONE"] = "Miscellaneous: Unknown Unit"
L["CLEU_COMBATLOG_OBJECT_NONE_DESC"] = "Check to exclude units that are completely unknown to the WoW client. This very rarely occurs, and can generally be left unchecked."
L["CLEU_COMBATLOG_OBJECT_MAINASSIST"] = "Miscellaneous: Main Assist"
L["CLEU_COMBATLOG_OBJECT_MAINASSIST_DESC"] = "Check to exclude units marked as main assists in your raid."
L["CLEU_COMBATLOG_OBJECT_MAINTANK"] = "Miscellaneous: Main Tank"
L["CLEU_COMBATLOG_OBJECT_MAINTANK_DESC"] = "Check to exclude units marked as main tanks in your raid."
L["CLEU_COMBATLOG_OBJECT_FOCUS"] = "Miscellaneous: Your Focus"
L["CLEU_COMBATLOG_OBJECT_FOCUS_DESC"] = "Check to exclude the unit that you have set as your focus."
L["CLEU_COMBATLOG_OBJECT_TARGET"] = "Miscellaneous: Your Target"
L["CLEU_COMBATLOG_OBJECT_TARGET_DESC"] = "Check to exclude the unit that you are targeting."

L["CLEU_COMBATLOG_OBJECT_TYPE_OBJECT"] = "Unit Type: Object"
L["CLEU_COMBATLOG_OBJECT_TYPE_OBJECT_DESC"] = "Check to exclude units such as traps, fishing bobbers, or anything else that does not fall under the other \"Unit Type\" categories."
L["CLEU_COMBATLOG_OBJECT_TYPE_GUARDIAN"] = "Unit Type: Guardian"
L["CLEU_COMBATLOG_OBJECT_TYPE_GUARDIAN_DESC"] = "Check to exclude Guardians. Guardians are units that defend their controller but cannot be directly controlled."
L["CLEU_COMBATLOG_OBJECT_TYPE_PET"] = "Unit Type: Pet"
L["CLEU_COMBATLOG_OBJECT_TYPE_PET_DESC"] = "Check to exclude Pets. Pets are units that defend their controller and can be directly controlled."
L["CLEU_COMBATLOG_OBJECT_TYPE_NPC"] = "Unit Type: NPC"
L["CLEU_COMBATLOG_OBJECT_TYPE_NPC_DESC"] = "Check to exclude non-player characters."
L["CLEU_COMBATLOG_OBJECT_TYPE_PLAYER"] = "Unit Type: Player Character"
L["CLEU_COMBATLOG_OBJECT_TYPE_PLAYER_DESC"] = "Check to exclude player characters."
L["CLEU_COMBATLOG_OBJECT_TYPE_MASK"] = "Unit Type"

L["CLEU_COMBATLOG_OBJECT_CONTROL_NPC"] = "Controller: Server"
L["CLEU_COMBATLOG_OBJECT_CONTROL_NPC_DESC"] = "Check to exclude units that are controlled by the server, including their pets and guardians."
L["CLEU_COMBATLOG_OBJECT_CONTROL_PLAYER"] = "Controller: Human"
L["CLEU_COMBATLOG_OBJECT_CONTROL_PLAYER_DESC"] = "Check to exclude units that are controlled by human beings, including their pets and guardians."
L["CLEU_COMBATLOG_OBJECT_CONTROL_MASK"] = "Controller"

L["CLEU_COMBATLOG_OBJECT_REACTION_HOSTILE"] = "Unit Reaction: Hostile"
L["CLEU_COMBATLOG_OBJECT_REACTION_HOSTILE_DESC"] = "Check to exclude units that are hostile towards you."
L["CLEU_COMBATLOG_OBJECT_REACTION_NEUTRAL"] = "Unit Reaction: Neutral"
L["CLEU_COMBATLOG_OBJECT_REACTION_NEUTRAL_DESC"] = "Check to exclude units that are neutral towards you."
L["CLEU_COMBATLOG_OBJECT_REACTION_FRIENDLY"] = "Unit Reaction: Friendly"
L["CLEU_COMBATLOG_OBJECT_REACTION_FRIENDLY_DESC"] = "Check to exclude units that are friendly towards you."
L["CLEU_COMBATLOG_OBJECT_REACTION_MASK"] = "Unit Reaction"

L["CLEU_COMBATLOG_OBJECT_AFFILIATION_OUTSIDER"] = "Controller Relationship: Outsiders"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_OUTSIDER_DESC"] = "Check to exclude units that are controlled by someone who not is grouped with you."
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_RAID"] = "Controller Relationship: Raid Members"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_RAID_DESC"] = "Check to exclude units that are controlled by someone who is in your raid group."
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_PARTY"] = "Controller Relationship: Party Members"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_PARTY_DESC"] = "Check to exclude units that are controlled by someone who is in your party."
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MINE"] = "Controller Relationship: Player (You)"
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MINE_DESC"] = "Check to exclude units that are controlled by you."
L["CLEU_COMBATLOG_OBJECT_AFFILIATION_MASK"] = "Controller Relationship"


L["CLEU_WHOLECATEGORYEXCLUDED"] = [[You have excluded every part of the %q category, which will cause this icon to never process any events.

Uncheck at least one for proper functionality.]]

L["CLEU_NOFILTERS"] = [[The %s icon in %s does not have any filters defined. It will not function until you define at least one filter.]]


L["CLEU_DIED"] = "Death"

L["CLEU_HEADER"] = "Combat Event Filters"
L["CLEU_EVENTS"] = "Events to check"
L["CLEU_EVENTS_ALL"] = "All"
L["CLEU_EVENTS_DESC"] = "Choose the combat events that you would like the icon to react to."
L["CLEU_SOURCEUNITS"] = "Source unit(s) to check"
L["CLEU_SOURCEUNITS_DESC"] = "Choose the source units that you would like the icon to react to, |cff7fffffOR|r leave this blank to let the icon react to any event source."
L["CLEU_DESTUNITS"] = "Destination unit(s) to check"
L["CLEU_DESTUNITS_DESC"] = "Choose the destination units that you would like the icon to react to, |cff7fffffOR|r leave this blank to let the icon react to any event destination."

--L["CLEU_FLAGS_SOURCE"] = "Source Exclusions"
--L["CLEU_FLAGS_DEST"] = "Destination Exclusions"
L["CLEU_FLAGS_SOURCE"] = "Exclusions"
L["CLEU_FLAGS_DEST"] = "Exclusions"
L["CLEU_FLAGS_DESC"] = "Contains a list of attributes that can be used to exclude certain units from triggering the icon. If an exclusion is checked, and a unit has that attribute, the icon will not process the event that the unit was part of."

L["CLEU_TIMER"] = "Timer to set on event"
L["CLEU_TIMER_DESC"] = [[Duration of a timer, in seconds, to set on the icon when an event occurs.

You may also set durations using the "Spell: Duration" syntax in the %q editbox to be used whenever an event is handled using a spell that you have set as a filter.

If no duration is defined for a spell, or you do not have any spell filter set (the editbox is blank), then this duration will be used.]]



L["HELP_FIRSTUCD"] = [[You have used an icon type that uses the special duration syntax for the first time! Spells that are added to the %q editbox for certain icon types must define a duration immediately after each spell using the following syntax:

Spell: Duration

For example:

"%s: 120"
"%s: 10; %s: 24"
"%s: 180"
"%s: 3:00"
"62618: 3:00"

Inserting from the suggestion list automatically adds the duration from the tooltip.]]

L["HELP_MISSINGDURS"] = [[The following spells are missing durations:

%s

To add durations, use the following syntax:

Spell Name: Duration

E.g. "%s: 10"

Inserting from the suggestion list automatically adds the duration from the tooltip.]]

L["HELP_POCKETWATCH"] = [[|TInterface\Icons\INV_Misc_PocketWatch_01:20|t -- The pocket watch texture.
This texture is being used because the first valid spell being checked was entered by name and isn't in your spellbook.

The correct texture will be used once you have seen the spell as you play.

To see the correct texture now, change the first spell being checked into a Spell ID. You can easily do this by clicking on the entry in the editbox and right-clicking the correct corresponding entry in the suggestion list.]]

L["HELP_NOUNITS"] = [[You must enter at least one unit!]]
L["HELP_NOUNIT"] = [[You must enter a unit!]]
L["HELP_ONLYONEUNIT"] = [[Conditions only accept one unit, but you have entered %d |4unit:units;.]]
L["HELP_MS_NOFOUND"] = [[The ability %q could not be found on your action bars.

Ensure that the ability is on your action bars, in its default state, and that it is not only a macro that is putting the spell on your action bars. Otherwise, this icon will not function properly.]]

L["HELP_IMPORT_CURRENTPROFILE"] = [[Trying to move or copy an icon from this profile to another icon slot?

You can do so easily by |cff7fffffRight-clicking and dragging|r the icon (hold down the mouse button) to another slot. When you release the mouse button, a menu will appear with many options.

Try dragging an icon to a meta icon, another group, or another frame on your screen for other options.]]

L["HELP_EXPORT_DOCOPY_WIN"] = [[Press |cff7fffffCTRL+C|r to copy]]
L["HELP_EXPORT_DOCOPY_MAC"] = [[Press |cff7fffffCMD+C|r to copy]]


L["HELP_CNDT_PARENTHESES_FIRSTSEE"] = [[You can group sets of conditions together for complex checking functionality, especially when coupled with the %q setting.

|cff7fffffClick|r the parentheses between your conditions to group them together if you wish to do so.]]
L["HELP_CNDT_ANDOR_FIRSTSEE"] = [[You can choose whether both conditions are required to succeed or if only one needs to succeed.

|cff7fffffClick|r this setting between your conditions to change this behavior if you wish to do so.]]
L["HELP_IE_TIMERTEXTHANDLER_MISSING"] = [[TellMeWhen cannot find any installed addon that it knows to be capable of handling this setting.

If you enable this setting but do not see any timer texts, please install the addon "OmniCC" from Curse.com or WoWInterface.com.]]


L["IMPORT_ICON_DISABLED_DESC"] = "You must be editing an icon to be able to import an icon."


L["TOPLEFT"] = "Top Left"
L["TOP"] = "Top"
L["TOPRIGHT"] = "Top Right"
L["LEFT"] = "Left"
L["CENTER"] = "Center"
L["RIGHT"] = "Right"
L["BOTTOMLEFT"] = "Bottom Left"
L["BOTTOM"] = "Bottom"
L["BOTTOMRIGHT"] = "Bottom Right"

L["STRATA_BACKGROUND"] = "Background"
L["STRATA_LOW"] = "Low"
L["STRATA_MEDIUM"] = "Medium"
L["STRATA_HIGH"] = "High"
L["STRATA_DIALOG"] = "Dialog"
L["STRATA_FULLSCREEN"] = "Fullscreen"
L["STRATA_FULLSCREEN_DIALOG"] = "Fullscreen Dialog"
L["STRATA_TOOLTIP"] = "Tooltip"

-- --------
-- EQUIVS
-- --------

L["CrowdControl"] = "Crowd Control"
L["Bleeding"] = "Bleeding"
L["Feared"] = "Fear"
L["Incapacitated"] = "Incapacitated"
L["Stunned"] = "Stunned"
L["Slowed"] = "Slowed"
L["ImmuneToStun"] = "Immune To Stun"
L["ImmuneToMagicCC"] = "Immune To Magic CC"
L["Disoriented"] = "Disoriented"
L["Silenced"] = "Silenced"
L["Disarmed"] = "Disarmed"
L["Rooted"] = "Rooted"
L["Shatterable"] = "Shatterable"
L["IncreasedStats"] = "Increased Stats"
L["IncreasedCrit"] = "Increased Crit Chance"
L["IncreasedMastery"] = "Increased Mastery"
L["IncreasedAP"] = "Increased Attack Power"
L["IncreasedSP"] = "Increased Spellpower"
L["IncreasedSPsix"] = "Increased Spellpower (6%)"
L["IncreasedSPten"] = "Increased Spellpower (10%)"
L["IncreasedPhysHaste"] = "Increased Physical Haste"
L["IncreasedSpellHaste"] = "Increased Spell Haste"
L["DamageShield"] = "Damage Shield"
--L["BurstHaste"] = "Heroism/Bloodlust" -- defined in static formats
L["BonusStamina"] = "Increased Stamina"
L["BurstManaRegen"] = "Burst Mana Regen"
L["PhysicalDmgTaken"] = "Physical Damage Taken"
L["SpellDamageTaken"] = "Increased Spell Damage Taken"
L["ReducedCastingSpeed"] = "Reduced Casting Speed"
L["ReducedArmor"] = "Reduced Armor"
L["ReducedHealing"] = "Reduced Healing"
L["ReducedPhysicalDone"] = "Reduced Physical Damage Done"
L["DefensiveBuffs"] = "Defensive Buffs"
L["MiscHelpfulBuffs"] = "Misc. Helpful Buffs"
L["DamageBuffs"] = "Damage Buffs"

-- Deprecated
L["DontMelee"] = "Don't Melee"
L["MovementSlowed"] = "Movement Slowed"

L["Heals"] = "Player Heals"
L["PvPSpells"] = "PvP Crowd Control, etc."
L["Tier11Interrupts"] = "Tier 11 Interruptibles"
L["Tier12Interrupts"] = "Tier 12 Interruptibles"

L["GCD"] = "Global Cooldown"

L["Magic"] = "Magic"
L["Curse"] = "Curse"
L["Disease"] = "Disease"
L["Poison"] = "Poison"
L["Enraged"] = "Enrage"

L["normal"] = "Normal"
L["rare"] = "Rare"
L["elite"] = "Elite"
L["rareelite"] = "Rare Elite"
L["worldboss"] = "World Boss"

L["RaidWarningFrame"] = "Raid Warning Frame"

L["DAMAGER"] = "Damage"
L["HEALER"] = "Heal"
L["TANK"] = "Tank"


L["DR-RandomStun"] = "Random stuns"
L["DR-ControlledStun"] = "Controlled stuns"
L["DR-Scatter"] = "Scatter Shot"
L["DR-Fear"] = "Fears"
L["DR-Silence"] = "Silences"
L["DR-Banish"] = "Banish"
L["DR-MindControl"] = "Mind Control"
L["DR-Entrapment"] = "Entrapment"
L["DR-Taunt"] = "Taunts"
L["DR-Disarm"] = "Disarms"
L["DR-Horrify"] = "Horrors"
L["DR-Cyclone"] = "Cyclone"
L["DR-Disorient"] = "Disorients"
L["DR-RandomRoot"] = "Random roots"
L["DR-ControlledRoot"] = "Controlled roots"
L["DR-DragonsBreath"] = "Dragon's Breath"
L["DR-BindElemental"] = "Bind Elemental"
L["DR-Charge"] = "Charge"
L["DR-IceWard"] = "Ice Ward"

L["CONDITIONPANEL_CREATURETYPE"] = "Unit Creature Type"
L["CONDITIONPANEL_CREATURETYPE_LABEL"] = "Creature Type(s)"
L["CONDITIONPANEL_CREATURETYPE_DESC"] = [[You can enter multiple creature types to be matched by separating each one with a semicolon (;).

Creature types must be typed exactly as they appear in the creature's tooltip.

The condition will pass if any types are matched.]]


L["CREATURETYPE_1"] = "Beast"
L["CREATURETYPE_2"] = "Dragonkin"
L["CREATURETYPE_3"] = "Demon"
L["CREATURETYPE_4"] = "Elemental"
L["CREATURETYPE_5"] = "Giant"
L["CREATURETYPE_6"] = "Undead"
L["CREATURETYPE_7"] = "Humanoid"
L["CREATURETYPE_8"] = "Critter"
L["CREATURETYPE_9"] = "Mechanical"
L["CREATURETYPE_10"] = "Not specified"
L["CREATURETYPE_11"] = "Totem"
L["CREATURETYPE_12"] = "Non-combat Pet"
L["CREATURETYPE_13"] = "Gas Cloud"
L["CREATURETYPE_14"] = "Wild Pet"
