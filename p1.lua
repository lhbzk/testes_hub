local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TeleportService = game:GetService("TeleportService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local SoundService = game:GetService("SoundService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--COMPATIBILIDADE BROOKHAVEN
local BROOKHAVEN_PLACE_ID = 4924922222
local BROOKHAVEN_UNIVERSE_ID = 1686885941

local jogoCompativel =
    game.PlaceId == BROOKHAVEN_PLACE_ID
    or game.GameId == BROOKHAVEN_UNIVERSE_ID

if not jogoCompativel then
    _G.RD4X_Incompativel = true -- Avisa o loader para não carregar as outras partes

    -- RD4X | Tela de incompatibilidade minimalista
    local incompatGui = Instance.new("ScreenGui")
    incompatGui.Name = "RD4X_Incompatible"
    incompatGui.IgnoreGuiInset = true
    incompatGui.ResetOnSpawn = false
    incompatGui.DisplayOrder = 999999
    
    -- Correção: Tenta usar gethui() (bypassa proteção do CoreGui em executores)
    -- Se falhar, joga no PlayerGui.
    local parentGui
    pcall(function()
        parentGui = (gethui and gethui()) or CoreGui
        incompatGui.Parent = parentGui
    end)
    
    if not incompatGui.Parent then
        incompatGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    end

    local function criar(class, props, target)
        local obj = Instance.new(class)
        for k, v in pairs(props or {}) do
            obj[k] = v
        end
        obj.Parent = target
        return obj
    end

    local function animar(obj, tempo, props)
        local t = TweenService:Create(
            obj,
            TweenInfo.new(tempo, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            props
        )
        t:Play()
        return t
    end

    local FUNDO = Color3.fromRGB(13, 13, 17)
    local CARD = Color3.fromRGB(23, 23, 29)
    local BORDA = Color3.fromRGB(48, 46, 53)
    local TEXTO = Color3.fromRGB(238, 236, 239)
    local CINZA = Color3.fromRGB(151, 148, 157)
    local VINHO = Color3.fromRGB(126, 42, 61)

    local bg = criar("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = FUNDO,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }, incompatGui)

    local card = criar("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.53),
        Size = UDim2.fromOffset(340, 250),
        BackgroundColor3 = CARD,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    }, bg)
    criar("UICorner", {CornerRadius = UDim.new(0, 13)}, card)
    criar("UIStroke", {
        Color = BORDA,
        Thickness = 1,
        Transparency = 0.15
    }, card)

    local logo = criar("ImageLabel", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 25),
        Size = UDim2.fromOffset(48, 48),
        BackgroundTransparency = 1,
        Image = "rbxassetid://109276734890323",
        ScaleType = Enum.ScaleType.Crop
    }, card)
    criar("UICorner", {CornerRadius = UDim.new(1, 0)}, logo)

    criar("TextLabel", {
        Position = UDim2.new(0, 20, 0, 83),
        Size = UDim2.new(1, -40, 0, 25),
        BackgroundTransparency = 1,
        Text = "RD4X HUB",
        TextColor3 = TEXTO,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center
    }, card)

    criar("Frame", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 119),
        Size = UDim2.fromOffset(34, 2),
        BackgroundColor3 = VINHO,
        BorderSizePixel = 0
    }, card)

    criar("TextLabel", {
        Position = UDim2.new(0, 20, 0, 135),
        Size = UDim2.new(1, -40, 0, 22),
        BackgroundTransparency = 1,
        Text = "Jogo não suportado",
        TextColor3 = TEXTO,
        TextSize = 14,
        Font = Enum.Font.GothamSemibold,
        TextXAlignment = Enum.TextXAlignment.Center
    }, card)

    criar("TextLabel", {
        Position = UDim2.new(0, 27, 0, 163),
        Size = UDim2.new(1, -54, 0, 39),
        BackgroundTransparency = 1,
        Text = "O RD4X Hub ainda não oferece suporte\npara esta experiência",
        TextColor3 = CINZA,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Center
    }, card)

    local button = criar("TextButton", {
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 211),
        Size = UDim2.fromOffset(112, 27),
        BackgroundColor3 = Color3.fromRGB(37, 35, 41),
        BorderSizePixel = 0,
        Text = "Entendi",
        TextColor3 = TEXTO,
        TextSize = 11,
        Font = Enum.Font.GothamSemibold,
        AutoButtonColor = false
    }, card)
    criar("UICorner", {CornerRadius = UDim.new(0, 7)}, button)
    criar("UIStroke", {
        Color = BORDA,
        Thickness = 1,
        Transparency = 0.25
    }, button)

    button.MouseEnter:Connect(function()
        animar(button, 0.15, {BackgroundColor3 = Color3.fromRGB(48, 44, 51)})
    end)
    button.MouseLeave:Connect(function()
        animar(button, 0.15, {BackgroundColor3 = Color3.fromRGB(37, 35, 41)})
    end)

    bg.BackgroundTransparency = 1
    card.Position = UDim2.fromScale(0.5, 0.55)

    animar(bg, 0.25, {BackgroundTransparency = 0})
    animar(card, 0.3, {
        BackgroundTransparency = 0,
        Position = UDim2.fromScale(0.5, 0.5)
    })

    local fechando = false
    local function fechar()
        if fechando then return end
        fechando = true
        animar(card, 0.2, {
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0.5, 0.53)
        })
        animar(bg, 0.2, {BackgroundTransparency = 1})
        task.wait(0.23)
        if incompatGui.Parent then
            incompatGui:Destroy()
        end
    end

    button.MouseButton1Click:Connect(fechar)

    -- Não permite que o restante do hub seja executado
    return
end

-- PARENT DA INTERFACE | COMPATIBILIDADE COM EXECUTORES
local function DefinirParentGui(gui)
    local pais = {}

    if type(gethui) == "function" then
        local sucesso, hui = pcall(gethui)
        if sucesso and hui then
            table.insert(pais, hui)
        end
    end

    table.insert(pais, CoreGui)
    table.insert(pais, LocalPlayer:WaitForChild("PlayerGui"))

    for _, parent in ipairs(pais) do
        local sucesso = pcall(function()
            gui.Parent = parent
        end)

        if sucesso and gui.Parent == parent then
            return parent
        end
    end

    error("[RD4X] Não foi possível definir o parent da interface")
end

--Confirmado o placeid:
-- (Daqui pra baixo continua o resto normal do seu código original, MEU_ID_CREATOR, UI, etc...)

--Confirmado o placeid:


local MEU_ID_CREATOR = 4200878493
local API_URL = "https://aidhmfv7af.apps.bot-hosting.cloud"

local function VerificarWhitelist()
    if LocalPlayer.UserId == MEU_ID_CREATOR then return true end
    local sucesso, resposta = pcall(function()
        local urlReq = API_URL .. "/api/v2/whitelist?nick=" .. tostring(LocalPlayer.Name)
        local rawData = game:HttpGet(urlReq)
        return HttpService:JSONDecode(rawData)
    end)
    if sucesso and resposta and (resposta.success == true or resposta.whitelisted == true) then
        return true
    end
    return false
end

local UsuarioAutorizado = true
-- local UsuarioAutorizado = VerificarWhitelist()

local TabFrames = {}
local TabButtons = {}

_G.RD4X_NotifAtivas       = true
_G.RD4X_SomAtivo          = true
_G.RD4X_Loading_Completo  = false
_G.RD4X_BolhasAtivas      = true
_G.RD4X_BordaPulsando     = true

local COR_FUNDO      = Color3.fromRGB(18, 18, 22)
local COR_SIDEBAR    = Color3.fromRGB(22, 22, 26)
local COR_SECUNDARIA = Color3.fromRGB(28, 28, 34)
local COR_TEXTO      = Color3.fromRGB(240, 240, 245)
local COR_TEXTO_CINZA= Color3.fromRGB(140, 140, 150)
local COR_VERDE      = Color3.fromRGB(46, 204, 113)
local COR_BORDA      = Color3.fromRGB(40, 40, 48)
local COR_VERMELHO   = Color3.fromRGB(220, 20, 60) -- Cor Hub

local TRANSP_FUNDO       = 0.25
local TRANSP_SIDEBAR     = 0.35
local TRANSP_CARDS       = 0.45
local TRANSP_INPUT       = 0.55
local TRANSP_BOTAO_VERDE = 0.35

