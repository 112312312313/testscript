-- LocalScript в StarterPack или StarterGui
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Создание инструмента Hollow Purple
local tool = Instance.new("Tool")
tool.Name = "HollowPurple"
tool.ToolTip = "Jujutsu Kaisen - Hollow Purple Technique"
tool.CanBeDropped = false
tool.RequiresHandle = true

-- Создание handle для инструмента
local handle = Instance.new("Part")
handle.Name = "Handle"
handle.Size = Vector3.new(1, 1, 1)
handle.Transparency = 1
handle.CanCollide = false
handle.Parent = tool

-- Текстура инструмента (опционально)
local decal = Instance.new("Decal")
decal.Texture = "rbxassetid://245520987"
decal.Face = Enum.NormalId.Front
decal.Parent = handle

-- Помещаем инструмент в инвентарь
tool.Parent = LocalPlayer.Backpack

print("[Hollow Purple] Tool created in inventory")

-- Основная функция активации
tool.Activated:Connect(function()
    print("[Hollow Purple] Activation started")
    
    local character = LocalPlayer.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    
    if not humanoid or not rootPart then return end
    
    -- Загрузка анимации
    local animationId = "rbxassetid://245520987"
    local animation = Instance.new("Animation")
    animation.AnimationId = animationId
    
    local animationTrack = humanoid:LoadAnimation(animation)
    
    -- Визуальные эффекты активации
    local function createActivationEffects()
        -- Эффект красной и синей энергии (Blue and Red phase)
        local redBlueBall = Instance.new("Part")
        redBlueBall.Name = "RedBlueEnergy"
        redBlueBall.Size = Vector3.new(3, 3, 3)
        redBlueBall.Shape = Enum.PartType.Ball
        redBlueBall.Material = Enum.Material.Neon
        redBlueBall.BrickColor = BrickColor.new("Bright red")
        redBlueBall.CanCollide = false
        redBlueBall.Anchored = true
        redBlueBall.Parent = workspace
        
        -- Позиция перед персонажем
        local offset = rootPart.CFrame.lookVector * 6
        redBlueBall.CFrame = rootPart.CFrame + offset + Vector3.new(0, 2, 0)
        
        -- Свечение для красной фазы
        local redLight = Instance.new("PointLight")
        redLight.Brightness = 8
        redLight.Range = 12
        redLight.Color = Color3.fromRGB(255, 0, 0)
        redLight.Parent = redBlueBall
        
        -- Частицы красной энергии
        local redParticles = Instance.new("ParticleEmitter")
        redParticles.Color = ColorSequence.new(Color3.fromRGB(255, 0, 0))
        redParticles.Size = NumberSequence.new(0.5)
        redParticles.Lifetime = NumberRange.new(0.3, 1.0)
        redParticles.Rate = 30
        redParticles.Parent = redBlueBall
        
        -- Анимация перехода в фиолетовый
        local tweenService = game:GetService("TweenService")
        
        -- Фаза 1: Красная энергия
        local redPhase = tweenService:Create(redBlueBall, TweenInfo.new(0.5), {
            Size = Vector3.new(4, 4, 4),
            BrickColor = BrickColor.new("Bright red")
        })
        
        -- Фаза 2: Синяя энергия
        local bluePhase = tweenService:Create(redBlueBall, TweenInfo.new(0.5), {
            BrickColor = BrickColor.new("Bright blue")
        })
        
        -- Фаза 3: Фиолетовый взрыв (Hollow Purple)
        local purplePhase = tweenService:Create(redBlueBall, TweenInfo.new(0.3), {
            Size = Vector3.new(8, 8, 8),
            BrickColor = BrickColor.new("Royal purple")
        })
        
        -- Финальная фаза: исчезновение
        local disappearPhase = tweenService:Create(redBlueBall, TweenInfo.new(0.5), {
            Size = Vector3.new(0.1, 0.1, 0.1),
            Transparency = 1
        })
        
        -- Запуск анимации
        redPhase:Play()
        
        redPhase.Completed:Connect(function()
            -- Меняем свет на синий
            redLight.Color = Color3.fromRGB(0, 0, 255)
            redParticles.Color = ColorSequence.new(Color3.fromRGB(0, 0, 255))
            
            bluePhase:Play()
            
            bluePhase.Completed:Connect(function()
                -- Финальный переход в фиолетовый
                redLight.Color = Color3.fromRGB(150, 0, 255)
                redParticles.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 150)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 100, 255))
                })
                
                purplePhase:Play()
                
                purplePhase.Completed:Connect(function()
                    -- Нанесение урона в небольшом радиусе
                    local explosionPos = redBlueBall.Position
                    local explosionRange = 15
                    
                    -- Визуальный эффект взрыва
                    local explosion = Instance.new("Part")
                    explosion.Size = Vector3.new(1, 1, 1)
                    explosion.Shape = Enum.PartType.Ball
                    explosion.Material = Enum.Material.Neon
                    explosion.BrickColor = BrickColor.new("Royal purple")
                    explosion.CanCollide = false
                    explosion.Anchored = true
                    explosion.CFrame = CFrame.new(explosionPos)
                    explosion.Parent = workspace
                    
                    local explosionLight = Instance.new("PointLight")
                    explosionLight.Brightness = 15
                    explosionLight.Range = 20
                    explosionLight.Color = Color3.fromRGB(200, 100, 255)
                    explosionLight.Parent = explosion
                    
                    -- Быстрое расширение и исчезновение
                    local explodeTween = tweenService:Create(explosion, TweenInfo.new(0.4), {
                        Size = Vector3.new(explosionRange, explosionRange, explosionRange),
                        Transparency = 1
                    })
                    
                    explodeTween:Play()
                    
                    -- Находим цели в радиусе
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
                            if targetRoot then
                                local distance = (targetRoot.Position - explosionPos).Magnitude
                                if distance <= explosionRange then
                                    -- Наносим урон (только визуальный, без изменения здоровья)
                                    print("[Hollow Purple] Hit: " .. player.Name .. " (Distance: " .. math.floor(distance) .. ")")
                                    
                                    -- Эффект отбрасывания
                                    local bodyVelocity = Instance.new("BodyVelocity")
                                    bodyVelocity.Velocity = (targetRoot.Position - explosionPos).Unit * 30 + Vector3.new(0, 15, 0)
                                    bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                                    bodyVelocity.Parent = targetRoot
                                    
                                    game:GetService("Debris"):AddItem(bodyVelocity, 0.3)
                                end
                            end
                        end
                    end
                    
                    disappearPhase:Play()
                    
                    disappearPhase.Completed:Connect(function()
                        redBlueBall:Destroy()
                        wait(0.5)
                        explosion:Destroy()
                    end)
                end)
            end)
        end)
        
        return redBlueBall
    end

    -- Проигрываем анимацию
    animationTrack:Play()
    
    -- Создаем эффекты с небольшой задержкой
    wait(0.3)
    createActivationEffects()
    
    print("[Hollow Purple] Technique completed")
