--adminskins
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end

local adminskins = Set { "1650288984" }

--Variables
local FrontGateMessageCoords = vector3(2576, -282, 93)
local FrontGateMessageVisibleRange = 15
local FrontGateMessage1 = "~r~You are entering a Governmental Facility!"
local FrontGateMessage2 = "~g~Here you can request a meeting with an admin."

local FrontGateExitMessageCoords = vector3(2574, -306, 93)
local FrontGateExitMessageVisibleRange = 15
local FrontGateExitMessage = "~r~EXIT"

local FrontGateMessageGoLeftForAdminSupportCoords = vector3(2560, -285, 93)
local FrontGateMessageGoLeftForAdminSupportCoordsVisibleRange = 16
local FrontGateMessageGoLeftForAdminSupport1 = "~y~--"
local FrontGateMessageGoLeftForAdminSupport2 = "~y~Go Left For Admin Support!"

local FrontGateMessageGoInsideForAdminSupportCoords = vector3(2563, -325, 95)
local FrontGateMessageGoInsideForAdminSupportCoordsVisibleRange = 49
local FrontGateMessageGoInsideForAdminSupport1 = "~y~--"
local FrontGateMessageGoInsideForAdminSupport2 = "~y~Go Inside For Admin Support!"

local AdminBuildingEntranceCoords = vector3(2521.56, -414.32, 94)
local AdminBuildingEntranceHeading = 313
local AdminBuildingInsideCoords = vector3(2155.38, 2921, -62)
local AdminBuildingInsideHeading = 81

local AdminBuildingReceptionDeskCoords = vector3(2106.64, 2927.14, -62)

local AdminRoom2ACoords = vector3(2048, 2981, -67)
AdminRoom2AOccupied = false
local AdminRoom2BCoords = vector3(2052, 2987, -67)
AdminRoom2BOccupied = false
local AdminRoom2CCoords = vector3(2059, 2968, -67)
AdminRoom2COccupied = false
local AdminRoom2DCoords = vector3(2055, 2963, -67)
AdminRoom2DOccupied = false
local CalledForAdmin = false
local UnhandledAdminCall = 0

--Debug Variables DO NOT TOUCH
ESX = nil
local admincalleduiopen = false
local menuopen = false
local admincalled = false
local designatedroom = ""
local Admincalls = {}
local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

--Functions
RegisterNUICallback('CallAdminToIAA', function()
    SetNuiFocus(false, false)
	TriggerEvent("HideARM")
	TriggerServerEvent("SyncAvailableAdminRoomsServer")
	if not AdminRoom2AOccupied then
		TriggerEvent('chat:addMessage', {args = {'An admin has been called, please wait for him in room 2A!'}})
		TriggerServerEvent("OccupieAdminRoom","2A")
		SetNewWaypoint(AdminRoom2ACoords.x, AdminRoom2ACoords.y);
		TriggerEvent("StatusUpdate","Waiting")
		designatedroom = "2A"
	else
		if not AdminRoom2BOccupied then
			TriggerEvent('chat:addMessage', {args = {'An admin has been called, please wait for him in room 2B!'}})
			TriggerServerEvent("OccupieAdminRoom","2B")
			SetNewWaypoint(AdminRoom2BCoords.x, AdminRoom2BCoords.y);
			TriggerEvent("StatusUpdate","Waiting")
			designatedroom = "2B"
		else
			if not AdminRoom2COccupied then
				TriggerEvent('chat:addMessage', {args = {'An admin has been called, please wait for him in room 2C!'}})
				TriggerServerEvent("OccupieAdminRoom","2C")
				SetNewWaypoint(AdminRoom2CCoords.x, AdminRoom2CCoords.y);
				TriggerEvent("StatusUpdate","Waiting")
				designatedroom = "2C"
			else
				if not AdminRoom2DOccupied then
					TriggerEvent('chat:addMessage', {args = {'An admin has been called, please wait for him in room 2D!'}})
					TriggerServerEvent("OccupieAdminRoom","2D")
					SetNewWaypoint(AdminRoom2DCoords.x, AdminRoom2DCoords.y);
					TriggerEvent("StatusUpdate","Waiting")
					designatedroom = "2D"
				else
					TriggerEvent('chat:addMessage', {args = {'No available rooms at this time.'}})
				end
			end
		end
	end
	TriggerServerEvent("SyncAvailableAdminRoomsServer")
end)

RegisterNUICallback('AdminCalled', function()
	admincalled = true
end)

