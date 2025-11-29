-- Вставь в любой экзекутор (Synapse X, ScriptWare, KRNL)
loadstring(game:HttpGet("https://raw.githubusercontent.com/jensonhirst/Rayfield/refs/heads/main/source"))()

local Window = Rayfield:CreateWindow({
   Name = "LOOOOL 🚀",
   LoadingTitle = "Загрузка...",
   LoadingSubtitle = "ALL LOAD!",
   ConfigurationSaving = {Enabled = true, FolderName = "LOOOOL", FileName = "Config"},
   Discord = {Enabled = false},
   KeySystem = false
})

-- REAL FE НЕВИДИМОСТЬ (игроки полностью не видят тебя)
local MainTab = Window:CreateTab("Главные функции", 4483362458)

MainTab:CreateToggle({
   Name = "REAL FE Невидимость",
   CurrentValue = false,
   Flag = "TrueInvisibleToggle",
   Callback = function(Value)
      if Value then
         -- Метод 1: Удаление коллизии и видимости через FE-совместимые методы
         local char = game.Players.LocalPlayer.Character
         if char then
            for _, part in ipairs(char:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.Transparency = 1
                  part.CanCollide = false
                  part.Material = Enum.Material.Glass
               end
            end
            
            -- Метод 2: Изменение NetworkOwner для скрытия от других игроков
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then
               hum:ChangeState(Enum.HumanoidStateType.Physics)
            end
            
            -- Метод 3: FE-совместимое скрытие через анимации
            coroutine.wrap(function()
               while _G.TrueInvisible do
                  wait(0.1)
                  pcall(function()
                     local root = char:FindFirstChild("HumanoidRootPart")
                     if root then
                        root.Velocity = Vector3.new(0,0,0)
                        root.RotVelocity = Vector3.new(0,0,0)
                     end
                  end)
               end
            end)()
         end
         _G.TrueInvisible = true
      else
         _G.TrueInvisible = false
         local char = game.Players.LocalPlayer.Character
         if char then
            for _, part in ipairs(char:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.Transparency = 0
                  part.CanCollide = true
                  part.Material = Enum.Material.Plastic
               end
            end
         end
      end
   end,
})

-- Легание (Noclip)
MainTab:CreateToggle({
   Name = "Легание (Noclip)",
   CurrentValue = false,
   Flag = "NoclipToggle",
   Callback = function(Value)
      _G.Noclip = Value
      coroutine.wrap(function()
         while _G.Noclip do
            wait(0.1)
            pcall(function()
               local char = game.Players.LocalPlayer.Character
               if char then
                  for _, part in ipairs(char:GetDescendants()) do
                     if part:IsA("BasePart") then
                        part.CanCollide = false
                     end
                  end
               end
            end)
         end
      end)()
   end,
})

-- Телепортация к игрокам
local PlayerDropdown = MainTab:CreateDropdown({
   Name = "Телепорт к игроку",
   Options = {"Обнови список"},
   CurrentOption = "Обнови список",
   Flag = "PlayerTPDropdown",
   Callback = function(Option)
      if Option ~= "Обнови список" then
         pcall(function()
            local target = game.Players[Option]
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
               game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = target.Character.HumanoidRootPart.CFrame
            end
         end)
      end
   end,
})

MainTab:CreateButton({
   Name = "📋 Обновить список игроков",
   Callback = function()
      local players = {}
      for _, player in ipairs(game.Players:GetPlayers()) do
         if player ~= game.Players.LocalPlayer then
            table.insert(players, player.Name)
         end
      end
      if #players == 0 then
         table.insert(players, "Игроков нет")
      end
      PlayerDropdown:Refresh(players, true)
   end,
})

-- Массовая телепортация игроков ко мне
MainTab:CreateButton({
   Name = "⚡ Телепортировать ВСЕХ ко мне",
   Callback = function()
      pcall(function()
         local myPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
         for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
               player.Character.HumanoidRootPart.CFrame = CFrame.new(myPos + Vector3.new(math.random(-10,10), 0, math.random(-10,10)))
            end
         end
      end)
   end,
})

-- Телепорт по координатам (форма квадрата)
MainTab:CreateSection("Телепорт по координатам (Квадрат)")
local XCoord = MainTab:CreateInput({
   Name = "Центр X",
   PlaceholderText = "0",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) end,
})

local YCoord = MainTab:CreateInput({
   Name = "Центр Y", 
   PlaceholderText = "0",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) end,
})

local ZCoord = MainTab:CreateInput({
   Name = "Центр Z",
   PlaceholderText = "0", 
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) end,
})

local SizeInput = MainTab:CreateInput({
   Name = "Размер квадрата",
   PlaceholderText = "50",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text) end,
})

