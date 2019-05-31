AdminRoom2AOccupied = false
AdminRoom2BOccupied = false
AdminRoom2COccupied = false
AdminRoom2DOccupied = false
UnhandledAdminCall = 0
Admincalls = {}
for i = 1, 4 do
    Admincalls[i] = {}

    for j = 1, 2 do
        Admincalls[i][j] = 0
    end
end

RegisterNetEvent("SyncAvailableAdminRoomsServer")
AddEventHandler("SyncAvailableAdminRoomsServer", function()
	TriggerClientEvent("SyncAvailableAdminRoomsClient", -1,AdminRoom2AOccupied,AdminRoom2BOccupied,AdminRoom2COccupied,AdminRoom2DOccupied,Admincalls)
end)

RegisterNetEvent("OccupieAdminRoom")
AddEventHandler("OccupieAdminRoom", function(roomname)
	local playername = 	GetPlayerName(source)
	if roomname == "2A" then
		AdminRoom2AOccupied = true
		Admincalls[1][1] = source..""
		Admincalls[1][2] = playername
		print(Admincalls[1][2].." "..Admincalls[1][1])
	else
		if roomname == "2B" then
			AdminRoom2BOccupied = true
			Admincalls[2][1] = source..""
			Admincalls[2][2] = playername
			print(Admincalls[2][2].." "..Admincalls[2][1])
		else
			if roomname == "2C" then
				AdminRoom2COccupied = true
				Admincalls[3][1] = source..""
				Admincalls[3][2] = playername
				print(Admincalls[3][2].." "..Admincalls[3][1])
			else
				if roomname == "2D" then
					AdminRoom2DOccupied = true
					Admincalls[4][1] = source..""
					Admincalls[4][2] = playername
					print(Admincalls[4][2].." "..Admincalls[4][1])
				end
			end
		end
	end
	UnhandledAdminCall = UnhandledAdminCall + 1
	TriggerClientEvent("SyncAdminCallsClient", -1,UnhandledAdminCall)
	print(UnhandledAdminCall)
end)

RegisterNetEvent("UnoccupieAdminRoom")
AddEventHandler("UnoccupieAdminRoom", function(roomname)
	if roomname == "2A" then
		AdminRoom2AOccupied = false
	else
		if roomname == "2B" then
			AdminRoom2BOccupied = false
		else
			if roomname == "2C" then
				AdminRoom2COccupied = false
			else
				if roomname == "2D" then
					AdminRoom2DOccupied = false
				end
			end
		end
	end
end)