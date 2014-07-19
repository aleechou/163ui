BGD_RcSMZone = {}
BGD_RcSMZone.__index = BGD_RcSMZone

setmetatable(BGD_RcSMZone, {
		__index = BGD_RayCast_base, -- inherit from RayCast_base
		__call = function (cls, ...)
			local self = setmetatable({}, cls)
			self:_init(...)
			return self
		end, 
	})

function BGD_RcSMZone:_init(init1, init2)
	BGD_RayCast_base._init(self, init1) -- call the base class constructor

   -- Initialize this class - Nothing to do atm.
end

BGD_RcSMZone.zones = {
	["rock"] = {
		{11.196951024,  40.6222051609},
		{43.0321078471, 23.663367037},
		{50.4468706956, 35.2475255075},
		{18.2058920473, 60.2970293687}},

	["top"] = {
		{42.9990058021, 23.3663369794},
		{66.4018520987, 9.0099015302},
		{83.4822915118, 12.8712875722},
		{77.1267741357, 52.0792081073},
		{65.3426004826, 46.1386138432},
		{68.0569328449, 33.8118819511},
		{66.3356487767, 28.4158422187},
		{61.1717965723, 25.2475250481},
		{50.6123786166, 35.2722782995}},

	["water"] = {
		{43.9589528191, 49.1089109752},
		{50.1820581756, 58.1188123906},
		{44.6871885932, 69.2079207648},
		{48.0635541754, 87.7227725433},
		{37.4710349427, 96.9306928487},
		{25.6206548958, 88.8118816066},
		{36.8752058126, 58.0198023714}},

	["lava"] = {
		{63.9523330245, 60.0000004594},
		{56.007942832,  85.643564436},
		{75.2730864954, 95.0495047799},
		{82.0920194459, 65.5445546465},
		{76.0675255914, 55.5445541871}}
}
