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
	WeedField = {coords = vector3(2224.64, 5577.03, 53.85), name = ("Daniel's Farm"), radius = 100.0},
	WeedProcessing = {coords = vector3(2329.12, 2571.86, 46.68), name = ("Daniel's Verarbeiter"), radius = 100.0},
	
	MethProcessing = {coords = vector3(978.17, -147.98, -48.53), name = ('Meth Labor'), radius = 20.0},
	MethTemp = {coords = vector3(982.56, -145.59, -49.0), name = ('Meth Temperatur'), radius = 20.0},
	MethBag = {coords = vector3(987.81, -140.43, -49.0), name = ('Meth Verpackung'), radius = 20.0},
	HydrochloricAcidFarm = {coords = vector3(-1069.25, 4945.57, 212.18), name = ('Salzsäure'), radius = 100.0},

	SulfuricAcidFarm = {coords = vector3(-3026.89, 3334.91, 10.04), name = ('Schwefelsäure'), radius = 100.0},
	SodiumHydroxideFarm = {coords = vector3(-389.35, -1874.85, 20.53), name = ('Natriumhydroxid'), radius = 100.0},
	
	ChemicalsField = {coords = vector3(1264.97, 1803.96, 82.94), name = ('Chemieabfall'), radius = 100.0},
	ChemicalsConvertionMenu = {coords = vector3(3536.71, 3662.63, 28.12), name = ('Chemielabor'), radius = 100.0},

	CokeField = {coords = vector3(2806.5, 4774.46, 46.98), name = ('Schlafmohn'), radius = 100.0},
	CokeProcessing = {coords = vector3(1087.14, -3195.31, -38.99), name = ('Kokainlabor'), radius = 20.0}, 
	CokePowder = {coords = vector3(1092.9, -3196.65, -38.99), name = ('Kokain Pulverisierung'), radius = 20.0},--vector3(1092.9, -3196.65, -38.99)
	CokeBrick = {coords = vector3(1099.57, -3194.35, -38.99), name = ('Kokain Verpackung'), radius = 20.0},--vector3(1099.57, -3194.35, -38.99)
	
	HeroinField = {coords = vector3(-2339.15, -54.32, 95.05), name = ('Heroin'), radius = 100.0},
	HeroinProcessing = {coords = vector3(1384.63, -2080.22, 52.61), name = ('Heroin Labor'), radius = 100.0},

	lsdProcessing = {coords = vector3(2503.84, -428.11, 92.99), name = ('LSD Labor'), radius = 100.0},

	thionylchlorideProcessing = {coords = vector3(-679.59, 5800.46, 17.33), name = ('Thionylchlorid Labor'), radius = 100.0},
}


Config.MethLab = {
	["enter"] = {
        coords = vector4(-1187.17, -446.24, 43.91, 306.59),
    },
    ["exit"] = {
        coords = vector4(969.57, -147.07, -46.4, 267.52),  --vector3(969.57, -147.07, -46.4)
    },
}

Config.CokeLab = {
	["enter"] = {
        coords = vector4(813.21, -2398.69, 23.66, 171.51), --vector3(813.21, -2398.69, 23.66)
    },
    ["exit"] = {
        coords = vector4(1088.68, -3187.68, -38.99, 176.04), -- GTA DLC Biker Cocaine Lab -- vector3(1088.68, -3187.68, -38.99)
    },
}

Config.WeedLab = {
	--[[["enter"] = {
        coords = vector4(813.21, -2398.69, 23.66, 171.51), --vector3(813.21, -2398.69, 23.66)
    },
    ["exit"] = {
        coords = vector4(1088.68, -3187.68, -38.99, 176.04), -- GTA DLC Biker Cocaine Lab -- vector3(1088.68, -3187.68, -38.99)
    },]]--
}
