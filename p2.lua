local R = _G
if not _G.RD4X_UI then error("[RD4X] Execute a Parte 1/4 primeiro!") end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local ScreenGui        = _G.RD4X_ScreenGui
local UI               = _G.RD4X_UI
local Notify           = _G.RD4X_Notify
local Tabs             = _G.RD4X_Tabs
local COR_FUNDO        = _G.RD4X_COR_FUNDO
local COR_SECUNDARIA   = _G.RD4X_COR_SECUNDARIA
local COR_TEXTO        = _G.RD4X_COR_TEXTO
local COR_TEXTO_CINZA  = _G.RD4X_COR_TEXTO_CINZA
local COR_VERMELHO     = _G.RD4X_COR_VERMELHO

-- ==========================================================
-- 🌍 ABA TELEPORTES
-- ==========================================================
UI.InfoBlock(Tabs.Teleportes, {
Title = "Teleportes",
Description = "Teleporta para locais do Servidor",
Icon = "6723742959"
})
local function teleportar(x, y, z, nomeLocal)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
        Notify("🌍 Teleporte", "Tp para: " .. nomeLocal, 2)
    else
        Notify("⚠️ Aviso", "Character not loaded.", 2)
    end
end

UI.Button(Tabs.Teleportes, { Name = "Praça", Description = "Teleporta para a Praça", Callback = function() teleportar(-26, 7, 1, "Praça") end })
UI.Button(Tabs.Teleportes, { Name = "Hospital", Description = "Teleporta para o Hospital", Callback = function() teleportar(-317, 5, 21, "Hospital") end })
UI.Button(Tabs.Teleportes, { Name = "Morro", Description = "Teleporta para o Morro", Callback = function() teleportar(-349, 66, -458, "Morro") end })
UI.Button(Tabs.Teleportes, { Name = "Floresta", Description = "Teleporta para a Floresta", Callback = function() teleportar(-254, 7, 1089, "Floresta") end })
UI.Button(Tabs.Teleportes, { Name = "Praia", Description = "Teleporta para a Praia", Callback = function() teleportar(-231, 0, 742, "Praia") end })
UI.Button(Tabs.Teleportes, { Name = "Praia 2", Description = "Teleporta para a praia, perto do deck", Callback = function() teleportar(63, 4, 1477, "Praia2") end })
UI.Button(Tabs.Teleportes, { Name = "Fazenda", Description = "Teleporta para a Fazenda", Callback = function() teleportar(-852, 3, -84, "Fazenda") end })
UI.Button(Tabs.Teleportes, { Name = "Celeiro", Description = "Teleporta para o Celeiro", Callback = function() teleportar(-831, 3, -287, "Celeiro") end })
UI.Button(Tabs.Teleportes, { Name = "Hotel", Description = "Teleporta para o Hotel", Callback = function() teleportar(168, 4, 161, "Hotel") end })
UI.Button(Tabs.Teleportes, { Name = "Posto", Description = "Teleporta para o Posto de Gasolina", Callback = function() teleportar(157, 4, -301, "Posto") end })
UI.Button(Tabs.Teleportes, { Name = "Heli + Drone", Description = "Teleporta para a área do Heli + Drone", Callback = function() teleportar(-695, 260, 790, "Drone") end })
UI.Button(Tabs.Teleportes, { Name = "Casa Abandonada", Description = "Teleporta para a Casa Abandonada", Callback = function() teleportar(1036, 6, 54, "Casa Abandonada") end })
UI.Button(Tabs.Teleportes, { Name = "Iate", Description = "Teleporta para o Iate", Callback = function() teleportar(-128, 32, 850, "Iate") end })
UI.Button(Tabs.Teleportes, { Name = "Energia", Description = "Teleporta para a Usina de Energia", Callback = function() teleportar(228, 4, 813, "Energia") end })

--------------------------------------------------------------------------------
-- ABA PLAYER
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Player, {
Title = "Velocidade | Jump",
Description = "Velocidade e Pulo do seu personagem",
Icon = "7992557371"
})
local valorSpeedInput, valorJumpInput = 16, 50

UI.Input(Tabs.Player, { Name = "Selecione Speed", CurrentValue = "16", PlaceholderText = "Velocidade...", Callback = function(v) valorSpeedInput = tonumber(v) or 16 end })
UI.Button(Tabs.Player, { Name = "Definir Speed", Description = "Aplica a speed", Callback = function()
    pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = valorSpeedInput end)
    Notify("Player", "Speed: " .. valorSpeedInput, 2)
end})

UI.Input(Tabs.Player, { Name = "Selecione Jump", CurrentValue = "50", PlaceholderText = "Pulo...", Callback = function(v) valorJumpInput = tonumber(v) or 50 end })
UI.Button(Tabs.Player, { Name = "Definir Jump", Description = "Aplica o jump", Callback = function()
    pcall(function() LocalPlayer.Character.Humanoid.JumpPower = valorJumpInput end)
    Notify("Player", "Jump: " .. valorJumpInput, 2)
end})

UI.Button(Tabs.Player, { Name = "Reset Personagem", Description = "respawn", Callback = function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
    end
end})
UI.InfoBlock(Tabs.Player, {
Title = "free cam | bio",
Description = "Free Cam e bio personalizada",
Icon = "7992557371"
})
UI.Button(Tabs.Player, {
    Name = " free cam com noclip",
    Description = "free cam",
    Callback = function()
        pcall(function() LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam end)
    end
})

