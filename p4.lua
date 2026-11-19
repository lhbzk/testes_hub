if not _G.RD4X_UI then error("[RD4X] Execute a Parte 1/4 primeiro!") end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local HttpService = game:GetService("HttpService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local ScreenGui       = _G.RD4X_ScreenGui
local MainFrame       = _G.RD4X_MainFrame
local NotifHolder     = _G.RD4X_NotifHolder
local BolhasContainer = _G.RD4X_BolhasContainer
local strokeMain      = _G.RD4X_strokeMain
local criarBolha      = _G.RD4X_criarBolha
local UI              = _G.RD4X_UI
local Notify          = _G.RD4X_Notify
local Tabs            = _G.RD4X_Tabs

local COR_FUNDO        = _G.RD4X_COR_FUNDO
local COR_SIDEBAR      = _G.RD4X_COR_SIDEBAR
local COR_SECUNDARIA   = _G.RD4X_COR_SECUNDARIA
local COR_TEXTO        = _G.RD4X_COR_TEXTO
local COR_TEXTO_CINZA  = _G.RD4X_COR_TEXTO_CINZA
local COR_VERDE        = _G.RD4X_COR_VERDE
local COR_BORDA        = _G.RD4X_COR_BORDA
local COR_VERMELHO     = _G.RD4X_COR_VERMELHO
local TRANSP_FUNDO       = _G.RD4X_TRANSP_FUNDO
local TRANSP_SIDEBAR     = _G.RD4X_TRANSP_SIDEBAR
local TRANSP_CARDS       = _G.RD4X_TRANSP_CARDS
local TRANSP_INPUT       = _G.RD4X_TRANSP_INPUT
local TRANSP_BOTAO_VERDE = _G.RD4X_TRANSP_BOTAO_VERDE

-- Controlo único do loop de bolhas para evitar duplicação
local bolhaLoopId = 0
local function controlarLoopBolhas(ativo)
    _G.RD4X_BolhasAtivas = ativo
    bolhaLoopId = bolhaLoopId + 1
    local meuId = bolhaLoopId

    if ativo and criarBolha and BolhasContainer then
        task.spawn(function()
            while _G.RD4X_BolhasAtivas and meuId == bolhaLoopId and BolhasContainer.Parent do
                criarBolha()
                task.wait(math.random(8, 30) / 100)
            end
        end)
    end
end

-- ABA OUTROS
UI.Paragraph(Tabs.Outros, {
    Title = "Aviso do Rd4X",
    Content = "Essa aba está sem funções no momento",
    Icon = "109123578002396"
})

--------------------------------------------------------------------------------
-- ABA PROTEÇÃO
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Protecao, {
    Title = "Proteções | P. Premium",
    Description = "Proteções normais e Proteções Premiuns.",
    Icon = "5197571759"
})

