if Config.Framework == 'esx' then
    ESX = nil
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        
        for bikeType, bikeData in pairs(Config.Bikes) do
            if bikeData.enabled then
                ESX.RegisterUsableItem(bikeType, function(source)
                    local xPlayer = ESX.GetPlayerFromId(source)
                    
                    if xPlayer then
                        xPlayer.removeInventoryItem(bikeType, 1)
                        TriggerClientEvent('bmx_item:spawnBike', source, bikeType)
                    end
                end)
            end
        end
    end)
    
    RegisterNetEvent('bmx_item:pickupBike')
    AddEventHandler('bmx_item:pickupBike', function(bikeType)
        local xPlayer = ESX.GetPlayerFromId(source)
        
        if xPlayer and Config.Bikes[bikeType] then
            xPlayer.addInventoryItem(bikeType, 1)
        end
    end)

elseif Config.Framework == 'qbcore' then
    QBCore = nil
    
    Citizen.CreateThread(function()
        while QBCore == nil do
            QBCore = exports['qb-core']:GetCoreObject()
            Citizen.Wait(100)
        end
    end)
    
    Citizen.CreateThread(function()
        Citizen.Wait(1000)
        
        for bikeType, bikeData in pairs(Config.Bikes) do
            if bikeData.enabled then
                QBCore.Functions.CreateUseableItem(bikeType, function(source, item)
                    local Player = QBCore.Functions.GetPlayer(source)
                    
                    if Player then
                        Player.Functions.RemoveItem(bikeType, 1)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[bikeType], "remove")
                        TriggerClientEvent('bmx_item:spawnBike', source, bikeType)
                    end
                end)
            end
        end
    end)
    
    RegisterNetEvent('bmx_item:pickupBike')
    AddEventHandler('bmx_item:pickupBike', function(bikeType)
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        
        if Player and Config.Bikes[bikeType] then
            Player.Functions.AddItem(bikeType, 1)
            TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[bikeType], "add")
        end
    end)

elseif Config.Framework == 'standalone' then
    local playerBikes = {}
    
    RegisterNetEvent('bmx_item:useBike')
    AddEventHandler('bmx_item:useBike', function(bikeType)
        local src = source
        
        if Config.Bikes[bikeType] and Config.Bikes[bikeType].enabled then
            if not playerBikes[src] then
                playerBikes[src] = {}
            end
            
            if playerBikes[src][bikeType] and playerBikes[src][bikeType] > 0 then
                playerBikes[src][bikeType] = playerBikes[src][bikeType] - 1
                TriggerClientEvent('bmx_item:spawnBike', src, bikeType)
            end
        end
    end)
    
    RegisterNetEvent('bmx_item:pickupBike')
    AddEventHandler('bmx_item:pickupBike', function(bikeType)
        local src = source
        
        if Config.Bikes[bikeType] then
            if not playerBikes[src] then
                playerBikes[src] = {}
            end
            
            if not playerBikes[src][bikeType] then
                playerBikes[src][bikeType] = 0
            end
            
            playerBikes[src][bikeType] = playerBikes[src][bikeType] + 1
        end
    end)
    
    RegisterCommand('givebike', function(source, args)
        local src = source
        local bikeType = args[1]
        
        if bikeType and Config.Bikes[bikeType] then
            if not playerBikes[src] then
                playerBikes[src] = {}
            end
            
            if not playerBikes[src][bikeType] then
                playerBikes[src][bikeType] = 0
            end
            
            playerBikes[src][bikeType] = playerBikes[src][bikeType] + 1
            TriggerClientEvent('chat:addMessage', src, {
                args = {'Système', 'Vous avez reçu un ' .. Config.Bikes[bikeType].label}
            })
        end
    end, false)
end
