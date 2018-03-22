--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to remove fire from the selected user.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = nil
command.Usage = "dunfire"
command.Description = "[Donator]: Extinguishes the fire from your torso"
command.AllowDonators = true

command.Init = function(main)
end

command.Run = function(main, user)
	if (user.Character and user.Character:findFirstChild("HumanoidRootPart")) then
		for _,fire in pairs(user.Character.HumanoidRootPart:children()) do
			if (fire:IsA("Fire")) then fire:Destroy() end
		end
	end
	return true,"Extinguished your body."
end

return command
