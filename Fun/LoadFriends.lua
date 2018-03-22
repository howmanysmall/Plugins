--[[  ____                      _       _           _
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/
	@Description: SyncAdmin plugin to load friends of a user in game.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
	Credits go to lukezammit
]]--
local game = game;
local workspace = workspace;
local lighting = game:GetService('Lighting');
local players = game:GetService('Players');
	
local V3, CF, CA, rad = Vector3.new, CFrame.new, CFrame.Angles, math.rad;
local C3, fromRgb = Color3.new, Color3.fromRGB
	
local runService = game:GetService('RunService');
local heartbeat = runService.Heartbeat;
	
local function create(object, properties)
	local new = Instance.new(object);
	for i,v in pairs (properties or {}) do
		if pcall(function() return new[i] end) then
			new[i] = v;
		end
	end
	return new;
end
	
local InitialCFrames = {
    Torso = {C0 = CF(0, -1, 0), C1 = CF(0, -1, 0)},
    Head = {C0 = CF(0, 1.5, 0), C1 = CF(0,0,0)},
    Right_Arm = {C0 = CF(1.5,.5,0), C1 = CF(0, .5, 0)},
    Right_Leg = {C0 = CF(.5, -1, 0), C1 = CF(0, 1, 0)},
    Left_Arm = {C0 = CF(-1.5, .5, 0), C1 = CF(0, .5, 0)},
    Left_Leg = {C0 = CF(-.5, -1, 0), C1 = CF(0, 1, 0)},	
}

local buds
	
