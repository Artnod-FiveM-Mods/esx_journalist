description 'ESX journalist'

version '0.5'

dependencies {
  "esx_society",
  "esx_billing",
  "esx_datastore",
  "esx_phone",
}

client_scripts {
  '@es_extended/locale.lua',
  'locales/fr.lua',
  'config.lua',
  'client/esx_journalist_cl.lua',
}

server_scripts {
  '@es_extended/locale.lua',
  'locales/fr.lua',
  'config.lua',
  'server/esx_journalist_sv.lua',
}