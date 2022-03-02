# Project Sloth Advanced Drug Processing

# Meth Preview
https://streamable.com/0pcjlt

# Add to qb-core > shared.lua

```
    ["wet_weed"] 		 	 	 	 = {["name"] = "wet_weed",           			["label"] = "Moist Weed",	 			["weight"] = 3000, 		["type"] = "item", 		["image"] = "wet_weed.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Wet weed that needs to be treated!"},
    ["coke"] 		 	 	 	     = {["name"] = "coke",           				["label"] = "Cocaine", 					["weight"] = 1000,		["type"] = "item", 		["image"] = "coke.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Processed cocaine"},
    ["coca_leaf"] 		 	 	 	 = {["name"] = "coca_leaf",           			["label"] = "Cocaine leaves",	 		["weight"] = 1500,		["type"] = "item", 		["image"] = "coca_leaf.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Cocaine leaves that must be processed !"},
    ["cannabis"] 			 		 = {["name"] = "cannabis", 						["label"] = "Cannabis", 				["weight"] = 2500, 		["type"] = "item", 		["image"] = "cannabis.png", 			["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Uncured cannabis"},
    ["marijuana"] 			 		 = {["name"] = "marijuana", 					["label"] = "Marijuana", 				["weight"] = 500,		["type"] = "item", 		["image"] = "marijuana.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Some fine smelling buds."},
    ["chemicals"] 		 	 	 	 = {["name"] = "chemicals",           			["label"] = "Chemicals",	 			["weight"] = 1500, 		["type"] = "item", 		["image"] = "chemicals.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care..."},
    ["poppyresin"] 		 	 	 	 = {["name"] = "poppyresin",           			["label"] = "Poppy resin",	 			["weight"] = 2000, 		["type"] = "item", 		["image"] = "poppyresin.png", 			["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "It sticks to your fingers when you handle it."},
    ["heroin"] 		 	 	 	     = {["name"] = "heroin",           				["label"] = "Heroin",	 				["weight"] = 500, 		["type"] = "item", 		["image"] = "heroin.png", 				["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Really addictive depressant..."},
    ["lsa"] 		 	 	 	     = {["name"] = "lsa",           				["label"] = "LSA",	 					["weight"] = 500, 		["type"] = "item", 		["image"] = "lsa.png", 					["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Almost ready to party..."},
    ["lsd"] 		 	 	 	     = {["name"] = "lsd",           				["label"] = "LSD",	 					["weight"] = 500, 		["type"] = "item", 		["image"] = "lsd.png", 					["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Lets get this party started!"},
    ["meth"] 		 	 	 	     = {["name"] = "meth",           				["label"] = "Meth",	 					["weight"] = 500, 		["type"] = "item", 		["image"] = "meth.png", 				["unique"] = false, 	["useable"] = true, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Really addictive stimulant..."},
    ["hydrochloric_acid"] 			 = {["name"] = "hydrochloric_acid", 			["label"] = "Hydrochloric Acid",		["weight"] = 1500, 		["type"] = "item", 		["image"] = "hydrochloric_acid.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["sodium_hydroxide"] 			 = {["name"] = "sodium_hydroxide", 				["label"] = "Sodium Hydroxide", 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "sodium_hydroxide.png", 	["unique"] = false, 	["useable"] = true, 	["shouldClose"] = true,	   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["sulfuric_acid"] 		 	 	 = {["name"] = "sulfuric_acid",           		["label"] = "Sulfuric Acid",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "sulfuric_acid.png", 		["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["thionyl_chloride"] 		 	 = {["name"] = "thionyl_chloride",           	["label"] = "Thionyl Chloride",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "thionyl_chloride.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["liquidmix"] 		 	 	     = {["name"] = "liquidmix",           		    ["label"] = "Liquid Chem Mix",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "liquidmix.png", 		    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Chemicals, handle with care!"},
    ["bakingsoda"] 		 	 	     = {["name"] = "bakingsoda",           		    ["label"] = "Baking Soda",	 		    ["weight"] = 1500, 		["type"] = "item", 		["image"] = "bakingsoda.png", 		    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Household Baking Soda!"},
    ["chemicalvapor"] 		 	     = {["name"] = "chemicalvapor",           	    ["label"] = "Chemical Vapors",	 		["weight"] = 1500, 		["type"] = "item", 		["image"] = "chemicalvapor.png", 	    ["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "High Pressure Chemical Vapors, Explosive!"},
    ["trimming_scissors"] 		 	 = {["name"] = "trimming_scissors",           	["label"] = "Trimming Scissors",	 	["weight"] = 1500, 		["type"] = "item", 		["image"] = "trimming_scissors.png", 	["unique"] = false, 	["useable"] = false, 	["shouldClose"] = false,   ["combinable"] = nil,   ["expire"] = 90,  ["description"] = "Very Sharp Trimming Scissors"},
    ['methtray'] 					 = {['name'] = 'methtray', 						['label'] = 'Meth Tray', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'meth_tray.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'make some meth'},
    ['methkey'] 					 = {['name'] = 'methkey', 						['label'] = 'Key A', 				    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'keya.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Random Key, with "Walter" Engraved on the Back...'},
    ['cocainekey'] 					 = {['name'] = 'cocainekey', 					['label'] = 'Key B', 				    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'keyb.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Random Key, with a "Razorblade" Engraved on the Back...'},
    ['weedkey'] 					 = {['name'] = 'weedkey', 						['label'] = 'Key C', 				    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'keyc.png', 			    ['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Random Key, with a "Seed" Engraved on the Back...'},
    ['finescale'] 					 = {['name'] = 'finescale', 					['label'] = 'Fine Scale', 			    ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'finescale.png', 			['unique'] = false, 	['useable'] = false, 	['shouldClose'] = false,   ['combinable'] = nil,   ['description'] = 'Scale Used for Fine Powders and Materials.'},
    ['coke_small_brick'] 		 	 = {['name'] = 'coke_small_brick', 				['label'] = 'Coke Package', 			['weight'] = 350, 		['type'] = 'item', 		['image'] = 'coke_small_brick.png', 	['unique'] = false, 	['useable'] = false, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Small package of cocaine, mostly used for deals and takes a lot of space'},
```


