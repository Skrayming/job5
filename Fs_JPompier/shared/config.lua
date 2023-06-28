local second = 1000
local minute = 60 * second

EarlyRespawnTimer          = 8 * minute  -- Temp de mort si les ambulancier sont pas venu

ConfigWebhookRendezVouspompier = "https://discord.com/api/webhooks/939468172757712936/qqAKmaXGHgsC876ykZm3Ulc7YyXowSt1kcHnVrFT-q5xmKTxYt7bOUsv4jSWSObIqHG1" -- Metez le webhook de votre salon disocrd configure pour le job ems 

Config = {

	Locale                     = 'fr',

	RespawnPoint = { coords = vector3(322.1182, -584.4746, 43.2841), heading = 61.63 }, -- L'endroit ou tu respawn apers la mort

	EarlyRespawnFine           = false, 
    EarlyRespawnFineAmount     = 5000, 

	RemoveWeaponsAfterRPDeath  = false, -- Supprime les arme sur sois 
    RemoveCashAfterRPDeath     = false, -- Supprime l'argent cash et sale sur sois 
    RemoveItemsAfterRPDeath    = false, -- Supprime tout les item sur sois 

    BleedoutTimer              = 10 * minute, -- Temp de l'effet quand tu respawn 

	ReviveReward               = 150,  -- Price du revive
    AntiCombatLog              = true, -- enable anti-combat logging?

    MarkerType = 22, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
    MarkerSizeLargeur = 0.3, -- Largeur du marker
    MarkerSizeEpaisseur = 0.3, -- Épaisseur du marker
    MarkerSizeHauteur = 0.3, -- Hauteur du marker
    MarkerDistance = 6.0, -- Distane de visibiliter du marker (1.0 = 1 mètre)
    MarkerColorR = 69, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerColorG = 112, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerColorB = 246, -- Voir pour les couleurs RGB: https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerOpacite = 180, -- Opacité du marker (min: 0, max: 255)
    MarkerSaute = true, -- Si le marker saute (true = oui, false = non)
    MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)

    TextCoffre = "Appuyez sur ~b~[E] ~s~pour accèder au ~b~coffre ~s~!",  -- Text Menu coffre
    TextPharmacie = "Appuyez sur ~b~[E] ~s~pour accèder a la ~b~pharmacie ~s~!",  -- Text Menu Pharamcie
    TextVestaire = "Appuyez sur ~b~[E] ~s~pour pour accèder au ~b~vestaire ~s~!", -- Text Menu Vestaire
    TextBoss = "Appuyez sur ~b~[E] ~s~pour pour accèder au ~b~action patron ~s~!",  -- Text Menu Boss
    TextGarageVehicule = "Appuyez sur ~b~[E] ~s~pour accèder au ~b~garage ~s~!",  -- Text Garage Voiture
	TextGarageHeli = "Appuyez sur ~b~[E] ~s~pour accèder au ~b~garage ~s~!",  -- Text Garage Hélico
	TextAscenseur = "Appuyez sur ~b~[E] ~s~pour accèder à ~b~l'étage ~s~!",  -- Text Ascenseur
    TextAccueil = "Appuyez sur ~b~[E] ~s~pour parler a la secrétaire ~s~!",  -- Text Ascenseur
	

