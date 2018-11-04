description 'ESX journalist'

version '0.1'

dependencies {
  "mysql-async",
  "esx_datastore",
  "esx_society",
  "esx_billing",
  "esx_phone",
}

client_scripts {
  '@es_extended/locale.lua',
  'locales/fr.lua',
  'config.lua',
  'client/esx_journalist_cl.lua',
}

server_scripts {
  "@mysql-async/lib/MySQL.lua",
  '@es_extended/locale.lua',
  'locales/fr.lua',
  'config.lua',
  'server/esx_journalist_sv.lua',
}