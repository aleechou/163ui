-- -------------------------------------------------------------------------- --
-- GridStatusRaidIcons DEFAULT (english) Localization                         --
-- Please make sure to save this file as UTF-8. ¶                             --
-- -------------------------------------------------------------------------- --

GridStatusRaidIcons_Locales =

{
	["Opacity"] = "透明度",
	["Sets the opacity for the raid icons."] = "设置团队标记的透明度",
}

function GridStatusRaidIcons_Locales:CreateLocaleTable(t)
	for k,v in pairs(t) do
		self[k] = (v == true and k) or v
	end
end

GridStatusRaidIcons_Locales:CreateLocaleTable(GridStatusRaidIcons_Locales)