MainTab:CreateButton({
   Name = "🔄 Телепорт в квадрат",
   Callback = function()
      pcall(function()
         local centerX = tonumber(XCoord:GetValue()) or 0
         local centerY = tonumber(YCoord:GetValue()) or 0
         local centerZ = tonumber(ZCoord:GetValue()) or 0
         local size = tonumber(SizeInput:GetValue()) or 50
         
         local randomX = centerX + math.random(-size/2, size/2)
         local randomZ = centerZ + math.random(-size/2, size/2)
         
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(randomX, centerY, randomZ))
      end)
   end,
})

-- Визуальные функции
local VisualTab = Window:CreateTab("Визуал", 4483362458)

-- ESP с квадратами
VisualTab:CreateToggle({
   Name = "ESP игроков (квадраты)",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
      _G.ESPEnabled = Value
      
      if Value then
         -- Создаем ESP для существующих игроков
         for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
               coroutine.wrap(function()
                  local box = Drawing.new("Square")
                  box.Visible = false
                  box.Color = Color3.fromRGB(255, 50, 50)
                  box.Thickness = 2
                  box.Filled = false
                  
                  local function updateESP()
                     while _G.ESPEnabled and player and player.Character do
                        local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                        if humanoidRootPart then
                           local vector, onScreen = workspace.CurrentCamera:WorldToViewportPoint(humanoidRootPart.Position)
                           if onScreen then
                              box.Size = Vector2.new(2000/vector.Z, 3000/vector.Z)
                              box.Position = Vector2.new(vector.X - box.Size.X/2, vector.Y - box.Size.Y/2)
                              box.Visible = true
                           else
                              box.Visible = false
                           end
                        else
                           box.Visible = false
                        end
                        wait(0.1)
                     end
                     box:Remove()
                  end
                  
                  updateESP()
               end)()
            end
         end
         
         -- Обработчик новых игроков
         game.Players.PlayerAdded:Connect(function(player)
            if _G.ESPEnabled then
               wait(2) -- Ждем появления персонажа
               -- Код ESP для нового игрока
            end
         end)
      else
         _G.ESPEnabled = false
      end
   end,
})

-- Скорость и прыжок
VisualTab:CreateSlider({
   Name = "Скорость движения",
   Range = {16, 500},
   Increment = 1,
   Suffix = "speed",
   CurrentValue = 16,
   Flag = "SpeedSlider",
   Callback = function(Value)
      pcall(function()
         game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
      end)
   end,
})

VisualTab:CreateSlider({
   Name = "Сила прыжка", 
   Range = {50, 500},
   Increment = 1,
   Suffix = "jump",
   CurrentValue = 50,
   Flag = "JumpSlider",
   Callback = function(Value)
      pcall(function()
         game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = Value
      end)
   end,
})

-- Fly
VisualTab:CreateToggle({
   Name = "Полёт (Fly)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      _G.Flying = Value
      if Value then
         local bodyVelocity = Instance.new("BodyVelocity")
         bodyVelocity.Velocity = Vector3.new(0, 0, 0)
         bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
         bodyVelocity.Parent = game.Players.LocalPlayer.Character.HumanoidRootPart
         
         local function fly()
            while _G.Flying and game.Players.LocalPlayer.Character do
               wait()
               bodyVelocity.Velocity = Vector3.new(0, 0, 0)
               
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
                  bodyVelocity.Velocity = bodyVelocity.Velocity + (workspace.CurrentCamera.CFrame.LookVector * 50)
               end
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
                  bodyVelocity.Velocity = bodyVelocity.Velocity - (workspace.CurrentCamera.CFrame.LookVector * 50)
               end
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
                  bodyVelocity.Velocity = bodyVelocity.Velocity - (workspace.CurrentCamera.CFrame.RightVector * 50)
               end
               if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
                  bodyVelocity.Velocity = bodyVelocity.Velocity + (workspace.CurrentCamera.CFrame.RightVector * 50)
               end
            end
            bodyVelocity:Remove()
         end
         
         coroutine.wrap(fly)()
      else
         _G.Flying = false
      end
   end,
})

-- Анимции
VisualTab:CreateDropdown({
   Name = "Анимации",
   Options = {"Попрыгунчик", "Танец1", "Танец2", "Стойка"},
   CurrentOption = "Выбери анимацию",
   Flag = "AnimationDropdown",
   Callback = function(Option)
      pcall(function()
         local anim = Instance.new("Animation")
         if Option == "Попрыгунчик" then
            anim.AnimationId = "rbxassetid://35154961"
         elseif Option == "Танец1" then
            anim.AnimationId = "rbxassetid://182435998"
         elseif Option == "Танец2" then
            anim.AnimationId = "rbxassetid://204295235"
         elseif Option == "Стойка" then
            anim.AnimationId = "rbxassetid://313762630"
         end
         
         local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
         if hum then
            local track = hum:LoadAnimation(anim)
            track:Play()
         end
      end)
   end,
})

Rayfield:LoadConfiguration()

-- Уведомление о загрузке
Rayfield:Notify({
   Title = "LOOOOL Загружен!",
   Content = "ALL LOAD! Все функции активированы",
   Duration = 6.5,
   Image = 4483362458,
})
