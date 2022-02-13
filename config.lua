Config = {}

Config.Delays = {
	WeedProcessing = 1000 * 10,
	MethProcessing = 1000 * 10,
	CokeProcessing = 1000 * 10,
	lsdProcessing = 1000 * 10,
	HeroinProcessing = 1000 * 10,
	thionylchlorideProcessing = 1000 * 10,
}

Config.ChemicalsConvertionItems = {
	hydrochloric_acid = 0,
	sodium_hydroxide = 0,
	sulfuric_acid = 0,
	lsa = 0,
}

Config.CircleZones = {
	WeedField = {coords = vector3(2224.64, 5577.03, 53.85), name = ('Weed Farm'), radius = 100.0},
	WeedProcessing = {coords = vector3(2329.12, 2571.86, 46.68), name = ('Weed Process'), radius = 100.0},
	
	MethProcessing = {coords = vector3(978.17, -147.98, -48.53), name = ('Meth Process'), radius = 20.0},
	MethTemp = {coords = vector3(982.56, -145.59, -49.0), name = ('Meth Temperature'), radius = 20.0},
	MethBag = {coords = vector3(987.81, -140.43, -49.0), name = ('Meth Bagging'), radius = 20.0},
	HydrochloricAcidFarm = {coords = vector3(-1069.25, 4945.57, 212.18), name = ('Hydrochloric Acid'), radius = 100.0},

	SulfuricAcidFarm = {coords = vector3(-3026.89, 3334.91, 10.04), name = ('Sulfuric Acid'), radius = 100.0},
	SodiumHydroxideFarm = {coords = vector3(-389.35, -1874.85, 20.53), name = ('Sodium Hydroxide'), radius = 100.0},
	
	ChemicalsField = {coords = vector3(1264.97, 1803.96, 82.94), name = ('Chemicals'), radius = 100.0},
	ChemicalsConvertionMenu = {coords = vector3(3536.71, 3662.63, 28.12), name = ('Chemicals Process'), radius = 100.0},

	CokeField = {coords = vector3(2806.5, 4774.46, 46.98), name = ('Coke'), radius = 100.0},
	CokeProcessing = {coords = vector3(-239.35, -1515.93, 33.38), name = ('Coke Process'), radius = 100.0},
	
	HeroinField = {coords = vector3(-2339.15, -54.32, 95.05), name = ('Heroin'), radius = 100.0},
	HeroinProcessing = {coords = vector3(1384.63, -2080.22, 52.61), name = ('Heroin Process'), radius = 100.0},

	lsdProcessing = {coords = vector3(2503.84, -428.11, 92.99), name = ('LSD process'), radius = 100.0},

	thionylchlorideProcessing = {coords = vector3(-679.59, 5800.46, 17.33), name = ('Thi Clo Process'), radius = 100.0},
}