local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TeleportGui"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- OPEN BUTTON
local openButton = Instance.new("TextButton")
openButton.Size = UDim2.new(0,50,0,50)
openButton.Position = UDim2.new(0,15,0.5,-25)
openButton.Text = "TP"
openButton.TextScaled = true
openButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
openButton.TextColor3 = Color3.new(1,1,1)
openButton.Parent = gui

local openCorner = Instance.new("UICorner")
openCorner.CornerRadius = UDim.new(1,0)
openCorner.Parent = openButton

-- MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,220,0,180)
frame.Position = UDim2.new(0.5,-110,0.5,-90)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0,10)
frameCorner.Parent = frame

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,35)
title.BackgroundColor3 = Color3.fromRGB(35,35,35)
title.Text = "Player Teleport"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.BorderSizePixel = 0
title.Parent = frame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0,10)
titleCorner.Parent = title

-- CLOSE BUTTON
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0,30,0,30)
closeButton.Position = UDim2.new(1,-35,0,3)
closeButton.Text = "X"
closeButton.TextScaled = true
closeButton.BackgroundColor3 = Color3.fromRGB(180,50,50)
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Parent = frame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1,0)
closeCorner.Parent = closeButton

-- PLAYER BOX
local playerBox = Instance.new("TextBox")
playerBox.Size = UDim2.new(0.9,0,0,40)
playerBox.Position = UDim2.new(0.05,0,0,55)
playerBox.PlaceholderText = "Enter player name"
playerBox.Text = ""
playerBox.TextScaled = true
playerBox.BackgroundColor3 = Color3.fromRGB(45,45,45)
playerBox.TextColor3 = Color3.new(1,1,1)
playerBox.Parent = frame

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0,8)
boxCorner.Parent = playerBox

-- TELEPORT BUTTON
local tpButton = Instance.new("TextButton")
tpButton.Size = UDim2.new(0.9,0,0,45)
tpButton.Position = UDim2.new(0.05,0,0,110)
tpButton.Text = "Teleport"
tpButton.TextScaled = true
tpButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
tpButton.TextColor3 = Color3.new(1,1,1)
tpButton.Parent = frame

local tpCorner = Instance.new("UICorner")
tpCorner.CornerRadius = UDim.new(0,8)
tpCorner.Parent = tpButton

-- OPEN GUI
openButton.MouseButton1Click:Connect(function()
	frame.Visible = true
	openButton.Visible = false
end)

-- CLOSE GUI
closeButton.MouseButton1Click:Connect(function()
	frame.Visible = false
	openButton.Visible = true
end)

-- TELEPORT FUNCTION
tpButton.MouseButton1Click:Connect(function()
	local targetName = playerBox.Text
	
	for _, target in pairs(Players:GetPlayers()) do
		if string.lower(target.Name):find(string.lower(targetName)) then
			
			if target.Character
			and target.Character:FindFirstChild("HumanoidRootPart")
			and player.Character
			and player.Character:FindFirstChild("HumanoidRootPart") then
				
				player.Character.HumanoidRootPart.CFrame =
					target.Character.HumanoidRootPart.CFrame + Vector3.new(0,3,0)
			end
		end
	end
end)
