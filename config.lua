Config            = {}
Config.Locale     = 'fr'
Config.debug      = true
Config.scriptName = "esx_journalist"

Config.jobName      = "journalist"
Config.companyLabel = "society_weazel"
Config.companyName  = "Weazel News"
Config.platePrefix  = "WEAZEL"

Config.journalistMinGrade = 1
Config.storageMinGrade    = 2
Config.copterMinGrade     = 3
Config.manageMinGrade     = 4

-- interim run
Config.iItemTime     = 1500
Config.iItemDb_name  = "journal"
Config.iItemName     = "Journal"
Config.iItemAdd      = 1
Config.iItemRemove   = 1
Config.iItemPrice    = 64
Config.iCompanyRate  = 0.015625


Config.jItemTime     = 2500
Config.jItemDb_name  = "journaux"
Config.jItemName     = "Sac de journaux"
Config.jItemAdd      = 1
Config.jItemRemove   = 1
Config.jItemPrice    = 10
Config.jCompanyRate  = 10

-- zones
Config.zones = {
  cloakRoom = {
    enable  = true,
    gps     = {x=-598.67492675781, y=-929.96899414063, z=22.88},
    markerD = {type=27, drawDistance=50.0, size={x=2.0, y=2.0, z=1.0}, color={r=11, g=203, b=159} },
    blipD   = {sprite=184, display=4, scale=0.9, color=1, range=true, name=_U('cloakroom_blip') }
  },
  
  vehicleSpawner = {
    enable = true,
    gps    = {x=-537.03985595703, y=-886.71276855469, z=24.20},
    markerD = {type=27, drawDistance=50.0, size={x=2.0, y=2.0, z=1.0}, color={r=11, g=203, b=159} },
    blipD   = {sprite=184, display=4, scale=0.9, color=1, range=true, name=_U('vehicleSpawner_blip') }
  },
  vehicleSpawnPoint = {
    enable = false,
    gps    = {x=-532.78131103516, y=-889.32562255859, z=23.90},
    markerD = {type=27, drawDistance=100.0, size={x=3.0, y=3.0, z=1.0}, color={r=255, g=0, b=0}, heading=182},
    blipD   = {sprite=184, display=4, scale=0.9, color=1, range=true, name=_U('vehicleDeleter_blip') }
  },
  
  copterSpawner = {
    enable = false,
    gps    = {x=-568.97296142578, y=-927.68316650391, z=35.85},
    markerD = {type=27, drawDistance=50.0, size={x=2.0, y=2.0, z=1.0}, color={r=11, g=203, b=159} },
    blipD   = {sprite=184, display=4, scale=0.9, color=1, range=true, name=_U('copterSpawner_blip') }
  },
  copterSpawnPoint = {
    enable = false,
    gps    = {x=-583.40, y=-930.60, z=35.90},
    markerD = {type=27, drawDistance=100.0, size={x=8.0, y=8.0, z=1.0}, color={r=255, g=0, b=0}, heading=182},
    blipD   = {sprite=184, display=4, scale=0.9, color=1, range=true, name=_U('copterDeleter_blip') }
  },
  
  printer = {
    enable = false,
    gps    = {x=-589.83483886719, y=-910.82006835938, z=22.89},
    markerD = {type=27, drawDistance=50.0, size={x=2.0, y=2.0, z=1.0}, color={r=11, g=203, b=159} },
    blipD   = {sprite=184, display=4, scale=0.9, color=1, range=true, name=_U('printer_blip') }
  },
  interimBoxes = {
    enable = false,
    gps    = {},
    markerD = {type=27, drawDistance=50.0, size={x=2.0, y=2.0, z=1.0}, color={r=204, g=204, b=0} },
    blipD   = {route=1 }
  },
  journalistBoxes = {
    enable = false,
    gps    = {},
    markerD = {type=27, drawDistance=50.0, size={x=2.0, y=2.0, z=1.0}, color={r=204, g=204, b=0} },
    blipD   = {route=1 }
  },
}