RegisterNUICallback('CallAdminForTextingToIAA', function()
    SetNuiFocus(false, false)
	TriggerEvent("HideARM")
	TriggerServerEvent("SyncAvailableAdminRoomsServer")
	if not AdminRoom2AOccupied then
		TriggerEvent('chat:addMessage', {args = {'An admin has been called, please wait for him in room 2A!'}})
		TriggerServerEvent("OccupieAdminRoom","2A")
		SetNewWaypoint(AdminRoom2ACoords.x, AdminRoom2ACoords.y);
		TriggerEvent("StatusUpdate","Waiting")
		designatedroom = "2A"
	else
		if not AdminRoom2BOccupied then
			TriggerEvent('chat:addMessage', {args = {'An admin has been called, please wait for him in room 2B!'}})
			TriggerServerEvent("OccupieAdminRoom","2B")
			SetNewWaypoint(AdminRoom2BCoords.x, AdminRoom2BCoords.y);
			TriggerEvent("StatusUpdate","Waiting")
			designatedroom = "2B"
		else
			if not AdminRoom2COccupied then
				TriggerEvent('chat:addMessage', {args = {'An admin has been called, please wait for him in room 2C!'}})
				TriggerServerEvent("OccupieAdminRoom","2C")
				SetNewWaypoint(AdminRoom2CCoords.x, AdminRoom2CCoords.y);
				TriggerEvent("StatusUpdate","Waiting")
				designatedroom = "2C"
			else
				if not AdminRoom2DOccupied then
					TriggerEvent('chat:addMessage', {args = {'An admin has been called, please wait for him in room 2D!'}})
					TriggerServerEvent("OccupieAdminRoom","2D")
					SetNewWaypoint(AdminRoom2DCoords.x, AdminRoom2DCoords.y);
					TriggerEvent("StatusUpdate","Waiting")
					designatedroom = "2D"
				else
					TriggerEvent('chat:addMessage', {args = {'No available rooms at this time.'}})
				end
			end
		end
	end
	TriggerServerEvent("SyncAvailableAdminRoomsServer")
end)

RegisterNUICallback('NUIFocusOff', function()
    SetNuiFocus(false, false)
	TriggerEvent("HideARM")
end)

AddEventHandler("ShowARM", function(playersstr)
    SendNUIMessage({
      type = "ARM",
      display = true
    })
end)

RegisterNetEvent("StatusUpdate")
AddEventHandler("StatusUpdate", function(newstatus)
    SendNUIMessage({
      type = "ARM",
      display = false,
	  status = newstatus
    })
end)

AddEventHandler("HideARM", function()
    SendNUIMessage({
      type = "ARM",
      hide = true
    })
	menuopen = false
end)

RegisterNetEvent("SyncAvailableAdminRoomsClient")
AddEventHandler("SyncAvailableAdminRoomsClient", function(AdminRoom2AOccupiedd,AdminRoom2BOccupiedd,AdminRoom2COccupiedd,AdminRoom2DOccupiedd,Admincallss)
	AdminRoom2AOccupied = AdminRoom2AOccupiedd
	AdminRoom2BOccupied = AdminRoom2BOccupiedd
	AdminRoom2COccupied = AdminRoom2COccupiedd
	AdminRoom2DOccupied = AdminRoom2DOccupiedd
end)

RegisterNetEvent("SyncAdminCallsClient")
AddEventHandler("SyncAdminCallsClient", function(UnhandledAdminCalll)
	UnhandledAdminCall = UnhandledAdminCalll
end)

function DrawText3D(x,y,z, text, scl) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	vec = GetGameplayCamCoords()
    local px,py,pz= vec.x,vec.y,vec.z
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*scl
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 1.1*scale)
        SetTextFont(10)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

