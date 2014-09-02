-------------------------------------------------------------------------------
-- Localized Lua globals.
-------------------------------------------------------------------------------
local _G = getfenv(0)

-- Functions
local pairs = _G.pairs


-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local FOLDER_NAME, private = ...


-------------------------------------------------------------------------------
-- General constants.
-------------------------------------------------------------------------------
private.KeyToggleIconTexture_Enabled = [[Interface\Icons\INV_Enchant_FormulaSuperior_01]]
private.KeyToggleIconTexture_Disabled = [[Interface\AddOns\]]..FOLDER_NAME..[[\Icons\Key_Off]]
private.PathToggleIconTexture_Enabled = [[Interface\Icons\INV_Misc_Map02]]
private.PathToggleIconTexture_Disabled = [[Interface\AddOns\]]..FOLDER_NAME..[[\Icons\Path_Off]]


	--http://wowprogramming.com/BlizzArt/Interface/ICONS/INV_MISC_NOTE_06.png
--http://wowprogramming.com/BlizzArt/Interface/ICONS/Ability_Hunter_MasterMarksman.png
--http://wowprogramming.com/BlizzArt/Interface/ICONS/INV_Misc_EngGizmos_20.png

private.NPCsFoundIgnored = {
	[ 32487 ] = true; -- Putridus the Ancient
	[ 50009 ] = true; -- Mobus
};

private.NPCAliases = { -- (Key) NPC shows (Value) NPC's path instead
	-- Note: Circular references will lock client!
	-- Madexx (Brown)
	[ 51401 ] = 50154; -- Madexx (Red)
	[ 51402 ] = 50154; -- Madexx (Green)
	[ 51403 ] = 50154; -- Madexx (Black)
	[ 51404 ] = 50154; -- Madexx (Blue)
};

private.Achievements = { -- Achievements whos criteria mobs are all mapped
		[ 1312 ] = true; -- Bloody Rare (Outlands)
		[ 2257 ] = true; -- Frostbitten (Northrend)
		[ 7317 ] = true; -- One Of Many
		[ 7439 ] = true; -- Glorious! (Pandaria)
		[ 8103 ] = true; -- Champions of Lei Shen
		[ 8714 ] = true;  --Timeless Champion
};

--Color's used for the paths.  Need to revisit to replace the duplicated colors if possible
private.Colors = {
	RAID_CLASS_COLORS.SHAMAN,
	RAID_CLASS_COLORS.DEATHKNIGHT,
	GREEN_FONT_COLOR,
	RAID_CLASS_COLORS.DRUID,
	RAID_CLASS_COLORS.PALADIN,
	UnitPopupButtons.RAID_TARGET_1.color,
	UnitPopupButtons.RAID_TARGET_5.color,
	UnitPopupButtons.RAID_TARGET_6.color,
	UnitPopupButtons.RAID_TARGET_3.color,
	RAID_CLASS_COLORS.MONK,
	RAID_CLASS_COLORS.HUNTER,

	RAID_CLASS_COLORS.SHAMAN,
	RAID_CLASS_COLORS.DEATHKNIGHT,
	GREEN_FONT_COLOR,
	RAID_CLASS_COLORS.DRUID,
	RAID_CLASS_COLORS.PALADIN,
	UnitPopupButtons.RAID_TARGET_1.color,
	UnitPopupButtons.RAID_TARGET_5.color,
	UnitPopupButtons.RAID_TARGET_6.color,
	UnitPopupButtons.RAID_TARGET_3.color,
	RAID_CLASS_COLORS.MONK,
	RAID_CLASS_COLORS.HUNTER,

	RAID_CLASS_COLORS.SHAMAN,
	RAID_CLASS_COLORS.DEATHKNIGHT,
	GREEN_FONT_COLOR,
	RAID_CLASS_COLORS.DRUID,
	RAID_CLASS_COLORS.PALADIN,
	UnitPopupButtons.RAID_TARGET_1.color,
	UnitPopupButtons.RAID_TARGET_5.color,
	UnitPopupButtons.RAID_TARGET_6.color,
	UnitPopupButtons.RAID_TARGET_3.color,
	RAID_CLASS_COLORS.MONK,
	RAID_CLASS_COLORS.HUNTER,
};

_NPCScanOverlayKeyColors = private.Colors