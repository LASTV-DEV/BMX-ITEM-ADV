Framework = {}

if Config.Framework == 'esx' then
    ESX = nil
    
    Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
    
    function Framework.GetPlayerData()
        if ESX then
            return ESX.GetPlayerData()
        end
        return nil
    end
    
    function Framework.ShowNotification(message)
        if ESX then
            ESX.ShowNotification(message)
        end
    end

elseif Config.Framework == 'qbcore' then
    QBCore = nil
    
    Citizen.CreateThread(function()
        while QBCore == nil do
            QBCore = exports['qb-core']:GetCoreObject()
            Citizen.Wait(100)
        end
    end)
    
    function Framework.GetPlayerData()
        if QBCore then
            return QBCore.Functions.GetPlayerData()
        end
        return nil
    end
    
    function Framework.ShowNotification(message)
        if QBCore then
            QBCore.Functions.Notify(message, 'success')
        end
    end

elseif Config.Framework == 'standalone' then
    function Framework.GetPlayerData()
        return {identifier = GetPlayerServerId(PlayerId())}
    end
    
    function Framework.ShowNotification(message)
        SetNotificationTextEntry('STRING')
        AddTextComponentString(message)
        DrawNotification(false, false)
    end
end

function Framework.DeleteVehicle(vehicle)
    if Config.Framework == 'esx' and ESX then
        ESX.Game.DeleteVehicle(vehicle)
    else
        SetEntityAsMissionEntity(vehicle, true, true)
        DeleteVehicle(vehicle)
    end
end
