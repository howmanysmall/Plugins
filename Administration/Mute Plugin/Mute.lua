--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to mute users using the Roblox Chat CoreGui.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
	@Editor: Railworks2
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"Player"}
command.Usage = "mute Player"
command.Description = [[Disables that players' CoreGui chat]] 

command.Init = function(main)
end

command.Run = function(main, user, target)
	if (SyncAPI.GetPermissionLevel(user) > SyncAPI.GetPermissionLevel(target))
	then
		if (target and target:FindFirstChild("PlayerGui")) then
			local sscript = script.SA_MuteHandler:clone()
			sscript.Disabled = false
			sscript.Parent = target.PlayerGui
			return true, "Muted " .. target.Name
		end
		return false, "Cannot mute " .. target.Name .. "; nowhere to run a LocalScript."
	end
	return false, "You cannot run this command on someone with a higher permission level than you."
end

return command