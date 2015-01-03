local L = LibStub("AceLocale-3.0"):NewLocale("ExtraCD", "enUS", true )
if not L then return end

L["General"] = true
L["Load Config"] = true
L["Profiles"] = true
L["talent"] = true
L["Scan and show internal cooldown of player's talent."] = true
L["enchant"] = true
L["Scan and show internal cooldown of player's enchant."] = true
L["item"] = true
L["Scan and show internal cooldown of player's trinket and special weapons."] = true
L["item set"] = true
L["Scan and show internal cooldown of player's item set."] = true
L["Lock frame"] = true
L["Set the frame locked."] = true
L["Combat only"] = true
L["Show the icon only in combat."] = true
L["Show tooltip"] = true
L["Show tooltip for the icons."] = true
L["Icons each row"] = true
L["Set the icons in each row"] = true
L["Text font"] = true
L["Set the font of the text"] = true
L["Text opacity"] = true
L["Text size"] = true
L["Set the cooldown text size"] = true
L["Icon interval"] = true
L["Set the interval size between icons"] = true
L["Icon size"] = true
L["Set the icon size"] = true
L["Blacklist"] = true
L["When you crtl+right click at the icon, it will be disabled. If you want to show it again, enable the spell in the list in advance option. The disabled spells will be at the end of the spell list."] = true
L["Icon border"] = true
L["Set the icon border"] = true
-- new
L["Advance"] = true
L["Add New CD"] = true
L["Proc Test"] = true
L["Data"] = true

L["Automatically scan and load icds of the types below"] = true
L["spec"] = true
L["Scan and show internal cooldown of player's specializations."] = true
L["Add a new custom cd(no limit of being an icd), and manage it by yourself.(marked with '*')"] = true
L["Data options provide more customized options for adding new cds and modifying the original cds"] = true
L["To reset all addon original data, your custom data and proc test data will not be changed"] = true
L["Are you sure to reset all addon original data?"] = true
L["Reset Original Data"] = true
L["Delete Custom Data"] = true
L["To delete all custom data, the addon original data and proc test data will not be changed"] = true
L["To unlock or lock the original data. It's suggested that you should not modify the addon original data, some advance users may need this feature."] = true
L["Are you sure to delete all custom data?"] = true
L["Unlock Original Data"] = true 
L["Lock Original Data"] = true
L["Proc test provides the feature of testing coverage of proc and estimating the real icds of the unknown"] = true
L["Add a new proc test(no limit of being a proc), and manage it by yourself."] = true
L["Add New Proc Test"] = true
L["Class"] = true
L["Type"] = true
L["CD"] = true
L["Duration"] = true
L["Spell ID"] = true
L["DELETE"] = true
L["already exists."] = true
L["Name"] = true
L["spell not exists, id:"] = true
L["Are you sure to delete the data?"] = true
L["Glow opacity"] = true

-- proc test
L["Minimum interval: "] = true
L["Maximum interval: "] = true
L["Average interval: "] = true
L["Estimated CD: "] = true
L["Total number of test samples: "] = true
L["Buff duration"] = true
L["Combat time"] = true
L["Calculate"] = true
L["Number of times: "] = true
L["Total proc duration: "] = true
L["Average coverage: "] = true
L["Refresh"] = true
L["Exact CD"] = true
L["In general, no need to set this field. If the exact cd of this spell is already known and does not equal to the estimated cd, add it here to calculate more accurately."] = true
L["Set this field 0 to calculate the average coverage in infinite time, otherwise calculate the coverage in the specified time"] = true
L["Show cooldown"] = true
L["Show cooldown upon the icons."] = true
L["Show glow"] = true
L["Show glow for the icons."] = true
L["Show cooldonw text"] = true
L["Show cooldown text for the procs."] = true

--sorting
L["Sorting options provide the feature to sort the order of icons by yourself."] = true
L["Enable custom sorting"] = true
L["Move up"] = true
L["Move down"] = true
L["Sorting"] = true

--rppm
L["RPPM"] = true
L["RPPM Options"] = true
L["Show icons for RPPM"] = true
L["Show icons for enchants or items with RPPM"] = true
L["Modified rppm"] = true
L["Show rppm modified by player stat and time since last proc(the number is capped by 6 out of combat)"] = true
L["gem"] = true
L["Scan and show player's special(legendary) gems"] = true

-- WOD new
L["Refreshable"] = true
L["Check this if the buff is refreshable up to 130% normal duration."] = true