-- ROLEPLAY BIO
local RPNameText = nil
local function atualizarBioRemote()
    local RE = ReplicatedStorage:FindFirstChild("RE")
    RPNameText = RE and RE:FindFirstChild("1RPNam1eTex1t")
end
atualizarBioRemote()

UI.Button(Tabs.Player, {
    Name = "▪️◾ set Bio: Welcome, " .. LocalPlayer.Name,
    Description = "sla",
    Callback = function()
        atualizarBioRemote()
        if RPNameText then
            local texto = "Welcome, " .. LocalPlayer.Name
            RPNameText:FireServer("RolePlayBio", texto)
        end
    end
})

local bioCustom = ""
UI.Input(Tabs.Player, { Name = "Bio Personalizada", CurrentValue = "", PlaceholderText = "Digite seu texto...", Callback = function(t) bioCustom = t end })
UI.Button(Tabs.Player, { Name = "Aplicar Bio Personalizada", Description = "Forma mais fácil de aplicar", Callback = function()
    atualizarBioRemote()
    if RPNameText and bioCustom ~= "" then
        RPNameText:FireServer("RolePlayBio", bioCustom)
    end
end})
UI.Button(Tabs.Player, { Name = "Limpar Bio", Description = "Remove a sua bio atual", Callback = function()
    atualizarBioRemote()
    if RPNameText then
        RPNameText:FireServer("RolePlayBio", "")
        Notify("Bio", "Bio removida", 2)
    end
end})

--------------------------------------------------------------------------------
-- ABA SERVIDOR
--------------------------------------------------------------------------------
local listaJogadoresServidor = {LocalPlayer.Name}
for _, p in ipairs(Players:GetPlayers()) do
    if p.Name ~= LocalPlayer.Name then table.insert(listaJogadoresServidor, p.Name) end
end
local alvoServidorSelecionado = LocalPlayer.Name
local conexaoSentarCabeca = nil
local camOriginalServidor = nil

local dropdownServidorList = UI.Dropdown(Tabs.Servidor, {
    Name = "Lista de Jogadores",
    Options = listaJogadoresServidor,
    CurrentOption = {LocalPlayer.Name},
    Callback = function(Option) alvoServidorSelecionado = Option[1] end,
})

UI.Button(Tabs.Servidor, { Name = "Atualizar Lista", Description = "Atualiza a lista de jogadores", Callback = function()
    local novaLista = {}
    for _, p in ipairs(Players:GetPlayers()) do table.insert(novaLista, p.Name) end
    listaJogadoresServidor = novaLista
    dropdownServidorList:Refresh(listaJogadoresServidor)
end})

UI.InfoBlock(Tabs.Servidor, {
Title = "View Cam, tp, etc",
Description = "View Cam, Tp, entre outros",
Icon = "14095421789"
})
UI.Button(Tabs.Servidor, { Name = "View Cam", Description = "ver câmera do jogador selecionado", Callback = function()
    local alvo = Players:FindFirstChild(alvoServidorSelecionado)
    if alvo and alvo.Character and alvo.Character:FindFirstChild("Head") then
        camOriginalServidor = Camera.CFrame
        Camera.CameraSubject = alvo.Character.Humanoid
    end
end})

UI.Button(Tabs.Servidor, { Name = "Voltar Cam", Description = "Volta a câmera para você", Callback = function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        Camera.CameraSubject = LocalPlayer.Character.Humanoid
        if camOriginalServidor then Camera.CFrame = camOriginalServidor end
        Notify("Servidor", "Restaurada.", 2)
    end
end})

UI.Button(Tabs.Servidor, { Name = "Teleportar para Jogador", Description = "Teleporta até o jogador", Callback = function()
    local alvo = Players:FindFirstChild(alvoServidorSelecionado)
    if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = alvo.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
        Notify("Servidor", "Teleportado!", 2)
    end
end})
--[[
UI.Button(Tabs.Servidor, { Name = "HeadSit", Description = "Senta na cabeça do jogador", Callback = function()
    local alvo = Players:FindFirstChild(alvoServidorSelecionado)
    if alvo and alvo.Character and alvo.Character:FindFirstChild("Head") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        if conexaoSentarCabeca then conexaoSentarCabeca:Disconnect() end
        conexaoSentarCabeca = RunService.Stepped:Connect(function()
            pcall(function()
                if alvo and alvo.Character and alvo.Character:FindFirstChild("Head") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = alvo.Character.Head.CFrame + Vector3.new(0, 1.5, 0)
                    LocalPlayer.Character.Humanoid.Sit = true
                end
            end)
        end)
    end
end})

UI.Button(Tabs.Servidor, { Name = "Sair da cabeça", Description = "Sai da cabeça do jogador", Callback = function()
    if conexaoSentarCabeca then conexaoSentarCabeca:Disconnect(); conexaoSentarCabeca = nil end
    pcall(function() LocalPlayer.Character.Humanoid.Sit = false end)
end})
--]]
UI.Button(Tabs.Servidor, { Name = "Disconnect", Description = "Desconecta do servidor atual", Callback = function()
    LocalPlayer:Kick("Disconnected by Rd4X.")
end})

