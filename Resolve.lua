local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")
local Hum = Character:WaitForChild("Humanoid")

-- GUI setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "OptimusHub"
gui.ResetOnSpawn = false

-- Dynamic color function
local function getDynamicColor(hueShift)
	local t = tick() / 4 + (hueShift or 0)
	return Color3.fromHSV(t % 1, 1, 1)
end

-- Background Frame (hidden until key)
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 240, 0, 280)
mainFrame.Position = UDim2.new(0.02, 0, 0.3, 0)
mainFrame.Visible = false
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 12)

-- Title
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 30)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "OPTIMUS HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.BackgroundTransparency = 1

-- VNM Toggle Button
local toggleBtn = Instance.new("TextButton", gui)
toggleBtn.Size = UDim2.new(0, 70, 0, 30)
toggleBtn.Position = UDim2.new(1, -80, 0, 10)
toggleBtn.Text = "VNM"
toggleBtn.TextScaled = true
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.GothamBold
toggleBtn.BackgroundColor3 = getDynamicColor()
Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)
RunService.RenderStepped:Connect(function()
	toggleBtn.BackgroundColor3 = getDynamicColor(0.5)
end)

toggleBtn.MouseButton1Click:Connect(function()
	mainFrame.Visible = not mainFrame.Visible
end)

-- Key UI Frame
local keyFrame = Instance.new("Frame", gui)
keyFrame.Size = UDim2.new(0, 240, 0, 140)
keyFrame.Position = UDim2.new(0.5, -120, 0.5, -70)
keyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
keyFrame.Active = true
keyFrame.Draggable = true
Instance.new("UICorner", keyFrame).CornerRadius = UDim.new(0, 10)

local keyLabel = Instance.new("TextLabel", keyFrame)
keyLabel.Size = UDim2.new(1, 0, 0, 30)
keyLabel.Position = UDim2.new(0, 0, 0, 5)
keyLabel.Text = "Enter Key"
keyLabel.TextColor3 = Color3.new(1, 1, 1)
keyLabel.Font = Enum.Font.GothamBold
keyLabel.TextScaled = true
keyLabel.BackgroundTransparency = 1

local keyBox = Instance.new("TextBox", keyFrame)
keyBox.Size = UDim2.new(1, -20, 0, 30)
keyBox.Position = UDim2.new(0, 10, 0, 40)
keyBox.PlaceholderText = "Your key here..."
keyBox.Text = ""
keyBox.ClearTextOnFocus = true
keyBox.Font = Enum.Font.Gotham
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
Instance.new("UICorner", keyBox).CornerRadius = UDim.new(0, 6)

local submitBtn = Instance.new("TextButton", keyFrame)
submitBtn.Size = UDim2.new(1, -20, 0, 30)
submitBtn.Position = UDim2.new(0, 10, 0, 80)
submitBtn.Text = "🔐 Submit"
submitBtn.TextColor3 = Color3.new(1, 1, 1)
submitBtn.Font = Enum.Font.GothamBold
submitBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 6)

local validKeys = { "Optimus Hub", "Venom" }
submitBtn.MouseButton1Click:Connect(function()
	local entered = keyBox.Text
	if table.find(validKeys, entered) then
		keyBox.Text = ""
		keyFrame.Visible = false
		mainFrame.Visible = true
	else
		submitBtn.Text = "Wrong Key!"
		task.wait(1)
		submitBtn.Text = "🔐 Submit"
	end
end)

-- Color effect for background
RunService.RenderStepped:Connect(function()
	local r = getDynamicColor(0).r
	local g = getDynamicColor(0.3).g
	local b = getDynamicColor(0.6).b
	mainFrame.BackgroundColor3 = Color3.new(r, b, g)
	keyFrame.BackgroundColor3 = Color3.new(r * 0.6, b * 0.6, g * 0.6)
end)-- SPEED ON/OFF
local SpeedEnabled = false
local speedPower = 75

local SpeedBtn = Instance.new("TextButton", mainFrame)
SpeedBtn.Size = UDim2.new(1, -20, 0, 35)
SpeedBtn.Position = UDim2.new(0, 10, 0, 40)
SpeedBtn.Text = "Speed: OFF"
SpeedBtn.Font = Enum.Font.GothamBold
SpeedBtn.TextScaled = true
SpeedBtn.TextColor3 = Color3.new(1,1,1)
SpeedBtn.BackgroundColor3 = getDynamicColor()
Instance.new("UICorner", SpeedBtn).CornerRadius = UDim.new(0, 6)

