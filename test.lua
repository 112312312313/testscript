local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

-- Создание GUI Lalohub Scanner
local LalohubGUI = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local TitleBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local ScanFrame = Instance.new("Frame")
local TargetInput = Instance.new("TextBox")
local ScanButton = Instance.new("TextButton")
local ResultsFrame = Instance.new("ScrollingFrame")
local StatusLabel = Instance.new("TextLabel")

-- Основной GUI
LalohubGUI.Name = "LalohubScanner"
LalohubGUI.Parent = CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = LalohubGUI
MainFrame.Size = UDim2.new(0, 450, 0, 450)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true

-- Title Bar
TitleBar.Name = "TitleBar"
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
TitleBar.BorderSizePixel = 0

Title.Name = "Title"
Title.Parent = TitleBar
Title.Size = UDim2.new(1, -40, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "Lalohub Backdoor Scanner v3.0"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

CloseButton.Name = "CloseButton"
CloseButton.Parent = TitleBar
CloseButton.Size = UDim2.new(0, 40, 1, 0)
CloseButton.Position = UDim2.new(1, -40, 0, 0)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14

-- Scan Frame
ScanFrame.Name = "ScanFrame"
ScanFrame.Parent = MainFrame
ScanFrame.Size = UDim2.new(1, -20, 0, 80)
ScanFrame.Position = UDim2.new(0, 10, 0, 50)
ScanFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
ScanFrame.BorderSizePixel = 0

TargetInput.Name = "TargetInput"
TargetInput.Parent = ScanFrame
TargetInput.Size = UDim2.new(1, -20, 0, 30)
TargetInput.Position = UDim2.new(0, 10, 0, 10)
TargetInput.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
TargetInput.TextColor3 = Color3.fromRGB(255, 255, 255)
TargetInput.PlaceholderText = "Введите ID игры или оставьте пустым для текущей"
TargetInput.Font = Enum.Font.Gotham
TargetInput.TextSize = 12

ScanButton.Name = "ScanButton"
ScanButton.Parent = ScanFrame
ScanButton.Size = UDim2.new(1, -20, 0, 30)
ScanButton.Position = UDim2.new(0, 10, 0, 45)
ScanButton.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanButton.Text = "🚀 НАЧАТЬ СКАНИРОВАНИЕ LALOHUB"
ScanButton.Font = Enum.Font.GothamBold
ScanButton.TextSize = 14

-- Results Frame
ResultsFrame.Name = "ResultsFrame"
ResultsFrame.Parent = MainFrame
ResultsFrame.Size = UDim2.new(1, -20, 0, 280)
ResultsFrame.Position = UDim2.new(0, 10, 0, 140)
ResultsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
ResultsFrame.ScrollBarThickness = 8
ResultsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

StatusLabel.Name = "StatusLabel"
StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(1, -20, 0, 20)
StatusLabel.Position = UDim2.new(0, 10, 0, 120)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 255)
StatusLabel.Text = "Готов к сканированию..."
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 12

-- Функции Lalohub Scanner
local function CreateResultEntry(text, color, icon)
    local entry = Instance.new("TextLabel")
    entry.Text = icon .. " " .. text
    entry.TextColor3 = color
    entry.BackgroundTransparency = 1
    entry.Size = UDim2.new(1, -10, 0, 20)
    entry.Font = Enum.Font.Code
    entry.TextSize = 11
    entry.TextXAlignment = Enum.TextXAlignment.Left
    entry.Parent = ResultsFrame
    
    ResultsFrame.CanvasSize = ResultsFrame.CanvasSize + UDim2.new(0, 0, 0, 25)
end

local function DeepSecurityScan(gameObj)
    local vulnerabilities = {}
    
    -- Сканирование Scripts и LocalScripts
    for _, obj in pairs(gameObj:GetDescendants()) do
        if obj:IsA("Script") or obj:IsA("LocalScript") then
            local success, source = pcall(function()
                return obj.Source
            end)
            
            if success and source then
                -- Паттерны бэкдоров Lalohub
                local lalohubPatterns = {
                    {"getfenv", "Доступ к окружению"},
                    {"setfenv", "Изменение окружения"}, 
                    {"loadstring", "Динамическая загрузка кода"},
                    {"coroutine.create", "Создание потоков"},
                    {"hookfunction", "Хук функций"},
                    {"newcclosure", "Создание C-замыканий"},
                    {"checkcaller", "Проверка вызывающего"},
                    {"getconnections", "Доступ к соединениям"},
                    {"firetouchinterest", "Обход TouchInterest"},
                    {"Instance.new.*Network", "Сетевые манипуляции"},
                    {"game.*Service", "Доступ к сервисам"}
                }
                
                for _, pattern in ipairs(lalohubPatterns) do
                    if string.find(source, pattern[1]) then
                        table.insert(vulnerabilities, {
                            Object = obj,
                            Type = pattern[2],
                            Path = obj:GetFullName()
                        })
                    end
                end
            end
        end
    end
    return vulnerabilities
end

-- Обработчики событий
CloseButton.MouseButton1Click:Connect(function()
    LalohubGUI:Destroy()
end)

ScanButton.MouseButton1Click:Connect(function()
    ResultsFrame:ClearAllChildren()
    ResultsFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    StatusLabel.Text = "🔍 Сканирование запущено..."
    StatusLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
    
    wait(1)
    
    -- Запуск сканирования Lalohub
    local targetGame = game
    if TargetInput.Text ~= "" then
        CreateResultEntry("Сканирование игры ID: " .. TargetInput.Text, Color3.fromRGB(200, 200, 255), "🎯")
    else
        CreateResultEntry("Сканирование текущей игры", Color3.fromRGB(200, 200, 255), "🎮")
    end
    
    local foundVulns = DeepSecurityScan(targetGame)
    
    CreateResultEntry("Просканировано объектов: " .. #targetGame:GetDescendants(), Color3.fromRGB(150, 255, 150), "📊")
    CreateResultEntry("Найдено уязвимостей: " .. #foundVulns, Color3.fromRGB(255, 150, 150), "⚠️")
    
    -- Вывод результатов
    for i, vuln in ipairs(foundVulns) do
        local severityColor = i % 3 == 0 and Color3.fromRGB(255, 100, 100) or 
                            i % 3 == 1 and Color3.fromRGB(255, 150, 50) or 
                            Color3.fromRGB(255, 200, 0)
        
        CreateResultEntry(vuln.Path, severityColor, "🔓")
        CreateResultEntry("   Тип: " .. vuln.Type, Color3.fromRGB(200, 150, 255), "📝")
    end
    
    if #foundVulns == 0 then
        StatusLabel.Text = "✅ Безопасно - уязвимостей не найдено"
        StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
    else
        StatusLabel.Text = "🚨 ОБНАРУЖЕНЫ УЯЗВИМОСТИ LALOHUB!"
        StatusLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

-- Анимации
ScanButton.MouseEnter:Connect(function()
    ScanButton.BackgroundColor3 = Color3.fromRGB(150, 50, 255)
end)

ScanButton.MouseLeave:Connect(function()
    ScanButton.BackgroundColor3 = Color3.fromRGB(120, 0, 200)
end)

-- Эффект тени
local Shadow = Instance.new("UIStroke")
Shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Shadow.Color = Color3.fromRGB(80, 0, 160)
Shadow.Thickness = 2
Shadow.Parent = MainFrame
