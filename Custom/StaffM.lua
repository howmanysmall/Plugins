 --[[
      ____                      _       _           _       
     / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
     \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
      ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
     |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
            |___/                                                                                         
                   
    @Description: SyncAdmin plugin command to send a message to all staff role users in game.
    @Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
    
    lukezammit | luka ~<3 (28491111)
--]]

local Command = { }
Command.PermissionLevel = 1
Command.Shorthand = "staffm"
Command.Params = { "..." }
Command.Usage = "staffm Your text here"
Command.Description = "Displays the given message to staff members."

local GroupID = 1 -- The Group ID goes here.
local RoleID = 1 -- Here's the Role ID (or the rank number if you want to call it that).

function Command.Init(Main)
	
end

function Command.Run(Main, User, ...)
	local Message = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}, " "), User)
	local List = { }
	for _, Player in pairs(game:GetService("Players"):GetPlayers()) do
		if Player:GetRankInGroup(GroupID) >= RoleID then
			SyncAPI.DisplayMessage(Player, "STAFF MESSAGE", Message)
			table.insert(List, Player.Name)
		end
	end
	return true, "Shown staff message to users: " .. table.concat(List, ", ")
end

return Command
