local _G = _G
local AtlasLoot = _G.AtlasLoot
local Styler = {}

AtlasLoot.Styler = Styler

local Styles = {}

function Styler.Get(frame, optName)

end

function Styler.AddFrame(frame, onSetFunc)
	
end

--- Adds a style for the GUI
-- @param	styleName		unique name for the table ( like addonName_Style1 )
-- @param	locStyleName	the shown name in the options for the style
-- @param	styleTable		infos about the styles
function Styler.AddStyle(styleName, locStyleName, styleTable)
	Styles[styleName] = styleTable
end

function Styler.Refresh()
	
end