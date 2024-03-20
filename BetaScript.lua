-- Kirainc Hub Kaitun Script BloxFruits

	if not game:IsLoaded() then
		repeat game.Loaded:wait(0.2) 
			wait(10)
		until game:IsLoaded() 
	end

	game.StarterGui:SetCore("SendNotification", {
		Icon = "";
		Title = "Kirainc Hub", 
		Text = "Loaded Scripted"
	})

	wait(2)

	_G.LockFPS = 120

	spawn(function()
		game:GetService('RunService').Heartbeat:Connect(function()
			if(not(type(_G.LockFPS)=='number'))then
				setfpscap(120)
			else
				setfpscap(_G.LockFPS)
			end
		end)
	end)

	-- Config Scripts

	task.spawn(function()
		while true do wait()
			if setscriptable then
				setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
			end
			if sethiddenproperty then
				sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
			end
		end
	end)

	task.spawn(function()
		while task.wait() do
			pcall(function()
				if StartMagnet then
					for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
						if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
							if InMyNetWork(v.HumanoidRootPart) then
								v.HumanoidRootPart.CFrame = PosMon
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								v.HumanoidRootPart.Size = Vector3.new(60,60,60)
								v.HumanoidRootPart.Transparency = 1
								v.HumanoidRootPart.CanCollide = false
								v.Head.CanCollide = false
								if v.Humanoid:FindFirstChild("Animator") then
									v.Humanoid.Animator:Destroy()
								end
								v.Humanoid:ChangeState(11)
								v.Humanoid:ChangeState(14)
							end
						end
					end
				end
			end)
		end
	end)

	-- [No Stun]

	task.spawn(function()
		if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
			game.Players.LocalPlayer.Character.Stun.Changed:connect(function()
				pcall(function()
					if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
						game.Players.LocalPlayer.Character.Stun.Value = 0
					end
				end)
			end)
		end
	end)

	-- [Deleted Effect Auto]

	task.spawn(function()
		while wait() do
			for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"]:GetChildren()) do
				pcall(function()
					if v.Name == ("CurvedRing") or v.Name == ("SlashHit") or v.Name == ("SwordSlash") or v.Name == ("SlashTail") or v.Name == ("Sounds") then
						v:Destroy()
					end
				end)
			end
		end
	end)

	if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Death") then
		game:GetService("ReplicatedStorage").Effect.Container.Death:Destroy()
	end
	if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Respawn") then
		game:GetService("ReplicatedStorage").Effect.Container.Respawn:Destroy()
	end

	-- Require

	local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
	local CombatFrameworkR = getupvalues(CombatFramework)[2]
	local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
	local RigControllerR = getupvalues(RigController)[2]
	local realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
	local cooldownfastattack = tick()

	-- Disabled Damage
	function DisabledDamage()
		task.spawn(function()
			while wait() do
				pcall(function()
					if _G.Settings.Configs["Disabled Damage"] then
						game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
					else
						game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = true
					end
				end)
			end
		end)
	end

	-- Camera Shaker
	function CameraShaker()
		task.spawn(function()
			local Camera = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.CameraShaker)
			while wait() do
				pcall(function()
					if _G.Settings.Configs["Camera Shaker"] then
						Camera.CameraShakeInstance.CameraShakeState.Inactive = 0
					else
						Camera.CameraShakeInstance.CameraShakeState.Inactive = 3
					end
				end)
			end
		end)
	end

	-- Current

	function CurrentWeapon()
		local ac = CombatFrameworkR.activeController
		local ret = ac.blades[1]
		if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
		pcall(function()
			while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
		end)
		if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
		return ret
	end

	function getAllBladeHitsPlayers(Sizes)
		local Hits = {}
		local Client = game.Players.LocalPlayer
		local Characters = game:GetService("Workspace").Characters:GetChildren()
		for i=1,#Characters do local v = Characters[i]
			local Human = v:FindFirstChildOfClass("Humanoid")
			if v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
				table.insert(Hits,Human.RootPart)
			end
		end
		return Hits
	end

	function getAllBladeHits(Sizes)
		local Hits = {}
		local Client = game.Players.LocalPlayer
		local Enemies = game:GetService("Workspace").Enemies:GetChildren()
		for i=1,#Enemies do local v = Enemies[i]
			local Human = v:FindFirstChildOfClass("Humanoid")
			if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
				table.insert(Hits,Human.RootPart)
			end
		end
		return Hits
	end

	function AttackFunction()
		local ac = CombatFrameworkR.activeController
		if ac and ac.equipped then
			for indexincrement = 1, 1 do
				local bladehit = getAllBladeHits(60)
				if #bladehit > 0 then
					local AcAttack8 = debug.getupvalue(ac.attack, 5)
					local AcAttack9 = debug.getupvalue(ac.attack, 6)
					local AcAttack7 = debug.getupvalue(ac.attack, 4)
					local AcAttack10 = debug.getupvalue(ac.attack, 7)
					local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
					local NumberAc13 = AcAttack7 * 798405
					(function()
						NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
						AcAttack8 = math.floor(NumberAc12 / AcAttack9)
						AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
					end)()
					AcAttack10 = AcAttack10 + 1
					debug.setupvalue(ac.attack, 5, AcAttack8)
					debug.setupvalue(ac.attack, 6, AcAttack9)
					debug.setupvalue(ac.attack, 4, AcAttack7)
					debug.setupvalue(ac.attack, 7, AcAttack10)
					for k, v in pairs(ac.animator.anims.basic) do
						v:Play(0.01,0.01,0.01)
					end                 
					if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
						game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
						game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
						game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "") 
					end
				end
			end
		end
	end

	function AttackPlayers()
		local ac = CombatFrameworkR.activeController
		if ac and ac.equipped then
			for indexincrement = 1, 1 do
				local bladehit = getAllBladeHitsPlayers(60)
				if #bladehit > 0 then
					local AcAttack8 = debug.getupvalue(ac.attack, 5)
					local AcAttack9 = debug.getupvalue(ac.attack, 6)
					local AcAttack7 = debug.getupvalue(ac.attack, 4)
					local AcAttack10 = debug.getupvalue(ac.attack, 7)
					local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
					local NumberAc13 = AcAttack7 * 798405
					(function()
						NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
						AcAttack8 = math.floor(NumberAc12 / AcAttack9)
						AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
					end)()
					AcAttack10 = AcAttack10 + 1
					debug.setupvalue(ac.attack, 5, AcAttack8)
					debug.setupvalue(ac.attack, 6, AcAttack9)
					debug.setupvalue(ac.attack, 4, AcAttack7)
					debug.setupvalue(ac.attack, 7, AcAttack10)
					for k, v in pairs(ac.animator.anims.basic) do
						v:Play(0.01,0.01,0.01)
					end                 
					if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
						game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
						game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
						game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "") 
					end
				end
			end
		end
	end

	-- FuncQuest

	function Com(com,...)
		local Remote = game:GetService('ReplicatedStorage').Remotes:FindFirstChild("Comm"..com)
		if Remote:IsA("RemoteEvent") then
			Remote:FireServer(...)
		elseif Remote:IsA("RemoteFunction") then
			Remote:InvokeServer(...)
		end
	end

	-- TweenFunction

	local function GetIsLand(...)
		local RealtargetPos = {...}
		local targetPos = RealtargetPos[1]
		local RealTarget
		if type(targetPos) == "vector" then
			RealTarget = targetPos
		elseif type(targetPos) == "userdata" then
			RealTarget = targetPos.Position
		elseif type(targetPos) == "number" then
			RealTarget = CFrame.new(unpack(RealtargetPos))
			RealTarget = RealTarget.p
		end

		local ReturnValue
		local CheckInOut = math.huge;
		if game.Players.LocalPlayer.Team then
			for i,v in pairs(game.Workspace._WorldOrigin.PlayerSpawns:FindFirstChild(tostring(game.Players.LocalPlayer.Team)):GetChildren()) do 
				local ReMagnitude = (RealTarget - v:GetModelCFrame().p).Magnitude;
				if ReMagnitude < CheckInOut then
					CheckInOut = ReMagnitude;
					ReturnValue = v.Name
				end
			end
			if ReturnValue then
				return ReturnValue
			end 
		end
	end

	--BTP

	function BTP(Position)
		game.Players.LocalPlayer.Character.Head:Destroy()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
		wait(1)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
	end

	-- TweenTotargets

	local function toTarget(...)
		local RealtargetPos = {...}
		local targetPos = RealtargetPos[1]
		local RealTarget
		if type(targetPos) == "vector" then
			RealTarget = CFrame.new(targetPos)
		elseif type(targetPos) == "userdata" then
			RealTarget = targetPos
		elseif type(targetPos) == "number" then
			RealTarget = CFrame.new(unpack(RealtargetPos))
		end

		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then if tween then tween:Cancel() end repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0; wait(0.2) end

		local tweenfunc = {}
		local Distance = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
		if Distance < 1000 then
			Speed = 315
		elseif Distance >= 1000 then
			Speed = 300
		end

		if _G.Settings.Configs["Bypass TP"] then
			if Distance > 3000 and not AutoFarmMaterial and not _G.Settings.FightingStyle["Auto God Human"] and not _G.Settings.Raids["Auto Raids"] and not (game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game.Players.LocalPlayer.Character:FindFirstChild("Hallow Essence") or game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice")) and not (Name == "Fishman Commando [Lv. 400]" or Name == "Fishman Warrior [Lv. 375]") then
				pcall(function()
					tween:Cancel()
					fkwarp = false

					if game:GetService("Players")["LocalPlayer"].Data:FindFirstChild("SpawnPoint").Value == tostring(GetIsLand(RealTarget)) then 
						wait(.1)
						Com("F_","TeleportToSpawn")
					elseif game:GetService("Players")["LocalPlayer"].Data:FindFirstChild("LastSpawnPoint").Value == tostring(GetIsLand(RealTarget)) then
						game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
						wait(0.1)
						repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
					else
						if game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 then
							if fkwarp == false then
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = RealTarget
							end
							fkwarp = true
						end
						wait(.08)
						game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
						repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
						wait(.1)
						Com("F_","SetSpawnPoint")
					end
					wait(0.2)

					return
				end)
			end
		end

		local tween_s = game:service"TweenService"
		local info = TweenInfo.new((RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed, Enum.EasingStyle.Linear)
		local tweenw, err = pcall(function()
			tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = RealTarget})
			tween:Play()
		end)

		function tweenfunc:Stop()
			tween:Cancel()
		end 

		function tweenfunc:Wait()
			tween.Completed:Wait()
		end 

		return tweenfunc
	end

	function toTargetP(CFgo)
		if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health <= 0 or not game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") then tween:Cancel() repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 wait(7) return end
		if (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude <= 150 then
			pcall(function()
				tween:Cancel()

				game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.CFrame = CFgo

				return
			end)
		end
		local tween_s = game:service"TweenService"
		local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude/325, Enum.EasingStyle.Linear)
		tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = CFgo})
		tween:Play()

		local tweenfunc = {}

		function tweenfunc:Stop()
			tween:Cancel()
		end

		return tweenfunc
	end

	-- CheckFruit1Million

	_G.CheckFruitLocal1M = false
	function CheckFruit1M()
		for i,v in pairs(game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("getInventoryFruits")) do
			if v.Price >= 1000000 then 
				_G.CheckFruitLocal1M = true
			end
		end
	end

	-- Fighting

	function GetFightingStyle(Style)
		ReturnText = ""
		for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v:IsA("Tool") then
				if v.ToolTip == Style then
					ReturnText = v.Name
				end
			end
		end
		for i ,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
			if v:IsA("Tool") then
				if v.ToolTip == Style then
					ReturnText = v.Name
				end
			end
		end
		if ReturnText ~= "" then
			return ReturnText
		else
			return "Not Have"
		end
	end