UI.Button(Tabs.Servidor, {
    Name = "Menu TP rápido",
    Description = "Teleport",
    Callback = function()
        local menu = Instance.new("Frame", ScreenGui)
        menu.Size = UDim2.new(0, 220, 0, 300)
        menu.Position = UDim2.new(0.5, -110, 0.5, -150)
        menu.BackgroundColor3 = COR_SECUNDARIA
        menu.BackgroundTransparency = 0.1
        menu.BorderSizePixel = 0
        menu.ZIndex = 2000

        local cM = Instance.new("UICorner", menu)
        cM.CornerRadius = UDim.new(0, 8)

        local titulo = Instance.new("TextLabel", menu)
        titulo.Size = UDim2.new(1, 0, 0, 30)
        titulo.BackgroundTransparency = 1
        titulo.Text = "Teleportar para..."
        titulo.TextColor3 = COR_TEXTO
        titulo.TextSize = 12
        titulo.Font = Enum.Font.GothamBold
        titulo.ZIndex = 2001

        local scroll = Instance.new("ScrollingFrame", menu)
        scroll.Size = UDim2.new(1, -10, 1, -40)
        scroll.Position = UDim2.new(0, 5, 0, 35)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel = 0
        scroll.ScrollBarThickness = 2
        scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scroll.ZIndex = 2001

        local layout = Instance.new("UIListLayout", scroll)
        layout.Padding = UDim.new(0, 4)

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local b = Instance.new("TextButton", scroll)
                b.Size = UDim2.new(1, -4, 0, 26)
                b.BackgroundColor3 = COR_FUNDO
                b.BackgroundTransparency = 0.3
                b.BorderSizePixel = 0
                b.Text = p.Name
                b.TextColor3 = COR_TEXTO
                b.TextSize = 10
                b.Font = Enum.Font.Gotham
                b.ZIndex = 2002

                local cB = Instance.new("UICorner", b)
                cB.CornerRadius = UDim.new(0, 6)

                b.MouseButton1Click:Connect(function()
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    end
                    menu:Destroy()
                end)
            end
        end

        local x = Instance.new("TextButton", menu)
        x.Size = UDim2.new(0, 20, 0, 20)
        x.Position = UDim2.new(1, -24, 0, 5)
        x.BackgroundTransparency = 1
        x.Text = "❌"
        x.TextColor3 = COR_VERMELHO
        x.TextSize = 12
        x.Font = Enum.Font.GothamBold
        x.ZIndex = 2002
        x.MouseButton1Click:Connect(function() menu:Destroy() end)
    end
})

UI.InfoBlock(Tabs.Servidor, {
    Title = "Posição",
    Description = "Salvar posição, teleportar, remover (auto-save)",
    Icon = "14095421789"
})

-- =========================================
-- PERSISTÊNCIA (auto-save em JSON)
-- =========================================
if type(makefolder) == "function" then pcall(makefolder, "Rd4X") end
local WP_FILE = "Rd4X/waypoints.json"

local function cframeToTable(cf)
    local r, u, l = cf.RightVector, cf.UpVector, cf.LookVector
    return {
        x = cf.X, y = cf.Y, z = cf.Z,
        r = {r.X, r.Y, r.Z},
        u = {u.X, u.Y, u.Z},
        l = {l.X, l.Y, l.Z}
    }
end

local function tableToCFrame(t)
    return CFrame.new(
        t.x, t.y, t.z,
        t.r[1], t.u[1], -t.l[1],
        t.r[2], t.u[2], -t.l[2],
        t.r[3], t.u[3], -t.l[3]
    )
end

local waypoints = {}
local function saveWaypoints()
    if type(writefile) ~= "function" then return end
    local serializable = {}
    for _, wp in ipairs(waypoints) do
        table.insert(serializable, {
            nome = wp.nome,
            cframe = cframeToTable(wp.pos)
        })
    end
    pcall(function()
        writefile(WP_FILE, HttpService:JSONEncode(serializable))
    end)
end

local function loadWaypoints()
    if type(readfile) ~= "function" then return {} end
    local ok, data = pcall(readfile, WP_FILE)
    if not ok or not data or data == "" then return {} end

    local ok2, decoded = pcall(function() return HttpService:JSONDecode(data) end)
    if not ok2 or type(decoded) ~= "table" then return {} end

    local loaded = {}
    for _, entry in ipairs(decoded) do
        if type(entry) == "table" and entry.nome and entry.cframe then
            local ok3, cf = pcall(tableToCFrame, entry.cframe)
            if ok3 and cf then
                table.insert(loaded, {nome = entry.nome, pos = cf})
            end
        end
    end
    return loaded
end
waypoints = loadWaypoints()

local waypoints = loadWaypoints()

-- =========================================
-- Container da lista de waypoints salvos
-- =========================================
local WaypointListContainer = Instance.new("Frame", Tabs.Servidor)
WaypointListContainer.Size = UDim2.new(1, -4, 0, 0)
WaypointListContainer.AutomaticSize = Enum.AutomaticSize.Y
WaypointListContainer.BackgroundTransparency = 1
WaypointListContainer.ZIndex = 6

local wlLayout = Instance.new("UIListLayout", WaypointListContainer)
wlLayout.Padding = UDim.new(0, 4)
wlLayout.SortOrder = Enum.SortOrder.LayoutOrder