--Code
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local model = GetEntityModel(GetPlayerPed(PlayerId())) .. ""
		if adminskins[model] then
			if not admincalleduiopen then
				SendNUIMessage({
					type = "ARM",
					admin = true
				})
				admincalleduiopen = true
			end
		elseif admincalleduiopen then
			SendNUIMessage({
				type = "ARM",
				admin = false
			})
			admincalleduiopen = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		
		--FrontGateMessage
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, FrontGateMessageCoords.x, FrontGateMessageCoords.y, FrontGateMessageCoords.z) < FrontGateMessageVisibleRange)then
			if(pos.x < FrontGateMessageCoords.x)then
			else
				DrawText3D(FrontGateMessageCoords.x,FrontGateMessageCoords.y,FrontGateMessageCoords.z+0.30, FrontGateMessage1, 3.0)
				DrawText3D(FrontGateMessageCoords.x,FrontGateMessageCoords.y,FrontGateMessageCoords.z, FrontGateMessage2, 3.0)
			end
		end
		
		--FrontGateExitMessage
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, FrontGateExitMessageCoords.x, FrontGateExitMessageCoords.y, FrontGateExitMessageCoords.z) < FrontGateExitMessageVisibleRange)then
			if(pos.x < FrontGateExitMessageCoords.x)then
				DrawText3D(FrontGateExitMessageCoords.x,FrontGateExitMessageCoords.y,FrontGateExitMessageCoords.z+0.30, FrontGateExitMessage, 3.0)
			end
		end
		
		--FrontGateMessageGoLeftForAdminSupport
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, FrontGateMessageGoLeftForAdminSupportCoords.x, FrontGateMessageGoLeftForAdminSupportCoords.y, FrontGateMessageGoLeftForAdminSupportCoords.z) < FrontGateMessageGoLeftForAdminSupportCoordsVisibleRange) then
			if(pos.x < FrontGateMessageGoLeftForAdminSupportCoords.x + 5)then
			else
				DrawText3D(FrontGateMessageGoLeftForAdminSupportCoords.x,FrontGateMessageGoLeftForAdminSupportCoords.y,FrontGateMessageGoLeftForAdminSupportCoords.z+0.30, FrontGateMessageGoLeftForAdminSupport1, 3.0)
				DrawText3D(FrontGateMessageGoLeftForAdminSupportCoords.x,FrontGateMessageGoLeftForAdminSupportCoords.y,FrontGateMessageGoLeftForAdminSupportCoords.z, FrontGateMessageGoLeftForAdminSupport2, 3.0)
			end
		end
		
		--FrontGateMessageGoInsideForAdminSupport
		if(GetDistanceBetweenCoords(pos.x, pos.y, pos.z, FrontGateMessageGoInsideForAdminSupportCoords.x, FrontGateMessageGoInsideForAdminSupportCoords.y, FrontGateMessageGoInsideForAdminSupportCoords.z) < FrontGateMessageGoInsideForAdminSupportCoordsVisibleRange) then
			if(pos.y > FrontGateMessageGoInsideForAdminSupportCoords.y)then
				DrawText3D(FrontGateMessageGoInsideForAdminSupportCoords.x,FrontGateMessageGoInsideForAdminSupportCoords.y,FrontGateMessageGoInsideForAdminSupportCoords.z+0.30, FrontGateMessageGoInsideForAdminSupport1, 3.0)
				DrawText3D(FrontGateMessageGoInsideForAdminSupportCoords.x,FrontGateMessageGoInsideForAdminSupportCoords.y,FrontGateMessageGoInsideForAdminSupportCoords.z, FrontGateMessageGoInsideForAdminSupport2, 3.0)
			end
		end
		
		--AdminBuildingEntrance
		if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, AdminBuildingEntranceCoords.x, AdminBuildingEntranceCoords.y, AdminBuildingEntranceCoords.z) < 1 then
			ESX.ShowHelpNotification("Click ~INPUT_PICKUP~ to enter the admin building")
			if IsControlJustReleased(0, Keys['E']) then
				DoScreenFadeOut(3000)
				Citizen.Wait(4000)
				SetEntityCoords(PlayerPedId(), AdminBuildingInsideCoords)
				SetEntityHeading(PlayerPedId(), AdminBuildingInsideHeading)
				DoScreenFadeIn(5000)
			end
		end
		DrawMarker(1, AdminBuildingEntranceCoords.x, AdminBuildingEntranceCoords.y, AdminBuildingEntranceCoords.z-1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 168, 104, 40, 255, 0, 0, 0, 0)
		
		--AdminBuildingExit
		if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, AdminBuildingInsideCoords.x-0.45, AdminBuildingInsideCoords.y-0.03, AdminBuildingInsideCoords.z) < 1.6 then
			ESX.ShowHelpNotification("Click ~INPUT_PICKUP~ to catch elevator to exit.")
			if IsControlJustReleased(0, Keys['E']) then
				DoScreenFadeOut(3000)
				Citizen.Wait(4000)
				SetEntityCoords(PlayerPedId(), AdminBuildingEntranceCoords)
				SetEntityHeading(PlayerPedId(), AdminBuildingEntranceHeading)
				DoScreenFadeIn(5000)
			end
		end
		DrawMarker(1, AdminBuildingInsideCoords.x-0.45, AdminBuildingInsideCoords.y-0.03, AdminBuildingInsideCoords.z-1, 0, 0, 0, 0, 0, 0, 3.0000, 3.0000, 0.5001, 0, 255, 0, 255, 0, 0, 0, 0)
		
		--AdminBuildingReceptionDesk
		if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, AdminBuildingReceptionDeskCoords.x, AdminBuildingReceptionDeskCoords.y, AdminBuildingReceptionDeskCoords.z) < 1 and not menuopen then
			ESX.ShowHelpNotification("Click ~INPUT_PICKUP~ to open the admin request menu!")
			if IsControlJustReleased(1, Keys['E']) then
				if menuopen or admincalled or (designatedroom ~= "") then
				TriggerEvent('chat:addMessage', {
					color = { 255, 0, 0},
					multiline = true,
					args = {"System", "You have already called for an admin, please back to room ".. designatedroom .."!"}})
					
					if designatedroom == "2A" then
						SetNewWaypoint(AdminRoom2ACoords.x, AdminRoom2ACoords.y);
					elseif designatedroom == "2B" then
						SetNewWaypoint(AdminRoom2BCoords.x, AdminRoom2BCoords.y);
					elseif designatedroom == "2C" then
						SetNewWaypoint(AdminRoom2CCoords.x, AdminRoom2CCoords.y);
					elseif designatedroom == "2D" then
						SetNewWaypoint(AdminRoom2DCoords.x, AdminRoom2DCoords.y);
					end
				else
					menuopen = true
					TriggerEvent("ShowARM")
					SetNuiFocus(true, true)
				end
			end
		end
		DrawMarker(1, AdminBuildingReceptionDeskCoords.x, AdminBuildingReceptionDeskCoords.y, AdminBuildingReceptionDeskCoords.z-1, 0, 0, 0, 0, 0, 0, 1.5001, 1.5001, 0.5001, 255, 0, 0, 255, 0, 0, 0, 0)
	end
end)