-- Kirainc Hub UI Library 
if game.PlaceId == 2753915549 or game.PlaceId == 4442272183 or game.PlaceId == 7449423635 then
	do  local ui =  game:GetService("CoreGui"):FindFirstChild("redui")  if ui then ui:Destroy() end end

	local UserInputService = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local LocalPlayer = game:GetService("Players").LocalPlayer
	local Mouse = LocalPlayer:GetMouse()
	local tween = game:GetService("TweenService")
	local Red = {RainbowColorValue = 0, HueSelectionPosition = 0}
	local PresetColor = Color3.fromRGB(66, 134, 255)


	coroutine.wrap(
		function()
			while wait() do
				Red.RainbowColorValue = Red.RainbowColorValue + 1 / 255
				Red.HueSelectionPosition = Red.HueSelectionPosition + 1

				if Red.RainbowColorValue >= 1 then
					Red.RainbowColorValue = 0
				end

				if Red.HueSelectionPosition == 160 then
					Red.HueSelectionPosition = 0
				end
			end
		end
	)()

	local Reduisceen = Instance.new("ScreenGui")
	Reduisceen.Parent = game:GetService("CoreGui")
	Reduisceen.Name = "redui"
	Reduisceen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling




	local function MakeDraggable(topbarobject, object)
		local Dragging = nil
		local DragInput = nil
		local DragStart = nil
		local StartPosition = nil

		local function Update(input)
			local Delta = input.Position - DragStart
			local pos =
				UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
			local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
			Tween:Play()
		end

		topbarobject.InputBegan:Connect(
			function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
					DragStart = input.Position
					StartPosition = object.Position

					input.Changed:Connect(
						function()
							if input.UserInputState == Enum.UserInputState.End then
								Dragging = false
							end
						end
					)
				end
			end
		)

		topbarobject.InputChanged:Connect(
			function(input)
				if
					input.UserInputType == Enum.UserInputType.MouseMovement or
						input.UserInputType == Enum.UserInputType.Touch
				then
					DragInput = input
				end
			end
		)

		UserInputService.InputChanged:Connect(
			function(input)
				if input == DragInput and Dragging then
					Update(input)
				end
			end
		)
	end

	local function Tween(instance, properties,style,wa)
		if style == nil or "" then
			return Back
		end
		tween:Create(instance,TweenInfo.new(wa,Enum.EasingStyle[style]),{properties}):Play()
	end

	local create = {}
	function create:Win(text)
		local fs = false

		local MainSceen = Instance.new("Frame")
		MainSceen.Name = "MainSceen"
		MainSceen.Parent = Reduisceen
		MainSceen.AnchorPoint = Vector2.new(0.5, 0.5)
		MainSceen.BackgroundColor3 = Color3.fromRGB(15,15,15)
		MainSceen.BorderSizePixel = 0
		MainSceen.Position = UDim2.new(0.5, 0, 0.5, 0)
		MainSceen.Size = UDim2.new(0, 0, 0, 0)
		MainSceen.ClipsDescendants = true

		local Main_UiConner  = Instance.new("UICorner")

		Main_UiConner.CornerRadius = UDim.new(0, 4)
		Main_UiConner.Name = "Main_UiConner"
		Main_UiConner.Parent = MainSceen

		local ClickFrame = Instance.new("Frame")
		ClickFrame.Name = "ClickFrame"
		ClickFrame.Parent = MainSceen
		ClickFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		ClickFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ClickFrame.BorderSizePixel = 0
		ClickFrame.Position = UDim2.new(0.5, 0, 0.036, 0)
		ClickFrame.Size = UDim2.new(0, 534-20, 0, 30)
		ClickFrame.ClipsDescendants = true
		ClickFrame.BackgroundTransparency = 1

		MakeDraggable(ClickFrame,MainSceen)
		tween:Create(MainSceen,TweenInfo.new(0.4,Enum.EasingStyle.Back),{Size = UDim2.new(0, 550, 0, 474)}):Play()

		local library = {toggledui = false;}
		game:GetService("UserInputService").InputBegan:Connect(function(input)
			pcall(function()
				if input.KeyCode == Enum.KeyCode.RightControl then
					if library.toggledui == false then
						library.toggledui = true
						tween:Create(MainSceen,TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.In),{Size = UDim2.new(0, 0, 0, 0)}):Play()
						wait(.3)
						Reduisceen.Enabled = false
					else
						library.toggledui = false
						tween:Create(MainSceen,TweenInfo.new(0.4,Enum.EasingStyle.Back),{Size = UDim2.new(0, 534, 0, 474)}):Play()
						Reduisceen.Enabled = true
					end
				end
			end)
		end)

		local NameReal = Instance.new("TextLabel")

		NameReal.Parent = MainSceen
		NameReal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NameReal.BackgroundTransparency = 1
		NameReal.BorderSizePixel = 0
		NameReal.Position = UDim2.new(0.5, 0, 0.05, 0)
		NameReal.AnchorPoint = Vector2.new(0.5, 0.5)
		NameReal.Size = UDim2.new(0, 136, 0, 34)
		NameReal.Font = Enum.Font.GothamBold
		NameReal.Text = tostring(text)
		NameReal.TextColor3 = Color3.fromRGB(249, 53, 139)
		NameReal.TextSize = 14.000


		local MainSceen2 = Instance.new("Frame")
		MainSceen2.Name = "MainSceen2"
		MainSceen2.Parent = MainSceen
		MainSceen2.AnchorPoint = Vector2.new(0.5, 0.5)
		MainSceen2.BackgroundColor3 = Color3.fromRGB(18,18,18)
		MainSceen2.BorderSizePixel = 0
		MainSceen2.Position = UDim2.new(0.5, 0, 0.5, 0)
		MainSceen2.Size = UDim2.new(0, 0, 0, 0)
		MainSceen2.ClipsDescendants = true

		local Main_UiConner2  = Instance.new("UICorner")

		Main_UiConner2.CornerRadius = UDim.new(0, 4)
		Main_UiConner2.Name = "Main_UiConner"
		Main_UiConner2.Parent = MainSceen

		MainSceen2:TweenSizeAndPosition(UDim2.new(0, 550-20, 0, 474-50), UDim2.new(0.5, 0, 0.53, 0), "Out", "Back", 0.5, true)


		local ScolTapBarFrame = Instance.new("Frame")
		ScolTapBarFrame.Name = "MainSceen2"
		ScolTapBarFrame.Parent = MainSceen2
		ScolTapBarFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		ScolTapBarFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
		ScolTapBarFrame.BorderSizePixel = 0
		ScolTapBarFrame.BackgroundTransparency = 1
		ScolTapBarFrame.Position = UDim2.new(0.5, 0, 0.07, 0)
		ScolTapBarFrame.Size = UDim2.new(0, 500, 0, 35)
		ScolTapBarFrame.ClipsDescendants = true

		local ScrollingFrame_Menubar = Instance.new("ScrollingFrame")

		ScrollingFrame_Menubar.Parent = ScolTapBarFrame
		ScrollingFrame_Menubar.Active = true
		ScrollingFrame_Menubar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ScrollingFrame_Menubar.BackgroundTransparency = 1
		ScrollingFrame_Menubar.BorderSizePixel = 0
		ScrollingFrame_Menubar.Size = UDim2.new(0, 500, 0, 35)
		ScrollingFrame_Menubar.CanvasSize = UDim2.new(2, 0, 0, 0)
		ScrollingFrame_Menubar.ScrollBarImageColor3 = Color3.fromRGB(249, 53, 139)
		ScrollingFrame_Menubar.ScrollBarThickness = 3


		local UIListLayout_Menubar = Instance.new("UIListLayout")

		UIListLayout_Menubar.Parent = ScrollingFrame_Menubar
		UIListLayout_Menubar.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout_Menubar.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_Menubar.Padding = UDim.new(0, 10)

		local UIPadding_Menubar = Instance.new("UIPadding")

		UIPadding_Menubar.Parent = ScrollingFrame_Menubar
		UIPadding_Menubar.PaddingTop = UDim.new(0, 2)


		local PageOrders = -1

		local Container_Page = Instance.new('Frame',MainSceen2)
		Container_Page.Size = UDim2.new(0, 518, 0, 268)
		Container_Page.Position = UDim2.new(0.5, 0, 0.45, 0)
		Container_Page.BackgroundTransparency = 1
		Container_Page.Name = "Page "
		Container_Page.AnchorPoint = Vector2.new(0.5, 0.5)

		local pagesFolder = Instance.new("Folder")

		pagesFolder.Name = "pagesFolder"
		pagesFolder.Parent = Container_Page


		local UIPage = Instance.new('UIPageLayout',pagesFolder)
		UIPage.SortOrder = Enum.SortOrder.LayoutOrder
		UIPage.EasingDirection = Enum.EasingDirection.InOut
		UIPage.EasingStyle = Enum.EasingStyle.Quad
		UIPage.Padding = UDim.new(0, 10)
		UIPage.TweenTime = 0.500

		local top = {}

		local NotiFrame = Instance.new("Frame")
		NotiFrame.Name = "NotiFrame"
		NotiFrame.Parent = Reduisceen
		NotiFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		NotiFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
		NotiFrame.BorderSizePixel = 0
		NotiFrame.Position =  UDim2.new(1, -210, 1, -500)
		NotiFrame.Size = UDim2.new(0, 400, 0, 500)
		NotiFrame.ClipsDescendants = true
		NotiFrame.BackgroundTransparency = 1


		local Notilistlayout = Instance.new("UIListLayout")
		Notilistlayout.Parent = NotiFrame
		Notilistlayout.SortOrder = Enum.SortOrder.LayoutOrder
		Notilistlayout.Padding = UDim.new(0, 5)


		function create:Notifile(titel,text,delays)
			local TitleFrame = Instance.new("Frame")
			TitleFrame.Name = "TitleFrame"
			TitleFrame.Parent = NotiFrame
			TitleFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			TitleFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
			TitleFrame.BorderSizePixel = 0
			TitleFrame.Position =  UDim2.new(0.5, 0, 0.5,0)
			TitleFrame.Size = UDim2.new(0, 0, 0, 0)
			TitleFrame.ClipsDescendants = true
			TitleFrame.BackgroundTransparency = 0

			local ConnerTitile = Instance.new("UICorner")

			ConnerTitile.CornerRadius = UDim.new(0, 4)
			ConnerTitile.Name = ""
			ConnerTitile.Parent = TitleFrame

			TitleFrame:TweenSizeAndPosition(UDim2.new(0, 400-10, 0, 70),  UDim2.new(0.5, 0, 0.5,0), "Out", "Quad", 0.3, true)

			local imagenoti = Instance.new("ImageLabel")

			imagenoti.Parent = TitleFrame
			imagenoti.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			imagenoti.BackgroundTransparency = 1.000
			imagenoti.AnchorPoint = Vector2.new(0.5, 0.5)
			imagenoti.Position = UDim2.new(0.9, 0, 0.5, 0)
			imagenoti.Size = UDim2.new(0, 50, 0, 50)
		--  imagenoti.Image = "https://www.roblox.com/asset-thumbnail/image?assetId=7578496318&width=0&height=0&format=png"

			local txdlid = Instance.new("TextLabel")

			txdlid.Parent = TitleFrame
			txdlid.Name = "TextLabel_Tap"
			txdlid.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
			txdlid.Size =UDim2.new(0, 160, 0,25 )
			txdlid.Font = Enum.Font.GothamBold
			txdlid.Text = titel
			txdlid.TextColor3 = Color3.fromRGB(249, 53, 139)
			txdlid.TextSize = 13.000
			txdlid.AnchorPoint = Vector2.new(0.5, 0.5)
			txdlid.Position = UDim2.new(0.23, 0, 0.3, 0)
			-- txdlid.TextYAlignment = Enum.TextYAlignment.Top
			txdlid.TextXAlignment = Enum.TextXAlignment.Left
			txdlid.BackgroundTransparency = 1

			local LableFrame = Instance.new("Frame")
			LableFrame.Name = "LableFrame"
			LableFrame.Parent = TitleFrame
			LableFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			LableFrame.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
			LableFrame.BorderSizePixel = 0
			LableFrame.Position =  UDim2.new(0.36, 0, 0.67,0)
			LableFrame.Size = UDim2.new(0, 260, 0,25 )
			LableFrame.ClipsDescendants = true
			LableFrame.BackgroundTransparency = 1

			local TextNoti = Instance.new("TextLabel")

			TextNoti.Parent = LableFrame
			TextNoti.Name = "TextLabel_Tap"
			TextNoti.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
			TextNoti.Size =UDim2.new(0, 260, 0,25 )
			TextNoti.Font = Enum.Font.GothamBold
			TextNoti.Text = text
			TextNoti.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextNoti.TextSize = 13.000
			TextNoti.AnchorPoint = Vector2.new(0.5, 0.5)
			TextNoti.Position = UDim2.new(0.5, 0, 0.5, 0)
			-- TextNoti.TextYAlignment = Enum.TextYAlignment.Top
			TextNoti.TextXAlignment = Enum.TextXAlignment.Left
			TextNoti.BackgroundTransparency = 1

			repeat wait() until TitleFrame.Size == UDim2.new(0, 400-10, 0, 70)

			local Time = Instance.new("Frame")
			Time.Name = "Time"
			Time.Parent = TitleFrame
	--Time.AnchorPoint = Vector2.new(0.5, 0.5)
			Time.BackgroundColor3 =  Color3.fromRGB(249, 53, 139)
			Time.BorderSizePixel = 0
			Time.Position =  UDim2.new(0, 0, 0.,0)
			Time.Size = UDim2.new(0, 0,0,0)
			Time.ClipsDescendants = false
			Time.BackgroundTransparency = 0

			local ConnerTitile_Time = Instance.new("UICorner")

			ConnerTitile_Time.CornerRadius = UDim.new(0, 4)
			ConnerTitile_Time.Name = ""
			ConnerTitile_Time.Parent = Time


			Time:TweenSizeAndPosition(UDim2.new(0, 400-10, 0, 3),  UDim2.new(0., 0, 0.,0), "Out", "Quad", 0.3, true)
			repeat wait() until Time.Size == UDim2.new(0, 400-10, 0, 3)

			TweenService:Create(
				Time,
				TweenInfo.new(tonumber(delays), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
				{Size = UDim2.new(0, 0, 0, 3)} -- UDim2.new(0, 128, 0, 25)
			):Play()
			delay(tonumber(delays),function()
				TweenService:Create(
					TitleFrame,
					TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
					{Size = UDim2.new(0, 0, 0, 0)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				wait(0.3)
				TitleFrame:Destroy()
			end
		)
		end


		function top:Taps(text)
			PageOrders = PageOrders + 1
			local name = tostring(text) or tostring(math.random(1,5000))

			local Frame_Tap = Instance.new("Frame")
			Frame_Tap.Parent = ScrollingFrame_Menubar
			Frame_Tap.Name = text.."Server"
			Frame_Tap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Frame_Tap.BackgroundTransparency = 1
			Frame_Tap.Position = UDim2.new(0.0, 0, 0.0, 0)
			Frame_Tap.Size = UDim2.new(0, 100, 0, 25)
			Frame_Tap.Visible = true

			local TextLabel_Tap = Instance.new("TextLabel")

			TextLabel_Tap.Parent = Frame_Tap
			TextLabel_Tap.Name = "TextLabel_Tap"
			TextLabel_Tap.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
			TextLabel_Tap.Position = UDim2.new(0.5, 0, 0.8, 0)
			TextLabel_Tap.Size = UDim2.new(0, 0, 0, 0)
			TextLabel_Tap.Font = Enum.Font.SourceSans
			TextLabel_Tap.Text = " "
			TextLabel_Tap.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextLabel_Tap.TextSize = 14.000
			TextLabel_Tap.AnchorPoint = Vector2.new(0.5, 0.5)

			local TextButton_Tap = Instance.new("TextButton")

			TextButton_Tap.Parent = Frame_Tap
			TextButton_Tap.Name = "TextButton_Tap"
			TextButton_Tap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextButton_Tap.BackgroundTransparency = 1.000
			TextButton_Tap.Position = UDim2.new(0.114491031, 0, -0.0216345787, 0)
			TextButton_Tap.Size = UDim2.new(0, 80, 0, 20)
			TextButton_Tap.Font = Enum.Font.GothamSemibold
			TextButton_Tap.TextColor3 = Color3.fromRGB(155, 155, 155)
			TextButton_Tap.TextSize = 13.000
			TextButton_Tap.Text = tostring(text)

			local MainPage = Instance.new("Frame")

			MainPage.Name = name.."_MainPage"
			MainPage.Parent = pagesFolder
			MainPage.BackgroundColor3 = Color3.fromRGB(255,255, 255)
			MainPage.BorderSizePixel = 0
			MainPage.Position = UDim2.new(0.5, 0, 0.5, 0) -- UDim2.new(0.0149812736, 0, 0.13, 0)
			MainPage.Size = UDim2.new(0, 518, 0, 375)
			MainPage.BackgroundTransparency = 1
			MainPage.ClipsDescendants = true
			MainPage.Visible = true
			MainPage.LayoutOrder = PageOrders




			TextButton_Tap.MouseButton1Click:connect(function()
				if MainPage.Name == text.."_MainPage" then
					UIPage:JumpToIndex(MainPage.LayoutOrder)

				end
				for i ,v in next , ScrollingFrame_Menubar:GetChildren() do
					if v:IsA("Frame") then
						TweenService:Create(
							v.TextButton_Tap,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(155, 155, 155)}
						):Play()
					end

					TweenService:Create(
						TextButton_Tap,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(249, 53, 139)}
					):Play()
				end
			end)

			if fs == false then
				-- TweenService:Create(
				--     TextLabel_Tap,
				--     TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
				--     {Size = UDim2.new(0, 70, 0, 2)}
				-- ):Play()
				TweenService:Create(
					TextButton_Tap,
					TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextColor3 = Color3.fromRGB(249, 53, 139)}
				):Play()

				MainPage.Visible = true
				Frame_Tap.Name  = text .. "Server"
				fs  = true
			end
			local ScrollingFrame_Pagefrist = Instance.new("ScrollingFrame")

			ScrollingFrame_Pagefrist.Parent = MainPage
			ScrollingFrame_Pagefrist.Active = true
			ScrollingFrame_Pagefrist.BackgroundColor3 = Color3.fromRGB(23, 23, 23) -- 249, 53, 139
			ScrollingFrame_Pagefrist.BorderSizePixel = 0
			ScrollingFrame_Pagefrist.Size = UDim2.new(0, 518, 0, 375)
			ScrollingFrame_Pagefrist.ScrollBarThickness = 4
			ScrollingFrame_Pagefrist.ScrollBarImageColor3 = Color3.fromRGB(249, 53, 139) -- 249, 53, 139

			local UIGridLayout_Pagefrist = Instance.new("UIGridLayout")
			local UIPadding_Pagefrist = Instance.new("UIPadding")

			UIGridLayout_Pagefrist.Archivable = false
			UIGridLayout_Pagefrist.Parent = ScrollingFrame_Pagefrist
			UIGridLayout_Pagefrist.SortOrder = Enum.SortOrder.LayoutOrder
			UIGridLayout_Pagefrist.CellPadding = UDim2.new(0, 13, 0, 15)
			UIGridLayout_Pagefrist.CellSize = UDim2.new(0, 240, 0, 370)

			UIPadding_Pagefrist.Parent = ScrollingFrame_Pagefrist
			UIPadding_Pagefrist.PaddingLeft = UDim.new(0, 10)
			UIPadding_Pagefrist.PaddingTop = UDim.new(0, 20)

			local page = {}

			function page:newpage()

				local Pageframe = Instance.new("Frame")


				Pageframe.Parent = ScrollingFrame_Pagefrist
				Pageframe.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Pageframe.BorderSizePixel = 0
				Pageframe.Position = UDim2.new(0.028957529, 0, 0.0496277921, 0)
				Pageframe.Size = UDim2.new(0, 240, 0, 379)


				local ScrollingFrame_Pageframe = Instance.new("ScrollingFrame")


				ScrollingFrame_Pageframe.Parent = Pageframe
				ScrollingFrame_Pageframe.Active = true
				ScrollingFrame_Pageframe.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				ScrollingFrame_Pageframe.BorderSizePixel = 0
				ScrollingFrame_Pageframe.Position = UDim2.new(0, 0, -0.0101253344, 0)
				ScrollingFrame_Pageframe.Size = UDim2.new(0, 240, 0, 379)
				ScrollingFrame_Pageframe.ScrollBarThickness = 4
				ScrollingFrame_Pageframe.ScrollBarImageColor3 = Color3.fromRGB(222, 222, 222)



				local UIPadding_Pageframe = Instance.new("UIPadding")
				local UIListLayout_Pageframe = Instance.new("UIListLayout")


				UIPadding_Pageframe.Parent = ScrollingFrame_Pageframe
				UIPadding_Pageframe.PaddingLeft = UDim.new(0, 15)
				UIPadding_Pageframe.PaddingTop = UDim.new(0, 10)


				UIListLayout_Pageframe.Parent = ScrollingFrame_Pageframe
				UIListLayout_Pageframe.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_Pageframe.Padding = UDim.new(0, 7)

				UIListLayout_Pageframe:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
					ScrollingFrame_Pageframe.CanvasSize = UDim2.new(0,0,0,UIListLayout_Pageframe.AbsoluteContentSize.Y + 120 )
				end)

				UIGridLayout_Pagefrist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
					ScrollingFrame_Pagefrist.CanvasSize = UDim2.new(0,0,0,UIGridLayout_Pagefrist.AbsoluteContentSize.Y + 50 )
				end)

				game:GetService("RunService").Stepped:Connect(function ()
					pcall(function ()
						ScrollingFrame_Menubar.CanvasSize = UDim2.new(0,  UIListLayout_Menubar.AbsoluteContentSize.X, 0,0)
						ScrollingFrame_Pageframe.CanvasSize = UDim2.new(0,0,0,UIListLayout_Pageframe.AbsoluteContentSize.Y +20 )
						ScrollingFrame_Pagefrist.CanvasSize = UDim2.new(0,0,0,UIGridLayout_Pagefrist.AbsoluteContentSize.Y + 40)
					end)
				end)
			local items = {}

			function items:Toggle(text,config,callback)
				local Toggle = Instance.new("Frame")

				Toggle.Parent = ScrollingFrame_Pageframe
				Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(0.5, 0, 0.5, 0)
				Toggle.Size = UDim2.new(0, 213, 0, 35)
				Toggle.BackgroundTransparency = 1
				Toggle.AnchorPoint = Vector2.new(0.5, 0.5)

				local TextButton_Toggle = Instance.new("TextButton")

				TextButton_Toggle.Parent = Toggle
				TextButton_Toggle.BackgroundTransparency =1
				TextButton_Toggle.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				TextButton_Toggle.BorderSizePixel = 0
				TextButton_Toggle.Size = UDim2.new(0, 213, 0, 35)
				TextButton_Toggle.AutoButtonColor = false
				TextButton_Toggle.Font = Enum.Font.SourceSans
				TextButton_Toggle.Text = " "
				TextButton_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_Toggle.TextSize = 12.000

				local TextButton_2_Toggle = Instance.new("TextButton")

				TextButton_2_Toggle.Parent = TextButton_Toggle
				TextButton_2_Toggle.BackgroundColor3 = Color3.fromRGB(155, 155, 155)
		--        TextButton_2_Toggle.BorderColor3 = Color3.fromRGB(249, 53, 139)
				TextButton_2_Toggle.BorderSizePixel = 0
				TextButton_2_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
				TextButton_2_Toggle.Position = UDim2.new(0.9, 0, 0.5, 0)
				TextButton_2_Toggle.Size = UDim2.new(0, 30, 0, 13)
				TextButton_2_Toggle.Font = Enum.Font.SourceSans
				TextButton_2_Toggle.Text = " "
				TextButton_2_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_2_Toggle.TextSize = 12.000
				TextButton_2_Toggle.AutoButtonColor = false

				local TextButton_Pageframe_Uiconner = Instance.new("UICorner")

				TextButton_Pageframe_Uiconner.CornerRadius = UDim.new(0, 30)
				TextButton_Pageframe_Uiconner.Name = ""
				TextButton_Pageframe_Uiconner.Parent = TextButton_2_Toggle

				local TextButton_3_Toggle = Instance.new("TextButton")

				TextButton_3_Toggle.Parent = TextButton_2_Toggle
				TextButton_3_Toggle.BackgroundColor3 = Color3.fromRGB(255, 255,255)
		--        TextButton_3_Toggle.BorderColor3 = Color3.fromRGB(249, 53, 139)
				TextButton_3_Toggle.BorderSizePixel = 0
				TextButton_3_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
				TextButton_3_Toggle.Position = UDim2.new(0.1, 0, 0.5, 0)
				TextButton_3_Toggle.Size = UDim2.new(0, 19, 0, 19)
				TextButton_3_Toggle.Font = Enum.Font.SourceSans
				TextButton_3_Toggle.Text = " "
				TextButton_3_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_3_Toggle.TextSize = 12.000
				TextButton_3_Toggle.AutoButtonColor = false

				local TextButton_Pageframe_Uiconner2 = Instance.new("UICorner")

				TextButton_Pageframe_Uiconner2.CornerRadius = UDim.new(0, 30)
				TextButton_Pageframe_Uiconner2.Name = ""
				TextButton_Pageframe_Uiconner2.Parent = TextButton_3_Toggle

				local TextButton_4_Toggle = Instance.new("TextButton")

				TextButton_4_Toggle.Parent = TextButton_3_Toggle
				TextButton_4_Toggle.BackgroundColor3 = Color3.fromRGB(155, 155,155)
		--        TextButton_3_Toggle.BorderColor3 = Color3.fromRGB(249, 53, 139)
				TextButton_4_Toggle.BorderSizePixel = 0
				TextButton_4_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
				TextButton_4_Toggle.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextButton_4_Toggle.Size = UDim2.new(0, 27, 0, 27-2)
				TextButton_4_Toggle.Font = Enum.Font.SourceSans
				TextButton_4_Toggle.Text = " "
				TextButton_4_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_4_Toggle.TextSize = 12.000
				TextButton_4_Toggle.AutoButtonColor = false
				TextButton_4_Toggle.BackgroundTransparency = 1
				TextButton_4_Toggle.Visible = true

				local TextButton_Pageframe_Uiconner4 = Instance.new("UICorner")

				TextButton_Pageframe_Uiconner4.CornerRadius = UDim.new(0, 30)
				TextButton_Pageframe_Uiconner4.Name = ""
				TextButton_Pageframe_Uiconner4.Parent = TextButton_4_Toggle

				local TextLabel_Toggle = Instance.new("TextLabel")

				TextLabel_Toggle.Parent = Toggle
				TextLabel_Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_Toggle.BackgroundTransparency = 1
				TextLabel_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel_Toggle.Position = UDim2.new(0.4, 0, 0.5, 0)
				TextLabel_Toggle.BorderSizePixel = 0
				TextLabel_Toggle.Size = UDim2.new(0, 130, 0, 25)
				TextLabel_Toggle.Font = Enum.Font.GothamSemibold
				TextLabel_Toggle.Text = text
				TextLabel_Toggle.TextColor3 = Color3.fromRGB(200, 200, 200)
				TextLabel_Toggle.TextSize = 13.000
				TextLabel_Toggle.ClipsDescendants = true
				TextLabel_Toggle.TextWrapped = true
				TextLabel_Toggle.TextXAlignment = Enum.TextXAlignment.Left

				local TextButton_Toggle2 = Instance.new("TextButton")

				TextButton_Toggle2.Parent = TextButton_Toggle
				TextButton_Toggle2.BackgroundTransparency =1
				TextButton_Toggle2.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				TextButton_Toggle2.BorderSizePixel = 0
				TextButton_Toggle2.Size = UDim2.new(0, 213, 0, 35)
				TextButton_Toggle2.AutoButtonColor = false
				TextButton_Toggle2.Font = Enum.Font.SourceSans
				TextButton_Toggle2.Text = " "
				TextButton_Toggle2.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_Toggle2.TextSize = 12.000

				TextButton_Toggle2.MouseEnter:Connect(function()
					TweenService:Create(
						TextButton_4_Toggle,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0.6} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextLabel_Toggle,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)

			TextButton_Toggle2.MouseLeave:Connect(function()
					TweenService:Create(
						TextButton_4_Toggle,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 1} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextLabel_Toggle,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(200, 200, 200)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)

			local check = {toogle = false ; loacker = true ; togfunction = {

			};
		}
		TextButton_Toggle2.MouseButton1Click:Connect(function()
				if check.toogle == false and check.loacker == true  then
					TweenService:Create(
						TextButton_4_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextButton_3_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextButton_2_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(153, 0, 102)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TextButton_3_Toggle:TweenSizeAndPosition(UDim2.new(0, 19, 0, 19), UDim2.new(1, 0, 0.5, 0), "Out", "Quad", 0.3, true)
				elseif  check.loacker ==  true then
					TweenService:Create(
						TextButton_4_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextButton_3_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextButton_2_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TextButton_3_Toggle:TweenSizeAndPosition(UDim2.new(0, 19, 0, 19), UDim2.new(0.1, 0, 0.5, 0), "Out", "Quad", 0.3, true)
				end
				if  check.loacker == true  then
				check.toogle = not check.toogle
				callback(check.toogle)
				end
			end
		)

			if config == true then
				TweenService:Create(
					TextButton_4_Toggle,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundColor3 =  Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					TextButton_3_Toggle,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundColor3 =  Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					TextButton_2_Toggle,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundColor3 =  Color3.fromRGB(153, 0, 102)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TextButton_3_Toggle:TweenSizeAndPosition(UDim2.new(0, 19, 0, 19), UDim2.new(1, 0, 0.5, 0), "Out", "Quad", 0.3, true)
				check.toogle = true
				callback(check.toogle)
			end

			local lockerframe = Instance.new("Frame")

			lockerframe.Name = "lockerframe"
			lockerframe.Parent = Toggle
			lockerframe.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			lockerframe.BackgroundTransparency = 1
			lockerframe.Size = UDim2.new(0, 320, 0, 35)
			lockerframe.Position = UDim2.new(0.5, 0, 0.5, 0)
			lockerframe.AnchorPoint = Vector2.new(0.5, 0.5)

			local LockerImageLabel = Instance.new("ImageLabel")
			LockerImageLabel.Parent = lockerframe
			LockerImageLabel.BackgroundTransparency = 1.000
			LockerImageLabel.BorderSizePixel = 0
			LockerImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
			LockerImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			LockerImageLabel.Size = UDim2.new(0, 0, 0, 0)
			LockerImageLabel.Image = "http://www.roblox.com/asset/?id=6031082533"


			function check.togfunction:lock()
				TweenService:Create(
					lockerframe,
					TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
					{BackgroundTransparency = 0.7}
				):Play()
				TweenService:Create(
					LockerImageLabel,
					TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
					{Size = UDim2.new(0, 30, 0, 30)}
				):Play()

				check.loacker  = false
			--    pcall(callback,locker)
			end
			function check.togfunction:unlock()
				TweenService:Create(
					lockerframe,
					TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
					{BackgroundTransparency = 1}
				):Play()
				TweenService:Create(
					LockerImageLabel,
					TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
					{Size = UDim2.new(0, 0, 0, 0)}
				):Play()
				check.loacker  = true
			--   pcall(callback,locker)
			end

				return  check.togfunction
			end

			function items:Button(text,callback)

				local ButtonFrame = Instance.new("Frame")

				ButtonFrame.Name = "ButtonFrame"
				ButtonFrame.Parent = ScrollingFrame_Pageframe
				ButtonFrame.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				ButtonFrame.BorderSizePixel = 0
				ButtonFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
				ButtonFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonFrame.Size = UDim2.new(0, 213, 0, 25) -- UDim2.new(0, 213, 0, 35)
				ButtonFrame.BackgroundTransparency  = 1
				ButtonFrame.ClipsDescendants = true



				local MheeFrameStroke = Instance.new("UIStroke")

				MheeFrameStroke.Thickness = 0
				MheeFrameStroke.Name = ""
				MheeFrameStroke.Parent = ButtonFrame
				MheeFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
				MheeFrameStroke.Color = Color3.fromRGB(249, 53, 139)
				MheeFrameStroke.Transparency = 0.7

				local Button = Instance.new("TextButton")

				Button.Parent = ButtonFrame
				Button.Name = "Button"
				Button.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				Button.Size = UDim2.new(0,150, 0, 25)
				Button.Font = Enum.Font.SourceSansSemibold
				Button.Text = tostring(text)
				Button.TextColor3 = Color3.fromRGB(155, 155, 155)
				Button.TextSize = 13.000
				Button.AnchorPoint = Vector2.new(0.5, 0.5)
				Button.Position = UDim2.new(0.5, 0, 0.5, 0)
				Button.TextXAlignment = Enum.TextXAlignment.Center
				Button.BackgroundTransparency = 0.6
				Button.TextWrapped = true
				Button.AutoButtonColor = false
				Button.ClipsDescendants = true

				local ConnerPageMhee = Instance.new("UICorner")

				ConnerPageMhee.CornerRadius = UDim.new(0, 4)
				ConnerPageMhee.Name = ""
				ConnerPageMhee.Parent = Button

				Button.MouseEnter:Connect(function()
					TweenService:Create(
						Button,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size =  UDim2.new(0, 213, 0, 25)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						Button,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						Button,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)
				Button.MouseLeave:Connect(function()
					TweenService:Create(
						Button,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size =  UDim2.new(0, 150, 0, 25)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						Button,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundTransparency = 0.6} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						Button,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)

			Button.MouseButton1Click:Connect(function()
			--    Ripple(Button)
				callback()
				TweenService:Create(
					Button,
					TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
					{TextSize =  16} -- UDim2.new(0, 128, 0, 25)
				):Play()
				wait(0.1)
				TweenService:Create(
					Button,
					TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
					{TextSize =  13} -- UDim2.new(0, 128, 0, 25)
				):Play()
			end
		)

			end

			function items:Slider(text,check,floor,min,max,de,lol,tog,callback)

			if check then

				local SliderFrame = Instance.new("Frame")

				SliderFrame.Name = "SliderFrame"
				SliderFrame.Parent = ScrollingFrame_Pageframe
				SliderFrame.BackgroundColor3 =  Color3.fromRGB(28, 28, 28)-- Color3.fromRGB(249, 53, 139)
				SliderFrame.BorderSizePixel = 0
				SliderFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
				SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderFrame.Size = UDim2.new(0, 213, 0, 75) -- UDim2.new(0, 213, 0, 35)
				SliderFrame.BackgroundTransparency  = 0
				SliderFrame.ClipsDescendants = true

				local SliderFrameConner = Instance.new("UICorner")

				SliderFrameConner.CornerRadius = UDim.new(0, 4)
				SliderFrameConner.Name = ""
				SliderFrameConner.Parent = SliderFrame

				local SliderFrameStroke = Instance.new("UIStroke")

				SliderFrameStroke.Thickness = 1
				SliderFrameStroke.Name = ""
				SliderFrameStroke.Parent = SliderFrame
				SliderFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
				SliderFrameStroke.Color = Color3.fromRGB(249, 53, 139)
				SliderFrameStroke.Transparency = 0.7


				SliderFrame.MouseEnter:Connect(function()
					TweenService:Create(
						SliderFrameStroke,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)

				SliderFrame.MouseLeave:Connect(function()
					TweenService:Create(
						SliderFrameStroke,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0.7} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)


				local LabelNameSliderxd = Instance.new("TextLabel")

				LabelNameSliderxd.Parent = SliderFrame
				LabelNameSliderxd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelNameSliderxd.BackgroundTransparency = 1
				LabelNameSliderxd.BorderSizePixel = 0
				LabelNameSliderxd.Position = UDim2.new(0.35, 0, 0.2, 0)
				LabelNameSliderxd.AnchorPoint = Vector2.new(0.5, 0.5)
				LabelNameSliderxd.Size = UDim2.new(0, 120, 0, 20)
				LabelNameSliderxd.Font = Enum.Font.GothamBold
				LabelNameSliderxd.Text = tostring(text)
				LabelNameSliderxd.TextColor3 = Color3.fromRGB(255, 255, 255)
				LabelNameSliderxd.TextSize = 11.000
				LabelNameSliderxd.TextXAlignment = Enum.TextXAlignment.Left


				local ShowValueFarm = Instance.new("Frame")

				ShowValueFarm.Name = "ShowValueFarm"
				ShowValueFarm.Parent = SliderFrame
				ShowValueFarm.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				ShowValueFarm.Position = UDim2.new(0.0833333358, 0, 0.235135213, 0)
				ShowValueFarm.Size = UDim2.new(0, 75, 0, 15)
				ShowValueFarm.BackgroundTransparency = 0
				ShowValueFarm.BorderSizePixel = 0
				ShowValueFarm.AnchorPoint = Vector2.new(0.5, 0.5)
				ShowValueFarm.Position = UDim2.new(0.8, 0, 0.2, 0)
				ShowValueFarm.ClipsDescendants = false

				local CustomValue = Instance.new("TextBox")

				CustomValue.Parent = ShowValueFarm
				CustomValue.BackgroundColor3 = Color3.fromRGB(45,45, 45)
				CustomValue.BorderSizePixel = 0
				CustomValue.ClipsDescendants = true
				CustomValue.AnchorPoint = Vector2.new(0.5, 0.5)
				CustomValue.Position = UDim2.new(0.5, 0, 0.5, 0)
				CustomValue.Size = UDim2.new(0, 158, 0, 26)
				CustomValue.Font = Enum.Font.GothamSemibold
				CustomValue.PlaceholderColor3 = Color3.fromRGB(222, 222, 222)
				CustomValue.PlaceholderText =  ""
				if floor == true then
					CustomValue.Text =  tostring(de and string.format("%.1f",(de / max) * (max - min) + min) or 0)
				else
					CustomValue.Text =  tostring(de and math.floor( (de / max) * (max - min) + min) or 0)
				end
				CustomValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				CustomValue.TextSize = 8.000
				CustomValue.BackgroundTransparency = 1

				local ValueFrame = Instance.new("Frame")

				ValueFrame.Name = "ValueFrame"
				ValueFrame.Parent = SliderFrame
				ValueFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				ValueFrame.Position = UDim2.new(0.0833333358, 0, 0.235135213, 0)
				ValueFrame.Size = UDim2.new(0, 140, 0, 5)
				ValueFrame.BackgroundTransparency = 0
				ValueFrame.BorderSizePixel = 0
				ValueFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ValueFrame.Position = UDim2.new(0.4, 0, 0.8, 0)
				ValueFrame.ClipsDescendants = false


				local PartValue = Instance.new("Frame")

				PartValue.Name = "PartValue"
				PartValue.Parent = ValueFrame
				PartValue.BackgroundColor3 = Color3.fromRGB(222, 222, 222)
				PartValue.Position = UDim2.new(0.0833333358, 0, 0.235135213, 0)
				PartValue.Size = UDim2.new(0, 140, 0, 5)
				PartValue.BackgroundTransparency = 1
				PartValue.BorderSizePixel = 0
				PartValue.AnchorPoint = Vector2.new(0.5, 0.5)
				PartValue.Position = UDim2.new(0.5, 0, 0.5, 0)
				PartValue.ClipsDescendants = false

				local MainValue = Instance.new("Frame")

				MainValue.Name = "MainValue"
				MainValue.Parent = PartValue
				MainValue.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				MainValue.Size = UDim2.new((de or 0) / max, 0, 0, 5)
				MainValue.BackgroundTransparency = 0
				MainValue.BorderSizePixel = 0
				-- MainValue.AnchorPoint = Vector2.new(0.5, 0.5)
				MainValue.Position = UDim2.new(0., 0, 0.0, 0)
				MainValue.ClipsDescendants = false

				local Conner_S1 = Instance.new("UICorner")

				Conner_S1.CornerRadius = UDim.new(0, 8)
				Conner_S1.Name = ""
				Conner_S1.Parent = MainValue

				local Conner_S2 = Instance.new("UICorner")

				Conner_S2.CornerRadius = UDim.new(0, 8)
				Conner_S2.Name = ""
				Conner_S2.Parent = ValueFrame

				local ConneValue = Instance.new("Frame")

				ConneValue.Name = "ConneValue"
				ConneValue.Parent = PartValue
				ConneValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ConneValue.Size = UDim2.new(0, 13, 0,13)
				ConneValue.BackgroundTransparency = 0
				ConneValue.BorderSizePixel = 0
				ConneValue.AnchorPoint = Vector2.new(0.5, 0.5)
				ConneValue.Position = UDim2.new((de or 0)/max, 0.5, 0.3,0.5, 0)
				ConneValue.ClipsDescendants = false


				local Conner_Conne = Instance.new("UICorner")

				Conner_Conne.CornerRadius = UDim.new(0, 300)
				Conner_Conne.Name = ""
				Conner_Conne.Parent = ConneValue

				local Addvalue = Instance.new("ImageButton")

				Addvalue.Name = "Imatog"
				Addvalue.Parent = SliderFrame
				Addvalue.BackgroundTransparency = 1.000
				Addvalue.BorderSizePixel = 0
				Addvalue.Position = UDim2.new(0.85, 0, 0.35, 0)
				Addvalue.Size = UDim2.new(0, 15, 0, 15)
				Addvalue.Image = "http://www.roblox.com/asset/?id=6035067836"
				Addvalue.ImageColor3 =  Color3.fromRGB(249, 53, 139)

				local Deletevalue = Instance.new("ImageButton")

				Deletevalue.Name = "Imatog"
				Deletevalue.Parent = SliderFrame
				Deletevalue.BackgroundTransparency = 1.000
				Deletevalue.BorderSizePixel = 0
				Deletevalue.Position = UDim2.new(0.7, 0, 0.35, 0)
				Deletevalue.Size = UDim2.new(0, 15, 0, 15)
				Deletevalue.Image = "http://www.roblox.com/asset/?id=6035047377"
				Deletevalue.ImageColor3 =  Color3.fromRGB(249, 53, 139)


				local TextButton_2_Toggle = Instance.new("TextButton")

				TextButton_2_Toggle.Parent = ValueFrame
				TextButton_2_Toggle.BackgroundColor3 = Color3.fromRGB(155, 155, 155)
		--        TextButton_2_Toggle.BorderColor3 = Color3.fromRGB(249, 53, 139)
				TextButton_2_Toggle.BorderSizePixel = 0
				TextButton_2_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
				TextButton_2_Toggle.Position = UDim2.new(1.25, 0, 0.4, 0)
				TextButton_2_Toggle.Size = UDim2.new(0, 30, 0, 13)
				TextButton_2_Toggle.Font = Enum.Font.SourceSans
				TextButton_2_Toggle.Text = " "
				TextButton_2_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_2_Toggle.TextSize = 12.000
				TextButton_2_Toggle.AutoButtonColor = false

				local TextButton_Pageframe_Uiconner = Instance.new("UICorner")

				TextButton_Pageframe_Uiconner.CornerRadius = UDim.new(0, 30)
				TextButton_Pageframe_Uiconner.Name = ""
				TextButton_Pageframe_Uiconner.Parent = TextButton_2_Toggle

				local TextButton_3_Toggle = Instance.new("TextButton")

				TextButton_3_Toggle.Parent = TextButton_2_Toggle
				TextButton_3_Toggle.BackgroundColor3 = Color3.fromRGB(255, 255,255)
		--        TextButton_3_Toggle.BorderColor3 = Color3.fromRGB(249, 53, 139)
				TextButton_3_Toggle.BorderSizePixel = 0
				TextButton_3_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
				TextButton_3_Toggle.Position = UDim2.new(0.1, 0, 0.5, 0)
				TextButton_3_Toggle.Size = UDim2.new(0, 19, 0, 19)
				TextButton_3_Toggle.Font = Enum.Font.SourceSans
				TextButton_3_Toggle.Text = " "
				TextButton_3_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_3_Toggle.TextSize = 12.000
				TextButton_3_Toggle.AutoButtonColor = false

				local TextButton_Pageframe_Uiconner2 = Instance.new("UICorner")

				TextButton_Pageframe_Uiconner2.CornerRadius = UDim.new(0, 30)
				TextButton_Pageframe_Uiconner2.Name = ""
				TextButton_Pageframe_Uiconner2.Parent = TextButton_3_Toggle

				local TextButton_4_Toggle = Instance.new("TextButton")

				TextButton_4_Toggle.Parent = TextButton_3_Toggle
				TextButton_4_Toggle.BackgroundColor3 = Color3.fromRGB(155, 155,155)
		--        TextButton_3_Toggle.BorderColor3 = Color3.fromRGB(249, 53, 139)
				TextButton_4_Toggle.BorderSizePixel = 0
				TextButton_4_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
				TextButton_4_Toggle.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextButton_4_Toggle.Size = UDim2.new(0, 27, 0, 27-2)
				TextButton_4_Toggle.Font = Enum.Font.SourceSans
				TextButton_4_Toggle.Text = " "
				TextButton_4_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_4_Toggle.TextSize = 12.000
				TextButton_4_Toggle.AutoButtonColor = false
				TextButton_4_Toggle.BackgroundTransparency = 1
				TextButton_4_Toggle.Visible = true

				local TextButton_Pageframe_Uiconner4 = Instance.new("UICorner")

				TextButton_Pageframe_Uiconner4.CornerRadius = UDim.new(0, 30)
				TextButton_Pageframe_Uiconner4.Name = ""
				TextButton_Pageframe_Uiconner4.Parent = TextButton_4_Toggle


				local TextButton_Toggle = Instance.new("TextButton")

				TextButton_Toggle.Parent = ValueFrame
				TextButton_Toggle.BackgroundTransparency =1
				TextButton_Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton_Toggle.BorderSizePixel = 0
				TextButton_Toggle.Size = UDim2.new(0, 50, 0, 20)
				TextButton_Toggle.AutoButtonColor = false
				TextButton_Toggle.Font = Enum.Font.SourceSans
				TextButton_Toggle.Text = " "
				TextButton_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_Toggle.TextSize = 12.000
				TextButton_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
				TextButton_Toggle.Position = UDim2.new(1.25, 0, 0.4, 0)



			-- local value = de
			local check2 = {toogle2 = false;}
				local function move(input)
					local pos =
						UDim2.new(
							math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0.3,
							0
						)
					local pos1 =
						UDim2.new(
							math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0,
							5
						)

						MainValue:TweenSize(pos1, "Out", "Sine", 0.2, true)

						ConneValue:TweenPosition(pos, "Out", "Sine", 0.2, true)
						if floor == true then
							local value = string.format("%.1f",((pos.X.Scale * max) / max) * (max - min) + min)
							CustomValue.Text = tostring(value)
						--   callback[2] = value
						callback({
							["s"] = value;
							["t"] = check2.toogle2
						})
						--callback({value,check2.toogle2})
							--callback(value)
						else
							local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
							CustomValue.Text = tostring(value)
							callback({
								["s"] = value;
								["t"] = check2.toogle2
							})
					--       callback({value,check2.toogle2})

						end



					end

					local dragging = false
					ConneValue.InputBegan:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = true

							end
						end
					)
					ConneValue.InputEnded:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = false

							end
						end
					)
					SliderFrame.InputBegan:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = true

							end
						end
					)
					SliderFrame.InputEnded:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = false

							end
						end
					)


					ValueFrame.InputBegan:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = true

							end
						end
					)
					ValueFrame.InputEnded:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = false

							end
						end
					)

					game:GetService("UserInputService").InputChanged:Connect(
						function(input)
							if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
								move(input)
							end
						end
						)

						CustomValue.FocusLost:Connect(function()
							if CustomValue.Text == "" then
								CustomValue.Text  = de
							end
							if  tonumber(CustomValue.Text) > max then
								CustomValue.Text  = max
							end
							if  tonumber(CustomValue.Text) <= min then
								CustomValue.Text  = min
							end
							MainValue:TweenSize(UDim2.new((CustomValue.Text or 0) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
							ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0, 0) , "Out", "Sine", 0.2, true)
							if floor == true then
								CustomValue.Text = tostring(CustomValue.Text and string.format("%.1f",(CustomValue.Text / max) * (max - min) + min) )
							else
								CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
							end
							callback({
								["s"] =  CustomValue.Text;
								["t"] = check2.toogle2;
							})
					--       callback({ tonumber(CustomValue.Text),check2.toogle2})
					--  pcall(callback, CustomValue.Text)
						end)


						Addvalue.MouseButton1Click:Connect(function ()
							if CustomValue.Text == "" then
								CustomValue.Text  = de
							end
							pcall(function()
								CustomValue.Text  = CustomValue.Text  - tonumber(lol)
							end)
							if  tonumber(CustomValue.Text) > max then
								CustomValue.Text  = max
							end
							if  tonumber(CustomValue.Text) < min then
								CustomValue.Text  = min
							end
							MainValue:TweenSize(UDim2.new((CustomValue.Text  or 0  ) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
							ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0.5, 0) , "Out", "Sine", 0.2, true)
							if floor == true then
								CustomValue.Text = tostring(CustomValue.Text and string.format("%.1f",(CustomValue.Text / max) * (max - min) + min) )
							else
								CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
							end
							callback({
								["s"] =  CustomValue.Text;
								["t"] = check2.toogle2
							})
						--   callback({ tonumber(CustomValue.Text),check2.toogle2})
						--  pcall(callback, CustomValue.Text)
						end)

						Deletevalue.MouseButton1Click:Connect(function ()
							if CustomValue.Text == "" then
								CustomValue.Text  = de
							end
							pcall(function()
								CustomValue.Text  = CustomValue.Text  + tonumber(lol)
							end)
							if  tonumber(CustomValue.Text) > max then
								CustomValue.Text  = max
							end
							if  tonumber(CustomValue.Text) < min then
								CustomValue.Text  = min
							end
							MainValue:TweenSize(UDim2.new((CustomValue.Text  or 0  ) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
							ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0.5, 0) , "Out", "Sine", 0.2, true)
							if floor == true then
								CustomValue.Text = tostring(CustomValue.Text and string.format("%.1f",(CustomValue.Text / max) * (max - min) + min) )
							else
								CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
							end
							callback({
								["s"] =  CustomValue.Text;
								["t"] = check2.toogle2;
							})
				--callback({ tonumber(CustomValue.Text),check2.toogle2})
						--  pcall(callback, CustomValue.Text)
						end)




				---
						TextButton_Toggle.MouseEnter:Connect(function()
							TweenService:Create(
								TextButton_4_Toggle,
								TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{BackgroundTransparency = 0.6} -- UDim2.new(0, 128, 0, 25)
							):Play()
						end
					)

					TextButton_Toggle.MouseLeave:Connect(function()
							TweenService:Create(
								TextButton_4_Toggle,
								TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
								{BackgroundTransparency = 1} -- UDim2.new(0, 128, 0, 25)
							):Play()
						end
					)



				TextButton_Toggle.MouseButton1Click:Connect(function()
					if check2.toogle2 == false   then
						TweenService:Create(
							TextButton_4_Toggle,
							TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 =  Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							TextButton_3_Toggle,
							TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 =  Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							TextButton_2_Toggle,
							TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 =  Color3.fromRGB(153, 0, 102)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TextButton_3_Toggle:TweenSizeAndPosition(UDim2.new(0, 19, 0, 19), UDim2.new(1, 0, 0.5, 0), "Out", "Quad", 0.3, true)
					else
						TweenService:Create(
							TextButton_4_Toggle,
							TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 =  Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							TextButton_3_Toggle,
							TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 =  Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							TextButton_2_Toggle,
							TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{BackgroundColor3 =  Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TextButton_3_Toggle:TweenSizeAndPosition(UDim2.new(0, 19, 0, 19), UDim2.new(0.1, 0, 0.5, 0), "Out", "Quad", 0.3, true)
					end
						check2.toogle2 = not check2.toogle2
						callback({
							["t"] = check2.toogle2;

						})
					--   callback({value,check2.toogle2})
						--callback(check2.toogle2)
				end
			)

				if tog == true then
					TweenService:Create(
						TextButton_4_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextButton_3_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextButton_2_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(153, 0, 102)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TextButton_3_Toggle:TweenSizeAndPosition(UDim2.new(0, 19, 0, 19), UDim2.new(1, 0, 0.5, 0), "Out", "Quad", 0.3, true)
					check2.toogle2 = true
					callback({
						["t"] = check2.toogle2;
					})
			--        callback({value,check2.toogle2})
				--  callback(check2.toogle2)
				end


			else
				tog = nil
				local SliderFrame = Instance.new("Frame")

				SliderFrame.Name = "SliderFrame"
				SliderFrame.Parent = ScrollingFrame_Pageframe
				SliderFrame.BackgroundColor3 =  Color3.fromRGB(28, 28, 28)-- Color3.fromRGB(249, 53, 139)
				SliderFrame.BorderSizePixel = 0
				SliderFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
				SliderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderFrame.Size = UDim2.new(0, 213, 0, 75) -- UDim2.new(0, 213, 0, 35)
				SliderFrame.BackgroundTransparency  = 0
				SliderFrame.ClipsDescendants = true

				local SliderFrameConner = Instance.new("UICorner")

				SliderFrameConner.CornerRadius = UDim.new(0, 4)
				SliderFrameConner.Name = ""
				SliderFrameConner.Parent = SliderFrame

				local SliderFrameStroke = Instance.new("UIStroke")

				SliderFrameStroke.Thickness = 1
				SliderFrameStroke.Name = ""
				SliderFrameStroke.Parent = SliderFrame
				SliderFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
				SliderFrameStroke.Color = Color3.fromRGB(249, 53, 139)
				SliderFrameStroke.Transparency = 0.7



				SliderFrame.MouseEnter:Connect(function()
					TweenService:Create(
						SliderFrameStroke,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)

				SliderFrame.MouseLeave:Connect(function()
					TweenService:Create(
						SliderFrameStroke,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0.7} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)

				local LabelNameSliderxd = Instance.new("TextLabel")

				LabelNameSliderxd.Parent = SliderFrame
				LabelNameSliderxd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelNameSliderxd.BackgroundTransparency = 1
				LabelNameSliderxd.BorderSizePixel = 0
				LabelNameSliderxd.Position = UDim2.new(0.35, 0, 0.2, 0)
				LabelNameSliderxd.AnchorPoint = Vector2.new(0.5, 0.5)
				LabelNameSliderxd.Size = UDim2.new(0, 120, 0, 20)
				LabelNameSliderxd.Font = Enum.Font.GothamBold
				LabelNameSliderxd.Text = tostring(text)
				LabelNameSliderxd.TextColor3 = Color3.fromRGB(255, 255, 255)
				LabelNameSliderxd.TextSize = 11.000
				LabelNameSliderxd.TextXAlignment = Enum.TextXAlignment.Left


				local ShowValueFarm = Instance.new("Frame")

				ShowValueFarm.Name = "ShowValueFarm"
				ShowValueFarm.Parent = SliderFrame
				ShowValueFarm.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				ShowValueFarm.Position = UDim2.new(0.0833333358, 0, 0.235135213, 0)
				ShowValueFarm.Size = UDim2.new(0, 75, 0, 15)
				ShowValueFarm.BackgroundTransparency = 0
				ShowValueFarm.BorderSizePixel = 0
				ShowValueFarm.AnchorPoint = Vector2.new(0.5, 0.5)
				ShowValueFarm.Position = UDim2.new(0.8, 0, 0.2, 0)
				ShowValueFarm.ClipsDescendants = false

				local CustomValue = Instance.new("TextBox")

				CustomValue.Parent = ShowValueFarm
				CustomValue.BackgroundColor3 = Color3.fromRGB(45,45, 45)
				CustomValue.BorderSizePixel = 0
				CustomValue.ClipsDescendants = true
				CustomValue.AnchorPoint = Vector2.new(0.5, 0.5)
				CustomValue.Position = UDim2.new(0.5, 0, 0.5, 0)
				CustomValue.Size = UDim2.new(0, 158, 0, 26)
				CustomValue.Font = Enum.Font.GothamSemibold
				CustomValue.PlaceholderColor3 = Color3.fromRGB(222, 222, 222)
				CustomValue.PlaceholderText =  ""
				if floor == true then
					CustomValue.Text =  tostring(de and string.format("%.1f",(de / max) * (max - min) + min) or 0)
				else
					CustomValue.Text =  tostring(de and math.floor( (de / max) * (max - min) + min) or 0)
				end
				CustomValue.TextColor3 = Color3.fromRGB(255, 255, 255)
				CustomValue.TextSize = 8.000
				CustomValue.BackgroundTransparency = 1

				local ValueFrame = Instance.new("Frame")

				ValueFrame.Name = "ValueFrame"
				ValueFrame.Parent = SliderFrame
				ValueFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				ValueFrame.Position = UDim2.new(0.0833333358, 0, 0.235135213, 0)
				ValueFrame.Size = UDim2.new(0, 190, 0, 5)
				ValueFrame.BackgroundTransparency = 0
				ValueFrame.BorderSizePixel = 0
				ValueFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ValueFrame.Position = UDim2.new(0.5, 0, 0.8, 0)
				ValueFrame.ClipsDescendants = false


				local PartValue = Instance.new("Frame")

				PartValue.Name = "PartValue"
				PartValue.Parent = ValueFrame
				PartValue.BackgroundColor3 = Color3.fromRGB(222, 222, 222)
				PartValue.Position = UDim2.new(0.0833333358, 0, 0.235135213, 0)
				PartValue.Size = UDim2.new(0, 190, 0, 5)
				PartValue.BackgroundTransparency = 1
				PartValue.BorderSizePixel = 0
				PartValue.AnchorPoint = Vector2.new(0.5, 0.5)
				PartValue.Position = UDim2.new(0.5, 0, 0.5, 0)
				PartValue.ClipsDescendants = false

				local MainValue = Instance.new("Frame")

				MainValue.Name = "MainValue"
				MainValue.Parent = PartValue
				MainValue.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				MainValue.Size = UDim2.new((de or 0) / max, 0, 0, 5)
				MainValue.BackgroundTransparency = 0
				MainValue.BorderSizePixel = 0
				-- MainValue.AnchorPoint = Vector2.new(0.5, 0.5)
				MainValue.Position = UDim2.new(0., 0, 0.0, 0)
				MainValue.ClipsDescendants = false

				local Conner_S1 = Instance.new("UICorner")

				Conner_S1.CornerRadius = UDim.new(0, 8)
				Conner_S1.Name = ""
				Conner_S1.Parent = MainValue

				local Conner_S2 = Instance.new("UICorner")

				Conner_S2.CornerRadius = UDim.new(0, 8)
				Conner_S2.Name = ""
				Conner_S2.Parent = ValueFrame

				local ConneValue = Instance.new("Frame")

				ConneValue.Name = "ConneValue"
				ConneValue.Parent = PartValue
				ConneValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ConneValue.Size = UDim2.new(0, 13, 0,13)
				ConneValue.BackgroundTransparency = 0
				ConneValue.BorderSizePixel = 0
				ConneValue.AnchorPoint = Vector2.new(0.5, 0.5)
				ConneValue.Position = UDim2.new((de or 0)/max, 0.5, 0.3,0.5, 0)
				ConneValue.ClipsDescendants = false


				local Conner_Conne = Instance.new("UICorner")

				Conner_Conne.CornerRadius = UDim.new(0, 300)
				Conner_Conne.Name = ""
				Conner_Conne.Parent = ConneValue

				local Addvalue = Instance.new("ImageButton")

				Addvalue.Name = "Imatog"
				Addvalue.Parent = SliderFrame
				Addvalue.BackgroundTransparency = 1.000
				Addvalue.BorderSizePixel = 0
				Addvalue.Position = UDim2.new(0.85, 0, 0.35, 0)
				Addvalue.Size = UDim2.new(0, 15, 0, 15)
				Addvalue.Image = "http://www.roblox.com/asset/?id=6035067836"
				Addvalue.ImageColor3 =  Color3.fromRGB(249, 53, 139)

				local Deletevalue = Instance.new("ImageButton")

				Deletevalue.Name = "Imatog"
				Deletevalue.Parent = SliderFrame
				Deletevalue.BackgroundTransparency = 1.000
				Deletevalue.BorderSizePixel = 0
				Deletevalue.Position = UDim2.new(0.7, 0, 0.35, 0)
				Deletevalue.Size = UDim2.new(0, 15, 0, 15)
				Deletevalue.Image = "http://www.roblox.com/asset/?id=6035047377"
				Deletevalue.ImageColor3 =  Color3.fromRGB(249, 53, 139)

				local function move(input)
					local pos =
						UDim2.new(
							math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0.3,
							0
						)
					local pos1 =
						UDim2.new(
							math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
							0,
							0,
							5
						)

						MainValue:TweenSize(pos1, "Out", "Sine", 0.2, true)

						ConneValue:TweenPosition(pos, "Out", "Sine", 0.2, true)
						if floor == true then
							local value = string.format("%.1f",((pos.X.Scale * max) / max) * (max - min) + min)
							CustomValue.Text = tostring(value)
							callback(value)
						else
							local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
							CustomValue.Text = tostring(value)
							callback(value)
						end



					end

					local dragging = false
					ConneValue.InputBegan:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = true

							end
						end
					)
					ConneValue.InputEnded:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = false

							end
						end
					)
					SliderFrame.InputBegan:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = true

							end
						end
					)
					SliderFrame.InputEnded:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = false

							end
						end
					)


					ValueFrame.InputBegan:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = true

							end
						end
					)
					ValueFrame.InputEnded:Connect(
						function(input)
							if input.UserInputType == Enum.UserInputType.MouseButton1 then
								dragging = false

							end
						end
					)

					game:GetService("UserInputService").InputChanged:Connect(
						function(input)
							if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
								move(input)
							end
						end
						)

						CustomValue.FocusLost:Connect(function()
							if CustomValue.Text == "" then
								CustomValue.Text  = de
							end
							if  tonumber(CustomValue.Text) > max then
								CustomValue.Text  = max
							end
							MainValue:TweenSize(UDim2.new((CustomValue.Text or 0) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
							ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0, 0) , "Out", "Sine", 0.2, true)
							if floor == true then
								CustomValue.Text = tostring(CustomValue.Text and string.format("%.1f",(CustomValue.Text / max) * (max - min) + min) )
							else
								CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
							end
							pcall(callback, CustomValue.Text)
						end)


				Addvalue.MouseButton1Click:Connect(function ()
					if CustomValue.Text == "" then
						CustomValue.Text  = de
					end
					CustomValue.Text  = CustomValue.Text  - tonumber(lol)
					if  tonumber(CustomValue.Text) > max then
						CustomValue.Text  = max
					end
					if  tonumber(CustomValue.Text) < min then
						CustomValue.Text  = min
					end
					MainValue:TweenSize(UDim2.new((CustomValue.Text  or 0  ) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
					ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0.5, 0) , "Out", "Sine", 0.2, true)
					if floor == true then
						CustomValue.Text = tostring(CustomValue.Text and string.format("%.1f",(CustomValue.Text / max) * (max - min) + min) )
					else
						CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
					end
					pcall(callback, CustomValue.Text)
				end)

				Deletevalue.MouseButton1Click:Connect(function ()
					if CustomValue.Text == "" then
						CustomValue.Text  = de
					end
					CustomValue.Text  = CustomValue.Text  + tonumber(lol)
					if  tonumber(CustomValue.Text) > max then
						CustomValue.Text  = max
					end
					if  tonumber(CustomValue.Text) < min then
						CustomValue.Text  = min
					end
					MainValue:TweenSize(UDim2.new((CustomValue.Text  or 0  ) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
					ConneValue:TweenPosition(UDim2.new((CustomValue.Text or 0)/max, 0,0.5, 0) , "Out", "Sine", 0.2, true)
					if floor == true then
						CustomValue.Text = tostring(CustomValue.Text and string.format("%.1f",(CustomValue.Text / max) * (max - min) + min) )
					else
						CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
					end
					pcall(callback, CustomValue.Text)
				end)

			end

			end

			function items:Drop(text,use,option,callback)

			if use == false then
				local DropFrame = Instance.new("Frame")

				DropFrame.Name = "DropFrame"
				DropFrame.Parent = ScrollingFrame_Pageframe
				DropFrame.BackgroundColor3 =  Color3.fromRGB(23, 23, 23)-- Color3.fromRGB(249, 53, 139)
				DropFrame.BorderSizePixel = 0
				DropFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
				DropFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				DropFrame.Size = UDim2.new(0, 213, 0, 30) -- UDim2.new(0, 213, 0, 35)
				DropFrame.BackgroundTransparency  = 0
				DropFrame.ClipsDescendants = true

				local ConnerDropFrame = Instance.new("UICorner")

				ConnerDropFrame.CornerRadius = UDim.new(0, 4)
				ConnerDropFrame.Name = ""
				ConnerDropFrame.Parent = DropFrame

				local DropFrameStroke = Instance.new("UIStroke")

				DropFrameStroke.Thickness = 1
				DropFrameStroke.Name = ""
				DropFrameStroke.Parent = DropFrame
				DropFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
				DropFrameStroke.Color = Color3.fromRGB(249, 53, 139)
				DropFrameStroke.Transparency = 0.7





				local LabelFrameDrop = Instance.new("TextLabel")

				LabelFrameDrop.Parent = DropFrame
				LabelFrameDrop.Name = "LabelFrameDrop"
				LabelFrameDrop.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				LabelFrameDrop.Position = UDim2.new(0., 0, 0., 0)
				LabelFrameDrop.Size =    UDim2.new(0, 213, 0, 30)
				LabelFrameDrop.Font = Enum.Font.SourceSansSemibold
				LabelFrameDrop.Text = ""
				LabelFrameDrop.TextColor3 = Color3.fromRGB(155, 155, 155)
				LabelFrameDrop.TextSize = 14.000
			--   LabelFrameDrop.AnchorPoint = Vector2.new(0.5, 0.5)
				LabelFrameDrop.BackgroundTransparency = 1
				LabelFrameDrop.TextXAlignment = Enum.TextXAlignment.Left


				local TextLabel_TapDrop = Instance.new("TextLabel")

				TextLabel_TapDrop.Parent = LabelFrameDrop
				TextLabel_TapDrop.Name = "TextLabel_TapDrop"
				TextLabel_TapDrop.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				TextLabel_TapDrop.Position = UDim2.new(0.04, 0, 0.14, 0)
				TextLabel_TapDrop.Size =    UDim2.new(0, 140, 0, 20)
				TextLabel_TapDrop.Font = Enum.Font.SourceSansSemibold
				TextLabel_TapDrop.Text = tostring(text).." :"
				TextLabel_TapDrop.TextColor3 = Color3.fromRGB(155, 155, 155)
				TextLabel_TapDrop.TextSize = 14.000
		--     TextLabel_TapDrop.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel_TapDrop.BackgroundTransparency = 1
				TextLabel_TapDrop.TextXAlignment = Enum.TextXAlignment.Left


				local DropArbt_listimage = Instance.new("ImageButton")

				DropArbt_listimage.Parent = LabelFrameDrop
				DropArbt_listimage.BackgroundTransparency = 1.000
				DropArbt_listimage.AnchorPoint = Vector2.new(0.5, 0.5)
				DropArbt_listimage.Position = UDim2.new(0.9, 0, 0.5, 0)
				DropArbt_listimage.BorderSizePixel = 0
				DropArbt_listimage.Size = UDim2.new(0, 25, 0, 25)
				DropArbt_listimage.Image = "http://www.roblox.com/asset/?id=6031091004"
				DropArbt_listimage.ImageColor3 = Color3.fromRGB(155, 155, 155)

				local ScolDown = Instance.new("ScrollingFrame")

				ScolDown.Name = "ScolDown"
				ScolDown.Position = UDim2.new(0.02, 0, 1., 0)
				ScolDown.Parent = LabelFrameDrop
				ScolDown.Active = true
				ScolDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScolDown.BorderSizePixel = 0
				ScolDown.Size = UDim2.new(0, 205, 0, 115)
				ScolDown.ScrollBarThickness = 3
				ScolDown.ClipsDescendants = true
				ScolDown.BackgroundTransparency = 1
				ScolDown.CanvasSize = UDim2.new(0, 0, 0, 2)

				local UIListLayoutlist = Instance.new("UIListLayout")
				local UIPaddinglist = Instance.new("UIPadding")

				UIListLayoutlist.Name = "UIListLayoutlist"
				UIListLayoutlist.Parent = ScolDown
				UIListLayoutlist.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayoutlist.Padding = UDim.new(0, 5)

				UIPaddinglist.Name = "UIPaddinglist"
				UIPaddinglist.Parent = ScolDown
				UIPaddinglist.PaddingTop = UDim.new(0, 5)
				UIPaddinglist.PaddingLeft = UDim.new(0, 12)

				local ButtonDrop = Instance.new("TextButton")

				ButtonDrop.Parent = DropFrame
				ButtonDrop.Name = "ButtonDrop"
				ButtonDrop.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				ButtonDrop.Size = UDim2.new(0, 213, 0, 30)
				ButtonDrop.Font = Enum.Font.SourceSansSemibold
				ButtonDrop.Text = ""
				ButtonDrop.TextColor3 = Color3.fromRGB(155, 155, 155)
				ButtonDrop.TextSize = 13.000
			--   ButtonDrop.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonDrop.Position = UDim2.new(0., 0, 0., 0)
				ButtonDrop.TextXAlignment = Enum.TextXAlignment.Center
				ButtonDrop.BackgroundTransparency = 1
				ButtonDrop.TextWrapped = true
				ButtonDrop.AutoButtonColor = false
				ButtonDrop.ClipsDescendants = true

				local dog = false

				local FrameSize = 75
				local cout = 0
				for i , v in pairs(option) do
					cout =cout + 1
					if cout == 1 then
						FrameSize = 75
					elseif cout == 2 then
						FrameSize = 110
					elseif cout >= 3 then
						FrameSize = 150
					end

					local ListFrame = Instance.new("Frame")

					ListFrame.Name = "ListFrame"
					ListFrame.Parent = ScolDown
					ListFrame.BackgroundColor3 =  Color3.fromRGB(22553, 23, 23)-- Color3.fromRGB(249, 53, 139)
					ListFrame.BorderSizePixel = 0
					ListFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
					ListFrame.AnchorPoint = Vector2.new(0.5, 0.5)
					ListFrame.Size = UDim2.new(0, 180, 0, 30) -- UDim2.new(0, 213, 0, 35)
					ListFrame.BackgroundTransparency  = 1
					ListFrame.ClipsDescendants = true

					local TextLabel_TapDro2p = Instance.new("TextLabel")

					TextLabel_TapDro2p.Parent = ListFrame
					TextLabel_TapDro2p.Name =  tostring(v).."Dropdown"
					TextLabel_TapDro2p.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
					TextLabel_TapDro2p.Position = UDim2.new(0.5, 0, 0.5, 0)
					TextLabel_TapDro2p.Size =  UDim2.new(0, 180, 0, 30)
					TextLabel_TapDro2p.Font = Enum.Font.SourceSansSemibold
					TextLabel_TapDro2p.Text = tostring(v)
					TextLabel_TapDro2p.TextColor3 = Color3.fromRGB(155, 155, 155)
					TextLabel_TapDro2p.TextSize = 14.000
					TextLabel_TapDro2p.AnchorPoint = Vector2.new(0.5, 0.5)
					TextLabel_TapDro2p.BackgroundTransparency = 1
					TextLabel_TapDro2p.TextXAlignment = Enum.TextXAlignment.Center

					local ButtonDrop2 = Instance.new("TextButton")

					ButtonDrop2.Parent = ListFrame
					ButtonDrop2.Name = "ButtonDrop2"
					ButtonDrop2.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
					ButtonDrop2.Size = UDim2.new(0, 213, 0, 30)
					ButtonDrop2.Font = Enum.Font.SourceSansSemibold
					ButtonDrop2.Text = ""
					ButtonDrop2.TextColor3 = Color3.fromRGB(155, 155, 155)
					ButtonDrop2.TextSize = 13.000
				--   ButtonDrop2.AnchorPoint = Vector2.new(0.5, 0.5)
					ButtonDrop2.Position = UDim2.new(0., 0, 0., 0)
					ButtonDrop2.TextXAlignment = Enum.TextXAlignment.Center
					ButtonDrop2.BackgroundTransparency = 1
					ButtonDrop2.TextWrapped = true
					ButtonDrop2.AutoButtonColor = false
					ButtonDrop2.ClipsDescendants = true

					ButtonDrop2.MouseEnter:Connect(function ()
						TweenService:Create(
							TextLabel_TapDro2p,
							TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
						):Play()
					end)

					ButtonDrop2.MouseLeave:Connect(function ()
						TweenService:Create(
							TextLabel_TapDro2p,
							TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
						):Play()
					end)

					ButtonDrop2.MouseButton1Click:Connect(function()
						TweenService:Create(
							DropFrame,
							TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Size = UDim2.new(0, 213, 0, 30)} -- UDim2.new(0, 128, 0, 25)
						):Play()
						TweenService:Create(
							DropArbt_listimage,
							TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
							{Rotation = 0}
						):Play()
						TextLabel_TapDrop.Text =  text.." : "..tostring(v)
						callback(v)
						dog = not dog
					end
				)


					ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
				end


				DropFrame.MouseEnter:Connect(function()
					TweenService:Create(
						DropFrameStroke,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextLabel_TapDrop,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						DropArbt_listimage,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)

			DropFrame.MouseLeave:Connect(function()
					TweenService:Create(
						DropFrameStroke,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0.7} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextLabel_TapDrop,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						DropArbt_listimage,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ImageColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)


			ButtonDrop.MouseButton1Click:Connect(function()
				if dog == false then
					TweenService:Create(
						DropFrame,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 213, 0, FrameSize)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						DropArbt_listimage,
						TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
						{Rotation = -180}
					):Play()
					ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
				else
					TweenService:Create(
						DropFrame,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 213, 0, 30)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						DropArbt_listimage,
						TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
				end
				dog = not dog
			end
		)
		ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )

			local dropfunc = {}

			function dropfunc:Clear()
				TextLabel_TapDrop.Text = tostring(text).." :"
				for i, v in next, ScolDown:GetChildren() do
					if v:IsA("Frame") then
						v:Destroy()
					end
				end
				ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
			end

			function dropfunc:Add(t)
				local ListFrame = Instance.new("Frame")

				ListFrame.Name = "ListFrame"
				ListFrame.Parent = ScolDown
				ListFrame.BackgroundColor3 =  Color3.fromRGB(22553, 23, 23)-- Color3.fromRGB(249, 53, 139)
				ListFrame.BorderSizePixel = 0
				ListFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
				ListFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				ListFrame.Size = UDim2.new(0, 180, 0, 30) -- UDim2.new(0, 213, 0, 35)
				ListFrame.BackgroundTransparency  = 1
				ListFrame.ClipsDescendants = true

				local TextLabel_TapDro2p = Instance.new("TextLabel")

				TextLabel_TapDro2p.Parent = ListFrame
				TextLabel_TapDro2p.Name =  tostring(t).."Dropdown"
				TextLabel_TapDro2p.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				TextLabel_TapDro2p.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextLabel_TapDro2p.Size =  UDim2.new(0, 180, 0, 30)
				TextLabel_TapDro2p.Font = Enum.Font.SourceSansSemibold
				TextLabel_TapDro2p.Text = tostring(t)
				TextLabel_TapDro2p.TextColor3 = Color3.fromRGB(155, 155, 155)
				TextLabel_TapDro2p.TextSize = 14.000
				TextLabel_TapDro2p.AnchorPoint = Vector2.new(0.5, 0.5)
				TextLabel_TapDro2p.BackgroundTransparency = 1
				TextLabel_TapDro2p.TextXAlignment = Enum.TextXAlignment.Center

				local ButtonDrop2 = Instance.new("TextButton")

				ButtonDrop2.Parent = ListFrame
				ButtonDrop2.Name = "ButtonDrop2"
				ButtonDrop2.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				ButtonDrop2.Size = UDim2.new(0, 213, 0, 30)
				ButtonDrop2.Font = Enum.Font.SourceSansSemibold
				ButtonDrop2.Text = ""
				ButtonDrop2.TextColor3 = Color3.fromRGB(155, 155, 155)
				ButtonDrop2.TextSize = 13.000
			--   ButtonDrop2.AnchorPoint = Vector2.new(0.5, 0.5)
				ButtonDrop2.Position = UDim2.new(0., 0, 0., 0)
				ButtonDrop2.TextXAlignment = Enum.TextXAlignment.Center
				ButtonDrop2.BackgroundTransparency = 1
				ButtonDrop2.TextWrapped = true
				ButtonDrop2.AutoButtonColor = false
				ButtonDrop2.ClipsDescendants = true

				ButtonDrop2.MouseEnter:Connect(function ()
					TweenService:Create(
						TextLabel_TapDro2p,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end)

				ButtonDrop2.MouseLeave:Connect(function ()
					TweenService:Create(
						TextLabel_TapDro2p,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end)

				ButtonDrop2.MouseButton1Click:Connect(function()
					TweenService:Create(
						DropFrame,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 213, 0, 30)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						DropArbt_listimage,
						TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
						{Rotation = 0}
					):Play()
					TextLabel_TapDrop.Text =  text.." : "..tostring(t)
					callback(t)
					dog = not dog
				end
			)

				ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
			end
			return dropfunc

		else

			local location = option.location or self.flags
			local flag = not use and option.flag or ""
			local callback = callback or function() end
			local list = option.list or {}
			local default = list.default or list[1].Name

			if not use then
				location[flag] = default
			end


			local DropFrame = Instance.new("Frame")

			DropFrame.Name = "DropFrame"
			DropFrame.Parent = ScrollingFrame_Pageframe
			DropFrame.BackgroundColor3 =  Color3.fromRGB(23, 23, 23)-- Color3.fromRGB(249, 53, 139)
			DropFrame.BorderSizePixel = 0
			DropFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
			DropFrame.AnchorPoint = Vector2.new(0.5, 0.5)
			DropFrame.Size = UDim2.new(0, 213, 0, 30) -- UDim2.new(0, 213, 0, 35)
			DropFrame.BackgroundTransparency  = 0
			DropFrame.ClipsDescendants = true

			local ConnerDropFrame = Instance.new("UICorner")

			ConnerDropFrame.CornerRadius = UDim.new(0, 4)
			ConnerDropFrame.Name = ""
			ConnerDropFrame.Parent = DropFrame

			local DropFrameStroke = Instance.new("UIStroke")

			DropFrameStroke.Thickness = 1
			DropFrameStroke.Name = ""
			DropFrameStroke.Parent = DropFrame
			DropFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
			DropFrameStroke.Color = Color3.fromRGB(249, 53, 139)
			DropFrameStroke.Transparency = 0.7





			local LabelFrameDrop = Instance.new("TextLabel")

			LabelFrameDrop.Parent = DropFrame
			LabelFrameDrop.Name = "LabelFrameDrop"
			LabelFrameDrop.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
			LabelFrameDrop.Position = UDim2.new(0., 0, 0., 0)
			LabelFrameDrop.Size =    UDim2.new(0, 213, 0, 30)
			LabelFrameDrop.Font = Enum.Font.SourceSansSemibold
			LabelFrameDrop.Text = ""
			LabelFrameDrop.TextColor3 = Color3.fromRGB(155, 155, 155)
			LabelFrameDrop.TextSize = 14.000
		--   LabelFrameDrop.AnchorPoint = Vector2.new(0.5, 0.5)
			LabelFrameDrop.BackgroundTransparency = 1
			LabelFrameDrop.TextXAlignment = Enum.TextXAlignment.Left


			local TextLabel_TapDrop = Instance.new("TextLabel")

			TextLabel_TapDrop.Parent = LabelFrameDrop
			TextLabel_TapDrop.Name = "TextLabel_TapDrop"
			TextLabel_TapDrop.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
			TextLabel_TapDrop.Position = UDim2.new(0.04, 0, 0.14, 0)
			TextLabel_TapDrop.Size =    UDim2.new(0, 140, 0, 20)
			TextLabel_TapDrop.Font = Enum.Font.SourceSansSemibold
			TextLabel_TapDrop.Text = tostring(text).." :"
			TextLabel_TapDrop.TextColor3 = Color3.fromRGB(155, 155, 155)
			TextLabel_TapDrop.TextSize = 14.000
	--     TextLabel_TapDrop.AnchorPoint = Vector2.new(0.5, 0.5)
			TextLabel_TapDrop.BackgroundTransparency = 1
			TextLabel_TapDrop.TextXAlignment = Enum.TextXAlignment.Left


			local DropArbt_listimage = Instance.new("ImageButton")

			DropArbt_listimage.Parent = LabelFrameDrop
			DropArbt_listimage.BackgroundTransparency = 1.000
			DropArbt_listimage.AnchorPoint = Vector2.new(0.5, 0.5)
			DropArbt_listimage.Position = UDim2.new(0.9, 0, 0.5, 0)
			DropArbt_listimage.BorderSizePixel = 0
			DropArbt_listimage.Size = UDim2.new(0, 25, 0, 25)
			DropArbt_listimage.Image = "http://www.roblox.com/asset/?id=6031091004"
			DropArbt_listimage.ImageColor3 = Color3.fromRGB(155, 155, 155)

			local ScolDown = Instance.new("ScrollingFrame")

			ScolDown.Name = "ScolDown"
			ScolDown.Position = UDim2.new(0.02, 0, 1., 0)
			ScolDown.Parent = LabelFrameDrop
			ScolDown.Active = true
			ScolDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ScolDown.BorderSizePixel = 0
			ScolDown.Size = UDim2.new(0, 205, 0, 115)
			ScolDown.ScrollBarThickness = 3
			ScolDown.ClipsDescendants = true
			ScolDown.BackgroundTransparency = 1
			ScolDown.CanvasSize = UDim2.new(0, 0, 0, 2)

			local UIListLayoutlist = Instance.new("UIListLayout")
			local UIPaddinglist = Instance.new("UIPadding")

			UIListLayoutlist.Name = "UIListLayoutlist"
			UIListLayoutlist.Parent = ScolDown
			UIListLayoutlist.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayoutlist.Padding = UDim.new(0, 5)

			UIPaddinglist.Name = "UIPaddinglist"
			UIPaddinglist.Parent = ScolDown
			UIPaddinglist.PaddingTop = UDim.new(0, 5)
			UIPaddinglist.PaddingLeft = UDim.new(0, 12)

			local ButtonDrop = Instance.new("TextButton")

			ButtonDrop.Parent = DropFrame
			ButtonDrop.Name = "ButtonDrop"
			ButtonDrop.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
			ButtonDrop.Size = UDim2.new(0, 213, 0, 30)
			ButtonDrop.Font = Enum.Font.SourceSansSemibold
			ButtonDrop.Text = ""
			ButtonDrop.TextColor3 = Color3.fromRGB(155, 155, 155)
			ButtonDrop.TextSize = 13.000
		--   ButtonDrop.AnchorPoint = Vector2.new(0.5, 0.5)
			ButtonDrop.Position = UDim2.new(0., 0, 0., 0)
			ButtonDrop.TextXAlignment = Enum.TextXAlignment.Center
			ButtonDrop.BackgroundTransparency = 1
			ButtonDrop.TextWrapped = true
			ButtonDrop.AutoButtonColor = false
			ButtonDrop.ClipsDescendants = true

			local dog = false

			local FrameSize = 75
			local cout = 0
			for i , v in pairs(list) do
				cout =cout + 1
				if cout == 1 then
					FrameSize = 75
				elseif cout == 2 then
					FrameSize = 110
				elseif cout >= 3 then
					FrameSize = 150
				end

				local listtog = Instance.new("Frame")

				listtog.Name = "listtog"
				listtog.Parent = ScolDown
				listtog.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
				listtog.BackgroundTransparency =1
				listtog.BorderSizePixel = 0
				listtog.ClipsDescendants = true
				listtog.AnchorPoint = Vector2.new(0.5, 0.5)
				listtog.Position = UDim2.new(0.5, 0, 0.5, 0)
				listtog.Size = UDim2.new(0, 210, 0, 33)


				local listtextbutton = Instance.new("TextButton")

				listtextbutton.Parent = listtog
				listtextbutton.BackgroundTransparency =1
				listtextbutton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
				listtextbutton.BorderSizePixel = 0
				listtextbutton.Size =  UDim2.new(0, 210, 0, 33)
				listtextbutton.AutoButtonColor = false
				listtextbutton.Font = Enum.Font.SourceSans
				listtextbutton.Text = " "
				listtextbutton.TextColor3 = Color3.fromRGB(0, 0, 0)
				listtextbutton.TextSize = 14.000

				local farmtoglist = Instance.new("TextButton")

				farmtoglist.Parent = listtextbutton
				farmtoglist.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				farmtoglist.BorderColor3 = Color3.fromRGB(249, 53, 139)
				farmtoglist.BorderSizePixel = 0
				farmtoglist.AnchorPoint = Vector2.new(0.5, 0.5)
				farmtoglist.Position = UDim2.new(0.1, 0, 0.5, 0)
				farmtoglist.Size = UDim2.new(0, 23, 0, 23)
				farmtoglist.Font = Enum.Font.SourceSans
				farmtoglist.Text = " "
				farmtoglist.TextColor3 = Color3.fromRGB(0, 0, 0)
				farmtoglist.TextSize = 14.000
				farmtoglist.AutoButtonColor = false


				local farmtoglist2 = Instance.new("TextButton")

				farmtoglist2.Parent = farmtoglist
				farmtoglist2.BackgroundColor3 = Color3.fromRGB(32, 32,32)
				farmtoglist2.BorderColor3 = Color3.fromRGB(249, 53, 139)
				farmtoglist2.BorderSizePixel = 0
				farmtoglist2.AnchorPoint = Vector2.new(0.5, 0.5)
				farmtoglist2.Position = UDim2.new(0.5, 0, 0.5, 0)
				farmtoglist2.Size = UDim2.new(0, 21, 0, 21)
				farmtoglist2.Font = Enum.Font.SourceSans
				farmtoglist2.Text = " "
				farmtoglist2.TextColor3 = Color3.fromRGB(0, 0, 0)
				farmtoglist2.TextSize = 14.000
				farmtoglist2.AutoButtonColor = false


				local listimage = Instance.new("ImageButton")

				listimage.Parent = farmtoglist2
				listimage.BackgroundTransparency = 1.000
				listimage.AnchorPoint = Vector2.new(0.5, 0.5)
				listimage.Position = UDim2.new(0.5, 0, 0.5, 0)
				listimage.BorderSizePixel = 0
				listimage.Size = UDim2.new(0, 0, 0, 0)
				listimage.Image = "http://www.roblox.com/asset/?id=5880482965"


				local textlist = Instance.new("TextLabel")


				textlist.Parent = listtextbutton
				textlist.Name = "textlist"
				textlist.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				textlist.BackgroundTransparency = 1.000
				textlist.AnchorPoint = Vector2.new(0.5, 0.5)
				textlist.Position = UDim2.new(0.5, 0, 0.5, 0)
				textlist.BorderSizePixel = 0
				textlist.Size = UDim2.new(0, 91, 0, 25)
				textlist.Font = Enum.Font.GothamSemibold
				textlist.Text = tostring(v.Name)
				textlist.TextColor3 = Color3.fromRGB(255, 255, 255)
				textlist.TextSize = 13.000



				local TextButton_Pageframe_Uiconner2 = Instance.new("UICorner")

				TextButton_Pageframe_Uiconner2.CornerRadius = UDim.new(0, 5)
				TextButton_Pageframe_Uiconner2.Name = ""
				TextButton_Pageframe_Uiconner2.Parent = farmtoglist

				local TextButton_Pageframe_Uiconner22 = Instance.new("UICorner")

				TextButton_Pageframe_Uiconner22.CornerRadius = UDim.new(0, 5)
				TextButton_Pageframe_Uiconner22.Name = ""
				TextButton_Pageframe_Uiconner22.Parent = farmtoglist2



				listtextbutton.MouseButton1Click:Connect(function()
					if not  location[v.flag] then
						listimage:TweenSizeAndPosition(UDim2.new(0, 30, 0, 30), UDim2.new(0.5, 0, 0.5, 0), "In", "Bounce", 0.1, true)
						wait(0.1)
						listimage:TweenSizeAndPosition(UDim2.new(0, 23, 0, 23), UDim2.new(0.5, 0, 0.5, 0), "In", "Bounce", 0.1, true)
					else
						listimage:TweenSizeAndPosition(UDim2.new(0, 30, 0, 30), UDim2.new(0.5, 0, 0.5, 0), "In", "Bounce", 0.1, true)
						wait(0.1)
						listimage:TweenSizeAndPosition(UDim2.new(0, 0, 0, 0), UDim2.new(0.5, 0, 0.5, 0), "In", "Bounce", 0.1, true)
					end
					location[v.flag] = not location[v.flag]
					callback(location[v.flag])
				end
			)

			if  location[v.flag] then
				listimage:TweenSizeAndPosition(UDim2.new(0, 30, 0, 30), UDim2.new(0.5, 0, 0.5, 0), "In", "Bounce", 0.1, true)
				wait(0.1)
				listimage:TweenSizeAndPosition(UDim2.new(0, 23, 0, 23), UDim2.new(0.5, 0, 0.5, 0), "In", "Bounce", 0.1, true)

				callback(location[v.flag])
			end

				ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
			end


			DropFrame.MouseEnter:Connect(function()
				TweenService:Create(
					DropFrameStroke,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					TextLabel_TapDrop,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					DropArbt_listimage,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ImageColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
				):Play()
			end
		)

		DropFrame.MouseLeave:Connect(function()
				TweenService:Create(
					DropFrameStroke,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{Transparency = 0.7} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					TextLabel_TapDrop,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					DropArbt_listimage,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{ImageColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
				):Play()
			end
		)


		ButtonDrop.MouseButton1Click:Connect(function()
			if dog == false then
				TweenService:Create(
					DropFrame,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{Size = UDim2.new(0, 213, 0, FrameSize)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					DropArbt_listimage,
					TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
					{Rotation = -180}
				):Play()
				ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
			else
				TweenService:Create(
					DropFrame,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{Size = UDim2.new(0, 213, 0, 30)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					DropArbt_listimage,
					TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out),
					{Rotation = 0}
				):Play()
				ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )
			end
			dog = not dog
		end
	)
	ScolDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutlist.AbsoluteContentSize.Y + 10  )



			end



			end

			function items:TextBox(text,text2,callback)
				local TextFrame = Instance.new("Frame")

				TextFrame.Name = "TextFrame"
				TextFrame.Parent = ScrollingFrame_Pageframe
				TextFrame.BackgroundColor3 =  Color3.fromRGB(23, 23, 23)
				TextFrame.BorderSizePixel = 0
				TextFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				TextFrame.Size = UDim2.new(0, 213, 0, 70)
				TextFrame.BackgroundTransparency  = 1
				TextFrame.ClipsDescendants = true

				local LabelNameSliderxd = Instance.new("TextLabel")

				LabelNameSliderxd.Parent = TextFrame
				LabelNameSliderxd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelNameSliderxd.BackgroundTransparency = 1
				LabelNameSliderxd.BorderSizePixel = 0
				LabelNameSliderxd.Position = UDim2.new(0.5, 0, 0.2, 0)
				LabelNameSliderxd.AnchorPoint = Vector2.new(0.5, 0.5)
				LabelNameSliderxd.Size = UDim2.new(0, 160, 0, 20)
				LabelNameSliderxd.Font = Enum.Font.GothamBold
				LabelNameSliderxd.Text = tostring(text)
				LabelNameSliderxd.TextColor3 = Color3.fromRGB(155, 155, 155)
				LabelNameSliderxd.TextSize = 11.000
				LabelNameSliderxd.TextXAlignment = Enum.TextXAlignment.Center

				local ConerTextBox = Instance.new("UICorner")

				ConerTextBox.CornerRadius = UDim.new(0, 4)
				ConerTextBox.Name = ""
				ConerTextBox.Parent = TextFrame

				local FrameBox = Instance.new("Frame")

				FrameBox.Name = "TextFrame"
				FrameBox.Parent = TextFrame
				FrameBox.BackgroundColor3 =  Color3.fromRGB(23, 23, 23)
				FrameBox.BorderSizePixel = 0
				FrameBox.Position = UDim2.new(0.5, 0, 0.65, 0)
				FrameBox.AnchorPoint = Vector2.new(0.5, 0.5)
				FrameBox.Size = UDim2.new(0, 158, 0, 30)
				FrameBox.BackgroundTransparency  = 0.2
				FrameBox.ClipsDescendants = true
				FrameBox.AnchorPoint = Vector2.new(0.5, 0.5)

				local TextFrame2 = Instance.new("TextBox")

				TextFrame2.Parent = FrameBox
				TextFrame2.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
				TextFrame2.BorderSizePixel = 0
				TextFrame2.ClipsDescendants = true
				TextFrame2.Position = UDim2.new(0.5, 0, 0.5, 0)
				TextFrame2.AnchorPoint = Vector2.new(0.5, 0.5)
				TextFrame2.Size = UDim2.new(0, 158, 0, 35)
				TextFrame2.Font = Enum.Font.GothamSemibold
				TextFrame2.PlaceholderColor3 = Color3.fromRGB(155, 155, 155)
				TextFrame2.PlaceholderText = text2
				TextFrame2.Text = ""
				TextFrame2.TextColor3 = Color3.fromRGB(155, 155, 155)
				TextFrame2.TextSize = 12.000
				TextFrame2.BackgroundTransparency = 1

				local ConerTextBox2 = Instance.new("UICorner")

				ConerTextBox2.CornerRadius = UDim.new(0, 4)
				ConerTextBox2.Name = ""
				ConerTextBox2.Parent = FrameBox

				local TextBoxStroke = Instance.new("UIStroke")

				TextBoxStroke.Thickness = 1
				TextBoxStroke.Name = ""
				TextBoxStroke.Parent = FrameBox
				TextBoxStroke.LineJoinMode = Enum.LineJoinMode.Round
				TextBoxStroke.Color = Color3.fromRGB(249, 53, 139)
				TextBoxStroke.Transparency = 0.7


				TextFrame.MouseEnter:Connect(function()
					TweenService:Create(
						FrameBox,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 213, 0, 30)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						FrameBox,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 = Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextFrame2,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{PlaceholderColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextFrame2,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						LabelNameSliderxd,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextBoxStroke,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Thickness = 0} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)

			TextFrame.MouseLeave:Connect(function()
				TweenService:Create(
					FrameBox,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{Size = UDim2.new(0, 158, 0, 30)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					FrameBox,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundColor3 = Color3.fromRGB(23, 23, 23)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					TextFrame2,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{PlaceholderColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					TextBoxStroke,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{Thickness = 1} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					LabelNameSliderxd,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
				):Play()
				TweenService:Create(
					TextFrame2,
					TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
				):Play()
			end
			)
				TextFrame2.FocusLost:Connect(function ()
					if #TextFrame2.Text > 0 then
						pcall(callback,TextFrame2.Text)
					end
				end)
			end

			function items:Bind(text,bi,callback)
				local BindFrame = Instance.new("Frame")

				BindFrame.Name = "BindFrame"
				BindFrame.Parent = ScrollingFrame_Pageframe
				BindFrame.BackgroundColor3 =  Color3.fromRGB(23, 23, 23)
				BindFrame.BorderSizePixel = 0
				BindFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
				BindFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				BindFrame.Size = UDim2.new(0, 213, 0, 35)
				BindFrame.BackgroundTransparency  = 0
				BindFrame.ClipsDescendants = true

				local BindConner = Instance.new("UICorner")

				BindConner.CornerRadius = UDim.new(0, 4)
				BindConner.Name = ""
				BindConner.Parent = BindFrame

				local BindStroke = Instance.new("UIStroke")

				BindStroke.Thickness = 1
				BindStroke.Name = ""
				BindStroke.Parent = BindFrame
				BindStroke.LineJoinMode = Enum.LineJoinMode.Round
				BindStroke.Color = Color3.fromRGB(249, 53, 139)
				BindStroke.Transparency = 0.7

				local LabelBind = Instance.new("TextLabel")

				LabelBind.Parent = BindFrame
				LabelBind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelBind.BackgroundTransparency = 1
				LabelBind.BorderSizePixel = 0
				LabelBind.Position = UDim2.new(0.4, 0, 0.5, 0)
				LabelBind.AnchorPoint = Vector2.new(0.5, 0.5)
				LabelBind.Size = UDim2.new(0, 140, 0, 35)
				LabelBind.Font = Enum.Font.GothamBold
				LabelBind.Text = tostring(text)
				LabelBind.TextColor3 = Color3.fromRGB(155, 155, 155)
				LabelBind.TextSize = 11.000
				LabelBind.TextXAlignment = Enum.TextXAlignment.Left

				local key = bi.Name
				local LabelBind2 = Instance.new("TextButton")

				LabelBind2.Parent = BindFrame
				LabelBind2.Name = "LabelBind2"
				LabelBind2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelBind2.Size = UDim2.new(0, 100, 0, 19)
				LabelBind2.Font = Enum.Font.GothamBold
				LabelBind2.Text =  "KEY : "..key
				LabelBind2.TextColor3 = Color3.fromRGB(155, 155, 155)
				LabelBind2.TextSize = 11.000
				LabelBind2.AnchorPoint = Vector2.new(0.5, 0.5)
				LabelBind2.Position = UDim2.new(0.75, 0, 0.5, 0)
				LabelBind2.TextXAlignment = Enum.TextXAlignment.Center
				LabelBind2.BackgroundTransparency = 1
				LabelBind2.TextWrapped = true

				local LabelBind22 = Instance.new("TextButton")

				LabelBind22.Parent = BindFrame
				LabelBind22.Name = "LabelBind22"
				LabelBind22.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LabelBind22.Size = UDim2.new(0, 213, 0, 35)
				LabelBind22.Font = Enum.Font.GothamBold
				LabelBind22.Text =  ""
				LabelBind22.TextColor3 = Color3.fromRGB(155, 155, 155)
				LabelBind22.TextSize = 11.000
				LabelBind22.AnchorPoint = Vector2.new(0.5, 0.5)
				LabelBind22.Position = UDim2.new(0.5, 0, 0.5, 0)
				LabelBind22.TextXAlignment = Enum.TextXAlignment.Center
				LabelBind22.BackgroundTransparency = 1
				LabelBind22.TextWrapped = true

				BindFrame.MouseEnter:Connect(function()
					TweenService:Create(
						BindStroke,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						LabelBind22,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						LabelBind2,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						LabelBind,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)
				BindFrame.MouseLeave:Connect(function()
					TweenService:Create(
						BindStroke,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0.7} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						LabelBind22,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						LabelBind2,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						LabelBind,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
				end
			)

				LabelBind22.MouseButton1Click:Connect(function ()


					LabelBind2.Text = "KEY : ".."..."
					local inputwait = game:GetService("UserInputService").InputBegan:wait()
					local fuckulop = inputwait.KeyCode == Enum.KeyCode.Unknown and inputwait.UserInputType or inputwait.KeyCode

					if
					fuckulop.Name ~= "Focus" and fuckulop.Name ~= "MouseMovement" and fuckulop.Name ~= "Focus"
					then
						LabelBind2.Text =  "KEY : "..fuckulop.Name
						key = fuckulop.Name
					end
					-- if fuckulop.Name ~= "Unknown" then
					--     LabelBind2.Text = fuckulop.Name
					--     key = fuckulop.Name
					-- end

				end)


				game:GetService("UserInputService").InputBegan:connect(
					function(current)
						local fuckulop2 = current.KeyCode == Enum.KeyCode.Unknown and current.UserInputType or current.KeyCode

							if fuckulop2.Name ==  key then
								pcall(callback)

						end
					end
					)

			end

			function items:Line()
				local LineFrame = Instance.new("Frame")

				LineFrame.Name = "LineFrame"
				LineFrame.Parent = ScrollingFrame_Pageframe
				LineFrame.BackgroundColor3 =  Color3.fromRGB(249, 53, 139)
				LineFrame.BorderSizePixel = 0
				LineFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
				LineFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				LineFrame.Size = UDim2.new(0, 213, 0, 1)
				LineFrame.BackgroundTransparency  = 0
				LineFrame.ClipsDescendants = true

				local LineFrame_BindConner = Instance.new("UICorner")

				LineFrame_BindConner.CornerRadius = UDim.new(0, 30)
				LineFrame_BindConner.Name = ""
				LineFrame_BindConner.Parent = LineFrame

			end

			function items:Color(text,preset,callback)
				local Pixker = Instance.new("Frame")

				Pixker.Name = "Pixker"
				Pixker.Parent = ScrollingFrame_Pageframe
				Pixker.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
				Pixker.Position = UDim2.new(0.0833333358, 0, 0.235135213, 0)
				Pixker.Size = UDim2.new(0, 213, 0, 33)
				Pixker.BackgroundTransparency = 0
				Pixker.BorderSizePixel = 0
				Pixker.AnchorPoint = Vector2.new(0.5, 0.5)
				Pixker.Position = UDim2.new(0.5, 0, 0.5, 0)
				Pixker.ClipsDescendants = true


				local BoxColorCorner2 = Instance.new("UICorner")

				BoxColorCorner2.CornerRadius = UDim.new(0, 4)
				BoxColorCorner2.Name = "BoxColorCorner"
				BoxColorCorner2.Parent = Pixker

				local MheeFrameStroke = Instance.new("UIStroke")

				MheeFrameStroke.Thickness = 1
				MheeFrameStroke.Name = ""
				MheeFrameStroke.Parent = Pixker
				MheeFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
				MheeFrameStroke.Color = Color3.fromRGB(249, 53, 139)
				MheeFrameStroke.Transparency = 0.7


				local TextFrameColor = Instance.new("TextLabel")

				TextFrameColor.Parent = Pixker
				TextFrameColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextFrameColor.BorderSizePixel = 0
				TextFrameColor.Size = UDim2.new(0, 200, 0, 34)
				TextFrameColor.Font = Enum.Font.SourceSans
				TextFrameColor.Text = "  "
				TextFrameColor.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextFrameColor.TextSize = 14.000
				TextFrameColor.BackgroundTransparency = 1
				TextFrameColor.Position = UDim2.new(0., 0, 0., 0)

				local TextReal = Instance.new("TextLabel")

				TextReal.Parent = TextFrameColor
				TextReal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextReal.BorderSizePixel = 0
				TextReal.Size = UDim2.new(0, 140, 0, 34)
				TextReal.Font = Enum.Font.GothamSemibold
				TextReal.Text = text
				TextReal.TextColor3 = Color3.fromRGB(155,155, 155)
				TextReal.TextSize = 12.000
				TextReal.BackgroundTransparency = 1
				TextReal.Position = UDim2.new(0.05, 0, 0., 0)
				TextReal.TextXAlignment = Enum.TextXAlignment.Left

				local BoxColor = Instance.new("Frame")

				BoxColor.Name = "BoxColor"
				BoxColor.Parent = TextFrameColor
				BoxColor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				BoxColor.Position = UDim2.new(0.85, 0, 0.5, 0)
				BoxColor.Size = UDim2.new(0, 35, 0, 19)
				BoxColor.AnchorPoint = Vector2.new(0.5, 0.5)

				local BoxColorCorner = Instance.new("UICorner")

				BoxColorCorner.CornerRadius = UDim.new(0, 4)
				BoxColorCorner.Name = "BoxColorCorner"
				BoxColorCorner.Parent = BoxColor

				local TextButton_Dropdown = Instance.new("TextButton")


				TextButton_Dropdown.Parent = TextFrameColor
				TextButton_Dropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				TextButton_Dropdown.BorderSizePixel = 0
				TextButton_Dropdown.Position = UDim2.new(0., 0, 0.14705883, 0)
				TextButton_Dropdown.Size = UDim2.new(0, 200, 0, 33)
				TextButton_Dropdown.Font = Enum.Font.SourceSans
				TextButton_Dropdown.Text = "  "
				TextButton_Dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton_Dropdown.TextSize = 14.000
				TextButton_Dropdown.AutoButtonColor = false
				--TextButton_Dropdown.AnchorPoint = Vector2.new(0.5, 0.5)
				TextButton_Dropdown.Position = UDim2.new(0, 0, 0, 0)
				TextButton_Dropdown.BackgroundTransparency = 1



				Pixker.MouseEnter:Connect(function()
					TweenService:Create(
						MheeFrameStroke,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0.}
					):Play()
					TweenService:Create(
						TextReal,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255,255, 255)}
					):Play()

				end)
				Pixker.MouseLeave:Connect(function()
					TweenService:Create(
						MheeFrameStroke,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency = 0.7}
					):Play()
					TweenService:Create(
						TextReal,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(155,155, 155)}
					):Play()
				end)
			-- Rainbow Toggle


			local TextButton_2_Toggle = Instance.new("TextButton")

			TextButton_2_Toggle.Parent = TextFrameColor
			TextButton_2_Toggle.BackgroundColor3 = Color3.fromRGB(155, 155, 155)
	--        TextButton_2_Toggle.BorderColor3 = Color3.fromRGB(249, 53, 139)
			TextButton_2_Toggle.BorderSizePixel = 0
			TextButton_2_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
			TextButton_2_Toggle.Position = UDim2.new(0.2, 0, 1.87, 0)
			TextButton_2_Toggle.Size = UDim2.new(0, 30, 0, 13)
			TextButton_2_Toggle.Font = Enum.Font.SourceSans
			TextButton_2_Toggle.Text = " "
			TextButton_2_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextButton_2_Toggle.TextSize = 12.000
			TextButton_2_Toggle.AutoButtonColor = false

			local TextButton_Pageframe_Uiconner = Instance.new("UICorner")

			TextButton_Pageframe_Uiconner.CornerRadius = UDim.new(0, 30)
			TextButton_Pageframe_Uiconner.Name = ""
			TextButton_Pageframe_Uiconner.Parent = TextButton_2_Toggle

			local TextButton_3_Toggle = Instance.new("TextButton")

			TextButton_3_Toggle.Parent = TextButton_2_Toggle
			TextButton_3_Toggle.BackgroundColor3 = Color3.fromRGB(255, 255,255)
	--        TextButton_3_Toggle.BorderColor3 = Color3.fromRGB(249, 53, 139)
			TextButton_3_Toggle.BorderSizePixel = 0
			TextButton_3_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
			TextButton_3_Toggle.Position = UDim2.new(0.1, 0, 0.5, 0)
			TextButton_3_Toggle.Size = UDim2.new(0, 19, 0, 19)
			TextButton_3_Toggle.Font = Enum.Font.SourceSans
			TextButton_3_Toggle.Text = " "
			TextButton_3_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextButton_3_Toggle.TextSize = 12.000
			TextButton_3_Toggle.AutoButtonColor = false

			local TextButton_Pageframe_Uiconner2 = Instance.new("UICorner")

			TextButton_Pageframe_Uiconner2.CornerRadius = UDim.new(0, 30)
			TextButton_Pageframe_Uiconner2.Name = ""
			TextButton_Pageframe_Uiconner2.Parent = TextButton_3_Toggle

			local TextButton_4_Toggle = Instance.new("TextButton")

			TextButton_4_Toggle.Parent = TextButton_3_Toggle
			TextButton_4_Toggle.BackgroundColor3 = Color3.fromRGB(155, 155,155)
	--        TextButton_3_Toggle.BorderColor3 = Color3.fromRGB(249, 53, 139)
			TextButton_4_Toggle.BorderSizePixel = 0
			TextButton_4_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
			TextButton_4_Toggle.Position = UDim2.new(0.5, 0, 0.5, 0)
			TextButton_4_Toggle.Size = UDim2.new(0, 27, 0, 27-2)
			TextButton_4_Toggle.Font = Enum.Font.SourceSans
			TextButton_4_Toggle.Text = " "
			TextButton_4_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextButton_4_Toggle.TextSize = 12.000
			TextButton_4_Toggle.AutoButtonColor = false
			TextButton_4_Toggle.BackgroundTransparency = 1
			TextButton_4_Toggle.Visible = true

			local TextButton_Pageframe_Uiconner4 = Instance.new("UICorner")

			TextButton_Pageframe_Uiconner4.CornerRadius = UDim.new(0, 30)
			TextButton_Pageframe_Uiconner4.Name = ""
			TextButton_Pageframe_Uiconner4.Parent = TextButton_4_Toggle


			local TextButton_Toggle = Instance.new("TextButton")

			TextButton_Toggle.Parent = ValueFrame
			TextButton_Toggle.BackgroundTransparency =1
			TextButton_Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TextButton_Toggle.BorderSizePixel = 0
			TextButton_Toggle.Size = UDim2.new(0, 50, 0, 20)
			TextButton_Toggle.AutoButtonColor = false
			TextButton_Toggle.Font = Enum.Font.SourceSans
			TextButton_Toggle.Text = " "
			TextButton_Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
			TextButton_Toggle.TextSize = 12.000
			TextButton_Toggle.AnchorPoint = Vector2.new(0.5, 0.5)
			TextButton_Toggle.Position = UDim2.new(1.25, 0, 0.4, 0)

			local TextButton_3_Toggle2 = Instance.new("TextLabel")

			TextButton_3_Toggle2.Parent = TextButton_2_Toggle
			TextButton_3_Toggle2.BackgroundColor3 = Color3.fromRGB(32, 32,32)
			TextButton_3_Toggle2.BorderColor3 = Color3.fromRGB(249, 53, 139)
			TextButton_3_Toggle2.BorderSizePixel = 0
			TextButton_3_Toggle2.AnchorPoint = Vector2.new(0.5, 0.5)
			TextButton_3_Toggle2.Position = UDim2.new(1.9, 0, 0.5, 0)
			TextButton_3_Toggle2.Size = UDim2.new(0, 500, 0, 21)
			TextButton_3_Toggle2.Font = Enum.Font.SourceSansBold
			TextButton_3_Toggle2.Text = "Rainbow"
			TextButton_3_Toggle2.TextColor3 = Color3.fromRGB(255, 255, 255)
			TextButton_3_Toggle2.TextSize = 13.000
			TextButton_3_Toggle2.BackgroundTransparency = 1

			local OMF = Instance.new("TextButton")

			OMF.Parent = TextButton_2_Toggle
			OMF.BackgroundTransparency =1
			OMF.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			OMF.BorderSizePixel = 0
			OMF.Size = UDim2.new(0, 100, 0, 20)
			OMF.AutoButtonColor = false
			OMF.Font = Enum.Font.SourceSans
			OMF.Text = " "
			OMF.TextColor3 = Color3.fromRGB(0, 0, 0)
			OMF.TextSize = 12.000
			OMF.AnchorPoint = Vector2.new(0.5, 0.5)
			OMF.Position = UDim2.new(1.3, 0, 0.5, 0)

			local Color =  Instance.new("ImageLabel")

			Color.Name = "Color"
			Color.Parent = TextFrameColor
			Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
			Color.Position = UDim2.new(0.05,0,4,0)
			Color.Size = UDim2.new(0, 195, 0, 40)
			Color.ZIndex = 0
			Color.BorderSizePixel = 0
			Color.Image = "rbxassetid://4155801252"

			local ColorFucj = Instance.new("UICorner")

			ColorFucj.CornerRadius = UDim.new(0, 4)
			ColorFucj.Name = ""
			ColorFucj.Parent = Color

			local ColorSelection =  Instance.new("ImageLabel")

			ColorSelection.Name = "ColorSelection"
			ColorSelection.Parent = Color
			ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
			ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ColorSelection.BackgroundTransparency = 1.000
			ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
			ColorSelection.Size = UDim2.new(0, 18, 0, 18)
			ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
			ColorSelection.ScaleType = Enum.ScaleType.Fit
			ColorSelection.Visible = true

			local Hue =  Instance.new("ImageLabel")

			Hue.Name = "Hue2"
			Hue.Parent = TextFrameColor
			Hue.Position = UDim2.new(0.14,0,3,0)
			Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Hue.Size = UDim2.new(0, 160, 0, 25)
			Hue.ZIndex = 0
			Hue.BorderSizePixel = 0

			local ColorFucj2 = Instance.new("UICorner")

			ColorFucj2.CornerRadius = UDim.new(0, 4)
			ColorFucj2.Name = ""
			ColorFucj2.Parent = Hue

			local HueGradient = Instance.new("UIGradient")

			HueGradient.Color = ColorSequence.new {
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
				ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
				ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
				ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
				ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
				ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
			}
			HueGradient.Rotation = 0
			HueGradient.Name = "HueGradient"
			HueGradient.Parent = Hue

			local HueSelection =  Instance.new("ImageLabel")

			HueSelection.Name = "HueSelection"
			HueSelection.Parent = Hue
			HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
			HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			HueSelection.BackgroundTransparency = 1.000
			HueSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
			HueSelection.Size = UDim2.new(0, 18, 0, 18)
			HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
			HueSelection.ScaleType = Enum.ScaleType.Fit
			HueSelection.Visible = true


			local BTN_XD = Instance.new("TextButton")

			BTN_XD.Parent = TextFrameColor
			BTN_XD.BackgroundColor3 = Color3.fromRGB(249, 53, 139)
			BTN_XD.BorderColor3 = Color3.fromRGB(249, 53, 139)
			BTN_XD.BorderSizePixel = 0
			BTN_XD.AnchorPoint = Vector2.new(0.5, 0.5)
			BTN_XD.Position = UDim2.new(0.8, 0, 1.9, 0)
			BTN_XD.Size = UDim2.new(0, 50, 0, 25)
			BTN_XD.Font = Enum.Font.GothamSemibold
			BTN_XD.Text = "Confirm"
			BTN_XD.TextColor3 = Color3.fromRGB(255, 255, 255)
			BTN_XD.TextSize = 11.000
			BTN_XD.AutoButtonColor = false

			local BTN_XD_COnner = Instance.new("UICorner")

			BTN_XD_COnner.CornerRadius = UDim.new(0, 4)
			BTN_XD_COnner.Name = ""
			BTN_XD_COnner.Parent = BTN_XD



			local MheeFrameStroke = Instance.new("UIStroke")

			MheeFrameStroke.Thickness = 1
			MheeFrameStroke.Name = ""
			MheeFrameStroke.Parent = BTN_XD
			MheeFrameStroke.LineJoinMode = Enum.LineJoinMode.Round
			MheeFrameStroke.Color = Color3.fromRGB(249, 53, 139)
			MheeFrameStroke.Transparency = 0.7


			local UwU = false


			OMF.MouseButton1Click:Connect(function()
				if       UwU == false  then
					TweenService:Create(
						TextButton_4_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextButton_3_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(249, 53, 139)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextButton_2_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(153, 0, 102)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TextButton_3_Toggle:TweenSizeAndPosition(UDim2.new(0, 19, 0, 19), UDim2.new(1, 0, 0.5, 0), "Out", "Quad", 0.3, true)
				else
					TweenService:Create(
						TextButton_4_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextButton_3_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(255, 255, 255)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TweenService:Create(
						TextButton_2_Toggle,
						TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{BackgroundColor3 =  Color3.fromRGB(155, 155, 155)} -- UDim2.new(0, 128, 0, 25)
					):Play()
					TextButton_3_Toggle:TweenSizeAndPosition(UDim2.new(0, 19, 0, 19), UDim2.new(0.1, 0, 0.5, 0), "Out", "Quad", 0.3, true)
				end
				UwU = not UwU
			end
		)


		OMF.MouseEnter:Connect(function()
				TweenService:Create(
					TextButton_4_Toggle,
					TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 0.6} -- UDim2.new(0, 128, 0, 25)
				):Play()
			end
		)

		OMF.MouseLeave:Connect(function()
				TweenService:Create(
					TextButton_4_Toggle,
					TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
					{BackgroundTransparency = 1} -- UDim2.new(0, 128, 0, 25)
				):Play()
			end
		)

		OMF.MouseButton1Down:Connect(
				function()
					RainbowColorPicker = not RainbowColorPicker

					if ColorInput then
						ColorInput:Disconnect()
					end

					if HueInput then
						HueInput:Disconnect()
					end

					if RainbowColorPicker then


						OldToggleColor = BoxColor.BackgroundColor3
						OldColor = Color.BackgroundColor3
						OldColorSelectionPosition = ColorSelection.Position
						OldHueSelectionPosition = HueSelection.Position

						while RainbowColorPicker do
							BoxColor.BackgroundColor3 = Color3.fromHSV(Red.RainbowColorValue, 1, 1)
							Color.BackgroundColor3 = Color3.fromHSV(Red.RainbowColorValue, 1, 1)

							ColorSelection.Position = UDim2.new(1, 0, 0, 0)
							HueSelection.Position = UDim2.new(0,  Red.HueSelectionPosition, 0.5,0)

							pcall(callback, BoxColor.BackgroundColor3)
							wait()
						end
					elseif not RainbowColorPicker then

						BoxColor.BackgroundColor3 = OldToggleColor
						Color.BackgroundColor3 = OldColor

						ColorSelection.Position = OldColorSelectionPosition
						HueSelection.Position = OldHueSelectionPosition

						pcall(callback, BoxColor.BackgroundColor3)
					end
				end
			)
			TextButton_3_Toggle.MouseButton1Down:Connect(
				function()
					RainbowColorPicker = not RainbowColorPicker

					if ColorInput then
						ColorInput:Disconnect()
					end

					if HueInput then
						HueInput:Disconnect()
					end

					if RainbowColorPicker then


						OldToggleColor = BoxColor.BackgroundColor3
						OldColor = Color.BackgroundColor3
						OldColorSelectionPosition = ColorSelection.Position
						OldHueSelectionPosition = HueSelection.Position

						while RainbowColorPicker do
							BoxColor.BackgroundColor3 = Color3.fromHSV(Red.RainbowColorValue, 1, 1)
							Color.BackgroundColor3 = Color3.fromHSV(Red.RainbowColorValue, 1, 1)

							ColorSelection.Position = UDim2.new(1, 0, 0, 0)
							HueSelection.Position = UDim2.new(0,  Red.HueSelectionPosition, 0.5,0)

							pcall(callback, BoxColor.BackgroundColor3)
							wait()
						end
					elseif not RainbowColorPicker then

						BoxColor.BackgroundColor3 = OldToggleColor
						Color.BackgroundColor3 = OldColor

						ColorSelection.Position = OldColorSelectionPosition
						HueSelection.Position = OldHueSelectionPosition

						pcall(callback, BoxColor.BackgroundColor3)
					end
				end
			)


			local function UpdateColorPicker(nope)
				BoxColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
				Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

				pcall(callback, BoxColor.BackgroundColor3)
			end
			ColorH =
			1 -
			(math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
				Hue.AbsoluteSize.Y)
			ColorS =
				(math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
					Color.AbsoluteSize.X)
			ColorV =
				1 -
				(math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
					Color.AbsoluteSize.Y)

			BoxColor.BackgroundColor3 = preset
			Color.BackgroundColor3 = preset
			pcall(callback, BoxColor.BackgroundColor3)

			local RainbowColorPicker = false

			Color.InputBegan:Connect(
				function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						if RainbowColorPicker then
							return
						end

						if ColorInput then
							ColorInput:Disconnect()
						end

						ColorInput =
							RunService.RenderStepped:Connect(
								function()
								local ColorX =
									(math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
										Color.AbsoluteSize.X)
								local ColorY =
									(math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
										Color.AbsoluteSize.Y)

								ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
								ColorS = ColorX
								ColorV = 1 - ColorY

								UpdateColorPicker(true)
							end
							)
					end
				end
			)


				Color.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if ColorInput then
								ColorInput:Disconnect()
							end
						end
					end
				)

				Hue.InputBegan:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if RainbowColorPicker then
								return
							end

							if HueInput then
								HueInput:Disconnect()
							end

							HueInput =
								RunService.RenderStepped:Connect(
									function()
									local HueY =
										(math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
											Hue.AbsoluteSize.Y)
									local HueX =
										(math.clamp(Mouse.X- Hue.AbsolutePosition.X, 0, Hue.AbsoluteSize.X) /
											Hue.AbsoluteSize.X)

									HueSelection.Position = UDim2.new(HueX, 0, HueY, 0)
									ColorH = 1 - HueY

									UpdateColorPicker(true)
								end
								)
						end
					end
				)

				Hue.InputEnded:Connect(
					function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							if HueInput then
								HueInput:Disconnect()
							end
						end
					end
				)
				local sk = false
				TextButton_Dropdown.MouseButton1Click:Connect(function()
					if sk == false then
					TweenService:Create(
						Pixker,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 213, 0, 180)}
					):Play()
				else
					TweenService:Create(
						Pixker,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.new(0, 213, 0, 33)}
					):Play()
				end
				sk = not sk
				end
			)
				BTN_XD.MouseButton1Click:Connect(
					function()
						TweenService:Create(
							Pixker,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
							{Size = UDim2.new(0, 213, 0, 33)}
						):Play()
						sk = not sk
					end
				)


			end
			function items:Label(text,image)
				if image == nil then
					image = "6031229361"
				end
				local labaelchange = {}
				local LabelFrame = Instance.new("Frame")


				LabelFrame.Name = "Mainframenoti"
				LabelFrame.Parent = ScrollingFrame_Pageframe
				LabelFrame.BackgroundColor3 = Color3.fromRGB(23, 23, 23)
				LabelFrame.BackgroundTransparency = 0
				LabelFrame.BorderSizePixel = 0
				LabelFrame.ClipsDescendants = false
				LabelFrame.AnchorPoint = Vector2.new(0.5, 0.5)
				LabelFrame.Position = UDim2.new(0.498, 0, 0.5, 0)
				LabelFrame.Size = UDim2.new(0, 213, 0, 28)

				local LabelFarm2 = Instance.new("TextLabel")

				LabelFarm2.Parent = LabelFrame
				LabelFarm2.Name = "TextLabel_Tap"
				LabelFarm2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				LabelFarm2.Size =UDim2.new(0, 130, 0,24 )
				LabelFarm2.Font = Enum.Font.SourceSansSemibold
				LabelFarm2.Text = text
				LabelFarm2.TextColor3 = Color3.fromRGB(255, 255, 255)
				LabelFarm2.TextSize = 12.000
				LabelFarm2.AnchorPoint = Vector2.new(0.5, 0.5)
				LabelFarm2.Position = UDim2.new(0.5, 0, 0.5, 0)
				LabelFarm2.TextXAlignment = Enum.TextXAlignment.Center
				LabelFarm2.BackgroundTransparency = 1
				LabelFarm2.TextWrapped = true

				local ImageLabel_gx = Instance.new("ImageLabel")

				ImageLabel_gx.Parent = LabelFrame
				ImageLabel_gx.BackgroundTransparency = 1.000
				ImageLabel_gx.BorderSizePixel = 0
				ImageLabel_gx.Size = UDim2.new(0, 18, 0, 18)
				ImageLabel_gx.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageLabel_gx.Position = UDim2.new(0.06, 0, 0.45, 0)
				ImageLabel_gx.Image = "http://www.roblox.com/asset/?id="..tostring(image)
				ImageLabel_gx.BackgroundTransparency = 1

				local noticore55 = Instance.new("UICorner")

				noticore55.CornerRadius = UDim.new(0, 4)
				noticore55.Name = ""
				noticore55.Parent = LabelFarm2

				local noticore2777 = Instance.new("UICorner")

				noticore2777.CornerRadius = UDim.new(0, 4)
				noticore2777.Name = ""
				noticore2777.Parent = LabelFrame

				local LabelStroke = Instance.new("UIStroke")

				LabelStroke.Thickness = 1
				LabelStroke.Name = ""
				LabelStroke.Parent = LabelFrame
				LabelStroke.LineJoinMode = Enum.LineJoinMode.Round
				LabelStroke.Color = Color3.fromRGB(249, 53, 139)
				LabelStroke.Transparency = 0.7

				LabelFrame.MouseEnter:Connect(function()
					TweenService:Create(
						LabelStroke,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency =0}
					):Play()
				end
			)
				LabelFrame.MouseLeave:Connect(function()
					TweenService:Create(
						LabelStroke,
						TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Transparency =0.7}
					):Play()
				end
			)
				function labaelchange:Change(text2)
					LabelFarm2.Text = text2
				end
				return  labaelchange
			end
			return  items
			end
		return  page
		end
	return top
	end

  -- Kirainc Hub SourceCode Kaitun Farm

  -- Auto Equip Melee

		spawn(function()
		while wait() do
		if _G.AutoFarm then
				pcall(function()
				while wait() do
				for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
				   if v.ToolTip == "Melee" then
				  if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
					  local ToolSe = tostring(v.Name)
					 local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
					 wait(.4)
					 game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
				  end
				   end
				end
			   end
			end)
		end
		end
		end)

