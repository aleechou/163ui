--[=[
	Modify order in this file, it'll be loaded after default order, so you may use them in game.
]=]


--[=[


JPACK_ORDER = {} -- repack order
JPACK_DEPOSIT = {} -- save what to bank
JPACK_DRAW = {} -- take what from bank

-- ignore specific from repack
JPACK_IGNORE_BAGS = {
	-- containors
	[0] = false, -- change to true to ignore
	[1] = true, -- like this
	[2] = false,
	[3] = false,
	[4] = false,
	
	-- banks
	[-1] = false,
	[5] = false,
	[6] = false,
	[7] = false,
	[8] = false,
	[9] = false,
	[10] = false,
	[11] = false,
}

-- this is my order
JPACK_ORDER = {
	'炉石',
	'气阀微粒提取器',
	'矿工锄',
	'剥皮小刀',
	'#鱼竿',
	'##材料',
	'#武器',
	'#护甲',
	'#配方',
	'#其它',
	'#商品',
	'#消耗品',
	'#商品',
	'鱼油',
	'#任务',
	'##任务',
	'#珠宝',
}


]=]


--[===[@debug@
-- example
JPACK_ORDER = {
	'炉石',
	'气阀微粒提取器',
	'矿工锄',
	'剥皮小刀',
	'#鱼竿',
	'##材料',
	'#武器',
	'#护甲',
	'#配方',
	'#其它',
	'#商品',
	'#消耗品',
	'#商品',
	'鱼油',
	'#任务',
	'##任务',
	'#珠宝',
}
JPACK_DEPOSIT = {}
JPACK_DRAW = {}
--@end-debug@]===]

