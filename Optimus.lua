-- 🔁 AUTO-UPDATE SYSTEM + VERSION CHECK
local configUrl = "https://raw.githubusercontent.com/Venomsz777/Optimus-hub/refs/heads/main/Optimus" -- înlocuiește cu linkul tău JSON

local function getData(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if success then
        return response
    else
        return nil
    end
end

local configRaw = getData(configUrl)
if not configRaw then
    warn("[Optimus Hub] Nu s-a putut accesa fișierul de configurare.")
    return
end

local success, config = pcall(function()
    return game:GetService("HttpService"):JSONDecode(configRaw)
end)

if not success then
    warn("[Optimus Hub] Config JSON invalid.")
    return
end

local currentVersion = "1.0" -- Versiunea curentă a acestui script
if config.version ~= currentVersion then
    if config.forcePopup then
        local ui = Instance.new("ScreenGui", game.Players.LocalPlayer:WaitForChild("PlayerGui"))
        ui.Name = "OptimusUpdatePopup"

        local frame = Instance.new("Frame", ui)
        frame.Size = UDim2.new(0.4, 0, 0.2, 0)
        frame.Position = UDim2.new(0.3, 0, 0.4, 0)
        frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        frame.BorderSizePixel = 0
        frame.ZIndex = 10

        local text = Instance.new("TextLabel", frame)
        text.Size = UDim2.new(1, 0, 0.6, 0)
        text.Position = UDim2.new(0, 0, 0, 0)
        text.BackgroundTransparency = 1
        text.Text = "🔄 New update available!\nJoin Discord for the latest version."
        text.TextColor3 = Color3.fromRGB(255, 255, 255)
        text.TextScaled = true
        text.Font = Enum.Font.GothamBold

        local button = Instance.new("TextButton", frame)
        button.Size = UDim2.new(1, 0, 0.4, 0)
        button.Position = UDim2.new(0, 0, 0.6, 0)
        button.Text = "📋 Copy Discord Invite"
        button.TextScaled = true
        button.Font = Enum.Font.Gotham
        button.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.MouseButton1Click:Connect(function()
            setclipboard("https://discord.gg/PenrXBYjzv")
        end)
        return
    else
        local newScript = getData(config.script)
        if newScript then
            loadstring(newScript)()
        else
            warn("[Optimus Hub] Eroare la încărcarea noii versiuni.")
        end
        return
    end
end

print("[Optimus Hub] Rulăm versiunea actuală: " .. currentVersion)

-- ⬇️ AICI ÎNCEPE SCRIPTUL TĂU COMPLET (NEMODIFICAT)
-- ✅ OPTIMUS HUB - Gradient UI, VNM Icon, Fly UI, Key System, Brainrot ESP

local Players = game:GetService("Players") local RunService = game:GetService("RunService") local UserInputService = game:GetService("UserInputService") local LocalPlayer = Players.LocalPlayer local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

repeat wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

local Character = LocalPlayer.Character local RootPart = Character:WaitForChild("HumanoidRootPart") local Humanoid = Character:WaitForChild("Humanoid")

-- ... [restul scriptului tău complet de mai sus vine aici, exact cum l-ai pus tu]

-- Ca să nu încarc tot aici încă o dată, presupun că îl ai deja — deci doar îl lipești sub această secțiune.local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

repeat wait() until LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

local Character = LocalPlayer.Character
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")

if PlayerGui:FindFirstChild("OptimusHub") then
	PlayerGui.OptimusHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui", PlayerGui)
ScreenGui.Name = "OptimusHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true

-- Gradient colors
local function applyGradient(frame)
	local uiGradient = Instance.new("UIGradient", frame)
	uiGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 60, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 0, 255))
	}
end

-- VNM BUTTON
local VNM = Instance.new("TextButton", ScreenGui)
VNM.Size = UDim2.new(0, 80, 0, 30)
VNM.Position = UDim2.new(1, -90, 0, 10)
VNM.Text = "VNM"
VNM.TextColor3 = Color3.new(1,1,1)
VNM.TextScaled = true
VNM.Font = Enum.Font.SourceSansBold
VNM.BackgroundColor3 = Color3.fromRGB(80, 0, 180)
VNM.Active = true
VNM.Draggable = true
applyGradient(VNM)
Instance.new("UICorner", VNM).CornerRadius = UDim.new(0, 8)

-- Key UI
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 260, 0, 140)
KeyFrame.Position = UDim2.new(0.5, -130, 0.5, -70)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
applyGradient(KeyFrame)
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(1, -40, 0, 30)
KeyBox.Position = UDim2.new(0, 20, 0, 45)
KeyBox.PlaceholderText = "Type key here..."
KeyBox.TextScaled = true
KeyBox.Font = Enum.Font.SourceSans
KeyBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
KeyBox.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 6)