_G.RD4X_COR_FUNDO = COR_FUNDO
_G.RD4X_COR_SIDEBAR = COR_SIDEBAR
_G.RD4X_COR_SECUNDARIA = COR_SECUNDARIA
_G.RD4X_COR_TEXTO = COR_TEXTO
_G.RD4X_COR_TEXTO_CINZA = COR_TEXTO_CINZA
_G.RD4X_COR_VERDE = COR_VERDE
_G.RD4X_COR_BORDA = COR_BORDA
_G.RD4X_COR_VERMELHO = COR_VERMELHO
_G.RD4X_TRANSP_FUNDO = TRANSP_FUNDO
_G.RD4X_TRANSP_SIDEBAR = TRANSP_SIDEBAR
_G.RD4X_TRANSP_CARDS = TRANSP_CARDS
_G.RD4X_TRANSP_INPUT = TRANSP_INPUT
_G.RD4X_TRANSP_BOTAO_VERDE = TRANSP_BOTAO_VERDE

-- cleanUp

local oldGui = CoreGui:FindFirstChild("Rd4XHubOficial")
if oldGui then oldGui:Destroy() end
if CoreGui:FindFirstChild("RD4X_Loading") then
    CoreGui.RD4X_Loading:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Rd4XHubOficial"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 999

DefinirParentGui(ScreenGui)

_G.RD4X_ScreenGui = ScreenGui

--Botão flutuante

local BotaoFlutuante = Instance.new("ImageButton", ScreenGui)
BotaoFlutuante.Name = "BotaoFlutuanteRD4X"
BotaoFlutuante.Size = UDim2.new(0, 46, 0, 46)
BotaoFlutuante.Position = UDim2.new(0, 20, 0.5, -23)
BotaoFlutuante.BackgroundColor3 = COR_SECUNDARIA
BotaoFlutuante.BackgroundTransparency = 0.15
BotaoFlutuante.BorderSizePixel = 0
BotaoFlutuante.Image = "rbxassetid://109276734890323"
BotaoFlutuante.AutoButtonColor = false
BotaoFlutuante.Visible = false
BotaoFlutuante.ZIndex = 1000

local cBF = Instance.new("UICorner", BotaoFlutuante)
cBF.CornerRadius = UDim.new(1, 0)

local sBF = Instance.new("UIStroke", BotaoFlutuante)
sBF.Color = COR_VERMELHO
sBF.Thickness = 1.5

local pulsando = true
local tamanhoNormal = UDim2.new(0, 46, 0, 46)
local tamanhoPulsado = UDim2.new(0, 54, 0, 54)

task.spawn(function()
    while pulsando and BotaoFlutuante.Parent do
        TweenService:Create(BotaoFlutuante, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = tamanhoPulsado,
            Position = BotaoFlutuante.Position - UDim2.new(0, 4, 0, 4)
        }):Play()
        TweenService:Create(sBF, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0,
            Thickness = 2.5
        }):Play()
        task.wait(0.6)
        TweenService:Create(BotaoFlutuante, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Size = tamanhoNormal,
            Position = BotaoFlutuante.Position + UDim2.new(0, 4, 0, 4)
        }):Play()
        TweenService:Create(sBF, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            Transparency = 0.5,
            Thickness = 1.5
        }):Play()
        task.wait(0.6)
    end
end)

BotaoFlutuante.MouseEnter:Connect(function() pulsando = false end)

local bfDragging, bfDragStart, bfStartPos
BotaoFlutuante.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        bfDragging = true
        bfDragStart = input.Position
        bfStartPos = BotaoFlutuante.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then bfDragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if bfDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - bfDragStart
        BotaoFlutuante.Position = UDim2.new(bfStartPos.X.Scale, bfStartPos.X.Offset + delta.X, bfStartPos.Y.Scale, bfStartPos.Y.Offset + delta.Y)
    end
end)

BotaoFlutuante.MouseEnter:Connect(function()
    TweenService:Create(BotaoFlutuante, TweenInfo.new(0.15), {BackgroundTransparency = 0, Size = UDim2.new(0, 50, 0, 50), Position = BotaoFlutuante.Position - UDim2.new(0, 2, 0, 2)}):Play()
end)
BotaoFlutuante.MouseLeave:Connect(function()
    TweenService:Create(BotaoFlutuante, TweenInfo.new(0.15), {BackgroundTransparency = 0.15, Size = UDim2.new(0, 46, 0, 46)}):Play()
end)

-- Janela Principal

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 560, 0, 400)
MainFrame.Position = UDim2.new(0.5, -280, 0.5, -200)
MainFrame.BackgroundColor3 = COR_FUNDO
MainFrame.BackgroundTransparency = TRANSP_FUNDO
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 1
MainFrame.Visible = false
_G.RD4X_MainFrame = MainFrame
local cMain = Instance.new("UICorner", MainFrame)
cMain.CornerRadius = UDim.new(0, 10) -- ajuste o 10 pra gosto (8–14 fica bom)


-- TELA DE CARREGAMENTO | RD4X minimalista
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer

-- Remove uma tela anterior
pcall(function()
    local parentAntigo = gethui and gethui() or CoreGui
    local antiga = parentAntigo:FindFirstChild("RD4X_LoadingPreview")
    if antiga then antiga:Destroy() end
end)

local gui = Instance.new("ScreenGui")
gui.Name = "RD4X_LoadingPreview"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999

DefinirParentGui(gui)

local function create(class, props, parentObject)
    local obj = Instance.new(class)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parentObject
    return obj
end

local function tween(obj, tempo, props)
    local t = TweenService:Create(
        obj,
        TweenInfo.new(tempo, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        props
    )
    t:Play()
    return t
end

local FUNDO = Color3.fromRGB(13, 13, 17)
local CARD = Color3.fromRGB(23, 23, 29)
local BORDA = Color3.fromRGB(48, 46, 53)
local TEXTO = Color3.fromRGB(238, 236, 239)
local CINZA = Color3.fromRGB(151, 148, 157)
local VINHO = Color3.fromRGB(126, 42, 61)

local bg = create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = FUNDO,
    BorderSizePixel = 0
}, gui)

local content = create("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.48),
    Size = UDim2.fromOffset(350, 290),
    BackgroundColor3 = CARD,
    BorderSizePixel = 0
}, bg)
create("UICorner", {CornerRadius = UDim.new(0, 14)}, content)
create("UIStroke", {
    Color = BORDA,
    Thickness = 1,
    Transparency = 0.15
}, content)

local logo = create("ImageLabel", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 27),
    Size = UDim2.fromOffset(58, 58),
    BackgroundTransparency = 1,
    Image = "rbxassetid://109276734890323",
    ScaleType = Enum.ScaleType.Crop
}, content)
create("UICorner", {CornerRadius = UDim.new(1, 0)}, logo)

create("TextLabel", {
    Position = UDim2.new(0, 20, 0, 96),
    Size = UDim2.new(1, -40, 0, 27),
    BackgroundTransparency = 1,
    Text = "RD4X HUB",
    TextColor3 = TEXTO,
    TextSize = 19,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Center
}, content)

create("TextLabel", {
    Position = UDim2.new(0, 20, 0, 124),
    Size = UDim2.new(1, -40, 0, 18),
    BackgroundTransparency = 1,
    Text = "BROOKHAVEN RP  •  v1.0",
    TextColor3 = CINZA,
    TextSize = 10,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Center
}, content)

local status = create("TextLabel", {
    Position = UDim2.new(0, 25, 0, 174),
    Size = UDim2.new(1, -50, 0, 20),
    BackgroundTransparency = 1,
    Text = "Inicializando script...",
    TextColor3 = CINZA,
    TextSize = 11,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Left
}, content)

local percentage = create("TextLabel", {
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -25, 0, 174),
    Size = UDim2.fromOffset(45, 20),
    BackgroundTransparency = 1,
    Text = "0%",
    TextColor3 = TEXTO,
    TextSize = 10,
    Font = Enum.Font.GothamSemibold,
    TextXAlignment = Enum.TextXAlignment.Right
}, content)

local barBackground = create("Frame", {
    Position = UDim2.new(0, 25, 0, 203),
    Size = UDim2.new(1, -50, 0, 4),
    BackgroundColor3 = BORDA,
    BorderSizePixel = 0
}, content)
create("UICorner", {CornerRadius = UDim.new(1, 0)}, barBackground)

local bar = create("Frame", {
    Size = UDim2.fromScale(0, 1),
    BackgroundColor3 = VINHO,
    BorderSizePixel = 0
}, barBackground)
create("UICorner", {CornerRadius = UDim.new(1, 0)}, bar)

