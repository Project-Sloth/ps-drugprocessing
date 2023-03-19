Config = {}

Config.KeyRequired = true

Config.Delays = {
	WeedProcessing = 1000 * 10,
	MethProcessing = 1000 * 10,
	CokeProcessing = 1000 * 10,
	lsdProcessing = 1000 * 10,
	HeroinProcessing = 1000 * 10,
	thionylchlorideProcessing = 1000 * 10,
}

Config.CircleZones = {
	WeedField = {coords = vector3(2224.64, 5577.03, 53.85), name = ('Weed Farm'), radius = 100.0},
	WeedProcessing = {coords = vector3(1038.33, -3204.44, -38.17), name = ('Weed Process'), radius = 100.0},
	
	MethProcessing = {coords = vector3(978.17, -147.98, -48.53), name = ('Meth Process'), radius = 20.0},
	MethTemp = {coords = vector3(982.56, -145.59, -49.0), name = ('Meth Temperature'), radius = 20.0},
	MethBag = {coords = vector3(987.81, -140.43, -49.0), name = ('Meth Bagging'), radius = 20.0},
	HydrochloricAcidFarm = {coords = vector3(-1069.25, 4945.57, 212.18), name = ('Hydrochloric Acid'), radius = 100.0},

	SulfuricAcidFarm = {coords = vector3(-3026.89, 3334.91, 10.04), name = ('Sulfuric Acid'), radius = 100.0},
	SodiumHydroxideFarm = {coords = vector3(-389.35, -1874.85, 20.53), name = ('Sodium Hydroxide'), radius = 100.0},
	
	ChemicalsField = {coords = vector3(1264.97, 1803.96, 82.94), name = ('Chemicals'), radius = 100.0},
	ChemicalsConvertionMenu = {coords = vector3(3536.71, 3662.63, 28.12), name = ('Chemicals Process'), radius = 100.0},

	CokeField = {coords = vector3(2806.5, 4774.46, 46.98), name = ('Coke'), radius = 100.0},
	CokeProcessing = {coords = vector3(1087.14, -3195.31, -38.99), name = ('Coke Process'), radius = 20.0}, 
	CokePowder = {coords = vector3(1092.9, -3196.65, -38.99), name = ('Powder Cutting'), radius = 20.0},--vector3(1092.9, -3196.65, -38.99)
	CokeBrick = {coords = vector3(1099.57, -3194.35, -38.99), name = ('Brick Up Packages'), radius = 20.0},--vector3(1099.57, -3194.35, -38.99)
	
	HeroinField = {coords = vector3(-2339.15, -54.32, 95.05), name = ('Heroin'), radius = 100.0},
	HeroinProcessing = {coords = vector3(1413.37, -2041.74, 52.0), name = ('Heroin Process'), radius = 100.0},

	lsdProcessing = {coords = vector3(2503.84, -428.11, 92.99), name = ('LSD process'), radius = 100.0},

	thionylchlorideProcessing = {coords = vector3(-679.59, 5800.46, 17.33), name = ('Thi Clo Process'), radius = 100.0},
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
	["enter"] = {
		coords = vector4(102.07, 175.09, 104.59, 165.63), 
    },
    ["exit"] = {
        coords = vector4(1066.01, -3183.38, -39.16, 93.01), -- GTA DLC Weed Lab -- 
    },
}


--------------------------------
-- DRUG CONFIG AMOUNTS --
--------------------------------

--------------------------------
-- COKE PROCESSING AMOUNTS --
--------------------------------

Config.CokeProcessing = {
	CokeLeaf = 1, -- Amount of Leaf Needed to Process
	ProcessCokeLeaf = math.random(2,7), -- Amount of Coke Received
	-- Processing Small Bricks --
	Coke = 10, -- Amount of Coke Needed for Small Brick
	BakingSoda = 5, -- Amount of Baking Soda Needed for Small Brick
	SmallCokeBrick = math.random(2,7),
	-- Process Small Bricks Into Large Brick --
	SmallBrick = 4, -- Amount of Small Bricks Required
	LargeBrick = 1, -- Large Bricks Received
}

--------------------------------
-- METH PROCESSING AMOUNTS --
--------------------------------
Config.MethProcessing = {
	-- Chemical Processing --
	SulfAcid = 1, -- Amount of Sulfuric Acid Needed for Liquid Mix
	HydAcid = 1, -- Amount of Hydrochloric Acid Needed for Liquid Mix
	SodHyd = 1, -- Amount of Sodium Hydroxide Needed for Liquid Mix
	Meth = math.random(5,12), -- Amount of Meth Recevied From 1 Tray
}

--------------------------------
-- HEROIN PROCESSING AMOUNTS --
--------------------------------
Config.HeroinProcessing = {
	Poppy = 2 -- Amount of Poppy Required for 1 Heroin
}
