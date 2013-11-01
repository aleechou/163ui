--[[

	Special Cases = When there are several combines that yield the same itemid

	[itemid] = "index1,index2,..."
	[indexi] = "itemid"

]]--


TradeskillInfo.vars.specialcases = {
	[3577]	= "1,2",
	[6037]	= "3,4",
	[7080]	= "5,6",
	[7076]	= "7,8",
	[21884]	= "9,10",
	[21885]	= "11,12",
	[22452]	= "13,14",
	[10577]	= "15,16",
	[18258]	= "17,18",
	[22448]	= "19,20",
	[22449]	= "21,22",
	[35624]	= "23,24",
	[35622]	= "25,26",
	[35623]	= "27,28",
	[35627]	= "29,30",
	[35625]	= "31,32",
	[36860]	= "33,34",
	[41163]	= "35,36",
	[51950]	= "37,38",
	[54440]	= "39,40,41,42,43,44",
	[53051]	= "45,46",
	[72986]	= "47,48",				-- Heavy Windwool Bandage
	[72095]	= "49,50",				-- Smelt Trillium
	[74247]	= "51,52",				-- Ethereal Shard
	[76132] = "53,54",				-- Primal Diamond
	[72163] = "55,56,57",			-- Magnificent Hide
	[72104]	= "59,60",				-- Living Steel
	[74250]	= "61,62",				-- Mysterious Essence
	[12655] = "63,64",				-- Enchanted Thorium Bar
	[98717] = "65,66",				-- Balanced Trillium Ingot
}


-- add the reverse mappings to special cases
do
	local tmpTbl = {}

	for i, v in pairs(TradeskillInfo.vars.specialcases) do
		i = tostring(i)

		for idx in v:gmatch("(%d+),?%s*") do
			tmpTbl[tonumber(idx)] = i
		end
	end

	for i, v in pairs(tmpTbl) do
		TradeskillInfo.vars.specialcases[i] = v
	end
end