create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 1),
    Position = UDim2.new(0.5, 0, 1, -13),
    Size = UDim2.new(1, -30, 0, 16),
    BackgroundTransparency = 1,
    Text = "RD4X TEAM",
    TextColor3 = Color3.fromRGB(103, 100, 108),
    TextSize = 9,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Center
}, content)

-- Entrada discreta
bg.BackgroundTransparency = 1
content.BackgroundTransparency = 1
content.Position = UDim2.fromScale(0.5, 0.51)
tween(bg, 0.25, {BackgroundTransparency = 0})
tween(content, 0.3, {
    BackgroundTransparency = 0,
    Position = UDim2.fromScale(0.5, 0.48)
})

-- Mantém a duração e as etapas da tela anterior
local TEMPO_CARREGAMENTO = 8.2
local inicioCarregamento = os.clock()

local stages = {
    {0, "Inicializando script..."},
    {2, "Carregando funções..."},
    {4, "Preparando interface..."},
    {6, "Finalizando inicialização..."},
    {8.2, "RD4X iniciado!"}
}

task.spawn(function()
    while gui.Parent do
        local progresso = math.clamp(
            (os.clock() - inicioCarregamento) / TEMPO_CARREGAMENTO,
            0,
            1
        )
        bar.Size = UDim2.fromScale(progresso, 1)
        percentage.Text = math.floor(progresso * 100) .. "%"
        if progresso >= 1 then break end
        task.wait(0.03)
    end
end)

for _, stage in ipairs(stages) do
    local restante = stage[1] - (os.clock() - inicioCarregamento)
    if restante > 0 then task.wait(restante) end
    if not gui.Parent then return end
    status.Text = stage[2]
end

percentage.Text = "100%"
bar.Size = UDim2.fromScale(1, 1)

local enter = create("TextButton", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 232),
    Size = UDim2.fromOffset(132, 31),
    BackgroundColor3 = Color3.fromRGB(37, 35, 41),
    BorderSizePixel = 0,
    Text = "Abrir hub",
    TextColor3 = TEXTO,
    TextSize = 11,
    Font = Enum.Font.GothamSemibold,
    AutoButtonColor = false
}, content)
create("UICorner", {CornerRadius = UDim.new(0, 7)}, enter)
create("UIStroke", {
    Color = BORDA,
    Thickness = 1,
    Transparency = 0.2
}, enter)

enter.MouseEnter:Connect(function()
    tween(enter, 0.15, {BackgroundColor3 = Color3.fromRGB(49, 45, 53)})
end)
enter.MouseLeave:Connect(function()
    tween(enter, 0.15, {BackgroundColor3 = Color3.fromRGB(37, 35, 41)})
end)

local abrindo = false
enter.MouseButton1Click:Connect(function()
    if abrindo then return end
    abrindo = true

    tween(content, 0.22, {
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.51)
    })
    tween(bg, 0.22, {BackgroundTransparency = 1})
    task.wait(0.25)

    if gui.Parent then gui:Destroy() end

    -- MOSTRAR O MENU PRINCIPAL (mantido do código original)
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.BackgroundTransparency = 1

    tween(MainFrame, 0.5, {
        Size = UDim2.new(0, 560, 0, 400),
        Position = UDim2.new(0.5, -280, 0.5, -200),
        BackgroundTransparency = TRANSP_FUNDO
    })
end)

-- Bolhas
local BolhasContainer = Instance.new("Frame", MainFrame)
BolhasContainer.Name = "BolhasContainer"
BolhasContainer.Size = UDim2.new(1, 0, 1, 0)
BolhasContainer.BackgroundTransparency = 0.5
BolhasContainer.ClipsDescendants = true
BolhasContainer.ZIndex = 0
BolhasContainer.Active = false
_G.RD4X_BolhasContainer = BolhasContainer

