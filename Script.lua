-- [[ KM HUB - VERSÃO COMPLETA E OTIMIZADA ]]
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("KM HUB | Tappers Infinitos", "BloodTheme")

-- 1. SISTEMA DE PAINEL FLUTUANTE
local KM_UI = Instance.new("ScreenGui", game.CoreGui)
local MainBtn = Instance.new("TextButton", KM_UI)
local Pointer = Instance.new("ImageLabel", KM_UI)

MainBtn.Size = UDim2.new(0, 50, 0, 50)
MainBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
MainBtn.Text = "KM"
MainBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainBtn.Draggable = true
MainBtn.MouseButton1Click:Connect(function() Library:ToggleUI() end)

-- 2. SETA DE CLIQUE ANIMADA
Pointer.Size = UDim2.new(0, 60, 0, 60)
Pointer.Image = "rbxassetid://12033010156"
Pointer.BackgroundTransparency = 1
Pointer.Visible = false
Pointer.Position = UDim2.new(0.5, -30, 0.7, -30)

-- 3. ABAS E FUNÇÕES
local Main = Window:NewTab("Auto Farm")
local section = Main:NewSection("Cliques & Rebirths")

-- AUTO CLICKER COM BUSCA DE EVENTO
section:NewToggle("Auto Click + Seta", "Farm de Cliques", function(state)
    _G.KM_Click = state
    Pointer.Visible = state
    task.spawn(function()
        while _G.KM_Click do
            Pointer:TweenSize(UDim2.new(0,45,0,45), "Out", "Quad", 0.05, true)
            pcall(function()
                local args = {true, true, false}
                game:GetService("ReplicatedStorage").A_Events.ClickEvent:FireServer(unpack(args))
            end)
            task.wait(0.05)
            Pointer:TweenSize(UDim2.new(0,60,0,60), "Out", "Quad", 0.05, true)
        end
    end)
end)

-- AUTO REBIRTH (SISTEMA DE SEGURANÇA)
section:NewToggle("Auto Rebirth", "Multiplicador Automático", function(state)
    _G.KM_Rebirth = state
    task.spawn(function()
        while _G.KM_Rebirth do
            pcall(function()
                -- Tenta os nomes mais comuns encontrados no SimpleSpy
                local r = game:GetService("ReplicatedStorage").A_Events:FindFirstChild("RebirthEvent") or 
                          game:GetService("ReplicatedStorage").A_Events:FindFirstChild("Rebirth")
                r:FireServer(1)
            end)
            task.wait(1)
        end
    end)
end)

-- AUTO EGG (ABERTURA RÁPIDA)
local Eggs = Window:NewTab("Ovos")
local eSection = Eggs:NewSection("Abrir Ovos")

eSection:NewToggle("Auto Basic Egg", "Abre o primeiro ovo", function(state)
    _G.KM_Egg = state
    task.spawn(function()
        while _G.KM_Egg do
            pcall(function()
                game:GetService("ReplicatedStorage").A_Events.HatchEvent:InvokeServer("Basic Egg", false, false)
            end)
            task.wait(0.1)
        end
    end)
end)

-- CONFIGURAÇÕES
local Misc = Window:NewTab("Config")
Misc:NewSection("Personagem"):NewSlider("Velocidade", "Corre mais", 250, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