local SubmitKeyBtn = Instance.new("TextButton", KeyFrame)
SubmitKeyBtn.Size = UDim2.new(1, -40, 0, 30)
SubmitKeyBtn.Position = UDim2.new(0, 20, 0, 85)
SubmitKeyBtn.Text = "Submit Key"
SubmitKeyBtn.TextScaled = true
SubmitKeyBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 180)
SubmitKeyBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", SubmitKeyBtn).CornerRadius = UDim.new(0, 6)

local KeyInfoLabel = Instance.new("TextLabel", KeyFrame)
KeyInfoLabel.Size = UDim2.new(1, -40, 0, 20)
KeyInfoLabel.Position = UDim2.new(0, 20, 0, 10)
KeyInfoLabel.Text = "Please enter the access key"
KeyInfoLabel.TextScaled = true
KeyInfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInfoLabel.Font = Enum.Font.SourceSans
KeyInfoLabel.BackgroundTransparency = 1

-- Main UI
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 260, 0, 320)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true
applyGradient(MainFrame)
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "Optimus Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1

local minimizeBtn = Instance.new("TextButton", MainFrame)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -35, 0, 0)
minimizeBtn.Text = "–"
minimizeBtn.TextScaled = true
minimizeBtn.Font = Enum.Font.SourceSansBold
minimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 180)
minimizeBtn.TextColor3 = Color3.new(1, 1, 1)

local InfoLabel = Instance.new("TextLabel", MainFrame)
InfoLabel.Size = UDim2.new(1, -20, 0, 20)
InfoLabel.Position = UDim2.new(0, 10, 0, 35)
InfoLabel.Text = "Status: Ready"
InfoLabel.TextScaled = true
InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.BackgroundTransparency = 1

-- On-screen Fly Buttons
local FlyBtn = Instance.new("TextButton", ScreenGui)
FlyBtn.Size = UDim2.new(0, 140, 0, 30)
FlyBtn.Position = UDim2.new(1, -300, 1, -90)
FlyBtn.Text = "Fly to Base"
FlyBtn.Visible = false
FlyBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 180)
FlyBtn.TextColor3 = Color3.new(1,1,1)
FlyBtn.TextScaled = true
FlyBtn.Active = true
FlyBtn.Draggable = true
Instance.new("UICorner", FlyBtn)

local StopFlyBtn = Instance.new("TextButton", ScreenGui)
StopFlyBtn.Size = UDim2.new(0, 140, 0, 30)
StopFlyBtn.Position = UDim2.new(1, -150, 1, -90)
StopFlyBtn.Text = "Stop Fly"
StopFlyBtn.Visible = false
StopFlyBtn.BackgroundColor3 = Color3.fromRGB(60, 0, 180)
StopFlyBtn.TextColor3 = Color3.new(1,1,1)
StopFlyBtn.TextScaled = true
StopFlyBtn.Active = true
StopFlyBtn.Draggable = true
Instance.new("UICorner", StopFlyBtn)

-- Buttons
local buttonY = 60
local function createButton(name, callback)
	local btn = Instance.new("TextButton", MainFrame)
	btn.Size = UDim2.new(1, -20, 0, 30)
	btn.Position = UDim2.new(0, 10, 0, buttonY)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(60, 0, 180)
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextScaled = true
	buttonY += 35
	btn.MouseButton1Click:Connect(callback)
	return btn
end

local basePosition = nil
local flyActive = false
local speedActive = false
local jumpActive = false
local correctKeys = {"Optimus Hub", "Venom"}

createButton("Speed Boost", function()
	speedActive = not speedActive
	InfoLabel.Text = speedActive and "Speed ON" or "Speed OFF"
end)

createButton("Jump Boost", function()
	jumpActive = not jumpActive
	InfoLabel.Text = jumpActive and "Jump ON" or "Jump OFF"
end)

createButton("Set Base", function()
	basePosition = RootPart.Position
	InfoLabel.Text = "Base position set!"
end)

createButton("Show Fly to Base on screen", function()
	FlyBtn.Visible = true
	StopFlyBtn.Visible = true
end)

FlyBtn.MouseButton1Click:Connect(function()
	if not basePosition or flyActive then return end
	flyActive = true
	InfoLabel.Text = "Flying to base..."
	local bv = Instance.new("BodyVelocity")
	bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
	bv.Velocity = Vector3.zero
	bv.P = 1250
	bv.Parent = RootPart
	RootPart.CFrame += Vector3.new(0, 5, 0)
	local conn
	conn = RunService.Heartbeat:Connect(function()
		if not RootPart or not bv or not flyActive then
			conn:Disconnect()
			if bv then bv:Destroy() end
			return
		end
		local dist = (basePosition - RootPart.Position).Magnitude
		if dist > 5 then
			local dir = (basePosition - RootPart.Position).Unit
			bv.Velocity = dir * 80
		else
			bv:Destroy()
			conn:Disconnect()
			flyActive = false
			InfoLabel.Text = "Arrived at base."
		end
	end)
end)

