--=================================================
--= github.com/davuongthanh   
--=	youtube.com/channel/UC4f6N3gtOGqn2znOo7lxzQA
--= facebook.com/hida1995/
--=================================================
ESX              = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('od_profile:getthongtin', function (source, cb)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local identifier = GetPlayerIdentifiers(source)[1]
	
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier ', {
		['identifier'] = xPlayer.identifier
	}, function(result)
		local thongtin = {}
		if (result[1] ~= nil) then
			for i=1, #result, 1 do
				table.insert(thongtin, {
					steamid			= tonumber(identifier:gsub("steam:",""), 16),
					playerid		= _source,
					name       		= result[i].lastname .. ' ' .. result[i].firstname,
					sex      		= result[i].sex,
					height			= result[i].height,
					dateofbirth 	= result[i].dateofbirth,
					job				= xPlayer.job.label .. " - " .. xPlayer.job.grade_label,
					phone_number	= result[i].phone_number,
					money 			= xPlayer.getMoney(),
					bank 			= xPlayer.getAccount('bank').money,
					black_money		= xPlayer.getAccount('black_money').money,
					--[[
					solanditu		= result[i].solanditu,
					solandilaodong	= result[i].solandilaodong,
					]]
				})
			end
			cb(thongtin)
		end
	end)
end)


function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

AddEventHandler('esx:playerLoaded', function(source) 
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM `od_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		if ( skillInfo and skillInfo[1] ) then
			TriggerClientEvent('od_skills:sendPlayerSkills', _source, skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].fishing, skillInfo[1].drugs)
			else
				MySQL.Async.execute('INSERT INTO `essentialmode`.`od_skills` (`identifier`, `strength`, `stamina`, `driving`, `shooting`, `fishing`, `drugs`) VALUES (@identifier, @strength, @stamina, @driving, @shooting, @fishing, @drugs);',
				{
				['@identifier'] = xPlayer.identifier,
				['@strength'] = 0,
				['@stamina'] = 0,
				['@driving'] = 0,
				['@shooting'] = 0,
				['@fishing'] = 0,
				['@drugs'] = 0
				}, function ()
				end)
		end
	end)
end)

function updatePlayerInfo(source)
  local _source = source
  local xPlayer  = ESX.GetPlayerFromId(_source)
	MySQL.Async.fetchAll('SELECT * FROM `od_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		if ( skillInfo and skillInfo[1] ) then
			TriggerClientEvent('od_skills:sendPlayerSkills', _source, skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].fishing, skillInfo[1].drugs)
		end
	end)
end

RegisterServerEvent("od_skills:addStamina")
AddEventHandler("od_skills:addStamina", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { 
		type = 'inform', 
		text = "+ " .. round(amount, 2) .. "% điểm kỹ năng thể lực", 
		length = 2500, 
		style = { ['background-color'] = '#008000', ['color'] = '#FFFFFF' } 
	})
	MySQL.Async.fetchAll('SELECT * FROM `od_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `od_skills` SET `stamina` = @stamina WHERE `identifier` = @identifier',
			{
			['@stamina'] = (skillInfo[1].stamina + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("od_skills:addStrength")
AddEventHandler("od_skills:addStrength", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { 
		type = 'inform', 
		text = "+ " .. round(amount, 2) .. "% điểm kỹ năng sức mạnh", 
		length = 2500, 
		style = { ['background-color'] = '#008000', ['color'] = '#FFFFFF' } 
	})
	MySQL.Async.fetchAll('SELECT * FROM `od_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `od_skills` SET `strength` = @strength WHERE `identifier` = @identifier',
			{
			['@strength'] = (skillInfo[1].strength + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("od_skills:addDriving")
AddEventHandler("od_skills:addDriving", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { 
		type = 'inform', 
		text = "+ " .. round(amount, 2) .. "% điểm kỹ năng lái xe", 
		length = 2500, 
		style = { ['background-color'] = '#008000', ['color'] = '#FFFFFF' } 
	})
	MySQL.Async.fetchAll('SELECT * FROM `od_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `od_skills` SET `driving` = @driving WHERE `identifier` = @identifier',
			{
			['@driving'] = (skillInfo[1].driving + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("od_skills:addFishing")
AddEventHandler("od_skills:addFishing", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { 
		type = 'inform', 
		text = "+ " .. round(amount, 2) .. "% điểm kỹ năng câu cá", 
		length = 2500, 
		style = { ['background-color'] = '#008000', ['color'] = '#FFFFFF' } 
	})
	MySQL.Async.fetchAll('SELECT * FROM `od_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `od_skills` SET `fishing` = @fishing WHERE `identifier` = @identifier',
			{
			['@fishing'] = (skillInfo[1].fishing + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

RegisterServerEvent("od_skills:addDrugs")
AddEventHandler("od_skills:addDrugs", function(source, amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { 
		type = 'inform', 
		text = "+ " .. round(amount, 2) .. "% điểm kỹ năng buôn thuốc", 
		length = 2500, 
		style = { ['background-color'] = '#008000', ['color'] = '#FFFFFF' } 
	})
	MySQL.Async.fetchAll('SELECT * FROM `od_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		MySQL.Async.execute('UPDATE `od_skills` SET `drugs` = @drugs WHERE `identifier` = @identifier',
			{
			['@drugs'] = (skillInfo[1].drugs + amount),
			['@identifier'] = xPlayer.identifier
			}, function ()
			updatePlayerInfo(source)
		end)
	end)
end)

ESX.RegisterServerCallback('od_skills:getSkills', function(source, cb)
  local xPlayer    = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM `od_skills` WHERE `identifier` = @identifier', {['@identifier'] = xPlayer.identifier}, function(skillInfo)
		cb(skillInfo[1].stamina, skillInfo[1].strength, skillInfo[1].driving, skillInfo[1].shooting, skillInfo[1].fishing, skillInfo[1].drugs)
	end)
end)