local function criarBolha()
    if not _G.RD4X_BolhasAtivas or not BolhasContainer.Parent then return end
    local tam = math.random(6, 14)
    local bolha = Instance.new("Frame", BolhasContainer)
    bolha.Size = UDim2.new(0, tam, 0, tam)
    bolha.Position = UDim2.new(math.random() * 0.95, 0, 1, 10)
    local cores = {COR_VERMELHO, Color3.fromRGB(150, 0, 0), Color3.fromRGB(255, 100, 100)}
    bolha.BackgroundColor3 = cores[math.random(1, #cores)]
    bolha.BackgroundTransparency = math.random(15, 40) / 100
    bolha.BorderSizePixel = 0
    bolha.ZIndex = 0
    Instance.new("UICorner", bolha).CornerRadius = UDim.new(1, 0)

    local tween = TweenService:Create(bolha, TweenInfo.new(math.random(6, 12), Enum.EasingStyle.Linear), {
        Position = UDim2.new(0, bolha.Position.X.Scale * 560 + math.random(-60, 60), 0, -20),
        BackgroundTransparency = 1
    })
    tween:Play()
    tween.Completed:Connect(function() if bolha and bolha.Parent then bolha:Destroy() end end)
end
_G.RD4X_criarBolha = criarBolha

task.spawn(function()
    while _G.RD4X_BolhasAtivas and BolhasContainer.Parent do
        criarBolha()
        task.wait(math.random(8, 30) / 100)
    end
end)

-- header
local Header = Instance.new("Frame", MainFrame)
Header.Size = UDim2.new(1, 0, 0, 38)
Header.BackgroundTransparency = 1
Header.ZIndex = 5

local IconHeader = Instance.new("ImageLabel", Header)
IconHeader.Size = UDim2.new(0, 24, 0, 24)
IconHeader.Position = UDim2.new(0, 10, 0, 7)
IconHeader.BackgroundTransparency = 1
IconHeader.Image = "rbxassetid://109276734890323"
IconHeader.ScaleType = Enum.ScaleType.Crop
IconHeader.ZIndex = 6
Instance.new("UICorner", IconHeader).CornerRadius = UDim.new(1, 0)

local TitleHeader = Instance.new("TextLabel", Header)
TitleHeader.Size = UDim2.new(0, 320, 0, 38)
TitleHeader.Position = UDim2.new(0, 34, 0, 0)
TitleHeader.BackgroundTransparency = 1
TitleHeader.Text = "Rd4X Hub Oficial $ > Brookhaven RP 🇧🇷 < "
TitleHeader.TextColor3 = COR_TEXTO
TitleHeader.TextSize = 11
TitleHeader.Font = Enum.Font.GothamBold
TitleHeader.TextXAlignment = Enum.TextXAlignment.Left
TitleHeader.ZIndex = 6

local UserCredit = Instance.new("TextLabel", Header)
UserCredit.Size = UDim2.new(0, 200, 0, 38)
UserCredit.Position = UDim2.new(1, -300, 0, 0)
UserCredit.BackgroundTransparency = 1
UserCredit.Text = "By j. Epstein"
UserCredit.TextColor3 = COR_VERDE
UserCredit.TextSize = 9
UserCredit.Font = Enum.Font.Gotham
UserCredit.TextXAlignment = Enum.TextXAlignment.Right
UserCredit.ZIndex = 6

local MinimizeBtn = Instance.new("ImageButton", Header)
MinimizeBtn.Size = UDim2.new(0, 24, 0, 24)
MinimizeBtn.Position = UDim2.new(1, -56, 0.5, -12)
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Image = "rbxthumb://type=Asset&id=15396334032&w=150&h=150"
MinimizeBtn.ImageColor3 = COR_TEXTO_CINZA
MinimizeBtn.ZIndex = 6
MinimizeBtn.AutoButtonColor = false

MinimizeBtn.MouseEnter:Connect(function() TweenService:Create(MinimizeBtn, TweenInfo.new(0.15), {ImageColor3 = COR_TEXTO}):Play() end)
MinimizeBtn.MouseLeave:Connect(function() TweenService:Create(MinimizeBtn, TweenInfo.new(0.15), {ImageColor3 = COR_TEXTO_CINZA}):Play() end)

local CloseBtn = Instance.new("ImageButton", Header)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Position = UDim2.new(1, -30, 0.5, -10)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Image = "rbxthumb://type=Asset&id=96089977023576&w=150&h=150" 
CloseBtn.ImageColor3 = COR_TEXTO_CINZA
CloseBtn.ZIndex = 6
CloseBtn.AutoButtonColor = false

CloseBtn.MouseEnter:Connect(function() TweenService:Create(CloseBtn, TweenInfo.new(0.15), {ImageColor3 = COR_VERMELHO}):Play() end)
CloseBtn.MouseLeave:Connect(function() TweenService:Create(CloseBtn, TweenInfo.new(0.15), {ImageColor3 = COR_TEXTO_CINZA}):Play() end)

-- sidebar móvel
local Sidebar = Instance.new("ScrollingFrame", MainFrame)
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = COR_SIDEBAR
Sidebar.BackgroundTransparency = TRANSP_SIDEBAR
Sidebar.BorderSizePixel = 0
Sidebar.ScrollBarThickness = 3
Sidebar.ScrollBarImageColor3 = COR_VERMELHO
Sidebar.CanvasSize = UDim2.new(0, 0, 0, 0)
Sidebar.AutomaticCanvasSize = Enum.AutomaticSize.Y
Sidebar.ZIndex = 5
Sidebar.Active = true

local SidebarHandle = Instance.new("TextButton", MainFrame)
SidebarHandle.Name = "SidebarHandle"
SidebarHandle.Size = UDim2.new(0, 5, 1, -38)
SidebarHandle.Position = UDim2.new(0, 150, 0, 38)
SidebarHandle.BackgroundColor3 = COR_BORDA
SidebarHandle.BackgroundTransparency = 0.5
SidebarHandle.BorderSizePixel = 0
SidebarHandle.Text = ""
SidebarHandle.AutoButtonColor = false
SidebarHandle.ZIndex = 20

SidebarHandle.MouseEnter:Connect(function() TweenService:Create(SidebarHandle, TweenInfo.new(0.15), {BackgroundColor3 = COR_VERMELHO, BackgroundTransparency = 0.2}):Play() end)
SidebarHandle.MouseLeave:Connect(function()
    if not sidebarDragging then TweenService:Create(SidebarHandle, TweenInfo.new(0.15), {BackgroundColor3 = COR_BORDA, BackgroundTransparency = 0.5}):Play() end
end)

local sidebarDragging = false
local sidebarDragStartX = 0
local sidebarStartWidth = 150
local LARGURA_MIN = 100
local LARGURA_MAX = 320

SidebarHandle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        sidebarDragging = true
        sidebarDragStartX = input.Position.X
        sidebarStartWidth = Sidebar.AbsoluteSize.X
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                sidebarDragging = false
                TweenService:Create(SidebarHandle, TweenInfo.new(0.15), {BackgroundColor3 = COR_BORDA, BackgroundTransparency = 0.5}):Play()
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if sidebarDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local deltaX = input.Position.X - sidebarDragStartX
        local nova = math.clamp(sidebarStartWidth + deltaX, LARGURA_MIN, LARGURA_MAX)
        Sidebar.Size = UDim2.new(0, nova, 1, -38)
        SidebarHandle.Position = UDim2.new(0, nova, 0, 38)
        for _, conteudo in pairs(TabFrames) do
            conteudo.Position = UDim2.new(0, nova + 6, 0, 44)
            conteudo.Size = UDim2.new(1, -(nova + 12), 1, -50)
        end
    end
end)

local sideLayout = Instance.new("UIListLayout", Sidebar)
sideLayout.Padding = UDim.new(0, 3)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder

local sidePadding = Instance.new("UIPadding", Sidebar)
sidePadding.PaddingTop = UDim.new(0, 6)
sidePadding.PaddingBottom = UDim.new(0, 6)
sidePadding.PaddingLeft = UDim.new(0, 6)
sidePadding.PaddingRight = UDim.new(0, 6)


-- NOTIFICAÇÕES

local NotifHolder = Instance.new("Frame", ScreenGui)
NotifHolder.Size = UDim2.new(0, 280, 1, -20)
NotifHolder.Position = UDim2.new(1, -290, 0, 10)
NotifHolder.BackgroundTransparency = 1
_G.RD4X_NotifHolder = NotifHolder

local notifLayout = Instance.new("UIListLayout", NotifHolder)
notifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
notifLayout.Padding = UDim.new(0, 6)

local function Notify(title, content, duration)
    if _G.RD4X_NotifAtivas == false then return end
    duration = duration or 3
    local frame = Instance.new("Frame", NotifHolder)
    frame.Size = UDim2.new(1, 0, 0, 56)
    frame.Position = UDim2.new(1.5, 0, 0, 0) 
    frame.BackgroundColor3 = COR_SECUNDARIA
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

    local s = Instance.new("UIStroke", frame)
    s.Color = _G.RD4X_COR_VERMELHO -- Usa a cor global atualizada
    s.Thickness = 1

    local titleLbl = Instance.new("TextLabel", frame)
    titleLbl.Size = UDim2.new(1, -20, 0, 18)
    titleLbl.Position = UDim2.new(0, 10, 0, 6)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Text = "RD4X | " .. tostring(title)
    titleLbl.TextColor3 = _G.RD4X_COR_VERMELHO
    titleLbl.TextSize = 11
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left

    local contentLbl = Instance.new("TextLabel", frame)
    contentLbl.Size = UDim2.new(1, -20, 0, 30)
    contentLbl.Position = UDim2.new(0, 10, 0, 22)
    contentLbl.BackgroundTransparency = 1
    contentLbl.Text = tostring(content)
    contentLbl.TextColor3 = COR_TEXTO
    contentLbl.TextSize = 10
    contentLbl.Font = Enum.Font.Gotham
    contentLbl.TextXAlignment = Enum.TextXAlignment.Left
    contentLbl.TextWrapped = true

    TweenService:Create(frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()

    task.delay(duration, function()
        pcall(function()
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(1.5, 0, 0, 0), BackgroundTransparency = 1}):Play()
            TweenService:Create(s, TweenInfo.new(0.3), {Transparency = 1}):Play()
            TweenService:Create(titleLbl, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            TweenService:Create(contentLbl, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            task.wait(0.35)
            frame:Destroy()
        end)
    end)
end
_G.RD4X_Notify = Notify

-- MINIMIZAR / FECHAR

local isMinimized = false
local alturaNormal = 400
local alturaMinimizada = 38

MinimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 560, 0, alturaMinimizada)}):Play()
        Sidebar.Visible = false
        SidebarHandle.Visible = false
        for _, c in pairs(TabFrames) do c.Visible = false end
        MinimizeBtn.ImageColor3 = COR_VERMELHO
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 560, 0, alturaNormal)}):Play()
        task.wait(0.35)
        Sidebar.Visible = true
        SidebarHandle.Visible = true
        for n, c in pairs(TabFrames) do
            local txt = TabButtons[n]:FindFirstChildOfClass("TextLabel")
            if txt and txt.TextColor3 == COR_TEXTO then c.Visible = true end
        end
        MinimizeBtn.ImageColor3 = COR_TEXTO_CINZA
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    BotaoFlutuante.Visible = true
end)

BotaoFlutuante.MouseButton1Click:Connect(function()
    BotaoFlutuante.Visible = false
    MainFrame.Visible = true
end)

local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- UI TOOLKIT

local UI = {}

function UI.Paragraph(parent, opts)
    local container = Instance.new("Frame", parent)
    container.BackgroundColor3 = COR_SECUNDARIA
    container.BackgroundTransparency = TRANSP_CARDS
    container.BorderSizePixel = 0
    container.ZIndex = 6
    
    -- MÁGICA AQUI: Faz o botão se ajustar sozinho à altura do texto
    container.Size = UDim2.new(1, -4, 0, 0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)
    
    local p = Instance.new("UIPadding", container)
    p.PaddingTop = UDim.new(0, 8)
    p.PaddingBottom = UDim.new(0, 8)
    p.PaddingLeft = UDim.new(0, 10)
    p.PaddingRight = UDim.new(0, 10)

    local temIcone = (opts.Icon ~= nil)
    local textOffset = temIcone and 28 or 0

    -- Ícone
    if temIcone then
        local numId = tostring(opts.Icon):match("%d+")
        if numId then
            local img = Instance.new("ImageLabel", container)
            img.Size = UDim2.new(0, 20, 0, 20) -- Ícone levemente maior
            img.Position = UDim2.new(0, 0, 0, 0) 
            img.BackgroundTransparency = 1
            img.Image = "rbxthumb://type=Asset&id=" .. numId .. "&w=150&h=150"
            img.ZIndex = 7
        end
    end

    -- Container de texto (para organizar Título e Descrição)
    local textFrame = Instance.new("Frame", container)
    textFrame.BackgroundTransparency = 1
    textFrame.Position = UDim2.new(0, textOffset, 0, 0)
    textFrame.Size = UDim2.new(1, -textOffset, 0, 0)
    textFrame.AutomaticSize = Enum.AutomaticSize.Y
    textFrame.ZIndex = 7

    local layout = Instance.new("UIListLayout", textFrame)
    layout.Padding = UDim.new(0, 2)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Título (Maior e Branco)
    if opts.Title then
        local titleLbl = Instance.new("TextLabel", textFrame)
        titleLbl.Size = UDim2.new(1, 0, 0, 0)
        titleLbl.AutomaticSize = Enum.AutomaticSize.Y
        titleLbl.BackgroundTransparency = 1
        titleLbl.Text = opts.Title
        titleLbl.TextColor3 = COR_TEXTO
        titleLbl.TextSize = 13 -- AUMENTEI A LETRA AQUI
        titleLbl.Font = Enum.Font.GothamBold
        titleLbl.TextXAlignment = Enum.TextXAlignment.Left
        titleLbl.TextWrapped = true
        titleLbl.ZIndex = 7
    end

    -- Conteúdo (Menor e Cinza)
    if opts.Content then
        local contentLbl = Instance.new("TextLabel", textFrame)
        contentLbl.Size = UDim2.new(1, 0, 0, 0)
        contentLbl.AutomaticSize = Enum.AutomaticSize.Y
        contentLbl.BackgroundTransparency = 1
        contentLbl.Text = opts.Content
        contentLbl.TextColor3 = COR_TEXTO_CINZA
        contentLbl.TextSize = 11
        contentLbl.Font = Enum.Font.Gotham
        contentLbl.TextXAlignment = Enum.TextXAlignment.Left
        contentLbl.TextWrapped = true
        contentLbl.ZIndex = 7
    end

    return container
