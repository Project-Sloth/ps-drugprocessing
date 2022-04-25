fx_version 'cerulean'

games      { 'gta5' }

lua54 'yes'

description 'QB Drug Trafficing by Project Sloth'

this_is_a_map 'yes'

version '1.0.0'

server_scripts {
	'config.lua',
	'server/coke.lua',
	'server/lsd.lua',
	'server/meth.lua',
	'server/weed.lua',
	'server/heroin.lua',
	'server/chemicals.lua',
	'server/lisenceshop.lua',
	'server/moneywash.lua',
}

client_scripts {
	'config.lua',
	'client/weed.lua',
	'client/meth.lua',
	'client/coke.lua',
	'client/lsd.lua',
	'client/heroin.lua',
	'client/chemicals.lua',
	'client/hydrochloricacid.lua',
	'client/sodiumhydroxide.lua',
	'client/sulfuricacid.lua',
	'client/target.lua',
}

files {
	'stream/mw_props.ytyp'
}

data_file 'DLC_ITYP_REQUEST' 'stream/mw_props.ytyp'
