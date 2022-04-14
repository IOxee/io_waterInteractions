fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "io_waterInteractions"
description "[ESX] The script allows you to interact with water in new ways, either by removing objects or by storing water in bottles/canteens."
author "ByBlackDeath"
version "0.5.1"

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}


escrow_ignore {
	'client/*.lua',
	'server/*.lua',
    'shared/*.lua',
}