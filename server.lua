reports = {}
report = {}


discord_webhook = 'WEBHOOK'



function log(source)

	connect = {
		{
		   ["color"] = "15105570",
		   ["title"] = "wfs_reportsystem - Transcript with player "..GetPlayerName(source),
		   ["description"] = {},
		   ["footer"] = {
			  ["text"] = os.date('%H:%M - %d. %m. %Y', os.time())..' IDS '..GetPlayerIdentifier(source, 1)
		   },
		}
	   }

	   
	transcript = reports[source]

	if #transcript == 1 then
		description = transcript[1]
		connect[1].description = description
	elseif #transcript == 2 then
		description = transcript[1]..' \n '..transcript[2]
		connect[1].description = description
	elseif #transcript == 3 then
		description = transcript[1]..' \n '..transcript[2]..' \n '..transcript[3]
		connect[1].description = description
	elseif #transcript == 4 then
		description = transcript[1]..' \n '..transcript[2]..' \n '..transcript[3]..' \n '..transcript[4]
		connect[1].description = description
	elseif #transcript == 5 then
		description = transcript[1]..' \n '..transcript[2]..' \n '..transcript[3]..' \n '..transcript[4]..' \n '..transcript[5]
		connect[1].description = description
	elseif #transcript == 6 then
		description = transcript[1]..' \n '..transcript[2]..' \n '..transcript[3]..' \n '..transcript[4]..' \n '..transcript[5]..' \n '..transcript[6]
		connect[1].description = description
	elseif #transcript == 7 then
		description = transcript[1]..' \n '..transcript[2]..' \n '..transcript[3]..' \n '..transcript[4]..' \n '..transcript[5]..' \n '..transcript[6]..' \n '..transcript[7]
		connect[1].description = description
	elseif #transcript == 8 then
		description = transcript[1]..' \n '..transcript[2]..' \n '..transcript[3]..' \n '..transcript[4]..' \n '..transcript[5]..' \n '..transcript[6]..' \n '..transcript[7]..' \n '..transcript[8]
		connect[1].description = description
	elseif #transcript == 9 then
		description = transcript[1]..' \n '..transcript[2]..' \n '..transcript[3]..' \n '..transcript[4]..' \n '..transcript[5]..' \n '..transcript[6]..' \n '..transcript[7]..' \n '..transcript[8]..' \n '..transcript[9]
		connect[1].description = description
	elseif #transcript == 10 then
		description = transcript[1]..' \n '..transcript[2]..' \n '..transcript[3]..' \n '..transcript[4]..' \n '..transcript[5]..' \n '..transcript[6]..' \n '..transcript[7]..' \n '..transcript[8]..' \n '..transcript[9]..' \n '..transcript[10]
		connect[1].description = description
	else 

		description = json.encode(transcript)..'\n CLEARING TRANSCRIPT REACHED OVER 10 REPLIES'

		connect[1].description = description

		reports[source] = {}

	end
	
	print(json.encode(connect[1].description))
	print(json.encode(connect))





	   PerformHttpRequest(discord_webhook, function(err, text, headers) end, 'POST', json.encode({username = 'Report Logs', embeds = connect}), { ['Content-Type'] = 'application/json' })


end





TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function getIdentity(source)
	return ESX.GetPlayerFromId(source).getGroup()
end


function loadExistingPlayers()
	TriggerEvent("es:getPlayers", function(curPlayers)
		for k,v in pairs(curPlayers)do
			TriggerClientEvent("reply:setGroup", v.get('source'), v.get('group'))
		end
	end)
end

loadExistingPlayers()

AddEventHandler('esx:playerLoaded', function(source, user)
	
	TriggerClientEvent('reply:setGroup', source, ESX.GetPlayerFromId(source).getGroup())
end)

-- (server side script)

-- Registers a command named 'ping'.

RegisterCommand("reply", function(source, args, rawCommand)
    if (source > 0) then
		CancelEvent()
		

			
			local tPID = tonumber(args[1])
			local names2 = GetPlayerName(tPID)
			local names3 = GetPlayerName(source)
			local textmsg = ""
			for i=1, #args do
				if i ~= 1 and i ~=1 then
					textmsg = (textmsg .. " " .. tostring(args[i]))
				end
			end
			print(textmsg)
			local grupos = getIdentity(source)
		    if grupos ~= 'user' then
			    TriggerClientEvent('textmsg', tPID, source, textmsg, names2, names3)
			    TriggerClientEvent('textsent', source, tPID, names2)
				textmsg = 'AdminName: '..GetPlayerName(source)..' Said, '..textmsg
				table.insert(reports[tPID], textmsg)
				-- TriggerEvent('EasyAdmin:requestSpectate',tPID)

				log(tPID)

		    else
			    TriggerClientEvent('chatMessage', source, "SYSTEM", {255, 0, 0}, "Insuficient Premissions!")
			end
			

    else

        print("This command was executed by the server console, RCON client, or a resource.")

    end

end, false)
RegisterCommand("rspectate", function(source, args, rawCommand)
    if (source > 0) then
		CancelEvent()
			
			--print(args[1])
			source2 = source
			source = args[1]
			if args ~= nil then
				
			local grupos = getIdentity(source)
		    if grupos ~= 'user' then
				 TriggerEvent('EasyAdmin:requestSpectate', args[1])
				 textmsg = 'Admin: '..GetPlayerName(source2)..' Spectated '..GetPlayerName(source)

				

				 --table.insert(reports[2], textmsg)


				 --log(args[1])

		    else
			    TriggerClientEvent('chatMessage', source2, "SYSTEM", {255, 0, 0}, "Insuficient Premissions!")
			end
			
			end

    else

        print("This command was executed by the server console, RCON client, or a resource.")

    end

end, false)

src = 0
a = {}
RegisterCommand("report", function(source, args, rawCommand)
    if (source > 0) then
		CancelEvent()
		
		local names1 = GetPlayerName(source)
		local textmsg = ""
		for i=1, #args do
			if i > 0 then
				textmsg = (textmsg .. " " .. tostring(args[i]))
			end
		end
		
		TriggerClientEvent("sendReport", -1, source, names1, textmsg)
		

		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
		  local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if reports[xPlayer.source] == nil then
				reports[xPlayer.source] = {
					exists = 'yes'
			} 

			end
		end


		--print(json.encode(reports))         
		

		textmsg = 'PlayerName: '..GetPlayerName(source)..' Said, '..textmsg
			table.insert(reports[source], textmsg)
			log(source)
    else

        print("This command was executed by the server console, RCON client, or a resource.")

    end

end, false)



function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end



function tablelength(T)
	local count = 0
	for _ in pairs(T) do count = count + 1 end
	return count
end