local function generateCharacter(userId, onlineBool, format)
	local appearance = players:GetCharacterAppearanceAsync(userId) or nil;
	if appearance then
		local isOnline;
		if onlineBool then
			isOnline = '[Online]';
		else
			isOnline = '[Offline]';
		end
		local person 	= create('Model', {Name = players:GetNameFromUserIdAsync(userId)..'\n'..isOnline, Parent = nil});
		
		local head 		= create('Part', {Size = V3(2,1,1), CanCollide = false, Anchored = false, Parent = person, Name = 'Head'});
		local torso 	= create('Part', {Size = V3(2, 2, 1), CanCollide = false, Anchored = false, Parent = person, Name = 'Torso'});
		local humRoot 	= create('Part', {Size = V3(2, 2, 1), CanCollide = false, Anchored = false, Parent = person, Name = 'HumanoidRootPart', Transparency = 1, Color = fromRgb(13, 105, 172)});
		local rightArm 	= create('Part', {Size = V3(1, 2, 1), CanCollide = false, Anchored = false, Parent = person, Name = 'Right Arm'});
		local leftArm 	= create('Part', {Size = V3(1, 2, 1), CanCollide = false, Anchored = false, Parent = person, Name = 'Left Arm'});
		local rightLeg 	= create('Part', {Size = V3(1, 2, 1), CanCollide = false, Anchored = false, Parent = person, Name = 'Right Leg'});
		local leftLeg 	= create('Part', {Size = V3(1, 2, 1), CanCollide = false, Anchored = false, Parent = person, Name = 'Left Leg'});
		
		local Torso     = create('Motor6D', {Name = 'Torso',Parent = head,     Part0 = humRoot, Part1 = torso,			C0 = InitialCFrames.Torso.C0,       	C1 = InitialCFrames.Torso.C1});
		local Head      = create('Motor6D', {Name = 'Head',Parent = head,      Part0 = torso, Part1 = head,            	C0 = InitialCFrames.Head.C0,        	C1 = InitialCFrames.Head.C1});
		local Right_Arm = create('Motor6D', {Name = 'Right_Arm',Parent = head, Part0 = torso, Part1 = rightArm,        	C0 = InitialCFrames.Right_Arm.C0,    	C1 = InitialCFrames.Left_Arm.C1});
		local Right_Leg = create('Motor6D', {Name = 'Right_Leg',Parent = head, Part0 = torso, Part1 = rightLeg,        	C0 = InitialCFrames.Right_Leg.C0,    	C1 = InitialCFrames.Right_Leg.C1});
		local Left_Arm  = create('Motor6D', {Name = 'Left_Arm',Parent = head,  Part0 = torso, Part1 = leftArm,         	C0 = InitialCFrames.Left_Arm.C0,     	C1 = InitialCFrames.Left_Arm.C1});
		local Left_Leg  = create('Motor6D', {Name = 'Left_Leg',Parent = head,  Part0 = torso, Part1 = leftLeg,         	C0 = InitialCFrames.Left_Leg.C0,    	C1 = InitialCFrames.Left_Leg.C1});
		
		local hum		= create('Humanoid', {Parent = person});
		local headMesh 	= create('SpecialMesh', {Scale = V3(1.25, 1.25, 1.25), MeshType = 'Head', Parent = head});
		local headDecal = create('Decal', {Texture = 'rbxasset://textures/face.png', Face = 'Front' , Parent = head});
		
		local HairAttachment = create('Attachment', {Name = 'HairAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,0.60000002384186,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = head});
		local HatAttachment = create('Attachment', {Name = 'HatAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,0.60000002384186,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = head});
		local FaceFrontAttachment = create('Attachment', {Name = 'FaceFrontAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,0,-0.60000002384186),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = head});
		local FaceCenterAttachment = create('Attachment', {Name = 'FaceCenterAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,0,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = head});
		local NeckAttachment = create('Attachment', {Name = 'NeckAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,1,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = torso});
		local BodyFrontAttachment = create('Attachment', {Name = 'BodyFrontAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,0,-0.5),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = torso});
		local BodyBackAttachment = create('Attachment', {Name = 'BodyBackAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,0,0.5),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = torso});
		local LeftCollarAttachment = create('Attachment', {Name = 'LeftCollarAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(-1,1,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = torso});
		local RightCollarAttachment = create('Attachment', {Name = 'RightCollarAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(1,1,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = torso});
		local WaistFrontAttachment = create('Attachment', {Name = 'WaistFrontAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,-1,-0.5),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = torso});
		local WaistCenterAttachment = create('Attachment', {Name = 'WaistCenterAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,-1,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = torso});
		local WaistBackAttachment = create('Attachment', {Name = 'WaistBackAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,-1,0.5),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = torso});
		local LeftShoulderAttachment = create('Attachment', {Name = 'LeftShoulderAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,1,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = leftArm});
		local LeftGripAttachment = create('Attachment', {Name = 'LeftGripAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,-1,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = leftArm});
		local RightShoulderAttachment = create('Attachment', {Name = 'RightShoulderAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,1,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = rightArm});
		local RightGripAttachment = create('Attachment', {Name = 'RightGripAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,-1,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = rightArm});
		local LeftFootAttachment = create('Attachment', {Name = 'LeftFootAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,-1,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = leftLeg});
		local RightFootAttachment = create('Attachment', {Name = 'RightFootAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,-1,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = rightLeg});
		local RootAttachment = create('Attachment', {Name = 'RootAttachment',Orientation = V3(0,0,0),Visible = false,Position = V3(0,0,0),Axis = V3(1,0,0),SecondaryAxis = V3(0,1,0),Archivable = true,Parent = humRoot});	
			
		hum.MaxHealth = math.huge;
		hum.Health = math.huge;
		person.PrimaryPart = humRoot;
		person:SetPrimaryPartCFrame(format*CA(0,rad(90),0));	
		
		for i,v in pairs (appearance:GetChildren()) do					
			if v:IsA('Folder') then
				if v.Name == 'R6' then
					table.foreach(v:GetChildren(), function(index, obj) obj.Parent = person end);
				end
			elseif v:IsA('Decal') then
				headDecal.Texture = v.Texture;
			elseif v:IsA('BlockMesh') then			
				headMesh:Destroy();
				v.Parent = head;
			else
				v.Parent = person;
			end
		end
		person.Parent = buds;
	end
end

local command = {};
command.PermissionLevel = 1;
command.Shorthand = 'loadf';
command.Params = {'Player'};
command.Usage = 'loadfriends player';
command.Description = [[Load the friends of a certain player.]];

command.Init = function(main)
	buds = create('Folder', {Name = 'Buddies', Parent = workspace});
end

local running = false;

command.Run = function(main,user,targetUser)
	if running then
		running = false
	end
	
	local player = user;
	local targetId;
	
	if targetUser then
		targetId = targetUser.UserId;
	else
		return false,'The target user could not be found.';
	end
	
	local friends = players:GetFriendsAsync(targetId);
	local playerCf = player.Character:WaitForChild('Head').CFrame;
	local currentFriends = {};
	local total = 0;
	
	pcall(function()
		for i = 1, 4 do
	        for _, item in ipairs(friends:GetCurrentPage()) do
	            table.insert(currentFriends, item);
				total = total + 1;
	        end
	        friends:AdvanceToNextPageAsync();		
		end
	end)
	
	running = true	
	buds:ClearAllChildren();
	coroutine.resume(coroutine.create(function()
	for i,v in pairs (currentFriends) do
		heartbeat:wait();		
			if running then
				generateCharacter(v.Id ,v.IsOnline , CF(playerCf.p) * CA(0,(rad(360/total)*i),0) * CF(total,0,0));
			else
				running = false;
				break;
			end
		end
		running = false;
	end))
	
	return true,'Displayed all the friends of '..targetUser.Name..', total friends :'..total..'.';
end

return command;