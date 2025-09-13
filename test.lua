local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BackdoorScanner"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главный фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Заголовок
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundColor3 = Color3.fromRGB(255, 102, 0)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "BACKDOOR SCANNER"
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.Parent = Header

-- Контент сканера
local ScanContent = Instance.new("Frame")
ScanContent.Size = UDim2.new(1, 0, 1, -60)
ScanContent.Position = UDim2.new(0, 0, 0, 60)
ScanContent.BackgroundTransparency = 1
ScanContent.Parent = MainFrame

-- Кнопка сканирования
local ScanButton = Instance.new("TextButton")
ScanButton.Text = "СКАНИРОВАТЬ BACKDOOR"
ScanButton.Size = UDim2.new(0.9, 0, 0, 50)
ScanButton.Position = UDim2.new(0.05, 0, 0.1, 0)
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanButton.Font = Enum.Font.SourceSansBold
ScanButton.TextSize = 18
ScanButton.Parent = ScanContent

-- Поле результата
local ResultFrame = Instance.new("Frame")
ResultFrame.Size = UDim2.new(0.9, 0, 0, 100)
ResultFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
ResultFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
ResultFrame.BorderSizePixel = 0
ResultFrame.Parent = ScanContent

local ResultText = Instance.new("TextLabel")
ResultText.Size = UDim2.new(1, 0, 1, 0)
ResultText.BackgroundTransparency = 1
ResultText.TextColor3 = Color3.fromRGB(255, 255, 255)
ResultText.Font = Enum.Font.SourceSansBold
ResultText.TextSize = 18
ResultText.Text = "Нажмите 'Сканировать' для проверки"
ResultText.Parent = ResultFrame

-- Прогресс сканирования
local ProgressBar = Instance.new("Frame")
ProgressBar.Size = UDim2.new(0.9, 0, 0, 20)
ProgressBar.Position = UDim2.new(0.05, 0, 0.6, 0)
ProgressBar.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
ProgressBar.BorderSizePixel = 0
ProgressBar.Parent = ScanContent

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
ProgressFill.BorderSizePixel = 0
ProgressFill.Parent = ProgressBar

-- Список известных бэкдоров для проверки
local knownBackdoors = {
    "BackdoorX_System",
    "BackdoorX_Universal",
    "SystemUpdate",
    "SecurityUpdate",
    "RemoteAdmin",
    "AdminPanel",
    "ControlSystem"
}

-- Функция сканирования
local function scanForBackdoors()
    ResultText.Text = "Сканирование..."
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    
    local found = false
    local totalChecks = #knownBackdoors + 3 -- +3 для проверки других мест
    
    -- Проверка ReplicatedStorage
    for i, backdoorName in ipairs(knownBackdoors) do
        wait(0.1)
        ProgressFill.Size = UDim2.new(i/totalChecks, 0, 1, 0)
        
        if ReplicatedStorage:FindFirstChild(backdoorName) then
            found = true
            ResultText.Text = "ОБНАРУЖЕН BACKDOOR: " .. backdoorName
            ResultText.TextColor3 = Color3.fromRGB(255, 0, 0)
            return
        end
    end
    
    -- Проверка ServerScriptService
    for i, backdoorName in ipairs(knownBackdoors) do
        wait(0.1)
        ProgressFill.Size = UDim2.new((#knownBackdoors + i)/totalChecks, 0, 1, 0)
        
        if game:GetService("ServerScriptService"):FindFirstChild(backdoorName) then
            found = true
            ResultText.Text = "ОБНАРУЖЕН BACKDOOR: " .. backdoorName
            ResultText.TextColor3 = Color3.fromRGB(255, 0, 0)
            return
        end
    end
    
    -- Проверка ServerStorage
    for i, backdoorName in ipairs(knownBackdoors) do
        wait(0.1)
        ProgressFill.Size = UDim2.new((2*#knownBackdoors + i)/totalChecks, 0, 1, 0)
        
        if game:GetService("ServerStorage"):FindFirstChild(backdoorName) then
            found = true
            ResultText.Text = "ОБНАРУЖЕН BACKDOOR: " .. backdoorName
            ResultText.TextColor3 = Color3.fromRGB(255, 0, 0)
            return
        end
    end
    
    -- Если ничего не найдено
    ProgressFill.Size = UDim2.new(1, 0, 1, 0)
    ResultText.Text = "BACKDOOR НЕ НАЙДЕНО"
    ResultText.TextColor3 = Color3.fromRGB(0, 255, 0)
end

-- Обработчик кнопки
ScanButton.MouseButton1Click:Connect(scanForBackdoors)

-- Анимация появления
MainFrame.Visible = true
for i = 0, 1, 0.1 do
    MainFrame.BackgroundTransparency = 1 - i
    wait(0.02)
end