local function refreshWaypoints()
    for _, ch in ipairs(WaypointListContainer:GetChildren()) do
        if ch:IsA("TextButton") or ch:IsA("TextLabel") or ch:IsA("Frame") then
            ch:Destroy()
        end
    end

    local titulo = Instance.new("TextLabel", WaypointListContainer)
    titulo.Size = UDim2.new(1, 0, 0, 18)
    titulo.BackgroundTransparency = 1
    titulo.Text = "Waypoints salvos (" .. #waypoints .. ")"
    titulo.TextColor3 = COR_TEXTO
    titulo.TextSize = 11
    titulo.Font = Enum.Font.GothamBold
    titulo.TextXAlignment = Enum.TextXAlignment.Left
    titulo.ZIndex = 7
    titulo.LayoutOrder = 1

    if #waypoints == 0 then
        local empty = Instance.new("TextLabel", WaypointListContainer)
        empty.Size = UDim2.new(1, 0, 0, 22)
        empty.BackgroundTransparency = 1
        empty.Text = "Nenhum waypoint. Clique em 'Salvar' acima."
        empty.TextColor3 = COR_TEXTO_CINZA
        empty.TextSize = 9
        empty.Font = Enum.Font.Gotham
        empty.TextXAlignment = Enum.TextXAlignment.Left
        empty.TextWrapped = true
        empty.ZIndex = 7
        empty.LayoutOrder = 2
        return
    end

    for i, wp in ipairs(waypoints) do
        local row = Instance.new("Frame", WaypointListContainer)
        row.Size = UDim2.new(1, 0, 0, 34)
        row.BackgroundColor3 = COR_SECUNDARIA
        row.BackgroundTransparency = TRANSP_CARDS
        row.BorderSizePixel = 0
        row.ZIndex = 6
        row.LayoutOrder = 1 + i
        Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

        local nome = Instance.new("TextLabel", row)
        nome.Size = UDim2.new(1, -92, 1, 0)
        nome.Position = UDim2.new(0, 10, 0, 0)
        nome.BackgroundTransparency = 1
        nome.Text = wp.nome
        nome.TextColor3 = COR_TEXTO
        nome.TextSize = 11
        nome.Font = Enum.Font.GothamBold
        nome.TextXAlignment = Enum.TextXAlignment.Left
        nome.TextTruncate = Enum.TextTruncate.AtEnd
        nome.ZIndex = 7

        local tpBtn = Instance.new("TextButton", row)
        tpBtn.Size = UDim2.new(0, 42, 1, -10)
        tpBtn.Position = UDim2.new(1, -82, 0, 5)
        tpBtn.BackgroundColor3 = COR_VERDE
        tpBtn.BackgroundTransparency = TRANSP_BOTAO_VERDE
        tpBtn.BorderSizePixel = 0
        tpBtn.Text = "TP"
        tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tpBtn.TextSize = 10
        tpBtn.Font = Enum.Font.GothamBold
        tpBtn.AutoButtonColor = false
        tpBtn.ZIndex = 8
        Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 5)

        tpBtn.MouseButton1Click:Connect(function()
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = wp.pos + Vector3.new(0, 3, 0)
                Notify("Waypoint", "Teleportado: " .. wp.nome, 2)
            end
        end)

        local delBtn = Instance.new("TextButton", row)
        delBtn.Size = UDim2.new(0, 32, 1, -10)
        delBtn.Position = UDim2.new(1, -36, 0, 5)
        delBtn.BackgroundColor3 = COR_VERMELHO
        delBtn.BackgroundTransparency = TRANSP_BOTAO_VERDE
        delBtn.BorderSizePixel = 0
        delBtn.Text = "✕"
        delBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        delBtn.TextSize = 11
        delBtn.Font = Enum.Font.GothamBold
        delBtn.AutoButtonColor = false
        delBtn.ZIndex = 8
        Instance.new("UICorner", delBtn).CornerRadius = UDim.new(0, 5)

        delBtn.MouseButton1Click:Connect(function()
            for j, w in ipairs(waypoints) do
                if w == wp then
                    table.remove(waypoints, j)
                    break
                end
            end
            saveWaypoints()      -- 👈 AUTO-SAVE
            Notify("Waypoint", "Removido: " .. wp.nome, 2)
            refreshWaypoints()
        end)
    end
end

refreshWaypoints()

