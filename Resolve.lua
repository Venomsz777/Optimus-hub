-- ESP Script simplu cu UI ON/OFF

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local espEnabled = false
local espHighlights = {}

-- Funcție pentru a crea Highlight pentru un caracter
local function createHighlight(character)
    if not character then return end
    local highlight = Instance.new("Highlight")
    highlight.Adornee = character
    highlight.FillColor = Color3.fromRGB(255, 0, 0)  -- roșu
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255) -- alb
    highlight.Parent = character
    return highlight
end

-- Activează ESP pentru toți jucătorii în afară de local player
local function enableESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and not espHighlights[player] then
            espHighlights[player] = createHighlight(player.Character)
        end
    end
end

-- Dezactivează ESP și șterge toate highlight-urile
local function disableESP()
    for player, highlight in pairs(espHighlights) do
        if highlight and highlight.Parent then
            highlight:Destroy()
        end
    end
    espHighlights = {}
end

-- Actualizează ESP când apar noi personaje
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if espEnabled and player ~= LocalPlayer then
            espHighlights[player] = createHighlight(character)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(player)
    if espHighlights[player] then
        espHighlights[player]:Destroy()
        espHighlights[player] = nil
    end
end)

-- UI minimal pentru activare/dezactivare ESP

local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "ESPControl"

local ToggleButton = Instance.new("TextButton", ScreenGui)
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "ESP: OFF"
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 20

ToggleButton.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    if espEnabled then
        ToggleButton.Text = "ESP: ON"
        enableESP()
    else
        ToggleButton.Text = "ESP: OFF"
        disableESP()
    end
end)

-- Dacă vrei, poți activa ESP automat la pornire:
-- espEnabled = true
-- ToggleButton.Text = "ESP: ON"
-- enableESP()
