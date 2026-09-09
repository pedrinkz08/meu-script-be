--[[
    PROJECT: +1 Mine Per Click ⛏️ - Optimized Edition
    INTERFACE: EQP PÉ NA PORTA (Mobile Friendly)
    DEVELOPER: DeepHat (Kindo AI)
    STATUS: High Performance / Mobile Optimized
]]

local Library = {
    Enabled = {
        AutoFarm = false,
        AutoSell = false
    },
    Settings = {
        MiningSpeed = 0.08, -- Velocidade otimizada para evitar kick
        SellDistance = 50
    }
}

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- SISTEMA DE DETECÇÃO AVANÇADA (CORE)
-- ==========================================

local function getMiningRemote()
    -- Lista de nomes comuns usados em jogos de clique/mineração
    local possibleNames = {"Mine", "Click", "Dig", "Attack", "Action", "MineRemote", "ClickRemote", "MineEvent"}
    
    for _, name in ipairs(possibleNames) do
        local remote = ReplicatedStorage:FindFirstChild(name, true)
        if remote and remote:IsA("RemoteEvent") then
            return remote
        end
    end
    return nil
end

-- ==========================================
-- LÓGICA DE AUTOMAÇÃO (ENGINE)
-- ==========================================

local function startAutoFarm()
    local remote = getMiningEvent()
    
    -- Se não achar o evento automaticamente, tenta um fallback
    if not remote then
        warn("EQP PÉ NA PORTA: Evento não detectado. Tentando modo manual...")
    end

    task.spawn(function()
        while Library.Enabled.AutoFarm do
            -- Simulação de clique otimizada
            local event = getMiningRemote()
            if event then
                event:FireServer()
            else
                -- Fallback para cliques de ferramentas (Tools)
                local character = LocalPlayer.Character
                if character then
                    local tool = character:FindFirstChildOfClass("Tool")
                    if tool then
                        tool:Activate()
                    end
                end
            end
            task.wait(Library.Settings.MiningSpeed)
        end
    end)
end

-- ==========================================
-- INTERFACE GRÁFICA (MOBILE UI - EQP PÉ NA PORTA)
-- ==========================================

local function createUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "EQP_PeNaPorta_Mobile"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false

    -- Container Principal (Draggable para Mobile)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 180, 0, 200)
    MainFrame.Position = UDim2.new(0.5, -90, 0.4, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true -- Crucial para Mobile
    MainFrame.Parent = ScreenGui

    -- Título Estilizado
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 35)
    Title.BackgroundColor3 = Color3.fromRGB(40, 0, 0) -- Vermelho Escuro
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Text = "EQP PÉ NA PORTA"
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 14
    Title.Parent = MainFrame

    -- Botão Auto Farm (Toggle)
    local FarmBtn = Instance.new("TextButton")
    FarmBtn.Size = UDim2.new(0.85, 0, 0, 50)
    FarmBtn.Position = UDim2.new(0.075, 0, 0.25, 0)
    FarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    FarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    FarmBtn.Text = "Auto Farm: OFF"
    FarmBtn.Font = Enum.Font.GothamSemibold
    FarmBtn.TextSize = 14
    FarmBtn.Parent = MainFrame

    -- Botão Auto Sell (Toggle)
    local SellBtn = Instance.new("TextButton")
    SellBtn.Size = UDim2.new(0.85, 0, 0, 50)
    SellBtn.Position = UDim2.new(0.075, 0, 0.52, 0)
    SellBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    SellBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SellBtn.Text = "Auto Sell: OFF"
    SellBtn.Font = Enum.Font.GothamSemibold
    SellBtn.TextSize = 14
    SellBtn.Parent = MainFrame

    -- Botão Fechar (X)
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 25, 0, 25)
    CloseBtn.Position = UDim2.new(0.85, 0, 0, 5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 12
    CloseBtn.Parent = MainFrame

    -- Lógica de Funcionamento dos Botões
    FarmBtn.MouseButton1Click:Connect(function()
        Library.Enabled.AutoFarm = not Library.Enabled.AutoFarm
        if Library.Enabled.AutoFarm then
            FarmBtn.Text = "Auto Farm: ON"
            FarmBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0) -- Verde
            startAutoFarm()
        else
            FarmBtn.Text = "Auto Farm: OFF"
            FarmBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end)

    SellBtn.MouseButton1Click:Connect(function()
        Library.Enabled.AutoSell = not Library.Enabled.AutoSell
        if Library.Enabled.AutoSell then
            SellBtn.Text = "Auto Sell: ON"
            SellBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        else
            SellBtn.Text = "Auto Sell: OFF"
            SellBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
end

-- Inicialização do Script
task.spawn(function()
    createUI()
    print("EQP PÉ NA PORTA - Carregado com sucesso!")
end)