-- =========================================
-- Botão Salvar (popup nome + auto-save)
-- =========================================
UI.Button(Tabs.Servidor, {
    Name = "Salvar",
    Description = "Salva a posição atual com um nome",
    Callback = function()
        if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
            Notify("Waypoint", "Personagem não encontrado!", 2)
            return
        end
        local posAtual = LocalPlayer.Character.HumanoidRootPart.CFrame

        local menu = Instance.new("Frame", ScreenGui)
        menu.Size = UDim2.new(0, 260, 0, 160)
        menu.Position = UDim2.new(0.5, -130, 0.5, -80)
        menu.BackgroundColor3 = COR_SECUNDARIA
        menu.BackgroundTransparency = 0.1
        menu.BorderSizePixel = 0
        menu.ZIndex = 2000
        Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 8)

        local stroke = Instance.new("UIStroke", menu)
        stroke.Color = COR_VERMELHO
        stroke.Thickness = 1

        local titulo = Instance.new("TextLabel", menu)
        titulo.Size = UDim2.new(1, -20, 0, 20)
        titulo.Position = UDim2.new(0, 10, 0, 10)
        titulo.BackgroundTransparency = 1
        titulo.Text = "Nome do waypoint"
        titulo.TextColor3 = COR_TEXTO
        titulo.TextSize = 12
        titulo.Font = Enum.Font.GothamBold
        titulo.TextXAlignment = Enum.TextXAlignment.Left
        titulo.ZIndex = 2001

        local input = Instance.new("TextBox", menu)
        input.Size = UDim2.new(1, -20, 0, 32)
        input.Position = UDim2.new(0, 10, 0, 38)
        input.BackgroundColor3 = COR_FUNDO
        input.BackgroundTransparency = TRANSP_INPUT
        input.BorderSizePixel = 0
        input.Text = ""
        input.PlaceholderText = "Ex: Minha Casa"
        input.PlaceholderColor3 = COR_TEXTO_CINZA
        input.TextColor3 = COR_TEXTO
        input.TextSize = 11
        input.Font = Enum.Font.Gotham
        input.ClearTextOnFocus = false
        input.ZIndex = 2001
        Instance.new("UICorner", input).CornerRadius = UDim.new(0, 4)
        Instance.new("UIPadding", input).PaddingLeft = UDim.new(0, 6)

        local btnSalvar = Instance.new("TextButton", menu)
        btnSalvar.Size = UDim2.new(1, -20, 0, 30)
        btnSalvar.Position = UDim2.new(0, 10, 0, 80)
        btnSalvar.BackgroundColor3 = COR_VERDE
        btnSalvar.BackgroundTransparency = TRANSP_BOTAO_VERDE
        btnSalvar.BorderSizePixel = 0
        btnSalvar.Text = "Salvar"
        btnSalvar.TextColor3 = Color3.fromRGB(255, 255, 255)
        btnSalvar.TextSize = 11
        btnSalvar.Font = Enum.Font.GothamBold
        btnSalvar.AutoButtonColor = false
        btnSalvar.ZIndex = 2001
        Instance.new("UICorner", btnSalvar).CornerRadius = UDim.new(0, 5)

        local btnCancelar = Instance.new("TextButton", menu)
        btnCancelar.Size = UDim2.new(1, -20, 0, 22)
        btnCancelar.Position = UDim2.new(0, 10, 0, 118)
        btnCancelar.BackgroundTransparency = 1
        btnCancelar.Text = "Cancelar"
        btnCancelar.TextColor3 = COR_TEXTO_CINZA
        btnCancelar.TextSize = 10
        btnCancelar.Font = Enum.Font.Gotham
        btnCancelar.ZIndex = 2001
        btnCancelar.MouseButton1Click:Connect(function() menu:Destroy() end)

        local x = Instance.new("TextButton", menu)
        x.Size = UDim2.new(0, 20, 0, 20)
        x.Position = UDim2.new(1, -24, 0, 5)
        x.BackgroundTransparency = 1
        x.Text = "❌"
        x.TextColor3 = COR_VERMELHO
        x.TextSize = 12
        x.Font = Enum.Font.GothamBold
        x.ZIndex = 2002
        x.MouseButton1Click:Connect(function() menu:Destroy() end)

        local function salvar()
            local nome = input.Text
            if nome == "" then nome = "Local " .. (#waypoints + 1) end
            table.insert(waypoints, {nome = nome, pos = posAtual})
            saveWaypoints()      -- 👈 AUTO-SAVE
            Notify("Waypoint", "Salvo: " .. nome, 2)
            menu:Destroy()
            refreshWaypoints()
        end

        btnSalvar.MouseButton1Click:Connect(salvar)
        input.FocusLost:Connect(function(enter) if enter then salvar() end end)
    end
})

-- =========================================
-- Botão "Limpar todos" (auto-save também)
-- =========================================
UI.Button(Tabs.Servidor, {
    Name = "Limpar todos",
    Description = "Apaga todos os waypoints salvos",
    Callback = function()
        waypoints = {}
        saveWaypoints()      -- 👈 AUTO-SAVE (grava array vazio)
        refreshWaypoints()
        Notify("Waypoint", "Todos removidos!", 2)
    end
})

-- =========================================
-- Menu TP rápido (jogadores) — inalterado
-- =========================================
UI.Button(Tabs.Servidor, {
    Name = "Menu TP rápido",
    Description = "Teleportar para um jogador",
    Callback = function()
        local menu = Instance.new("Frame", ScreenGui)
        menu.Size = UDim2.new(0, 220, 0, 300)
        menu.Position = UDim2.new(0.5, -110, 0.5, -150)
        menu.BackgroundColor3 = COR_SECUNDARIA
        menu.BackgroundTransparency = 0.1
        menu.BorderSizePixel = 0
        menu.ZIndex = 2000
        Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 8)

        local titulo = Instance.new("TextLabel", menu)
        titulo.Size = UDim2.new(1, 0, 0, 30)
        titulo.BackgroundTransparency = 1
        titulo.Text = "Teleportar para..."
        titulo.TextColor3 = COR_TEXTO
        titulo.TextSize = 12
        titulo.Font = Enum.Font.GothamBold
        titulo.ZIndex = 2001

        local scroll = Instance.new("ScrollingFrame", menu)
        scroll.Size = UDim2.new(1, -10, 1, -40)
        scroll.Position = UDim2.new(0, 5, 0, 35)
        scroll.BackgroundTransparency = 1
        scroll.BorderSizePixel = 0
        scroll.ScrollBarThickness = 2
        scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
        scroll.ZIndex = 2001

        local layout = Instance.new("UIListLayout", scroll)
        layout.Padding = UDim.new(0, 4)

        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local b = Instance.new("TextButton", scroll)
                b.Size = UDim2.new(1, -4, 0, 26)
                b.BackgroundColor3 = COR_FUNDO
                b.BackgroundTransparency = 0.3
                b.BorderSizePixel = 0
                b.Text = p.Name
                b.TextColor3 = COR_TEXTO
                b.TextSize = 10
                b.Font = Enum.Font.Gotham
                b.ZIndex = 2002
                Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

                b.MouseButton1Click:Connect(function()
                    if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                    end
                    menu:Destroy()
                end)
            end
        end

        local x = Instance.new("TextButton", menu)
        x.Size = UDim2.new(0, 20, 0, 20)
        x.Position = UDim2.new(1, -24, 0, 5)
        x.BackgroundTransparency = 1
        x.Text = "❌"
        x.TextColor3 = COR_VERMELHO
        x.TextSize = 12
        x.Font = Enum.Font.GothamBold
        x.ZIndex = 2002
        x.MouseButton1Click:Connect(function() menu:Destroy() end)
    end
})

