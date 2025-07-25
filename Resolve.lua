local link = "https://discord.gg/wrKsPnQmbp"

local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local TextLabelOutline = Instance.new("UIStroke")
local Button = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

Frame.Size = UDim2.new(0, 320, 0, 150)
Frame.Position = UDim2.new(0.5, -160, 0.5, -75)
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Frame

TextLabel.Text = "Optimus Hub is updating\nJoin Discord for update notification."
TextLabel.Size = UDim2.new(1, -20, 0, 80)
TextLabel.Position = UDim2.new(0, 10, 0, 10)
TextLabel.TextWrapped = true
TextLabel.Font = Enum.Font.GothamBold
TextLabel.TextSize = 18
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundTransparency = 1
TextLabel.Parent = Frame

-- Outline black for text for better visibility
TextLabelOutline.Thickness = 2
TextLabelOutline.Color = Color3.new(0, 0, 0)
TextLabelOutline.Parent = TextLabel

Button.Text = "🔗 Copy Link"
Button.Size = UDim2.new(0, 160, 0, 40)
Button.Position = UDim2.new(0.5, -80, 1, -50)
Button.Font = Enum.Font.Gotham
Button.TextSize = 16
Button.TextColor3 = Color3.new(1, 1, 1)
Button.BackgroundColor3 = Color3.fromRGB(60, 60, 255)
Button.Parent = Frame

local buttonCorner = Instance.new("UICorner", Button)
buttonCorner.CornerRadius = UDim.new(0, 10)

-- Rainbow animation
task.spawn(function()
	local hue = 0
	while true do
		hue = (hue + 0.01) % 1
		local color = Color3.fromHSV(hue, 1, 1)
		Frame.BackgroundColor3 = color
		Button.BackgroundColor3 = color
		TextLabel.TextColor3 = color:lerp(Color3.new(1,1,1), 0.2)
		task.wait(0.03)
	end
end)

-- Clipboard + open Chrome browser
Button.MouseButton1Click:Connect(function()
	-- Copy link to clipboard (Delta supports setclipboard)
	if setclipboard then setclipboard(link) end

	-- Try to open Chrome explicitly - depends on exploit and OS
	local success = false

	-- If using Synapse or other exploit that supports syn.request/open
	if syn and syn.open then
		pcall(function() syn.open(link) end)
		success = true
	end

	-- Alternative: Roblox open url (may open default browser)
	if not success then
		pcall(function()
			game:GetService("StarterGui"):SetCore("OpenUrl", link)
		end)
	end
end)
