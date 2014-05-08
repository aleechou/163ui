local L = _G.JPackLocale


local dataobj = LibStub:GetLibrary('LibDataBroker-1.1'):NewDataObject('JPack', {
	type = 'launcher',
	label = 'JPack',
	icon = 'Interface\\Icons\\INV_Misc_Bag_10_Green',
})

dataobj.OnTooltipShow = function(tooltip)
	if not tooltip or not tooltip.AddLine then return end
	
	tooltip:AddLine('|cff32cd32JPack|r')
	tooltip:AddDoubleLine(L['Sequence'], JPackDB.asc and L['asc'] or L['desc'], 1, 1, 0, 1, 1, 1)
	
	tooltip:AddLine(' ')
	tooltip:AddDoubleLine(L['Click'], L['Pack'], 0, 1, 0, 0, 1, 0)
	if JPack.DEV_MOD then tooltip:AddDoubleLine(L['Alt + Left-Click'], L['Packup guildbank'], 0, 1, 0, 0, 1, 0) end
	tooltip:AddDoubleLine(L['Shift + Left-Click'], L['Save to the bank'], 0, 1, 0, 0, 1, 0)
	tooltip:AddDoubleLine(L['Ctrl + Left-Click'], L['Load from the bank'], 0, 1, 0, 0, 1, 0)
	tooltip:AddDoubleLine(L['Shift + Right-Click'], L['Set sequence to ascend'], 0, 1, 0, 0, 1, 0)
	tooltip:AddDoubleLine(L['Ctrl + Right-Click'], L['Set sequence to descend'], 0, 1, 0, 0, 1, 0)

	tooltip:AddLine(' ')
	tooltip:AddLine(L['HELP'], 0, 1, 0)
end

dataobj.OnClick = function(_, button)
	local access, order
	if ( button == 'LeftButton' ) then
		if IsShiftKeyDown() then
			access = 1
		elseif IsControlKeyDown() then
			access = 2
		elseif IsAltKeyDown() then
			access = 3
		end
	elseif ( button == 'RightButton' ) then
		if IsShiftKeyDown() then
			order = 1
		elseif IsControlKeyDown() then
			order = 2
		end
	end
	JPack:Pack(access, order)
end