end

function UI.InfoBlock(parent, opts)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -4, 0, opts.Description and 34 or 24)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 6

    local temIcone = (opts.Icon ~= nil)
    local textOffset = temIcone and 26 or 0

    if temIcone then
        local numId = tostring(opts.Icon):match("%d+")
        if numId then
            local img = Instance.new("ImageLabel", frame)
            img.Size = UDim2.new(0, 18, 0, 18)
            img.Position = UDim2.new(0, 0, 0.5, -9)
            img.BackgroundTransparency = 1
             --Correção: Puxa a imagem igual às abas
            img.Image = "rbxthumb://type=Asset&id=" .. numId .. "&w=150&h=150"
            img.ZIndex = 7
        end
    end

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, -textOffset, 0, opts.Description and 16 or 24)
    title.Position = UDim2.new(0, textOffset, 0, opts.Description and 2 or 0)
    title.BackgroundTransparency = 1
    title.Text = opts.Title or "Título"
    title.TextColor3 = COR_TEXTO
    title.TextSize = 12
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextYAlignment = Enum.TextYAlignment.Center
    title.ZIndex = 7

    if opts.Description then
        local desc = Instance.new("TextLabel", frame)
        desc.Size = UDim2.new(1, -textOffset, 0, 14)
        desc.Position = UDim2.new(0, textOffset, 0, 18)
        desc.BackgroundTransparency = 1
        desc.Text = opts.Description
        desc.TextColor3 = COR_TEXTO_CINZA
        desc.TextSize = 9
        desc.Font = Enum.Font.Gotham
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.ZIndex = 7
    end

    return frame
end

function UI.Button(parent, opts)
    local container = Instance.new("TextButton", parent)
    container.Size = UDim2.new(1, -4, 0, 36)
    container.BackgroundColor3 = COR_SECUNDARIA
    container.BackgroundTransparency = TRANSP_CARDS
    container.BorderSizePixel = 0
    container.Text = ""
    container.AutoButtonColor = false
    container.ZIndex = 6
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

    local title = Instance.new("TextLabel", container)
    title.Size = UDim2.new(1, -30, 0, 16)
    title.Position = UDim2.new(0, 10, 0, 4)
    title.BackgroundTransparency = 1
    title.Text = opts.Name or "Botão"
    title.TextColor3 = COR_TEXTO
    title.TextSize = 11
    title.Font = Enum.Font.GothamBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 7

    local desc = Instance.new("TextLabel", container)
    desc.Size = UDim2.new(1, -30, 0, 14)
    desc.Position = UDim2.new(0, 10, 0, 20)
    desc.BackgroundTransparency = 1
    desc.Text = opts.Description or ""
    desc.TextColor3 = COR_TEXTO_CINZA
    desc.TextSize = 9
    desc.Font = Enum.Font.Gotham
    desc.TextXAlignment = Enum.TextXAlignment.Left
    desc.ZIndex = 7

    local arrow = Instance.new("TextLabel", container)
    arrow.Size = UDim2.new(0, 20, 1, 0)
    arrow.Position = UDim2.new(1, -25, 0, 0)
    arrow.BackgroundTransparency = 1
    arrow.Text = ">"
    arrow.TextColor3 = COR_TEXTO_CINZA
    arrow.TextSize = 14
    arrow.Font = Enum.Font.GothamBold
    arrow.ZIndex = 7

    container.MouseEnter:Connect(function() TweenService:Create(container, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 50, 62), BackgroundTransparency = 0.25}):Play() end)
    container.MouseLeave:Connect(function() TweenService:Create(container, TweenInfo.new(0.15), {BackgroundColor3 = COR_SECUNDARIA, BackgroundTransparency = TRANSP_CARDS}):Play() end)
    container.MouseButton1Click:Connect(function()
        if _G.RD4X_SomAtivo ~= false then
            pcall(function() local s = Instance.new("Sound", SoundService) s.SoundId = "rbxassetid://3665143844" s.Volume = 0.3 s:Play() task.delay(2, function() s:Destroy() end) end)
        end
        if opts.Callback then pcall(opts.Callback) end
    end)
    return container
end

function UI.Input(parent, opts)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, -4, 0, 32)
    container.BackgroundColor3 = COR_SECUNDARIA
    container.BackgroundTransparency = TRANSP_CARDS
    container.BorderSizePixel = 0
    container.ZIndex = 6
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel", container)
    label.Size = UDim2.new(0.55, -10, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = opts.Name or "Input"
    label.TextColor3 = COR_TEXTO_CINZA
    label.TextSize = 10
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 7

    local tb = Instance.new("TextBox", container)
    tb.Size = UDim2.new(0.45, -10, 1, -8)
    tb.Position = UDim2.new(0.55, 0, 0, 4)
    tb.BackgroundColor3 = COR_FUNDO
    tb.BackgroundTransparency = TRANSP_INPUT
    tb.BorderSizePixel = 0
    tb.Text = opts.CurrentValue or ""
    tb.PlaceholderText = opts.PlaceholderText or "..."
    tb.PlaceholderColor3 = COR_TEXTO_CINZA
    tb.TextColor3 = COR_TEXTO
    tb.TextSize = 10
    tb.Font = Enum.Font.Gotham
    tb.ClearTextOnFocus = false
    tb.ZIndex = 7
    Instance.new("UICorner", tb).CornerRadius = UDim.new(0, 4)
    Instance.new("UIPadding", tb).PaddingLeft = UDim.new(0, 6)

    tb.FocusLost:Connect(function()
        if opts.Callback then pcall(opts.Callback, tb.Text) end
    end)
    return tb
end

function UI.Toggle(parent, opts)
    local container = Instance.new("TextButton", parent)
    container.Size = UDim2.new(1, -4, 0, 28)
    container.BackgroundColor3 = COR_SECUNDARIA
    container.BackgroundTransparency = TRANSP_CARDS
    container.BorderSizePixel = 0
    container.Text = ""
    container.AutoButtonColor = false
    container.ZIndex = 6
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

    local label = Instance.new("TextLabel", container)
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = opts.Name or "Toggle"
    label.TextColor3 = COR_TEXTO
    label.TextSize = 10
    label.Font = Enum.Font.GothamMedium
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 7

    local switchBg = Instance.new("Frame", container)
    switchBg.Size = UDim2.new(0, 34, 0, 18)
    switchBg.Position = UDim2.new(1, -44, 0.5, -9)
    switchBg.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    switchBg.BorderSizePixel = 0
    switchBg.ZIndex = 7
    Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)

    local knob = Instance.new("Frame", switchBg)
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new(0, 2, 0.5, -7)
    knob.BackgroundColor3 = COR_TEXTO
    knob.BorderSizePixel = 0
    knob.ZIndex = 8
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local state = opts.CurrentValue or false
    local function update()
        TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = state and _G.RD4X_COR_VERMELHO or Color3.fromRGB(60, 60, 70)}):Play()
        TweenService:Create(knob, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)}):Play()
    end
    update()

    container.MouseButton1Click:Connect(function()
        state = not state
        update()
        if opts.Callback then pcall(opts.Callback, state) end
    end)
    return { Set = function(v) state = v update() if opts.Callback then pcall(opts.Callback, v) end end }
