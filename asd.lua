-- Полный оптимизированный чит LOOOL для Roblox
getgenv().Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/jensonhirst/Rayfield/refs/heads/main/source'))()

local Window = Rayfield:CreateWindow({
   Name = "LOOOOL 🚀",
   LoadingTitle = "Загрузка...",
   LoadingSubtitle = "ALL LOAD!",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "LOOOOL",
      FileName = "Config"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvite",
      RememberJoins = true
   },
   KeySystem = false
})

-- Глобальные переменные
getgenv().Noclip = false
getgenv().Fly = false
getgenv().Spinbot = false
getgenv().ESP = false
getgenv().Invisible = false

-- ОПТИМИЗАЦИЯ: Отключаем тени и детализацию
local Lighting = game:GetService("Lighting")
Lighting.GlobalShadows = false
Lighting.ShadowSoftness = 0
Lighting.Brightness = 2

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

-- Функция для безопасного выполнения
local function SafeCall(func)
    pcall(func)
end

-- Главные функции
local MainTab = Window:CreateTab("Главные функции", 4483362458)

-- REAL FE НЕВИДИМОСТЬ
MainTab:CreateToggle({
   Name = "🔥 REAL FE Невидимость",
   CurrentValue = false,
   Callback = function(Value)
        getgenv().Invisible = Value
        SafeCall(function()
            if Value then
                local char = LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 1
                            part.CanCollide = false
                            part.Material = Enum.Material.Glass
                        end
                    end
                    -- Скрываем имя и эффекты
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
                    end
                end
            else
                local char = LocalPlayer.Character
                if char then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Transparency = 0
                            part.CanCollide = true
                            part.Material = Enum.Material.Plastic
                        end
                    end
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        hum.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
                    end
                end
            end
        end)
   end,
})

-- SPINBOT (Жесткий)
MainTab:CreateToggle({
   Name = "🔄 SPINBOT (Жесткий)",
   CurrentValue = false,
   Callback = function(Value)
        getgenv().Spinbot = Value
        SafeCall(function()
            if Value then
                local char = LocalPlayer.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        spawn(function()
                            while getgenv().Spinbot and root do
                                RunService.RenderStepped:Wait()
                                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(30), 0)
                            end
                        end)
                    end
                end
            end
        end)
   end,
})

