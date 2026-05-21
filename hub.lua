local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local AutoFarm = true
local CollectionFolder = Workspace:FindFirstChild("Nuggets") -- Change to actual folder name

spawn(function()
    while AutoFarm do
        if CollectionFolder then
            for _, nugget in pairs(CollectionFolder:GetChildren()) do
                if nugget:FindFirstChild("TouchInterest") then
                    -- Move player to nugget
                    LocalPlayer.Character.HumanoidRootPart.CFrame = nugget.CFrame
                    task.wait(0.1) -- Cooldown to prevent teleport crashing
                end
            end
        end
        task.wait(1) -- Delay before next scan
    end
end)