SpeedBtn.MouseButton1Click:Connect(function()
	SpeedEnabled = not SpeedEnabled
	SpeedBtn.Text = SpeedEnabled and "Speed: ON" or "Speed: OFF"
end)

RunService.Heartbeat:Connect(function()
	if SpeedEnabled and Hum and HRP and Hum.FloorMaterial ~= Enum.Material.Air then
		local dir = Hum.MoveDirection
		if dir.Magnitude > 0 then
			HRP.Velocity = Vector3.new(dir.Unit.X * speedPower, HRP.Velocity.Y, dir.Unit.Z * speedPower)
		end
	end
end)

RunService.RenderStepped:Connect(function()
	SpeedBtn.BackgroundColor3 = getDynamicColor(0.1)
end)

-- JUMP BOOST ON/OFF
local JumpEnabled = false
local JumpBtn = Instance.new("TextButton", mainFrame)
JumpBtn.Size = UDim2.new(1, -20, 0, 35)
JumpBtn.Position = UDim2.new(0, 10, 0, 85)
JumpBtn.Text = "Jump: OFF"
JumpBtn.Font = Enum.Font.GothamBold
JumpBtn.TextScaled = true
JumpBtn.TextColor3 = Color3.new(1,1,1)
JumpBtn.BackgroundColor3 = getDynamicColor(0.2)
Instance.new("UICorner", JumpBtn).CornerRadius = UDim.new(0, 6)

JumpBtn.MouseButton1Click:Connect(function()
	JumpEnabled = not JumpEnabled
	JumpBtn.Text = JumpEnabled and "Jump: ON" or "Jump: OFF"
	if JumpEnabled then
		Hum.UseJumpPower = true
		Hum.JumpPower = 100
	else
		Hum.JumpPower = 50
	end
end)

RunService.RenderStepped:Connect(function()
	JumpBtn.BackgroundColor3 = getDynamicColor(0.2)
end)

-- SET BASE
local BaseCFrame = nil
local SetBase = Instance.new("TextButton", mainFrame)
SetBase.Size = UDim2.new(1, -20, 0, 35)
SetBase.Position = UDim2.new(0, 10, 0, 130)
SetBase.Text = "📍 Set Base"
SetBase.Font = Enum.Font.GothamBold
SetBase.TextScaled = true
SetBase.TextColor3 = Color3.new(1,1,1)
SetBase.BackgroundColor3 = getDynamicColor(0.4)
Instance.new("UICorner", SetBase).CornerRadius = UDim.new(0, 6)

SetBase.MouseButton1Click:Connect(function()
	BaseCFrame = HRP.CFrame + Vector3.new(0, 5, 0)
end)

RunService.RenderStepped:Connect(function()
	SetBase.BackgroundColor3 = getDynamicColor(0.4)
end)

-- SHOW FLY UI ON/OFF
local FlyUIVisible = false
local ShowFlyBtn = Instance.new("TextButton", mainFrame)
ShowFlyBtn.Size = UDim2.new(1, -20, 0, 35)
ShowFlyBtn.Position = UDim2.new(0, 10, 0, 175)
ShowFlyBtn.Text = "Fly UI: OFF"
ShowFlyBtn.Font = Enum.Font.GothamBold
ShowFlyBtn.TextScaled = true
ShowFlyBtn.TextColor3 = Color3.new(1,1,1)
ShowFlyBtn.BackgroundColor3 = getDynamicColor(0.6)
Instance.new("UICorner", ShowFlyBtn).CornerRadius = UDim.new(0, 6)

ShowFlyBtn.MouseButton1Click:Connect(function()
	FlyUIVisible = not FlyUIVisible
	ShowFlyBtn.Text = FlyUIVisible and "Fly UI: ON" or "Fly UI: OFF"
	if FlyUIVisible and flyUI then
		flyUI.Visible = true
	else
		if flyUI then flyUI.Visible = false end
	end
end)

RunService.RenderStepped:Connect(function()
	ShowFlyBtn.BackgroundColor3 = getDynamicColor(0.6)
end)-- FLY UI pe mijlocul ecranului
flyUI = Instance.new("Frame")
flyUI.Size = UDim2.new(0, 220, 0, 120)
flyUI.Position = UDim2.new(0.5, -110, 0.5, -60)
flyUI.AnchorPoint = Vector2.new(0.5, 0.5)
flyUI.BackgroundColor3 = Color3.fromRGB(40, 20, 60)
flyUI.BackgroundTransparency = 0.1
flyUI.Visible = false
flyUI.Active = true
flyUI.Draggable = true
flyUI.Parent = gui
Instance.new("UICorner", flyUI).CornerRadius = UDim.new(0, 10)