-- AutoHaki

spawn(function()
    while wait(.1) do
        if _G.AutoFarm then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

-- RedeemCode

spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoFarm then
                function UseCode(Text)
                    game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
                end
                UseCode("EXP_5B")
                UseCode("kittgaming")
                UseCode("Sub2Fer999")
                UseCode("Enyu_is_Pro")
                UseCode("Magicbus")
                UseCode("JCWK")
                UseCode("Starcodeheo")
                UseCode("Bluxxy")
                UseCode("fudd10_v2")
                UseCode("FUDD10")
                UseCode("BIGNEWS")
                UseCode("THEGREATACE")
                UseCode("SUB2GAMERROBOT_EXP1")
                UseCode("Sub2OfficialNoobie")
                UseCode("StrawHatMaine")
                UseCode("SUB2NOOBMASTER123")
                UseCode("Sub2Daigrock")
                UseCode("Axiore")
                UseCode("TantaiGaming")
            end
        end
    end)
end)
	
	local plr = game.Players.LocalPlayer
	local CbFw = getupvalues(require(plr.PlayerScripts.CombatFramework))
	local CbFw2 = CbFw[2]
	
	function GetCurrentBlade() 
		local p13 = CbFw2.activeController
		local ret = p13.blades[1]
		if not ret then return end
		while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
		return ret
	end
	
	function AttackNoCD()
		if not Auto_Farm_Bounty and not Auto_Farm_Fruit or Mix_Farm then
			if not Auto_Raid then
				local AC = CbFw2.activeController
				for i = 1, 1 do 
					local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
						plr.Character,
						{plr.Character.HumanoidRootPart},
						60
					)
					local cac = {}
					local hash = {}
					for k, v in pairs(bladehit) do
						if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
							table.insert(cac, v.Parent.HumanoidRootPart)
							hash[v.Parent] = true
						end
					end
					bladehit = cac
					if #bladehit > 0 then
						local u8 = debug.getupvalue(AC.attack, 5)
						local u9 = debug.getupvalue(AC.attack, 6)
						local u7 = debug.getupvalue(AC.attack, 4)
						local u10 = debug.getupvalue(AC.attack, 7)
						local u12 = (u8 * 798405 + u7 * 727595) % u9
						local u13 = u7 * 798405
						(function()
							u12 = (u12 * u9 + u13) % 1099511627776
							u8 = math.floor(u12 / u9)
							u7 = u12 - u8 * u9
						end)()
						u10 = u10 + 1
						debug.setupvalue(AC.attack, 5, u8)
						debug.setupvalue(AC.attack, 6, u9)
						debug.setupvalue(AC.attack, 4, u7)
						debug.setupvalue(AC.attack, 7, u10)
						pcall(function()
							if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then
								AC.animator.anims.basic[1]:Play(0.01,0.01,0.01)
								game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
								game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
								game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
							end
						end)
					end
				end
			end
		end
		if Auto_Farm_Bounty or Auto_Farm_Fruit and not Mix_Farm then
			local Fast = getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))
			local Lop = Fast[2]
			Lop.activeController.timeToNextAttack = (-math.huge^math.huge*math.huge)
			Lop.activeController.attacking = false
			Lop.activeController.timeToNextBlock = 0
			Lop.activeController.humanoid.AutoRotate = 80
			Lop.activeController.increment = 3
			Lop.activeController.blocking = false
			Lop.activeController.hitboxMagnitude = 80
		end
	end

	-- Auto NextSea

	spawn(function()
        while wait() do
            if _G.Auto_New_World then
                pcall(function()
                    if game.Players.LocalPlayer.Data.Level.Value >= 700 and World1 then
                        _G.AutoFarm = false
                        if game.Workspace.Map.Ice.Door.CanCollide == true and game.Workspace.Map.Ice.Door.Transparency == 0 then
                            repeat wait() getgenv().ToTarget(CFrame.new(4851.8720703125, 5.6514348983765, 718.47094726563)) until (CFrame.new(4851.8720703125, 5.6514348983765, 718.47094726563).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.Auto_New_World
                            wait(1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
                            EquipWeapon("Key")
                            local pos2 = CFrame.new(1347.7124, 37.3751602, -1325.6488)
                            repeat wait() getgenv().ToTarget(pos2) until (pos2.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.Auto_New_World
                            wait(3)
                        elseif game.Workspace.Map.Ice.Door.CanCollide == false and game.Workspace.Map.Ice.Door.Transparency == 1 then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral [Lv. 700] [Boss]") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Ice Admiral [Lv. 700] [Boss]" and v.Humanoid.Health > 0 then
                                        repeat wait()
                                            AutoHaki()
                                            EquipWeapon(_G.Select_Weapon)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            getgenv().ToTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,_G.Select_Distance,0))
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 870),workspace.CurrentCamera.CFrame)
                                        until v.Humanoid.Health <= 0 or not v.Parent or not _G.Auto_New_World
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                                    end
                                end
                            else
                                getgenv().ToTarget(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                            end
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                        end
                    end
                end)
            end
        end
    end)

    -- Auto Buy All Haki

					spawn(function()
						pcall(function()
							while wait() do
								if _G.AutoFarm then
									local args = {
										[1] = "BuyHaki",
										[2] = "Geppo"
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
							end
						end)
					end)
					spawn(function()
						pcall(function()
							while wait() do
								if _G.AutoFarm then
									local args = {
										[1] = "BuyHaki",
										[2] = "Buso"
									}
							
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
							end
						end)
					end)
					spawn(function()
						pcall(function()
							while wait() do
								if _G.AutoFarm then
									local args = {
										[1] = "BuyHaki",
										[2] = "Soru"
									}
									game:GetService("ReplicatedStorage I").Remotes.CommF_:InvokeServer(unpack(args))
								end
							end
						end)
					end)

	-- AutoSaber

	spawn(function()
		while wait() do
			if _G.Auto_Saber then
				if game.Players.localPlayer.Data.Level.Value < 200 then
					_G.AutoFarm = false
				else
					if game.Workspace.Map.Jungle.Final.Part.CanCollide == false then
						if _G.Auto_Saber and game.ReplicatedStorage:FindFirstChild("Saber Expert [Lv. 200] [Boss]") or game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
							if game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == "Saber Expert [Lv. 200] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												AutoHaki()
												EquipWeapon(_G.Select_Weapon)
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
												game:GetService'VirtualUser':CaptureController()
												game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
											end
										until not _G.Auto_Saber or not v.Parent or v.Humanoid.Health <= 0
									end
								end
							else
								Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
								if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
									if Questtween then
										Questtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
								end
							end
						else
							if _G.Auto_Saber_Hop then
								Hop()
							end
						end
					elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") and game.Players.localPlayer.Data.Level.Value >= 200 then
						EquipWeapon("Relic")
						wait(0.5)
						Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
						if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
						end
					else
						if Workspace.Map.Jungle.QuestPlates.Door.CanCollide == false then
							if game.Workspace.Map.Desert.Burn.Part.CanCollide == false then
								if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") == 0 then
									if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
										if game.Workspace.Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
											for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
												if _G.Auto_Saber and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Mob Leader [Lv. 120] [Boss]" then
													repeat
														pcall(function() wait() 
															if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
																Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
															elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
																if Farmtween then
																	Farmtween:Stop()
																end
																AutoHaki()
																EquipWeapon(_G.Select_Weapon)
																if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
																	local args = {
																		[1] = "Buso"
																	}
																	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
																end
																game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
																game:GetService'VirtualUser':CaptureController()
																game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
															end
														end)
													until not _G.Auto_Saber or not v.Parent or v.Humanoid.Health <= 0
												end
											end
										else
											Questtween = toTarget(CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position,CFrame.new(-2848.59399, 7.4272871, 5342.44043))
											if (CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.928248107)
											end
										end
									elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
										if game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") then
											EquipWeapon("Relic")
											wait(0.5)
											Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
											if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055)
											end
										else
											Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624).Position,CFrame.new(-910.979736, 13.7520342, 4078.14624))
											if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624, 0.00685182028, -1.53155766e-09, -0.999976516, 9.15205245e-09, 1, -1.46888401e-09, 0.999976516, -9.14177267e-09, 0.00685182028)
												wait(.5)
												local args = {
													[1] = "ProQuestProgress",
													[2] = "RichSon"
												}
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
											end
										end
									else
										Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624).Position,CFrame.new(-910.979736, 13.7520342, 4078.14624))
										if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Questtween then
												Questtween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624)
											local args = {
												[1] = "ProQuestProgress",
												[2] = "RichSon"
											}
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
									end
								else
									if game.Players.LocalPlayer.Backpack:FindFirstChild("Cup") or game.Players.LocalPlayer.Character:FindFirstChild("Cup") then
										EquipWeapon("Cup")
										if game.Players.LocalPlayer.Character.Cup.Handle:FindFirstChild("TouchInterest") then
											Questtween = toTarget(CFrame.new(1397.229, 37.3480148, -1320.85217).Position,CFrame.new(1397.229, 37.3480148, -1320.85217))
											if (CFrame.new(1397.229, 37.3480148, -1320.85217).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1397.229, 37.3480148, -1320.85217, -0.11285457, 2.01368788e-08, 0.993611455, 1.91641178e-07, 1, 1.50028845e-09, -0.993611455, 1.90586206e-07, -0.11285457)
											end
										else
											wait(0.5)
											if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
												local args = {
													[1] = "ProQuestProgress",
													[2] = "SickMan"
												}
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
											end
										end
									else
										Questtween = toTarget(game.Workspace.Map.Desert.Cup.Position,game.Workspace.Map.Desert.Cup.CFrame)
										if (game.Workspace.Map.Desert.Cup.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Questtween then
												Questtween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Desert.Cup.CFrame
										end
										-- firetouchinterest(game.Workspace.Map.Desert.Cup.TouchInterest,game.Players.LocalPlayer.Character.Head, 1)
									end
								end
							else
								if game.Players.LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
									EquipWeapon("Torch")
									Questtween = toTarget(CFrame.new(1114.87708, 4.9214654, 4349.8501).Position,CFrame.new(1114.87708, 4.9214654, 4349.8501))
									if (CFrame.new(1114.87708, 4.9214654, 4349.8501).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1114.87708, 4.9214654, 4349.8501, -0.612586915, -9.68697833e-08, 0.790403247, -1.2634203e-07, 1, 2.4638446e-08, -0.790403247, -8.47679615e-08, -0.612586915)
									end
								else
									Questtween = toTarget(CFrame.new(-1610.00757, 11.5049858, 164.001587).Position,CFrame.new(-1610.00757, 11.5049858, 164.001587))
									if (CFrame.new(-1610.00757, 11.5049858, 164.001587).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408)
									end
								end
							end
						else
							for i,v in pairs(Workspace.Map.Jungle.QuestPlates:GetChildren()) do
								if v:IsA("Model") then wait()
									if v.Button.BrickColor ~= BrickColor.new("Camo") then
										repeat wait()
											Questtween = toTarget(v.Button.Position,v.Button.CFrame)
											if (v.Button.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Button.CFrame
											end
										until not _G.Auto_Saber or v.Button.BrickColor == BrickColor.new("Camo")
									end
								end
							end    
						end
					end
				end 
			end
		end
	end)
	
	-- Mob
	
	task.spawn(function()
		while true do wait()
			if setscriptable then
				setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
			end
			if sethiddenproperty then
				sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
			end
		end
	end)
	
	task.spawn(function()
		while task.wait() do
			pcall(function()
				if StartMagnet then
					for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
						if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
							if InMyNetWork(v.HumanoidRootPart) then
								v.HumanoidRootPart.CFrame = PosMon
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								v.HumanoidRootPart.Size = Vector3.new(60,60,60)
								v.HumanoidRootPart.Transparency = 1
								v.HumanoidRootPart.CanCollide = false
								v.Head.CanCollide = false
								if v.Humanoid:FindFirstChild("Animator") then
									v.Humanoid.Animator:Destroy()
								end
								v.Humanoid:ChangeState(11)
								v.Humanoid:ChangeState(14)
							end
						end
					end
				end
			end)
		end
	end)

	-- Hit Melee

    local Client = game.Players.LocalPlayer
    local PC = require(Client.PlayerScripts.CombatFramework.Particle)
    local RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
    if not shared.orl then shared.orl = RL.wrapAttackAnimationAsync end
    if not shared.cpc then shared.cpc = PC.play end
    RL.wrapAttackAnimationAsync = function(a,b,c,d,func)
        local Hits = RL.getBladeHits(b,c,d)
        if Hits then
            PC.play = function() end
            a:Play(0.01,0.01,0.01)
            func(Hits)
            PC.play = shared.cpc
            wait(a.length * 0.5)
            a:Stop()
        end
    end

spawn(function()
    if _G.AutoFarm == true then
        local Client = game.Players.LocalPlayer
        local PC = require(Client.PlayerScripts.CombatFramework.Particle)
        local RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
        if not shared.orl then shared.orl = RL.wrapAttackAnimationAsync end
        if not shared.cpc then shared.cpc = PC.play end
        RL.wrapAttackAnimationAsync = function(a,b,c,d,func)
            local Hits = RL.getBladeHits(b,c,d)
            if Hits then
                PC.play = function() end
                a:Play(0.01,0.01,0.01)
                func(Hits)
                PC.play = shared.cpc
                wait(a.length * 0.5)
                a:Stop()
            end
        end
    end
end)
	
	-- Fast Attack Modulex2
	
	local Module = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	local CombatFramework = debug.getupvalues(Module)[2]
	local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
	
	spawn(function()
		while true do
			if _G.AutoFarm then
				pcall(function()
					CameraShakerR:Stop()
					CombatFramework.activeController.attacking = false
					CombatFramework.activeController.timeToNextAttack = 0
					CombatFramework.activeController.increment = 3
					CombatFramework.activeController.hitboxMagnitude = 100
					CombatFramework.activeController.blocking = false
					CombatFramework.activeController.timeToNextBlock = 0
					CombatFramework.activeController.focusStart = 0
					CombatFramework.activeController.humanoid.AutoRotate = true
				end)
			end
			task.wait()
		end
	end)
	
	-- FastAttackFrameWork
	
	local Module = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	local CombatFramework = debug.getupvalues(Module)[2]
	local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
	spawn(function()
		while true do
			if _G.AutoFarm then
				pcall(function()
					CameraShakerR:Stop()
					CombatFramework.activeController.attacking = false
					CombatFramework.activeController.timeToNextAttack = 0
					CombatFramework.activeController.increment = 3
					CombatFramework.activeController.hitboxMagnitude = 100
					CombatFramework.activeController.blocking = false
					CombatFramework.activeController.timeToNextBlock = 0
					CombatFramework.activeController.focusStart = 0
					CombatFramework.activeController.humanoid.AutoRotate = true
				end)
			end
			task.wait()
		end
	end)
	
	-- FastAttackShaker
	
	local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
	CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	y = debug.getupvalues(CombatFrameworkR)[2]
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if _G.AutoFarm then
				if typeof(y) == "table" then
					pcall(function()
						CameraShaker:Stop()
						y.activeController.timeToNextAttack = (math.huge^math.huge^math.huge)
						y.activeController.timeToNextAttack = 0
						y.activeController.hitboxMagnitude = 9999
						y.activeController.active = false
						y.activeController.timeToNextBlock = 0
						y.activeController.focusStart = 0
						y.activeController.increment = 4
						y.activeController.blocking = false
						y.activeController.attacking = false
						y.activeController.humanoid.AutoRotate = true
					end)
				end
			end
		end)
	end)
	
	-- FastAttackConnect
	
	local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
	CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	y = debug.getupvalues(CombatFrameworkR)[2]
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if _G.AutoFarm then
				if typeof(y) == "table" then
					pcall(function()
						CameraShaker:Stop()
						y.activeController.timeToNextAttack = (math.huge^math.huge^math.huge)
						y.activeController.timeToNextAttack = 0
						y.activeController.hitboxMagnitude = 9999
						y.activeController.active = false
						y.activeController.timeToNextBlock = 0
						y.activeController.focusStart = 0
						y.activeController.increment = 4
						y.activeController.blocking = false
						y.activeController.attacking = false
						y.activeController.humanoid.AutoRotate = true
					end)
				end
			end
		end)
	end)
	
	-- CameraShaker
	
	function CameraShaker()
		task.spawn(function()
			local Camera = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.CameraShaker)
			while wait() do
				pcall(function()
					if _G.Settings.Configs["Camera Shaker"] then
						Camera.CameraShakeInstance.CameraShakeState.Inactive = 0
					else
						Camera.CameraShakeInstance.CameraShakeState.Inactive = 3
					end
				end)
			end
		end)
	end
	
	-- No Stun
	
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if _G.AutoFarm == true then
				game.Players.LocalPlayer.Character.Stun.Value = 0
				game.Players.LocalPlayer.Character.Humanoid.Sit = false
				game.Players.LocalPlayer.Character.Busy.Value = false        
			end
		end)
	end)
	
	-- Auto Buso
	
	spawn(function()
		while wait(.1) do
			if _G.AutoFarm then 
				if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					local args = {
						[1] = "Buso"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
			end
		end
	end)
	
	-- BringFruits
	
	spawn(function()
		while wait() do
			pcall(function()
				if _G.AutoFarm then
					for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
						if v:IsA("Tool") then
							if string.find(v.Name, "Fruit") then
								repeat wait()
									wait()
									firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,v.Handle,0)    
									wait()
								until not _G.BringFruit or v.Parent == game.Players.LocalPlayer.Character
							end
						end
					end
				end
			end)
		end
	end)
	
	-- StoreFruits
	
	spawn(function()
		pcall(function()
			while wait() do
				if _G.AutoStoreFruit then
					for i,v in pairs(FruitList) do
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit",v)
					end
				end
			end
		end)
	end)
	
	-- AutoRejoin
	
	spawn(function()
		while wait() do
			if _G.AutoFarm then
				_G.AutoFarm = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
					if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
						print("Xennia Hub Rejoin Connecting")
						game:GetService("TeleportService"):Teleport(game.PlaceId)
					end
				end)
			end
		end
	end)

	-- RedeemAllCode

	spawn(function()
		pcall(function()
			while wait() do
				if _G.AutoFarm then
					function UseCode(Text)
						game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
					end
					UseCode("EXP_5B")
					UseCode("kittgaming")
					UseCode("Sub2Fer999")
					UseCode("Enyu_is_Pro")
					UseCode("Magicbus")
					UseCode("JCWK")
					UseCode("Starcodeheo")
					UseCode("Bluxxy")
					UseCode("fudd10_v2")
					UseCode("FUDD10")
					UseCode("BIGNEWS")
					UseCode("THEGREATACE")
					UseCode("SUB2GAMERROBOT_EXP1")
					UseCode("Sub2OfficialNoobie")
					UseCode("StrawHatMaine")
					UseCode("SUB2NOOBMASTER123")
					UseCode("Sub2Daigrock")
					UseCode("Axiore")
					UseCode("TantaiGaming")
				end
			end
		end)
	end)

	-- Auto Buy Legendary Sword

		spawn(function()
			while wait() do
				if _G.AutoFarm then
					pcall(function()
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","1")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","2")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","3")
						if _G.AutoBuyLegendarySword_Hop and _G.AutoFarm and New_World then
							wait(10)
							Hop()
						end
					end)
				end 
			end
		end)

	-- BuySoru

	spawn(function()
		pcall(function()
			while wait() do
				if game.Players.LocalPlayer.Backpack:FindFirstChild("Soru") and game.Players.LocalPlayer.Backpack:FindFirstChild("Soru").Level.Value >= 300 then
				if _G.AutoFarm then
					local args = {
						[1] = "BuyHaki",
						[2] = "Soru"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
			end
		end
		end)
	end)

	-- AutoHaki

	spawn(function()
		while wait(.1) do
			if _G.AutoFarm then
				if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
				end
			end
		end
	end)

	-- Setfflag

			if _G.AutoFarm == true then
				while _G.AutoFarm do wait()
				setfflag("HumanoidParallelRemoveNoPhysics", "False")
				setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
				setfflag("CrashPadUploadToBacktraceToBacktraceBaseUrl", "")
				setfflag("CrashUploadToBacktracePercentage", "0")
				setfflag("CrashUploadToBacktraceBlackholeToken", "")
				setfflag("CrashUploadToBacktraceWindowsPlayerToken", "")
			end
		end

	local Window = create:Win("Kirainc Hub - Kaitun Edition")
  local Tap1 = Window:Taps("Item")
  local Tap2 = Window:Taps("Setting")

  -- Tab 1 UI Library
	local EnableFunction = Tap1:newpage()
	local page2 = Tap1:newpage()

  -- Tab 2 UI Library
	local SettingFunction = Tap1:newpage()
	local page2 = Tap1:newpage()

  	spawn(function()
		if _G.HideUi then
			game:GetService("VirtualInputManager"):SendKeyEvent(true,305,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
		end
	end)

	_G.EnableStartFarm = true
	EnableFunction:Toggle("Enable Start Kaitun",_G.StartFarm,function(vu)
		_G.AutoFarm = vu
		Auto_Farm = vu
		_G.Auto_New_World = vu
		_G.Auto_Saber = vu
		Magnet = vu
		SelectMonster = ""
		if vu == false then
			wait(1)
			totarget(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
		end
      end)

  _G.WhiteScreen = true
	EnableFunction:Toggle("White Screen",_G.WhiteScreen,function(vu)
		_G.WhiteScreen = vu
		if _G.WhiteScreen then
			game:GetService("RunService"):Set3dRenderingEnabled(false)
		else
			game:GetService("RunService"):Set3dRenderingEnabled(true)
		end
	end)

	spawn(function()
		while wait(1) do
			pcall(function()
				if _G.AutoFarm then
					if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
					else
						wait(3)
					end
				end
			end)
		end
	end)

_G.FastAttack = true
Attack:AddToggle("Fast Attack ",_G.FastAttack,function(vu)
	_G.FastAttack = vu
end)

local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
for i,v in pairs(getreg()) do
	if typeof(v) == "function" and getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework then
		for x,w in pairs(debug.getupvalues(v)) do
			 if typeof(w) == "table" then
				spawn(function()
					game:GetService("RunService").RenderStepped:Connect(function()
						if _G.FastAttack then
							pcall(function()
								if game.Players.LocalPlayer.Character:FindFirstChild("Combat") or game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") or game.Players.LocalPlayer.Character:FindFirstChild("Electro") or game.Players.LocalPlayer.Character:FindFirstChild("Fishman Karate") or game.Players.LocalPlayer.Character:FindFirstChild("Dragon Claw") or game.Players.LocalPlayer.Character:FindFirstChild("Superhuman") or game.Players.LocalPlayer.Character:FindFirstChild("Sharkman Karate") then
									w.activeController.increment = 3
								else
									w.activeController.increment = 4
								end             
								CameraShaker:Stop()
								w.activeController.timeToNextAttack = -(math.huge^math.huge^math.huge)
								w.activeController.attacking = false
								w.activeController.timeToNextBlock = 0
								w.activeController.blocking = false                            
								w.activeController.hitboxMagnitude = 50
								w.activeController.humanoid.AutoRotate = true
								  w.activeController.focusStart = 0
							end)
						end
					end)
				end)
			end
		end
	end
end

spawn(function()
	while task.wait() do
		if _G.FastAttack then
			pcall(function()
				wait(0.2)
				local AC = CbFw2.activeController
				for i = 1,1 do 
					local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
						plr.Character,
						{plr.Character.HumanoidRootPart},
						60
					)
					local cac = {}
					local hash = {}
					for k, v in pairs(bladehit) do
						if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
							table.insert(cac, v.Parent.HumanoidRootPart)
							hash[v.Parent] = true
						end
					end
					bladehit = cac
					if #bladehit > 0 then
						local u8 = debug.getupvalue(AC.attack, 5)
						local u9 = debug.getupvalue(AC.attack, 6)
						local u7 = debug.getupvalue(AC.attack, 4)
						local u10 = debug.getupvalue(AC.attack, 7)
						local u12 = (u8 * 798405 + u7 * 727595) % u9
						local u13 = u7 * 798405
						(function()
							u12 = (u12 * u9 + u13) % 1099511627776
							u8 = math.floor(u12 / u9)
							u7 = u12 - u8 * u9
						end)()
						u10 = u10 + 1
						debug.setupvalue(AC.attack, 5, u8)
						debug.setupvalue(AC.attack, 6, u9)
						debug.setupvalue(AC.attack, 4, u7)
						debug.setupvalue(AC.attack, 7, u10)
						if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then 
							game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
							game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
							game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "") 
						end
					end
				end
			end)
		end
	end
end)

local Camera = require(game.ReplicatedStorage.Util.CameraShaker)
Camera:Stop()

	Attack:AddToggle("Camera Shaker",false,function(d)
		_G.LockMob = d
			if _G.LockMob == true then
				while _G.LockMob do wait()
				setfflag("HumanoidParallelRemoveNoPhysics", "False")
				setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
				setfflag("CrashPadUploadToBacktraceToBacktraceBaseUrl", "")
				setfflag("CrashUploadToBacktracePercentage", "0")
				setfflag("CrashUploadToBacktraceBlackholeToken", "")
				setfflag("CrashUploadToBacktraceWindowsPlayerToken", "")
			end
		end
	end)

		Attack:AddToggle("Attack No Cooldown",true,function(XEEE)
			_G.LockMob = XEEE
			if _G.LockMob == true then
			while _G.LockMob do wait()
				cq()
				for k,x in pairs(game.Workspace.Enemies:GetChildren()) do
					if x.Name == Ms and x:FindFirstChild("HumanoidRootPart") and x:FindFirstChild("Humanoid") and x.Humanoid.Health > 0 and (x.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= magbring then
								x.HumanoidRootPart.CanCollide = false
								x.HumanoidRootPart.CFrame = PosMonAutoFarm
								x.Humanoid.PlatformStand = false
								x.Humanoid:ChangeState(11)
								wait(0.1)
								x.HumanoidRootPart.Anchored = false
					end 
				end
			end
			end
			if _G.LockMob == false then
				cq()
				for k,x in pairs(game.Workspace.Enemies:GetChildren()) do
							if x.Name == Ms and x:FindFirstChild("HumanoidRootPart") and x:FindFirstChild("Humanoid") and x.Humanoid.Health > 0 and (x.HumanoidRootPart.Position-game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= magbring then
								x.HumanoidRootPart.CanCollide = false
								x.HumanoidRootPart.CFrame = PosMonAutoFarm
								x.Humanoid.PlatformStand = false
								x.Humanoid:ChangeState(11)
								wait(0.2)
								x.HumanoidRootPart.Anchored = false
							end 
						end
			end
			end)

SettingFunction:Toggle("Auto Update Status",true,function(value)
    _G.AutoUpdate = value
end)

spawn(function()
	while wait() do
		if _G.AutoUpdate then
			if game:GetService("Players").LocalPlayer.Data.Stats.Melee.Level.Value < 2400 then
				local args = {
					[1] = "AddPoint",
					[2] = "Melee",
					[3] = tonumber(UpStatus)
				}
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
			else
				local args = {
					[1] = "AddPoint",
					[2] = "Defense",
					[3] = tonumber(UpStatus)
				}
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))				
			end
		end
	end
end)

PointStats = 3
Update:AddSlider("Update %",1,3,100,1,"PointStats",function(value)
    PointStats = value
end)

PointStats = 3
SettingKaitun:Slider("Update %",1,3,100,1,"PointStats",function(value)
		PointStats = value
end)

-- CFrame Monster

  -- Auto Equip Melee

		spawn(function()
		while wait() do
		if _G.AutoFarm then
				pcall(function()
				while wait() do
				for i,v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
				   if v.ToolTip == "Melee" then
				  if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v.Name)) then
					  local ToolSe = tostring(v.Name)
					 local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
					 wait(.4)
					 game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
				  end
				   end
				end
			   end
			end)
		end
		end
		end)

