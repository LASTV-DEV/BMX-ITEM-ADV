local spawnedBikes = {}

RegisterNetEvent('bmx_item:spawnBike')
AddEventHandler('bmx_item:spawnBike', function(bikeType)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local heading = GetEntityHeading(playerPed)
    
    if not Config.Bikes[bikeType] or not Config.Bikes[bikeType].enabled then
        return
    end
    
    local bikeConfig = Config.Bikes[bikeType]
    
    local forward = GetEntityForwardVector(playerPed)
    local spawnCoords = vector3(
        coords.x + forward.x * bikeConfig.spawnDistance,
        coords.y + forward.y * bikeConfig.spawnDistance,
        coords.z
    )
    
    RequestAnimDict(Config.Animations.deploy.dict)
    while not HasAnimDictLoaded(Config.Animations.deploy.dict) do
        Citizen.Wait(100)
    end
    
    TaskPlayAnim(playerPed, Config.Animations.deploy.dict, Config.Animations.deploy.name, 8.0, -8.0, Config.Animations.deploy.duration, 0, 0, false, false, false)
    
    Citizen.Wait(Config.Animations.deploy.duration)
    
    local bikeHash = GetHashKey(bikeConfig.model)
    RequestModel(bikeHash)
    while not HasModelLoaded(bikeHash) do
        Citizen.Wait(100)
    end
    
    local bike = CreateVehicle(bikeHash, spawnCoords.x, spawnCoords.y, spawnCoords.z, heading, true, false)
    SetEntityAsMissionEntity(bike, true, true)
    SetVehicleOnGroundProperly(bike)
    
    if Config.VehicleInvincible then
        SetEntityInvincible(bike, true)
    end
    
    if Config.LockVehicle then
        SetVehicleDoorsLocked(bike, 2)
        SetVehicleDoorsLockedForPlayer(bike, PlayerId(), false)
    end
    
    table.insert(spawnedBikes, {vehicle = bike, type = bikeType})
    
    SetModelAsNoLongerNeeded(bikeHash)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local isInVehicle = IsPedInAnyVehicle(playerPed, false)
        
        for i = #spawnedBikes, 1, -1 do
            local bikeData = spawnedBikes[i]
            local bike = bikeData.vehicle
            
            if DoesEntityExist(bike) then
                local bikeCoords = GetEntityCoords(bike)
                local distance = #(playerCoords - bikeCoords)
                
                if distance < Config.DrawDistance and (not isInVehicle or Config.PickupInVehicle) then
                    Draw3DText(bikeCoords.x, bikeCoords.y, bikeCoords.z + 0.5, Config.Text3D.message)
                    
                    if distance < Config.PickupDistance and IsControlJustReleased(0, Config.PickupKey) then
                        RequestAnimDict(Config.Animations.pickup.dict)
                        while not HasAnimDictLoaded(Config.Animations.pickup.dict) do
                            Citizen.Wait(100)
                        end
                        
                        TaskPlayAnim(playerPed, Config.Animations.pickup.dict, Config.Animations.pickup.name, 8.0, -8.0, Config.Animations.pickup.duration, 0, 0, false, false, false)
                        
                        Citizen.Wait(Config.Animations.pickup.duration)
                        
                        Framework.DeleteVehicle(bike)
                        
                        TriggerServerEvent('bmx_item:pickupBike', bikeData.type)
                        
                        table.remove(spawnedBikes, i)
                    end
                end
            else
                table.remove(spawnedBikes, i)
            end
        end
    end
end)

if Config.AutoDeleteTime > 0 then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(Config.AutoDeleteTime * 60000)
            
            for i = #spawnedBikes, 1, -1 do
                local bike = spawnedBikes[i].vehicle
                if DoesEntityExist(bike) then
                    local playerPed = PlayerPedId()
                    if not IsPedInVehicle(playerPed, bike, false) then
                        Framework.DeleteVehicle(bike)
                        table.remove(spawnedBikes, i)
                    end
                end
            end
        end
    end)
end

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    
    SetTextScale(Config.Text3D.scale, Config.Text3D.scale)
    SetTextFont(Config.Text3D.font)
    SetTextProportional(1)
    SetTextColour(Config.Text3D.color[1], Config.Text3D.color[2], Config.Text3D.color[3], Config.Text3D.color[4])
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)
end
