--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to give the selected player a pants item from the Roblox catalog.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"pant"}
command.Params = {"PlayerList","Number"}
command.Usage = "pants Player ID"
command.Description = [[Give selected player a shirt.]] 

command.Init = function(main)
end

command.Run = function(main,user,users,id)
	if (user == nil) then error("No user found") end
	local asset = game:GetService("InsertService"):LoadAsset(id):children()[1]
	if (not asset:IsA("Pants")) then
		return false,"That is not a pants item"
	end
	
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		if player.Character then
			for _,a in pairs(player.Character:children()) do
				if (a:IsA("Pants")) then
					a:Destroy()
				end
			end
			asset:clone().Parent = player.Character
		end
	end
	return true,"Given pants to " .. table.concat(list,", "),list,user.Name .. " has given you pants."
end

return command