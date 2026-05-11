-- // Dark Hub - Sailor Piece (Better Version)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLibV3/main/Library.lua"))()
local ThemeManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLibV3/main/Addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLibV3/main/Addons/SaveManager.lua"))()

local Window = Library:CreateWindow({
    Title = 'Dark Hub | Sailor Piece',
    Center = true,
    AutoShow = true,
})

local Tabs = {
    Main = Window:AddTab('Main'),
    Combat = Window:AddTab('Combat'),
    Auto = Window:AddTab('Automation'),
    Teleport = Window:AddTab('Teleport'),
    Misc = Window:AddTab('Misc')
}

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Root = Char:WaitForChild("HumanoidRootPart")

getgenv().DarkHub = {
    AF = false,
    KA = false,
    AutoQuest = false,
    Speed = 100
}

-- Main Tab
local Main = Tabs.Main

Main:AddToggle('AutoFarm', {
    Text = 'Auto Farm',
    Default = false,
    Callback = function(v)
        getgenv().DarkHub.AF = v
    end
})

Main:AddToggle('AutoQuest', {
    Text = 'Auto Quest',
    Default = false,
    Callback = function(v) getgenv().DarkHub.AutoQuest = v end
})

-- Combat Tab
local Combat = Tabs.Combat

Combat:AddToggle('KillAura', {
    Text = 'Kill Aura',
    Default = false,
    Callback = function(v) getgenv().DarkHub.KA = v end
})

Combat:AddSlider('KillAuraRange', {
    Text = 'Kill Aura Range',
    Default = 20,
    Min = 5,
    Max = 50,
    Rounding = 0,
})

-- Misc
local Misc = Tabs.Misc

Misc:AddSlider('WalkSpeed', {
    Text = 'WalkSpeed',
    Default = 16,
    Min = 16,
    Max = 300,
    Rounding = 0,
    Callback = function(v)
        if Char and Char:FindFirstChild("Humanoid") then
            Char.Humanoid.WalkSpeed = v
        end
    end
})

Misc:AddButton({
    Text = 'FPS Boost',
    Func = function()
        setfpscap(999)
        pcall(function() settings().Rendering.QualityLevel = 1 end)
    end
})

-- Auto Farm Loop
task.spawn(function()
    while task.wait(0.25) do
        if getgenv().DarkHub.AF and Root then
            for _, mob in ipairs(Workspace:FindFirstChild("Enemies") and Workspace.Enemies:GetChildren() or Workspace:GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    Root.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                    break
                end
            end
        end
    end
end)

-- Kill Aura Loop
task.spawn(function()
    while task.wait(0.15) do
        if getgenv().DarkHub.KA and Root then
            for _, mob in ipairs(Workspace:FindFirstChild("Enemies") and Workspace.Enemies:GetChildren() or {}) do
                local hrp = mob:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - Root.Position).Magnitude < 25 and mob.Humanoid.Health > 0 then
                    -- Add attack remote if you find it
                end
            end
        end
    end
end)

Library:Notify('Dark Hub', 'Loaded successfully for Sailor Piece!', 5)
print("✅ Dark Hub - Sailor Piece Loaded")
