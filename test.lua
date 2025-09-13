local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateBackdoorScannerPro"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главный фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 700, 0, 600)
MainFrame.Position = UDim2.new(0.5, -350, 0.5, -300)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Заголовок с анимированным мемом
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 80)
Header.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local memes = {
    "ОМГ POCO 😱", 
    "Backdoor GO BRRRR 💉", 
    "Scanner GOD 🎩", 
    "Require KING 👑",
    "Lalol Hub PRO MAX ⚔️",
    "Lua LEGEND 🧠",
    "Universal EXECUTOR 🚀",
    "Roblox HACKER 🌟",
    "Scanning GOAT 🐐",
    "MEME LORD 🤣",
    "SUPER SCANNER 🔍",
    "BACKDOOR BUSTER 🚀"
}

local currentMeme = memes[math.random(1, #memes)]

local Title = Instance.new("TextLabel")
Title.Text = "ULTIMATE BACKDOOR SCANNER - " .. currentMeme
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.Parent = Header

-- Вкладки
local TabsFrame = Instance.new("Frame")
TabsFrame.Size = UDim2.new(1, 0, 0, 40)
TabsFrame.Position = UDim2.new(0, 0, 0, 80)
TabsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
TabsFrame.BorderSizePixel = 0
TabsFrame.Parent = MainFrame

local ScannerTab = Instance.new("TextButton")
ScannerTab.Text = "СКАНЕР"
ScannerTab.Size = UDim2.new(0.33, 0, 1, 0)
ScannerTab.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
ScannerTab.TextColor3 = Color3.fromRGB(255, 255, 255)
ScannerTab.Font = Enum.Font.SourceSansBold
ScannerTab.TextSize = 16
ScannerTab.Parent = TabsFrame

local ExecutorTab = Instance.new("TextButton")
ExecutorTab.Text = "ВЫПОЛНЕНИЕ"
ExecutorTab.Size = UDim2.new(0.33, 0, 1, 0)
ExecutorTab.Position = UDim2.new(0.33, 0, 0, 0)
ExecutorTab.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ExecutorTab.TextColor3 = Color3.fromRGB(200, 200, 200)
ExecutorTab.Font = Enum.Font.SourceSansBold
ExecutorTab.TextSize = 16
ExecutorTab.Parent = TabsFrame

local SettingsTab = Instance.new("TextButton")
SettingsTab.Text = "НАСТРОЙКИ"
SettingsTab.Size = UDim2.new(0.34, 0, 1, 0)
SettingsTab.Position = UDim2.new(0.66, 0, 0, 0)
SettingsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
SettingsTab.TextColor3 = Color3.fromRGB(200, 200, 200)
SettingsTab.Font = Enum.Font.SourceSansBold
SettingsTab.TextSize = 16
SettingsTab.Parent = TabsFrame

-- Контент сканера
local ScanContent = Instance.new("Frame")
ScanContent.Size = UDim2.new(1, 0, 1, -120)
ScanContent.Position = UDim2.new(0, 0, 0, 120)
ScanContent.BackgroundTransparency = 1
ScanContent.Visible = true
ScanContent.Parent = MainFrame

-- Контент выполнения
local ExecContent = Instance.new("Frame")
ExecContent.Size = UDim2.new(1, 0, 1, -120)
ExecContent.Position = UDim2.new(0, 0, 0, 120)
ExecContent.BackgroundTransparency = 1
ExecContent.Visible = false
ExecContent.Parent = MainFrame

-- Контент настроек
local SettingsContent = Instance.new("Frame")
SettingsContent.Size = UDim2.new(1, 0, 1, -120)
SettingsContent.Position = UDim2.new(0, 0, 0, 120)
SettingsContent.BackgroundTransparency = 1
SettingsContent.Visible = false
SettingsContent.Parent = MainFrame

-- Кнопка сканирования
local ScanButton = Instance.new("TextButton")
ScanButton.Text = "🔄 ЗАПУСТИТЬ ГЛУБОКОЕ СКАНИРОВАНИЕ"
ScanButton.Size = UDim2.new(0.9, 0, 0, 60)
ScanButton.Position = UDim2.new(0.05, 0, 0.05, 0)
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanButton.Font = Enum.Font.SourceSansBold
ScanButton.TextSize = 18
ScanButton.Parent = ScanContent

-- Поле результата
local ResultFrame = Instance.new("Frame")
ResultFrame.Size = UDim2.new(0.9, 0, 0, 120)
ResultFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
ResultFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
ResultFrame.BorderSizePixel = 0
ResultFrame.Parent = ScanContent

local ResultText = Instance.new("TextLabel")
ResultText.Size = UDim2.new(0.95, 0, 0.8, 0)
ResultText.Position = UDim2.new(0.025, 0, 0.1, 0)
ResultText.BackgroundTransparency = 1
ResultText.TextColor3 = Color3.fromRGB(255, 255, 255)
ResultText.Font = Enum.Font.SourceSans
ResultText.TextSize = 16
ResultText.TextWrapped = true
ResultText.Text = "Готов к сканированию. Нажмите кнопку для начала."
ResultText.Parent = ResultFrame

-- Прогресс сканирования
local ProgressLabel = Instance.new("TextLabel")
ProgressLabel.Size = UDim2.new(0.9, 0, 0, 25)
ProgressLabel.Position = UDim2.new(0.05, 0, 0.45, 0)
ProgressLabel.BackgroundTransparency = 1
ProgressLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
ProgressLabel.Font = Enum.Font.SourceSans
ProgressLabel.TextSize = 14
ProgressLabel.Text = "Прогресс: 0%"
ProgressLabel.TextXAlignment = Enum.TextXAlignment.Left
ProgressLabel.Parent = ScanContent

local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0.9, 0, 0, 25)
ProgressBar.Position = UDim2.new(0.05, 0, 0.5, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = ScanContent

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(0, 180, 255)
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressBar

-- Детали сканирования
local DetailsScroll = Instance.new("ScrollingFrame")
DetailsScroll.Size = UDim2.new(0.9, 0, 0, 150)
DetailsScroll.Position = UDim2.new(0.05, 0, 0.6, 0)
DetailsScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
DetailsScroll.BorderSizePixel = 0
DetailsScroll.ScrollBarThickness = 8
DetailsScroll.Parent = ScanContent

local DetailsText = Instance.new("TextLabel")
DetailsText.Size = UDim2.new(1, 0, 0, 0)
DetailsText.BackgroundTransparency = 1
DetailsText.TextColor3 = Color3.fromRGB(180, 180, 180)
DetailsText.Font = Enum.Font.SourceSans
DetailsText.TextSize = 14
DetailsText.TextWrapped = true
DetailsText.TextXAlignment = Enum.TextXAlignment.Left
DetailsText.TextYAlignment = Enum.TextYAlignment.Top
DetailsText.Text = "Детали сканирования будут отображаться здесь..."
DetailsText.AutomaticSize = Enum.AutomaticSize.Y
DetailsText.Parent = DetailsScroll

DetailsScroll.CanvasSize = UDim2.new(0, 0, 0, DetailsText.AbsoluteContentSize.Y)

-- Контент выполнения
local CodeInput = Instance.new("TextBox")
CodeInput.PlaceholderText = "Введите код для выполнения..."
CodeInput.Size = UDim2.new(0.9, 0, 0, 150)
CodeInput.Position = UDim2.new(0.05, 0, 0.05, 0)
CodeInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
CodeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CodeInput.Font = Enum.Font.Code
CodeInput.TextSize = 14
CodeInput.TextWrapped = true
CodeInput.TextXAlignment = Enum.TextXAlignment.Left
CodeInput.TextYAlignment = Enum.TextYAlignment.Top
CodeInput.Parent = ExecContent

local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Text = "🚀 ВЫПОЛНИТЬ КОД"
ExecuteButton.Size = UDim2.new(0.9, 0, 0, 50)
ExecuteButton.Position = UDim2.new(0.05, 0, 0.35, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.Font = Enum.Font.SourceSansBold
ExecuteButton.TextSize = 18
ExecuteButton.Parent = ExecContent

local UrlInput = Instance.new("TextBox")
UrlInput.PlaceholderText = "Введите URL require-скрипта..."
UrlInput.Size = UDim2.new(0.7, 0, 0, 40)
UrlInput.Position = UDim2.new(0.05, 0, 0.5, 0)
UrlInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
UrlInput.TextColor3 = Color3.fromRGB(255, 255, 255)
UrlInput.Font = Enum.Font.SourceSans
UrlInput.TextSize = 16
UrlInput.Parent = ExecContent

local RequireButton = Instance.new("TextButton")
RequireButton.Text = "📥 ВЫПОЛНИТЬ"
RequireButton.Size = UDim2.new(0.2, 0, 0, 40)
RequireButton.Position = UDim2.new(0.76, 0, 0.5, 0)
RequireButton.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
RequireButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RequireButton.Font = Enum.Font.SourceSansBold
RequireButton.TextSize = 16
RequireButton.Parent = ExecContent

local ExecOutput = Instance.new("ScrollingFrame")
ExecOutput.Size = UDim2.new(0.9, 0, 0, 150)
ExecOutput.Position = UDim2.new(0.05, 0, 0.65, 0)
ExecOutput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ExecOutput.BorderSizePixel = 0
ExecOutput.ScrollBarThickness = 8
ExecOutput.Parent = ExecContent

local ExecOutputText = Instance.new("TextLabel")
ExecOutputText.Size = UDim2.new(1, 0, 0, 0)
ExecOutputText.BackgroundTransparency = 1
ExecOutputText.TextColor3 = Color3.fromRGB(0, 255, 0)
ExecOutputText.Font = Enum.Font.Code
ExecOutputText.TextSize = 14
ExecOutputText.TextWrapped = true
ExecOutputText.TextXAlignment = Enum.TextXAlignment.Left
ExecOutputText.TextYAlignment = Enum.TextYAlignment.Top
ExecOutputText.Text = "Результаты выполнения будут здесь..."
ExecOutputText.AutomaticSize = Enum.AutomaticSize.Y
ExecOutputText.Parent = ExecOutput

ExecOutput.CanvasSize = UDim2.new(0, 0, 0, ExecOutputText.AbsoluteContentSize.Y)

-- Настройки
local AutoScanToggle = Instance.new("TextButton")
AutoScanToggle.Text = "АВТОМАТИЧЕСКОЕ СКАНИРОВАНИЕ: ВЫКЛ"
AutoScanToggle.Size = UDim2.new(0.9, 0, 0, 40)
AutoScanToggle.Position = UDim2.new(0.05, 0, 0.1, 0)
AutoScanToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
AutoScanToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoScanToggle.Font = Enum.Font.SourceSansBold
AutoScanToggle.TextSize = 16
AutoScanToggle.Parent = SettingsContent

local MemeToggle = Instance.new("TextButton")
MemeToggle.Text = "МЕМЫ В ЧАТЕ: ВКЛ"
MemeToggle.Size = UDim2.new(0.9, 0, 0, 40)
MemeToggle.Position = UDim2.new(0.05, 0, 0.2, 0)
MemeToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
MemeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
MemeToggle.Font = Enum.Font.SourceSansBold
MemeToggle.TextSize = 16
MemeToggle.Parent = SettingsContent

local ThemeToggle = Instance.new("TextButton")
ThemeToggle.Text = "ТЕМА: ТЕМНАЯ"
ThemeToggle.Size = UDim2.new(0.9, 0, 0, 40)
ThemeToggle.Position = UDim2.new(0.05, 0, 0.3, 0)
ThemeToggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
ThemeToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ThemeToggle.Font = Enum.Font.SourceSansBold
ThemeToggle.TextSize = 16
ThemeToggle.Parent = SettingsContent

-- Расширенный список известных бэкдоров и сигнатур
local backdoorSignatures = {
    Names = {
        "Backdoor", "BackdoorX", "SystemUpdate", "SecurityUpdate", 
        "RemoteAdmin", "AdminPanel", "ControlSystem", "UniversalBackdoor",
        "ExecuteScript", "RemoteExecute", "ServerControl", "AdminRemote",
        "Lalol", "LALOL", "Hub", "Scanner", "Require", "Executor",
        "InfiniteYield", "Cmd", "Command", "Cortex", "DarkHub"
    },
    Patterns = {
        "RemoteEvent", "HttpService", "GetAsync", "Loadstring",
        "FireServer", "InvokeServer", "OnServerEvent", "Backdoor",
        "require", "HttpService", "Webhook", "Discord", "Execute",
        "hookfunction", "hookmetamethod", "setreadonly", "setrawmetatable"
    }
}

-- Настройки
local settings = {
    autoScan = false,
    chatMemes = true,
    darkTheme = true
}

-- Функция для обновления мемов
local function updateMeme()
    currentMeme = memes[math.random(1, #memes)]
    Title.Text = "ULTIMATE BACKDOOR SCANNER - " .. currentMeme
    return currentMeme
end

-- Безопасная функция отправки сообщения в чат
local function sendChatMessage(message)
    if not settings.chatMemes then return end
    
    pcall(function()
        -- Старый чат (работает в большинстве игр)
        if game:GetService("Chat") and Player.Character and Player.Character:FindFirstChild("Head") then
            game:GetService("Chat"):Chat(Player.Character.Head, "[SCANNER] " .. message)
        end
    end)
end

-- Функция для вывода в консоль
local function printToConsole(message, color)
    color = color or Color3.fromRGB(0, 255, 0)
    ExecOutputText.TextColor3 = color
    ExecOutputText.Text = ExecOutputText.Text .. "\n" .. message
    ExecOutput.CanvasSize = UDim2.new(0, 0, 0, ExecOutputText.AbsoluteContentSize.Y)
    print("[BackdoorScanner] " .. message)
end

-- Функция глубокого сканирования с улучшенным обнаружением
local function deepScanForBackdoors()
    ResultText.Text = "🔍 НАЧИНАЕМ ГЛУБОКОЕ СКАНИРОВАНИЕ..."
    ResultText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    DetailsText.Text = "Начинаем сканирование..."
    ScanButton.Text = "⏳ СКАНИРУЕМ..."
    ScanButton.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
    
    local foundBackdoors = {}
    local totalChecks = 0
    local currentCheck = 0
    
    -- Подсчет общего количества проверок
    local servicesToCheck = {
        ReplicatedStorage, ServerScriptService, ServerStorage, 
        workspace, game:GetService("Lighting"), game:GetService("StarterPack"),
        game:GetService("StarterGui"), game:GetService("StarterPlayer")
    }
    
    for _, service in pairs(servicesToCheck) do
        pcall(function()
            totalChecks = totalChecks + #service:GetDescendants()
        end)
    end
    totalChecks = math.min(totalChecks, 2000) -- Ограничение для производительности
    
    -- Функция обновления прогресса
    local function updateProgress()
        currentCheck = currentCheck + 1
        local progress = currentCheck / totalChecks
        ProgressFill.Size = UDim2.new(progress, 0, 1, 0)
        ProgressLabel.Text = "Прогресс: " .. math.floor(progress * 100) .. "%"
        
        -- Случайный мем каждые 10% прогресса
        if math.floor(progress * 100) % 10 == 0 then
            local newMeme = updateMeme()
            DetailsText.Text = DetailsText.Text .. "\n" .. newMeme .. " 🎉"
            DetailsScroll.CanvasSize = UDim2.new(0, 0, 0, DetailsText.AbsoluteContentSize.Y)
        end
    end
    
    -- Функция проверки объекта с улучшенным обнаружением
    local function checkObject(obj)
        -- Проверка по имени
        for _, name in ipairs(backdoorSignatures.Names) do
            if string.find(string.lower(obj.Name), string.lower(name)) then
                table.insert(foundBackdoors, "🔴 ОБНАРУЖЕНО ПО ИМЕНИ: " .. obj:GetFullName())
                print("Найден потенциальный бэкдор: " .. obj:GetFullName())
            end
        end
        
        -- Проверка скриптов на подозрительный код
        if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            local success, source = pcall(function()
                return obj.Source
            end)
            
            if success and source then
                for _, pattern in ipairs(backdoorSignatures.Patterns) do
                    if string.find(string.lower(source), string.lower(pattern)) then
                        table.insert(foundBackdoors, "🟡 ПОДОЗРИТЕЛЬНЫЙ КОД: " .. obj:GetFullName() .. " (" .. pattern .. ")")
                        print("Подозрительный код в " .. obj:GetFullName() .. ": " .. pattern)
                    end
                end
                
                -- Проверка на наличие require-скриптов
                if string.find(string.lower(source), "require") and string.find(string.lower(source), "http") then
                    table.insert(foundBackdoors, "🔵 REQUIRE-СКРИПТ: " .. obj:GetFullName())
                    print("Найден require-скрипт: " .. obj:GetFullName())
                end
            end
        end
        
        -- Проверка RemoteEvents/RemoteFunctions
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            table.insert(foundBackdoors, "🔵 ОБНАРУЖЕН REMOTE: " .. obj:GetFullName())
            print("Найден Remote объект: " .. obj:GetFullName())
        end
    end
    
    -- Основной цикл сканирования
    for _, service in pairs(servicesToCheck) do
        pcall(function()
            local descendants = service:GetDescendants()
            for _, obj in ipairs(descendants) do
                if currentCheck < totalChecks then
                    pcall(checkObject, obj)
                    updateProgress()
                    RunService.Heartbeat:Wait() -- Для избежания лагов
                end
            end
        end)
    end
    
    -- Отображение результатов
    if #foundBackdoors > 0 then
        ResultText.Text = "🚨 ОБНАРУЖЕНО " .. #foundBackdoors .. " ПОТЕНЦИАЛЬНЫХ БЭКДОРОВ!"
        ResultText.TextColor3 = Color3.fromRGB(255, 50, 50)
        
        local details = "РЕЗУЛЬТАТЫ СКАНИРОВАНИЯ:\n"
        for i, result in ipairs(foundBackdoors) do
            if i <= 20 then -- Ограничиваем вывод
                details = details .. result .. "\n"
            end
        end
        
        if #foundBackdoors > 20 then
            details = details .. "... и еще " .. (#foundBackdoors - 20) .. " объектов\n"
        end
        
        -- Добавляем случайный мем в результаты
        details = details .. "\n" .. updateMeme() .. " 🤣"
        
        DetailsText.Text = details
        DetailsScroll.CanvasSize = UDim2.new(0, 0, 0, DetailsText.AbsoluteContentSize.Y)
        
        -- Отправляем мем в чат для всех видимости
        sendChatMessage("Обнаружены бэкдоры! " .. currentMeme)
    else
        ResultText.Text = "✅ БЭКДОРЫ НЕ ОБНАРУЖЕНЫ"
        ResultText.TextColor3 = Color3.fromRGB(50, 255, 50)
        DetailsText.Text = "Сканирование завершено. Подозрительные объекты не найдены.\n" .. updateMeme() .. " 🎉"
        DetailsScroll.CanvasSize = UDim2.new(0, 0, 0, DetailsText.AbsoluteContentSize.Y)
    end
    
    ProgressFill.Size = UDim2.new(1, 0, 1, 0)
    ProgressLabel.Text = "Прогресс: 100%"
    ScanButton.Text = "🔄 СКАНИРОВАТЬ СНОВА"
    ScanButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
end

-- Функция для выполнения require-скриптов
local function requireScript(url)
    if url == "" or url == nil then
        printToConsole("[ОШИБКА] Введите URL скрипта", Color3.fromRGB(255, 50, 50))
        return
    end
    
    printToConsole("Загрузка скрипта из: " .. url)
    
    local success, scriptContent = pcall(function()
        return HttpService:GetAsync(url, true)
    end)
    
    if success then
        printToConsole("Скрипт загружен, выполнение...")
        
        local executeSuccess, result = pcall(function()
            return loadstring(scriptContent)()
        end)
        
        if executeSuccess then
            local newMeme = updateMeme()
            printToConsole("[УСПЕХ] Скрипт выполнен! " .. newMeme)
            if result then
                printToConsole("Результат: " .. tostring(result))
            end
        else
            printToConsole("[ОШИБКА] " .. tostring(result) .. " 😢", Color3.fromRGB(255, 50, 50))
        end
    else
        printToConsole("[ОШИБКА] Не удалось загрузить скрипт: " .. tostring(scriptContent), Color3.fromRGB(255, 50, 50))
    end
end

-- Функция для выполнения кода
local function executeCode(code)
    if code == "" or code == nil then
        printToConsole("[ОШИБКА] Введите код для выполнения", Color3.fromRGB(255, 50, 50))
        return
    end
    
    printToConsole("Выполнение кода...")
    
    local success, result = pcall(function()
        return loadstring(code)()
    end)
    
    if success then
        local newMeme = updateMeme()
        printToConsole("[УСПЕХ] Код выполнен! " .. newMeme)
        if result then
            printToConsole("Результат: " .. tostring(result))
        end
    else
        printToConsole("[ОШИБКА] " .. tostring(result) .. " 💀", Color3.fromRGB(255, 50, 50))
    end
end

-- Обработчики событий
ScannerTab.MouseButton1Click:Connect(function()
    ScanContent.Visible = true
    ExecContent.Visible = false
    SettingsContent.Visible = false
    ScannerTab.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    ExecutorTab.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    SettingsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
end)

ExecutorTab.MouseButton1Click:Connect(function()
    ScanContent.Visible = false
    ExecContent.Visible = true
    SettingsContent.Visible = false
    ScannerTab.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    ExecutorTab.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
    SettingsTab.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
end)

SettingsTab.MouseButton1Click:Connect(function()
    ScanContent.Visible = false
    ExecContent.Visible = false
    SettingsContent.Visible = true
    ScannerTab.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    ExecutorTab.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    SettingsTab.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
end)

ScanButton.MouseButton1Click:Connect(function()
    pcall(deepScanForBackdoors)
end)

ExecuteButton.MouseButton1Click:Connect(function()
    pcall(function()
        executeCode(CodeInput.Text)
    end)
end)

RequireButton.MouseButton1Click:Connect(function()
    pcall(function()
        requireScript(UrlInput.Text)
    end)
end)

AutoScanToggle.MouseButton1Click:Connect(function()
    settings.autoScan = not settings.autoScan
    AutoScanToggle.Text = "АВТОМАТИЧЕСКОЕ СКАНИРОВАНИЕ: " .. (settings.autoScan and "ВКЛ" or "ВЫКЛ")
    AutoScanToggle.BackgroundColor3 = settings.autoScan and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 65)
end)

MemeToggle.MouseButton1Click:Connect(function()
    settings.chatMemes = not settings.chatMemes
    MemeToggle.Text = "МЕМЫ В ЧАТЕ: " .. (settings.chatMemes and "ВКЛ" or "ВЫКЛ")
    MemeToggle.BackgroundColor3 = settings.chatMemes and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(60, 60, 65)
end)

ThemeToggle.MouseButton1Click:Connect(function()
    settings.darkTheme = not settings.darkTheme
    ThemeToggle.Text = "ТЕМА: " .. (settings.darkTheme and "ТЕМНАЯ" or "СВЕТЛАЯ")
    
    if settings.darkTheme then
        MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
        ResultFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
        ProgressBar.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        DetailsScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        CodeInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        ExecOutput.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    else
        MainFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
        ResultFrame.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        ProgressBar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        DetailsScroll.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
        CodeInput.BackgroundColor3 = Color3.fromRGB(220, 220, 220)
        ExecOutput.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
    end
end)

-- Автоматическое обновление мемов каждые 15 секунд
spawn(function()
    while true do
        wait(15)
        local newMeme = updateMeme()
        DetailsText.Text = DetailsText.Text .. "\n" .. newMeme .. " 🎉"
        DetailsScroll.CanvasSize = UDim2.new(0, 0, 0, DetailsText.AbsoluteContentSize.Y)
    end
end)

-- Автоматическое сканирование при запуске, если включено
spawn(function()
    wait(2)
    if settings.autoScan then
        pcall(deepScanForBackdoors)
    end
end)

-- Инициализация
DetailsText.Text = "Ultimate Backdoor Scanner инициализирован!\nГотов к сканированию и выполнению require-скриптов.\n" .. currentMeme .. " 🚀"
DetailsScroll.CanvasSize = UDim2.new(0, 0, 0, DetailsText.AbsoluteContentSize.Y)

printToConsole("Ultimate Backdoor Scanner загружен!")
printToConsole("Используйте вкладки для навигации: СКАНЕР, ВЫПОЛНЕНИЕ, НАСТРОЙКИ")