# Add icon images

qb-inventory > html > images

# Add to qb-target

```
Config.TargetModels = {
    ["cokeplant"] = {
        models = {
            "mw_coke_plant",
        },
        options = {
            {
                type = "client",
                event = "qb-drugtrafficking:client:coke",
                icon = "fas fa-leaf",
                label = "Pickup Coke Leafs",
            },
        },
        distance = 4.0
    },
	["heroinplant"] = {
        models = {
            "mw_heroin_plant",
        },
        options = {
            {
                type = "client",
                event = "qb-drugtrafficking:client:heorin",
                icon = "fas fa-seedling",
                label = "Pickup Poppy Plants",
            },
        },
        distance = 4.0
    },
	["weedplant"] = {
        models = {
            "mw_weed_plant",
        },
        options = {
            {
                type = "client",
                event = "qb-drugtrafficking:client:weed",
                icon = "fas fa-envira",
                label = "Pickup Weed Leafs",
            },
        },
        distance = 4.0
    },
	["hydrobarrel"] = {
        models = {
            "mw_hydro_barrel",
        },
        options = {
            {
                type = "client",
                event = "qb-drugtrafficking:client:hydro",
                icon = "fas fa-biohazard",
                label = "Pickup Hydro Barrel",
            },
        },
        distance = 4.0
    },
	["sodiumbarrel"] = {
        models = {
            "mw_sodium_barrel",
        },
        options = {
            {
                type = "client",
                event = "qb-drugtrafficking:client:sodium",
                icon = "fas fa-dna",
                label = "Pickup Sodium Barrel",
            },
        },
        distance = 4.0
    },
	["sulfuricbarrel"] = {
        models = {
            "mw_sulfuric_barrel",
        },
        options = {
            {
                type = "client",
                event = "qb-drugtrafficking:client:sulfuric",
                icon = "fas fa-shield-virus",
                label = "Pickup Sulfuric Barrel",
            },
        },
        distance = 4.0
    },
	["chemicalbarrel"] = {
        models = {
            "mw_chemical_barrel",
        },
        options = {
            {
                type = "client",
                event = "qb-drugtrafficking:chemicals",
                icon = "fas fa-radiation",
                label = "Pickup Chem Barrels",
            },
        },
        distance = 4.0
    },
}
```