local antiAfkConectado = false
UI.Button(Tabs.Protecao, {
    Name = "Anti-AFK (Evita Desconexão)",
    Description = "Evita desconexão por inatividade",
    Callback = function()
        if not antiAfkConectado then
            antiAfkConectado = true
            pcall(function()
                local vu = game:GetService("VirtualUser")
                LocalPlayer.Idled:Connect(function()
                    vu:Button2Down(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
                    task.wait(0.5)
                    vu:Button2Up(Vector2.new(0, 0), Workspace.CurrentCamera.CFrame)
                end)
            end)
        end
        Notify("Proteção", "Enabled", 3)
    end
})

-- Invisibilidade limpa (salva transparência original e não deixa bloco cinza)
local invisivelAtivo = false
local transparenciasOriginais = {}

local function aplicarInvisibilidade(char, esconder)
    if not char then return end
    for _, obj in ipairs(char:GetDescendants()) do
        if obj.Name ~= "HumanoidRootPart" then
            if obj:IsA("BasePart") or obj:IsA("Decal") then
                if esconder then
                    if transparenciasOriginais[obj] == nil then
                        transparenciesOriginais[obj] = obj.Transparency
                    end
                    obj.Transparency = 1
                else
                    if transparenciasOriginais[obj] ~= nil then
                        obj.Transparency = transparenciasOriginais[obj]
                    else
                        obj.Transparency = 0
                    end
                end
            end
        end
    end
    if not esconder then
        table.clear(transparenciesOriginais)
    end
end

UI.Toggle(Tabs.Player, {
    Name = "Invisibilidade",
    CurrentValue = false,
    Callback = function(state)
        invisivelAtivo = state
        pcall(function()
            aplicarInvisibilidade(LocalPlayer.Character, invisivelAtivo)
        end)
        Notify("Player", invisivelAtivo and "Enabled" or "Disabled", 2)
    end
})

LocalPlayer.CharacterAdded:Connect(function(char)
    table.clear(transparenciesOriginais)
    if invisivelAtivo then
        task.wait(0.4)
        pcall(function()
            aplicarInvisibilidade(char, true)
        end)
    end
end)

local antiSitAtivo, antiLagAtivo, antiFlingAtivo, noclipAtivo, espAtivo = false, false, false, false, false

UI.Toggle(Tabs.Protecao, {
    Name = "Anti-Sit",
    CurrentValue = false,
    Callback = function(v) antiSitAtivo = v end
})

RunService.Stepped:Connect(function()
    if antiSitAtivo and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum and hum.Sit then
            hum.Sit = false
            hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        end
    end
end)

UI.Toggle(Tabs.Protecao, {
    Name = "Anti-Lag",
    CurrentValue = false,
    Callback = function(v)
        antiLagAtivo = v
        if antiLagAtivo then
            task.spawn(function()
                local contador = 0
                for _, obj in ipairs(Workspace:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Fire") or obj:IsA("Smoke") or obj:IsA("Sparkles") then
                        pcall(function()
                            obj.Enabled = false
                        end)
                    end
                    contador = contador + 1
                    if contador % 250 == 0 then
                        task.wait()
                    end
                end
                Notify("Proteção", "Efeitos pesados reduzidos!", 2)
            end)
        else
            Notify("Proteção", "Anti-Lag desativado.", 2)
        end
    end
})

-- Anti-Fling focado em teleporte/puxão repentino no Brookhaven
local ultimaPosSegura = nil
local lastFlingReset = 0

UI.Toggle(Tabs.Protecao, {
    Name = "Anti-Fling",
    CurrentValue = false,
    Callback = function(v)
        antiFlingAtivo = v
        ultimaPosSegura = nil
        Notify("Proteção", v and "Anti-Fling ativo!" or "Anti-Fling desativado.", 2)
    end
})

RunService.Heartbeat:Connect(function()
    if not antiFlingAtivo then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    -- Zera forças de arremesso contínuas
    if hrp.AssemblyLinearVelocity.Magnitude > 95 then
        hrp.AssemblyLinearVelocity = Vector3.zero
    end
    if hrp.AssemblyAngularVelocity.Magnitude > 25 then
        hrp.AssemblyAngularVelocity = Vector3.zero
    end

    local posAtual = hrp.Position
    if ultimaPosSegura then
        local distancia = (posAtual - ultimaPosSegura).Magnitude
        -- Detecta teleporte/puxão repentino fora do normal e puxa de volta
        if distancia > 35 and (os.clock() - lastFlingReset) > 0.35 then
            lastFlingReset = os.clock()
            hrp.AssemblyLinearVelocity = Vector3.zero
            hrp.AssemblyAngularVelocity = Vector3.zero
            hrp.CFrame = CFrame.new(ultimaPosSegura + Vector3.new(0, 1.5, 0))
            return
        end
    end

    if hum:GetState() ~= Enum.HumanoidStateType.Seated and hum:GetState() ~= Enum.HumanoidStateType.PlatformStanding then
        ultimaPosSegura = posAtual
    end
end)

UI.Toggle(Tabs.Protecao, {
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(v) noclipAtivo = v end
})

RunService.Stepped:Connect(function()
    if noclipAtivo and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

UI.Toggle(Tabs.Protecao, {
    Name = "ESP",
    CurrentValue = false,
    Callback = function(state)
        espAtivo = state
        if espAtivo then
            task.spawn(function()
                while espAtivo do
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") and not p.Character.Head:FindFirstChild("RD4X_ESP") then
                            local bg = Instance.new("BillboardGui", p.Character.Head)
                            bg.Name = "RD4X_ESP"
                            bg.Size = UDim2.new(0, 100, 0, 40)
                            bg.StudsOffset = Vector3.new(0, 3, 0)
                            bg.AlwaysOnTop = true
                            local tl = Instance.new("TextLabel", bg)
                            tl.Size = UDim2.new(1, 0, 1, 0)
                            tl.BackgroundTransparency = 1
                            tl.TextColor3 = _G.RD4X_COR_VERMELHO or COR_VERMELHO
                            tl.TextStrokeTransparency = 0
                            tl.TextSize = 14
                            tl.Text = p.Name
                        end
                    end
                    task.wait(1)
                end
            end)
        else
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character and p.Character:FindFirstChild("Head") then
                    local esp = p.Character.Head:FindFirstChild("RD4X_ESP")
                    if esp then esp:Destroy() end
                end
            end
        end
    end
})

--------------------------------------------------------------------------------
-- ABA CONFIG
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Config, {
    Title = "Configurações | Funções gerais",
    Description = "Funções gerais do script",
    Icon = "134966548587596"
})

UI.Toggle(Tabs.Config, {
    Name = "Bolhas do Script",
    CurrentValue = true,
    Callback = function(v)
        controlarLoopBolhas(v)
    end
})

UI.Toggle(Tabs.Config, {
    Name = "Borda do Botão flutuante",
    CurrentValue = true,
    Callback = function(v)
        _G.RD4X_BordaPulsando = v
        if not v and strokeMain and strokeMain.Parent then
            strokeMain.Transparency = 0.3
            strokeMain.Thickness = 1.2
        end
    end
})

UI.InfoBlock(Tabs.Config, {
    Title = "Cores | Notificações | Entre outros",
    Description = "Configurações",
    Icon = "134966548587596"
})

local PALETA_CORES = {
    ["Vermelho (Padrão)"] = Color3.fromRGB(220, 20, 60),
    ["Verde"]              = Color3.fromRGB(46, 204, 113),
    ["Azul"]               = Color3.fromRGB(52, 152, 219),
    ["Roxo"]               = Color3.fromRGB(155, 89, 182),
    ["Amarelo"]            = Color3.fromRGB(241, 196, 15),
    ["Laranja"]            = Color3.fromRGB(230, 126, 34),
    ["Rosa"]               = Color3.fromRGB(255, 105, 180),
    ["Turquesa"]           = Color3.fromRGB(26, 188, 156),
}

local NOMES_CORES = {
    "Vermelho (Padrão)",
    "Verde",
    "Azul",
    "Roxo",
    "Amarelo",
    "Laranja",
    "Rosa",
    "Turquesa",
}

local corDestaqueAnterior = _G.RD4X_COR_VERMELHO or COR_VERMELHO

local function trocarCorHub(novaCor)
    if not novaCor then return end
    local corAntiga = corDestaqueAnterior
    corDestaqueAnterior = novaCor
    COR_VERMELHO = novaCor
    COR_VERDE = novaCor
    _G.RD4X_COR_VERMELHO = novaCor
    _G.RD4X_COR_VERDE = novaCor

    if ScreenGui and ScreenGui.Parent then
        for _, obj in ipairs(ScreenGui:GetDescendants()) do
            pcall(function()
                if obj:IsA("UIStroke") then
                    if obj.Color == corAntiga or obj.Color == Color3.fromRGB(220, 20, 60) or obj.Color == Color3.fromRGB(46, 204, 113) then
                        obj.Color = novaCor
                    end
                elseif obj:IsA("ScrollingFrame") then
                    if obj.ScrollBarImageColor3 == corAntiga or obj.ScrollBarImageColor3 == Color3.fromRGB(220, 20, 60) or obj.ScrollBarImageColor3 == Color3.fromRGB(46, 204, 113) then
                        obj.ScrollBarImageColor3 = novaCor
                    end
                elseif obj:IsA("Frame") or obj:IsA("TextButton") then
                    if obj.BackgroundColor3 == corAntiga or obj.BackgroundColor3 == Color3.fromRGB(220, 20, 60) or obj.BackgroundColor3 == Color3.fromRGB(46, 204, 113) then
                        obj.BackgroundColor3 = novaCor
                    end
                elseif obj:IsA("TextLabel") then
                    if obj.TextColor3 == corAntiga or obj.TextColor3 == Color3.fromRGB(220, 20, 60) or obj.TextColor3 == Color3.fromRGB(46, 204, 113) then
                        obj.TextColor3 = novaCor
                    end
                end
            end)
        end
    end

    local botaoFlutuante = ScreenGui and ScreenGui:FindFirstChild("BotaoFlutuanteRD4X")
    local strokeBF = botaoFlutuante and botaoFlutuante:FindFirstChildOfClass("UIStroke")
    if strokeBF then
        strokeBF.Color = novaCor
    end

    Notify("Config", "Cor do hub atualizada!", 2)
end

UI.Dropdown(Tabs.Config, {
    Name = "Cor do Hub",
    Options = NOMES_CORES,
    CurrentOption = {"Vermelho (Padrão)"},
    Callback = function(opt)
        local escolhido = opt and opt[1]
        if escolhido and PALETA_CORES[escolhido] then
            trocarCorHub(PALETA_CORES[escolhido])
        end
    end
})

UI.Toggle(Tabs.Config, {
    Name = "Notificações",
    CurrentValue = true,
    Callback = function(v)
        _G.RD4X_NotifAtivas = v
        if v then Notify("Config", "Notificações ativadas", 2) end
    end
})

UI.Toggle(Tabs.Config, {
    Name = "Som de Clique",
    CurrentValue = true,
    Callback = function(v)
        _G.RD4X_SomAtivo = v
        if v then Notify("Config", "Som ativado", 2) end
    end
})

-- Música de fundo, volume e botão mantidos sem mexer
UI.Toggle(Tabs.Config, {
    Name = "Música de Fundo",
    CurrentValue = true,
    Callback = function(v)
        pcall(function()
            if _G.RD4X_MusicaFundo then
                if v then _G.RD4X_MusicaFundo:Resume() else _G.RD4X_MusicaFundo:Pause() end
            end
        end)
    end
})

UI.Input(Tabs.Config, {
    Name = "Volume da Música",
    CurrentValue = "0.15",
    PlaceholderText = "0 a 1",
    Callback = function(v)
        local n = tonumber(v) or 0.15
        pcall(function()
            if _G.RD4X_MusicaFundo then
                _G.RD4X_MusicaFundo.Volume = n
            end
        end)
    end,
})

UI.InfoBlock(Tabs.Config, {
    Title = "Transparência | Modo leve",
    Description = "Interface, entre outros",
    Icon = "134966548587596"
})

UI.Input(Tabs.Config, {
    Name = "Transparência (0-1)",
    CurrentValue = "0.25",
    PlaceholderText = "0 = sólido",
    Callback = function(v)
        local n = tonumber(v) or 0.25
        if MainFrame then
            MainFrame.BackgroundTransparency = n
        end
        Notify("Config", "Transparência: " .. n, 2)
    end,
})

UI.Toggle(Tabs.Config, {
    Name = "Modo Leve",
    CurrentValue = false,
    Callback = function(v)
        if v then
            controlarLoopBolhas(false)
            _G.RD4X_BordaPulsando = false
            if strokeMain and strokeMain.Parent then
                strokeMain.Transparency = 0.5
            end
            Notify("Config", "Modo leve ativado", 2)
        else
            controlarLoopBolhas(true)
            _G.RD4X_BordaPulsando = true
            Notify("Config", "Modo normal", 2)
        end
    end,
})

UI.Button(Tabs.Config, {
    Name = "Limpar Notificações",
    Description = "Caso alguma notificação fique presa na tela, use isso para remover",
    Callback = function()
        if NotifHolder then
            for _, notif in ipairs(NotifHolder:GetChildren()) do
                if notif:IsA("Frame") then notif:Destroy() end
            end
        end
    end,
})

UI.Button(Tabs.Config, {
    Name = "Minimizar",
    Description = "Fecha a interface do hub",
    Callback = function()
        if MainFrame then
            MainFrame.Visible = false
        end
    end,
})

UI.Paragraph(Tabs.Config, {
    Title = "Sobre",
    Content = "Rd4X Hub v1.0\nBy nxz7\nhttps://discord.gg/kZzuySatK9",
    Height = 70
})

-- Borda pulsante segura
task.spawn(function()
    while MainFrame and MainFrame.Parent do
        if _G.RD4X_BordaPulsando and strokeMain and strokeMain.Parent then
            TweenService:Create(strokeMain, TweenInfo.new(1.5), {Transparency = 0.8, Thickness = 2.5}):Play()
            task.wait(1.5)
            if strokeMain and strokeMain.Parent then
                TweenService:Create(strokeMain, TweenInfo.new(1.5), {Transparency = 0.2, Thickness = 1.2}):Play()
            end
            task.wait(1.5)
        else
            task.wait(0.5)
        end
    end
end)

--------------------------------------------------------------------------------
-- ABA SCRIPTS (RESERVADA PARA SCRIPTS FUTUROS)
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Scripts, {
    Title = "Scripts Oficiais",
    Description = "Scripts criados por mim",
    Icon = "5650870659"
})
UI.Button(Tabs.Scripts, { Name = "Rd4X Emotes", Description = "Carrega o Rd4x Emotes", Callback = function() Notify("Scripts", "Aguarde loadstring...", 2) end })
UI.Button(Tabs.Scripts, { Name = "Rd4X Chat", Description = "Carrega o Rd4x chat", Callback = function() Notify("Scripts", "Aguarde loadstring...", 2) end })
UI.Button(Tabs.Scripts, { Name = "Rd4X Universal", Description = "Carrega o script universal", Callback = function() Notify("Scripts", "Aguarde loadstring...", 2) end })

UI.InfoBlock(Tabs.Scripts, {
    Title = "Scripts terceirizados",
    Description = "Outros",
    Icon = "5650870659"
})
UI.Button(Tabs.Scripts, {
    Name = "Fly gui",
    Description = "Abre o menu de voar",
    Callback = function()
        task.spawn(function()
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt"))()
            end)
        end)
        Notify("Scripts", "Fly GUI carregado!", 2)
    end
})

