resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

files {
    'ui/app.js',
	'ui/ARM.html',
	'ui/style.css',
	'ui/TextWithAdmin.jpg',
	'ui/TalkWithAdmin.jpg',
}

ui_page {
    'ui/ARM.html'
}

client_script 'client.lua'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'server.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'client.lua'
}

dependency 'es_extended'