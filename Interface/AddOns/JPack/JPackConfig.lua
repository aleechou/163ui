--[=[
	Modify order in this file, it'll be loaded after default order, so you may use them in game.
]=]

JPACK_ORDER = {} -- repack order
JPACK_DEPOSIT = {} -- save what to bank
JPACK_DRAW = {} -- take what from bank

-- ignore specific from repack
JPACK_IGNORE_BAGS = {
	-- containors
	[0] = false, -- change to true to ignore
	[1] = false, -- like this
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
	'协同披风',
	'协和披风',
	'协作披风',
	'暖阳合剂',
	'冬噬合剂',
	'大地合剂',
	'春华合剂',
	'秋叶合剂',
	'青龙药水',
	'兔妖之啮',
	'魔古之力药水',
	'气阀微粒提取器',
	'矿工锄',
	'剥皮小刀',
	'#鱼竿',
	'#武器',
	'#护甲',
	'#配方',
	'#其它',
	'#商品',
	'鱼油',
	'#消耗品',
	'#珠宝',
	'#任务',
	'##任务',
	
}





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
	'#珠宝',
	'#任务',
	'##任务',

}
JPACK_DEPOSIT = {}
JPACK_DRAW = {}
--@end-debug@]===]