--------------------------------------------------------------------------------
-- ABA CARROS
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Carros, {
Title = "Speed",
Description = "Velocidade do carro",
Icon = "82734412385826"
})
local velocidadeCarroInput, forcaArrancadaInput = 50, 100

UI.Input(Tabs.Carros, { Name = "Velocidade do Carro", CurrentValue = "50", PlaceholderText = "Velocidade...", Callback = function(v) velocidadeCarroInput = tonumber(v) or 50 end })
UI.Button(Tabs.Carros, { Name = "Inserir Velocidade", Description = "aplicar car speed < Pode ter falhas >", Callback = function()
    pcall(function() LocalPlayer.Character.Humanoid.SeatPart.MaxSpeed = velocidadeCarroInput end)
end})

UI.Input(Tabs.Carros, { Name = "Força de Arrancada", CurrentValue = "100", PlaceholderText = "Força...", Callback = function(v) forcaArrancadaInput = tonumber(v) or 100 end })
UI.Button(Tabs.Carros, { Name = "Definir Arrancada", Description = "Aplica a força de arrancada no carro", Callback = function()
    pcall(function() LocalPlayer.Character.Humanoid.SeatPart.Torque = forcaArrancadaInput end)
end})
--[[
UI.InfoBlock(Tabs.Carros, {
Title = "Carros Bloqueados",
Description = "Desbloqueie Carros Bloqueados",
Icon = "82734412385826"
})
UI.Button(Tabs.Carros, { Name = "Desbloquear carros", Description = "Permite dirigir qualquer carro", Callback = function()
    pcall(function()
        for _, v in ipairs(Workspace:GetDescendants()) do
            if v:IsA("VehicleSeat") then v.Disabled = false; v.Locked = false end
        end
    end)
end})


UI.Button(Tabs.Carros, { Name = "Fly Car", Description = "Carrega o script de carro voador", Callback = function()
    Notify("Carros", "Carregando Fly Car...", 2)
    task.spawn(function()
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/willthingVN/script-lua/refs/heads/main/Vehicle%20Fly%20Gui.lua"))()
        end)
    end)
end})
--]]
--[[
local rainbowCarAtivo = false
UI.Toggle(Tabs.Carros, {
    Name = "RGB Car",
    CurrentValue = false,
    Callback = function(state)
        rainbowCarAtivo = state
        if rainbowCarAtivo then
            task.spawn(function()
                local RE = ReplicatedStorage:FindFirstChild("RE")
                local carColorRemote = RE and RE:FindFirstChild("1Ca1rColo1r")
                local hue = 0
                while rainbowCarAtivo do
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    if hum and hum.SeatPart and hum.SeatPart:IsA("VehicleSeat") then
                        hue = (hue + 0.01) % 1
                        local corRGB = Color3.fromHSV(hue, 1, 1)
                        if carColorRemote then
                            pcall(function() carColorRemote:FireServer("PickingCarColor", corRGB) end)
                        end
                        local veiculo = hum.SeatPart:FindFirstAncestorOfClass("Model")
                        if veiculo then
                            for _, part in ipairs(veiculo:GetDescendants()) do
                                if part:IsA("BasePart") and part.Name ~= "Seat" then
                                    pcall(function() part.Color = corRGB end)
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

local autoDriveAtivo = false
local destinoSelecionado = "🏛️ Praça"
local LOCAIS_BROOKHAVEN = {
    ["🏛️ Praça"]            = Vector3.new(-26, 7, 1),
    ["🏥 Hospital"]         = Vector3.new(-317, 5, 21),
    ["⛰️ Morro"]            = Vector3.new(-349, 66, -458),
    ["🌲 Floresta"]         = Vector3.new(-254, 7, 1089),
    ["🩳 Praia"]            = Vector3.new(-231, 0, 742),
    ["🐥 Fazenda"]          = Vector3.new(-852, 3, -84),
    ["🐴 Celeiro"]          = Vector3.new(-831, 3, -287),
    ["🛏️ Hotel"]            = Vector3.new(168, 4, 161),
    ["⛽ Posto de Gasolina"] = Vector3.new(157, 4, -301),
    ["🚁 Heli + Drone"]     = Vector3.new(-695, 260, 790),
    ["🏠 Casa Abandonada"]  = Vector3.new(1036, 6, 54),
    ["⛵ Iate"]             = Vector3.new(-128, 32, 850),
    ["🔌 Usina de Energia"] = Vector3.new(228, 4, 813),
}


local function obterListaPiloto()
    local lista = {}
    for nomeLocal, _ in pairs(LOCAIS_BROOKHAVEN) do table.insert(lista, nomeLocal) end
    for _, p in ipairs(Players:GetPlayers()) do table.insert(lista, "👤 " .. p.Name) end
    return lista
end

local dropdownPiloto = UI.Dropdown(Tabs.Carros, {
    Name = "🎯 Selecione o Destino (Local ou Player)",
    Options = obterListaPiloto(),
    CurrentOption = {"🏛️ Praça"},
    Callback = function(opt) if opt and opt[1] then destinoSelecionado = opt[1] end end
})

UI.Button(Tabs.Carros, {
    Name = "ERROR",
    Description = "ERROR",
    Callback = function()
        dropdownPiloto:Refresh(obterListaPiloto())
        Notify("Carros", "INDISPONÍVEL", 2)
    end
})


UI.Toggle(Tabs.Carros, {
    Name = "Piloto Automático < Em Breve >",
    CurrentValue = false,
    Callback = function(state)
        autoDriveAtivo = state
        if autoDriveAtivo then
            Notify("Carros", "Piloto Automático ligado! Destino: " .. destinoSelecionado, 3)
            task.spawn(function()
                while autoDriveAtivo do
                    local char = LocalPlayer.Character
                    local hum = char and char:FindFirstChildOfClass("Humanoid")
                    local seat = hum and hum.SeatPart
                    if seat and seat:IsA("VehicleSeat") then
                        local veiculo = seat:FindFirstAncestorOfClass("Model") or seat.Parent
                        local posAlvo = nil
                        if LOCAIS_BROOKHAVEN[destinoSelecionado] then
                            posAlvo = LOCAIS_BROOKHAVEN[destinoSelecionado]
                        else
                            local nomeLimpo = destinoSelecionado:gsub("👤 ", "")
                            local alvo = Players:FindFirstChild(nomeLimpo)
                            if alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart") then
                                posAlvo = alvo.Character.HumanoidRootPart.Position
                            end
                        end
                        if veiculo and posAlvo then
                            local posCarro = seat.Position
                            local direcao = (Vector3.new(posAlvo.X, posCarro.Y, posAlvo.Z) - posCarro).Unit
                            if (Vector3.new(posAlvo.X, posCarro.Y, posAlvo.Z) - posCarro).Magnitude > 8 then
                                pcall(function()
                                    seat.AssemblyLinearVelocity = direcao * 50
                                    veiculo:PivotTo(CFrame.new(posCarro, Vector3.new(posAlvo.X, posCarro.Y, posAlvo.Z)))
                                end)
                            else
                                pcall(function() seat.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end)
                                Notify("Carros", "🏁 Você chegou ao destino!", 2)
                                autoDriveAtivo = false
                                break
                            end
                        end
                    else
                        Notify("Carros", "Entre no banco do motorista!", 3)
                        autoDriveAtivo = false
                        break
                    end
                    task.wait(0.05)
                end
            end)
        else
            Notify("Carros", "Piloto Automático Desativado", 2)
        end
    end
})
--]]

UI.InfoBlock(Tabs.Carros, {
Title = "Bring carros",
Description = "Bring cars",
Icon = "82734412385826"
})
UI.Button(Tabs.Carros, {
    Name = "Bring All Vehicles (Indisponível no momento)",
    Description = "Puxa todos os carros do srv",
    Callback = function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then Notify("Carros", "Character not found ", 2); return end
        local posicaoFrente = hrp.CFrame + (hrp.CFrame.LookVector * 10)
        local quantidadePuxada = 0
        pcall(function()
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("VehicleSeat") and not obj.Occupant then
                    local veiculo = obj:FindFirstAncestorOfClass("Model") or obj.Parent
                    if veiculo and veiculo:IsA("Model") then
                        veiculo:PivotTo(posicaoFrente + Vector3.new(0, quantidadePuxada * 3, 0))
                        quantidadePuxada = quantidadePuxada + 1
                    end
                end
            end
        end)
        if quantidadePuxada > 0 then
            Notify("Carros", " " .. quantidadePuxada .. " carros puxados até você!", 3)
        else
            Notify("Carros", "Nenhum carro encontrado, tente de novo.", 2)
        end
    end
})

--------------------------------------------------------------------------------
-- ABA CASAS (aviso)
--------------------------------------------------------------------------------
UI.Paragraph(Tabs.Casas, {
    Title = "Aviso do RD4X!",
    Content = "Aguarde atualizações, em breve estará disponível!",
    Icon = "18923169586",
    Height = 55
})

-- =========================
-- CONTROLES DA ABA RGB
-- =========================
_G.RD4X_RGB = _G.RD4X_RGB or {
    Ativo = true,
    Alvo = "Nome e Bio",          -- "Nome e Bio", "Apenas Nome", "Apenas Bio"
    Modo = "RGB Completo",        -- "RGB Completo", "Gradiente", "Cor Única"
    FamiliaCor = "Azul",          -- "Azul", "Vermelho", "Verde", "Roxo", "Rosa", "Amarelo"
    Intensidade = "Vibrante",     -- "Suave", "Equilibrada", "Vibrante"
    Velocidade = 65               -- 1 até 100
}

local INTENSIDADES_RGB = {
    ["Suave"] = { sat = 0.45, val = 1.0 },
    ["Equilibrada"] = { sat = 0.75, val = 1.0 },
    ["Vibrante"] = { sat = 1.0, val = 1.0 }
}

local FAIXAS_GRADIENTE = {
    ["Azul"] = { min = 0.52, max = 0.68 },
    ["Vermelho"] = { min = 0.0, max = 0.05 },
    ["Verde"] = { min = 0.25, max = 0.42 },
    ["Roxo"] = { min = 0.72, max = 0.82 },
    ["Rosa"] = { min = 0.84, max = 0.95 },
    ["Amarelo"] = { min = 0.11, max = 0.18 }
}

local function obterParametrosVelocidade(velNum)
    local v = math.clamp(tonumber(velNum) or 50, 1, 100) / 100
    local delay = 0.65 - (v * 0.59)
    local passo = 0.015 + (v * 0.135)
    return passo, delay
end

local function calcularCorRGB(ciclo)
    local cfg = _G.RD4X_RGB
    local inten = INTENSIDADES_RGB[cfg.Intensidade] or INTENSIDADES_RGB["Vibrante"]

    if cfg.Modo == "Cor Única" then
        local faixa = FAIXAS_GRADIENTE[cfg.FamiliaCor] or FAIXAS_GRADIENTE["Azul"]
        local meio = (faixa.min + faixa.max) * 0.5
        return Color3.fromHSV(meio, inten.sat, inten.val)
    elseif cfg.Modo == "Gradiente" then
        local faixa = FAIXAS_GRADIENTE[cfg.FamiliaCor] or FAIXAS_GRADIENTE["Azul"]
        local onda = (math.sin(ciclo * math.pi * 2) + 1) * 0.5
        local hue = faixa.min + (faixa.max - faixa.min) * onda
        return Color3.fromHSV(hue % 1, inten.sat, inten.val)
    else
        return Color3.fromHSV(ciclo % 1, inten.sat, inten.val)
    end
end

local rgbTab = Tabs.Rgb
UI.InfoBlock(Tabs.Rgb, {
Title = "RGB | Speed RGB",
Description = "Ative, desative e ajuste aqui suas opções de RGB.",
Icon = "107865760439298"
})

UI.Toggle(rgbTab, {
    Name = "Ativar / Desativar RGB",
    CurrentValue = true,
    Callback = function(v)
        _G.RD4X_RGB.Ativo = v
        if v then
            iniciarLoopRGB()
        end
    end
})


UI.Slider(rgbTab, {
    Name = "Velocidade do RGB",
    Min = 1,
    Max = 100,
    CurrentValue = _G.RD4X_RGB.Velocidade,
    Suffix = "%",
    Callback = function(val)
        _G.RD4X_RGB.Velocidade = val
    end
})

UI.Dropdown(rgbTab, {
    Name = "Aplicar em",
    Options = { "Nome e Bio", "Apenas Nome", "Apenas Bio" },
    CurrentOption = { _G.RD4X_RGB.Alvo },
    Callback = function(opt)
        if opt and opt[1] then
            _G.RD4X_RGB.Alvo = opt[1]
        end
    end
})

UI.Dropdown(rgbTab, {
    Name = "Modo de Cor",
    Options = { "RGB Completo", "Gradiente", "Cor Única" },
    CurrentOption = { _G.RD4X_RGB.Modo },
    Callback = function(opt)
        if opt and opt[1] then
            _G.RD4X_RGB.Modo = opt[1]
        end
    end
})

UI.Dropdown(rgbTab, {
    Name = "Faixa / Cor",
    Options = { "Azul", "Vermelho", "Verde", "Roxo", "Rosa", "Amarelo" },
    CurrentOption = { _G.RD4X_RGB.FamiliaCor },
    Callback = function(opt)
        if opt and opt[1] then
            _G.RD4X_RGB.FamiliaCor = opt[1]
        end
    end
})

UI.Dropdown(rgbTab, {
    Name = "Intensidade",
    Options = { "Suave", "Equilibrada", "Vibrante" },
    CurrentOption = { _G.RD4X_RGB.Intensidade },
    Callback = function(opt)
        if opt and opt[1] then
            _G.RD4X_RGB.Intensidade = opt[1]
        end
    end
})
-- =========================
-- LOOP DO RGB (CONTROLADO)
-- =========================
local rgbTaskRodando = false

local function iniciarLoopRGB()
    if rgbTaskRodando then return end
    rgbTaskRodando = true

    task.spawn(function()
        local ciclo = 0
        while _G.RD4X_RGB and _G.RD4X_RGB.Ativo do
            local cfg = _G.RD4X_RGB
            local RE = ReplicatedStorage:FindFirstChild("RE")
            local rpColor = RE and RE:FindFirstChild("1RPNam1eColo1r")

            local passo, delay = obterParametrosVelocidade(cfg.Velocidade)
            ciclo = (ciclo + passo) % 1
            local corAtual = calcularCorRGB(ciclo)

            local usarNome = (cfg.Alvo == "Nome e Bio" or cfg.Alvo == "Apenas Nome")
            local usarBio = (cfg.Alvo == "Nome e Bio" or cfg.Alvo == "Apenas Bio")

            if rpColor and rpColor.Parent then
                if usarNome then
                    pcall(function()
                        rpColor:FireServer("PickingRPNameColor", corAtual)
                    end)
                end
                if usarBio then
                    pcall(function()
                        rpColor:FireServer("PickingRPBioColor", corAtual)
                    end)
                end
            end

            task.wait(delay)
        end
        rgbTaskRodando = false
    end)
end

if _G.RD4X_RGB.Ativo then
    iniciarLoopRGB()
end