StopFlyBtn.MouseButton1Click:Connect(function()
	flyActive = false
	InfoLabel.Text = "Flight manually stopped."
end)

-- Global ESP
for _, player in pairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		local esp = Instance.new("BillboardGui", player.Character:WaitForChild("Head"))
		esp.Size = UDim2.new(0, 100, 0, 20)
		esp.AlwaysOnTop = true
		local nameLbl = Instance.new("TextLabel", esp)
		nameLbl.Size = UDim2.new(1, 0, 1, 0)
		nameLbl.BackgroundTransparency = 1
		nameLbl.Text = player.Name
		nameLbl.TextColor3 = Color3.new(1, 0, 0)
		nameLbl.TextScaled = true

		for _, part in pairs(player.Character:GetChildren()) do
			if part:IsA("BasePart") then
				local box = Instance.new("BoxHandleAdornment", part)
				box.Adornee = part
				box.Size = part.Size
				box.AlwaysOnTop = true
				box.ZIndex = 10
				box.Transparency = 0.5
				box.Color3 = Color3.new(1, 0, 0)
			end
		end
	end
end

-- Secret/God Pet ESP
local espHighlights = {}
local targetNames = {
	["Cocofanto Elefanto"] = true, ["Girafa Celestre"] = true, ["Gattatino Neonino"] = true,
	["Matteo"] = true, ["Tralalero Tralala"] = true, ["Espresso Signora"] = true,
	["Odin Din Din Dun"] = true, ["Statutino Libertino"] = true, ["Trenostruzzo Turbo 3000"] = true,
	["Ballerino Lololo"] = true, ["Tigroligre Frutonni"] = true, ["Orcala Orcalero"] = true,
	["La Vacca Saturno Saturnita"] = true, ["Chimpanzini Spiderini"] = true,
	["Los Tralaleritos"] = true, ["Las Tralaleritas"] = true, ["Graipuss Medussi"] = true,
	["La Grande Combinasion"] = true, ["Nuclearo Dinossauro"] = true, ["Garama and Madundung"] = true,
	["Torrtuginni Dragonfrutini"] = true, ["Pot Hotspot"] = true,
["Tralalelo Tralala"] = true, ["Trenostrutzo Turbo 3000"] = true}

local function createHighlight(model)
	local h = Instance.new("Highlight")
	h.Adornee = model
	h.FillColor = Color3.new(0, 1, 0)
	h.OutlineColor = Color3.new(1, 1, 1)
	h.Parent = model
	return h
end

local function scanPets()
	local container = workspace:FindFirstChild("PetContainer") or workspace
	for _, pet in pairs(container:GetDescendants()) do
		if pet:IsA("Model") and targetNames[pet.Name] and not espHighlights[pet] then
			espHighlights[pet] = createHighlight(pet)
		end
	end
end

-- Key System + activare ESP după cheie corectă
SubmitKeyBtn.MouseButton1Click:Connect(function()
	for _, key in ipairs(correctKeys) do
		if KeyBox.Text == key then
			KeyFrame.Visible = false
			MainFrame.Visible = true
			InfoLabel.Text = "Access granted!"
			scanPets()
			return
		end
	end
	KeyInfoLabel.Text = "Incorrect key!"
	KeyInfoLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
end)

-- Minimize
local minimized = false
minimizeBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	for _, child in pairs(MainFrame:GetChildren()) do
		if child ~= minimizeBtn and child ~= Title then
			child.Visible = not minimized
		end
	end
end)

-- Speed Loop
RunService.RenderStepped:Connect(function()
	if speedActive and Humanoid.MoveDirection.Magnitude > 0 then
		local velY = RootPart.Velocity.Y
		RootPart.Velocity = Humanoid.MoveDirection * 80 + Vector3.new(0, velY, 0)
	end
end)
Humanoid.StateChanged:Connect(function(_, newState)
	if jumpActive and newState == Enum.HumanoidStateType.Jumping then
		local bv = Instance.new("BodyVelocity")
		bv.Velocity = Vector3.new(0, 80, 0)
		bv.MaxForce = Vector3.new(0, 1e5, 0)
		bv.P = 1250
		bv.Parent = RootPart
		game.Debris:AddItem(bv, 0.15)
	end
end)

-- VNM TOGGLE UI
VNM.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)