AmbuVehiculespompier = { 
    {buttoname = "↓ ~y~Sap ~s~↓", rightlabel = "", spawnname = "", spawnzone = vector3(-2029.0559082031, -473.56292724609, 12.213418960571), headingspawn = 317.64691162109375}, -- Garage Voiture
	{buttoname = "Vsav", rightlabel = "→→", spawnname = "vsavbspp", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
	{buttoname = "Vsav 2", rightlabel = "→→", spawnname = "vsavbspp2", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Vsav 3", rightlabel = "→→", spawnname = "vsavbmpm", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
	{buttoname = "Vsav Tib", rightlabel = "→→", spawnname = "vsavtib", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "↓ ~y~Inc ~s~↓", rightlabel = "", spawnname = "", spawnzone = vector3(-2029.0559082031, -473.56292724609, 12.213418960571), headingspawn = 317.64691162109375},     
    {buttoname = "Epan", rightlabel = "→→", spawnname = "epan", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Camion d'acompagnement", rightlabel = "→→", spawnname = "canonels", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Vps", rightlabel = "→→", spawnname = "vpsbspp", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Fpt", rightlabel = "→→", spawnname = "fptbspp", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Ccf", rightlabel = "→→", spawnname = "ccfbmpm", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Ccf 2", rightlabel = "→→", spawnname = "ccfbspp", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Ps", rightlabel = "→→", spawnname = "psbspp", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Fpt", rightlabel = "→→", spawnname = "fpt77", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "CCfl", rightlabel = "→→", spawnname = "ccfl", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "↓ ~y~Spécifique ~s~↓", rightlabel = "", spawnname = "", spawnzone = vector3(-2029.0559082031, -473.56292724609, 12.213418960571), headingspawn = 317.64691162109375},     
    {buttoname = "Vtu", rightlabel = "→→", spawnname = "vtu33", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Vlchef", rightlabel = "→→", spawnname = "vlchef", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Vlhr", rightlabel = "→→", spawnname = "vlhr33", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Kangoo", rightlabel = "→→", spawnname = "vlcg33", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Vl Grimp", rightlabel = "→→", spawnname = "grimpbspp", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Vlhr Grimp", rightlabel = "→→", spawnname = "landgrimp", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Pcc", rightlabel = "→→", spawnname = "dailypcc13", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Vsm", rightlabel = "→→", spawnname = "vsm83", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Zodiac", rightlabel = "→→", spawnname = "zodiac", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
    {buttoname = "Vlmi", rightlabel = "→→", spawnname = "vlmi74", spawnzone = vector3(1189.2520751953, -1475.2359619141, 34.692276000977), headingspawn = 358.9125061035156}, 
},

AmbuHelicopompier = { 
	{buttonameheli = "EC - 135", rightlabel = "→→", spawnnameheli = "supervolito", spawnzoneheli = vector3(1208.9575195313, -1505.5881347656, 34.692588806152), headingspawnheli = 250.93191528320312}, -- Garage Hélico
},


Pharmacie = {
    {Nom = "Medikit", Item = "medikit"}, -- Item Pour la Pharmacie
    {Nom = "Bandage", Item = "bandage"}, 
    {Nom = "Brancard", Item = "stretcher"}, 
    {Nom = "Echelle", Item = "ladder"}, 
},

Ascenseur = {
	vector3(-436.11, -360.62, 34.95), -- Etage 0 [Accueil]
	vector3(-493.61, -327.43, 42.31), -- Etage 1 [Direction]
    vector3(-439.77, -335.78, 78.3), -- Etage 2 [Héliport] 
},

Position = {
	    -- Boss = {vector3(-498.26, -315.48, 42.32)}, -- Menu boss 
	    -- Coffre = {vector3(-436.85, -318.45, 34.91)}, -- Menu coffre 
        Pharmacie = {vector3(1205.6031494141, -1486.3851318359, 34.692302703857)}, -- Menu Pharmacie 
        Vestaire = {vector3(1237.2774658203, -1493.7816162109, 34.692306518555)}, -- Menu Vestaire 
        Accueil = {vector3(308.59057617188, -595.36560058594, 43.284061431885)}, -- Menu Pour Accueil 
        GarageVehicule = {vector3(1191.4600830078, -1482.5570068359, 34.692276000977)}, -- Menu Garage Vehicule
	    GarageHeli = {vector3(1208.9575195313, -1505.5881347656, 34.692588806152)}, -- Menu Garage Helico
    }
}

AmbuCloak = {
	clothes = {
        specials = {
                [0] = {
                    label = "Tenue Civil",
                    minimum_grade = 0,
                    variations = {male = {}, female = {}},
                    onEquip = function()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin) TriggerEvent('skinchanger:loadSkin', skin) end)
                        SetPedArmour(PlayerPedId(), 0)
                    end
                },
                [1] = {
                    minimum_grade = 0,
                    label = "Sac PS",
                    variations = {
                    male = {
                        tshirt_1 = 15,  tshirt_2 = 0,
                        torso_1 = 93,   torso_2 = 0,
                        decals_1 = 0,   decals_2 = 0,
                        arms = 85,
                        pants_1 = 45, pants_2 = 0,
                        shoes_1 = 25, shoes_2 = 0,
                        mask_1 = 0, mask_2 = 0,
                        bproof_1 = 2, bproof_2 = 1,
                        helmet_1 = -1, helmet_2 = 0,
                        chain_1 = 0, chain_2 = 0,
                        decals_1 = 0, decals_2 = 0,
                    },
                    female = {
                        tshirt_1 = 39,  tshirt_2 = 0,
                        torso_1 = 90,   torso_2 = 2,
                        decals_1 = 0,   decals_2 = 0,
                        arms = 101,
                        pants_1 = 23,   pants_2 = 0,
                        shoes_1 = 74,   shoes_2 = 1,
                        helmet_1 = -1,  helmet_2 = 0,
                        chain_1 = 96,    chain_2 = 0,
                        ears_1 = -1,     ears_2 = 0
                    }
                },
                onEquip = function()  
                end
                }
            },
            grades = {
                -- @label = Le nom affiché de la tenue de grade
                -- @male = Les composants skinchanger pour les hommes
                -- @female = Les composants skinchanger pour les femmes
                [2] = {
                    label = "Tenue Feu",
                    minimum_grade = 0,
                    variations = {
                    male = {
                        bags_1 = 0, bags_2 = 0,
                        tshirt_1 = 106, tshirt_2 = 0,
                        torso_1 = 127, torso_2 = 0,
                        arms = 31,
                        pants_1 = 43, pants_2 = 0,
                        shoes_1 = 25, shoes_2 = 0,
                        mask_1 = 0, mask_2 = 0,
                        bproof_1 = 0, bproof_2 = 0,
                        helmet_1 = 79, helmet_2 = 0,
                        chain_1 = 0, chain_2 = 0,
                        decals_1 = 0, decals_2 = 0,
                    },
                    female = {
                        bags_1 = 0, bags_2 = 0,
                        tshirt_1 = 15, tshirt_2 = 0,
                        torso_1 = 18, torso_2 = 6,
                        arms = 101,
                        pants_1 = 23, pants_2 = 0,
                        shoes_1 = 74, shoes_2 = 1,
                        mask_1 = 0, mask_2 = 0,
                        bproof_1 = 0, bproof_2 = 0,
                        helmet_1 = -1, helmet_2 = 0,
                        chain_1 = 0, chain_2 = 0,
                        decals_1 = 0, decals_2 = 0
                    }
                },
                onEquip = function()
                end
            },
                [3] = {
                    minimum_grade = 0,
                    label = "Tenue Sport",
                    variations = {
                    male = {
                        tshirt_1 = 15,  tshirt_2 = 0,
                        torso_1 = 171,   torso_2 = 0,
                        decals_1 = 0,   decals_2 = 0,
                        arms = 0,
                        pants_1 = 45, pants_2 = 0,
                        shoes_1 = 25, shoes_2 = 0,
                        mask_1 = 0, mask_2 = 0,
                        bproof_1 = 0, bproof_2 = 0,
                        helmet_1 = -1, helmet_2 = 0,
                        chain_1 = 0, chain_2 = 0,
                        decals_1 = 0, decals_2 = 0,
                    },
                    female = {
                        tshirt_1 = 15,  tshirt_2 = 0,
                        torso_1 = 18,   torso_2 = 4,
                        decals_1 = 0,   decals_2 = 0,
                        arms = 101,
                        pants_1 = 23,   pants_2 = 1,
                        shoes_1 = 74,   shoes_2 = 1,
                        helmet_1 = -1,  helmet_2 = 0,
                        chain_1 = 96,    chain_2 = 0,
                        ears_1 = -1,     ears_2 = 0
                    }
                },
                onEquip = function()
                end

            },
            [4] = {
                minimum_grade = 0,
                label = "Tenue Plongée",
                variations = {
                male = {
                    tshirt_1 = 151,  tshirt_2 = 0,
                    torso_1 = 243,   torso_2 = 3,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 0,
                    pants_1 = 94, pants_2 = 3,
                    shoes_1 = 67, shoes_2 = 7,
                    mask_1 = 0, mask_2 = 0,
                    bproof_1 = 0, bproof_2 = 0,
                    helmet_1 = -1, helmet_2 = 0,
                    chain_1 = 0, chain_2 = 0,
                    decals_1 = 0, decals_2 = 0,
                },
                female = {
                    tshirt_1 = 15,  tshirt_2 = 0,
                    torso_1 = 18,   torso_2 = 4,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 101,
                    pants_1 = 23,   pants_2 = 1,
                    shoes_1 = 74,   shoes_2 = 1,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 96,    chain_2 = 0,
                    ears_1 = -1,     ears_2 = 0
                }
            },
            onEquip = function()
            end

            },
            [5] = {
                minimum_grade = 0,
                label = "Tenue Polo",
                variations = {
                    male = {
                        tshirt_1 = 15,  tshirt_2 = 0,
                        torso_1 = 93,   torso_2 = 0,
                        decals_1 = 0,   decals_2 = 0,
                        arms = 85,
                        pants_1 = 45, pants_2 = 0,
                        shoes_1 = 25, shoes_2 = 0,
                        mask_1 = 0, mask_2 = 0,
                        bproof_1 = 0, bproof_2 = 0,
                        helmet_1 = -1, helmet_2 = 0,
                        chain_1 = 0, chain_2 = 0,
                        decals_1 = 0, decals_2 = 0,
                    },
                    female = {
                        tshirt_1 = 39,  tshirt_2 = 0,
                        torso_1 = 90,   torso_2 = 2,
                        decals_1 = 0,   decals_2 = 0,
                        arms = 101,
                        pants_1 = 23,   pants_2 = 0,
                        shoes_1 = 74,   shoes_2 = 1,
                        helmet_1 = -1,  helmet_2 = 0,
                        chain_1 = 96,    chain_2 = 0,
                        ears_1 = -1,     ears_2 = 0
                }
            },
            onEquip = function()
            end

            },
            [6] = {
                minimum_grade = 0,
                label = "Tenue Grimp",
                variations = {
                male = {
                    tshirt_1 = 15,  tshirt_2 = 0,
                    torso_1 = 245,   torso_2 = 0,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 31,
                    pants_1 = 52, pants_2 = 1,
                    shoes_1 = 25, shoes_2 = 0,
                    mask_1 = 0, mask_2 = 0,
                    bproof_1 = 0, bproof_2 = 0,
                    helmet_1 = 6, helmet_2 = 0,
                    chain_1 = 0, chain_2 = 0,
                    decals_1 = 0, decals_2 = 0,
                },
                female = {
                    tshirt_1 = 15,  tshirt_2 = 0,
                    torso_1 = 18,   torso_2 = 4,
                    decals_1 = 0,   decals_2 = 0,
                    arms = 101,
                    pants_1 = 23,   pants_2 = 1,
                    shoes_1 = 74,   shoes_2 = 1,
                    helmet_1 = -1,  helmet_2 = 0,
                    chain_1 = 96,    chain_2 = 0,
                    ears_1 = -1,     ears_2 = 0
                }
            },
            onEquip = function()
            end
            }
        },
    }
}
