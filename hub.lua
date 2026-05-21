local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local mouse = player:GetMouse()

-- GUI Configuration
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AimbotGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 250, 0, 200)
mainFrame.Position = UDim2.new(0.5, -125, 0, 20)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = mainFrame

-- Title
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Text = "Aim Assist System"
title.BorderSizePixel = 0
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 8)
titleCorner.Parent = title

-- Toggle Button for Aimbot
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.new(0.9, 0, 0, 40)
toggleButton.Position = UDim2.new(0.05, 0, 0, 50)
toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.Gotham
toggleButton.Text = "Aimbot: OFF"
toggleButton.BorderSizePixel = 0
toggleButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 6)
buttonCorner.Parent = toggleButton

-- Range Slider
local rangeLabel = Instance.new("TextLabel")
rangeLabel.Name = "RangeLabel"
rangeLabel.Size = UDim2.new(1, 0, 0, 25)
rangeLabel.Position = UDim2.new(0, 0, 0, 95)
rangeLabel.BackgroundTransparency = 1
rangeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
rangeLabel.TextSize = 12
rangeLabel.Font = Enum.Font.Gotham
rangeLabel.Text = "Range: 100 studs"
rangeLabel.Parent = mainFrame

local rangeSlider = Instance.new("Frame")
rangeSlider.Name = "RangeSlider"
rangeSlider.Size = UDim2.new(0.9, 0, 0, 10)
rangeSlider.Position = UDim2.new(0.05, 0, 0, 125)
rangeSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
rangeSlider.BorderSizePixel = 0
rangeSlider.Parent = mainFrame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim2.new(0, 5)
sliderCorner.Parent = rangeSlider

local sliderFill = Instance.new("Frame")
sliderFill.Name = "Fill"
sliderFill.Size = UDim2.new(0.5, 0, 1, 0)
sliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = rangeSlider

local fillCorner = Instance.new("UICorner")
fillCorner.CornerRadius = UDim2.new(0, 5)
fillCorner.Parent = sliderFill

-- Settings
local aimbotEnabled = false
local aimbotRange = 100
local smoothness = 0.1
local targetPlayer = nil

-- Toggle Aimbot
toggleButton.MouseButton1Click:Connect(function()
	aimbotEnabled = not aimbotEnabled
	if aimbotEnabled then
		toggleButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
		toggleButton.Text = "Aimbot: ON"
	else
		toggleButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		toggleButton.Text = "Aimbot: OFF"
		targetPlayer = nil
	end
end)

-- Slider Interaction (for mobile and desktop)
rangeSlider.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		local function updateSlider()
			local mousePos = mouse.X
			local sliderPos = rangeSlider.AbsolutePosition.X
			local sliderSize = rangeSlider.AbsoluteSize.X
			local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
			
			aimbotRange = math.floor(percentage * 200) + 10
			sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
			rangeLabel.Text = "Range: " .. aimbotRange .. " studs"
		end
		
		updateSlider()
		local connection
		connection = RunService.RenderStepped:Connect(function()
			if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or UserInputService:IsTouchActive(1) then
				updateSlider()
			else
				connection:Disconnect()
			end
		end)
	end
end)

-- Find closest enemy
local function findClosestEnemy()
	local closestDistance = aimbotRange
	local closestPlayer = nil
	
	for _, otherPlayer in pairs(Players:GetPlayers()) do
		if otherPlayer ~= player and otherPlayer.Character then
			local character = otherPlayer.Character
			local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
			local humanoid = character:FindFirstChild("Humanoid")
			
			if humanoidRootPart and humanoid and humanoid.Health > 0 then
				local distance = (humanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
				
				if distance < closestDistance then
					closestDistance = distance
					closestPlayer = otherPlayer
				end
			end
		end
	end
	
	return closestPlayer
end

-- Main Aimbot Loop
RunService.RenderStepped:Connect(function()
	if aimbotEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
		local target = findClosestEnemy()
		
		if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
			local targetPos = target.Character.HumanoidRootPart.Position
			local cameraPos = camera.CFrame.Position
			
			-- Smooth aim towards target
			local direction = (targetPos - cameraPos).Unit
			local newCFrame = CFrame.new(cameraPos, cameraPos + direction)
			
			camera.CFrame = camera.CFrame:Lerp(newCFrame, smoothness)
			targetPlayer = target
		else
			targetPlayer = nil
		end
	end
end)

-- Cleanup on respawn
player.CharacterAdded:Connect(function()
	targetPlayer = nil
end)