```
Config.BoxZones = {
	---- ps-drugprocessing options -----
	["chemmenu"] = {
        name = "chemmenu",
        coords = vector3(3535.66, 3661.69, 28.12),
        length = 1.65,
        width = 2.4,
        heading = 350,
        debugPoly = false,
        minZ = 27.52,
        maxZ = 29.12,
        options = {
            {
                type = "client",
                event = "qb-drugtrafficking:chemicalmenu",
                icon = "fas fa-vials",
                label = "Learn a New Chemical Compound",
                --job = "pawnshop", -- Remove this line if you do not want a job check.
            },
        },
        distance = 2.5
    },
	["methprocess"] = {
        name = "methprocess",
        coords = vector3(978.22, -147.1, -48.53),
        length = 1.6,
        width = 1.8,
        heading = 0,
        debugPoly = false,
        minZ = -50.33,
        maxZ = -45.53,
        options = {
            {
                type = "client",
                event = "qb-drugprocessing:ProcessChemicals",
                icon = "fas fa-vials",
                label = "Cook Something Wonderful & Blue",
                --job = "methcook", -- Remove this line if you do not want a job check.
            },
        },
        distance = 3.5
    },
	["methtempup"] = {
        name = "methtempup",
        coords = vector3(982.56, -145.59, -49.0),
        length = 1.2,
        width = 1.4,
        heading = 0,
        debugPoly = false,
        minZ = -50.3,
        maxZ = -47.3,
        options = {
            {
                type = "client",
                event = "qb-drugprocessing:ChangeTemp",
                icon = "fas fa-temperature-empty",
                label = "Hmmm Seems Cold",
                --job = "methcook", -- Remove this line if you do not want a job check.
            },
        },
        distance = 3.5
    },
	["methtempdown"] = {
        name = "methtempdown",
        coords = vector3(979.59, -144.14, -49.0),
        length = 1.2,
        width = 0.5,
        heading = 354,
        debugPoly = false,
        minZ = -49.2,
        maxZ = -47.9,
        options = {
            {
                type = "client",
                event = "qb-drugprocessing:ChangeTemp2",
                icon = "fas fa-temperature-full",
                label = "Hmmm Seems Hot",
                --job = "methcook", -- Remove this line if you do not want a job check.
            },
        },
        distance = 3.5
    },
	["methbagging"] = {
        name = "methbagging",
        coords = vector3(987.44, -140.5, -49.0),
        length = 0.5,
        width = 0.7,
        heading = 1,
        debugPoly = false,
        minZ = -49.35,
        maxZ = -48.65,
        options = {
            {
                type = "client",
                event = "qb-drugprocessing:ProcessProduct",
                icon = "fas fa-box",
                label = "Start Bagging",
                --job = "methcook", -- Remove this line if you do not want a job check.
            },
        },
        distance = 3.5
    },
    ["methkeypad"] = {
        name = "methkeypad",
        coords = vector3(969.04, -146.17, -46.4),
        length = 0.4,
        width = 0.2,
        heading = 0,
        debugPoly = false,
        minZ = -46.2,
        maxZ = -45.8,
        options = {
            {
                type = "client",
                event = "qb-drugprocessing:ExitLab",
                icon = "fas fa-lock",
                label = "Secure Lab & Leave",
                --job = "methcook", -- Remove this line if you do not want a job check.
            },
        },
        distance = 3.5
    },
	["cokekeypad"] = {
        name = "cokekeypad",
        coords = vector3(1087.66, -3187.16, -38.99),
        length = 0.1,
        width = 0.2,
        heading = 0,
        debugPoly = false,
        minZ = -38.74,
        maxZ = -38.54,
        options = {
            {
                type = "client",
                event = "qb-drugprocessing:ExitCWarehouse",
                icon = "fas fa-lock",
                label = "Secure Warehouse & Leave",
                --job = "cokecutter", -- Remove this line if you do not want a job check.
            },
        },
        distance = 3.5
    },
	["cokeleafproc"] = {
        name = "cokeleafproc",
        coords = vector3(1086.2, -3194.9, -38.99),
        length = 2.5,
        width = 1.4,
        heading = 0,
        debugPoly = false,
        minZ = -39.39,
        maxZ = -38.39,
        options = {
            {
                type = "client",
                event = "qb-drugprocessing:ProcessCocaFarm",
                icon = "fas fa-scissors",
                label = "Breakdown Leaves",
                --job = "cokecutter", -- Remove this line if you do not want a job check.
            },
        },
        distance = 3.5
    },
	["cokepowdercut"] = {
        name = "cokepowdercut",
        coords = vector3(1092.89, -3195.78, -38.99),
        length = 7.65,
        width = 1.2,
        heading = 90,
        debugPoly = false,
        minZ = -39.39,
        maxZ = -38.44,
        options = {
            {
                type = "client",
                event = "qb-drugprocessing:ProcessCocaPowder",
                icon = "fas fa-weight-scale",
                label = "Cut Product & Weight",
                --job = "cokecutter", -- Remove this line if you do not want a job check.
            },
        },
        distance = 3.5
    },
	["cokebricked"] = {
        name = "cokebricked",
        coords = vector3(1098.77, -3194.19, -38.99),
        length = 2.6,
        width = 1.0,
        heading = 90,
        debugPoly = false,
        minZ = -39.99,
        maxZ = -38.59,
        options = {
            {
                type = "client",
                event = "qb-drugprocessing:ProcessBricks",
                icon = "fas fa-weight-scale",
                label = "Brick Up Product",
                --job = "cokecutter", -- Remove this line if you do not want a job check.
            },
        },
        distance = 3.5
    },

```
```
Config.Peds = {
    [65] = {
		model = 'a_m_m_hillbilly_02',
		coords = vector4(-1187.73, -445.27, 43.91, 289.45), -- vector3(-1187.73, -445.27, 43.91)
		currentpednumber = 0,
		target = {
			options = {
				{
					type = "client",
					event = "qb-drugprocessing:EnterLab",
					icon = "fas fa-atom",
					label = "Talk to Walter",
				},
			},
			distance = 2.0
		},
		freeze = true,
		blockevents = true,
		invincible = true,
		minusOne = true,
	},
	[66] = {
		model = 'a_m_m_mlcrisis_01',
		coords = vector4(811.03, -2400.17, 23.66, 216.01), -- vector3(811.03, -2400.17, 23.66)
		currentpednumber = 0,
		target = {
			options = {
				{
					type = "client",
					event = "qb-drugprocessing:EnterCWarehouse",
					icon = "fas fa-key",
					label = "Talk to Draco",
				},
			},
			distance = 5.0
		},
		freeze = true,
		blockevents = true,
		invincible = true,
		minusOne = true,
	},
}
```
# Helpful Triggers:

* "qb-drugtrafficking:chemicalmenu" - Open Chemical Menu
* "qb-drugtrafficking:hydrochloric_acid" - Process Hydrochloric Acid
* "qb-drugtrafficking:sodium_hydroxide" - Process Sodium Hydroxide
* "qb-drugtrafficking:sulfuric_acid" - Process Sulfuric Acid
* "qb-drugtrafficking:lsa" - Process LSA


# Dependencies
* qb-target - https://github.com/BerkieBb/qb-target
* qb-menu - https://github.com/qbcore-framework/qb-menu

# Original Repo
https://github.com/DoPeMan17/esx_drugs