UI.Button(Tabs.Scripts, {
    Name = "Fly car",
    Description = "Abre o menu de fly car",
    Callback = function()
        task.spawn(function()
            pcall(function()
                loadstring(game:HttpGet("https://raw.githubusercontent.com/willthingVN/script-lua/refs/heads/main/Vehicle%20Fly%20Gui.lua"))()
            end)
        end)
        Notify("Scripts", "Fly Car carregado!", 2)
    end
})

--------------------------------------------------------------------------------
-- POPUP DE ANÚNCIO (VISUAL CINZA COMBINANDO COM O LOADER)
--------------------------------------------------------------------------------
task.spawn(function()
    task.wait(1)
    local oldAd = CoreGui:FindFirstChild("Rd4X_Ad_Anuncio")
    if oldAd then oldAd:Destroy() end

    local AdGui = Instance.new("ScreenGui")
    AdGui.Name = "Rd4X_Ad_Anuncio"
    AdGui.ResetOnSpawn = false
    AdGui.DisplayOrder = 9999
    AdGui.IgnoreGuiInset = true
    AdGui.Parent = CoreGui

    local CINZA_FUNDO       = Color3.fromRGB(16, 16, 20)
    local CINZA_CARD        = Color3.fromRGB(23, 23, 29)
    local CINZA_BOTAO       = Color3.fromRGB(37, 35, 41)
    local CINZA_BOTAO_HOVER = Color3.fromRGB(49, 45, 53)
    local CINZA_BORDA       = Color3.fromRGB(48, 46, 53)
    local CINZA_SCROLL      = Color3.fromRGB(95, 92, 102)
    local TEXTO_CLARO       = Color3.fromRGB(238, 236, 239)
    local TEXTO_CINZA       = Color3.fromRGB(151, 148, 157)

    local anuncio = Instance.new("Frame", AdGui)
    anuncio.Size = UDim2.new(0, 0, 0, 0)
    anuncio.Position = UDim2.new(0.5, 0, 0.5, 0)
    anuncio.BackgroundColor3 = CINZA_FUNDO
    anuncio.BackgroundTransparency = 0
    anuncio.BorderSizePixel = 0
    anuncio.ClipsDescendants = true
    anuncio.ZIndex = 1

    Instance.new("UICorner", anuncio).CornerRadius = UDim.new(0, 10)
    local sAd = Instance.new("UIStroke", anuncio)
    sAd.Color = CINZA_BORDA
    sAd.Thickness = 1.5
    sAd.Transparency = 0.15
    sAd.ZIndex = 2

    local bolhasAd = Instance.new("Frame", anuncio)
    bolhasAd.Size = UDim2.new(1, 0, 1, 0)
    bolhasAd.BackgroundTransparency = 1
    bolhasAd.ClipsDescendants = true
    bolhasAd.ZIndex = 0

    local adAberto = true
    task.spawn(function()
        while adAberto and bolhasAd.Parent do
            local tam = math.random(5, 12)
            local b = Instance.new("Frame", bolhasAd)
            b.Size = UDim2.new(0, tam, 0, tam)
            b.Position = UDim2.new(math.random(), 0, 1, 5)
            local cores = {
                Color3.fromRGB(46, 204, 113),
                Color3.fromRGB(52, 152, 219),
                Color3.fromRGB(155, 89, 182),
                Color3.fromRGB(241, 196, 15),
                Color3.fromRGB(231, 76, 60),
            }
            b.BackgroundColor3 = cores[math.random(1, #cores)]
            b.BackgroundTransparency = math.random(20, 45) / 100
            b.BorderSizePixel = 0
            b.ZIndex = 0
            Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
            local tw = TweenService:Create(b, TweenInfo.new(math.random(4, 8), Enum.EasingStyle.Linear), {
                Position = UDim2.new(b.Position.X.Scale, 0, 0, -15),
                BackgroundTransparency = 1
            })
            tw:Play()
            tw.Completed:Connect(function() if b and b.Parent then b:Destroy() end end)
            task.wait(math.random(12, 35) / 100)
        end
    end)

    local adHeader = Instance.new("Frame", anuncio)
    adHeader.Size = UDim2.new(1, 0, 0, 40)
    adHeader.BackgroundColor3 = CINZA_CARD
    adHeader.BackgroundTransparency = 0.1
    adHeader.BorderSizePixel = 0
    adHeader.ZIndex = 2
    Instance.new("UICorner", adHeader).CornerRadius = UDim.new(0, 10)

    local adIcon = Instance.new("TextLabel", adHeader)
    adIcon.Size = UDim2.new(0, 24, 0, 24)
    adIcon.Position = UDim2.new(0, 10, 0.5, -12)
    adIcon.BackgroundTransparency = 1
    adIcon.Text = "📢"
    adIcon.TextSize = 15
    adIcon.ZIndex = 3

    local adTitle = Instance.new("TextLabel", adHeader)
    adTitle.Size = UDim2.new(1, -70, 1, 0)
    adTitle.Position = UDim2.new(0, 40, 0, 0)
    adTitle.BackgroundTransparency = 1
    adTitle.Text = "Updates!"
    adTitle.TextColor3 = TEXTO_CLARO
    adTitle.TextSize = 13
    adTitle.Font = Enum.Font.GothamBold
    adTitle.TextXAlignment = Enum.TextXAlignment.Left
    adTitle.ZIndex = 3

    local adClose = Instance.new("TextButton", adHeader)
    adClose.Size = UDim2.new(0, 24, 0, 24)
    adClose.Position = UDim2.new(1, -32, 0.5, -12)
    adClose.BackgroundTransparency = 1
    adClose.Text = "✕"
    adClose.TextColor3 = TEXTO_CINZA
    adClose.TextSize = 14
    adClose.Font = Enum.Font.GothamBold
    adClose.AutoButtonColor = false
    adClose.ZIndex = 3

    adClose.MouseEnter:Connect(function() adClose.TextColor3 = COR_VERMELHO end)
    adClose.MouseLeave:Connect(function() adClose.TextColor3 = TEXTO_CINZA end)

    local function ColorirChangelog(texto)
        local mapaCores = {
            ["fix"]        = "#2ECC71",
            ["corrigido"]  = "#2ECC71",
            ["conserto"]   = "#2ECC71",
            ["remove"]     = "#E74C3C",
            ["removido"]   = "#E74C3C",
            ["del"]        = "#E74C3C",
            ["add"]        = "#F1C40F",
            ["adicionado"] = "#F1C40F",
            ["novo"]       = "#F1C40F",
            ["update"]     = "#E67E22",
            ["atualizado"] = "#E67E22",
            ["info"]       = "#3498DB",
            ["aviso"]      = "#3498DB",
        }

        local linhas = {}
        for linha in (texto .. "\n"):gmatch("(.-)\n") do
            local palavra, resto = linha:match("^(%a+):%s*(.*)$")
            if palavra and mapaCores[palavra:lower()] then
                local cor = mapaCores[palavra:lower()]
                table.insert(linhas, string.format(
                    '<font color="%s"><b>%s:</b></font> %s',
                    cor, palavra, resto
                ))
            else
                table.insert(linhas, linha)
            end
        end
        return table.concat(linhas, "\n")
    end

    local adTextScroll = Instance.new("ScrollingFrame", anuncio)
    adTextScroll.Size = UDim2.new(1, -20, 1, -80)
    adTextScroll.Position = UDim2.new(0, 10, 0, 48)
    adTextScroll.BackgroundTransparency = 1
    adTextScroll.BorderSizePixel = 0
    adTextScroll.ScrollBarThickness = 2
    adTextScroll.ScrollBarImageColor3 = CINZA_SCROLL
    adTextScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    adTextScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    adTextScroll.ScrollingDirection = Enum.ScrollingDirection.Y
    adTextScroll.ZIndex = 3

    local adText = Instance.new("TextLabel", adTextScroll)
    adText.Size = UDim2.new(1, 0, 0, 0)
    adText.AutomaticSize = Enum.AutomaticSize.Y
    adText.BackgroundTransparency = 1
    adText.Text = ColorirChangelog([[
🎉 Bem-vindo ao Rd4X Hub!

Este hub foi lançado a pouco tempo e já está com diversas funções!... Mas, essa é a primeira versão de muitas, por isso, se achar bugs/falhas nos conte no Discord!

Info: Versão beta
Fix: Menu principal
Fix: Travamento na execução
Add: Loader
Add: Pop-Up de updates.
Add: RGB Function

]])
    adText.TextColor3 = TEXTO_CLARO
    adText.TextSize = 11
    adText.Font = Enum.Font.Gotham
    adText.TextXAlignment = Enum.TextXAlignment.Left
    adText.TextYAlignment = Enum.TextYAlignment.Top
    adText.TextWrapped = true
    adText.RichText = true
    adText.ZIndex = 3

    local adOk = Instance.new("TextButton", anuncio)
    adOk.Size = UDim2.new(1, -20, 0, 32)
    adOk.Position = UDim2.new(0, 10, 1, -42)
    adOk.BackgroundColor3 = CINZA_BOTAO
    adOk.BackgroundTransparency = 0
    adOk.BorderSizePixel = 0
    adOk.Text = "Entendi!"
    adOk.TextColor3 = TEXTO_CLARO
    adOk.TextSize = 12
    adOk.Font = Enum.Font.GothamBold
    adOk.AutoButtonColor = false
    adOk.ZIndex = 3

    Instance.new("UICorner", adOk).CornerRadius = UDim.new(0, 6)
    local sOk = Instance.new("UIStroke", adOk)
    sOk.Color = CINZA_BORDA
    sOk.Thickness = 1
    sOk.Transparency = 0.2

    adOk.MouseEnter:Connect(function()
        TweenService:Create(adOk, TweenInfo.new(0.15), {BackgroundColor3 = CINZA_BOTAO_HOVER}):Play()
    end)
    adOk.MouseLeave:Connect(function()
        TweenService:Create(adOk, TweenInfo.new(0.15), {BackgroundColor3 = CINZA_BOTAO}):Play()
    end)

    local function fecharAd()
        adAberto = false
        TweenService:Create(anuncio, TweenInfo.new(0.3), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            BackgroundTransparency = 1
        }):Play()
        for _, obj in ipairs(anuncio:GetDescendants()) do
            pcall(function()
                if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                    TweenService:Create(obj, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
                elseif obj:IsA("Frame") then
                    TweenService:Create(obj, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                elseif obj:IsA("UIStroke") then
                    TweenService:Create(obj, TweenInfo.new(0.3), {Transparency = 1}):Play()
                end
            end)
        end
        task.wait(0.35)
        if AdGui and AdGui.Parent then AdGui:Destroy() end
    end

    adClose.MouseButton1Click:Connect(fecharAd)
    adOk.MouseButton1Click:Connect(fecharAd)

    TweenService:Create(anuncio, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 340, 0, 220),
        Position = UDim2.new(0.5, -170, 0.5, -110)
    }):Play()
end)

Notify("RD4X Hub", "Interface carregada com sucesso!", 4)

--------------------------------------------------------------------------------
-- MÚSICA DE FUNDO (MANTIDO SEM MEXER)
--------------------------------------------------------------------------------
_G.RD4X_MusicaFundo = Instance.new("Sound", SoundService)
_G.RD4X_MusicaFundo.SoundId = "rbxassetid://1843525279"
_G.RD4X_MusicaFundo.Volume = 0.15
_G.RD4X_MusicaFundo.Looped = true

UI.Button(Tabs.Outros, {
    Name = "🎵 Play/Pause Música",
    Description = "Liga ou desliga a música de fundo",
    Callback = function()
        if _G.RD4X_MusicaFundo.IsPlaying then
            _G.RD4X_MusicaFundo:Pause()
            Notify("Música", "Música pausada", 2)
        else
            _G.RD4X_MusicaFundo:Play()
            Notify("Música", "Música tocando", 2)
        end
    end
})

--------------------------------------------------------------------------------
-- EFEITO DE CONFETE
--------------------------------------------------------------------------------
local function soltarConfete()
    if not ScreenGui or not ScreenGui.Parent then return end
    local cores = {
        Color3.fromRGB(46, 204, 113),
        Color3.fromRGB(52, 152, 219),
        Color3.fromRGB(241, 196, 15),
        Color3.fromRGB(231, 76, 60),
        Color3.fromRGB(155, 89, 182),
    }
    for i = 1, 30 do
        task.spawn(function()
            local p = Instance.new("Frame", ScreenGui)
            p.Size = UDim2.new(0, 8, 0, 8)
            p.Position = UDim2.new(math.random(), 0, 0, -20)
            p.BackgroundColor3 = cores[math.random(1, #cores)]
            p.BorderSizePixel = 0
            p.ZIndex = 9998
            Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
            local duracao = math.random(15, 25) / 10
            TweenService:Create(p, TweenInfo.new(duracao, Enum.EasingStyle.Linear), {
                Position = UDim2.new(p.Position.X.Scale, 0, 1.2, 0),
                Rotation = math.random(-360, 360)
            }):Play()
            task.delay(duracao, function() if p and p.Parent then p:Destroy() end end)
        end)
        task.wait(0.03)
    end
end
_G.RD4X_SoltarConfete = soltarConfete

--------------------------------------------------------------------------------
-- BIO WELCOME
--------------------------------------------------------------------------------
UI.Button(Tabs.Player, {
    Name = "📝 Aplicar Bio (Welcome)",
    Description = "Aplica a bio automática",
    Callback = function()
        local textoBio = "Welcome, " .. LocalPlayer.Name
        pcall(function()
            local remote = ReplicatedStorage:FindFirstChild("RE") and ReplicatedStorage.RE:FindFirstChild("1RPNam1eTex1t")
            if remote then
                remote:FireServer("RolePlayBio", textoBio)
                Notify("Bio", "Alterada: " .. textoBio, 3)
            end
        end)
    end
})

--------------------------------------------------------------------------------
-- SEGUNDO MENU VIP/ADMIN (MANTIDO SEM MEXER)
--------------------------------------------------------------------------------
local UsuarioAutorizado = true
if UsuarioAutorizado or _G.RD4X_Autorizado == nil then
    local MEU_ID_CREATOR = 4200878493
    local API_URL = "https://aidhmfv7af.apps.bot-hosting.cloud"

    local oldVIPGui = CoreGui:FindFirstChild("Rd4XHubVIP")
    if oldVIPGui then oldVIPGui:Destroy() end

    local ScreenGuiVIP = Instance.new("ScreenGui")
    ScreenGuiVIP.Name = "Rd4XHubVIP"
    ScreenGuiVIP.ResetOnSpawn = false
    ScreenGuiVIP.DisplayOrder = 1000
    ScreenGuiVIP.Parent = CoreGui

    local MainFrameVIP = Instance.new("Frame", ScreenGuiVIP)
    MainFrameVIP.Name = "MainFrameVIP"
    MainFrameVIP.Size = UDim2.new(0, 480, 0, 340)
    MainFrameVIP.Position = UDim2.new(0.5, -240, 0.5, -170)
    MainFrameVIP.BackgroundColor3 = COR_FUNDO
    MainFrameVIP.BackgroundTransparency = TRANSP_FUNDO
    MainFrameVIP.BorderSizePixel = 0
    MainFrameVIP.ClipsDescendants = true
    MainFrameVIP.ZIndex = 1
    MainFrameVIP.Visible = false
    MainFrameVIP.Active = false

    Instance.new("UICorner", MainFrameVIP).CornerRadius = UDim.new(0, 10)

    local BolhasVIP = Instance.new("Frame", MainFrameVIP)
    BolhasVIP.Name = "BolhasVIP"
    BolhasVIP.Size = UDim2.new(1, 0, 1, 0)
    BolhasVIP.BackgroundTransparency = 1
    BolhasVIP.ClipsDescendants = true
    BolhasVIP.ZIndex = 0
    BolhasVIP.Active = false

    task.spawn(function()
        while BolhasVIP.Parent do
            local tam = math.random(6, 14)
            local b = Instance.new("Frame", BolhasVIP)
            b.Size = UDim2.new(0, tam, 0, tam)
            b.Position = UDim2.new(math.random() * 0.95, 0, 1, 10)
            local cores = {
                Color3.fromRGB(46, 204, 113),
                Color3.fromRGB(52, 152, 219),
                Color3.fromRGB(155, 89, 182),
                Color3.fromRGB(241, 196, 15),
                Color3.fromRGB(231, 76, 60),
            }
            b.BackgroundColor3 = cores[math.random(1, #cores)]
            b.BackgroundTransparency = math.random(15, 40) / 100
            b.BorderSizePixel = 0
            b.ZIndex = 0
            Instance.new("UICorner", b).CornerRadius = UDim.new(1, 0)
            local strokeB = Instance.new("UIStroke", b)
            strokeB.Color = Color3.fromRGB(255, 255, 255)
            strokeB.Thickness = 1.5
            strokeB.Transparency = 0.3
            local tween = TweenService:Create(b, TweenInfo.new(math.random(6, 12), Enum.EasingStyle.Linear), {
                Position = UDim2.new(b.Position.X.Scale, math.random(-60, 60), 0, -20),
                BackgroundTransparency = 1
            })
            tween:Play()
            tween.Completed:Connect(function() if b and b.Parent then b:Destroy() end end)
            task.wait(math.random(8, 30) / 100)
        end
    end)

    local HeaderVIP = Instance.new("Frame", MainFrameVIP)
    HeaderVIP.Size = UDim2.new(1, 0, 0, 38)
    HeaderVIP.BackgroundTransparency = 1
    HeaderVIP.ZIndex = 5

    local IconVIP = Instance.new("ImageLabel", HeaderVIP)
    IconVIP.Size = UDim2.new(0, 24, 0, 24)
    IconVIP.Position = UDim2.new(0, 10, 0, 7)
    IconVIP.BackgroundTransparency = 1
    IconVIP.Image = "rbxassetid://109276734890323"
    IconVIP.ScaleType = Enum.ScaleType.Crop
    IconVIP.ZIndex = 6
    Instance.new("UICorner", IconVIP).CornerRadius = UDim.new(1, 0)

    local TitleVIP = Instance.new("TextLabel", HeaderVIP)
    TitleVIP.Size = UDim2.new(0, 300, 0, 38)
    TitleVIP.Position = UDim2.new(0, 34, 0, 0)
    TitleVIP.BackgroundTransparency = 1
    TitleVIP.Text = "🔒 Rd4X Hub VIP $ 「 Exclusivo 」"
    TitleVIP.TextColor3 = COR_VERDE
    TitleVIP.TextSize = 11
    TitleVIP.Font = Enum.Font.GothamBold
    TitleVIP.TextXAlignment = Enum.TextXAlignment.Left
    TitleVIP.ZIndex = 6

    local BadgeVIP = Instance.new("TextLabel", HeaderVIP)
    BadgeVIP.Size = UDim2.new(0, 60, 0, 38)
    BadgeVIP.Position = UDim2.new(1, -90, 0, 0)
    BadgeVIP.BackgroundTransparency = 1
    BadgeVIP.Text = "⭐ VIP"
    BadgeVIP.TextColor3 = COR_VERDE
    BadgeVIP.TextSize = 10
    BadgeVIP.Font = Enum.Font.GothamBold
    BadgeVIP.TextXAlignment = Enum.TextXAlignment.Right
    BadgeVIP.ZIndex = 6

    local MinimizeVIP = Instance.new("TextButton", HeaderVIP)
    MinimizeVIP.Size = UDim2.new(0, 20, 0, 20)
    MinimizeVIP.Position = UDim2.new(1, -26, 0, 9)
    MinimizeVIP.BackgroundTransparency = 1
    MinimizeVIP.Text = "—"
    MinimizeVIP.TextColor3 = COR_TEXTO_CINZA
    MinimizeVIP.TextSize = 14
    MinimizeVIP.Font = Enum.Font.GothamBold
    MinimizeVIP.ZIndex = 6
    MinimizeVIP.AutoButtonColor = false

    MinimizeVIP.MouseEnter:Connect(function() MinimizeVIP.TextColor3 = COR_TEXTO end)
    MinimizeVIP.MouseLeave:Connect(function() MinimizeVIP.TextColor3 = COR_TEXTO_CINZA end)

    local SidebarVIP = Instance.new("ScrollingFrame", MainFrameVIP)
    SidebarVIP.Size = UDim2.new(0, 130, 1, -38)
    SidebarVIP.Position = UDim2.new(0, 0, 0, 38)
    SidebarVIP.BackgroundColor3 = COR_SIDEBAR
    SidebarVIP.BackgroundTransparency = TRANSP_SIDEBAR
    SidebarVIP.BorderSizePixel = 0
    SidebarVIP.ScrollBarThickness = 2
    SidebarVIP.CanvasSize = UDim2.new(0, 0, 0, 0)
    SidebarVIP.AutomaticCanvasSize = Enum.AutomaticSize.Y
    SidebarVIP.ZIndex = 5

    local layoutVIP = Instance.new("UIListLayout", SidebarVIP)
    layoutVIP.Padding = UDim.new(0, 3)
    layoutVIP.SortOrder = Enum.SortOrder.LayoutOrder

    local padVIP = Instance.new("UIPadding", SidebarVIP)
    padVIP.PaddingTop = UDim.new(0, 6)
    padVIP.PaddingBottom = UDim.new(0, 6)
    padVIP.PaddingLeft = UDim.new(0, 6)
    padVIP.PaddingRight = UDim.new(0, 6)

    local TabFramesVIP = {}
    local TabButtonsVIP = {}

    local function ShowTabVIP(name)
        for n, f in pairs(TabFramesVIP) do f.Visible = (n == name) end
        for n, b in pairs(TabButtonsVIP) do
            if n == name then
                b.BackgroundTransparency = TRANSP_CARDS
                b.TextColor3 = COR_TEXTO
            else
                b.BackgroundTransparency = 1
                b.TextColor3 = COR_TEXTO_CINZA
            end
        end
    end

    local function CreateTabVIP(name)
        local btn = Instance.new("TextButton", SidebarVIP)
        btn.Size = UDim2.new(1, 0, 0, 26)
        btn.BackgroundColor3 = COR_SECUNDARIA
        btn.BackgroundTransparency = 1
        btn.BorderSizePixel = 0
        btn.Text = "   " .. name
        btn.TextColor3 = COR_TEXTO_CINZA
        btn.TextSize = 10
        btn.Font = Enum.Font.GothamMedium
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.AutoButtonColor = false
        btn.ZIndex = 6
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

        local content = Instance.new("ScrollingFrame", MainFrameVIP)
        content.Size = UDim2.new(1, -142, 1, -50)
        content.Position = UDim2.new(0, 136, 0, 44)
        content.BackgroundTransparency = 1
        content.BorderSizePixel = 0
        content.ScrollBarThickness = 3
        content.ScrollBarImageColor3 = COR_BORDA
        content.CanvasSize = UDim2.new(0, 0, 0, 0)
        content.AutomaticCanvasSize = Enum.AutomaticSize.Y
        content.Visible = false
        content.ZIndex = 5

        local layout = Instance.new("UIListLayout", content)
        layout.Padding = UDim.new(0, 6)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        TabFramesVIP[name] = content
        TabButtonsVIP[name] = btn

        btn.MouseButton1Click:Connect(function() ShowTabVIP(name) end)
        return content
    end

    local TabsVIP = {
        Admin = CreateTabVIP("👑 Admin"),
        VIP = CreateTabVIP("VIP"),
        Jumpscare = CreateTabVIP("Jumpscare"),
    }
    ShowTabVIP("👑 Admin")

    local dragVIP = false
    local startVIP = nil
    local posVIP = nil

    MainFrameVIP.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragVIP = true
            startVIP = input.Position
            posVIP = MainFrameVIP.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragVIP = false end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragVIP and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startVIP
            MainFrameVIP.Position = UDim2.new(posVIP.X.Scale, posVIP.X.Offset + delta.X, posVIP.Y.Scale, posVIP.Y.Offset + delta.Y)
        end
    end)

    local vipMinimizado = false
    local alturaVIPNormal = 340
    local alturaVIPMinimizada = 38

    MinimizeVIP.MouseButton1Click:Connect(function()
        vipMinimizado = not vipMinimizado
        if vipMinimizado then
            TweenService:Create(MainFrameVIP, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 480, 0, alturaVIPMinimizada)
            }):Play()
            SidebarVIP.Visible = false
            for _, c in pairs(TabFramesVIP) do c.Visible = false end
            MinimizeVIP.Text = "▢"
            MinimizeVIP.TextColor3 = COR_VERDE
        else
            TweenService:Create(MainFrameVIP, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 480, 0, alturaVIPNormal)
            }):Play()
            task.wait(0.35)
            SidebarVIP.Visible = true
            for n, c in pairs(TabFramesVIP) do
                if TabButtonsVIP[n].TextColor3 == COR_TEXTO then c.Visible = true end
            end
            MinimizeVIP.Text = "—"
            MinimizeVIP.TextColor3 = COR_TEXTO_CINZA
        end
    end)

    local AlvoSelecionado = LocalPlayer.Name
    local JaulaModelo = nil
    local conexaoSpam = nil

    local function obterUsuariosDoHub()
        local lista = {}
        for _, p in ipairs(Players:GetPlayers()) do
            table.insert(lista, p.Name)
        end
        if #lista == 0 then table.insert(lista, LocalPlayer.Name) end
        return lista
    end

    local DropdownAdmin = UI.Dropdown(TabsVIP.Admin, {
        Name = "Lista de Jogadores",
        Options = obterUsuariosDoHub(),
        CurrentOption = {LocalPlayer.Name},
        Callback = function(Option) AlvoSelecionado = Option[1] end,
    })

    UI.Button(TabsVIP.Admin, {
        Name = "🔄 Atualizar Hub (Lista)",
        Description = "Atualiza a lista de jogadores",
        Callback = function()
            DropdownAdmin:Refresh(obterUsuariosDoHub())
            Notify("Admin", "Lista atualizada!", 3)
        end
    })

    local cameraOriginalCFrame = nil
    UI.Button(TabsVIP.Admin, {
        Name = "Cam (ver câmera)",
        Description = "Espia o jogador selecionado",
        Callback = function()
            local alvo = Players:FindFirstChild(AlvoSelecionado)
            if alvo and alvo.Character and alvo.Character:FindFirstChild("Humanoid") then
                cameraOriginalCFrame = Camera.CFrame
                Camera.CameraSubject = alvo.Character.Humanoid
                Notify("Admin", "Assistindo " .. alvo.Name, 2)
            end
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "Voltar Cam",
        Description = "Volta a câmera para você",
        Callback = function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = LocalPlayer.Character.Humanoid
                if cameraOriginalCFrame then Camera.CFrame = cameraOriginalCFrame end
                Notify("Admin", "Câmera restaurada.", 2)
            end
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "Kick",
        Description = "Expulsa o jogador local se selecionado",
        Callback = function()
            local alvo = Players:FindFirstChild(AlvoSelecionado)
            if alvo == LocalPlayer then LocalPlayer:Kick("Kickado") end
            Notify("Admin", "Kick enviado.", 2)
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "Kill",
        Description = "Mata o jogador localmente",
        Callback = function()
            local alvo = Players:FindFirstChild(AlvoSelecionado)
            if alvo and alvo.Character and alvo.Character:FindFirstChild("Humanoid") then
                alvo.Character.Humanoid.Health = 0
                Notify("Admin", "Kill executado.", 2)
            end
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "Freeze",
        Description = "Congela o jogador",
        Callback = function()
            local alvo = Players:FindFirstChild(AlvoSelecionado)
            if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                alvo.Character.HumanoidRootPart.Anchored = true
                Notify("Admin", "Congelado.", 2)
            end
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "Unfreeze",
        Description = "Descongela o jogador",
        Callback = function()
            local alvo = Players:FindFirstChild(AlvoSelecionado)
            if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                alvo.Character.HumanoidRootPart.Anchored = false
                Notify("Admin", "Descongelado.", 2)
            end
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "Jail",
        Description = "Prende o jogador em uma jaula",
        Callback = function()
            local alvo = Players:FindFirstChild(AlvoSelecionado)
            if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                if JaulaModelo then JaulaModelo:Destroy() end
                JaulaModelo = Instance.new("Model", Workspace)
                JaulaModelo.Name = "RD4X_JailBox"
                local pos = alvo.Character.HumanoidRootPart.Position
                local function criarParede(tam, pst)
                    local p = Instance.new("Part", JaulaModelo)
                    p.Size = tam; p.Position = pst; p.Anchored = true
                    p.CanCollide = true; p.Transparency = 0.4; p.Color = COR_VERMELHO
                end
                criarParede(Vector3.new(8, 1, 8), pos + Vector3.new(0, -4, 0))
                criarParede(Vector3.new(8, 1, 8), pos + Vector3.new(0, 4, 0))
                criarParede(Vector3.new(8, 8, 1), pos + Vector3.new(0, 0, -4))
                criarParede(Vector3.new(8, 8, 1), pos + Vector3.new(0, 0, 4))
                criarParede(Vector3.new(1, 8, 8), pos + Vector3.new(-4, 0, 0))
                criarParede(Vector3.new(1, 8, 8), pos + Vector3.new(4, 0, 0))
                Notify("Admin", "Jaula aplicada!", 2)
            end
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "UnJail",
        Description = "Remove a jaula",
        Callback = function()
            if JaulaModelo then JaulaModelo:Destroy(); JaulaModelo = nil end
            Notify("Admin", "Jaula removida!", 2)
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "Bring",
        Description = "Traz o jogador até você",
        Callback = function()
            local alvo = Players:FindFirstChild(AlvoSelecionado)
            if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                alvo.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                Notify("Admin", "Jogador trazido.", 2)
            end
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "Teleport",
        Description = "Vai até o jogador",
        Callback = function()
            local alvo = Players:FindFirstChild(AlvoSelecionado)
            if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = alvo.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                Notify("Admin", "Teleportado.", 2)
            end
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "Fling",
        Description = "Arremessa o jogador",
        Callback = function()
            local alvo = Players:FindFirstChild(AlvoSelecionado)
            if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                alvo.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(99999, 99999, 99999)
                Notify("Admin", "Fling aplicado!", 2)
            end
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "Spam",
        Description = "Ativa o spam de chat",
        Callback = function()
            if conexaoSpam then task.cancel(conexaoSpam) end
            conexaoSpam = task.spawn(function()
                while true do
                    pcall(function()
                        local targs = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents")
                        if targs then
                            local say = targs:FindFirstChild("SayMessageRequest")
                            if say then say:FireServer("RD4X HAHAHA", "All") end
                        end
                    end)
                    task.wait(1)
                end
            end)
            Notify("Admin", "Spam ativado!", 2)
        end
    })

    UI.Button(TabsVIP.Admin, {
        Name = "UnSpam",
        Description = "Desativa o spam de chat",
        Callback = function()
            if conexaoSpam then task.cancel(conexaoSpam); conexaoSpam = nil end
            Notify("Admin", "Spam desativado.", 2)
        end
    })

    -- JUMPSCARE
    local LISTA_JUMPSCARES = {
        ["Jumpscare 1"] = { imagem = "rbxassetid://83706098778583", som = "rbxassetid://130586258888902" },
        ["😱 Jumpscare 2"] = { imagem = "rbxassetid://125557150437761", som = "rbxassetid://133973334152130" },
        ["Jumpscare 3"] = { imagem = "rbxassetid://117625655704744", som = "rbxassetid://140558918020400" },
        ["?? Jumpscare 4"] = { imagem = "rbxassetid://106883295632038", som = "rbxassetid://130586258888902" },
        ["🔴 Jumpscare 5"] = { imagem = "rbxassetid://105916553275189", som = "rbxassetid://140558918020400" },
    }

    local function obterNomesJumpscare()
        local nomes = {}
        for nome, _ in pairs(LISTA_JUMPSCARES) do table.insert(nomes, nome) end
        table.sort(nomes)
        return nomes
    end

    local function executarJumpscare(nomeAlvo, nomeJumpscare)
        local alvo = Players:FindFirstChild(nomeAlvo)
        if not alvo then Notify("Jumpscare", "Alvo não encontrado!", 2); return end
        local pg = alvo:FindFirstChild("PlayerGui")
        if not pg then return end
        local dados = LISTA_JUMPSCARES[nomeJumpscare]
        if not dados then Notify("Jumpscare", "Jumpscare inválido!", 2); return end

        pcall(function()
            local som = Instance.new("Sound", SoundService)
            som.SoundId = dados.som; som.Volume = 5; som:Play()
            task.delay(3, function() if som and som.Parent then som:Destroy() end end)
        end)

        local sgJump = Instance.new("ScreenGui", pg)
        sgJump.Name = "RD4X_JumpScare"; sgJump.IgnoreGuiInset = true; sgJump.DisplayOrder = 99999
        local flash = Instance.new("Frame", sgJump)
        flash.Size = UDim2.new(1, 0, 1, 0)
        flash.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        flash.BackgroundTransparency = 0; flash.BorderSizePixel = 0

        local cara = Instance.new("ImageLabel", sgJump)
        cara.Size = UDim2.new(0.3, 0, 0.3, 0)
        cara.Position = UDim2.new(0.35, 0, 0.35, 0)
        cara.BackgroundTransparency = 1; cara.Image = dados.imagem
        cara.ScaleType = Enum.ScaleType.Fit; cara.ImageTransparency = 0

        task.spawn(function()
            TweenService:Create(cara, TweenInfo.new(0.15, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
                Size = UDim2.new(1.5, 0, 1.5, 0), Position = UDim2.new(-0.25, 0, -0.25, 0)
            }):Play()
            local blur = Instance.new("BlurEffect", Lighting)
            blur.Size = 0
            TweenService:Create(blur, TweenInfo.new(0.1), {Size = 24}):Play()
            for i = 1, 6 do
                TweenService:Create(flash, TweenInfo.new(0.05), {BackgroundTransparency = 0}):Play()
                task.wait(0.05)
                TweenService:Create(flash, TweenInfo.new(0.05), {BackgroundTransparency = 0.6}):Play()
                task.wait(0.05)
            end
            if alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = alvo.Character.HumanoidRootPart
                local offsetOriginal = hrp.CFrame
                task.spawn(function()
                    for i = 1, 10 do
                        hrp.CFrame = offsetOriginal * CFrame.new(math.random(-30, 30) / 100, math.random(-30, 30) / 100, 0)
                        task.wait(0.02)
                    end
                    hrp.CFrame = offsetOriginal
                end)
            end
            task.wait(2.5)
            TweenService:Create(cara, TweenInfo.new(0.3), {ImageTransparency = 1}):Play()
            TweenService:Create(blur, TweenInfo.new(0.3), {Size = 0}):Play()
            TweenService:Create(flash, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            task.wait(0.4)
            if blur and blur.Parent then blur:Destroy() end
            if sgJump and sgJump.Parent then sgJump:Destroy() end
        end)
    end

    UI.Paragraph(TabsVIP.Jumpscare, {
        Title = "😱 Sistema de Jumpscare",
        Content = "Escolha um jumpscare da lista e envie pro alvo.",
        Height = 42
    })

    local jumpscareSelecionado = nil
    local nomesJumpscare = obterNomesJumpscare()
    if #nomesJumpscare > 0 then jumpscareSelecionado = nomesJumpscare[1] end

    UI.Dropdown(TabsVIP.Jumpscare, {
        Name = "😱 Escolha o Jumpscare",
        Options = nomesJumpscare,
        CurrentOption = {jumpscareSelecionado or "Nenhum"},
        Callback = function(opt) if opt and opt[1] then jumpscareSelecionado = opt[1] end end,
    })

    UI.Button(TabsVIP.Jumpscare, {
        Name = "😱 Ativar Jumpscare no Alvo",
        Description = "Assusta o jogador selecionado",
        Callback = function()
            if not AlvoSelecionado then Notify("Jumpscare", "Selecione um alvo na aba Admin!", 2); return end
            if not jumpscareSelecionado then Notify("Jumpscare", "Escolha um jumpscare!", 2); return end
            executarJumpscare(AlvoSelecionado, jumpscareSelecionado)
            Notify("😱 Jumpscare", "Susto em " .. AlvoSelecionado, 3)
        end
    })

    UI.Button(TabsVIP.Jumpscare, {
        Name = "😱 Jumpscare em TODOS os Jogadores",
        Description = "Assusta todos no servidor",
        Callback = function()
            if not jumpscareSelecionado then Notify("Jumpscare", "Escolha um jumpscare!", 2); return end
            local enviados = 0
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    executarJumpscare(p.Name, jumpscareSelecionado)
                    enviados = enviados + 1
                    task.wait(0.3)
                end
            end
            Notify("😱 Jumpscare", "Susto em " .. enviados .. " jogadores!", 3)
        end
    })

    task.spawn(function()
        local tempoEspera = 0
        while not _G.RD4X_Loading_Completo and tempoEspera < 10 do
            task.wait(0.1)
            tempoEspera = tempoEspera + 0.1
        end
        task.wait(0.3)
        MainFrameVIP.Visible = true
        MainFrameVIP.Size = UDim2.new(0, 0, 0, 0)
        MainFrameVIP.Position = UDim2.new(0.5, 0, 0.5, 0)
        MainFrameVIP.BackgroundTransparency = 1
        TweenService:Create(MainFrameVIP, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 480, 0, 340),
            Position = UDim2.new(0.5, -240, 0.5, -170),
            BackgroundTransparency = TRANSP_FUNDO
        }):Play()
    end)
end
