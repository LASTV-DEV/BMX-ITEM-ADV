Config = {}

Config.Framework = 'esx'

Config.DrawDistance = 3.0
Config.PickupDistance = 2.0
Config.PickupKey = 38

Config.Text3D = {
    scale = 0.30,
    font = 4,
    color = {255, 255, 255, 215},
    message = "Appuyez sur ~b~E~s~ pour ramasser le vélo"
}

Config.Animations = {
    deploy = {
        dict = "anim@narcotics@trash",
        name = "drop_front",
        duration = 1000
    },
    pickup = {
        dict = "anim@narcotics@trash",
        name = "drop_front",
        duration = 1000
    }
}

Config.Bikes = {
    ['bmx'] = {
        label = 'BMX',
        model = 'bmx',
        spawnDistance = 2.0,
        weight = 5,
        enabled = true
    },
    
    ['cruiser'] = {
        label = 'Cruiser',
        model = 'cruiser',
        spawnDistance = 2.0,
        weight = 6,
        enabled = true
    },
    
    ['fixter'] = {
        label = 'Fixter',
        model = 'fixter',
        spawnDistance = 2.0,
        weight = 5,
        enabled = true
    },
    
    ['scorcher'] = {
        label = 'Scorcher VTT',
        model = 'scorcher',
        spawnDistance = 2.0,
        weight = 7,
        enabled = true
    },
    
    ['tribike'] = {
        label = 'TriBike Course',
        model = 'tribike',
        spawnDistance = 2.0,
        weight = 6,
        enabled = true
    },
    
    ['tribike2'] = {
        label = 'TriBike Sport',
        model = 'tribike2',
        spawnDistance = 2.0,
        weight = 6,
        enabled = true
    },
    
    ['tribike3'] = {
        label = 'TriBike Pro',
        model = 'tribike3',
        spawnDistance = 2.0,
        weight = 6,
        enabled = true
    }
}

Config.AutoDeleteTime = 0
Config.PickupInVehicle = false
Config.VehicleInvincible = false
Config.LockVehicle = false
