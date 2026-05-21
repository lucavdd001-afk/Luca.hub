local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "CustomAntiCheat"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- BACKGROUND
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(240,240,240)
bg.BorderSizePixel = 0
bg.Parent = gui

-- MAIN BOX
local box = Instance.new("Frame")
box.Size = UDim2.new(0,700,0,420)
box.Position = UDim2.new(0.5,-350,0.5,-210)
box.BackgroundColor3 = Color3.fromRGB(255,255,255)
box.BorderSizePixel = 0
box.Parent = bg

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0,10)
boxCorner.Parent = box

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(210,210,210)
stroke.Thickness = 1
stroke.Parent = box

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,-50,0,70)
title.Position = UDim2.new(0,25,0,20)
title.BackgroundTransparency = 1
title.Text = "Disconnected"
title.TextColor3 = Color3.fromRGB(30,30,30)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Font = Enum.Font.GothamBold
title.TextScaled = true
title.Parent = box

-- MESSAGE
local message = Instance.new("TextLabel")
message.Size = UDim2.new(1,-50,0,220)
message.Position = UDim2.new(0,25,0,100)
message.BackgroundTransparency = 1
message.TextWrapped = true
message.TextXAlignment = Enum.TextXAlignment.Left
message.TextYAlignment = Enum.TextYAlignment.Top
message.TextColor3 = Color3.fromRGB(70,70,70)
message.Font = Enum.Font.Gotham
message.TextScaled = true
message.Text = [[You were removed from this experience.

Reason: exploiting go touch grass.

Your session has been terminated by the game's anti-cheat system due to suspicious activity linked to exploit execution or tampering with protected game functions.

Please restart Roblox and disable any third-party software before reconnecting.

(Error Code: 267)]]
message.Parent = box

-- WARNING ICON
local warning = Instance.new("TextLabel")
warning.Size = UDim2.new(0,70,0,70)
warning.Position = UDim2.new(0,25,1,-95)
warning.BackgroundTransparency = 1
warning.Text = "⚠"
warning.TextScaled = true
warning.Font = Enum.Font.GothamBold
warning.TextColor3 = Color3.fromRGB(255,170,0)
warning.Parent = box

-- LEAVE BUTTON
local leave = Instance.new("TextButton")
leave.Size = UDim2.new(0,180,0,55)
leave.Position = UDim2.new(1,-210,1,-80)
leave.BackgroundColor3 = Color3.fromRGB(0,162,255)
leave.Text = "Leave"
leave.TextColor3 = Color3.new(1,1,1)
leave.TextScaled = true
leave.Font = Enum.Font.GothamBold
leave.Parent = box

local leaveCorner = Instance.new("UICorner")
leaveCorner.CornerRadius = UDim.new(0,8)
leaveCorner.Parent = leave

-- BUTTON FUNCTION
leave.MouseButton1Click:Connect(function()
	player:Kick("Disconnected")
end)