-- Легание (Noclip)
MainTab:CreateToggle({
   Name = "👻 Легание (Noclip)",
   CurrentValue = false,
   Callback = function(Value)
        getgenv().Noclip = Value
        SafeCall(function()
            RunService.Stepped:Connect(function()
                if getgenv().Noclip and LocalPlayer.Character then
                    for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end)
   end,
})

-- Полёт (Fly)
MainTab:CreateToggle({
   Name = "🚀 Полёт (Fly)",
   CurrentValue = false,
   Callback = function(Value)
        getgenv().Fly = Value
        SafeCall(function()
            if Value then
                local char = LocalPlayer.Character
                if char then
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if root then
                        local bodyVelocity = Instance.new("BodyVelocity")
                        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                        bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                        bodyVelocity.Parent = root
                        
                        spawn(function()
                            local UIS = game:GetService("UserInputService")
                            while getgenv().Fly and root do
                                RunService.RenderStepped:Wait()
                                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                                
                                if UIS:IsKeyDown(Enum.KeyCode.W) then
                                    bodyVelocity.Velocity = bodyVelocity.Velocity + (workspace.CurrentCamera.CFrame.LookVector * 100)
                                end
                                if UIS:IsKeyDown(Enum.KeyCode.S) then
                                    bodyVelocity.Velocity = bodyVelocity.Velocity - (workspace.CurrentCamera.CFrame.LookVector * 100)
                                end
                                if UIS:IsKeyDown(Enum.KeyCode.A) then
                                    bodyVelocity.Velocity = bodyVelocity.Velocity - (workspace.CurrentCamera.CFrame.RightVector * 100)
                                end
                                if UIS:IsKeyDown(Enum.KeyCode.D) then
                                    bodyVelocity.Velocity = bodyVelocity.Velocity + (workspace.CurrentCamera.CFrame.RightVector * 100)
                                end
                                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                                    bodyVelocity.Velocity = bodyVelocity.Velocity + Vector3.new(0, 100, 0)
                                end
                                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                                    bodyVelocity.Velocity = bodyVelocity.Velocity - Vector3.new(0, 100, 0)
                                end
                            end
                            bodyVelocity:Destroy()
                        end)
                    end
                end
            end
        end)
   end,
})

-- Телепортация к игрокам
local playerNames = {}
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        table.insert(playerNames, player.Name)
    end
end

local PlayerDropdown = MainTab:CreateDropdown({
   Name = "🎯 Телепорт к игроку",
   Options = playerNames,
   CurrentOption = playerNames[1] or "Нет игроков",
   Callback = function(Option)
        SafeCall(function()
            local target = Players[Option]
            if target and target.Character then
                local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
                local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot and localRoot then
                    localRoot.CFrame = targetRoot.CFrame
                end
            end
        end)
   end,
})

-- Массовая телепортация
MainTab:CreateButton({
   Name = "⚡ Телепортировать ВСЕХ ко мне",
   Callback = function()
        SafeCall(function()
            local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myRoot then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                        if targetRoot then
                            targetRoot.CFrame = myRoot.CFrame + Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
                        end
                    end
                end
            end
        end)
   end,
})

-- Телепорт по координатам (квадрат)
MainTab:CreateSection("📍 Телепорт по координатам")
local XInput = MainTab:CreateInput({
   Name = "Центр X",
   PlaceholderText = "0",
   Callback = function(Text) end,
})

local YInput = MainTab:CreateInput({
   Name = "Центр Y", 
   PlaceholderText = "0",
   Callback = function(Text) end,
})

local ZInput = MainTab:CreateInput({
   Name = "Центр Z",
   PlaceholderText = "0",
   Callback = function(Text) end,
})

local SizeInput = MainTab:CreateInput({
   Name = "Размер квадрата",
   PlaceholderText = "50",
   Callback = function(Text) end,
})

MainTab:CreateButton({
   Name = "🔄 Телепорт в квадрат",
   Callback = function()
        SafeCall(function()
            local centerX = tonumber(XInput:GetValue()) or 0
            local centerY = tonumber(YInput:GetValue()) or 0
            local centerZ = tonumber(ZInput:GetValue()) or 0
            local size = tonumber(SizeInput:GetValue()) or 50
            
            local randomX = centerX + math.random(-size/2, size/2)
            local randomZ = centerZ + math.random(-size/2, size/2)
            
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = CFrame.new(Vector3.new(randomX, centerY, randomZ))
            end
        end)
   end,
})

-- Визуальные функции
local VisualTab = Window:CreateTab("Визуал", 4483362458)

-- ESP с Highlight
VisualTab:CreateToggle({
   Name = "🎯 ESP игроков",
   CurrentValue = false,
   Callback = function(Value)
        getgenv().ESP = Value
        SafeCall(function()
            if Value then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        spawn(function()
                            while getgenv().ESP and player and player.Character do
                                RunService.RenderStepped:Wait()
                                local char = player.Character
                                if char then
                                    local highlight = char:FindFirstChildOfClass("Highlight")
                                    if not highlight then
                                        highlight = Instance.new("Highlight")
                                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                                        highlight.Parent = char
                                    end
                                    highlight.Adornee = char
                                end
                            end
                            -- Удаляем Highlight при отключении
                            if player.Character then
                                local highlight = player.Character:FindFirstChildOfClass("Highlight")
                                if highlight then
                                    highlight:Destroy()
                                end
                            end
                        end)
                    end
                end
            else
                -- Удаляем все Highlight
                for _, player in ipairs(Players:GetPlayers()) do
                    if player.Character then
                        local highlight = player.Character:FindFirstChildOfClass("Highlight")
                        if highlight then
                            highlight:Destroy()
                        end
                    end
                end
            end
        end)
   end,
})

-- Скорость движения
VisualTab:CreateSlider({
   Name = "💨 Скорость движения",
   Range = {16, 500},
   Increment = 1,
   Suffix = "speed",
   CurrentValue = 16,
   Callback = function(Value)
        SafeCall(function()
            LocalPlayer.Character.Humanoid.WalkSpeed = Value
        end)
   end,
})

-- Сила прыжка
VisualTab:CreateSlider({
   Name = "🦘 Сила прыжка",
   Range = {50, 500},
   Increment = 1,
   Suffix = "jump", 
   CurrentValue = 50,
   Callback = function(Value)
        SafeCall(function()
            LocalPlayer.Character.Humanoid.JumpPower = Value
        end)
   end,
})

-- Бессмертие
VisualTab:CreateToggle({
   Name = "💀 Бессмертие",
   CurrentValue = false,
   Callback = function(Value)
        SafeCall(function()
            if Value then
                LocalPlayer.Character.Humanoid.MaxHealth = math.huge
                LocalPlayer.Character.Humanoid.Health = math.huge
            else
                LocalPlayer.Character.Humanoid.MaxHealth = 100
                LocalPlayer.Character.Humanoid.Health = 100
            end
        end)
   end,
})

-- Бесконечный прыжок
VisualTab:CreateToggle({
   Name = "∞ Бесконечный прыжок",
   CurrentValue = false,
   Callback = function(Value)
        getgenv().InfJump = Value
        SafeCall(function()
            local UIS = game:GetService("UserInputService")
            UIS.JumpRequest:Connect(function()
                if getgenv().InfJump then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
                end
            end)
        end)
   end,
})

-- Анимции
VisualTab:CreateDropdown({
   Name = "💃 Анимации",
   Options = {"Попрыгунчик", "Танец1", "Танец2", "Стойка", "Зомби"},
   CurrentOption = "Выбери анимацию",
   Callback = function(Option)
        SafeCall(function()
            local animationIds = {
                ["Попрыгунчик"] = "rbxassetid://35154961",
                ["Танец1"] = "rbxassetid://182435998", 
                ["Танец2"] = "rbxassetid://204295235",
                ["Стойка"] = "rbxassetid://313762630",
                ["Зомби"] = "rbxassetid://2510239857"
            }
            
            if animationIds[Option] then
                local anim = Instance.new("Animation")
                anim.AnimationId = animationIds[Option]
                
                local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if hum then
                    local track = hum:LoadAnimation(anim)
                    track:Play()
                end
            end
        end)
   end,
})

-- Команды в чат
local CommandsTab = Window:CreateTab("Команды", 4483362458)

CommandsTab:CreateInput({
   Name = "Команда в чат",
   PlaceholderText = "Напиши команду...",
   Callback = function(Text)
        SafeCall(function()
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(Text, "All")
        end)
   end,
})

-- Килл всех
CommandsTab:CreateButton({
   Name = "☠️ Убить всех",
   Callback = function()
        SafeCall(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    player.Character:BreakJoints()
                end
            end
        end)
   end,
})

-- Респавн всех
CommandsTab:CreateButton({
   Name = "🔄 Респавн всех",
   Callback = function()
        SafeCall(function()
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character then
                    player.Character:BreakJoints()
                end
            end
        end)
   end,
})

-- Уведомление о загрузке
Rayfield:Notify({
   Title = "LOOOOL Загружен!",
   Content = "ALL LOAD! Все функции активированы\n🔥 Оптимизация включена\n🔄 Spinbot готов\n👻 Невидимость работает",
   Duration = 6.5,
   Image = 4483362458,
})

-- Авто-обновление списка игроков
spawn(function()
    while true do
        wait(5)
        local newPlayers = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                table.insert(newPlayers, player.Name)
            end
        end
        if #newPlayers > 0 then
            PlayerDropdown:Refresh(newPlayers, true)
        end
    end
end)

-- Защита от кика
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)
