-- LOOOL Чит для мобильных устройств
-- Простая версия без сложных библиотек

-- Создаем простой GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LOOOOLMobile"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "LOOOOL 🚀 MOBILE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Title.Parent = MainFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, -40)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 40)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 800)
ScrollingFrame.Parent = MainFrame

-- Глобальные переменные
getgenv().Noclip = false
getgenv().Fly = false
getgenv().Spinbot = false
getgenv().ESP = false
getgenv().Invisible = false
getgenv().InfJump = false

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Функция создания кнопки
local function CreateButton(text, yPosition, callback)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0.9, 0, 0, 40)
    Button.Position = UDim2.new(0.05, 0, 0, yPosition)
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Button.Parent = ScrollingFrame
    
    Button.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

-- Функция создания переключателя
local function CreateToggle(text, yPosition)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(0.9, 0, 0, 40)
    ToggleFrame.Position = UDim2.new(0.05, 0, 0, yPosition)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ToggleFrame.Parent = ScrollingFrame
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(0.7, 0, 1, 0)
    ToggleLabel.Position = UDim2.new(0, 0, 0, 0)
    ToggleLabel.Text = text
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Parent = ToggleFrame
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0.2, 0, 0.6, 0)
    ToggleButton.Position = UDim2.new(0.75, 0, 0.2, 0)
    ToggleButton.Text = "OFF"
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    ToggleButton.Parent = ToggleFrame
    
    return ToggleButton
end

-- Создаем функции
local yPos = 10

-- Невидимость
local InvisibleToggle = CreateToggle("👻 Невидимость", yPos)
yPos = yPos + 50

InvisibleToggle.MouseButton1Click:Connect(function()
    if InvisibleToggle.Text == "OFF" then
        InvisibleToggle.Text = "ON"
        InvisibleToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        getgenv().Invisible = true
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                    part.CanCollide = false
                end
            end
        end
    else
        InvisibleToggle.Text = "OFF"
        InvisibleToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        getgenv().Invisible = false
        local char = LocalPlayer.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- Spinbot
local SpinbotToggle = CreateToggle("🔄 Spinbot", yPos)
yPos = yPos + 50

SpinbotToggle.MouseButton1Click:Connect(function()
    if SpinbotToggle.Text == "OFF" then
        SpinbotToggle.Text = "ON"
        SpinbotToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        getgenv().Spinbot = true
        spawn(function()
            while getgenv().Spinbot do
                RunService.RenderStepped:Wait()
                local char = LocalPlayer.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(30), 0)
                    end
                end
            end
        end)
    else
        SpinbotToggle.Text = "OFF"
        SpinbotToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        getgenv().Spinbot = false
    end
end)

-- Легание (Noclip)
local NoclipToggle = CreateToggle("👻 Легание", yPos)
yPos = yPos + 50

NoclipToggle.MouseButton1Click:Connect(function()
    if NoclipToggle.Text == "OFF" then
        NoclipToggle.Text = "ON"
        NoclipToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        getgenv().Noclip = true
        RunService.Stepped:Connect(function()
            if getgenv().Noclip and LocalPlayer.Character then
                for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        NoclipToggle.Text = "OFF"
        NoclipToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        getgenv().Noclip = false
    end
end)

-- ESP
local ESPToggle = CreateToggle("🎯 ESP", yPos)
yPos = yPos + 50

ESPToggle.MouseButton1Click:Connect(function()
    if ESPToggle.Text == "OFF" then
        ESPToggle.Text = "ON"
        ESPToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        getgenv().ESP = true
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                spawn(function()
                    while getgenv().ESP and player and player.Character do
                        RunService.RenderStepped:Wait()
                        local char = player.Character
                        if char then
                            local highlight = char:FindFirstChildOfClass("Highlight")
                            if not highlight then
                                highlight = Instance.new("Highlight")
                                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                highlight.Parent = char
                            end
                            highlight.Adornee = char
                        end
                    end
                end)
            end
        end
    else
        ESPToggle.Text = "OFF"
        ESPToggle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        getgenv().ESP = false
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChildOfClass("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end)

-- Кнопки
CreateButton("💨 Скорость +50", yPos, function()
    local char = LocalPlayer.Character
    if char then
        char.Humanoid.WalkSpeed = char.Humanoid.WalkSpeed + 50
    end
end)
yPos = yPos + 50

CreateButton("🦘 Прыжок +50", yPos, function()
    local char = LocalPlayer.Character
    if char then
        char.Humanoid.JumpPower = char.Humanoid.JumpPower + 50
    end
end)
yPos = yPos + 50

CreateButton("💀 Бессмертие", yPos, function()
    local char = LocalPlayer.Character
    if char then
        char.Humanoid.MaxHealth = math.huge
        char.Humanoid.Health = math.huge
    end
end)
yPos = yPos + 50

CreateButton("⚡ Телепорт ко всем", yPos, function()
    local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if myRoot then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    targetRoot.CFrame = myRoot.CFrame
                end
            end
        end
    end
end)
yPos = yPos + 50

CreateButton("☠️ Убить всех", yPos, function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            player.Character:BreakJoints()
        end
    end
end)
yPos = yPos + 50

CreateButton("🔄 Респавн всех", yPos, function()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            player.Character:BreakJoints()
        end
    end
end)
yPos = yPos + 50

-- Перемещение GUI
local dragging = false
local dragInput, dragStart, startPos

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Защита от кика
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

print("LOOOOL MOBILE loaded! ALL LOAD!")
