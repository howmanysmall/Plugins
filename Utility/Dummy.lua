local command = {}
command.PermissionLevel = 1
command.Shorthand = {"dum"}
command.Params = {"Optional:Number"}
command.Usage = "Dummy Amount"
command.Description = [[Spawns a dummy character. Dummies will despawn when killed.]] 

command.Init = function(main)
	-- we don't need to add anything here
end

command.Run = function(main,player,amount)
	local position = player.Character.HumanoidRootPart.CFrame-player.Character.HumanoidRootPart.CFrame.lookVector*(math.random()*4);
	amount = amount or 1 -- if no number is specified, spawn only one
	amount = math.max(0,math.min(amount,20)) -- only spawn 20 dummies at one time or else it can get pretty laggy
	
	for count = 1,amount do
		
		--// Dummy model properties
		local body 	= Instance.new("Model")
		body.Name 	= "Dummy"
		local hum 	= Instance.new("Humanoid",body)
		
		--// Dummy torso properties
		local torso = Instance.new("Part",body)
		torso.Name = "Torso"
		torso.TopSurface = 0
		torso.LeftSurface = 2
		torso.RightSurface = 2
		torso.BottomSurface = 2
		torso.Size = Vector3.new(2,2,1)
		torso.BrickColor = BrickColor.new("Deep blue")
		
		--// Dummy head properties
		local head = Instance.new("Part",body)
		head.Name = "Head"
		head.TopSurface = 0
		head.BottomSurface = 2
		head.Size = Vector3.new(1,1,1)
		head.BrickColor = BrickColor.new("Bright yellow")
		head.CFrame = torso.CFrame*CFrame.new(0,torso.Size.Y*0.75,0)
		
		local mesh = Instance.new("SpecialMesh",head)
		mesh.MeshType = 0
		mesh.Scale = Vector3.new(1.25,1.25,1.25)
		
		--// Dummy right arm properties
		local rightArm = Instance.new("Part",body)
		rightArm.TopSurface = 0
		rightArm.BottomSurface = 0
		rightArm.Name = "Right Arm"
		rightArm.Size = Vector3.new(1,2,1);
		rightArm.BrickColor = BrickColor.new("Bright yellow")
		rightArm.CFrame = torso.CFrame*CFrame.new(torso.Size.X*0.75,0,0)
		
		--// Dummy right leg properties
		local rightLeg = rightArm:clone()
		rightLeg.Parent = body
		rightLeg.Name = "Right Leg"
		rightLeg.BrickColor = BrickColor.new("Bright green")
		rightLeg.CFrame = torso.CFrame*CFrame.new(torso.Size.X*0.25,-torso.Size.Y*1,0)
		
		--// Dummy left arm properties
		local leftArm = rightArm:clone()
		leftArm.Parent = body
		leftArm.Name = "Left Arm"
		leftArm.BrickColor = BrickColor.new("Bright yellow")
		leftArm.CFrame = torso.CFrame*CFrame.new(-torso.Size.X*0.75,0,0)
			
		--// Dummy left leg properties
		local leftLeg = rightArm:clone()
		leftLeg.Parent = body
		leftLeg.Name = "Left Leg"
		leftLeg.BrickColor = BrickColor.new("Bright green")
		leftLeg.CFrame = torso.CFrame*CFrame.new(-torso.Size.X*0.25,-torso.Size.Y*1,0)
		
		--// Finalize Dummy model
		body.Parent = workspace
		body:makeJoints()
		body.Torso.CFrame = position
		
		--// Despawn dummies upon death
		hum.Died:connect(function()
			wait(5)
			body:Destroy()
		end)
	end
	
	return true,"Spawned " .. amount .. (amount == 1 and " dummy" or " dummies")
end

return command