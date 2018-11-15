Config        = {}
Config.Locale = 'fr'
Config.debug  = true

Config.platePrefix = "WEAZEL"

Config.journalistMinGrade = 1
Config.storageMinGrade    = 2
Config.copterMinGrade     = 3
Config.manageMinGrade     = 4

Config.gouvRate = 0.05

-- interim run
Config.iItemTime     = 1500
Config.iItemDb_name  = "journal"
Config.iItemName     = "Journal"
Config.iItemAdd      = 1
Config.iItemRemove   = 1
Config.iItemPrice    = 70
Config.iCompanyRate  = 0.1


Config.jItemTime     = 2500
Config.jItemDb_name  = "journaux"
Config.jItemName     = "Paquet de journaux"
Config.jItemAdd      = 1
Config.jItemRemove   = 1
Config.jItemPrice    = 62
Config.jCompanyRate  = 5

Config.vehicles = {
  bike = {
    label   = 'Scooter',
    hash    = "Faggio2"
  },
  van = {
    label   = 'Camionette',
    hash    = 0x4543B74D
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

-- zones
Config.zones = {
  cloakRoom = {
    enable  = false,
    gps     = {x=-598.67492675781, y=-929.96899414063, z=22.88},
    markerD = {type=27, drawDistance=50.0, size={x=2.0, y=2.0, z=1.0}, color={r=11, g=203, b=159} },
    blipD   = {sprite=184, display=4, scale=0.9, color=1, range=true, name=_U('cloakroom_blip') }
  },
  
  vehicleSpawnPoint = {
    enable = false,
    gps    = {x=-532.78131103516, y=-889.32562255859, z=23.90},
    markerD = {type=27, drawDistance=100.0, size={x=4.0, y=4.0, z=1.0}, color={r=255, g=0, b=0}, heading=182},
    blipD   = {sprite=184, display=4, scale=0.9, color=1, range=true, name=_U('vehicleDeleter_blip') }
  },
  
  roof = {
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
    markerD = {type=27, drawDistance=50.0, size={x=3.0, y=3.0, z=1.0}, color={r=11, g=203, b=159} },
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
  { -- downtown
    {x=-232.76, y=-971.63, z=28.29}, -- pole emploi
    {x=-279.71, y=-644.77, z=32.16}, -- dab
    {x=-114.66, y=-600.78, z=35.28}, -- appart
    {x=27.25  , y=-738.36, z=43.22}, -- appart
    {x=235.00 , y=-604.38, z=41.27}, -- croix rouge
    {x=207.94 , y=-851.53, z=29.54}, -- place cube
    {x=307.60 , y=-870.59, z=28.29}, -- dab
    {x=419.23 , y=-817.12, z=28.21}, -- wear
    {x=418.46 , y=-997.88, z=28.24}, -- lspd
    {x=311.56 , y=-1070.6, z=28.41}, -- appart
    {x=186.56 , y=-1010.9, z=28.31}, -- dab
    {x=2.39   , y=-1123.6, z=27.21}, -- ammu
    {x=-65.87 , y=-1126.5, z=24.82}, -- concess
    {x=-63.07 , y=-955.02, z=28.36},
    {x=-148.30, y=-720.09, z=33.77},
    {x=-269.93, y=-829.10, z=30.81}
  },
  { -- little seoul
    {x=-1114.30, y=-1572.59, z=3.39 }, -- vespucci
    {x=-1159.03, y=-1397.50, z=4.02 }, -- vespucci
    {x=-1212.04, y=-1387.47, z=3.08 }, -- vespucci
    {x=-1198.50, y=-1196.54, z=6.68 }, -- vespucci
    {x=-1285.44, y=-1131.02, z=5.79 }, -- vespucci
    {x=-1231.66, y=-1073.80, z=7.41 }, -- vespucci
    {x=-1053.27, y=-1321.25, z=4.54 }, -- palomino avenue
    {x=-957.17 , y=-1243.68, z=4.43 }, -- palomino avenue
    {x=-875.38 , y=-1197.00, z=3.88 }, -- palomino avenue
    {x=-768.10 , y=-1090.69, z=9.65 }, -- palomino avenue
    {x=-625.52 , y=-974.97 , z=20.36}, -- palomino avenue
    {x=-523.39 , y=-850.23 , z=29.25}, -- little seoul
    {x=-752.11 , y=-790.41 , z=23.43}, -- little seoul
    {x=-880.75 , y=-838.63 , z=18.02}, -- little seoul
    {x=-878.17 , y=-899.36 , z=14.77}, -- little seoul
    {x=-549.85 , y=-1023.84, z=21.84}, -- little seoul
    {x=-556.02 , y=-681.54 , z=32.23}, -- little seoul
    {x=-658.90 , y=-672.14 , z=30.59}, -- little seoul
    {x=-1076.00, y=-790.46 , z=18.32}, -- little seoul
    {x=-852.20 , y=-678.95 , z=26.85}, -- little seoul
    {x=-752.88 , y=-679.11 , z=29.31}  -- little seoul
  },
  {
    {x=-1441.16, y=-720.89, z=22.80},
    {x=-1282.98, y=-644.04, z=25.68},
    {x=-1432.65, y=-603.80, z=29.73},
    {x=-1355.74, y=-560.02, z=29.19},
    {x=-1260.62, y=-484.06, z=32.37},
    {x=-1057.77, y=-359.31, z=36.76},
    {x=-1067.42, y=-431.96, z=35.64},
    {x=-921.11 , y=-420.37, z=36.46},
    {x=-741.66 , y=-356.83, z=34.39},
    {x=-874.61, y=-175.22, z=36.91 },
    {x=-1029.11, y=-214.78, z=36.92},
    {x=-1246.05, y=-299.82, z=36.38},
    {x=-1352.09, y=-389.44, z=35.75},
    {x=-1452.97, y=-417.49, z=34.67},
    {x=-1559.02, y=-483.69, z=34.48},
    {x=-1675.20, y=-584.29, z=32.68},
    {x=-1420.45, y=-298.91, z=43.13},
    {x=-1390.09, y=-230.20, z=43.11},
    {x=-1429.79, y=-95.26 , z=50.75},
    {x=-1501.37, y=-150.56, z=51.54}
  },
  { -- vinewood
    {x=327.33 , y=167.54 , z=102.57}, -- vinewood
    {x=541.27 , y=89.32  , z=95.29 }, -- vinewood
    {x=522.53 , y=-158.56, z=55.59 }, -- hawick
    {x=380.59 , y=-94.03 , z=65.93 }, -- hawick
    {x=241.49 , y=-58.38 , z=68.62 }, -- hawick
    {x=106.80 , y=-9.54  , z=66.92 }, -- hawick
    {x=-432.02, y=16.77  , z=45.14 }, -- burton
    {x=-278.87, y=-22.39 , z=48.35 }, -- burton
    {x=-54.44 , y=-97.60 , z=56.81 }, -- burton
    {x=122.50 , y=-165.11, z=53.68 }, -- burton
    {x=260.14 , y=-215.59, z=52.97 }, -- burton
    {x=209.49 , y=-334.09, z=43.02 }, -- alta
    {x=53.70  , y=-277.49, z=46.61 }, -- alta
    {x=-148.19, y=-399.59, z=32.70 },
    {x=-251.90, y=-344.14, z=28.96 },
    {x=-390.13, y=-236.20, z=35.02 },
  },
}

Config.journalistBoxes = {
  { -- center
    {x=-46.13047 ,y=-1758.271 ,z=28.43 },
    {x=1133.697  ,y=-982.4708 ,z=45.42 },
    {x=1165.317  ,y=-322.3742 ,z=68.21 },
    {x=372.9026  ,y=328.7234  ,z=102.58},
    {x=-1485.86  ,y=-377.6055 ,z=39.17 },
    {x=-1221.643 ,y=-908.7925 ,z=11.33 },
    {x=-705.5613 ,y=-913.527  ,z=18.22 },
  },
  { -- east coast
    {x=-2965.91  ,y=390.7833  ,z=14.06 },
    {x=-3242.203 ,y=999.7093  ,z=11.84 },
    {x=-1819.728 ,y=794.6349  ,z=137.09},
  },
  { -- west coast
    {x=2555.058  ,y=380.6407  ,z=107.63},
  },
  {  -- sandy shore
    {x=2675.866  ,y=3280.38   ,z=54.25 },
    {x=549.6006  ,y=2669.001  ,z=41.17 },
    {x=1165.902  ,y=2711.337  ,z=37.17 },
    {x=1958.744  ,y=3741.852  ,z=31.35 },
    {x=1697.708  ,y=4922.295  ,z=41.08 },
  },
  { -- paleto
    {x=1728.768  ,y=6417.453  ,z=34.05 }
  }
}

Config.uniforms = {
  wear1 = {
    male = {
      ['tshirt_1'] = 96 , ['tshirt_2'] = 1,
      ['torso_1']  = 31 , ['torso_2']  = 0,
      ['decals_1'] = 0  , ['decals_2'] = 0,
      ['arms']     = 1 ,
      ['pants_1']  = 25 , ['pants_2']  = 0,
      ['shoes_1']  = 20 , ['shoes_2']  = 7,
      ['helmet_1'] = -1  , ['helmet_2'] = 0,
      ['chain_1']  = 0  , ['chain_2']  = 0,
      ['ears_1']   = -1 , ['ears_2']   = 0,
      ['bags_1']   = 0  , ['bags_2']   = 0
    },
    female = {
      ['tshirt_1'] = 101 , ['tshirt_2'] = 1,
      ['torso_1']  = 7 , ['torso_2']  = 0,
      ['decals_1'] = 0  , ['decals_2'] = 0,
      ['arms']     = 7 ,
      ['pants_1']  = 36  , ['pants_2']  = 2,
      ['shoes_1']  = 42 , ['shoes_2']  = 2,
      ['helmet_1'] = -1 , ['helmet_2'] = 0,
      ['chain_1']  = 0  , ['chain_2']  = 0,
      ['ears_1']   = -1 , ['ears_2']   = 0,
      ['bags_1']   = 0  , ['bags_2']   = 0
    }
  },
  wear2 = {
    male = {
      ['tshirt_1'] = 15 , ['tshirt_2'] = 0,
      ['torso_1']  = 26 , ['torso_2']  = 2,
      ['decals_1'] = 0  , ['decals_2'] = 0,
      ['arms']     = 59 ,
      ['pants_1']  = 15 , ['pants_2']  = 11,
      ['shoes_1']  = 62 , ['shoes_2']  = 3,
      ['helmet_1'] = 3  , ['helmet_2'] = 2,
      ['chain_1']  = 112, ['chain_2']  = 0,
      ['ears_1']   = -1 , ['ears_2']   = 0,
      ['bags_1']   = 34 , ['bags_2']   = 3
    },
    female = {
      ['tshirt_1'] = 7 , ['tshirt_2'] = 0,
      ['torso_1']  = 27 , ['torso_2']  = 2,
      ['decals_1'] = 0  , ['decals_2'] = 0,
      ['arms']     = 59 ,
      ['pants_1']  = 11  , ['pants_2']  =11,
      ['shoes_1']  = 65 , ['shoes_2']  = 0,
      ['helmet_1'] = -1 , ['helmet_2'] = 0,
      ['chain_1']  = 83  , ['chain_2']  = 0,
      ['ears_1']   = -1 , ['ears_2']   = 0,
      ['bags_1']   = 35  , ['bags_2']   = 3
    }
  },
  wear3 = {
    male = {
      ['tshirt_1'] = 75 , ['tshirt_2'] = 3,
      ['torso_1']  = 72 , ['torso_2']  = 2,
      ['decals_1'] = 0  , ['decals_2'] = 0,
      ['arms']     = 33 ,
      ['pants_1']  = 10 , ['pants_2']  = 0,
      ['shoes_1']  = 12 , ['shoes_2']  = 6,
      ['helmet_1'] = -1 , ['helmet_2'] = 0,
      ['chain_1']  = 0  , ['chain_2']  = 0,
      ['ears_1']   = -1 , ['ears_2']   = 0,
      ['bags_1']   = 0  , ['bags_2']   = 0
    },
    female = {
      ['tshirt_1'] = 67 , ['tshirt_2'] = 3,
      ['torso_1']  = 70 , ['torso_2']  = 1,
      ['decals_1'] = 0  , ['decals_2'] = 0,
      ['arms']     = 34 ,
      ['pants_1']  = 37 , ['pants_2']  = 0,
      ['shoes_1']  = 27 , ['shoes_2']  = 0,
      ['helmet_1'] = -1 , ['helmet_2'] = 0,
      ['chain_1']  = 0  , ['chain_2']  = 0,
      ['ears_1']   = -1 , ['ears_2']   = 0,
      ['bags_1']   = 0  , ['bags_2']   = 0
    }
  },
  wear4 = {
    male = {
      ['tshirt_1'] = 21 , ['tshirt_2'] = 4,
      ['torso_1']  = 119, ['torso_2']  = 9,
      ['decals_1'] = 0  , ['decals_2'] = 0,
      ['arms']     = 12 ,
      ['pants_1']  = 22 , ['pants_2']  = 8,
      ['shoes_1']  = 20 , ['shoes_2']  = 5,
      ['helmet_1'] = -1 , ['helmet_2'] = 0,
      ['chain_1']  = 21 , ['chain_2']  = 7,
      ['ears_1']   = -1 , ['ears_2']   = 0,
      ['bags_1']   = 0  , ['bags_2']   = 0
    },
    female = {
      ['tshirt_1'] = 41 , ['tshirt_2'] = 1,
      ['torso_1']  = 58 , ['torso_2']  = 6,
      ['decals_1'] = 0  , ['decals_2'] = 0,
      ['arms']     = 14 ,
      ['pants_1']  = 37 , ['pants_2']  = 6,
      ['shoes_1']  = 20 , ['shoes_2']  = 1,
      ['helmet_1'] = -1 , ['helmet_2'] = 0,
      ['chain_1']  = 0  , ['chain_2']  = 0,
      ['ears_1']   = -1 , ['ears_2']   = 0,
      ['bags_1']   = 0  , ['bags_2']   = 0
    }
  }
}
