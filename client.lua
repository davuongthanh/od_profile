--=================================================
--= github.com/davuongthanh   
--=	youtube.com/channel/UC4f6N3gtOGqn2znOo7lxzQA
--= facebook.com/hida1995/
--=================================================
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local display = false
strengthValue = nil
staminaValue = nil
shootingValue = nil
drivingValue = nil
fishingValue = nil
drugsValue = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	
	
end)

function OpenMenu()
	ESX.TriggerServerCallback('od_profile:getthongtin', function(thongtin) 
		
		-- register steam key dev https://steamcommunity.com/dev/apikey
		local steamkey = ''
		local gioitinhod = thongtin[1].sex
		if gioitinhod == "m" then
			gioitinhthat = "Nam"
		else
			gioitinhthat = "Nữ"
		end
		if thongtin[1].steamid then
			steamid = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key=" .. steamkey .. "&steamids=" .. thongtin[1].steamid
		else
			steamid = 'null'
		end
		SendNUIMessage({
			steamid			= steamid,
			playerid       	= thongtin[1].playerid,
			name       		= thongtin[1].name,
			sex      		= gioitinhthat,
			height			= thongtin[1].height,
			dateofbirth 	= thongtin[1].dateofbirth,
			job 			= thongtin[1].job,
			phone_number	= thongtin[1].phone_number,
			money 			= ESX.Math.GroupDigits(thongtin[1].money),
			bank 			= ESX.Math.GroupDigits(thongtin[1].bank),
			black_money 	= ESX.Math.GroupDigits(thongtin[1].black_money),
			--[[
			solanditu		= thongtin[1].solanditu,
			solandilaodong	= thongtin[1].solandilaodong,
			]]
			display = true
		})
		
		if staminaValue == nil or strengthValue == nil or shootingValue == nil or drivingValue == nil or fishingValue == nil or drugsValue == nil then
			ESX.TriggerServerCallback('od_skills:getSkills', function(stamina, strength, driving, shooting, fishing, drugs)
				strengthValue = strength
				staminaValue = stamina
				shootingValue = shooting
				drivingValue = driving
				fishingValue = fishing
				drugsValue = drugs
				SendNUIMessage({
					stamina = staminaValue,
					strength = strengthValue,
					driving = drivingValue,
					shooting = shootingValue,
					fishing = fishingValue, 
					drugs = drugsValue,
					display = true
				})
			end)
		else
			SendNUIMessage({
				stamina = staminaValue,
				strength = strengthValue,
				driving = drivingValue,
				shooting = shootingValue,
				fishing = fishingValue, 
				drugs = drugsValue,
				display = true
			})
		end
		SetNuiFocus(true, true)
	end)
end 

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
end)

--[[
RegisterNetEvent("od_profile:openmenu")
AddEventHandler("od_profile:openmenu", function()
	OpenMenu()
end)
]]

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
		if IsControlJustReleased(0, 167) then -- F6
			OpenMenu()
		end
	end
end)

function round(num, numDecimalPlaces)
	local mult = 10^(2)
	return math.floor(num * mult + 0.5) / mult
end

RegisterNetEvent('od_skills:sendPlayerSkills')
AddEventHandler('od_skills:sendPlayerSkills', function(stamina, strength, driving, shooting, fishing, drugs)
	strengthValue = strength
	staminaValue = stamina
	shootingValue = shooting
	drivingValue = driving
	fishingValue = fishing
	drugsValue = drugs

	StatSetInt("MP0_STRENGTH", round(strength), true)
	StatSetInt("MP0_STAMINA", round(stamina), true)
	StatSetInt('MP0_LUNG_CAPACITY', round(stamina), true)
	StatSetInt('MP0_SHOOTING_ABILITY', round(shooting), true)
	StatSetInt('MP0_WHEELIE_ABILITY', round(driving), true)
	StatSetInt('MP0_DRIVING_ABILITY', round(driving), true)
end)


Faketimer = 0
Citizen.CreateThread(function()
	while true do
        if IsPedInAnyVehicle(GetPlayerPed(-1), true) then
		if Faketimer >= 180 then
		TriggerServerEvent('od_skills:addDriving', GetPlayerServerId(PlayerId()), (math.random() + 0))
		Faketimer = 0
		end
        end
        if Faketimer >= 180 then
          Faketimer = 0
        end
        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function() -- Thread for  timer
	while true do 
		Citizen.Wait(1000)
    Faketimer = Faketimer + 1 
	end 
end)