--[[  ____                      _       _           _
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/

	@Description: SyncAdmin plugin to ban users from your game
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]

	Credits go to lukezammit
]]--

local command = {};
command.PermissionLevel = 1;
command.Shorthand = "clearf";
command.Params = {};
command.Usage = "clearfriends";
command.Description = [[Clears the friends from folder.]];

command.Init = function(main)
end

command.Run = function(main,user)
	if user then
		if workspace:FindFirstChild("Buddies") then
			workspace.Buddies:ClearAllChildren()
		else
			return false,"Folder not found."
		end
		return true,"Cleared the friends folder.";	
	else
		return false,"User is nil.";	
	end
end

return command;