-- Fly to Base Button
local flying = false
local flyLoop = nil

local FlyBtn = Instance.new("TextButton", flyUI)
FlyBtn.Size = UDim2.new(1, -20, 0, 40)
FlyBtn.Position = UDim2.new(0, 10, 0, 10)
FlyBtn.Text = "Fly to Base"
FlyBtn.Font = Enum.Font.GothamBold
FlyBtn.TextScaled = true
FlyBtn.TextColor3 = Color3.new(1,1,1)
FlyBtn.BackgroundColor3 = getDynamicColor()
Instance.new("UICorner", FlyBtn).CornerRadius = UDim.new(0, 8)

FlyBtn.MouseButton1Click:Connect(function()
	if not BaseCFrame or flying then return end
	flying = true
	local goal = BaseCFrame.Position + Vector3.new(0, 7, 0)
	local targetHeight = HRP.Position.Y + 20
	local phase = "lift"

	if flyLoop then flyLoop:Disconnect() end

	flyLoop = RunService.Heartbeat:Connect(function()
		if not flying then return end
		if phase == "lift" then
			if HRP.Position.Y < targetHeight then
				HRP.Velocity = Vector3.new(0, 60, 0)
			else
				phase = "fly"
			end
		elseif phase == "fly" then
			local pos = HRP.Position
			local dir = (goal - pos)
			local dist = dir.Magnitude
			if dist < 4 then
				HRP.Velocity = Vector3.zero
				flying = false
				if flyLoop then flyLoop:Disconnect() end
				return
			end
			local moveDir = dir.Unit
			local flySpeed = 70
			local flyY = math.clamp(moveDir.Y * 40, -25, 35)
			HRP.Velocity = Vector3.new(moveDir.X * flySpeed, flyY, moveDir.Z * flySpeed)
		end
	end)
end)

RunService.RenderStepped:Connect(function()
	FlyBtn.BackgroundColor3 = getDynamicColor(0.1)
end)

-- Stop Fly Button
local StopBtn = Instance.new("TextButton", flyUI)
StopBtn.Size = UDim2.new(1, -20, 0, 40)
StopBtn.Position = UDim2.new(0, 10, 0, 70)
StopBtn.Text = "Stop Fly"
StopBtn.Font = Enum.Font.GothamBold
StopBtn.TextScaled = true
StopBtn.TextColor3 = Color3.new(1,1,1)
StopBtn.BackgroundColor3 = getDynamicColor(0.2)
Instance.new("UICorner", StopBtn).CornerRadius = UDim.new(0, 8)

StopBtn.MouseButton1Click:Connect(function()
	flying = false
	if flyLoop then flyLoop:Disconnect() end
	HRP.Velocity = Vector3.zero
end)

RunService.RenderStepped:Connect(function()
	StopBtn.BackgroundColor3 = getDynamicColor(0.2)
end)-- INFINITE JUMP
local InfiniteJumpEnabled = false
local UserInputService = game:GetService("UserInputService")

local InfJumpBtn = Instance.new("TextButton", mainFrame)
InfJumpBtn.Size = UDim2.new(1, -20, 0, 35)
InfJumpBtn.Position = UDim2.new(0, 10, 0, 220)
InfJumpBtn.Text = "Inf Jump: OFF"
InfJumpBtn.Font = Enum.Font.GothamBold
InfJumpBtn.TextScaled = true
InfJumpBtn.TextColor3 = Color3.new(1,1,1)
InfJumpBtn.BackgroundColor3 = getDynamicColor(0.5)
Instance.new("UICorner", InfJumpBtn).CornerRadius = UDim.new(0, 6)

InfJumpBtn.MouseButton1Click:Connect(function()
	InfiniteJumpEnabled = not InfiniteJumpEnabled
	InfJumpBtn.Text = InfiniteJumpEnabled and "Inf Jump: ON" or "Inf Jump: OFF"
end)

UserInputService.JumpRequest:Connect(function()
	if InfiniteJumpEnabled and Hum then
		Hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

RunService.RenderStepped:Connect(function()
	InfJumpBtn.BackgroundColor3 = getDynamicColor(0.5)
end)