Config.interimBoxes = {
  { -- center
    {x=-232.76321411133, y=-971.63806152344, z=28.298276901245}, -- pole emploi
    {x=-279.71481323242, y=-644.77526855469, z=32.166927337646}, -- dab
    {x=-114.66568756104, y=-600.78131103516, z=35.281700134277}, -- appart
    {x=27.258623123169, y=-738.36120605469, z=43.220474243164}, -- appart
    {x=235.00625610352, y=-604.38824462891, z=41.272121429443}, -- croix rouge
    {x=207.94300842285, y=-851.53143310547, z=29.542676925659}, -- place cube
    {x=307.60232543945, y=-870.59906005859, z=28.291597366333}, -- dab
    {x=419.23870849609, y=-817.12457275391, z=28.211791992188}, -- wear
    {x=418.46252441406, y=-997.88372802734, z=28.24608039856}, -- lspd
    {x=311.56063842773, y=-1070.6965332031, z=28.414241790771}, -- appart
    {x=186.5682220459, y=-1010.9787597656, z=28.318914413452}, -- dab
    {x=2.3928689956665, y=-1123.6417236328, z=27.211946487427}, -- ammu
    {x=-65.873764038086, y=-1126.5200195313, z=24.821189880371}, -- concess
    {x=-63.071155548096, y=-955.02294921875, z=28.367357254028},
    {x=-148.30569458008, y=-720.09149169922, z=33.778877258301},
    {x=-269.93417358398, y=-829.10662841797, z=30.811920166016}
  },
  { -- groovestreet
     
    
  },
}

Config.journalistBoxes = {
  { -- center
    {x=-232.76321411133, y=-971.63806152344, z=28.298276901245}, -- pole emploi
    {x=-279.71481323242, y=-644.77526855469, z=32.166927337646}, -- dab
    {x=-114.66568756104, y=-600.78131103516, z=35.281700134277}, -- appart
    {x=27.258623123169, y=-738.36120605469, z=43.220474243164}, -- appart
    {x=235.00625610352, y=-604.38824462891, z=41.272121429443}, -- croix rouge
    {x=207.94300842285, y=-851.53143310547, z=29.542676925659}, -- place cube
    {x=307.60232543945, y=-870.59906005859, z=28.291597366333}, -- dab
    {x=419.23870849609, y=-817.12457275391, z=28.211791992188}, -- wear
    {x=418.46252441406, y=-997.88372802734, z=28.24608039856}, -- lspd
    {x=311.56063842773, y=-1070.6965332031, z=28.414241790771}, -- appart
    {x=186.5682220459, y=-1010.9787597656, z=28.318914413452}, -- dab
    {x=2.3928689956665, y=-1123.6417236328, z=27.211946487427}, -- ammu
    {x=-65.873764038086, y=-1126.5200195313, z=24.821189880371}, -- concess
    {x=-63.071155548096, y=-955.02294921875, z=28.367357254028},
    {x=-148.30569458008, y=-720.09149169922, z=33.778877258301},
    {x=-269.93417358398, y=-829.10662841797, z=30.811920166016}
  },
}

Config.vehicles = {
  bike = {
    label   = 'Vélo',
    hash    = "Cruiser"
  },
  van = {
    label   = 'Camionette',
    hash    = 1162065741
  },
  bossCar = {
    label   = 'Voiture Commercial',
    hash    = "Cognoscenti"
  },
  copter = {
    label   = 'Hélicopter',
    hash    = "Buzzard2"
  }
}

Config.uniforms = {
  job_wear = {
    male = {
      ['tshirt_1'] = 131, ['tshirt_2'] = 0,
      ['torso_1']  = 50 , ['torso_2']  = 4,
      ['decals_1'] = 0  , ['decals_2'] = 0,
      ['arms']     = 22 ,
      ['pants_1']  = 25 , ['pants_2']  = 0,
      ['shoes_1']  = 51 , ['shoes_2']  = 0,
      ['helmet_1'] = 58 , ['helmet_2'] = 1,
      ['chain_1']  = 0  , ['chain_2']  = 0,
      ['ears_1']   = -1 , ['ears_2']   = 0,
      ['bags_1']   = 0  , ['bags_2']   = 0
    },
    female = {
      ['tshirt_1'] = 161, ['tshirt_2'] = 0,
      ['torso_1']  = 43 , ['torso_2']  = 4,
      ['decals_1'] = 0  , ['decals_2'] = 0,
      ['arms']     = 23 ,
      ['pants_1']  = 6  , ['pants_2']  = 0,
      ['shoes_1']  = 52 , ['shoes_2']  = 0,
      ['helmet_1'] = -1 , ['helmet_2'] = 0,
      ['chain_1']  = 0  , ['chain_2']  = 0,
      ['ears_1']   = -1 , ['ears_2']   = 0,
      ['bags_1']   = 0  , ['bags_2']   = 0
    }
  },
}
