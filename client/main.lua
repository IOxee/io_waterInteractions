ESX = nil
local IsAnimated = false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function GetPed() return PlayerPedId() end

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextDropshadow(0, 0, 0, 155)
    SetTextEdge(1, 0, 0, 0, 250)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
end

if Config.removeObjectWhenPlayerContactWithWater then
    Citizen.CreateThread(function()
        while true do
            if not IsPedInAnyVehicle(GetPed(), false) then
                if IsPedSwimming(GetPed()) then
                    TriggerServerEvent('io_waterInteractions:removeObject', source)
                end
            end
            Citizen.Wait(500)
        end
    end)
end

RegisterNetEvent('io_waterInteractions:checkwater')
AddEventHandler('io_waterInteractions:checkwater', function(bool, timer)
    if not IsAnimated then
        if not IsPedInAnyVehicle(GetPed(), false) then
	    	if IsEntityInWater(GetPed()) then
                LoadAnimDict(Config.animDict)
                TaskPlayAnim(GetPed(), Config.animDict, Config.anim, 8.0, 8.0, -1, 33, 0, 0, 0, 0)
                IsAnimated = true
                exportsProgressBars(Translation.Sayings[1] .. bool, timer)
                Wait(timer)
                ClearPedTasks(GetPed())
                IsAnimated = false
	    		TriggerServerEvent('io_waterInteractions:collectingWater')
	    	else
                SendNotifications(Translation.Sayings[2], "error") 
	    	end
        else
            SendNotifications(Translation.Sayings[3], "error") 
	    end
    else
        SendNotifications(Translation.Sayings[4], "error")
    end
end)