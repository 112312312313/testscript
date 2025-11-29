-- Исправленная версия - работает с правильной библиотекой Rayfield
loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

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

-- REAL FE НЕВИДИМОСТЬ
local MainTab = Window:CreateTab("Главные функции", 4483362458)

MainTab:CreateToggle({
   Name = "REAL FE Невидимость",
   CurrentValue = false,
   Callback = function(Value)
      _G.TrueInvisible = Value
      if Value then
         local char = game.Players.LocalPlayer.Character
         if char then
            for _, part in ipairs(char:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.Transparency = 1
                  part.CanCollide = false
               end
            end
         end
      else
         local char = game.Players.LocalPlayer.Character
         if char then
            for _, part in ipairs(char:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.Transparency = 0
                  part.CanCollide = true
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
   Callback = function(Value)
      _G.Noclip = Value
      game:GetService("RunService").Stepped:Connect(function()
         if _G.Noclip and game.Players.LocalPlayer.Character then
            for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
               if part:IsA("BasePart") then
                  part.CanCollide = false
               end
            end
         end
      end)
   end,
})

-- Телепортация к игрокам
local playersList = {}
for _, player in ipairs(game.Players:GetPlayers()) do
   if player ~= game.Players.LocalPlayer then
      table.insert(playersList, player.Name)
   end
end

local PlayerTP = MainTab:CreateDropdown({
   Name = "Телепорт к игроку",
   Options = playersList,
   CurrentOption = playersList[1] or "Нет игроков",
   Callback = function(Option)
      local target = game.Players[Option]
      if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
      end
   end,
})

-- Телепорт по координатам
MainTab:CreateSection("Телепорт по координатам")
local XInput = MainTab:CreateInput({
   Name = "X координата",
   PlaceholderText = "0",
   Callback = function(Text) end,
})

local YInput = MainTab:CreateInput({
   Name = "Y координата",
   PlaceholderText = "0", 
   Callback = function(Text) end,
})

local ZInput = MainTab:CreateInput({
   Name = "Z координата",
   PlaceholderText = "0",
   Callback = function(Text) end,
})

MainTab:CreateButton({
   Name = "Телепортироваться",
   Callback = function()
      local x = tonumber(XInput:GetValue()) or 0
      local y = tonumber(YInput:GetValue()) or 0
      local z = tonumber(ZInput:GetValue()) or 0
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
   end,
})

-- Визуальные функции
local VisualTab = Window:CreateTab("Визуал", 4483362458)

-- ESP
VisualTab:CreateToggle({
   Name = "ESP игроков",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP = Value
      
      if Value then
         for _, player in ipairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
               coroutine.wrap(function()
                   local highlight = Instance.new("Highlight")
                   highlight.Parent = player.Character
                   highlight.Adornee = player.Character
                   highlight.FillColor = Color3.fromRGB(255, 0, 0)
                   
                   while _G.ESP and player.Character do
                       wait(0.1)
                   end
                   highlight:Destroy()
               end)()
            end
         end
      else
         _G.ESP = false
      end
   end,
})

-- Скорость
VisualTab:CreateSlider({
   Name = "Скорость движения",
   Range = {16, 200},
   Increment = 1,
   Suffix = "speed",
   CurrentValue = 16,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
   end,
})

-- Прыжок
VisualTab:CreateSlider({
   Name = "Сила прыжка",
   Range = {50, 200},
   Increment = 1,
   Suffix = "jump", 
   CurrentValue = 50,
   Callback = function(Value)
      game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
   end,
})

Rayfield:Notify({
   Title = "LOOOOL Загружен!",
   Content = "ALL LOAD! Все функции работают",
   Duration = 5,
   Image = 4483362458,
})
