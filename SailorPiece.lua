-- Dark Hub - Sailor Piece (Universal - PC + Mobile)
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Root = Char:WaitForChild("HumanoidRootPart")

getgenv().AF = false
getgenv().KA = false
getgenv().AutoQuest = false

local SG = Instance.new("ScreenGui")
SG.ResetOnSpawn = false
SG.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 290, 0, 360)
Frame.Position = UDim2.new(0.4, 0, 0.3, 0)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Frame.BorderSizePixel = 0
Frame.Parent = SG

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(0, 70, 160)
Title.Text = "Dark Hub - Sailor Piece"
Title.TextColor3 = Color3.new(1,1,1)
Title.TextScaled = true
Title.Parent = Frame

-- Draggable (PC + Mobile friendly)
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        local startPos = Frame.Position
        local startLoc = input.Position
        local conn = game:GetService("RunService").RenderStepped:Connect(function()
            local delta = game:GetService("UserInputService"):GetMouseLocation() - Vector2.new(startLoc.X, startLoc.Y)
            Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end)
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then conn:Disconnect() end
        end)
    end
end)

local y = 60
local function AddToggle(name, var)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9,0,0,45)
    Btn.Position = UDim2.new(0.05,0,0,y)
    Btn.BackgroundColor3 = Color3.fromRGB(30,30,30)
    Btn.Text = name .. ": OFF"
    Btn.TextColor3 = Color3.new(1,1,1)
    Btn.TextScaled = true
    Btn.Parent = Frame
    Btn.MouseButton1Click:Connect(function()
        getgenv()[var] = not getgenv()[var]
        Btn.Text = name .. ": " .. (getgenv()[var] and "ON ✅" or "OFF")
    end)
    y = y + 55
end

AddToggle("Auto Farm", "AF")
AddToggle("Kill Aura", "KA")
AddToggle("Auto Quest", "AutoQuest")

-- Auto Farm
task.spawn(function()
    while task.wait(0.3) do
        if getgenv().AF and Root then
            for _, mob in ipairs(Workspace:FindFirstChild("Enemies") and Workspace.Enemies:GetChildren() or Workspace:GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    Root.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
                    break
                end
            end
        end
    end
end)

-- Kill Aura
task.spawn(function()
    while task.wait(0.2) do
        if getgenv().KA and Root then
            for _, mob in ipairs(Workspace:FindFirstChild("Enemies") and Workspace.Enemies:GetChildren() or {}) do
                local hrp = mob:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - Root.Position).Magnitude < 30 and mob.Humanoid.Health > 0 then
                    -- Add game-specific attack remote here
                end
            end
        end
    end
end)

print("✅ Dark Hub - Sailor Piece Loaded")