-- AutoHaki

spawn(function()
    while wait(.1) do
        if _G.AutoFarm then
            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

-- RedeemCode

spawn(function()
    pcall(function()
        while wait() do
            if _G.AutoFarm then
                function UseCode(Text)
                    game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
                end
                UseCode("EXP_5B")
                UseCode("kittgaming")
                UseCode("Sub2Fer999")
                UseCode("Enyu_is_Pro")
                UseCode("Magicbus")
                UseCode("JCWK")
                UseCode("Starcodeheo")
                UseCode("Bluxxy")
                UseCode("fudd10_v2")
                UseCode("FUDD10")
                UseCode("BIGNEWS")
                UseCode("THEGREATACE")
                UseCode("SUB2GAMERROBOT_EXP1")
                UseCode("Sub2OfficialNoobie")
                UseCode("StrawHatMaine")
                UseCode("SUB2NOOBMASTER123")
                UseCode("Sub2Daigrock")
                UseCode("Axiore")
                UseCode("TantaiGaming")
            end
        end
    end)
end)
	
	local plr = game.Players.LocalPlayer
	local CbFw = getupvalues(require(plr.PlayerScripts.CombatFramework))
	local CbFw2 = CbFw[2]
	
	function GetCurrentBlade() 
		local p13 = CbFw2.activeController
		local ret = p13.blades[1]
		if not ret then return end
		while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
		return ret
	end
	
	function AttackNoCD()
		if not Auto_Farm_Bounty and not Auto_Farm_Fruit or Mix_Farm then
			if not Auto_Raid then
				local AC = CbFw2.activeController
				for i = 1, 1 do 
					local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
						plr.Character,
						{plr.Character.HumanoidRootPart},
						60
					)
					local cac = {}
					local hash = {}
					for k, v in pairs(bladehit) do
						if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
							table.insert(cac, v.Parent.HumanoidRootPart)
							hash[v.Parent] = true
						end
					end
					bladehit = cac
					if #bladehit > 0 then
						local u8 = debug.getupvalue(AC.attack, 5)
						local u9 = debug.getupvalue(AC.attack, 6)
						local u7 = debug.getupvalue(AC.attack, 4)
						local u10 = debug.getupvalue(AC.attack, 7)
						local u12 = (u8 * 798405 + u7 * 727595) % u9
						local u13 = u7 * 798405
						(function()
							u12 = (u12 * u9 + u13) % 1099511627776
							u8 = math.floor(u12 / u9)
							u7 = u12 - u8 * u9
						end)()
						u10 = u10 + 1
						debug.setupvalue(AC.attack, 5, u8)
						debug.setupvalue(AC.attack, 6, u9)
						debug.setupvalue(AC.attack, 4, u7)
						debug.setupvalue(AC.attack, 7, u10)
						pcall(function()
							if plr.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then
								AC.animator.anims.basic[1]:Play(0.01,0.01,0.01)
								game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
								game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
								game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
							end
						end)
					end
				end
			end
		end
		if Auto_Farm_Bounty or Auto_Farm_Fruit and not Mix_Farm then
			local Fast = getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))
			local Lop = Fast[2]
			Lop.activeController.timeToNextAttack = (-math.huge^math.huge*math.huge)
			Lop.activeController.attacking = false
			Lop.activeController.timeToNextBlock = 0
			Lop.activeController.humanoid.AutoRotate = 80
			Lop.activeController.increment = 3
			Lop.activeController.blocking = false
			Lop.activeController.hitboxMagnitude = 80
		end
	end

	-- Auto NextSea

	spawn(function()
        while wait() do
            if _G.Auto_New_World then
                pcall(function()
                    if game.Players.LocalPlayer.Data.Level.Value >= 700 and World1 then
                        _G.AutoFarm = false
                        if game.Workspace.Map.Ice.Door.CanCollide == true and game.Workspace.Map.Ice.Door.Transparency == 0 then
                            repeat wait() getgenv().ToTarget(CFrame.new(4851.8720703125, 5.6514348983765, 718.47094726563)) until (CFrame.new(4851.8720703125, 5.6514348983765, 718.47094726563).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.Auto_New_World
                            wait(1)
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("DressrosaQuestProgress","Detective")
                            EquipWeapon("Key")
                            local pos2 = CFrame.new(1347.7124, 37.3751602, -1325.6488)
                            repeat wait() getgenv().ToTarget(pos2) until (pos2.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.Auto_New_World
                            wait(3)
                        elseif game.Workspace.Map.Ice.Door.CanCollide == false and game.Workspace.Map.Ice.Door.Transparency == 1 then
                            if game:GetService("Workspace").Enemies:FindFirstChild("Ice Admiral [Lv. 700] [Boss]") then
                                for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                    if v.Name == "Ice Admiral [Lv. 700] [Boss]" and v.Humanoid.Health > 0 then
                                        repeat wait()
                                            AutoHaki()
                                            EquipWeapon(_G.Select_Weapon)
                                            v.HumanoidRootPart.CanCollide = false
                                            v.HumanoidRootPart.Size = Vector3.new(60,60,60)
                                            v.HumanoidRootPart.Transparency = 1
                                            getgenv().ToTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,_G.Select_Distance,0))
                                            game:GetService("VirtualUser"):CaptureController()
                                            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 870),workspace.CurrentCamera.CFrame)
                                        until v.Humanoid.Health <= 0 or not v.Parent or not _G.Auto_New_World
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                                    end
                                end
                            else
                                getgenv().ToTarget(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                            end
                        else
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
                        end
                    end
                end)
            end
        end
    end)

    -- Auto Buy All Haki

					spawn(function()
						pcall(function()
							while wait() do
								if _G.AutoFarm then
									local args = {
										[1] = "BuyHaki",
										[2] = "Geppo"
									}
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
							end
						end)
					end)
					spawn(function()
						pcall(function()
							while wait() do
								if _G.AutoFarm then
									local args = {
										[1] = "BuyHaki",
										[2] = "Buso"
									}
							
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
								end
							end
						end)
					end)
					spawn(function()
						pcall(function()
							while wait() do
								if _G.AutoFarm then
									local args = {
										[1] = "BuyHaki",
										[2] = "Soru"
									}
									game:GetService("ReplicatedStorage I").Remotes.CommF_:InvokeServer(unpack(args))
								end
							end
						end)
					end)

	-- AutoSaber

	spawn(function()
		while wait() do
			if _G.Auto_Saber then
				if game.Players.localPlayer.Data.Level.Value < 200 then
					_G.AutoFarm = false
				else
					if game.Workspace.Map.Jungle.Final.Part.CanCollide == false then
						if _G.Auto_Saber and game.ReplicatedStorage:FindFirstChild("Saber Expert [Lv. 200] [Boss]") or game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
							if game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
								for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
									if v.Name == "Saber Expert [Lv. 200] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
										repeat wait()
											if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
												Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
											elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Farmtween then
													Farmtween:Stop()
												end
												AutoHaki()
												EquipWeapon(_G.Select_Weapon)
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
												game:GetService'VirtualUser':CaptureController()
												game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
											end
										until not _G.Auto_Saber or not v.Parent or v.Humanoid.Health <= 0
									end
								end
							else
								Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
								if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
									if Questtween then
										Questtween:Stop()
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
								end
							end
						else
							if _G.Auto_Saber_Hop then
								Hop()
							end
						end
					elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") and game.Players.localPlayer.Data.Level.Value >= 200 then
						EquipWeapon("Relic")
						wait(0.5)
						Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
						if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
						end
					else
						if Workspace.Map.Jungle.QuestPlates.Door.CanCollide == false then
							if game.Workspace.Map.Desert.Burn.Part.CanCollide == false then
								if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") == 0 then
									if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
										if game.Workspace.Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
											for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
												if _G.Auto_Saber and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Mob Leader [Lv. 120] [Boss]" then
													repeat
														pcall(function() wait() 
															if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
																Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
															elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
																if Farmtween then
																	Farmtween:Stop()
																end
																AutoHaki()
																EquipWeapon(_G.Select_Weapon)
																if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
																	local args = {
																		[1] = "Buso"
																	}
																	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
																end
																game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
																game:GetService'VirtualUser':CaptureController()
																game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
															end
														end)
													until not _G.Auto_Saber or not v.Parent or v.Humanoid.Health <= 0
												end
											end
										else
											Questtween = toTarget(CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position,CFrame.new(-2848.59399, 7.4272871, 5342.44043))
											if (CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.928248107)
											end
										end
									elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
										if game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") then
											EquipWeapon("Relic")
											wait(0.5)
											Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position,CFrame.new(-1405.41956, 29.8519993, 5.62435055))
											if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055)
											end
										else
											Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624).Position,CFrame.new(-910.979736, 13.7520342, 4078.14624))
											if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624, 0.00685182028, -1.53155766e-09, -0.999976516, 9.15205245e-09, 1, -1.46888401e-09, 0.999976516, -9.14177267e-09, 0.00685182028)
												wait(.5)
												local args = {
													[1] = "ProQuestProgress",
													[2] = "RichSon"
												}
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
											end
										end
									else
										Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624).Position,CFrame.new(-910.979736, 13.7520342, 4078.14624))
										if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Questtween then
												Questtween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624)
											local args = {
												[1] = "ProQuestProgress",
												[2] = "RichSon"
											}
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
									end
								else
									if game.Players.LocalPlayer.Backpack:FindFirstChild("Cup") or game.Players.LocalPlayer.Character:FindFirstChild("Cup") then
										EquipWeapon("Cup")
										if game.Players.LocalPlayer.Character.Cup.Handle:FindFirstChild("TouchInterest") then
											Questtween = toTarget(CFrame.new(1397.229, 37.3480148, -1320.85217).Position,CFrame.new(1397.229, 37.3480148, -1320.85217))
											if (CFrame.new(1397.229, 37.3480148, -1320.85217).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1397.229, 37.3480148, -1320.85217, -0.11285457, 2.01368788e-08, 0.993611455, 1.91641178e-07, 1, 1.50028845e-09, -0.993611455, 1.90586206e-07, -0.11285457)
											end
										else
											wait(0.5)
											if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
												local args = {
													[1] = "ProQuestProgress",
													[2] = "SickMan"
												}
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
											end
										end
									else
										Questtween = toTarget(game.Workspace.Map.Desert.Cup.Position,game.Workspace.Map.Desert.Cup.CFrame)
										if (game.Workspace.Map.Desert.Cup.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
											if Questtween then
												Questtween:Stop()
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Desert.Cup.CFrame
										end
										-- firetouchinterest(game.Workspace.Map.Desert.Cup.TouchInterest,game.Players.LocalPlayer.Character.Head, 1)
									end
								end
							else
								if game.Players.LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
									EquipWeapon("Torch")
									Questtween = toTarget(CFrame.new(1114.87708, 4.9214654, 4349.8501).Position,CFrame.new(1114.87708, 4.9214654, 4349.8501))
									if (CFrame.new(1114.87708, 4.9214654, 4349.8501).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1114.87708, 4.9214654, 4349.8501, -0.612586915, -9.68697833e-08, 0.790403247, -1.2634203e-07, 1, 2.4638446e-08, -0.790403247, -8.47679615e-08, -0.612586915)
									end
								else
									Questtween = toTarget(CFrame.new(-1610.00757, 11.5049858, 164.001587).Position,CFrame.new(-1610.00757, 11.5049858, 164.001587))
									if (CFrame.new(-1610.00757, 11.5049858, 164.001587).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if Questtween then
											Questtween:Stop()
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408)
									end
								end
							end
						else
							for i,v in pairs(Workspace.Map.Jungle.QuestPlates:GetChildren()) do
								if v:IsA("Model") then wait()
									if v.Button.BrickColor ~= BrickColor.new("Camo") then
										repeat wait()
											Questtween = toTarget(v.Button.Position,v.Button.CFrame)
											if (v.Button.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
												if Questtween then
													Questtween:Stop()
												end
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Button.CFrame
											end
										until not _G.Auto_Saber or v.Button.BrickColor == BrickColor.new("Camo")
									end
								end
							end    
						end
					end
				end 
			end
		end
	end)
	
	-- Mob
	
	task.spawn(function()
		while true do wait()
			if setscriptable then
				setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
			end
			if sethiddenproperty then
				sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
			end
		end
	end)
	
	task.spawn(function()
		while task.wait() do
			pcall(function()
				if StartMagnet then
					for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
						if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
							if InMyNetWork(v.HumanoidRootPart) then
								v.HumanoidRootPart.CFrame = PosMon
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								v.HumanoidRootPart.Size = Vector3.new(60,60,60)
								v.HumanoidRootPart.Transparency = 1
								v.HumanoidRootPart.CanCollide = false
								v.Head.CanCollide = false
								if v.Humanoid:FindFirstChild("Animator") then
									v.Humanoid.Animator:Destroy()
								end
								v.Humanoid:ChangeState(11)
								v.Humanoid:ChangeState(14)
							end
						end
					end
				end
			end)
		end
	end)

	-- Hit Melee

    local Client = game.Players.LocalPlayer
    local PC = require(Client.PlayerScripts.CombatFramework.Particle)
    local RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
    if not shared.orl then shared.orl = RL.wrapAttackAnimationAsync end
    if not shared.cpc then shared.cpc = PC.play end
    RL.wrapAttackAnimationAsync = function(a,b,c,d,func)
        local Hits = RL.getBladeHits(b,c,d)
        if Hits then
            PC.play = function() end
            a:Play(0.01,0.01,0.01)
            func(Hits)
            PC.play = shared.cpc
            wait(a.length * 0.5)
            a:Stop()
        end
    end

spawn(function()
    if _G.AutoFarm == true then
        local Client = game.Players.LocalPlayer
        local PC = require(Client.PlayerScripts.CombatFramework.Particle)
        local RL = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
        if not shared.orl then shared.orl = RL.wrapAttackAnimationAsync end
        if not shared.cpc then shared.cpc = PC.play end
        RL.wrapAttackAnimationAsync = function(a,b,c,d,func)
            local Hits = RL.getBladeHits(b,c,d)
            if Hits then
                PC.play = function() end
                a:Play(0.01,0.01,0.01)
                func(Hits)
                PC.play = shared.cpc
                wait(a.length * 0.5)
                a:Stop()
            end
        end
    end
end)
	
	-- Fast Attack Modulex2
	
	local Module = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	local CombatFramework = debug.getupvalues(Module)[2]
	local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
	
	spawn(function()
		while true do
			if _G.AutoFarm then
				pcall(function()
					CameraShakerR:Stop()
					CombatFramework.activeController.attacking = false
					CombatFramework.activeController.timeToNextAttack = 0
					CombatFramework.activeController.increment = 3
					CombatFramework.activeController.hitboxMagnitude = 100
					CombatFramework.activeController.blocking = false
					CombatFramework.activeController.timeToNextBlock = 0
					CombatFramework.activeController.focusStart = 0
					CombatFramework.activeController.humanoid.AutoRotate = true
				end)
			end
			task.wait()
		end
	end)
	
	-- FastAttackFrameWork
	
	local Module = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	local CombatFramework = debug.getupvalues(Module)[2]
	local CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
	spawn(function()
		while true do
			if _G.AutoFarm then
				pcall(function()
					CameraShakerR:Stop()
					CombatFramework.activeController.attacking = false
					CombatFramework.activeController.timeToNextAttack = 0
					CombatFramework.activeController.increment = 3
					CombatFramework.activeController.hitboxMagnitude = 100
					CombatFramework.activeController.blocking = false
					CombatFramework.activeController.timeToNextBlock = 0
					CombatFramework.activeController.focusStart = 0
					CombatFramework.activeController.humanoid.AutoRotate = true
				end)
			end
			task.wait()
		end
	end)
	
	-- FastAttackShaker
	
	local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
	CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	y = debug.getupvalues(CombatFrameworkR)[2]
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if _G.AutoFarm then
				if typeof(y) == "table" then
					pcall(function()
						CameraShaker:Stop()
						y.activeController.timeToNextAttack = (math.huge^math.huge^math.huge)
						y.activeController.timeToNextAttack = 0
						y.activeController.hitboxMagnitude = 9999
						y.activeController.active = false
						y.activeController.timeToNextBlock = 0
						y.activeController.focusStart = 0
						y.activeController.increment = 4
						y.activeController.blocking = false
						y.activeController.attacking = false
						y.activeController.humanoid.AutoRotate = true
					end)
				end
			end
		end)
	end)
	
	-- FastAttackConnect
	
	local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
	CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
	y = debug.getupvalues(CombatFrameworkR)[2]
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if _G.AutoFarm then
				if typeof(y) == "table" then
					pcall(function()
						CameraShaker:Stop()
						y.activeController.timeToNextAttack = (math.huge^math.huge^math.huge)
						y.activeController.timeToNextAttack = 0
						y.activeController.hitboxMagnitude = 9999
						y.activeController.active = false
						y.activeController.timeToNextBlock = 0
						y.activeController.focusStart = 0
						y.activeController.increment = 4
						y.activeController.blocking = false
						y.activeController.attacking = false
						y.activeController.humanoid.AutoRotate = true
					end)
				end
			end
		end)
	end)
	
	-- CameraShaker
	
	function CameraShaker()
		task.spawn(function()
			local Camera = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.CameraShaker)
			while wait() do
				pcall(function()
					if _G.Settings.Configs["Camera Shaker"] then
						Camera.CameraShakeInstance.CameraShakeState.Inactive = 0
					else
						Camera.CameraShakeInstance.CameraShakeState.Inactive = 3
					end
				end)
			end
		end)
	end
	
	-- No Stun
	
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if _G.AutoFarm == true then
				game.Players.LocalPlayer.Character.Stun.Value = 0
				game.Players.LocalPlayer.Character.Humanoid.Sit = false
				game.Players.LocalPlayer.Character.Busy.Value = false        
			end
		end)
	end)
	
	-- Auto Buso
	
	spawn(function()
		while wait(.1) do
			if _G.AutoFarm then 
				if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					local args = {
						[1] = "Buso"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
			end
		end
	end)
	
	-- BringFruits
	
	spawn(function()
		while wait() do
			pcall(function()
				if _G.AutoFarm then
					for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
						if v:IsA("Tool") then
							if string.find(v.Name, "Fruit") then
								repeat wait()
									wait()
									firetouchinterest(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,v.Handle,0)    
									wait()
								until not _G.BringFruit or v.Parent == game.Players.LocalPlayer.Character
							end
						end
					end
				end
			end)
		end
	end)
	
	-- StoreFruits
	
	spawn(function()
		pcall(function()
			while wait() do
				if _G.AutoStoreFruit then
					for i,v in pairs(FruitList) do
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit",v)
					end
				end
			end
		end)
	end)
	
	-- AutoRejoin
	
	spawn(function()
		while wait() do
			if _G.AutoFarm then
				_G.AutoFarm = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
					if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
						print("Xennia Hub Rejoin Connecting")
						game:GetService("TeleportService"):Teleport(game.PlaceId)
					end
				end)
			end
		end
	end)

	-- RedeemAllCode

	spawn(function()
		pcall(function()
			while wait() do
				if _G.AutoFarm then
					function UseCode(Text)
						game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(Text)
					end
					UseCode("EXP_5B")
					UseCode("kittgaming")
					UseCode("Sub2Fer999")
					UseCode("Enyu_is_Pro")
					UseCode("Magicbus")
					UseCode("JCWK")
					UseCode("Starcodeheo")
					UseCode("Bluxxy")
					UseCode("fudd10_v2")
					UseCode("FUDD10")
					UseCode("BIGNEWS")
					UseCode("THEGREATACE")
					UseCode("SUB2GAMERROBOT_EXP1")
					UseCode("Sub2OfficialNoobie")
					UseCode("StrawHatMaine")
					UseCode("SUB2NOOBMASTER123")
					UseCode("Sub2Daigrock")
					UseCode("Axiore")
					UseCode("TantaiGaming")
				end
			end
		end)
	end)

	-- Auto Buy Legendary Sword

		spawn(function()
			while wait() do
				if _G.AutoFarm then
					pcall(function()
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","1")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","2")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer","3")
						if _G.AutoBuyLegendarySword_Hop and _G.AutoFarm and New_World then
							wait(10)
							Hop()
						end
					end)
				end 
			end
		end)

	-- BuySoru

	spawn(function()
		pcall(function()
			while wait() do
				if game.Players.LocalPlayer.Backpack:FindFirstChild("Soru") and game.Players.LocalPlayer.Backpack:FindFirstChild("Soru").Level.Value >= 300 then
				if _G.AutoFarm then
					local args = {
						[1] = "BuyHaki",
						[2] = "Soru"
					}
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
				end
			end
		end
		end)
	end)

	-- AutoHaki

	spawn(function()
		while wait(.1) do
			if _G.AutoFarm then
				if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
				end
			end
		end
	end)

	-- Setfflag

			if _G.AutoFarm == true then
				while _G.AutoFarm do wait()
				setfflag("HumanoidParallelRemoveNoPhysics", "False")
				setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
				setfflag("CrashPadUploadToBacktraceToBacktraceBaseUrl", "")
				setfflag("CrashUploadToBacktracePercentage", "0")
				setfflag("CrashUploadToBacktraceBlackholeToken", "")
				setfflag("CrashUploadToBacktraceWindowsPlayerToken", "")
			end
		end

	local locallv = Status:AddLabel("Level")

	spawn(function()
		while wait() do
			pcall(function()
				locallv:Set("Level :".." "..game:GetService("Players").LocalPlayer.Data.Level.Value)
			end)
		end
	end)

	local localbeli = Status:AddLabel("Money")

	spawn(function()
		while wait() do
			pcall(function()
				localbeli:Set("Money :".." "..game:GetService("Players").LocalPlayer.Data.Beli.Value)
			end)
		end
	end)

	local localfrag = Status:AddLabel("Fragment")

	spawn(function()
		while wait() do
			pcall(function()
				localfrag:Set("Fragments :".." "..game:GetService("Players").LocalPlayer.Data.Fragments.Value)
			end)
		end
	end)

	local localDevil = Status:AddLabel("Fruit")

	spawn(function()
		while wait() do
			pcall(function()
				if game:GetService("Players").LocalPlayer.Character:FindFirstChild(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value) or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(game:GetService("Players").LocalPlayer.Data.DevilFruit.Value) then
					localDevil:Set("Fruit :".." "..game:GetService("Players").LocalPlayer.Data.DevilFruit.Value)
				else
					localDevil:Set("Fruit : N/A")
				end
			end)
		end
	end)


	-- Quest
	Old_World = false
	New_World = false
	Three_World = false

	local placeId = game.PlaceId
	if placeId == 2753915549 then
		Old_World = true
	elseif placeId == 4442272183 then
		New_World = true
	elseif placeId == 7449423635 then
		Three_World = true
	end

	function toTarget(targetPos, targetCFrame)
			if FastTween then
				Distance = (targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
				if Distance < 10000 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
					Speed = 500
				elseif Distance >= 10000 then
					Speed = 450
				end
			else
				Distance = (targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
				if Distance < 10000 then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = P
					Speed = 500
				elseif Distance >= 10000 then
					Speed = 450
				end
			end
			local tweenfunc = {}
		
			local tween_s = game:service"TweenService"
			local info = TweenInfo.new((targetPos - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed, Enum.EasingStyle.Linear)
			local tween = tween_s:Create(game:GetService("Players").LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = targetCFrame * CFrame.fromAxisAngle(Vector3.new(1,0,0), math.rad(0))})
			tween:Play()
		
			function tweenfunc:Stop()
				tween:Cancel()
			end 
		
			if not tween then return tween end
			return tweenfunc
		end

	function SlowtoTarget(CFgo)
		local tween_s = game:service"TweenService"
		local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude/250, Enum.EasingStyle.Linear)
		local tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = CFgo})
		tween:Play()
	end

	function totarget(CFgo)
		local tween_s = game:service"TweenService"
		local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude/300, Enum.EasingStyle.Linear)
		local tween, err = pcall(function()
			tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = CFgo})
			tween:Play()
		end)
		if not tween then return err end
	end

	spawn(function()
		game:GetService("RunService").Stepped:Connect(function()
			if farm or Auto_Farm or AutoFarmBone or AutoFarmChest or FramBoss or KillAllBoss or _G.AutoNew or _G.AutoThird or _G.AutoSaber or _G.AutoPoleHOP or _G.AutoPole or _G.AutoRengoku or _G.AutoEvoRace2 or _G.AutoQuestBartilo or _G.AutoHakiRainbow or _G.AutoEliteHunter or _G.AutoYama or _G.HolyTorch then
				if not KRNL_LOADED and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
					setfflag("HumanoidParallelRemoveNoPhysics", "False")
					setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
					game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
				else
					if not game:GetService("Workspace"):FindFirstChild("LOL") then
						local LOL = Instance.new("Part")
						LOL.Name = "LOL"
						LOL.Parent = game.Workspace
						LOL.Anchored = true
						LOL.Transparency = 10
						LOL.Size = Vector3.new(10,0,10)
					elseif game:GetService("Workspace"):FindFirstChild("LOL") then
						game.Workspace["LOL"].CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Y - 3.8,game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
					end
				end
				for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			end
		end)
	end)

	spawn(function()
			game:GetService("RunService").Heartbeat:Connect(function()
			if _G.Noclip then
			if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
				setfflag("HumanoidParallelRemoveNoPhysics", "False")
				setfflag("HumanoidParallelRemoveNoPhysicsNoSimulate2", "False")
				game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
				end
			end
		end)
	end)

	function CheckLevel()
		local Lv = game:GetService("Players").LocalPlayer.Data.Level.Value
		if Old_World then
			if Lv == 1 or Lv <= 14 or SelectMonster == "Bandit [Lv. 5]" then -- Bandit
				Ms = "Bandit [Lv. 5]"
				NameQuest = "BanditQuest1"
				QuestLv = 1
				NameMon = "Bandit"
				CFrameQ = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
				CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
			elseif Lv == 15 or Lv <= 29 or SelectMonster == "Gorilla [Lv. 20]" then -- Gorilla
				Ms = "Gorilla [Lv. 20]"
				NameQuest = "JungleQuest"
				QuestLv = 2
				NameMon = "Gorilla"
				CFrameQ = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
				CFrameMon = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
			elseif Lv == 30 or Lv <= 39 or SelectMonster == "Pirate [Lv. 35]" then -- Pirate
				Ms = "Pirate [Lv. 35]"
				NameQuest = "BuggyQuest1"
				QuestLv = 1
				NameMon = "Pirate"
				CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
				CFrameMon = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)
			elseif Lv == 40 or Lv <= 59 or SelectMonster == "Brute [Lv. 45]" then -- Brute
				Ms = "Brute [Lv. 45]"
				NameQuest = "BuggyQuest1"
				QuestLv = 2
				NameMon = "Brute"
				CFrameQ = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
				CFrameMon = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)
			elseif Lv == 60 or Lv <= 74 or SelectMonster == "Desert Bandit [Lv. 60]" then -- Desert Bandit
				Ms = "Desert Bandit [Lv. 60]"
				NameQuest = "DesertQuest"
				QuestLv = 1
				NameMon = "Desert Bandit"
				CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
				CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
			elseif Lv == 75 or Lv <= 89 or SelectMonster == "Desert Officer [Lv. 70]" then -- Desert Officer
				Ms = "Desert Officer [Lv. 70]"
				NameQuest = "DesertQuest"
				QuestLv = 2
				NameMon = "Desert Officer"
				CFrameQ = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
				CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
			elseif Lv == 90 or Lv <= 99 or SelectMonster == "Snow Bandit [Lv. 90]" then -- Snow Bandit
				Ms = "Snow Bandit [Lv. 90]"
				NameQuest = "SnowQuest"
				QuestLv = 1
				NameMon = "Snow Bandit"
				CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
				CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
			elseif Lv == 100 or Lv <= 119 or SelectMonster == "Snowman [Lv. 100]" then -- Snowman
				Ms = "Snowman [Lv. 100]"
				NameQuest = "SnowQuest"
				QuestLv = 2
				NameMon = "Snowman"
				CFrameQ = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
				CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
			elseif Lv == 120 or Lv <= 149 or SelectMonster == "Chief Petty Officer [Lv. 120]" then -- Chief Petty Officer
				Ms = "Chief Petty Officer [Lv. 120]"
				NameQuest = "MarineQuest2"
				QuestLv = 1
				NameMon = "Chief Petty Officer"
				CFrameQ = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
				CFrameMon = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)
			elseif Lv == 150 or Lv <= 174 or SelectMonster == "Sky Bandit [Lv. 150]" then -- Sky Bandit
				Ms = "Sky Bandit [Lv. 150]"
				NameQuest = "SkyQuest"
				QuestLv = 1
				NameMon = "Sky Bandit"
				CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
				CFrameMon = CFrame.new(-4955.6411132813, 365.46365356445, -2908.1865234375)
			elseif Lv == 175 or Lv <= 189 or SelectMonster == "Dark Master [Lv. 175]" then -- Dark Master
				Ms = "Dark Master [Lv. 175]"
				NameQuest = "SkyQuest"
				QuestLv = 2
				NameMon = "Dark Master"
				CFrameQ = CFrame.new(-4842.1372070313, 717.69543457031, -2623.0483398438)
				CFrameMon = CFrame.new(-5148.1650390625, 439.04571533203, -2332.9611816406)
			elseif Lv == 190 or Lv <= 209 or SelectMonster == "Prisoner [Lv. 190]" then -- Prisoner
				Ms = "Prisoner [Lv. 190]"
				NameQuest = "PrisonerQuest"
				QuestLv = 1
				NameMon = "Prisoner"
				CFrameQ = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
				CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877, 0.879988372, 0, -0.474995494, 0, 1, 0, 0.474995494, 0, 0.879988372)
			elseif Lv == 210 or Lv <= 249 or SelectMonster == "Dangerous Prisoner [Lv. 210]" then -- Dangerous Prisoner
				Ms = "Dangerous Prisoner [Lv. 210]"
				NameQuest = "PrisonerQuest"
				QuestLv = 2
				NameMon = "Dangerous Prisoner"
				CFrameQ = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, 0.995993316, -2.06384709e-09, -0.0894274712)
				CFrameMon = CFrame.new(5433.39307, 88.678093, 514.986877, 0.879988372, 0, -0.474995494, 0, 1, 0, 0.474995494, 0, 0.879988372)
					elseif Lv == 250 or Lv <= 274 or SelectMonster == "Toga Warrior [Lv. 250]" then -- Toga Warrior
						Ms = "Toga Warrior [Lv. 250]"
						NameQuest = "ColosseumQuest"
						QuestLv = 1
						NameMon = "Toga Warrior"
						CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
						CFrameMon = CFrame.new(-1872.5166015625, 49.080215454102, -2913.810546875)
					elseif Lv == 275 or Lv <= 299 or SelectMonster == "Gladiator [Lv. 275]" then -- Gladiator
						Ms = "Gladiator [Lv. 275]"
						NameQuest = "ColosseumQuest"
						QuestLv = 2
						NameMon = "Gladiator"
						CFrameQ = CFrame.new(-1577.7890625, 7.4151420593262, -2984.4838867188)
						CFrameMon = CFrame.new(-1521.3740234375, 81.203170776367, -3066.3139648438)
			elseif Lv == 300 or Lv <= 324 or SelectMonster == "Military Soldier [Lv. 300]" then -- Military Soldier
				Ms = "Military Soldier [Lv. 300]"
				NameQuest = "MagmaQuest"
				QuestLv = 1
				NameMon = "Military Soldier"
				CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
				CFrameMon = CFrame.new(-5369.0004882813, 61.24352645874, 8556.4921875)
			elseif Lv == 325 or Lv <= 374 or SelectMonster == "Military Spy [Lv. 325]" then -- Military Spy
				Ms = "Military Spy [Lv. 325]"
				NameQuest = "MagmaQuest"
				QuestLv = 2
				NameMon = "Military Spy"
				CFrameQ = CFrame.new(-5316.1157226563, 12.262831687927, 8517.00390625)
				CFrameMon = CFrame.new(-5787.00293, 75.8262634, 8651.69922, 0.838590562, 0, -0.544762194, 0, 1, 0, 0.544762194, 0, 0.838590562)
			elseif Lv == 375 or Lv <= 399 or SelectMonster == "Fishman Warrior [Lv. 375]" then -- Fishman Warrior 
				Ms = "Fishman Warrior [Lv. 375]"
				NameQuest = "FishmanQuest"
				QuestLv = 1
				NameMon = "Fishman Warrior"
				CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
				CFrameMon = CFrame.new(60844.10546875, 98.462875366211, 1298.3985595703)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
				end
			elseif Lv == 400 or Lv <= 449 or SelectMonster == "Fishman Commando [Lv. 400]" then -- Fishman Commando
				Ms = "Fishman Commando [Lv. 400]"
				NameQuest = "FishmanQuest"
				QuestLv = 2
				NameMon = "Fishman Commando"
				CFrameQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
				CFrameMon = CFrame.new(61738.3984375, 64.207321166992, 1433.8375244141)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
				end
			elseif Lv == 450 or Lv <= 474 or SelectMonster == "God's Guard [Lv. 450]" then -- God's Guard
				Ms = "God's Guard [Lv. 450]"
				NameQuest = "SkyExp1Quest"
				QuestLv = 1
				NameMon = "God's Guard"
				CFrameQ = CFrame.new(-4721.8603515625, 845.30297851563, -1953.8489990234)
				CFrameMon = CFrame.new(-4628.0498046875, 866.92877197266, -1931.2352294922)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4607.82275, 872.54248, -1667.55688))
				end
			elseif Lv == 475 or Lv <= 524 or SelectMonster == "Shanda [Lv. 475]" then -- Shanda
				Ms = "Shanda [Lv. 475]"
				NameQuest = "SkyExp1Quest"
				QuestLv = 2
				NameMon = "Shanda"
				CFrameQ = CFrame.new(-7863.1596679688, 5545.5190429688, -378.42266845703)
				CFrameMon = CFrame.new(-7685.1474609375, 5601.0751953125, -441.38876342773)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 3000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-7894.6176757813, 5547.1416015625, -380.29119873047))
				end
			elseif Lv == 525 or Lv <= 549 or SelectMonster == "Royal Squad [Lv. 525]" then -- Royal Squad
				Ms = "Royal Squad [Lv. 525]"
				NameQuest = "SkyExp2Quest"
				QuestLv = 1
				NameMon = "Royal Squad"
				CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
				CFrameMon = CFrame.new(-7654.2514648438, 5637.1079101563, -1407.7550048828)
			elseif Lv == 550 or Lv <= 624 or SelectMonster == "Royal Soldier [Lv. 550]" then -- Royal Soldier
				Ms = "Royal Soldier [Lv. 550]"
				NameQuest = "SkyExp2Quest"
				QuestLv = 2
				NameMon = "Royal Soldier"
				CFrameQ = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
				CFrameMon = CFrame.new(-7760.4106445313, 5679.9077148438, -1884.8112792969)
			elseif Lv == 625 or Lv <= 649 or SelectMonster == "Galley Pirate [Lv. 625]" then -- Galley Pirate
				Ms = "Galley Pirate [Lv. 625]"
				NameQuest = "FountainQuest"
				QuestLv = 1
				NameMon = "Galley Pirate"
				CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
				CFrameMon = CFrame.new(5557.1684570313, 152.32717895508, 3998.7758789063)
			elseif Lv >= 650 or SelectMonster == "Galley Captain [Lv. 650]" then -- Galley Captain
				Ms = "Galley Captain [Lv. 650]"
				NameQuest = "FountainQuest"
				QuestLv = 2
				NameMon = "Galley Captain"
				CFrameQ = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
				CFrameMon = CFrame.new(5677.6772460938, 92.786109924316, 4966.6323242188)
			end
		end
		if New_World then
			if Lv == 700 or Lv <= 724 or SelectMonster == "Raider [Lv. 700]" then -- Raider
				Ms = "Raider [Lv. 700]"
				NameQuest = "Area1Quest"
				QuestLv = 1
				NameMon = "Raider"
				CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
				CFrameMon = CFrame.new(68.874565124512, 93.635643005371, 2429.6752929688)
			elseif Lv == 725 or Lv <= 774 or SelectMonster == "Mercenary [Lv. 725]" then -- Mercenary
				Ms = "Mercenary [Lv. 725]"
				NameQuest = "Area1Quest"
				QuestLv = 2
				NameMon = "Mercenary"
				CFrameQ = CFrame.new(-427.72567749023, 72.99634552002, 1835.9426269531)
				CFrameMon = CFrame.new(-864.85009765625, 122.47104644775, 1453.1505126953)
			elseif Lv == 775 or Lv <= 799 or SelectMonster == "Swan Pirate [Lv. 775]" then -- Swan Pirate
				Ms = "Swan Pirate [Lv. 775]"
				NameQuest = "Area2Quest"
				QuestLv = 1
				NameMon = "Swan Pirate"
				CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
				CFrameMon = CFrame.new(1065.3669433594, 137.64012145996, 1324.3798828125)
			elseif Lv == 800 or Lv <= 874 or SelectMonster == "Factory Staff [Lv. 800]" then -- Factory Staff
				Ms = "Factory Staff [Lv. 800]"
				NameQuest = "Area2Quest"
				QuestLv = 2
				NameMon = "Factory Staff"
				CFrameQ = CFrame.new(635.61151123047, 73.096351623535, 917.81298828125)
				CFrameMon = CFrame.new(533.22045898438, 128.46876525879, 355.62615966797)
			elseif Lv == 875 or Lv <= 899 or SelectMonster == "Marine Lieutenant [Lv. 875]" then -- Marine Lieutenant
				Ms = "Marine Lieutenant [Lv. 875]"
				NameQuest = "MarineQuest3"
				QuestLv = 1
				NameMon = "Marine Lieutenant"
				CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
				CFrameMon = CFrame.new(-2489.2622070313, 84.613594055176, -3151.8830566406)
			elseif Lv == 900 or Lv <= 949 or SelectMonster == "Marine Captain [Lv. 900]" then -- Marine Captain
				Ms = "Marine Captain [Lv. 900]"
				NameQuest = "MarineQuest3"
				QuestLv = 2
				NameMon = "Marine Captain"
				CFrameQ = CFrame.new(-2440.9934082031, 73.04190826416, -3217.7082519531)
				CFrameMon = CFrame.new(-2335.2026367188, 79.786659240723, -3245.8674316406)
			elseif Lv == 950 or Lv <= 974 or SelectMonster == "Zombie [Lv. 950]" then -- Zombie
				Ms = "Zombie [Lv. 950]"
				NameQuest = "ZombieQuest"
				QuestLv = 1
				NameMon = "Zombie"
				CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
				CFrameMon = CFrame.new(-5536.4970703125, 101.08577728271, -835.59075927734)
			elseif Lv == 975 or Lv <= 999 or SelectMonster == "Vampire [Lv. 975]" then -- Vampire
				Ms = "Vampire [Lv. 975]"
				NameQuest = "ZombieQuest"
				QuestLv = 2
				NameMon = "Vampire"
				CFrameQ = CFrame.new(-5494.3413085938, 48.505931854248, -794.59094238281)
				CFrameMon = CFrame.new(-5806.1098632813, 16.722528457642, -1164.4384765625)
			elseif Lv == 1000 or Lv <= 1049 or SelectMonster == "Snow Trooper [Lv. 1000]" then -- Snow Trooper
				Ms = "Snow Trooper [Lv. 1000]"
				NameQuest = "SnowMountainQuest"
				QuestLv = 1
				NameMon = "Snow Trooper"
				CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
				CFrameMon = CFrame.new(535.21051025391, 432.74209594727, -5484.9165039063)
			elseif Lv == 1050 or Lv <= 1099 or SelectMonster == "Winter Warrior [Lv. 1050]" then -- Winter Warrior
				Ms = "Winter Warrior [Lv. 1050]"
				NameQuest = "SnowMountainQuest"
				QuestLv = 2
				NameMon = "Winter Warrior"
				CFrameQ = CFrame.new(607.05963134766, 401.44781494141, -5370.5546875)
				CFrameMon = CFrame.new(1234.4449462891, 456.95419311523, -5174.130859375)
			elseif Lv == 1100 or Lv <= 1124 or SelectMonster == "Lab Subordinate [Lv. 1100]" then -- Lab Subordinate
				Ms = "Lab Subordinate [Lv. 1100]"
				NameQuest = "IceSideQuest"
				QuestLv = 1
				NameMon = "Lab Subordinate"
				CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
				CFrameMon = CFrame.new(-5720.5576171875, 63.309471130371, -4784.6103515625)
			elseif Lv == 1125 or Lv <= 1174 or SelectMonster == "Horned Warrior [Lv. 1125]" then -- Horned Warrior
				Ms = "Horned Warrior [Lv. 1125]"
				NameQuest = "IceSideQuest"
				QuestLv = 2
				NameMon = "Horned Warrior"
				CFrameQ = CFrame.new(-6061.841796875, 15.926671981812, -4902.0385742188)
				CFrameMon = CFrame.new(-6292.751953125, 91.181983947754, -5502.6499023438)
			elseif Lv == 1175 or Lv <= 1199 or SelectMonster == "Magma Ninja [Lv. 1175]" then -- Magma Ninja
				Ms = "Magma Ninja [Lv. 1175]"
				NameQuest = "FireSideQuest"
				QuestLv = 1
				NameMon = "Magma Ninja"
				CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
				CFrameMon = CFrame.new(-5461.8388671875, 130.36347961426, -5836.4702148438)
			elseif Lv == 1200 or Lv <= 1249 or SelectMonster == "Lava Pirate [Lv. 1200]" then -- Lava Pirate
				Ms = "Lava Pirate [Lv. 1200]"
				NameQuest = "FireSideQuest"
				QuestLv = 2
				NameMon = "Lava Pirate"
				CFrameQ = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
				CFrameMon = CFrame.new(-5251.1889648438, 55.164535522461, -4774.4096679688)
			elseif Lv == 1250 or Lv <= 1274 or SelectMonster == "Ship Deckhand [Lv. 1250]" then -- Ship Deckhand
				Ms = "Ship Deckhand [Lv. 1250]"
				NameQuest = "ShipQuest1"
				QuestLv = 1
				NameMon = "Ship Deckhand"
				CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
				CFrameMon = CFrame.new(921.12365722656, 125.9839553833, 33088.328125)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif Lv == 1275 or Lv <= 1299 or SelectMonster == "Ship Engineer [Lv. 1275]" then -- Ship Engineer
				Ms = "Ship Engineer [Lv. 1275]"
				NameQuest = "ShipQuest1"
				QuestLv = 2
				NameMon = "Ship Engineer"
				CFrameQ = CFrame.new(1040.2927246094, 125.08293151855, 32911.0390625)
				CFrameMon = CFrame.new(886.28179931641, 40.47790145874, 32800.83203125)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif Lv == 1300 or Lv <= 1324 or SelectMonster == "Ship Steward [Lv. 1300]" then -- Ship Steward
				Ms = "Ship Steward [Lv. 1300]"
				NameQuest = "ShipQuest2"
				QuestLv = 1
				NameMon = "Ship Steward"
				CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
				CFrameMon = CFrame.new(943.85504150391, 129.58183288574, 33444.3671875)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif Lv == 1325 or Lv <= 1349 or SelectMonster == "Ship Officer [Lv. 1325]" then -- Ship Officer
				Ms = "Ship Officer [Lv. 1325]"
				NameQuest = "ShipQuest2"
				QuestLv = 2
				NameMon = "Ship Officer"
				CFrameQ = CFrame.new(971.42065429688, 125.08293151855, 33245.54296875)
				CFrameMon = CFrame.new(955.38458251953, 181.08335876465, 33331.890625)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			elseif Lv == 1350 or Lv <= 1374 or SelectMonster == "Arctic Warrior [Lv. 1350]" then -- Arctic Warrior
				Ms = "Arctic Warrior [Lv. 1350]"
				NameQuest = "FrostQuest"
				QuestLv = 1
				NameMon = "Arctic Warrior"
				CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
				CFrameMon = CFrame.new(5935.4541015625, 77.26016998291, -6472.7568359375)
				if Auto_Farm and (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude > 20000 then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
				end
			elseif Lv == 1375 or Lv <= 1424 or SelectMonster == "Snow Lurker [Lv. 1375]" then -- Snow Lurker
				Ms = "Snow Lurker [Lv. 1375]"
				NameQuest = "FrostQuest"
				QuestLv = 2
				NameMon = "Snow Lurker"
				CFrameQ = CFrame.new(5668.1372070313, 28.202531814575, -6484.6005859375)
				CFrameMon = CFrame.new(5628.482421875, 57.574996948242, -6618.3481445313)
			elseif Lv == 1425 or Lv <= 1449 or SelectMonster == "Sea Soldier [Lv. 1425]" then -- Sea Soldier
				Ms = "Sea Soldier [Lv. 1425]"
				NameQuest = "ForgottenQuest"
				QuestLv = 1
				NameMon = "Sea Soldier"
				CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
				CFrameMon = CFrame.new(-3185.0153808594, 58.789089202881, -9663.6064453125)
			elseif Lv >= 1450 or SelectMonster == "Water Fighter [Lv. 1450]" then -- Water Fighter
				Ms = "Water Fighter [Lv. 1450]"
				NameQuest = "ForgottenQuest"
				QuestLv = 2
				NameMon = "Water Fighter"
				CFrameQ = CFrame.new(-3054.5827636719, 236.87213134766, -10147.790039063)
				CFrameMon = CFrame.new(-3262.9301757813, 298.69036865234, -10552.529296875)
			end
		end
		if Three_World then
			if Lv == 1500 or Lv <= 1524 or SelectMonster == "Pirate Millionaire [Lv. 1500]" then -- Pirate Millionaire
				Ms = "Pirate Millionaire [Lv. 1500]"
				NameQuest = "PiratePortQuest"
				QuestLv = 1
				NameMon = "Pirate Millionaire"
				CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
				CFrameMon = CFrame.new(-435.68109130859, 189.69866943359, 5551.0756835938)
			elseif Lv == 1525 or Lv <= 1574 or SelectMonster == "Pistol Billionaire [Lv. 1525]" then -- Pistol Billoonaire
				Ms = "Pistol Billionaire [Lv. 1525]"
				NameQuest = "PiratePortQuest"
				QuestLv = 2
				NameMon = "Pistol Billionaire"
				CFrameQ = CFrame.new(-289.61752319336, 43.819011688232, 5580.0903320313)
				CFrameMon = CFrame.new(-236.53652954102, 217.46676635742, 6006.0883789063)
			elseif Lv == 1575 or Lv <= 1599 or SelectMonster == "Dragon Crew Warrior [Lv. 1575]" then -- Dragon Crew Warrior
				Ms = "Dragon Crew Warrior [Lv. 1575]"
				NameQuest = "AmazonQuest"
				QuestLv = 1
				NameMon = "Dragon Crew Warrior"
				CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
				CFrameMon = CFrame.new(6301.9975585938, 104.77153015137, -1082.6075439453)
			elseif Lv == 1600 or Lv <= 1624 or SelectMonster == "Dragon Crew Archer [Lv. 1600]" then -- Dragon Crew Archer
				Ms = "Dragon Crew Archer [Lv. 1600]"
				NameQuest = "AmazonQuest"
				QuestLv = 2
				NameMon = "Dragon Crew Archer"
				CFrameQ = CFrame.new(5833.1147460938, 51.60498046875, -1103.0693359375)
				CFrameMon = CFrame.new(6831.1171875, 441.76708984375, 446.58615112305)
			elseif Lv == 1625 or Lv <= 1649 or SelectMonster == "Female Islander [Lv. 1625]" then -- Female Islander
				Ms = "Female Islander [Lv. 1625]"
				NameQuest = "AmazonQuest2"
				QuestLv = 1
				NameMon = "Female Islander"
				CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
				CFrameMon = CFrame.new(5792.5166015625, 848.14392089844, 1084.1818847656)
			elseif Lv == 1650 or Lv <= 1699 or SelectMonster == "Giant Islander [Lv. 1650]" then -- Giant Islander
				Ms = "Giant Islander [Lv. 1650]"
				NameQuest = "AmazonQuest2"
				QuestLv = 2
				NameMon = "Giant Islander"
				CFrameQ = CFrame.new(5446.8793945313, 601.62945556641, 749.45672607422)
				CFrameMon = CFrame.new(5009.5068359375, 664.11071777344, -40.960144042969)
			elseif Lv == 1700 or Lv <= 1724 or SelectMonster == "Marine Commodore [Lv. 1700]" then -- Marine Commodore
				Ms = "Marine Commodore [Lv. 1700]"
				NameQuest = "MarineTreeIsland"
				QuestLv = 1
				NameMon = "Marine Commodore"
				CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
				CFrameMon = CFrame.new(2198.0063476563, 128.71075439453, -7109.5043945313)
			elseif Lv == 1725 or Lv <= 1774 or SelectMonster == "Marine Rear Admiral [Lv. 1725]" then -- Marine Rear Admiral
				Ms = "Marine Rear Admiral [Lv. 1725]"
				NameQuest = "MarineTreeIsland"
				QuestLv = 2
				NameMon = "Marine Rear Admiral"
				CFrameQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813)
				CFrameMon = CFrame.new(3294.3142089844, 385.41125488281, -7048.6342773438)
			elseif Lv == 1775 or Lv <= 1799 or SelectMonster == "Fishman Raider [Lv. 1775]" then -- Fishman Raide
				Ms = "Fishman Raider [Lv. 1775]"
				NameQuest = "DeepForestIsland3"
				QuestLv = 1
				NameMon = "Fishman Raider"
				CFrameQ = CFrame.new(-10582.759765625, 331.78845214844, -8757.666015625)
				CFrameMon = CFrame.new(-10553.268554688, 521.38439941406, -8176.9458007813)
			elseif Lv == 1800 or Lv <= 1824 or SelectMonster == "Fishman Captain [Lv. 1800]" then -- Fishman Captain
				Ms = "Fishman Captain [Lv. 1800]"
				NameQuest = "DeepForestIsland3"
				QuestLv = 2
				NameMon = "Fishman Captain"
				CFrameQ = CFrame.new(-10583.099609375, 331.78845214844, -8759.4638671875)
				CFrameMon = CFrame.new(-10789.401367188, 427.18637084961, -9131.4423828125)
			elseif Lv == 1825 or Lv <= 1849 or SelectMonster == "Forest Pirate [Lv. 1825]" then -- Forest Pirate
				Ms = "Forest Pirate [Lv. 1825]"
				NameQuest = "DeepForestIsland"
				QuestLv = 1
				NameMon = "Forest Pirate"
				CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
				CFrameMon = CFrame.new(-13489.397460938, 400.30349731445, -7770.251953125)
			elseif Lv == 1850 or Lv <= 1899 or SelectMonster == "Mythological Pirate [Lv. 1850]" then -- Mythological Pirate
				Ms = "Mythological Pirate [Lv. 1850]"
				NameQuest = "DeepForestIsland"
				QuestLv = 2
				NameMon = "Mythological Pirate"
				CFrameQ = CFrame.new(-13232.662109375, 332.40396118164, -7626.4819335938)
				CFrameMon = CFrame.new(-13508.616210938, 582.46228027344, -6985.3037109375)
			elseif Lv == 1900 or Lv <= 1924 or SelectMonster == "Jungle Pirate [Lv. 1900]" then -- Jungle Pirate
				Ms = "Jungle Pirate [Lv. 1900]"
				NameQuest = "DeepForestIsland2"
				QuestLv = 1
				NameMon = "Jungle Pirate"
				CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
				CFrameMon = CFrame.new(-12267.103515625, 459.75262451172, -10277.200195313)
			elseif Lv == 1925 or Lv <= 1974 or SelectMonster == "Musketeer Pirate [Lv. 1925]" then -- Musketeer Pirate
				Ms = "Musketeer Pirate [Lv. 1925]"
				NameQuest = "DeepForestIsland2"
				QuestLv = 2
				NameMon = "Musketeer Pirate"
				CFrameQ = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
				CFrameMon = CFrame.new(-13291.5078125, 520.47338867188, -9904.638671875)
			elseif Lv == 1975 or Lv <= 1999 or SelectMonster == "Reborn Skeleton [Lv. 1975]" then
				Ms = "Reborn Skeleton [Lv. 1975]"
				NameQuest = "HauntedQuest1"
				QuestLv = 1
				NameMon = "Reborn Skeleton"
				CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
				CFrameMon = CFrame.new(-8761.77148, 183.431747, 6168.33301, 0.978073597, -1.3950732e-05, -0.208259016, -1.08073925e-06, 1, -7.20630269e-05, 0.208259016, 7.07080399e-05, 0.978073597)
			elseif Lv == 2000 or Lv <= 2024 or SelectMonster == "Living Zombie [Lv. 2000]" then
				Ms = "Living Zombie [Lv. 2000]"
				NameQuest = "HauntedQuest1"
				QuestLv = 2
				NameMon = "Living Zombie"
				CFrameQ = CFrame.new(-9480.80762, 142.130661, 5566.37305, -0.00655503059, 4.52954225e-08, -0.999978542, 2.04920472e-08, 1, 4.51620679e-08, 0.999978542, -2.01955679e-08, -0.00655503059)
				CFrameMon = CFrame.new(-10103.7529, 238.565979, 6179.75977, 0.999474227, 2.77547141e-08, 0.0324240364, -2.58006327e-08, 1, -6.06848474e-08, -0.0324240364, 5.98163865e-08, 0.999474227)
			elseif Lv == 2025 or Lv <= 2049 or SelectMonster == "Demonic Soul [Lv. 2025]" then
				Ms = "Demonic Soul [Lv. 2025]"
				NameQuest = "HauntedQuest2"
				QuestLv = 1
				NameMon = "Demonic Soul"
				CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
				CFrameMon = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)
			elseif Lv == 2050 or Lv <= 2074 or SelectMonster == "Posessed Mummy [Lv. 2050]" then
				Ms = "Posessed Mummy [Lv. 2050]"
				NameQuest = "HauntedQuest2"
				QuestLv = 2
				NameMon = "Posessed Mummy"
				CFrameQ = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
				CFrameMon = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)
			elseif Lv == 2075 and Lv <= 2099 or SelectMonster == "Peanut Scout [Lv. 2075]" then
				Ms = "Peanut Scout [Lv. 2075]"
				NameQuest = "NutsIslandQuest"
				QuestLv = 1
				NameMon = "Peanut Scout"
				CFrameQ = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
				CFrameMon = CFrame.new(-2126.47998, 192.095154, -10204.6553, 0.0779861137, -9.29044361e-08, 0.996954441, 6.59006432e-08, 1, 8.80332109e-08, -0.996954441, 5.88345728e-08, 0.0779861137)
			elseif Lv == 2100 and Lv <= 2124 or SelectMonster == "Peanut President [Lv. 2100]" then
				Ms = "Peanut President [Lv. 2100]"
				NameQuest = "NutsIslandQuest"
				QuestLv = 2
				NameMon = "Peanut President"
				CFrameQ = CFrame.new(-2105.53198, 37.2495995, -10195.5088, -0.766061664, 0, -0.642767608, 0, 1, 0, 0.642767608, 0, -0.766061664)
				CFrameMon = CFrame.new(-2126.47998, 192.095154, -10204.6553, 0.0779861137, -9.29044361e-08, 0.996954441, 6.59006432e-08, 1, 8.80332109e-08, -0.996954441, 5.88345728e-08, 0.0779861137)
			elseif Lv == 2125 and Lv <= 2149 or SelectMonster == "Ice Cream Chef [Lv. 2125]" then
				Ms = "Ice Cream Chef [Lv. 2125]"
				NameQuest = "IceCreamIslandQuest"
				QuestLv = 1
				NameMon = "Ice Cream Chef"
				CFrameQ = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
				CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012, -0, 0.997525275, 0, -0.0703101456)
			elseif Lv == 2150 or Lv <= 2199 or SelectMonster == "Ice Cream Commander [Lv. 2150]" then
				Ms = "Ice Cream Commander [Lv. 2150]"
				NameQuest = "IceCreamIslandQuest"
				QuestLv = 2
				NameMon = "Ice Cream Commander"
				CFrameQ = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
				CFrameMon = CFrame.new(-789.941528, 209.382889, -11009.9805, -0.0703101531, -0, -0.997525156, -0, 1.00000012, -0, 0.997525275, 0, -0.0703101456)
			elseif Lv == 2200 or Lv <= 2224 or SelectMonster == "Cookie Crafter [Lv. 2200]" then
				Ms = "Cookie Crafter [Lv. 2200]"
				NameQuest = "CakeQuest1"
				QuestLv = 1
				NameMon = "Cookie Crafter"
				CFrameQ = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
				CFrameMon = CFrame.new(-2321.71216, 36.699482, -12216.7871, -0.780074954, 0, 0.625686109, 0, 1, 0, -0.625686109, 0, -0.780074954)
			elseif Lv == 2225 or Lv <= 2249 or SelectMonster == "Cake Guard [Lv. 2225]" then
				Ms = "Cake Guard [Lv. 2225]"
				NameQuest = "CakeQuest1"
				QuestLv = 2
				NameMon = "Cake Guard"
				CFrameQ = CFrame.new(-2022.29858, 36.9275894, -12030.9766, -0.961273909, 0, -0.275594592, 0, 1, 0, 0.275594592, 0, -0.961273909)
				CFrameMon = CFrame.new(-1418.11011, 36.6718941, -12255.7324, 0.0677844882, 0, 0.997700036, 0, 1, 0, -0.997700036, 0, 0.0677844882)
			elseif Lv == 2250 or Lv <= 2274 or SelectMonster == "Baking Staff [Lv. 2250]" then
				Ms = "Baking Staff [Lv. 2250]"
				NameQuest = "CakeQuest2"
				QuestLv = 1
				NameMon = "Baking Staff"
				CFrameQ = CFrame.new(-1928.31763, 37.7296638, -12840.626, 0.951068401, -0, -0.308980465, 0, 1, -0, 0.308980465, 0, 0.951068401)
				CFrameMon = CFrame.new(-1980.43848, 36.6716766, -12983.8418, -0.254443765, 0, -0.967087567, 0, 1, 0, 0.967087567, 0, -0.254443765)
			elseif Lv == 2275 or Lv <= 2299 or SelectMonster == "Head Baker [Lv. 2275]" then
				Ms = "Head Baker [Lv. 2275]"
				NameQuest = "CakeQuest2"
				QuestLv = 2
				NameMon = "Head Baker"
				CFrameQ = CFrame.new(-1927.9107666015625, 37.79813003540039, -12843.78515625)
				CFrameMon = CFrame.new(-2203.302490234375, 109.90937042236328, -12788.7333984375)
			elseif MyLevel == 2300 or Lv <= 2324 or SelectMonster == "Cocoa Warrior [Lv. 2300]" then
				Ms = "Cocoa Warrior [Lv. 2300]"
				NameQuest = "ChocQuest1"
				QuestLv = 1
				NameMon = "Cocoa Warrior"
				CFrameQ = CFrame.new(231.13571166992188, 24.734268188476562, -12195.1162109375)
				CFrameMon = CFrame.new(231.13571166992188, 24.734268188476562, -12195.1162109375)
			elseif MyLevel == 2325 or Lv <= 2349 or SelectMonster == "Chocolate Bar Battler [Lv. 2325]" then
				Ms = "Chocolate Bar Battler [Lv. 2325]"
				NameQuest = "ChocQuest1"
				QuestLv = 2
				NameMon = "Chocolate Bar Battler"
				CFrameQ = CFrame.new(231.13571166992188, 24.734268188476562, -12195.1162109375)
				CFrameMon = CFrame.new(231.13571166992188, 24.734268188476562, -12195.1162109375)
			elseif Lv == 2350 or Lv <= 2374 or SelectMonster == "Sweet Thief [Lv. 2350]" then
				Ms = "Sweet Thief [Lv. 2350]"
				NameQuest = "ChocQuest2"
				QuestLv = 1
				NameMon = "Sweet Thief"
				CFrameQ = CFrame.new(147.52256774902344, 24.793832778930664, -12775.3583984375)
				CFrameMon = CFrame.new(147.52256774902344, 24.793832778930664, -12775.3583984375)
			elseif Lv >= 2375 or SelectMonster == "Candy Rebel [Lv. 2375]" then
				Ms = "Candy Rebel [Lv. 2375]"
				NameQuest = "ChocQuest2"
				QuestLv = 2
				NameMon = "Candy Rebel"
				CFrameQ = CFrame.new(147.52256774902344, 24.793832778930664, -12775.3583984375)
				CFrameMon = CFrame.new(147.52256774902344, 24.793832778930664, -12775.3583984375)
			end
		end
	end

	function EquipWeapon(ToolSe)
		if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
			local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
			wait(.4)
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
		end
	end

	Type = 1
	spawn(function()
		while wait(.1) do
			if Type == 1 then
				Farm_Mode = CFrame.new(0, 15, 0)
			end
		end
	end)

	spawn(function()
		while wait(.1) do
			Type = 1
			wait(.1)
		end
	end)

	pcall(function()
		for i,v in pairs(game:GetService("Workspace").Map.Dressrosa.Tavern:GetDescendants()) do
			if v.ClassName == "Seat" then
				v:Destroy()
			end
		end
	end)

	spawn(function()
		while wait() do
			if Auto_Farm then
				if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
					MagnetActive = false
					CheckLevel()
					totarget(CFrameQ)
					if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 4 then
						wait(1.1)
						CheckLevel()
						if (CFrameQ.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 20 then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, QuestLv)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
						else
							totarget(CFrameQ)
						end
					end
				elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true then
					pcall(function()
						CheckLevel()
						if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
							for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
								if v.Name == Ms and v:FindFirstChild("Humanoid") then
									if v.Humanoid.Health > 0 then
										repeat game:GetService("RunService").Heartbeat:wait()
											if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
												if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, NameMon) then
													EquipWeapon(SelectToolWeapon)
													totarget(v.HumanoidRootPart.CFrame * Farm_Mode)
													v.HumanoidRootPart.CanCollide = false
													v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
													game:GetService("VirtualUser"):CaptureController()
													game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 670),workspace.CurrentCamera.CFrame)
													PosMon = v.HumanoidRootPart.CFrame
													MagnetActive = true
												else
													MagnetActive = false    
													game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
												end
											else
												MagnetActive = false
												CheckLevel()
												totarget(CFrameMon)
											end
										until not v.Parent or v.Humanoid.Health <= 0 or Auto_Farm == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false or not game:GetService("Workspace").Enemies:FindFirstChild(v.Name)
									end
								end
							end
						else
							MagnetActive = false
							CheckLevel()
							totarget(CFrameMon)
						end
					end)
				end
			end
		end
	end)

	function Click()
		game:GetService'VirtualUser':CaptureController()
		game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
	end

	if SelectToolWeapon then
	else
		SelectToolWeapon = ""
	end

	SelectBoss = ""
		function CheckQuestBoss()
			-- Old World
			if SelectBoss == "Saber Expert [Lv. 200] [Boss]" then
				MsBoss = "Saber Expert [Lv. 200] [Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = ""
				CFrameQuestBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564)
				CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564, 0.858821094, 1.13848939e-08, 0.512275636, -4.85649254e-09, 1, -1.40823326e-08, -0.512275636, 9.6063415e-09, 0.858821094)
			elseif SelectBoss == "The Saw [Lv. 100] [Boss]" then
				MsBoss = "The Saw [Lv. 100] [Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = ""
				CFrameQuestBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854)
				CFrameBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854, -0.290192783, 6.88365773e-08, 0.956968188, 6.98413629e-08, 1, -5.07531119e-08, -0.956968188, 5.21077759e-08, -0.290192783)
			elseif SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" then
				MsBoss = "Greybeard [Lv. 750] [Raid Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = ""
				CFrameQuestBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666)
				CFrameBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666, -0.433646321, -1.03394289e-08, 0.901083171, -3.0443168e-08, 1, -3.17633075e-09, -0.901083171, -2.88092288e-08, -0.433646321)
			elseif SelectBoss == "Mob Leader [Lv. 120] [Boss]" then
				MsBoss = "Mob Leader [Lv. 120] [Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = ""
				CFrameQuestBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043)
				CFrameBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.92824)
			
			elseif SelectBoss == "The Gorilla King [Lv. 25] [Boss]" then
				MsBoss = "The Gorilla King [Lv. 25] [Boss]"
				NameQuestBoss = "JungleQuest"
				LevelQuestBoss = 3
				NameBoss = "The Gorilla King"
				CFrameQuestBoss = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
				CFrameBoss = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-08, 0.950426519, -3.37275488e-08, 1, 7.06501808e-08, -0.950426519, -5.40241736e-08, 0.310949147)
			elseif SelectBoss == "Bobby [Lv. 55] [Boss]" then
				MsBoss = "Bobby [Lv. 55] [Boss]"
				NameQuestBoss = "BuggyQuest1"
				LevelQuestBoss = 3
				NameBoss = "Bobby"
				CFrameQuestBoss = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
				CFrameBoss = CFrame.new(-1147.65173, 32.5966301, 4156.02588, 0.956680477, -1.77109952e-10, -0.29113996, 5.16530874e-10, 1, 1.08897802e-09, 0.29113996, -1.19218679e-09, 0.956680477)
			elseif SelectBoss == "Yeti [Lv. 110] [Boss]" then
				MsBoss = "Yeti [Lv. 110] [Boss]"
				NameQuestBoss = "SnowQuest"
				LevelQuestBoss = 3
				NameBoss = "Yeti"
				CFrameQuestBoss = CFrame.new(1384.90247, 87.3078308, -1296.6825, 0.280209213, 2.72035177e-08, -0.959938943, -6.75690828e-08, 1, 8.6151708e-09, 0.959938943, 6.24481444e-08, 0.280209213)
				CFrameBoss = CFrame.new(1221.7356, 138.046906, -1488.84082, 0.349343032, -9.49245944e-08, 0.936994851, 6.29478194e-08, 1, 7.7838429e-08, -0.936994851, 3.17894653e-08, 0.349343032)
			elseif SelectBoss == "Vice Admiral [Lv. 130] [Boss]" then
				MsBoss = "Vice Admiral [Lv. 130] [Boss]"
				NameQuestBoss = "MarineQuest2"
				LevelQuestBoss = 2
				NameBoss = "Vice Admiral"
				CFrameQuestBoss = CFrame.new(-5035.42285, 28.6520386, 4324.50293, -0.0611100644, -8.08395768e-08, 0.998130739, -1.57416586e-08, 1, 8.00271849e-08, -0.998130739, -1.08217701e-08, -0.0611100644)
				CFrameBoss = CFrame.new(-5078.45898, 99.6520691, 4402.1665, -0.555574954, -9.88630566e-11, 0.831466436, -6.35508286e-08, 1, -4.23449258e-08, -0.831466436, -7.63661632e-08, -0.555574954)
			elseif SelectBoss == "Warden [Lv. 175] [Boss]" then
				MsBoss = "Warden [Lv. 175] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 1
				NameBoss = "Warden"
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Chief Warden [Lv. 200] [Boss]" then
				MsBoss = "Chief Warden [Lv. 200] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 2
				NameBoss = "Chief Warden"
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Swan [Lv. 225] [Boss]" then
				MsBoss = "Swan [Lv. 225] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 3
				NameBoss = "Swan"
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Magma Admiral [Lv. 350] [Boss]" then
				MsBoss = "Magma Admiral [Lv. 350] [Boss]"
				NameQuestBoss = "MagmaQuest"
				LevelQuestBoss = 3
				NameBoss = "Magma Admiral"
				CFrameQuestBoss = CFrame.new(-5317.07666, 12.2721891, 8517.41699, 0.51175487, -2.65508806e-08, -0.859131515, -3.91131572e-08, 1, -5.42026761e-08, 0.859131515, 6.13418294e-08, 0.51175487)
				CFrameBoss = CFrame.new(-5530.12646, 22.8769703, 8859.91309, 0.857838571, 2.23414389e-08, 0.513919294, 1.53689133e-08, 1, -6.91265853e-08, -0.513919294, 6.71978384e-08, 0.857838571)
			elseif SelectBoss == "Fishman Lord [Lv. 425] [Boss]" then
				MsBoss = "Fishman Lord [Lv. 425] [Boss]"
				NameQuestBoss = "FishmanQuest"
				LevelQuestBoss = 3
				NameBoss = "Fishman Lord"
				CFrameQuestBoss = CFrame.new(61123.0859, 18.5066795, 1570.18018, 0.927145958, 1.0624845e-07, 0.374700129, -6.98219367e-08, 1, -1.10790765e-07, -0.374700129, 7.65569368e-08, 0.927145958)
				CFrameBoss = CFrame.new(61351.7773, 31.0306778, 1113.31409, 0.999974668, 0, -0.00714713801, 0, 1.00000012, 0, 0.00714714266, 0, 0.999974549)
			elseif SelectBoss == "Wysper [Lv. 500] [Boss]" then
				MsBoss = "Wysper [Lv. 500] [Boss]"
				NameQuestBoss = "SkyExp1Quest"
				LevelQuestBoss = 3
				NameBoss = "Wysper"
				CFrameQuestBoss = CFrame.new(-7862.94629, 5545.52832, -379.833954, 0.462944925, 1.45838088e-08, -0.886386991, 1.0534996e-08, 1, 2.19553424e-08, 0.886386991, -1.95022007e-08, 0.462944925)
				CFrameBoss = CFrame.new(-7925.48389, 5550.76074, -636.178345, 0.716468513, -1.22915289e-09, 0.697619379, 3.37381434e-09, 1, -1.70304748e-09, -0.697619379, 3.57381835e-09, 0.716468513)
			elseif SelectBoss == "Thunder God [Lv. 575] [Boss]" then
				MsBoss = "Thunder God [Lv. 575] [Boss]"
				NameQuestBoss = "SkyExp2Quest"
				LevelQuestBoss = 3
				NameBoss = "Thunder God"
				CFrameQuestBoss = CFrame.new(-7902.78613, 5635.99902, -1411.98706, -0.0361216255, -1.16895912e-07, 0.999347389, 1.44533963e-09, 1, 1.17024491e-07, -0.999347389, 5.6715117e-09, -0.0361216255)
				CFrameBoss = CFrame.new(-7917.53613, 5616.61377, -2277.78564, 0.965189934, 4.80563429e-08, -0.261550069, -6.73089886e-08, 1, -6.46515304e-08, 0.261550069, 8.00056768e-08, 0.965189934)
			elseif SelectBoss == "Cyborg [Lv. 675] [Boss]" then
				MsBoss = "Cyborg [Lv. 675] [Boss]"
				NameQuestBoss = "FountainQuest"
				LevelQuestBoss = 3
				NameBoss = "Cyborg"
				CFrameQuestBoss = CFrame.new(5253.54834, 38.5361786, 4050.45166, -0.0112687312, -9.93677887e-08, -0.999936521, 2.55291371e-10, 1, -9.93769547e-08, 0.999936521, -1.37512213e-09, -0.0112687312)
				CFrameBoss = CFrame.new(6041.82813, 52.7112198, 3907.45142, -0.563162148, 1.73805248e-09, -0.826346457, -5.94632716e-08, 1, 4.26280238e-08, 0.826346457, 7.31437524e-08, -0.563162148)
			
				-- New World
			elseif SelectBoss == "Don Swan [Lv. 1000] [Boss]" then
				MsBoss = "Don Swan [Lv. 1000] [Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = "Don Swan"
				CFrameBoss = CFrame.new(2288.802, 15.1870775, 863.034607, 0.99974072, -8.41247214e-08, -0.0227668174, 8.4774733e-08, 1, 2.75850098e-08, 0.0227668174, -2.95079072e-08, 0.99974072)
			
			elseif SelectBoss == "Diamond [Lv. 750] [Boss]" then
				MsBoss = "Diamond [Lv. 750] [Boss]"
				NameQuestBoss = "Area1Quest"
				LevelQuestBoss = 3
				NameBoss = "Diamond"
				CFrameQuestBoss = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601, -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
				CFrameBoss = CFrame.new(-1736.26587, 198.627731, -236.412857, -0.997808516, 0, -0.0661673471, 0, 1, 0, 0.0661673471, 0, -0.997808516)
			elseif SelectBoss == "Jeremy [Lv. 850] [Boss]" then
				MsBoss = "Jeremy [Lv. 850] [Boss]"
				NameQuestBoss = "Area2Quest"
				LevelQuestBoss = 3
				NameBoss = "Jeremy"
				CFrameQuestBoss = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
				CFrameBoss = CFrame.new(2203.76953, 448.966034, 752.731079, -0.0217453763, 0, -0.999763548, 0, 1, 0, 0.999763548, 0, -0.0217453763)
			elseif SelectBoss == "Fajita [Lv. 925] [Boss]" then
				MsBoss = "Fajita [Lv. 925] [Boss]"
				NameQuestBoss = "MarineQuest3"
				LevelQuestBoss = 3
				NameBoss = "Fajita"
				CFrameQuestBoss = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301, 5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
				CFrameBoss = CFrame.new(-2297.40332, 115.449463, -3946.53833, 0.961227536, -1.46645796e-09, -0.275756449, -2.3212845e-09, 1, -1.34094433e-08, 0.275756449, 1.35296352e-08, 0.961227536)
			elseif SelectBoss == "Smoke Admiral [Lv. 1150] [Boss]" then
				MsBoss = "Smoke Admiral [Lv. 1150] [Boss]"
				NameQuestBoss = "IceSideQuest"
				LevelQuestBoss = 3
				NameBoss = "Smoke Admiral"
				CFrameQuestBoss = CFrame.new(-6059.96191, 15.9868021, -4904.7373, -0.444992423, -3.0874483e-09, 0.895534337, -3.64098796e-08, 1, -1.4644522e-08, -0.895534337, -3.91229982e-08, -0.444992423)
				CFrameBoss = CFrame.new(-5115.72754, 23.7664986, -5338.2207, 0.251453817, 1.48345061e-08, -0.967869282, 4.02796978e-08, 1, 2.57916977e-08, 0.967869282, -4.54708946e-08, 0.251453817)
			elseif SelectBoss == "Awakened Ice Admiral [Lv. 1400] [Boss]" then
				MsBoss = "Awakened Ice Admiral [Lv. 1400] [Boss]"
				NameQuestBoss = "FrostQuest"
				LevelQuestBoss = 3
				NameBoss = "Awakened Ice Admiral"
				CFrameQuestBoss = CFrame.new(5669.33203, 28.2118053, -6481.55908, 0.921275556, -1.25320829e-08, 0.388910472, 4.72230788e-08, 1, -7.96414241e-08, -0.388910472, 9.17372489e-08, 0.921275556)
				CFrameBoss = CFrame.new(6407.33936, 340.223785, -6892.521, 0.49051559, -5.25310213e-08, -0.871432424, -2.76146022e-08, 1, -7.58250565e-08, 0.871432424, 6.12576301e-08, 0.49051559)
			elseif SelectBoss == "Tide Keeper [Lv. 1475] [Boss]" then
				MsBoss = "Tide Keeper [Lv. 1475] [Boss]"
				NameQuestBoss = "ForgottenQuest"             
				LevelQuestBoss = 3
				NameBoss = "Tide Keeper"
				CFrameQuestBoss = CFrame.new(-3053.89648, 236.881363, -10148.2324, -0.985987961, -3.58504737e-09, 0.16681771, -3.07832915e-09, 1, 3.29612559e-09, -0.16681771, 2.73641976e-09, -0.985987961)
				CFrameBoss = CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -1.3857326e-08, 0.885206044, 4.0332897e-09, 1, 1.35347511e-08, -0.885206044, -2.72606271e-09, 0.465199202)
			
			elseif SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" then
				MsBoss = "Cursed Captain [Lv. 1325] [Raid Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = "Cursed Captain"
				CFrameQuestBoss = CFrame.new(916.928589, 181.092773, 33422)
				CFrameBoss = CFrame.new(916.928589, 181.092773, 33422, -0.999505103, 9.26310495e-09, 0.0314563364, 8.42916226e-09, 1, -2.6643713e-08, -0.0314563364, -2.63653774e-08, -0.999505103)
			elseif SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
				MsBoss = "Darkbeard [Lv. 1000] [Raid Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = "Darkbeard"
				CFrameQuestBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777)
				CFrameBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777, -0.976951957, 4.97356325e-08, 0.213458836, 4.57335361e-08, 1, -2.36868622e-08, -0.213458836, -1.33787044e-08, -0.976951957)
			elseif SelectBoss == "Order [Lv. 1250] [Raid Boss]" then
				MsBoss = "Order [Lv. 1250] [Raid Boss]"
				NameQuestBoss = ""
				LevelQuestBoss = 3
				NameBoss = "Order"
				CFrameQuestBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584)
				CFrameBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584, -0.380726993, 7.41463495e-08, 0.924687505, 5.85604774e-08, 1, -5.60738549e-08, -0.924687505, 3.28013137e-08, -0.380726993)
			
				-- Thire World
			elseif SelectBoss == "Stone [Lv. 1550] [Boss]" then
				MsBoss = "Stone [Lv. 1550] [Boss]"
				NameQuestBoss = "PiratePortQuest"             
				LevelQuestBoss = 3
				NameBoss = "Stone"
				CFrameQuestBoss = CFrame.new(-290, 44, 5577)
				CFrameBoss = CFrame.new(-1085, 40, 6779)
			elseif SelectBoss == "Island Empress [Lv. 1675] [Boss]" then
				MsBoss = "Island Empress [Lv. 1675] [Boss]"
				NameQuestBoss = "AmazonQuest2"             
				LevelQuestBoss = 3
				NameBoss = "Island Empress"
				CFrameQuestBoss = CFrame.new(5443, 602, 752)
				CFrameBoss = CFrame.new(5659, 602, 244)
			elseif SelectBoss == "Kilo Admiral [Lv. 1750] [Boss]" then
				MsBoss = "Kilo Admiral [Lv. 1750] [Boss]"
				NameQuestBoss = "MarineTreeIsland"             
				LevelQuestBoss = 3
				NameBoss = "Kilo Admiral"
				CFrameQuestBoss = CFrame.new(2178, 29, -6737)
				CFrameBoss =CFrame.new(2846, 433, -7100)
			elseif SelectBoss == "Captain Elephant [Lv. 1875] [Boss]" then
				MsBoss = "Captain Elephant [Lv. 1875] [Boss]"
				NameQuestBoss = "DeepForestIsland"             
				LevelQuestBoss = 3
				NameBoss = "Captain Elephant"
				CFrameQuestBoss = CFrame.new(-13232, 333, -7631)
				CFrameBoss = CFrame.new(-13221, 325, -8405)
			elseif SelectBoss == "Beautiful Pirate [Lv. 1950] [Boss]" then
				MsBoss = "Beautiful Pirate [Lv. 1950] [Boss]"
				NameQuestBoss = "DeepForestIsland2"             
				LevelQuestBoss = 3
				NameBoss = "Beautiful Pirate"
				CFrameQuestBoss = CFrame.new(-12686, 391, -9902)
				CFrameBoss = CFrame.new(5182, 23, -20)
			elseif SelectBoss == "Cake Queen [Lv. 2175] [Boss]" then
				MsBoss = "Cake Queen [Lv. 2175] [Boss]"
				NameQuestBoss = "IceCreamIslandQuest"             
				LevelQuestBoss = 3
				NameBoss = "Cake Queen"
				CFrameQuestBoss = CFrame.new(-716, 382, -11010)
				CFrameBoss = CFrame.new(-821, 66, -10965)
		
			elseif SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" then
				MsBoss = "rip_indra True Form [Lv. 5000] [Raid Boss]"
				LevelQuestBoss = 3
				NameQuestBoss = ""
				NameBoss = "rip_indra True Form"
				CFrameQuestBoss = CFrame.new(-5359, 424, -2735)
				CFrameBoss = CFrame.new(-5359, 424, -2735)
			elseif SelectBoss == "Longma [Lv. 2000] [Boss]" then
				MsBoss = "Longma [Lv. 2000] [Boss]"
				LevelQuestBoss = 3
				NameQuestBoss = ""
				NameBoss = "Longma"
				CFrameQuestBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
				CFrameBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
			elseif SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" then
				MsBoss = "Soul Reaper [Lv. 2100] [Raid Boss]"
				LevelQuestBoss = 3
				NameQuestBoss = ""
				NameBoss = "Soul Reaper"
				CFrameQuestBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
				CFrameBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
			end
		end
		CheckQuestBoss() 
		
		AutoQuestBoss = true
		function CheckQuestBoss()
			-- Old World
			if SelectBoss == "Saber Expert [Lv. 200] [Boss]" then
				MsBoss = "Saber Expert [Lv. 200] [Boss]"
				CFrameBoss = CFrame.new(-1458.89502, 29.8870335, -50.633564, 0.858821094, 1.13848939e-08, 0.512275636, -4.85649254e-09, 1, -1.40823326e-08, -0.512275636, 9.6063415e-09, 0.858821094)
			elseif SelectBoss == "The Saw [Lv. 100] [Boss]" then
				MsBoss = "The Saw [Lv. 100] [Boss]"
				CFrameBoss = CFrame.new(-683.519897, 13.8534927, 1610.87854, -0.290192783, 6.88365773e-08, 0.956968188, 6.98413629e-08, 1, -5.07531119e-08, -0.956968188, 5.21077759e-08, -0.290192783)
			elseif SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" then
				MsBoss = "Greybeard [Lv. 750] [Raid Boss]"
				CFrameBoss = CFrame.new(-4955.72949, 80.8163834, 4305.82666, -0.433646321, -1.03394289e-08, 0.901083171, -3.0443168e-08, 1, -3.17633075e-09, -0.901083171, -2.88092288e-08, -0.433646321)
			elseif SelectBoss == "The Gorilla King [Lv. 25] [Boss]" then
				MsBoss = "The Gorilla King [Lv. 25] [Boss]"
				NameQuestBoss = "JungleQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
				CFrameBoss = CFrame.new(-1223.52808, 6.27936459, -502.292664, 0.310949147, -5.66602516e-08, 0.950426519, -3.37275488e-08, 1, 7.06501808e-08, -0.950426519, -5.40241736e-08, 0.310949147)
			elseif SelectBoss == "Bobby [Lv. 55] [Boss]" then
				MsBoss = "Bobby [Lv. 55] [Boss]"
				NameQuestBoss = "BuggyQuest1"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-1139.59717, 4.75205183, 3825.16211, -0.959730506, -7.5857054e-09, 0.280922383, -4.06310328e-08, 1, -1.11807175e-07, -0.280922383, -1.18718916e-07, -0.959730506)
				CFrameBoss = CFrame.new(-1147.65173, 32.5966301, 4156.02588, 0.956680477, -1.77109952e-10, -0.29113996, 5.16530874e-10, 1, 1.08897802e-09, 0.29113996, -1.19218679e-09, 0.956680477)
			elseif SelectBoss == "Yeti [Lv. 110] [Boss]" then
				MsBoss = "Yeti [Lv. 110] [Boss]"
				NameQuestBoss = "SnowQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(1384.90247, 87.3078308, -1296.6825, 0.280209213, 2.72035177e-08, -0.959938943, -6.75690828e-08, 1, 8.6151708e-09, 0.959938943, 6.24481444e-08, 0.280209213)
				CFrameBoss = CFrame.new(1221.7356, 138.046906, -1488.84082, 0.349343032, -9.49245944e-08, 0.936994851, 6.29478194e-08, 1, 7.7838429e-08, -0.936994851, 3.17894653e-08, 0.349343032)
			elseif SelectBoss == "Mob Leader [Lv. 120] [Boss]" then
				MsBoss = "Mob Leader [Lv. 120] [Boss]"
				CFrameBoss = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.92824)
			elseif SelectBoss == "Vice Admiral [Lv. 130] [Boss]" then
				MsBoss = "Vice Admiral [Lv. 130] [Boss]"
				NameQuestBoss = "MarineQuest2"
				LevelQuestBoss = 2
				CFrameQuestBoss = CFrame.new(-5035.42285, 28.6520386, 4324.50293, -0.0611100644, -8.08395768e-08, 0.998130739, -1.57416586e-08, 1, 8.00271849e-08, -0.998130739, -1.08217701e-08, -0.0611100644)
				CFrameBoss = CFrame.new(-5078.45898, 99.6520691, 4402.1665, -0.555574954, -9.88630566e-11, 0.831466436, -6.35508286e-08, 1, -4.23449258e-08, -0.831466436, -7.63661632e-08, -0.555574954)
			elseif SelectBoss == "Warden [Lv. 175] [Boss]" then
				MsBoss = "Warden [Lv. 175] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 1
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Chief Warden [Lv. 200] [Boss]" then
				MsBoss = "Chief Warden [Lv. 200] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 2
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Swan [Lv. 225] [Boss]" then
				MsBoss = "Swan [Lv. 225] [Boss]"
				NameQuestBoss = "ImpelQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(4851.35059, 5.68744135, 743.251282, -0.538484037, -6.68303741e-08, -0.842635691, 1.38001752e-08, 1, -8.81300792e-08, 0.842635691, -5.90851599e-08, -0.538484037)
				CFrameBoss = CFrame.new(5232.5625, 5.26856995, 747.506897, 0.943829298, -4.5439414e-08, 0.330433697, 3.47818627e-08, 1, 3.81658154e-08, -0.330433697, -2.45289105e-08, 0.943829298)
			elseif SelectBoss == "Magma Admiral [Lv. 350] [Boss]" then
				MsBoss = "Magma Admiral [Lv. 350] [Boss]"
				NameQuestBoss = "MagmaQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-5317.07666, 12.2721891, 8517.41699, 0.51175487, -2.65508806e-08, -0.859131515, -3.91131572e-08, 1, -5.42026761e-08, 0.859131515, 6.13418294e-08, 0.51175487)
				CFrameBoss = CFrame.new(-5530.12646, 22.8769703, 8859.91309, 0.857838571, 2.23414389e-08, 0.513919294, 1.53689133e-08, 1, -6.91265853e-08, -0.513919294, 6.71978384e-08, 0.857838571)
			elseif SelectBoss == "Fishman Lord [Lv. 425] [Boss]" then
				MsBoss = "Fishman Lord [Lv. 425] [Boss]"
				NameQuestBoss = "FishmanQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(61123.0859, 18.5066795, 1570.18018, 0.927145958, 1.0624845e-07, 0.374700129, -6.98219367e-08, 1, -1.10790765e-07, -0.374700129, 7.65569368e-08, 0.927145958)
				CFrameBoss = CFrame.new(61351.7773, 31.0306778, 1113.31409, 0.999974668, 0, -0.00714713801, 0, 1.00000012, 0, 0.00714714266, 0, 0.999974549)
			elseif SelectBoss == "Wysper [Lv. 500] [Boss]" then
				MsBoss = "Wysper [Lv. 500] [Boss]"
				NameQuestBoss = "SkyExp1Quest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-7862.94629, 5545.52832, -379.833954, 0.462944925, 1.45838088e-08, -0.886386991, 1.0534996e-08, 1, 2.19553424e-08, 0.886386991, -1.95022007e-08, 0.462944925)
				CFrameBoss = CFrame.new(-7925.48389, 5550.76074, -636.178345, 0.716468513, -1.22915289e-09, 0.697619379, 3.37381434e-09, 1, -1.70304748e-09, -0.697619379, 3.57381835e-09, 0.716468513)
			elseif SelectBoss == "Thunder God [Lv. 575] [Boss]" then
				MsBoss = "Thunder God [Lv. 575] [Boss]"
				NameQuestBoss = "SkyExp2Quest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-7902.78613, 5635.99902, -1411.98706, -0.0361216255, -1.16895912e-07, 0.999347389, 1.44533963e-09, 1, 1.17024491e-07, -0.999347389, 5.6715117e-09, -0.0361216255)
				CFrameBoss = CFrame.new(-7917.53613, 5616.61377, -2277.78564, 0.965189934, 4.80563429e-08, -0.261550069, -6.73089886e-08, 1, -6.46515304e-08, 0.261550069, 8.00056768e-08, 0.965189934)
			elseif SelectBoss == "Cyborg [Lv. 675] [Boss]" then
				MsBoss = "Cyborg [Lv. 675] [Boss]"
				NameQuestBoss = "FountainQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(5253.54834, 38.5361786, 4050.45166, -0.0112687312, -9.93677887e-08, -0.999936521, 2.55291371e-10, 1, -9.93769547e-08, 0.999936521, -1.37512213e-09, -0.0112687312)
				CFrameBoss = CFrame.new(6041.82813, 52.7112198, 3907.45142, -0.563162148, 1.73805248e-09, -0.826346457, -5.94632716e-08, 1, 4.26280238e-08, 0.826346457, 7.31437524e-08, -0.563162148)
			-- New World
			elseif SelectBoss == "Diamond [Lv. 750] [Boss]" then
				MsBoss = "Diamond [Lv. 750] [Boss]"
				NameQuestBoss = "Area1Quest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-424.080078, 73.0055847, 1836.91589, 0.253544956, -1.42165932e-08, 0.967323601, -6.00147771e-08, 1, 3.04272909e-08, -0.967323601, -6.5768397e-08, 0.253544956)
				CFrameBoss = CFrame.new(-1736.26587, 198.627731, -236.412857, -0.997808516, 0, -0.0661673471, 0, 1, 0, 0.0661673471, 0, -0.997808516)
			elseif SelectBoss == "Jeremy [Lv. 850] [Boss]" then
				MsBoss = "Jeremy [Lv. 850] [Boss]"
				NameQuestBoss = "Area2Quest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, 0.999488771, -1.07732087e-10, -0.0319722369)
				CFrameBoss = CFrame.new(2203.76953, 448.966034, 752.731079, -0.0217453763, 0, -0.999763548, 0, 1, 0, 0.999763548, 0, -0.0217453763)
			elseif SelectBoss == "Fajita [Lv. 925] [Boss]" then
				MsBoss = "Fajita [Lv. 925] [Boss]"
				NameQuestBoss = "MarineQuest3"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-2442.65015, 73.0511475, -3219.11523, -0.873540044, 4.2329841e-08, -0.486752301, 5.64383384e-08, 1, -1.43220786e-08, 0.486752301, -3.99823996e-08, -0.873540044)
				CFrameBoss = CFrame.new(-2297.40332, 115.449463, -3946.53833, 0.961227536, -1.46645796e-09, -0.275756449, -2.3212845e-09, 1, -1.34094433e-08, 0.275756449, 1.35296352e-08, 0.961227536)
			elseif SelectBoss == "Don Swan [Lv. 1000] [Boss]" then
				MsBoss = "Don Swan [Lv. 1000] [Boss]"
				CFrameBoss = CFrame.new(2288.802, 15.1870775, 863.034607, 0.99974072, -8.41247214e-08, -0.0227668174, 8.4774733e-08, 1, 2.75850098e-08, 0.0227668174, -2.95079072e-08, 0.99974072)
			elseif SelectBoss == "Smoke Admiral [Lv. 1150] [Boss]" then
				MsBoss = "Smoke Admiral [Lv. 1150] [Boss]"
				NameQuestBoss = "IceSideQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-6059.96191, 15.9868021, -4904.7373, -0.444992423, -3.0874483e-09, 0.895534337, -3.64098796e-08, 1, -1.4644522e-08, -0.895534337, -3.91229982e-08, -0.444992423)
				CFrameBoss = CFrame.new(-5115.72754, 23.7664986, -5338.2207, 0.251453817, 1.48345061e-08, -0.967869282, 4.02796978e-08, 1, 2.57916977e-08, 0.967869282, -4.54708946e-08, 0.251453817)
			elseif SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" then
				MsBoss = "Cursed Captain [Lv. 1325] [Raid Boss]"
				CFrameBoss = CFrame.new(916.928589, 181.092773, 33422, -0.999505103, 9.26310495e-09, 0.0314563364, 8.42916226e-09, 1, -2.6643713e-08, -0.0314563364, -2.63653774e-08, -0.999505103)
				elseif SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
				MsBoss = "Darkbeard [Lv. 1000] [Raid Boss]"
				CFrameBoss = CFrame.new(3876.00366, 24.6882591, -3820.21777, -0.976951957, 4.97356325e-08, 0.213458836, 4.57335361e-08, 1, -2.36868622e-08, -0.213458836, -1.33787044e-08, -0.976951957)
				elseif SelectBoss == "Order [Lv. 1250] [Raid Boss]" then
				MsBoss = "Order [Lv. 1250] [Raid Boss]"
				CFrameBoss = CFrame.new(-6221.15039, 16.2351036, -5045.23584, -0.380726993, 7.41463495e-08, 0.924687505, 5.85604774e-08, 1, -5.60738549e-08, -0.924687505, 3.28013137e-08, -0.380726993)
			elseif SelectBoss == "Awakened Ice Admiral [Lv. 1400] [Boss]" then
				MsBoss = "Awakened Ice Admiral [Lv. 1400] [Boss]"
				NameQuestBoss = "FrostQuest"
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(5669.33203, 28.2118053, -6481.55908, 0.921275556, -1.25320829e-08, 0.388910472, 4.72230788e-08, 1, -7.96414241e-08, -0.388910472, 9.17372489e-08, 0.921275556)
				CFrameBoss = CFrame.new(6407.33936, 340.223785, -6892.521, 0.49051559, -5.25310213e-08, -0.871432424, -2.76146022e-08, 1, -7.58250565e-08, 0.871432424, 6.12576301e-08, 0.49051559)
			elseif SelectBoss == "Tide Keeper [Lv. 1475] [Boss]" then
				MsBoss = "Tide Keeper [Lv. 1475] [Boss]"
				NameQuestBoss = "ForgottenQuest"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-3053.89648, 236.881363, -10148.2324, -0.985987961, -3.58504737e-09, 0.16681771, -3.07832915e-09, 1, 3.29612559e-09, -0.16681771, 2.73641976e-09, -0.985987961)
				CFrameBoss = CFrame.new(-3570.18652, 123.328949, -11555.9072, 0.465199202, -1.3857326e-08, 0.885206044, 4.0332897e-09, 1, 1.35347511e-08, -0.885206044, -2.72606271e-09, 0.465199202)
			-- Thire World
			elseif SelectBoss == "Stone [Lv. 1550] [Boss]" then
				MsBoss = "Stone [Lv. 1550] [Boss]"
				NameQuestBoss = "PiratePortQuest"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-290, 44, 5577)
				CFrameBoss = CFrame.new(-1085, 40, 6779)
			elseif SelectBoss == "Island Empress [Lv. 1675] [Boss]" then
				MsBoss = "Island Empress [Lv. 1675] [Boss]"
				NameQuestBoss = "AmazonQuest2"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(5443, 602, 752)
				CFrameBoss = CFrame.new(5659, 602, 244)
			elseif SelectBoss == "Kilo Admiral [Lv. 1750] [Boss]" then
				MsBoss = "Kilo Admiral [Lv. 1750] [Boss]"
				NameQuestBoss = "MarineTreeIsland"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(2178, 29, -6737)
				CFrameBoss =CFrame.new(2846, 433, -7100)
			elseif SelectBoss == "Captain Elephant [Lv. 1875] [Boss]" then
				MsBoss = "Captain Elephant [Lv. 1875] [Boss]"
				NameQuestBoss = "DeepForestIsland"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-13232, 333, -7631)
				CFrameBoss = CFrame.new(-13221, 325, -8405)
			elseif SelectBoss == "Beautiful Pirate [Lv. 1950] [Boss]" then
				MsBoss = "Beautiful Pirate [Lv. 1950] [Boss]"
				NameQuestBoss = "DeepForestIsland2"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-12686, 391, -9902)
				CFrameBoss = CFrame.new(5182, 23, -20)
			elseif SelectBoss == "Cake Queen [Lv. 2175] [Boss]" then
				MsBoss = "Cake Queen [Lv. 2175] [Boss]"
				NameQuestBoss = "IceCreamIslandQuest"             
				LevelQuestBoss = 3
				CFrameQuestBoss = CFrame.new(-716, 382, -11010)
				CFrameBoss = CFrame.new(-821, 66, -10965)
			elseif SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" then
				MsBoss = "rip_indra True Form [Lv. 5000] [Raid Boss]"
				CFrameBoss = CFrame.new(-5359, 424, -2735)
			elseif SelectBoss == "Longma [Lv. 2000] [Boss]" then
				MsBoss = "Longma [Lv. 2000] [Boss]"
				CFrameBoss = CFrame.new(-10248.3936, 353.79129, -9306.34473)
			elseif SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" then
				MsBoss = "Soul Reaper [Lv. 2100] [Raid Boss]"
				CFrameBoss = CFrame.new(-9515.62109, 315.925537, 6691.12012)
			end
		end
	function AutoFramBoss()
		CheckQuestBoss()
			if MsBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" or MsBoss == "Order [Lv. 1250] [Raid Boss]" or MsBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" or MsBoss == "Longma [Lv. 2000] [Boss]" or MsBoss == "The Saw [Lv. 100] [Boss]" or MsBoss == "Greybeard [Lv. 750] [Raid Boss]" or MsBoss == "Don Swan [Lv. 1000] [Boss]" or MsBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" or MsBoss == "Saber Expert [Lv. 200] [Boss]" or MsBoss == "Mob Leader [Lv. 120] [Boss]" or MsBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
				if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
					for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
						if FramBoss and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == MsBoss then
							repeat wait() 
								if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
									Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
								elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
									if Farmtween then
										Farmtween:Stop()
									end
									EquipWeapon(SelectToolWeapon)
									Usefastattack = true
									if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
										local args = {
											[1] = "Buso"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 30)
									Click()
								end
							until not FramBoss or not v.Parent or v.Humanoid.Health <= 0
							Usefastattack = false
						end
					end
				else
					Usefastattack = false
					Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
					if (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
						if Questtween then
							Questtween:Stop()
						end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
						wait(1)
					end 
				end
			else
				if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
					Usefastattack = false
					CheckQuestBoss()
					Questtween = toTarget(CFrameQuestBoss.Position,CFrameQuestBoss)
					if (CFrameQuestBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
						if Questtween then
							Questtween:Stop()
						end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuestBoss
						wait(1.1)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuestBoss, LevelQuestBoss)
					end 
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
					if game:GetService("Workspace").Enemies:FindFirstChild(MsBoss) then print("Find")
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if FramBoss and v.Name == MsBoss and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat wait()
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
									elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
										EquipWeapon(SelectToolWeapon)
										if Farmtween then
											Farmtween:Stop()
										end
										if Modstween then
											Modstween:Stop()
										end
										Usefastattack = true
										if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
											local args = {
												[1] = "Buso"
											}
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
										Click()
									end
								until not FramBoss or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
								Usefastattack = false
							end
						end
					else
						Usefastattack = false
						Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
						if ThreeWorld and game:GetService("Players").LocalPlayer.Data.Level.Value >= 1925 and MsBoss == "Beautiful Pirate [Lv. 1950] [Boss]" and (CFrameBoss.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude < 500 then
							if Questtween then
								Questtween:Stop()
							end
							local TouchInterest = game:GetService("Workspace").Map.Turtle.Entrance.Door.BossDoor.Hitbox
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TouchInterest.CFrame
							UseTween = false
							wait(.1)
						elseif (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
						end 
					end
				end
			end
		end
	KillBossuseGet = false
		function AutoFramAllBoss()
			for i, v in pairs(game.ReplicatedStorage:GetChildren()) do
				if not KillBossuseGet then
					if v.Name == "Diamond [Lv. 750] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 750 then
						SelectBoss = "Diamond [Lv. 750] [Boss]"
					elseif v.Name == "Jeremy [Lv. 850] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 850 then
						SelectBoss = "Jeremy [Lv. 850] [Boss]"
					elseif v.Name == "Fajita [Lv. 925] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 925  then
						SelectBoss = "Fajita [Lv. 925] [Boss]"
					elseif v.Name == "Don Swan [Lv. 1000] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1000 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor","1") == 0 then
						SelectBoss = "Don Swan [Lv. 1000] [Boss]" 
					elseif v.Name == "Smoke Admiral [Lv. 1150] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1150 then
						SelectBoss = "Smoke Admiral [Lv. 1150] [Boss]"
					elseif v.Name == "Cursed Captain [Lv. 1325] [Raid Boss]" and game.Players.localPlayer.Data.Level.Value >= 1325 then
						SelectBoss = "Cursed Captain [Lv. 1325] [Raid Boss]"
					elseif v.Name == "Awakened Ice Admiral [Lv. 1400] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1400  then
						SelectBoss = "Awakened Ice Admiral [Lv. 1400] [Boss]"
					elseif v.Name == "Tide Keeper [Lv. 1475] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1475  then
						SelectBoss = "Tide Keeper [Lv. 1475] [Boss]"
					-- Old World
					elseif v.Name == "The Gorilla King [Lv. 25] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 20  then
						SelectBoss = "The Gorilla King [Lv. 25] [Boss]"
					elseif v.Name == "Bobby [Lv. 55] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 55  then
						SelectBoss = "Bobby [Lv. 55] [Boss]" 
					elseif v.Name == "Yeti [Lv. 110] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 105  then
						SelectBoss = "Yeti [Lv. 110] [Boss]"
					elseif v.Name == "Mob Leader [Lv. 120] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 120 then
						SelectBoss = "Mob Leader [Lv. 120] [Boss]"
					elseif v.Name == "Vice Admiral [Lv. 130] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 130 then
						SelectBoss = "Vice Admiral [Lv. 130] [Boss]"
					elseif v.Name == "Warden [Lv. 175] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 175 then
						SelectBoss = "Warden [Lv. 175] [Boss]"
					elseif v.Name == "Saber Expert [Lv. 200] [Boss]" and game.Workspace.Map.Jungle.Final.Part.Transparency == 1 then
						SelectBoss = "Saber Expert [Lv. 200] [Boss]"
					elseif v.Name == "Chief Warden [Lv. 200] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 200 then
						SelectBoss = "Chief Warden [Lv. 200] [Boss]"
					elseif v.Name == "Swan [Lv. 225] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 250 then
						SelectBoss = "Swan [Lv. 225] [Boss]"
					elseif v.Name == "Magma Admiral [Lv. 350] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 350  then
						SelectBoss = "Magma Admiral [Lv. 350] [Boss]"
					elseif v.Name == "Fishman Lord [Lv. 425] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 425  then
						SelectBoss = "Fishman Lord [Lv. 425] [Boss]"
					elseif v.Name == "Wysper [Lv. 500] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 500 then
						SelectBoss = "Wysper [Lv. 500] [Boss]"
					elseif v.Name == "Thunder God [Lv. 575] [Boss]"  and game.Players.localPlayer.Data.Level.Value >= 575 then
						SelectBoss = "Thunder God [Lv. 575] [Boss]"
					elseif v.Name == "Cyborg [Lv. 675] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 675 then
						SelectBoss = "Cyborg [Lv. 675] [Boss]"
					-- Thire World
					elseif v.Name == "Stone [Lv. 1550] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1550 then
						SelectBoss = "Stone [Lv. 1550] [Boss]"
					elseif v.Name == "Island Empress [Lv. 1675] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1675 then
						SelectBoss = "Island Empress [Lv. 1675] [Boss]"
					elseif v.Name == "Kilo Admiral [Lv. 1750] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1750 then
						SelectBoss = "Kilo Admiral [Lv. 1750] [Boss]"
					elseif v.Name == "Captain Elephant [Lv. 1875] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1875 then
						SelectBoss = "Captain Elephant [Lv. 1875] [Boss]"
					elseif v.Name == "Beautiful Pirate [Lv. 1950] [Boss]" and game.Players.localPlayer.Data.Level.Value >= 1950 then
						SelectBoss = "Beautiful Pirate [Lv. 1950] [Boss]"
					end 
				end 
			end
			CheckQuestBoss()
			if SelectBoss == "rip_indra True Form [Lv. 5000] [Raid Boss]" or SelectBoss == "Order [Lv. 1250] [Raid Boss]" or SelectBoss == "Soul Reaper [Lv. 2100] [Raid Boss]" or SelectBoss == "Longma [Lv. 2000] [Boss]" or SelectBoss == "The Saw [Lv. 100] [Boss]" or SelectBoss == "Greybeard [Lv. 750] [Raid Boss]" or SelectBoss == "Don Swan [Lv. 1000] [Boss]" or SelectBoss == "Cursed Captain [Lv. 1325] [Raid Boss]" or SelectBoss == "Saber Expert [Lv. 200] [Boss]" or SelectBoss == "Mob Leader [Lv. 120] [Boss]" or SelectBoss == "Darkbeard [Lv. 1000] [Raid Boss]" then
				if game:GetService("Workspace").Enemies:FindFirstChild(SelectBoss) then
					for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
						if KillAllBoss and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == MsBoss then
							repeat wait() 
								KillBossuseGet = true
								if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
									Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
								elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
									if Farmtween then
										Farmtween:Stop()
									end
									EquipWeapon(SelectToolWeapon)
									Usefastattack = true
									if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
										local args = {
											[1] = "Buso"
										}
										game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
									end
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 30)
									Click()
								end
							until not KillAllBoss or not v.Parent or v.Humanoid.Health <= 0
							Usefastattack = false
							KillBossuseGet = false
						end
					end
				else
					KillBossuseGet = true
					Usefastattack = false
					Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
					if (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
						if Questtween then
							Questtween:Stop()
						end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
						wait(1)
					end 
				end
			else
				if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
					Usefastattack = false
					KillBossuseGet = true
					CheckQuestBoss()
					Questtween = toTarget(CFrameQuestBoss.Position,CFrameQuestBoss)
					if (CFrameQuestBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
						if Questtween then
							Questtween:Stop()
						end
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuestBoss
						wait(1.1)
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuestBoss, LevelQuestBoss)
					end 
				elseif game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then
					if game:GetService("Workspace").Enemies:FindFirstChild(MsBoss) then print("Find")
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if KillAllBoss and v.Name == MsBoss and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat wait()
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
										Farmtween = toTarget(v.HumanoidRootPart.Position,v.HumanoidRootPart.CFrame)
									elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
										EquipWeapon(SelectToolWeapon)
										if Farmtween then
											Farmtween:Stop()
										end
										if Modstween then
											Modstween:Stop()
										end
										Usefastattack = true
										if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
											local args = {
												[1] = "Buso"
											}
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
										Click()
									end
								until not KillAllBoss or not v.Parent or v.Humanoid.Health <= 0 or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false
								Usefastattack = false
								KillBossuseGet = false
							end
						end
					else
						KillBossuseGet = true
						Usefastattack = false
						Questtween = toTarget(CFrameBoss.Position,CFrameBoss)
						if ThreeWorld and game:GetService("Players").LocalPlayer.Data.Level.Value >= 1925 and MsBoss == "Beautiful Pirate [Lv. 1950] [Boss]" and (CFrameBoss.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 20000 then
							if Questtween then
								Questtween:Stop()
							end
							local TouchInterest = game:GetService("Workspace").Map.Turtle.Entrance.Door.BossDoor.Hitbox
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = TouchInterest.CFrame
							wait(.1)
							UseTween = false
						elseif (CFrameBoss.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
							if Questtween then
								Questtween:Stop()
							end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameBoss
						end 
					end
				end
			end
		end

	spawn(function()
	while wait() do
		pcall(function()
			for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
				if Auto_Farm and MagnetActive and Magnet then
					if v.Name == Ms and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						if v.Name == "Factory Staff [Lv. 800]" then
							if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 250 then
								v.Head.CanCollide = false
								v.HumanoidRootPart.CanCollide = false
								v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
								v.HumanoidRootPart.CFrame = PosMon
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
								v.Humanoid:ChangeState(11)
							end
						elseif v.Name == Ms then
							if (v.HumanoidRootPart.Position - PosMon.Position).Magnitude <= 400 then
								v.Head.CanCollide = false
								v.HumanoidRootPart.CanCollide = false
								v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
								v.HumanoidRootPart.CFrame = PosMon
								v.Humanoid.JumpPower = 0
								v.Humanoid.WalkSpeed = 0
								sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
								v.Humanoid:ChangeState(11)
							end
						end
					end
				elseif _G.AutoFarmBone and MagnetFarmBone and Magnet then
					if (v.Name == "Reborn Skeleton [Lv. 1975]" or v.Name == "Living Zombie [Lv. 2000]" or v.Name == "Demonic Soul [Lv. 2025]" or v.Name == "Posessed Mummy [Lv. 2050]") and (v.HumanoidRootPart.Position - PosFarmBone.Position).Magnitude <= 500 then 
						if sethiddenproperty then 
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  10000)
						end
						v.Head.CanCollide = false
						v.HumanoidRootPart.CanCollide = false
						v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
						v.HumanoidRootPart.CFrame = PosFarmBone
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
					end
				elseif _G.AutoFramEctoplasm and StatrMagnetEctoplasm and Magnet then
					if (v.Name == "Ship Deckhand [Lv. 1250]" or v.Name == "Ship Engineer [Lv. 1275]" or v.Name == "Ship Steward [Lv. 1300]" or v.Name == "Ship Officer [Lv. 1325]") and (v.HumanoidRootPart.Position - PosMonEctoplasm.Position).Magnitude <= 500 then 
						if sethiddenproperty then 
						sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius",  10000)
						end
						v.Head.CanCollide = false
						v.HumanoidRootPart.CanCollide = false
						v.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
						v.HumanoidRootPart.CFrame = PosMonEctoplasm
						v.Humanoid.JumpPower = 0
						v.Humanoid.WalkSpeed = 0
						end
					end
				end
			end)
		end
	end)