end)

-- Функция для перезарядки инструмента
local cooldown = false
tool.Activated:Connect(function()
    if cooldown then return end
    
    cooldown = true
    
    -- Вызов основной функции активации
    local character = LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            -- Здесь уже вызывается активация через соединение выше
        end
    end
    
    -- Визуальная индикация перезарядки
    tool.ToolTip = "Hollow Purple - Recharging..."
    tool.TextureId = "" -- Можно поменять текстуру
    
    -- Перезарядка 5 секунд
    wait(5)
    
    cooldown = false
    tool.ToolTip = "Jujutsu Kaisen - Hollow Purple Technique"
    tool.TextureId = "rbxassetid://245520987"
    
    print("[Hollow Purple] Ready to use again")
end)

-- Звуковые эффекты (опционально)
local function playSound(soundId)
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = 0.7
        sound.Parent = workspace
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 5)
    end)
end

-- Дополнительный эффект при взятии инструмента
tool.Equipped:Connect(function()
    print("[Hollow Purple] Tool equipped")
    
    -- Воспроизводим звук при взятии
    playSound("rbxassetid://9118469333")
    
    -- Эффект свечения вокруг персонажа
    local character = LocalPlayer.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            local aura = Instance.new("Part")
            aura.Size = Vector3.new(8, 8, 8)
            aura.Shape = Enum.PartType.Ball
            aura.Material = Enum.Material.Neon
            aura.BrickColor = BrickColor.new("Royal purple")
            aura.Transparency = 0.8
            aura.CanCollide = false
            aura.Anchored = true
            aura.Parent = workspace
            
            local weld = Instance.new("Weld")
            weld.Part0 = rootPart
            weld.Part1 = aura
            weld.C0 = CFrame.new(0, 0, 0)
            weld.Parent = aura
            
            local light = Instance.new("PointLight")
            light.Brightness = 5
            light.Range = 10
            light.Color = Color3.fromRGB(150, 0, 255)
            light.Parent = aura
            
            -- Исчезает через 2 секунды
            wait(2)
            
            local tween = game:GetService("TweenService"):Create(aura, TweenInfo.new(1), {
                Transparency = 1,
                Size = Vector3.new(0.1, 0.1, 0.1)
            })
            tween:Play()
            
            tween.Completed:Connect(function()
                aura:Destroy()
            end)
        end
    end
end)

print("[Hollow Purple] System loaded successfully!")
