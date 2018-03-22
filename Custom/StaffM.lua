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

local command = {}
command.PermissionLevel = 1
command.Shorthand = "staffm"
command.Params = {"..."}
command.Usage = "staffm Your text here"
command.Description = [[Displays the given message to staff members.]] 

local groupid = 1; --The group id.
local role = 1; --The RoleId which you want and any rank above to see staff messages.

command.Init = function(main)
end

command.Run = function(main,user,...)
    local message = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
    local list = {}
    for _,player in pairs(game:GetService("Players"):GetPlayers()) do
        if player:GetRankInGroup(groupid) >= role then
            SyncAPI.DisplayMessage(player,"STAFF MESSAGE",message)
            table.insert(list,player.Name)
        end
    end
    return true,"Shown staff message to users: " .. table.concat(list,", ")
end

return command