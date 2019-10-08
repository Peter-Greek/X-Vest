print("X-Vest Made by Xerxes468893#0001 / Peter Greek")  -- dont remove please

RegisterCommand("vest", function(source, args, raw)
	local player = source 
	if (player > 0) then
		local version = args[1]
		TriggerClientEvent("ARPF:vest", source, version)
		CancelEvent()
	end
end, false)

RegisterCommand("removevest", function(source, args, raw)
	local player = source 
	if (player > 0) then
		TriggerClientEvent("ARPF:vestoff", source)
		CancelEvent()
	end
end, false)

RegisterServerEvent('Xvest:givevesttoserver')
AddEventHandler('Xvest:givevesttoserver', function(otherperson,  types, givento)
TriggerClientEvent("ARPF:vest", otherperson, types, givento)
end)
