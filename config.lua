Config = {}
ps = exports.ps_lib:init()
Config.KeyRequired = true
Config.Drugs = {
	coke = {
		{loc = vector3(2812.77, 4785.87, 46.61), taken = false, model = 'h4_prop_bush_cocaplant_01'},
		{loc = vector3(2824.06, 4778.93, 47.34), taken = false, model = 'h4_prop_bush_cocaplant_01'},
		{loc = vector3(2826.23, 4760.15, 46.69), taken = false, model = 'h4_prop_bush_cocaplant_01'},
		{loc = vector3(2814.22, 4744.70, 45.73), taken = false, model = 'h4_prop_bush_cocaplant_01'},
		{loc = vector3(2794.96, 4754.71, 45.32), taken = false, model = 'h4_prop_bush_cocaplant_01'},
		{loc = vector3(2791.65, 4772.15, 45.87), taken = false, model = 'h4_prop_bush_cocaplant_01'},
		{loc = vector3(2789.54, 4783.35, 45.35), taken = false, model = 'h4_prop_bush_cocaplant_01'},
		{loc = vector3(2798.90, 4788.74, 45.65), taken = false, model = 'h4_prop_bush_cocaplant_01'},
		{loc = vector3(2808.10, 4778.35, 46.11), taken = false, model = 'h4_prop_bush_cocaplant_01'},
	},
	WeedPlants = {
		{loc = vector3(2215.61, 5579.80, 52.95), taken = false, model = 'mw_weed_plant'},
		{loc = vector3(2213.41, 5580.08, 52.93), taken = false, model = 'mw_weed_plant'},
		{loc = vector3(2211.25, 5580.06, 53.02), taken = false, model = 'mw_weed_plant'},
		{loc = vector3(2210.29, 5580.22, 53.07), taken = false, model = 'mw_weed_plant'},
		{loc = vector3(2214.72, 5577.55, 52.82), taken = false, model = 'mw_weed_plant'},
		{loc = vector3(2212.53, 5577.69, 52.81), taken = false, model = 'mw_weed_plant'},
		{loc = vector3(2211.35, 5577.83, 52.87), taken = false, model = 'mw_weed_plant'},
		{loc = vector3(2210.29, 5577.90, 52.92), taken = false, model = 'mw_weed_plant'},
	},
	chemicals = {
		{loc = vector3(1270.48, 1802.08, 82.54), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1262.18, 1794.47, 81.93), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1253.49, 1799.48, 80.70), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1227.22, 1800.42, 78.26), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1231.96, 1820.09, 78.75), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1245.61, 1822.07, 79.77), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1263.07, 1825.05, 81.43), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1278.00, 1845.10, 82.98), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1297.92, 1830.62, 85.96), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1306.34, 1798.88, 87.68), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1288.02, 1787.11, 85.26), taken = false, model = 'mw_chemical_barrel'},
		{loc = vector3(1274.21, 1779.28, 83.79), taken = false, model = 'mw_chemical_barrel'},
	},
	heroin = {
		{loc = vector3(-2336.02, -50.96, 95.46), taken = false, model = 'prop_plant_01b'},
		{loc = vector3(-2331.68, -51.34, 95.25), taken = false, model = 'prop_plant_01b'},
		{loc = vector3(-2341.43, -48.82, 93.74), taken = false, model = 'prop_plant_01b'},
		{loc = vector3(-2338.45, -60.05, 92.55), taken = false, model = 'prop_plant_01b'},
		{loc = vector3(-2343.20, -60.20, 91.84), taken = false, model = 'prop_plant_01b'},
		{loc = vector3(-2345.42, -52.04, 92.01), taken = false, model = 'prop_plant_01b'},
		{loc = vector3(-2323.90, -34.88, 100.04),taken = false, model = 'prop_plant_01b'},
		{loc = vector3(-2314.72, -8.38, 102.47), taken = false, model = 'prop_plant_01b'},
	},
	hydro = {
		{loc = vector3(-1074.19, 4929.44, 211.55), taken = false, model = 'mw_hydro_barrel'},
		{loc = vector3(-1072.89, 4943.10, 211.62), taken = false, model = 'mw_hydro_barrel'},
		{loc = vector3(-1085.32, 4952.85, 214.53), taken = false, model = 'mw_hydro_barrel'},
		{loc = vector3(-1071.05, 4950.43, 211.88), taken = false, model = 'mw_hydro_barrel'},
		{loc = vector3(-1065.21, 4947.90, 211.13), taken = false, model = 'mw_hydro_barrel'},
		{loc = vector3(-1057.18, 4944.42, 209.80), taken = false, model = 'mw_hydro_barrel'},
		{loc = vector3(-1063.33, 4926.76, 210.14), taken = false, model = 'mw_hydro_barrel'},
		{loc = vector3(-1067.10, 4920.27, 211.71), taken = false, model = 'mw_hydro_barrel'},
		{loc = vector3(-1089.31, 4923.88, 213.76), taken = false, model = 'mw_hydro_barrel'},
	},
	sodium = {
		{loc = vector3(-392.80, -1879.73, 19.52), taken = false, model = 'mw_sodium_barrel'},
		{loc = vector3(-397.60, -1873.89, 19.52), taken = false, model = 'mw_sodium_barrel'},
		{loc = vector3(-397.04, -1868.84, 19.66), taken = false, model = 'mw_sodium_barrel'},
		{loc = vector3(-389.00, -1866.19, 19.66), taken = false, model = 'mw_sodium_barrel'},
		{loc = vector3(-381.89, -1870.62, 19.52), taken = false, model = 'mw_sodium_barrel'},
		{loc = vector3(-380.35, -1890.85, 20.53), taken = false, model = 'mw_sodium_barrel'},
		{loc = vector3(-387.77, -1874.07, 19.52), taken = false, model = 'mw_sodium_barrel'},
		{loc = vector3(-393.16, -1877.98, 19.52), taken = false, model = 'mw_sodium_barrel'},
		{loc = vector3(-374.73, -1877.74, 19.52), taken = false, model = 'mw_sodium_barrel'},
		{loc = vector3(-375.79, -1871.35, 19.52), taken = false, model = 'mw_sodium_barrel'},
	},
	sulfur = {
		{loc = vector3(-3025.91, 3340.92, 9.00), taken = false, model = 'mw_sulfuric_barrel'},
		{loc = vector3(-3032.29, 3338.64, 9.13), taken = false, model = 'mw_sulfuric_barrel'},
		{loc = vector3(-3027.97, 3328.27, 9.13), taken = false, model = 'mw_sulfuric_barrel'},
		{loc = vector3(-3016.29, 3324.36, 9.02), taken = false, model = 'mw_sulfuric_barrel'},
		{loc = vector3(-3030.60, 3322.89, 9.37), taken = false, model = 'mw_sulfuric_barrel'},
		{loc = vector3(-3031.21, 3331.28, 9.03), taken = false, model = 'mw_sulfuric_barrel'},
		{loc = vector3(-3046.94, 3350.62, 6.47), taken = false, model = 'mw_sulfuric_barrel'},
	}
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
