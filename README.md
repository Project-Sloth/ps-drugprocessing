# Project Sloth Advanced Drug Processing

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

```


# Add icon images

qb-inventory > html > images

# Add to qb-core > client > functions.lua
```
QBCore.Functions.SpawnLocalObject = function(model, coords, cb)

	local model = (type(model) == 'number' and model or GetHashKey(model))
  
	Citizen.CreateThread(function()
		RequestModel(model)
		local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
		SetModelAsNoLongerNeeded(model)

		if cb then
			cb(obj)
		end
	end)
end

QBCore.Functions.DeleteObject = function(object)
	SetEntityAsMissionEntity(object, false, true)
	DeleteObject(object)
end
```
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

Config.BoxZones = {
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
			--job = "scientist", -- Remove this line if you do not want a job check.
		    },
		},
		distance = 2.5
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