end

function UI.Dropdown(parent, opts)
    local container = Instance.new("Frame", parent)
    container.Size = UDim2.new(1, -4, 0, 32)
    container.BackgroundColor3 = COR_SECUNDARIA
    container.BackgroundTransparency = TRANSP_CARDS
    container.BorderSizePixel = 0
    container.ClipsDescendants = false
    container.ZIndex = 8
    Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

    local btn = Instance.new("TextButton", container)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 9

    local label = Instance.new("TextLabel", btn)
    label.Size = UDim2.new(0.6, -10, 1, 0)
    label.Position = UDim2.new(0, 10, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = opts.Name or "Dropdown"
    label.TextColor3 = COR_TEXTO_CINZA
    label.TextSize = 10
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 9

    local currentLabel = Instance.new("TextLabel", btn)
    currentLabel.Size = UDim2.new(0.4, -20, 1, 0)
    currentLabel.Position = UDim2.new(0.6, 0, 0, 0)
    currentLabel.BackgroundTransparency = 1
    currentLabel.Text = (opts.CurrentOption and opts.CurrentOption[1]) or "..."
    currentLabel.TextColor3 = COR_TEXTO
    currentLabel.TextSize = 10
    currentLabel.Font = Enum.Font.GothamMedium
    currentLabel.TextXAlignment = Enum.TextXAlignment.Right
    currentLabel.ZIndex = 9

    local arrow = Instance.new("TextLabel", btn)
    arrow.Size = UDim2.new(0, 14, 0, 14)
    arrow.Position = UDim2.new(1, -20, 0.5, -7)
    arrow.BackgroundTransparency = 1
    arrow.Text = "▼"
    arrow.TextColor3 = COR_TEXTO_CINZA
    arrow.TextSize = 8
    arrow.Font = Enum.Font.GothamBold
    arrow.ZIndex = 9

    local listFrame = Instance.new("ScrollingFrame", container)
    listFrame.Size = UDim2.new(1, 0, 0, 100)
    listFrame.Position = UDim2.new(0, 0, 1, 4)
    listFrame.BackgroundColor3 = COR_SIDEBAR
    listFrame.BackgroundTransparency = 0.1
    listFrame.BorderSizePixel = 0
    listFrame.Visible = false
    listFrame.ZIndex = 15
    listFrame.ScrollBarThickness = 2
    listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    listFrame.ScrollingDirection = Enum.ScrollingDirection.Y

    Instance.new("UICorner", listFrame).CornerRadius = UDim.new(0, 6)
    local sl = Instance.new("UIStroke", listFrame)
    sl.Color = COR_BORDA
    sl.Thickness = 1

    local listLayout = Instance.new("UIListLayout", listFrame)
    listLayout.Padding = UDim.new(0, 2)
    local listPad = Instance.new("UIPadding", listFrame)
    listPad.PaddingTop = UDim.new(0, 4)
    listPad.PaddingBottom = UDim.new(0, 4)
    listPad.PaddingLeft = UDim.new(0, 4)
    listPad.PaddingRight = UDim.new(0, 4)

    local isOpen = false
    local options = opts.Options or {}
    local selected = (opts.CurrentOption and opts.CurrentOption[1]) or options[1]

    local function refreshOptions(newOptions)
        options = newOptions or {}
        
        for _, ch in ipairs(listFrame:GetChildren()) do
            if ch:IsA("TextButton") then ch:Destroy() end
        end
        
        for _, opt in ipairs(options) do
            local ob = Instance.new("TextButton", listFrame)
            ob.Size = UDim2.new(1, -4, 0, 26)
            ob.BackgroundColor3 = COR_SECUNDARIA
            ob.BackgroundTransparency = 1
            ob.BorderSizePixel = 0
            ob.Text = ""
            ob.AutoButtonColor = false
            ob.ZIndex = 16
            Instance.new("UICorner", ob).CornerRadius = UDim.new(0, 4)

            -- Avatar 2d, listas dks players
            local p = Players:FindFirstChild(tostring(opt))
            local txtPadding = 8
            if p then
                local img = Instance.new("ImageLabel", ob)
                img.Size = UDim2.new(0, 18, 0, 18)
                img.Position = UDim2.new(0, 4, 0.5, -9)
                img.BackgroundColor3 = COR_FUNDO
                img.Image = "rbxthumb://type=AvatarHeadShot&id=" .. p.UserId .. "&w=150&h=150"
                img.ZIndex = 17
                Instance.new("UICorner", img).CornerRadius = UDim.new(1, 0)
                txtPadding = 26
            end

            local txt = Instance.new("TextLabel", ob)
            txt.Size = UDim2.new(1, -txtPadding, 1, 0)
            txt.Position = UDim2.new(0, txtPadding, 0, 0)
            txt.BackgroundTransparency = 1
            txt.Text = tostring(opt)
            txt.TextColor3 = COR_TEXTO
            txt.TextSize = 10
            txt.Font = Enum.Font.Gotham
            txt.TextXAlignment = Enum.TextXAlignment.Left
            txt.ZIndex = 17

            ob.MouseEnter:Connect(function() ob.BackgroundTransparency = 0.4 end)
            ob.MouseLeave:Connect(function() ob.BackgroundTransparency = 1 end)
            ob.MouseButton1Click:Connect(function()
                selected = opt
                currentLabel.Text = tostring(opt)
                listFrame.Visible = false
                isOpen = false
                if opts.Callback then pcall(opts.Callback, {opt}) end
            end)
        end
        
        local h = math.clamp(#options * 28 + 8, 30, 140)
        listFrame.Size = UDim2.new(1, 0, 0, h)
        listFrame.CanvasSize = UDim2.new(0, 0, 0, #options * 28 + 8)
    end

    refreshOptions(options)

    btn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        listFrame.Visible = isOpen
    end)

    return {
    -- Aceita tanto dropdown:Refresh(lista) quanto dropdown.Refresh(lista)
    Refresh = function(a, b)
        local newList = (b ~= nil) and b or a
        refreshOptions(newList)
    end,
    Set = function(a, b)
        local v = (b ~= nil) and b or a
        selected = v
        currentLabel.Text = tostring(v)
    end
}
end
_G.RD4X_UI = UI

--Sistemas De Abas
local function ShowTab(name)
    for n, f in pairs(TabFrames) do
        if n == name then
            f.Visible = true
            f.Position = UDim2.new(0, 165, 0, 44)
            TweenService:Create(f, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2.new(0, 156, 0, 44)
            }):Play()
        else
            f.Visible = false
        end
    end

    for n, b in pairs(TabButtons) do
        local txt = b:FindFirstChildOfClass("TextLabel")
        if n == name then
            b.BackgroundTransparency = TRANSP_CARDS
            if txt then txt.TextColor3 = COR_TEXTO end
        else
            b.BackgroundTransparency = 1
            if txt then txt.TextColor3 = COR_TEXTO_CINZA end
        end
    end
end

local function CreateTab(name, iconId)
    local btn = Instance.new("TextButton", Sidebar)
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundColor3 = COR_SECUNDARIA
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.ZIndex = 6
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

    if iconId then
        local numId = tostring(iconId):match("%d+")
        if numId then
            local img = Instance.new("ImageLabel", btn)
            img.Size = UDim2.new(0, 16, 0, 16)
            img.Position = UDim2.new(0, 10, 0.5, -8)
            img.BackgroundTransparency = 1
            img.Image = "rbxthumb://type=Asset&id=" .. numId .. "&w=150&h=150"
            img.ZIndex = 7
        end
    end

    local txt = Instance.new("TextLabel", btn)
    txt.Size = UDim2.new(1, -40, 1, 0)
    txt.Position = UDim2.new(0, iconId and 34 or 10, 0, 0)
    txt.BackgroundTransparency = 1
    txt.Text = name
    txt.TextColor3 = COR_TEXTO_CINZA
    txt.TextSize = 10
    txt.Font = Enum.Font.GothamMedium
    txt.TextXAlignment = Enum.TextXAlignment.Left
    txt.TextYAlignment = Enum.TextYAlignment.Center
    txt.ZIndex = 7

    local content = Instance.new("ScrollingFrame", MainFrame)
    content.Size = UDim2.new(1, -162, 1, -50)
    content.Position = UDim2.new(0, 156, 0, 44)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.ScrollBarThickness = 3
    content.ScrollBarImageColor3 = COR_VERMELHO
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    content.Visible = false
    content.ZIndex = 5

    local layout = Instance.new("UIListLayout", content)
    layout.Padding = UDim.new(0, 6)
    layout.SortOrder = Enum.SortOrder.LayoutOrder

    TabFrames[name] = content
    TabButtons[name] = btn

    btn.MouseButton1Click:Connect(function() ShowTab(name) end)
    return content
end

local Tabs = {
    Principal = CreateTab("Informações", "10941503192"),
    Player    = CreateTab("Jogador", "7992557371"),
    Skins = CreateTab("Skins", "11955919656"),
    Servidor  = CreateTab("Servidor", "14095421789"),
    Carros    = CreateTab("Veículo", "82734412385826"),
    Casas     = CreateTab("Casa", "18923169586"),
    SomAll = CreateTab("SomAll", "137483969436938"),
    Musicas   = CreateTab("Música", "105472378838470"),
    Troll     = CreateTab("Troll", "14436167217"),
    Outros    = CreateTab("Outros", "109123578002396"),
    Protecao  = CreateTab("Proteção", "5197571759"),
    Scripts   = CreateTab("Scripts", "5650870659"),
    Teleportes = CreateTab("Teleportes", "6723742959"),
    Config = CreateTab("Config", "134966548587596")
}
ShowTab("Informações")

_G.RD4X_Tabs = Tabs
_G.RD4X_TabFrames = TabFrames
_G.RD4X_TabButtons = TabButtons

UI.Paragraph(Tabs.SomAll, {
Title = "Aviso do RD4X!", Content = "Em Breve, na atualização 2.0.0!",
Icon = "137483969436938"
})
UI.Paragraph(Tabs.Skins, {
Title = "Aviso do RD4X!", Content = "Em Breve, na atualização 2.0.0!",
Icon = "11955919656"
})


-- ABA INFORMAÇÕES

local infoContent = Tabs.Principal

local LinkText = Instance.new("TextLabel", infoContent)
LinkText.Size = UDim2.new(1, -4, 0, 14)
LinkText.BackgroundTransparency = 1
LinkText.Text = "Informações Script"
LinkText.TextColor3 = COR_TEXTO_CINZA
LinkText.TextSize = 5
LinkText.Font = Enum.Font.Gotham
LinkText.TextXAlignment = Enum.TextXAlignment.Left

local CardComunidade = Instance.new("Frame", infoContent)
CardComunidade.Size = UDim2.new(1, -4, 0, 56)
CardComunidade.BackgroundColor3 = COR_SECUNDARIA
CardComunidade.BackgroundTransparency = TRANSP_CARDS
CardComunidade.BorderSizePixel = 0
CardComunidade.ZIndex = 6
Instance.new("UICorner", CardComunidade).CornerRadius = UDim.new(0, 6)

local IconeComunidade = Instance.new("ImageLabel", CardComunidade)
IconeComunidade.Size = UDim2.new(0, 40, 0, 40)
IconeComunidade.Position = UDim2.new(0, 8, 0.5, -20)
IconeComunidade.BackgroundTransparency = 1
IconeComunidade.Image = "rbxassetid://109276734890323"
IconeComunidade.ScaleType = Enum.ScaleType.Crop
IconeComunidade.ZIndex = 7
Instance.new("UICorner", IconeComunidade).CornerRadius = UDim.new(1, 0)

local TituloComunidade = Instance.new("TextLabel", CardComunidade)
TituloComunidade.Size = UDim2.new(1, -70, 0, 18)
TituloComunidade.Position = UDim2.new(0, 56, 0, 10)
TituloComunidade.BackgroundTransparency = 1
TituloComunidade.Text = "Discord Ofc"
TituloComunidade.TextColor3 = COR_TEXTO
TituloComunidade.TextSize = 12
TituloComunidade.Font = Enum.Font.GothamBold
TituloComunidade.TextXAlignment = Enum.TextXAlignment.Left
TituloComunidade.ZIndex = 7

local SubComunidade = Instance.new("TextLabel", CardComunidade)
SubComunidade.Size = UDim2.new(1, -70, 0, 16)
SubComunidade.Position = UDim2.new(0, 56, 0, 28)
SubComunidade.BackgroundTransparency = 1
SubComunidade.Text = "Entre no nosso Discord"
SubComunidade.TextColor3 = COR_TEXTO_CINZA
SubComunidade.TextSize = 10
SubComunidade.Font = Enum.Font.Gotham
SubComunidade.TextXAlignment = Enum.TextXAlignment.Left
SubComunidade.ZIndex = 7

local BotaoCopyLink = Instance.new("TextButton", infoContent)
BotaoCopyLink.Size = UDim2.new(1, -4, 0, 34)
BotaoCopyLink.BackgroundColor3 = COR_VERMELHO
BotaoCopyLink.BackgroundTransparency = TRANSP_BOTAO_VERDE
BotaoCopyLink.BorderSizePixel = 0
BotaoCopyLink.Text = "Copy Link"
BotaoCopyLink.TextColor3 = Color3.fromRGB(255, 255, 255)
BotaoCopyLink.TextSize = 12
BotaoCopyLink.Font = Enum.Font.GothamBold
BotaoCopyLink.AutoButtonColor = false
BotaoCopyLink.ZIndex = 6
Instance.new("UICorner", BotaoCopyLink).CornerRadius = UDim.new(0, 6)

BotaoCopyLink.MouseEnter:Connect(function() TweenService:Create(BotaoCopyLink, TweenInfo.new(0.15), {BackgroundTransparency = 0.15}):Play() end)
BotaoCopyLink.MouseLeave:Connect(function() TweenService:Create(BotaoCopyLink, TweenInfo.new(0.15), {BackgroundTransparency = TRANSP_BOTAO_VERDE}):Play() end)
BotaoCopyLink.MouseButton1Click:Connect(function()
    pcall(function() setclipboard("https://discord.gg/kZzuySatK9") end)
end)

local TituloInfo = Instance.new("TextLabel", infoContent)
TituloInfo.Size = UDim2.new(1, -4, 0, 20)
TituloInfo.BackgroundTransparency = 1
TituloInfo.Text = "ⓘ  Informações"
TituloInfo.TextColor3 = COR_TEXTO
TituloInfo.TextSize = 13
TituloInfo.Font = Enum.Font.GothamBold
TituloInfo.TextXAlignment = Enum.TextXAlignment.Left

local CardHexagon = Instance.new("Frame", infoContent)
CardHexagon.Size = UDim2.new(1, -4, 0, 58)
CardHexagon.BackgroundColor3 = COR_SECUNDARIA
CardHexagon.BackgroundTransparency = TRANSP_CARDS
CardHexagon.BorderSizePixel = 0
CardHexagon.ZIndex = 6
Instance.new("UICorner", CardHexagon).CornerRadius = UDim.new(0, 6)

local padCH = Instance.new("UIPadding", CardHexagon)
padCH.PaddingTop = UDim.new(0, 6)
padCH.PaddingLeft = UDim.new(0, 8)
padCH.PaddingRight = UDim.new(0, 8)

local TitleHex = Instance.new("TextLabel", CardHexagon)
TitleHex.Size = UDim2.new(1, -10, 0, 16)
TitleHex.BackgroundTransparency = 1
TitleHex.Text = "Rd4X Hub Info"
TitleHex.TextColor3 = COR_TEXTO
TitleHex.TextSize = 11
TitleHex.Font = Enum.Font.GothamBold
TitleHex.TextXAlignment = Enum.TextXAlignment.Left
TitleHex.ZIndex = 7

local DescHex = Instance.new("TextLabel", CardHexagon)
DescHex.Size = UDim2.new(1, -10, 0, 32)
DescHex.Position = UDim2.new(0, 0, 0, 18)
DescHex.BackgroundTransparency = 1
DescHex.Text = "Está versão é a 1.0. Você pode encontrar falhas."
DescHex.TextColor3 = COR_TEXTO_CINZA
DescHex.TextSize = 9
DescHex.Font = Enum.Font.Gotham
DescHex.TextXAlignment = Enum.TextXAlignment.Left
DescHex.TextYAlignment = Enum.TextYAlignment.Top
DescHex.TextWrapped = true
DescHex.ZIndex = 7

local CardRelease = Instance.new("Frame", infoContent)
CardRelease.Size = UDim2.new(1, -4, 0, 118)
CardRelease.BackgroundColor3 = COR_SECUNDARIA
CardRelease.BackgroundTransparency = TRANSP_CARDS
CardRelease.BorderSizePixel = 0
CardRelease.ZIndex = 6
Instance.new("UICorner", CardRelease).CornerRadius = UDim.new(0, 6)

local padCR = Instance.new("UIPadding", CardRelease)
padCR.PaddingTop = UDim.new(0, 6)
padCR.PaddingLeft = UDim.new(0, 8)
padCR.PaddingRight = UDim.new(0, 8)

local TitleRelease = Instance.new("TextLabel", CardRelease)
TitleRelease.Size = UDim2.new(1, -10, 0, 16)
TitleRelease.BackgroundTransparency = 1
TitleRelease.Text = "[Updates]🔥 Versão: 1.0:"
TitleRelease.TextColor3 = COR_TEXTO
TitleRelease.TextSize = 11
TitleRelease.Font = Enum.Font.GothamBold
TitleRelease.TextXAlignment = Enum.TextXAlignment.Left
TitleRelease.ZIndex = 7

local DescRelease = Instance.new("TextLabel", CardRelease)
DescRelease.Size = UDim2.new(1, -10, 0, 94)
DescRelease.Position = UDim2.new(0, 0, 0, 20)
DescRelease.BackgroundTransparency = 1
DescRelease.Text = "V: 1.0.0.\nJogo: Brookhaven 🏡  Rp\nPlaceId: 4924922222\nAproveite!"
DescRelease.TextColor3 = COR_TEXTO_CINZA
DescRelease.TextSize = 9
DescRelease.Font = Enum.Font.Gotham
DescRelease.TextXAlignment = Enum.TextXAlignment.Left
DescRelease.TextYAlignment = Enum.TextYAlignment.Top
DescRelease.TextWrapped = true
DescRelease.ZIndex = 7

local CardInfo2 = Instance.new("Frame", infoContent)
CardInfo2.Size = UDim2.new(1, -4, 0, 58)
CardInfo2.BackgroundColor3 = COR_SECUNDARIA
CardInfo2.BackgroundTransparency = TRANSP_CARDS
CardInfo2.BorderSizePixel = 0
CardInfo2.ZIndex = 6
Instance.new("UICorner", CardInfo2).CornerRadius = UDim.new(0, 6)

local padCI2 = Instance.new("UIPadding", CardInfo2)
padCI2.PaddingTop = UDim.new(0, 6)
padCI2.PaddingLeft = UDim.new(0, 8)
padCI2.PaddingRight = UDim.new(0, 8)

local TitleCI2 = Instance.new("TextLabel", CardInfo2)
TitleCI2.Size = UDim2.new(1, -10, 0, 16)
TitleCI2.BackgroundTransparency = 1
TitleCI2.Text = "Autoria:"
TitleCI2.TextColor3 = COR_TEXTO
TitleCI2.TextSize = 11
TitleCI2.Font = Enum.Font.GothamBold
TitleCI2.TextXAlignment = Enum.TextXAlignment.Left
TitleCI2.ZIndex = 7

local DescCI2 = Instance.new("TextLabel", CardInfo2)
DescCI2.Size = UDim2.new(1, -10, 0, 32)
DescCI2.Position = UDim2.new(0, 0, 0, 18)
DescCI2.BackgroundTransparency = 1
DescCI2.Text = "Dev / Owner = J. Epstein\nEquipe = Rd4X Team oficial"
DescCI2.TextColor3 = COR_TEXTO_CINZA
DescCI2.TextSize = 9
DescCI2.Font = Enum.Font.Gotham
DescCI2.TextXAlignment = Enum.TextXAlignment.Left
DescCI2.TextYAlignment = Enum.TextYAlignment.Top
DescCI2.TextWrapped = true
DescCI2.ZIndex = 7

local BotaoReconectar = Instance.new("TextButton", infoContent)
BotaoReconectar.Size = UDim2.new(1, -4, 0, 44)
BotaoReconectar.BackgroundColor3 = COR_SECUNDARIA
BotaoReconectar.BackgroundTransparency = TRANSP_CARDS
BotaoReconectar.BorderSizePixel = 0
BotaoReconectar.Text = "Reconectar"
BotaoReconectar.AutoButtonColor = false
BotaoReconectar.ZIndex = 6
Instance.new("UICorner", BotaoReconectar).CornerRadius = UDim.new(0, 6)

local ReconectarTitle = Instance.new("TextLabel", BotaoReconectar)
ReconectarTitle.Size = UDim2.new(1, -30, 0, 16)
ReconectarTitle.Position = UDim2.new(0, 10, 0, 6)
ReconectarTitle.BackgroundTransparency = 1
ReconectarTitle.Text = "Reconectar"
ReconectarTitle.TextColor3 = COR_TEXTO
ReconectarTitle.TextSize = 11
ReconectarTitle.Font = Enum.Font.GothamBold
ReconectarTitle.TextXAlignment = Enum.TextXAlignment.Left
ReconectarTitle.ZIndex = 7

local ReconectarDesc = Instance.new("TextLabel", BotaoReconectar)
ReconectarDesc.Size = UDim2.new(1, -30, 0, 14)
ReconectarDesc.Position = UDim2.new(0, 10, 0, 24)
ReconectarDesc.BackgroundTransparency = 1
ReconectarDesc.Text = "Reconecta você ao servidor atual"
ReconectarDesc.TextColor3 = COR_TEXTO_CINZA
ReconectarDesc.TextSize = 9
ReconectarDesc.Font = Enum.Font.Gotham
ReconectarDesc.TextXAlignment = Enum.TextXAlignment.Left
ReconectarDesc.ZIndex = 7

local ReconectarArrow = Instance.new("TextLabel", BotaoReconectar)
ReconectarArrow.Size = UDim2.new(0, 20, 1, 0)
ReconectarArrow.Position = UDim2.new(1, -25, 0, 0)
ReconectarArrow.BackgroundTransparency = 1
ReconectarArrow.Text = ">"
ReconectarArrow.TextColor3 = COR_TEXTO_CINZA
ReconectarArrow.TextSize = 14
ReconectarArrow.Font = Enum.Font.GothamBold
ReconectarArrow.ZIndex = 7

BotaoReconectar.MouseEnter:Connect(function() TweenService:Create(BotaoReconectar, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(50, 50, 62), BackgroundTransparency = 0.25}):Play() end)
BotaoReconectar.MouseLeave:Connect(function() TweenService:Create(BotaoReconectar, TweenInfo.new(0.15), {BackgroundColor3 = COR_SECUNDARIA, BackgroundTransparency = TRANSP_CARDS}):Play() end)
BotaoReconectar.MouseButton1Click:Connect(function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

-- Auto bio, auto nome personalizado + RGB com velocidade ajustável
_G.RD4X_RGB_Ativo = true
_G.RD4X_RGB_Velocidade = "Rapido" -- Opções: "Normal", "Rapido", "MuitoRapido"

local VELOCIDADES_RGB = {
    Normal = { passo = 0.04, delay = 0.45 },
    Rapido = { passo = 0.08, delay = 0.18 },
    MuitoRapido = { passo = 0.14, delay = 0.08 }
}

task.spawn(function()
    task.wait(2)
    local RE = ReplicatedStorage:FindFirstChild("RE")
    local rpText = RE and RE:FindFirstChild("1RPNam1eTex1t")
    local rpColor = RE and RE:FindFirstChild("1RPNam1eColo1r")

    if not rpText and not rpColor then
        task.wait(2)
        RE = ReplicatedStorage:FindFirstChild("RE")
        rpText = RE and RE:FindFirstChild("1RPNam1eTex1t")
        rpColor = RE and RE:FindFirstChild("1RPNam1eColo1r")
    end

    if rpText then
        pcall(function()
            rpText:FireServer("RolePlayBio", "W3lc0m3, " .. LocalPlayer.Name)
        end)
        task.wait(0.35)

        if LocalPlayer.UserId == MEU_ID_CREATOR then
            pcall(function()
                rpText:FireServer("RolePlayName", "👑 Rd4X Creator◾")
            end)
        else
            pcall(function()
                rpText:FireServer("RolePlayName", "🇧🇷 Rd4X User◾")
            end)
        end
        task.wait(0.25)
    end

    local hue = 0
    while LocalPlayer.Parent do
        if _G.RD4X_RGB_Ativo then
            local cfg = VELOCIDADES_RGB[_G.RD4X_RGB_Velocidade] or VELOCIDADES_RGB.Rapido
            hue = (hue + cfg.passo) % 1
            local corRGB = Color3.fromHSV(hue, 1, 1)

            if rpColor and rpColor.Parent then
                pcall(function()
                    rpColor:FireServer("PickingRPNameColor", corRGB)
                end)
            end

            task.wait(cfg.delay)
        else
            task.wait(0.3)
        end
    end
end)
