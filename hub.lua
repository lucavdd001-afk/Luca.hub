local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "FakeBanGui"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = player:WaitForChild("PlayerGui")

-- BLACK BACKGROUND
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.new(0,0,0)
bg.BorderSizePixel = 0
bg.Parent = gui

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,80)
title.Position = UDim2.new(0,0,0.2,0)
title.BackgroundTransparency = 1
title.Text = "Account Deleted"
title.TextColor3 = Color3.fromRGB(255,70,70)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = bg

-- MESSAGE
local message = Instance.new("TextLabel")
message.Size = UDim2.new(0.8,0,0,120)
message.Position = UDim2.new(0.1,0,0.38,0)
message.BackgroundTransparency = 1
message.Text = "Your account has been permanently banned for exploiting and violating community guidelines."
message.TextWrapped = true
message.TextColor3 = Color3.new(1,1,1)
message.TextScaled = true
message.Font = Enum.Font.Gotham
message.Parent = bg

-- ERROR CODE
local code = Instance.new("TextLabel")
code.Size = UDim2.new(1,0,0,40)
code.Position = UDim2.new(0,0,0.55,0)
code.BackgroundTransparency = 1
code.Text = "Error Code: 267"
code.TextColor3 = Color3.fromRGB(170,170,170)
code.TextScaled = true
code.Font = Enum.Font.Code
code.Parent = bg

-- LEAVE BUTTON
local leave = Instance.new("TextButton")
leave.Size = UDim2.new(0,220,0,55)
leave.Position = UDim2.new(0.5,-110,0.72,0)
leave.BackgroundColor3 = Color3.fromRGB(220,50,50)
leave.Text = "Leave"
leave.TextColor3 = Color3.new(1,1,1)
leave.TextScaled = true
leave.Font = Enum.Font.GothamBold
leave.Parent = bg

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,10)
corner.Parent = leave

-- BUTTON EFFECT
leave.MouseButton1Click:Connect(function()
	player:Kick("Disconnected")
end)
