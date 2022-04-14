ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


Citizen.CreateThread(function()
	for i = 1, #CollectorsObject do
		local collectors = CollectorsObject[i]
		ESX.RegisterUsableItem(collectors.collectorItem, function(source)
			local xPlayer = ESX.GetPlayerFromId(source)
			TriggerClientEvent('io_waterInteractions:checkwater', source, ESX.GetItemLabel(collectors.collectorItem), collectors.progressBarTimer)
		end)
	end
end)

RegisterNetEvent('io_waterInteractions:collectingWater')
AddEventHandler('io_waterInteractions:collectingWater', function()
	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	SendNotifications(Translation.Sayings[7], "success", true)
	for k,v in pairs(CollectorsObject) do
		xPlayer.removeInventoryItem(v.collectorItem, 1)
		xPlayer.addInventoryItem(v.containerObject, 1)
	end
end)

RegisterNetEvent('io_waterInteractions:removeObject')
AddEventHandler('io_waterInteractions:removeObject', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	for k,v in pairs(RemovableObject) do
		originalItemAmout = xPlayer.getInventoryItem(v.originalItem).count
		if originalItemAmout > 0 then
			SendNotifications(Translation.Sayings[5] .. ESX.GetItemLabel(v.originalItem) .. Translation.Sayings[6], "error", true)
			xPlayer.removeInventoryItem(v.originalItem, originalItemAmout)
			xPlayer.addInventoryItem(v.brokenItem, originalItemAmout)
		end
	end
end)