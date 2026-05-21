local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "BanScreen"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- BACKGROUND
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(245,245,245)
bg.BorderSizePixel = 0
bg.Parent = gui

-- MAIN BOX
local box = Instance.new("Frame")
box.Size = UDim2.new(0,500,0,300)
box.Position = UDim2.new(0.5,-250,0.5,-150)
box.BackgroundColor3 = Color3.fromRGB(255,255,255)
box.BorderSizePixel = 0
box.Parent = bg

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0,8)
boxCorner.Parent = box

-- SHADOW EFFECT
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(220,220,220)
stroke.Thickness = 1
stroke.Parent = box

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-40,0,50)
title.Position = UDim2.new(0,20,0,20)
title.BackgroundTransparency = 1
title.Text = "Disconnected"
title.TextColor3 = Color3.fromRGB(35,35,35)
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = box

-- MESSAGE
local message = Instance.new("TextLabel")
message.Size = UDim2.new(1,-40,0,140)
message.Position = UDim2.new(0,20,0,80)
message.BackgroundTransparency = 1
message.TextWrapped = true
message.TextXAlignment = Enum.TextXAlignment.Left
message.TextYAlignment = Enum.TextYAlignment.Top
message.TextColor3 = Color3.fromRGB(70,70,70)
message.TextScaled = true
message.Font = Enum.Font.Gotham
message.Text = [[You were kicked from this experience.

Reason: Exploiting detected.

Your account has been flagged for suspicious activity. Please restart Roblox and try again.

(Error Code: 267)]]
message.Parent = box

-- LEAVE BUTTON
local leave = Instance.new("TextButton")
leave.Size = UDim2.new(0,140,0,45)
leave.Position = UDim2.new(1,-160,1,-65)
leave.BackgroundColor3 = Color3.fromRGB(0,162,255)
leave.Text = "Leave"
leave.TextColor3 = Color3.new(1,1,1)
leave.TextScaled = true
leave.Font = Enum.Font.GothamBold
leave.Parent = box

local leaveCorner = Instance.new("UICorner")
leaveCorner.CornerRadius = UDim.new(0,6)
leaveCorner.Parent = leave

-- BUTTON FUNCTION
leave.MouseButton1Click:Connect(function()
	player:Kick("Error Code: 267")
end)
