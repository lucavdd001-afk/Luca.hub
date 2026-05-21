--// ADVANCED MOBILE SCRIPT HUB V2
--// Made for Loadstring Usage

if getgenv().AdvancedHubLoaded then
    return
end
getgenv().AdvancedHubLoaded = true

--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local TS = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")

--// PLAYER
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

--// SETTINGS
local KEY = "lucabom101"

local Settings = {
    WalkSpeed = 16,
    FlySpeed = 60,
    Fly = false,
    Noclip = false,
    ESP = false,
    InfiniteJump = false,
    Fullbright = false
}

--// CONNECTIONS
local FlyConnection
local NoclipConnection

--// CHARACTER UPDATE
local function UpdateCharacter()
    Character = Player.Character or Player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    RootPart = Character:WaitForChild("HumanoidRootPart")
end

Player.CharacterAdded:Connect(function()
    task.wait(1)
    UpdateCharacter()
end)

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AdvancedHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

--// OPEN BUTTON
local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0,60,0,60)
OpenButton.Position = UDim2.new(0,20,0.5,-30)
OpenButton.Text = "⚙️"
OpenButton.TextScaled = true
OpenButton.BackgroundColor3 = Color3.fromRGB(25,25,25)
OpenButton.TextColor3 = Color3.new(1,1,1)
OpenButton.Parent = ScreenGui
OpenButton.Visible = false
OpenButton.Draggable = true

Instance.new("UICorner",OpenButton).CornerRadius = UDim.new(1,0)

--// KEY GUI
local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0,320,0,220)
KeyFrame.Position = UDim2.new(0.5,-160,0.5,-110)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyFrame.Parent = ScreenGui

Instance.new("UICorner",KeyFrame).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "🔐 ADVANCED HUB"
Title.TextScaled = true
Title.TextColor3 = Color3.fromRGB(0,170,255)
Title.Parent = KeyFrame

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1,-20,0,40)
KeyBox.Position = UDim2.new(0,10,0,70)
KeyBox.PlaceholderText = "Enter Key..."
KeyBox.Text = ""
KeyBox.TextScaled = true
KeyBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.Parent = KeyFrame

Instance.new("UICorner",KeyBox).CornerRadius = UDim.new(0,8)

local Submit = Instance.new("TextButton")
Submit.Size = UDim2.new(1,-20,0,40)
Submit.Position = UDim2.new(0,10,0,125)
Submit.Text = "SUBMIT"
Submit.TextScaled = true
Submit.BackgroundColor3 = Color3.fromRGB(0,170,255)
Submit.TextColor3 = Color3.new(1,1,1)
Submit.Parent = KeyFrame

Instance.new("UICorner",Submit).CornerRadius = UDim.new(0,8)

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1,0,0,30)
Status.Position = UDim2.new(0,0,0,175)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.TextScaled = true
Status.TextColor3 = Color3.new(1,0,0)
Status.Parent = KeyFrame

--// MAIN HUB
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,320,0,450)
Main.Position = UDim2.new(0.5,-160,0.5,-225)
Main.BackgroundColor3 = Color3.fromRGB(20,20,20)
Main.Visible = false
Main.Active = true
Main.Draggable = true
Main.Parent = ScreenGui

Instance.new("UICorner",Main).CornerRadius = UDim.new(0,12)

local Header = Instance.new("TextLabel")
Header.Size = UDim2.new(1,0,0,50)
Header.BackgroundTransparency = 1
Header.Text = "⚙️ ADVANCED HUB V2"
Header.TextScaled = true
Header.TextColor3 = Color3.fromRGB(0,170,255)
Header.Parent = Main

--// MINIMIZE
local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,40,0,40)
Minimize.Position = UDim2.new(1,-45,0,5)
Minimize.Text = "-"
Minimize.TextScaled = true
Minimize.BackgroundColor3 = Color3.fromRGB(50,50,50)
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Parent = Main

Instance.new("UICorner",Minimize).CornerRadius = UDim.new(1,0)

Minimize.MouseButton1Click:Connect(function()
    Main.Visible = false
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    Main.Visible = true
    OpenButton.Visible = false
end)

--// BUTTON CREATOR
local Y = 60

local function CreateButton(Name, Callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1,-20,0,40)
    Button.Position = UDim2.new(0,10,0,Y)
    Button.BackgroundColor3 = Color3.fromRGB(35,35,35)
    Button.TextColor3 = Color3.new(1,1,1)
    Button.TextScaled = true
    Button.Text = Name
    Button.Parent = Main

    Instance.new("UICorner",Button).CornerRadius = UDim.new(0,8)

    Button.MouseButton1Click:Connect(Callback)

    Y += 50

    return Button
