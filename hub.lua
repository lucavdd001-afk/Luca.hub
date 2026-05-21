local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- SETTINGS
local aimbotEnabled = false
local aimbotRange = 100
local smoothness = 0.12

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AimbotGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- MAIN FRAME
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 260, 0, 220)
mainFrame.Position = UDim2.new(0.5, -130, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- MOBILE + PC DRAG
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0,10)
corner.Parent = mainFrame

-- TITLE
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.BackgroundColor3 = Color3.fromRGB(35,35,35)
title.Text = "Mobile Aim Assist"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.BorderSizePixel = 0
title.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0,10)
titleCorner.Parent = title

-- TOGGLE BUTTON
local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0.9,0,0,45)
toggleButton.Position = UDim2.new(0.05,0,0,55)
toggleButton.BackgroundColor3 = Color3.fromRGB(180,50,50)
toggleButton.Text = "Aimbot OFF"
toggleButton.TextColor3 = Color3.new(1,1,1)
toggleButton.Font = Enum.Font.GothamBold
toggleButton.TextSize = 16
toggleButton.BorderSizePixel = 0
toggleButton.Parent = mainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0,8)
toggleCorner.Parent = toggleButton

-- RANGE LABEL
local rangeLabel = Instance.new("TextLabel")
rangeLabel.Size = UDim2.new(1,0,0,25)
rangeLabel.Position = UDim2.new(0,0,0,115)
rangeLabel.BackgroundTransparency = 1
rangeLabel.Text = "Range: 100"
rangeLabel.TextColor3 = Color3.new(1,1,1)
rangeLabel.Font = Enum.Font.Gotham
rangeLabel.TextSize = 14
rangeLabel.Parent = mainFrame

-- SLIDER BAR
local sliderBack = Instance.new("Frame")
sliderBack.Size = UDim2.new(0.9,0,0,14)
sliderBack.Position = UDim2.new(0.05,0,0,145)
sliderBack.BackgroundColor3 = Color3.fromRGB(50,50,50)
sliderBack.BorderSizePixel = 0
sliderBack.Parent = mainFrame

local sliderBackCorner = Instance.new("UICorner")
sliderBackCorner.CornerRadius = UDim.new(1,0)
sliderBackCorner.Parent = sliderBack

-- SLIDER FILL
local sliderFill = Instance.new("Frame")
sliderFill.Size = UDim2.new(0.45,0,1,0)
sliderFill.BackgroundColor3 = Color3.fromRGB(0,170,255)
sliderFill.BorderSizePixel = 0
sliderFill.Parent = sliderBack

local sliderFillCorner = Instance.new("UICorner")
sliderFillCorner.CornerRadius = UDim.new(1,0)
sliderFillCorner.Parent = sliderFill

-- CLOSE BUTTON
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0,35,0,35)
closeButton.Position = UDim2.new(1,-40,0,5)
closeButton.BackgroundColor3 = Color3.fromRGB(200,60,60)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 16
closeButton.BorderSizePixel = 0
closeButton.Parent = mainFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1,0)
closeCorner.Parent = closeButton

-- TOGGLE
toggleButton.MouseButton1Click:Connect(function()
	aimbotEnabled = not aimbotEnabled
	
	if aimbotEnabled then
		toggleButton.Text = "Aimbot ON"
		toggleButton.BackgroundColor3 = Color3.fromRGB(50,200,80)
	else
		toggleButton.Text = "Aimbot OFF"
		toggleButton.BackgroundColor3 = Color3.fromRGB(180,50,50)
	end
end)

-- CLOSE GUI
closeButton.MouseButton1Click:Connect(function()
	screenGui:Destroy()
end)

-- MOBILE + PC SLIDER
local draggingSlider = false

local function updateSlider(input)
	local posX
	
	if input.UserInputType == Enum.UserInputType.Touch then
		posX = input.Position.X
	else
		posX = UserInputService:GetMouseLocation().X
	end
	
	local barX = sliderBack.AbsolutePosition.X
	local barSize = sliderBack.AbsoluteSize.X
	
	local percent = math.clamp((posX - barX) / barSize, 0, 1)
	
	sliderFill.Size = UDim2.new(percent,0,1,0)
	
	aimbotRange = math.floor(percent * 300)
	if aimbotRange < 20 then
		aimbotRange = 20
	end
	
	rangeLabel.Text = "Range: "..aimbotRange
end

sliderBack.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		
		draggingSlider = true
		updateSlider(input)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if draggingSlider then
		updateSlider(input)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		
		draggingSlider = false
	end
end)

-- FIND CLOSEST PLAYER
local function getClosestPlayer()
	local closest = nil
	local shortestDistance = aimbotRange
	
	for _, target in pairs(Players:GetPlayers()) do
		if target ~= player and target.Character then
			
			local humanoid = target.Character:FindFirstChild("Humanoid")
			local root = target.Character:FindFirstChild("HumanoidRootPart")
			
			if humanoid and root and humanoid.Health > 0 then
				
				local myRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
				
				if myRoot then
					local distance = (root.Position - myRoot.Position).Magnitude
					
					if distance < shortestDistance then
						shortestDistance = distance
						closest = target
					end
				end
			end
		end
	end
	
	return closest
end

-- AIMBOT LOOP
RunService.RenderStepped:Connect(function()
	if not aimbotEnabled then
		return
	end
	
	local target = getClosestPlayer()
	
	if target and target.Character then
		local root = target.Character:FindFirstChild("HumanoidRootPart")
		
		if root then
			local camPos = camera.CFrame.Position
			local targetPos = root.Position
			
			local newCF = CFrame.new(camPos, targetPos)
			
			camera.CFrame = camera.CFrame:Lerp(newCF, smoothness)
		end
	end
end)