end

--// NOCLIP
CreateButton("🚫 Noclip", function()
    Settings.Noclip = not Settings.Noclip

    if Settings.Noclip then
        NoclipConnection = RS.Stepped:Connect(function()
            if Character then
                for _,v in pairs(Character:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = false
                    end
                end
            end
        end)
    else
        if NoclipConnection then
            NoclipConnection:Disconnect()
        end
    end
end)

--// FLY
CreateButton("🕊 Fly", function()
    Settings.Fly = not Settings.Fly

    if Settings.Fly then
        local BV = Instance.new("BodyVelocity")
        BV.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        BV.Parent = RootPart

        local BG = Instance.new("BodyGyro")
        BG.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
        BG.P = 10000
        BG.Parent = RootPart

        FlyConnection = RS.RenderStepped:Connect(function()
            BG.CFrame = workspace.CurrentCamera.CFrame

            local Direction = Vector3.zero

            if UIS:IsKeyDown(Enum.KeyCode.W) then
                Direction += workspace.CurrentCamera.CFrame.LookVector
            end

            if UIS:IsKeyDown(Enum.KeyCode.S) then
                Direction -= workspace.CurrentCamera.CFrame.LookVector
            end

            if UIS:IsKeyDown(Enum.KeyCode.A) then
                Direction -= workspace.CurrentCamera.CFrame.RightVector
            end

            if UIS:IsKeyDown(Enum.KeyCode.D) then
                Direction += workspace.CurrentCamera.CFrame.RightVector
            end

            if Direction.Magnitude > 0 then
                BV.Velocity = Direction.Unit * Settings.FlySpeed
            else
                BV.Velocity = Vector3.zero
            end
        end)
    else
        if FlyConnection then
            FlyConnection:Disconnect()
        end

        for _,v in pairs(RootPart:GetChildren()) do
            if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
                v:Destroy()
            end
        end
    end
end)

--// SPEED
CreateButton("⚡ Speed +", function()
    Settings.WalkSpeed += 5
    Humanoid.WalkSpeed = Settings.WalkSpeed
end)

CreateButton("⚡ Speed -", function()
    Settings.WalkSpeed -= 5
    Humanoid.WalkSpeed = Settings.WalkSpeed
end)

--// INFINITE JUMP
CreateButton("🦘 Infinite Jump", function()
    Settings.InfiniteJump = not Settings.InfiniteJump
end)

UIS.JumpRequest:Connect(function()
    if Settings.InfiniteJump then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

--// FULLBRIGHT
CreateButton("💡 Fullbright", function()
    Settings.Fullbright = not Settings.Fullbright

    if Settings.Fullbright then
        Lighting.Brightness = 5
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
    end
end)

--// ESP
local function AddESP(Target)
    if not Target.Character then
        return
    end

    if Target.Character:FindFirstChild("Highlight") then
        return
    end

    local Highlight = Instance.new("Highlight")
    Highlight.FillColor = Color3.fromRGB(0,255,0)
    Highlight.OutlineColor = Color3.new(1,1,1)
    Highlight.FillTransparency = 0.5
    Highlight.Parent = Target.Character
end

CreateButton("👁 ESP", function()
    Settings.ESP = not Settings.ESP

    if Settings.ESP then
        for _,v in pairs(Players:GetPlayers()) do
            if v ~= Player then
                AddESP(v)
            end
        end
    else
        for _,v in pairs(Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("Highlight") then
                v.Character.Highlight:Destroy()
            end
        end
    end
end)

Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function()
        task.wait(1)

        if Settings.ESP then
            AddESP(plr)
        end
    end)
end)

--// REJOIN
CreateButton("🔄 Rejoin", function()
    TS:Teleport(game.PlaceId,Player)
end)

--// COPY DISCORD
CreateButton("📋 Copy Discord", function()
    if setclipboard then
        setclipboard("discord.gg/yourserver")
    end
end)

--// DESTROY HUB
CreateButton("❌ Destroy Hub", function()
    ScreenGui:Destroy()

    if FlyConnection then
        FlyConnection:Disconnect()
    end

    if NoclipConnection then
        NoclipConnection:Disconnect()
    end

    getgenv().AdvancedHubLoaded = false
end)

--// KEY SYSTEM
Submit.MouseButton1Click:Connect(function()
    if KeyBox.Text == KEY then
        Status.TextColor3 = Color3.fromRGB(0,255,0)
        Status.Text = "ACCESS GRANTED"

        task.wait(1)

        KeyFrame.Visible = false
        Main.Visible = true
    else
        Status.Text = "WRONG KEY"
    end
end)

print("Advanced Hub Loaded Successfully")
