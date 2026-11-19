if not _G.RD4X_UI then error("[RD4X] Execute a Parte 1/4 primeiro!") end

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local UI        = _G.RD4X_UI
local Notify    = _G.RD4X_Notify
local Tabs      = _G.RD4X_Tabs

-- MÚSICAS
local PlayerToolEvent = nil
local function atualizarToolRemote()
    local RE = ReplicatedStorage:FindFirstChild("RE")
    PlayerToolEvent = RE and RE:FindFirstChild("PlayerToolEvent")
end
atualizarToolRemote()
UI.InfoBlock(Tabs.Musicas, {
Title = "Ids Músicas",
Description = "Ids d músicas",
Icon = "105472378838470"
})
local idMusicaCustom = ""
UI.Input(Tabs.Musicas, { Name = "Ids De Áudios", CurrentValue = "", PlaceholderText = "Ex: 9048375035", Callback = function(t) idMusicaCustom = t end })
UI.Button(Tabs.Musicas, {
    Name = "Tocar Audio ID Personalizado",
    Description = "Toca a música pelo ID inserido acima",
    Callback = function()
        atualizarToolRemote()
        if PlayerToolEvent and idMusicaCustom ~= "" then
            PlayerToolEvent:FireServer("ToolMusicText", idMusicaCustom)
        end
    end
})

local LISTA_FUNK = {
    ["piranha"]               = "103811087853875",
    ["os menor"]              = "126719632721905",
    ["vai caindo com a bct"]  = "74967642581893",
    ["facada"]                = "81730477878065",
    ["Tipo nino"]             = "140336018782383",
    ["lacs"]                  = "121544291272731",
    ["Funk"]                  = "74206017407052",
    ["onda do birimbau"]      = "90728144562197",
    ["piseiro bahiano"]       = "111425053457342",
    ["cheiro"]                = "102430799050444",
    ["afrozada"]              = "116257708415048",
    ["sequência de papapey"]  = "127060465281063",
    ["lampada da sorte"]  = "71393805905055",
    ["bem louca"]  = "94365050554101",
    ["jantar em familia"]  = "103043727188319",
    ["místico 2"]  = "112182302553336",
    ["koala"]  = "136574160308808",
    ["tufitufi"]  = "132901244600312",
    ["madley"]  = "81928219376467",
    ["mágica 2"]  = "81733205826673",
    ["desestressabb"]  = "131777662810651",
    ["mtg jogador raro BH"]  = "94678954269340",
    ["joga joga"]  = "109330943148950",
    ["tak"]  = "128417229744862",
    ["ta nervoso d+"]  = "92999059792601",
    ["m4"]  = "76707483030355",
    ["antares"]  = "73461924431293",
    ["azul piscina"]  = "80512054525157",
    ["jssr"]  = "99857365723549",
}
local LISTA_FORRO = {
    ["uma botadinha"]         = "84624301411909",
    ["eu me apaixonei"]       = "139414982330352",
    ["Pisada xl"]             = "70508008395270",
    ["notificação preferida"] = "90137280531474",
    ["só fé"]                 = "139128878060651",
    ["desça daí seu corno"]   = "1197388789221996",
    ["até o fim"]  = "139777248910220",
    ["apaixonei na sua botada"]  = "132901244600372",
}
local LISTA_PHONK = {
    ["Phonk"]              = "COLE_O_ID_AQUI",
    ["Phonk"]              = "COLE_O_ID_AQUI",
}

local function tocarMusicaPorNome(lista, nome)
    atualizarToolRemote()
    local id = lista[nome]
    if PlayerToolEvent and id and id ~= "COLE_O_ID_AQUI" then
        PlayerToolEvent:FireServer("ToolMusicText", id)
    end
end
local function obterNomes(lista)
    local nomes = {}
    for nome, _ in pairs(lista) do table.insert(nomes, nome) end
    table.sort(nomes)
    return nomes
end

UI.Dropdown(Tabs.Musicas, {
    Name = "Funk", Options = obterNomes(LISTA_FUNK),
    CurrentOption = {"Selecione um Funk..."},
    Callback = function(opt) if opt and opt[1] then tocarMusicaPorNome(LISTA_FUNK, opt[1]) end end
})
UI.Dropdown(Tabs.Musicas, {
    Name = "Forró", Options = obterNomes(LISTA_FORRO),
    CurrentOption = {"Selecione um Forró..."},
    Callback = function(opt) if opt and opt[1] then tocarMusicaPorNome(LISTA_FORRO, opt[1]) end end
})
UI.Dropdown(Tabs.Musicas, {
    Name = "Phonk", Options = obterNomes(LISTA_PHONK),
    CurrentOption = {"Selecione um Phonk..."},
    Callback = function(opt) if opt and opt[1] then tocarMusicaPorNome(LISTA_PHONK, opt[1]) end end
})

--------------------------------------------------------------------------------
-- TROLL
--------------------------------------------------------------------------------
local alvoTrollSelecionado = LocalPlayer.Name
local function obterListaJogadoresTroll()
    local lista = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(lista, p.Name) end
    end
    if #lista == 0 then table.insert(lista, LocalPlayer.Name) end
    return lista
end

UI.InfoBlock(Tabs.Troll, {
    Title = "Bus Kill (void)",
    Description = "Mata o alvo jogando ele no void",
    Icon = "14436167217"
})

local dropdownAlvoTroll = UI.Dropdown(Tabs.Troll, {
    Name = "Selecionar alvo",
    Options = obterListaJogadoresTroll(),
    CurrentOption = {obterListaJogadoresTroll()[1]},
    Callback = function(opt)
        if opt and opt[1] then
            alvoTrollSelecionado = opt[1]
            Notify("Troll", "Alvo selecionado: " .. alvoTrollSelecionado, 2)
        end
    end,
})

UI.Button(Tabs.Troll, {
    Name = "Atualizar Lista",
    Description = "Atualiza a lista de jogadores",
    Callback = function()
        dropdownAlvoTroll:Refresh(obterListaJogadoresTroll())
        Notify("Troll", "Lista de jogadores atualizada.", 2)
    end,
})

-- BUS KILL
local busAtivo = false

UI.Button(Tabs.Troll, {
    Name = "Iniciar Bus Kill (Void)",
    Description = "Joga o player selecionado para o void",
    Callback = function()
        if busAtivo then Notify("Troll", "Já possui um ônibus em perseguição", 2); return end

        local RE = ReplicatedStorage:FindFirstChild("RE")
        local CarRemote = RE and RE:FindFirstChild("1Ca1r")
        if not CarRemote then Notify("Erro", "Tente Novamente", 3); return end

        local alvo = Players:FindFirstChild(alvoTrollSelecionado)
        if not alvo or not alvo.Character then Notify("Troll", "Selecione um player na lista", 3); return end

        local rootAlvo = alvo.Character:FindFirstChild("HumanoidRootPart")
        local humanoidAlvo = alvo.Character:FindFirstChildOfClass("Humanoid")
        if not rootAlvo or not humanoidAlvo then Notify("Troll", "...!", 3); return end

        busAtivo = true
        CarRemote:FireServer("PickingCar", "SchoolBus")
        Notify("Bus Kill", "Gerando ônibus, aguarde...", 3)

        task.spawn(function()
            local function encontrarNovoOnibus()
                local tInicio = tick()
                local ultimoOnibus = nil
                local ultimoSeat = nil
                while tick() - tInicio < 4 do
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("Model") then
                            local nomeUpper = obj.Name:upper()
                            local playerUpper = LocalPlayer.Name:upper()
                            if (nomeUpper:find("BUS") or nomeUpper:find("SCHOOL") or nomeUpper:find(playerUpper)) then
                                local seat = obj:FindFirstChildOfClass("VehicleSeat") or obj:FindFirstChild("VehicleSeat", true)
                                if seat and seat.Position.Y > -50 then
                                    ultimoOnibus = obj
                                    ultimoSeat = seat
                                end
                            end
                        end
                    end
                    if ultimoOnibus and ultimoSeat then return ultimoOnibus, ultimoSeat end
                    task.wait(0.2)
                end
                return nil, nil
            end

            local onibus, seatMotorista = encontrarNovoOnibus()
            local myChar = LocalPlayer.Character
            local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid")
            local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")

            if onibus and seatMotorista and myHum then
                pcall(function() seatMotorista:Sit(myHum) end)
                task.wait(0.1)

                local girando = true
                local conexaoRender
                conexaoRender = RunService.RenderStepped:Connect(function()
                    if girando and rootAlvo and rootAlvo.Parent and onibus and onibus.Parent then
                        local tempo = tick() * 25
                        local rotX = math.rad(tempo * 50 % 360)
                        local rotY = math.rad(tempo * 80 % 360)
                        local rotZ = math.rad(tempo * 30 % 360)
                        local posicaoAlvo = rootAlvo.CFrame
                        onibus:PivotTo(posicaoAlvo * CFrame.Angles(rotX, rotY, rotZ))
                    else
                        if conexaoRender then conexaoRender:Disconnect() end
                    end
                end)

                local conexaoSentouBus
                conexaoSentouBus = humanoidAlvo.Seated:Connect(function(isSeated, seat)
                    if isSeated and seat and seat:IsDescendantOf(onibus) then
                        girando = false
                        if conexaoRender then conexaoRender:Disconnect() end
                        onibus:PivotTo(CFrame.new(rootAlvo.Position.X, -300, rootAlvo.Position.Z))
                        task.wait(0.2)
                        pcall(function()
                            if myHum then myHum.Sit = false end
                            if myHrp then myHrp.CFrame = CFrame.new(-26, 7, 1) end
                        end)
                        Notify("Bus Kill", "return: 'praça'", 3)
                        if conexaoSentouBus then conexaoSentouBus:Disconnect() end
                        busAtivo = false
                    end
                end)

                task.delay(30, function()
                    girando = false
                    busAtivo = false
                    if conexaoRender then conexaoRender:Disconnect() end
                    if conexaoSentouBus then conexaoSentouBus:Disconnect() end
                end)
            else
                Notify("Erro", "Falha ao gerar novo ônibus. Tente novamente.", 3)
                busAtivo = false
            end
        end)
    end,
})

UI.Button(Tabs.Troll, {
    Name = "Stop Bus",
    Description = "Cancela a perseguição",
    Callback = function() busAtivo = false; Notify("Troll", "Bus Kill desativado", 2) end,
})

-- HEAD SIT / DOG MODE

--[[
local conexaoHeadSit = nil
UI.Toggle(Tabs.Troll, {
    Name = "Head Sit (Sentar na Cabeça do Alvo)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            local alvo = Players:FindFirstChild(alvoTrollSelecionado)
            if not alvo or not alvo.Character then
                Notify("Troll", "Selecione uma vítima!", 2)
                return
            end
            Notify("Troll", "Sentado na cabeça de: " .. alvo.Name, 2)
            if conexaoHeadSit then conexaoHeadSit:Disconnect() end
            conexaoHeadSit = RunService.RenderStepped:Connect(function()
                pcall(function()
                    local meuChar = LocalPlayer.Character
                    local meuHrp = meuChar and meuChar:FindFirstChild("HumanoidRootPart")
                    local meuHum = meuChar and meuChar:FindFirstChildOfClass("Humanoid")
                    local cabecaAlvo = alvo.Character and alvo.Character:FindFirstChild("Head")
                    if meuHrp and meuHum and cabecaAlvo then
                        meuHum.Sit = true
                        meuHrp.CFrame = cabecaAlvo.CFrame * CFrame.new(0, 1.6, 0)
                    else
                        if conexaoHeadSit then conexaoHeadSit:Disconnect() end
                    end
                end)
            end)
        else
            if conexaoHeadSit then conexaoHeadSit:Disconnect(); conexaoHeadSit = nil end
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Sit = false
                end
            end)
            Notify("Troll", "Saiu da cabeça do alvo", 2)
        end
    end
})

local conexaoAttach = nil
UI.Toggle(Tabs.Troll, {
    Name = "Mochila (Grudar nas Costas do Alvo)",
    CurrentValue = false,
    Callback = function(state)
        if state then
            local alvo = Players:FindFirstChild(alvoTrollSelecionado)
            if not alvo or not alvo.Character then
                Notify("Troll", "Selecione uma vítima válida!", 2)
                return
            end
            Notify("Troll", "Grudado nas costas de: " .. alvo.Name, 2)
            if conexaoAttach then conexaoAttach:Disconnect() end
            conexaoAttach = RunService.RenderStepped:Connect(function()
                pcall(function()
                    local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local hrpAlvo = alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart")
                    if meuHrp and hrpAlvo then
                        meuHrp.CFrame = hrpAlvo.CFrame * CFrame.new(0, 0, 1.5)
                    else
                        if conexaoAttach then conexaoAttach:Disconnect() end
                    end
                end)
            end)
        else
            if conexaoAttach then conexaoAttach:Disconnect(); conexaoAttach = nil end
            Notify("Troll", "Soltou do alvo", 2)
        end
    end
})
--]]
-- PROPS
local PROP_KILL_Y      = -300
local PROP_MOVE_SPEED  = 6
local PROP_MOVE_RANGE  = 3
local TEMPO_MAX_SIT    = 10
local PROP_TIPO        = "FurnitureBleachers"
local PROP_CATEGORIA   = "Furniture"
local alvoPropSelecionado = LocalPlayer.Name

local function obterListaProp()
    local lista = {}
    for _, p in ipairs(Players:GetPlayers()) do table.insert(lista, p.Name) end
    if #lista == 0 then table.insert(lista, LocalPlayer.Name) end
    return lista
end
UI.InfoBlock(Tabs.Troll, {
Title = "Prop Kill | Bring",
Description = "Mata ou traz o alvo selecionado até vc.",
Icon = "14436167217"
})
local dropdownProp = UI.Dropdown(Tabs.Troll, {
    Name = "Alvo (Props)",
    Options = obterListaProp(),
    CurrentOption = {LocalPlayer.Name},
    Callback = function(opt) if opt and opt[1] then alvoPropSelecionado = opt[1] end end
})

UI.Button(Tabs.Troll, {
    Name = "Atualizar Lista (Props)",
    Description = "Atualiza a lista de jogadores",
    Callback = function()
        local novaLista = obterListaProp()
        dropdownProp:Refresh(novaLista)
        Notify("Props", "Lista atualizada!", 2)
    end,
})

local function pegarPropMaker()
    local RE = ReplicatedStorage:FindFirstChild("RE")
    if not RE then return nil end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if not char or not hum then return nil end
    local propMaker = char:FindFirstChild("PropMaker")
    if propMaker then return propMaker end
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    propMaker = backpack and backpack:FindFirstChild("PropMaker")
    if not propMaker then
        local toolRemote = RE:FindFirstChild("1Too1l")
        if toolRemote then pcall(function() toolRemote:InvokeServer("PickingTools", "PropMaker") end) end
        task.wait(0.4)
        propMaker = char:FindFirstChild("PropMaker") or (backpack and backpack:FindFirstChild("PropMaker"))
    end
    if propMaker and propMaker.Parent ~= char then
        pcall(function() hum:EquipTool(propMaker) end)
        task.wait(0.3)
    end
    return char:FindFirstChild("PropMaker")
end

local function selecionarProp(nome, categoria)
    local RE = ReplicatedStorage:FindFirstChild("RE")
    if not RE then return end
    local clearRemote = RE:FindFirstChild("1Clea1rTool1s")
    if not clearRemote then return end
    task.wait(0.2)
    pcall(function() clearRemote:FireServer("OpenPropMenu") end)
    task.wait(0.3)
    pcall(function() clearRemote:FireServer("RequestingPropName", nome or PROP_TIPO, categoria or PROP_CATEGORIA) end)
    task.wait(0.3)
end

local function spawnarProp(posicao)
    local char = LocalPlayer.Character
    if not char then return false end
    local propMaker = char:FindFirstChild("PropMaker")
    if not propMaker then return false end
    local toolProp = propMaker:FindFirstChild("Tool_PropMake") or propMaker:FindFirstChildOfClass("RemoteEvent")
    local chao = Workspace:FindFirstChild("Model")
        and Workspace.Model:FindFirstChild("Street")
        and Workspace.Model.Street:FindFirstChild("Street")
        or Workspace
    if toolProp then pcall(function() toolProp:FireServer(chao, posicao) end) end
    pcall(function()
        local camera = Workspace.CurrentCamera
        local posTela, naTela = camera:WorldToViewportPoint(posicao)
        if naTela then
            local vu = game:GetService("VirtualUser")
            vu:CaptureController()
            vu:ClickButton1(Vector2.new(posTela.X, posTela.Y))
        end
    end)
    return true
end

local function encontrarMeusProps()
    local WorkspaceCom = Workspace:FindFirstChild("WorkspaceCom")
    if not WorkspaceCom then return {} end
    local props = {}
    local meuNome = LocalPlayer.Name
    for _, container in ipairs(WorkspaceCom:GetChildren()) do
        for _, prop in ipairs(container:GetChildren()) do
            if prop.Name:find(meuNome, 1, true) then
                if prop:FindFirstChild("SetCurrentCFrame") or prop:IsA("Model") then
                    table.insert(props, prop)
                end
            end
        end
    end
    return props
end

local function moverProp(prop, cf)
    if not prop or not prop.Parent then return end
    local remote = prop:FindFirstChild("SetCurrentCFrame")
    if remote then pcall(function() remote:InvokeServer(cf) end)
    elseif prop:IsA("Model") then pcall(function() prop:PivotTo(cf) end) end
end

local function deletarTodosProps()
    local RE = ReplicatedStorage:FindFirstChild("RE")
    if not RE then return end
    local clearRemote = RE:FindFirstChild("1Clea1rTool1s")
    if clearRemote then pcall(function() clearRemote:FireServer("ClearAllProps") end) end
end

local function executarKillProp(nomeAlvo)
    local alvo = Players:FindFirstChild(nomeAlvo)
    if not alvo or not alvo.Character then return false end
    local hum = alvo.Character:FindFirstChildOfClass("Humanoid")
    local hrp = alvo.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then return false end
    local antes = #encontrarMeusProps()
    spawnarProp(hrp.Position)
    task.wait(0.5)
    local agora = encontrarMeusProps()
    local prop = agora[#agora]
    if not prop then
        Notify("Props", "Clique 1x no chão para liberar o prop", 3)
        local t0 = tick()
        while tick() - t0 < 6 do
            task.wait(0.3)
            agora = encontrarMeusProps()
            if #agora > antes then prop = agora[#agora]; break end
        end
    end
    if not prop then Notify("Props", "Prop não foi criado.", 2); return false end
    local sentou = false
    local tInicio = tick()
    local conexao
    conexao = RunService.Heartbeat:Connect(function()
        if sentou or (tick() - tInicio > TEMPO_MAX_SIT) then
            if conexao then conexao:Disconnect() end
            return
        end
        if not alvo.Character or not alvo.Character:FindFirstChild("HumanoidRootPart") then return end
        local hrpAtual = alvo.Character.HumanoidRootPart
        local t = tick() * PROP_MOVE_SPEED
        local offsetY = math.sin(t) * PROP_MOVE_RANGE
        local posPerseguicao = hrpAtual.Position + Vector3.new(0, offsetY, 0)
        moverProp(prop, CFrame.new(posPerseguicao))
        if hum.Sit then
            sentou = true
            if conexao then conexao:Disconnect() end
            task.wait(0.1)
            moverProp(prop, CFrame.new(hrpAtual.Position.X, PROP_KILL_Y, hrpAtual.Position.Z))
            task.wait(0.8)
            deletarTodosProps()
        end
    end)
    return true
end

local function executarBringProp(nomeAlvo)
    local alvo = Players:FindFirstChild(nomeAlvo)
    if not alvo or not alvo.Character then return false end
    local hum = alvo.Character:FindFirstChildOfClass("Humanoid")
    local hrp = alvo.Character:FindFirstChild("HumanoidRootPart")
    local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp or not meuHrp then return false end
    local antes = #encontrarMeusProps()
    spawnarProp(meuHrp.Position + (meuHrp.CFrame.LookVector * 4))
    task.wait(0.5)
    local agora = encontrarMeusProps()
    local prop = agora[#agora]
    if not prop then
        Notify("Props", "Clique 1x no chão para liberar o Prop", 3)
        local t0 = tick()
        while tick() - t0 < 6 do
            task.wait(0.3)
            agora = encontrarMeusProps()
            if #agora > antes then prop = agora[#agora]; break end
        end
    end
    if not prop then Notify("Props", "Prop não foi criado.", 2); return false end
    local sentou = false
    local tInicio = tick()
    local conexao
    conexao = RunService.Heartbeat:Connect(function()
        if sentou or (tick() - tInicio > TEMPO_MAX_SIT) then
            if conexao then conexao:Disconnect() end
            return
        end
        if not alvo.Character or not alvo.Character:FindFirstChild("HumanoidRootPart") then return end
        local hrpAtual = alvo.Character.HumanoidRootPart
        local t = tick() * PROP_MOVE_SPEED
        local offsetY = math.sin(t) * PROP_MOVE_RANGE
        moverProp(prop, CFrame.new(hrpAtual.Position + Vector3.new(0, offsetY, 0)))
        if hum.Sit then
            sentou = true
            if conexao then conexao:Disconnect() end
            task.wait(0.1)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                moverProp(prop, LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 0))
            end
            task.wait(0.8)
            deletarTodosProps()
        end
    end)
    return true
end

UI.Button(Tabs.Troll, {
    Name = "Kill Prop",
    Description = "TP prop: Void",
    Callback = function()
        if not alvoPropSelecionado then Notify("Props", "Selecione um alvo", 2); return end
        if not pegarPropMaker() then Notify("Props", "Falha ao equipar 'caixa de props'.", 2); return end
        selecionarProp()
        Notify("Props", "Iniciando Kill Prop...", 2)
        task.spawn(function() executarKillProp(alvoPropSelecionado) end)
    end,
})

UI.Button(Tabs.Troll, {
    Name = "Bring Prop (Trazer Alvo)",
    Description = "Traz o player selecionado até vc",
    Callback = function()
        if not alvoPropSelecionado then Notify("Props", "Selecione um alvo", 2); return end
        if not pegarPropMaker() then Notify("Props", "Falha ao equipar 'caixa de props'", 2); return end
        selecionarProp()
        Notify("Props", "Iniciando Bring Prop...", 2)
        task.spawn(function() executarBringProp(alvoPropSelecionado) end)
    end,
})

UI.Button(Tabs.Troll, {
    Name = "Limpar TODOS os Props",
    Description = "Apaga todos os props do mapa",
    Callback = function() deletarTodosProps(); Notify("Props", "Props deletados", 2) end,
})

--------------------------------------------------------------------------------
-- PAINEL DE PROPS AVANÇADOS (FORÇA 20 NO ALL / 1 NO PLAYER / SEM AUTO-DELETE)
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Troll, {
    Title = "🚽🪑 Props Avançados (Lote de 20)",
    Description = "Spawna até 20 props no all, sobe e desce no alvo e só apaga ao desligar.",
    Icon = "14436167217"
})

-- ============================================================================
-- SELEÇÃO DE PLAYER (SEPARADA DAS OUTRAS LISTAS)
-- ============================================================================
local function obterPlayersPropsAvancado()
    local lista = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(lista, p.Name)
        end
    end
    if #lista == 0 then
        table.insert(lista, "Nenhum player")
    end
    return lista
end

local listaInicialAvancado = obterPlayersPropsAvancado()
if listaInicialAvancado[1] ~= "Nenhum player" then
    alvoPropSelecionado = listaInicialAvancado[1][span_0](start_span)[span_0](end_span)
end

local dropdownPlayerAvancado = UI.Dropdown(Tabs.Troll, {
    Name = "👤 Player Alvo (Modo player)",
    Options = listaInicialAvancado,
    CurrentOption = { listaInicialAvancado[1] },
    Callback = function(opt)
        if opt and opt[1] and opt[1] ~= "Nenhum player" then
            alvoPropSelecionado = opt[1][span_1](start_span)[span_1](end_span)
            Notify("Props", "Alvo definido: " .. alvoPropSelecionado, 2)
        end
    end
})

UI.Button(Tabs.Troll, {
    Name = "🔄 Atualizar Lista de Players",
    Description = "Atualiza os jogadores disponíveis para o modo player",
    Callback = function()
        local novaLista = obterPlayersPropsAvancado()
        dropdownPlayerAvancado:Refresh(novaLista)
        if novaLista[1] ~= "Nenhum player" then
            alvoPropSelecionado = novaLista[1][span_2](start_span)[span_2](end_span)
        end
        Notify("Props", "Lista de players atualizada!", 2)
    end
})

-- Separador visual entre a lista de players e as configurações do prop
if UI.Section then
    UI.Section(Tabs.Troll, "⚙️ Configurações do Prop")
else
    UI.InfoBlock(Tabs.Troll, {
        Title = "⚙️ Configurações do Prop",
        Description = "Escolha o equipamento, a função e o modo (all ou player).",
        Icon = "14436167217"
    })
end

-- ============================================================================
-- LÓGICA E CONFIGURAÇÕES DO PROP
-- ============================================================================
local TOTAL_PROPS_ALL = 20
local CONFIG_PROPS_AVANCADO = {
    Bancada = { nome = "FurnitureBleachers", categoria = "Furniture" },[span_3](start_span)[span_3](end_span)
    Privada = { nome = "Toilet", categoria = "Furniture" }
}

local equipamentoSelecionado = "Privada"
local funcaoPropSelecionada    = "Kill All"
local modoAlvoProp           = "all" -- "all" ou "player"
local propAvancadoAtivo      = false

local function selecionarEquipamentoProp(chave)
    local info = CONFIG_PROPS_AVANCADO[chave] or CONFIG_PROPS_AVANCADO.Bancada
    local RE = ReplicatedStorage:FindFirstChild("RE")
    local clearRemote = RE and RE:FindFirstChild("1Clea1rTool1s")[span_4](start_span)[span_4](end_span)
    if not clearRemote then return end
    pcall(function() clearRemote:FireServer("OpenPropMenu") end)
    task.wait(0.2)
    pcall(function() clearRemote:FireServer("RequestingPropName", info.nome, info.categoria) end)
    task.wait(0.25)
end

local function obterChaoParaSpawn(posicaoBase)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local ignorar = {}
    if LocalPlayer.Character then table.insert(ignorar, LocalPlayer.Character) end
    params.FilterDescendantsInstances = ignorar

    local resultado = Workspace:Raycast(posicaoBase + Vector3.new(0, 10, 0), Vector3.new(0, -50, 0), params)
    if resultado and resultado.Instance then
        return resultado.Instance, resultado.Position
    end

    local fallback = (Workspace:FindFirstChild("POI_Hospital") and Workspace.POI_Hospital:FindFirstChild("Parking_Lot"))
        or Workspace:FindFirstChildWhichIsA("BasePart", true)
    return fallback, posicaoBase
end

local function coletarPropsDisponiveis(limite)
    local encontrados = encontrarMeusProps()[span_5](start_span)[span_5](end_span)
    local validos = {}
    local vistos = {}

    for _, p in ipairs(encontrados) do
        if p and p.Parent and not vistos[p] then
            vistos[p] = true
            table.insert(validos, p)
            if limite and #validos >= limite then
                return validos
            end
        end
    end

    local WorkspaceCom = Workspace:FindFirstChild("WorkspaceCom")[span_6](start_span)[span_6](end_span)
    if WorkspaceCom then
        for _, container in ipairs(WorkspaceCom:GetChildren()) do
            for _, prop in ipairs(container:GetChildren()) do
                if prop and prop.Parent and not vistos[prop] then
                    if prop:FindFirstChild("SetCurrentCFrame") then[span_7](start_span)[span_7](end_span)
                        vistos[prop] = true
                        table.insert(validos, prop)
                        if limite and #validos >= limite then
                            return validos
                        end
                    end
                end
            end
        end
    end

    return validos
end

local function calcularPosicaoEspacada(posBase, indice, total)
    local raioBase = 14 + ((indice - 1) % 3) * 5
    local angulo = ((indice - 1) / math.max(total, 1)) * math.pi * 2 + (indice * 0.45)
    local offsetX = math.cos(angulo) * raioBase
    local offsetZ = math.sin(angulo) * raioBase
    return posBase + Vector3.new(offsetX, 0, offsetZ)
end

local function obterAlvosSemVoce()
    local lista = {}
    local modoEfetivo = modoAlvoProp
    if funcaoPropSelecionada:find("All") then
        modoEfetivo = "all"
    elseif funcaoPropSelecionada:find("(Player)", 1, true) then
        modoEfetivo = "player"
    end

    if modoEfetivo == "all" then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 0 then
                    table.insert(lista, p)
                end
            end
        end
    else
        local alvo = alvoPropSelecionado and Players:FindFirstChild(alvoPropSelecionado)[span_8](start_span)[span_8](end_span)
        if alvo and alvo ~= LocalPlayer and alvo.Character then
            local hum = alvo.Character:FindFirstChildOfClass("Humanoid")
            local hrp = alvo.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                table.insert(lista, alvo)
            end
        end
    end

    return lista
end

-- FASE 1: Insiste até completar 20 props (no all) ou 1 prop (no player) antes de sair
local function spawnarLoteCompleto(modoEfetivo, posBase)
    local quantidadeDesejada = (modoEfetivo == "all") and TOTAL_PROPS_ALL or 1
    local propsAtuais = coletarPropsDisponiveis(quantidadeDesejada)

    if #propsAtuais >= quantidadeDesejada then
        return propsAtuais
    end

    local maxTentativas = (modoEfetivo == "all") and 65 or 8
    local tentativas = 0

    while #propsAtuais < quantidadeDesejada and tentativas < maxTentativas and propAvancadoAtivo do
        tentativas = tentativas + 1

        local propMaker = pegarPropMaker()[span_9](start_span)[span_9](end_span)
        local toolProp = propMaker and (propMaker:FindFirstChild("Tool_PropMake") or propMaker:FindFirstChildOfClass("RemoteEvent"))[span_10](start_span)[span_10](end_span)

        if propMaker and toolProp then
            local posAlvoSpawn = calcularPosicaoEspacada(posBase, #propsAtuais + 1, quantidadeDesejada)
            local chaoPart, posChao = obterChaoParaSpawn(posAlvoSpawn)

            pcall(function()
                toolProp:FireServer(chaoPart, posChao)
            end)
            pcall(function()
                propMaker:Activate()
            end)
        end

        task.wait(0.25)
        propsAtuais = coletarPropsDisponiveis(quantidadeDesejada)

        if #propsAtuais >= quantidadeDesejada then
            break
        end
    end

    return coletarPropsDisponiveis(quantidadeDesejada)
end

-- FASE 2: Sobe e desce no avatar do alvo até ele sentar, executa Kill/Bring e troca rápido
local function rodarEnxameProps(propsLote, acao)
    local indiceAlvoGlobal = 1
    local estadoPorProp = {}

    local function proximoAlvo(listaAlvos)
        if #listaAlvos == 0 then return nil end
        if indiceAlvoGlobal > #listaAlvos then
            indiceAlvoGlobal = 1
        end
        local escolhido = listaAlvos[indiceAlvoGlobal]
        indiceAlvoGlobal = indiceAlvoGlobal + 1
        return escolhido
    end

    while propAvancadoAtivo do
        local alvos = obterAlvosSemVoce()
        if #alvos == 0 then
            task.wait(0.25)
            continue
        end

        for idxProp, prop in ipairs(propsLote) do
            if not propAvancadoAtivo then break end
            if prop and prop.Parent then
                local st = estadoPorProp[prop]
                if not st then
                    st = { alvo = proximoAlvo(alvos), inicioAlvo = tick(), concluido = false }
                    estadoPorProp[prop] = st
                end

                local alvo = st.alvo
                local char = alvo and alvo.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")

                if not alvo or alvo == LocalPlayer or not alvo.Parent or not char or not hrp or not hum or hum.Health <= 0 or (tick() - st.inicioAlvo > 2.2) then
                    st.alvo = proximoAlvo(alvos)
                    st.inicioAlvo = tick()
                    st.concluido = false
                    alvo = st.alvo
                    char = alvo and alvo.Character
                    hrp = char and char:FindFirstChild("HumanoidRootPart")
                    hum = char and char:FindFirstChildOfClass("Humanoid")
                end

                if alvo and alvo ~= LocalPlayer and hrp and hum and hum.Health > 0 then
                    if not st.concluido then
                        local t = tick() * PROP_MOVE_SPEED + idxProp[span_11](start_span)[span_11](end_span)
                        local offsetY = math.sin(t) * PROP_MOVE_RANGE[span_12](start_span)[span_12](end_span)
                        local cfMira = CFrame.new(hrp.Position + Vector3.new(0, offsetY, 0))
                        moverProp(prop, cfMira)[span_13](start_span)[span_13](end_span)

                        if hum.Sit then
                            st.concluido = true
                            task.wait(0.08)
                            if acao == "KILL" then
                                moverProp(prop, CFrame.new(hrp.Position.X, PROP_KILL_Y, hrp.Position.Z))[span_14](start_span)[span_14](end_span)
                            elseif acao == "BRING" then
                                local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if meuHrp then
                                    moverProp(prop, meuHrp.CFrame * CFrame.new(2, 0, 0))[span_15](start_span)[span_15](end_span)
                                end
                            end
                            st.alvo = proximoAlvo(alvos)
                            st.inicioAlvo = tick()
                            st.concluido = false
                        end
                    end
                end
            end
        end

        task.wait(0.05)
    end
end

-- ============================================================================
-- LISTAS DE CONFIGURAÇÃO DO PROP (3 LISTAS) + INTERRUPTOR
-- ============================================================================
UI.Dropdown(Tabs.Troll, {
    Name = "Equipamento (Prop)",
    Options = { "Privada", "Bancada" },
    CurrentOption = { "Privada" },
    Callback = function(opt)
        if opt and opt[1] then
            equipamentoSelecionado = opt[1]
        end
    end
})

UI.Dropdown(Tabs.Troll, {
    Name = "Função do Prop",
    Options = { "Kill All", "Kill (Player)", "Bring All", "Bring (Player)" },
    CurrentOption = { "Kill All" },
    Callback = function(opt)
        if opt and opt[1] then
            funcaoPropSelecionada = opt[1]
            if opt[1]:find("All") then
                modoAlvoProp = "all"
            else
                modoAlvoProp = "player"
            end
        end
    end
})

UI.Dropdown(Tabs.Troll, {
    Name = "Alvo (all / player)",
    Options = { "all", "player" },
    CurrentOption = { "all" },
    Callback = function(opt)
        if opt and opt[1] then
            modoAlvoProp = opt[1]
        end
    end
})

UI.Toggle(Tabs.Troll, {
    Name = "Executar Prop Selecionado",
    Description = "Gera até 20 props no all; sobe e desce nos alvos; só apaga ao desligar",
    CurrentValue = false,
    Callback = function(ativo)
        propAvancadoAtivo = ativo
        if not ativo then
            deletarTodosProps()[span_16](start_span)[span_16](end_span)
            Notify("Props", "Desligado e props removidos.", 2)
            return
        end

        if not pegarPropMaker() then[span_17](start_span)[span_17](end_span)
            propAvancadoAtivo = false
            Notify("Props", "Falha ao equipar 'caixa de props'.", 2)
            return
        end

        selecionarEquipamentoProp(equipamentoSelecionado)
        local acao = funcaoPropSelecionada:find("Kill") and "KILL" or "BRING"
        local modoEfetivo = modoAlvoProp
        if funcaoPropSelecionada:find("All") then
            modoEfetivo = "all"
        elseif funcaoPropSelecionada:find("(Player)", 1, true) then
            modoEfetivo = "player"
        end

        task.spawn(function()
            local meuChar = LocalPlayer.Character
            local meuHrp = meuChar and meuChar:FindFirstChild("HumanoidRootPart")
            local posBase = meuHrp and meuHrp.Position or Vector3.new(-428.6, 0.4, 64.9)

            local propsLote = spawnarLoteCompleto(modoEfetivo, posBase)
            if #propsLote == 0 then
                propAvancadoAtivo = false
                Notify("Props", "Não foi possível gerar os props.", 3)
                return
            end

            rodarEnxameProps(propsLote, acao)
        end)
    end
})

--[[
--------------------------------------------------------------------------------
-- PAINEL DE PROPS AVANÇADOS (SPAWN AFASTADO / LOTE DE 20 / SEM AUTO-DELETE)
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Troll, {
    Title = "🚽🪑 Props Avançados (Lote de 20)",
    Description = "Spawna longe e separado, inicia ao atingir 20 props no all e só apaga ao desligar.",
    Icon = "14436167217"
})

-- ============================================================================
-- SELEÇÃO DE PLAYER (SEPARADA DAS OUTRAS LISTAS)
-- ============================================================================
local function obterPlayersPropsAvancado()
    local lista = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(lista, p.Name)
        end
    end
    if #lista == 0 then
        table.insert(lista, "Nenhum player")
    end
    return lista
end

local listaInicialAvancado = obterPlayersPropsAvancado()
if listaInicialAvancado[1] ~= "Nenhum player" then
    alvoPropSelecionado = listaInicialAvancado[1] --[span_1](start_span)[span_1](end_span)
end

local dropdownPlayerAvancado = UI.Dropdown(Tabs.Troll, {
    Name = "👤 Player Alvo (Modo player)",
    Options = listaInicialAvancado,
    CurrentOption = { listaInicialAvancado[1] },
    Callback = function(opt)
        if opt and opt[1] and opt[1] ~= "Nenhum player" then
            alvoPropSelecionado = opt[1] --[span_2](start_span)[span_2](end_span)
            Notify("Props", "Alvo definido: " .. alvoPropSelecionado, 2)
        end
    end
})

UI.Button(Tabs.Troll, {
    Name = "🔄 Atualizar Lista de Players",
    Description = "Atualiza os jogadores disponíveis para o modo player",
    Callback = function()
        local novaLista = obterPlayersPropsAvancado()
        dropdownPlayerAvancado:Refresh(novaLista)
        if novaLista[1] ~= "Nenhum player" then
            alvoPropSelecionado = novaLista[1] --[span_3](start_span)[span_3](end_span)
        end
        Notify("Props", "Lista de players atualizada!", 2)
    end
})

-- Separador visual entre a lista de players e as configurações do prop
if UI.Section then
    UI.Section(Tabs.Troll, "⚙️ Configurações do Prop")
else
    UI.InfoBlock(Tabs.Troll, {
        Title = "⚙️ Configurações do Prop",
        Description = "Escolha o equipamento, a função e o modo (all ou player).",
        Icon = "14436167217"
    })
end

-- ============================================================================
-- LÓGICA E CONFIGURAÇÕES DO PROP
-- ============================================================================
local TOTAL_PROPS_ALL = 20
local CONFIG_PROPS_AVANCADO = {
    Bancada = { nome = "FurnitureBleachers", categoria = "Furniture" }, --[span_4](start_span)[span_4](end_span)
    Privada = { nome = "Toilet", categoria = "Furniture" }
}

local equipamentoSelecionado = "Privada"
local funcaoPropSelecionada    = "Kill All"
local modoAlvoProp           = "all" -- "all" ou "player"
local propAvancadoAtivo      = false

local function selecionarEquipamentoProp(chave)
    local info = CONFIG_PROPS_AVANCADO[chave] or CONFIG_PROPS_AVANCADO.Bancada
    local RE = ReplicatedStorage:FindFirstChild("RE")
    local clearRemote = RE and RE:FindFirstChild("1Clea1rTool1s") --[span_5](start_span)[span_5](end_span)
    if not clearRemote then return end
    pcall(function() clearRemote:FireServer("OpenPropMenu") end)
    task.wait(0.2)
    pcall(function() clearRemote:FireServer("RequestingPropName", info.nome, info.categoria) end)
    task.wait(0.25)
end

local function obterChaoParaSpawn(posicaoBase)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local ignorar = {}
    if LocalPlayer.Character then table.insert(ignorar, LocalPlayer.Character) end
    params.FilterDescendantsInstances = ignorar

    local resultado = Workspace:Raycast(posicaoBase + Vector3.new(0, 10, 0), Vector3.new(0, -50, 0), params)
    if resultado and resultado.Instance then
        return resultado.Instance, resultado.Position
    end

    local fallback = (Workspace:FindFirstChild("POI_Hospital") and Workspace.POI_Hospital:FindFirstChild("Parking_Lot"))
        or Workspace:FindFirstChildWhichIsA("BasePart", true)
    return fallback, posicaoBase
end

local function coletarPropsDisponiveis(limite)
    local encontrados = encontrarMeusProps() --[span_6](start_span)[span_6](end_span)
    local validos = {}
    local vistos = {}

    for _, p in ipairs(encontrados) do
        if p and p.Parent and not vistos[p] then
            vistos[p] = true
            table.insert(validos, p)
            if limite and #validos >= limite then
                return validos
            end
        end
    end

    local WorkspaceCom = Workspace:FindFirstChild("WorkspaceCom") --[span_7](start_span)[span_7](end_span)
    if WorkspaceCom then
        for _, container in ipairs(WorkspaceCom:GetChildren()) do
            for _, prop in ipairs(container:GetChildren()) do
                if prop and prop.Parent and not vistos[prop] then
                    if prop:FindFirstChild("SetCurrentCFrame") then --[span_8](start_span)[span_8](end_span)
                        vistos[prop] = true
                        table.insert(validos, prop)
                        if limite and #validos >= limite then
                            return validos
                        end
                    end
                end
            end
        end
    end

    return validos
end

local function calcularPosicaoEspacada(posBase, indice, total)
    -- Mantém distância segura do personagem e separa os props entre si
    local raioBase = 14 + ((indice - 1) % 3) * 5
    local angulo = ((indice - 1) / math.max(total, 1)) * math.pi * 2 + (indice * 0.45)
    local offsetX = math.cos(angulo) * raioBase
    local offsetZ = math.sin(angulo) * raioBase
    return posBase + Vector3.new(offsetX, 0, offsetZ)
end

local function obterAlvosSemVoce()
    local lista = {}
    local modoEfetivo = modoAlvoProp
    if funcaoPropSelecionada:find("All") then
        modoEfetivo = "all"
    elseif funcaoPropSelecionada:find("(Player)", 1, true) then
        modoEfetivo = "player"
    end

    if modoEfetivo == "all" then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                if hum and hrp and hum.Health > 0 then
                    table.insert(lista, p)
                end
            end
        end
    else
        local alvo = alvoPropSelecionado and Players:FindFirstChild(alvoPropSelecionado) --[span_9](start_span)[span_9](end_span)
        if alvo and alvo ~= LocalPlayer and alvo.Character then
            local hum = alvo.Character:FindFirstChildOfClass("Humanoid")
            local hrp = alvo.Character:FindFirstChild("HumanoidRootPart")
            if hum and hrp and hum.Health > 0 then
                table.insert(lista, alvo)
            end
        end
    end

    return lista
end

-- FASE 1: Garante ou spawna os 20 props (no all) ou 1 prop (no player) afastados entre si e de você
local function spawnarLoteCompleto(modoEfetivo, posBase)
    local quantidadeDesejada = (modoEfetivo == "all") and TOTAL_PROPS_ALL or 1
    local propsAtuais = coletarPropsDisponiveis(quantidadeDesejada)

    if #propsAtuais >= quantidadeDesejada then
        return propsAtuais
    end

    local maxCiclos = (quantidadeDesejada - #propsAtuais) + 8
    local ciclos = 0

    while #propsAtuais < quantidadeDesejada and ciclos < maxCiclos and propAvancadoAtivo do
        ciclos = ciclos + 1

        local propMaker = pegarPropMaker() --[span_10](start_span)[span_10](end_span)
        local toolProp = propMaker and (propMaker:FindFirstChild("Tool_PropMake") or propMaker:FindFirstChildOfClass("RemoteEvent")) --[span_11](start_span)[span_11](end_span)

        if propMaker and toolProp then
            local posAlvoSpawn = calcularPosicaoEspacada(posBase, #propsAtuais + 1, quantidadeDesejada)
            local chaoPart, posChao = obterChaoParaSpawn(posAlvoSpawn)

            pcall(function()
                toolProp:FireServer(chaoPart, posChao)
            end)
            pcall(function()
                propMaker:Activate()
            end)
        end

        task.wait(0.22)
        propsAtuais = coletarPropsDisponiveis(quantidadeDesejada)

        if #propsAtuais >= quantidadeDesejada then
            break
        end
    end

    return coletarPropsDisponiveis(quantidadeDesejada)
end

-- FASE 2: Todos os props ativos vão atrás de 1 alvo cada, executam Kill/Bring ao sentar e trocam rápido
local function rodarEnxameProps(propsLote, acao)
    local indiceAlvoGlobal = 1
    local estadoPorProp = {}

    local function proximoAlvo(listaAlvos)
        if #listaAlvos == 0 then return nil end
        if indiceAlvoGlobal > #listaAlvos then
            indiceAlvoGlobal = 1
        end
        local escolhido = listaAlvos[indiceAlvoGlobal]
        indiceAlvoGlobal = indiceAlvoGlobal + 1
        return escolhido
    end

    while propAvancadoAtivo do
        local alvos = obterAlvosSemVoce()
        if #alvos == 0 then
            task.wait(0.25)
            continue
        end

        for _, prop in ipairs(propsLote) do
            if not propAvancadoAtivo then break end
            if prop and prop.Parent then
                local st = estadoPorProp[prop]
                if not st then
                    st = { alvo = proximoAlvo(alvos), inicioAlvo = tick(), concluido = false }
                    estadoPorProp[prop] = st
                end

                local alvo = st.alvo
                local char = alvo and alvo.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")

                if not alvo or alvo == LocalPlayer or not alvo.Parent or not char or not hrp or not hum or hum.Health <= 0 or (tick() - st.inicioAlvo > 1.8) then
                    st.alvo = proximoAlvo(alvos)
                    st.inicioAlvo = tick()
                    st.concluido = false
                    alvo = st.alvo
                    char = alvo and alvo.Character
                    hrp = char and char:FindFirstChild("HumanoidRootPart")
                    hum = char and char:FindFirstChildOfClass("Humanoid")
                end

                if alvo and alvo ~= LocalPlayer and hrp and hum and hum.Health > 0 then
                    if not st.concluido then
                        local cfMira = CFrame.new(hrp.Position.X, hrp.Position.Y - 1.0, hrp.Position.Z)
                        moverProp(prop, cfMira) --[span_12](start_span)[span_12](end_span)

                        if hum.Sit then
                            st.concluido = true
                            if acao == "KILL" then
                                moverProp(prop, CFrame.new(hrp.Position.X, PROP_KILL_Y, hrp.Position.Z)) --[span_13](start_span)[span_13](end_span)
                            elseif acao == "BRING" then
                                local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if meuHrp then
                                    moverProp(prop, meuHrp.CFrame * CFrame.new(0, -1, -3))
                                end
                            end
                            st.alvo = proximoAlvo(alvos)
                            st.inicioAlvo = tick()
                            st.concluido = false
                        end
                    end
                end
            end
        end

        task.wait(0.06)
    end
end

-- ============================================================================
-- LISTAS DE CONFIGURAÇÃO DO PROP (3 LISTAS) + INTERRUPTOR
-- ============================================================================
UI.Dropdown(Tabs.Troll, {
    Name = "Equipamento (Prop)",
    Options = { "Privada", "Bancada" },
    CurrentOption = { "Privada" },
    Callback = function(opt)
        if opt and opt[1] then
            equipamentoSelecionado = opt[1]
        end
    end
})

UI.Dropdown(Tabs.Troll, {
    Name = "Função do Prop",
    Options = { "Kill All", "Kill (Player)", "Bring All", "Bring (Player)" },
    CurrentOption = { "Kill All" },
    Callback = function(opt)
        if opt and opt[1] then
            funcaoPropSelecionada = opt[1]
            if opt[1]:find("All") then
                modoAlvoProp = "all"
            else
                modoAlvoProp = "player"
            end
        end
    end
})

UI.Dropdown(Tabs.Troll, {
    Name = "Alvo (all / player)",
    Options = { "all", "player" },
    CurrentOption = { "all" },
    Callback = function(opt)
        if opt and opt[1] then
            modoAlvoProp = opt[1]
        end
    end
})

UI.Toggle(Tabs.Troll, {
    Name = "Executar Prop Selecionado",
    Description = "Spawna longe e separado, inicia ao bater 20 no all e só apaga ao desligar",
    CurrentValue = false,
    Callback = function(ativo)
        propAvancadoAtivo = ativo
        if not ativo then
            deletarTodosProps() --[span_14](start_span)[span_14](end_span)
            Notify("Props", "Desligado e props removidos.", 2)
            return
        end

        if not pegarPropMaker() then --[span_15](start_span)[span_15](end_span)
            propAvancadoAtivo = false
            Notify("Props", "Falha ao equipar 'caixa de props'.", 2)
            return
        end

        selecionarEquipamentoProp(equipamentoSelecionado)
        local acao = funcaoPropSelecionada:find("Kill") and "KILL" or "BRING"
        local modoEfetivo = modoAlvoProp
        if funcaoPropSelecionada:find("All") then
            modoEfetivo = "all"
        elseif funcaoPropSelecionada:find("(Player)", 1, true) then
            modoEfetivo = "player"
        end

        task.spawn(function()
            local meuChar = LocalPlayer.Character
            local meuHrp = meuChar and meuChar:FindFirstChild("HumanoidRootPart")
            local posBase = meuHrp and meuHrp.Position or Vector3.new(-428.6, 0.4, 64.9)

            local propsLote = spawnarLoteCompleto(modoEfetivo, posBase)
            if #propsLote == 0 then
                propAvancadoAtivo = false
                Notify("Props", "Não foi possível gerar os props.", 3)
                return
            end

            rodarEnxameProps(propsLote, acao)
        end)
    end
})


--------------------------------------------------------------------------------
-- PAINEL DE PROPS AVANÇADOS (SPAWNA 20 NO ALL / 1 NO PLAYER / SEM AUTO-DELETE)
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Troll, {
    Title = "🚽🪑 Props Avançados (Lote de 20)",
    Description = "Spawna os 20 props no all, foca 1 player por vez e só apaga ao desligar.",
    Icon = "14436167217"
})

-- ============================================================================
-- SELEÇÃO DE PLAYER (SEPARADA DAS OUTRAS LISTAS)
-- ============================================================================
local function obterPlayersPropsAvancado()
    local lista = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(lista, p.Name)
        end
    end
    if #lista == 0 then
        table.insert(lista, "Nenhum player")
    end
    return lista
end

local listaInicialAvancado = obterPlayersPropsAvancado()
if listaInicialAvancado[1] ~= "Nenhum player" then
    alvoPropSelecionado = listaInicialAvancado[1] --[span_1](start_span)[span_1](end_span)
end

local dropdownPlayerAvancado = UI.Dropdown(Tabs.Troll, {
    Name = "👤 Player Alvo (Modo player)",
    Options = listaInicialAvancado,
    CurrentOption = { listaInicialAvancado[1] },
    Callback = function(opt)
        if opt and opt[1] and opt[1] ~= "Nenhum player" then
            alvoPropSelecionado = opt[1] --[span_2](start_span)[span_2](end_span)
            Notify("Props", "Alvo definido: " .. alvoPropSelecionado, 2)
        end
    end
})

UI.Button(Tabs.Troll, {
    Name = "🔄 Atualizar Lista de Players",
    Description = "Atualiza os jogadores disponíveis para o modo player",
    Callback = function()
        local novaLista = obterPlayersPropsAvancado()
        dropdownPlayerAvancado:Refresh(novaLista)
        if novaLista[1] ~= "Nenhum player" then
            alvoPropSelecionado = novaLista[1] --[span_3](start_span)[span_3](end_span)
        end
        Notify("Props", "Lista de players atualizada!", 2)
    end
})

-- Separador visual entre a lista de players e as configurações do prop
if UI.Section then
    UI.Section(Tabs.Troll, "⚙️ Configurações do Prop")
else
    UI.InfoBlock(Tabs.Troll, {
        Title = "⚙️ Configurações do Prop",
        Description = "Escolha o equipamento, a função e o modo (all ou player).",
        Icon = "14436167217"
    })
end

-- ============================================================================
-- LÓGICA E CONFIGURAÇÕES DO PROP
-- ============================================================================
local TOTAL_PROPS_ALL = 20
local CONFIG_PROPS_AVANCADO = {
    Bancada = { nome = "FurnitureBleachers", categoria = "Furniture" }, --[span_4](start_span)[span_4](end_span)
    Privada = { nome = "Toilet", categoria = "Furniture" }
}

local equipamentoSelecionado = "Privada"
local funcaoPropSelecionada    = "Kill All"
local modoAlvoProp           = "all" -- "all" ou "player"
local propAvancadoAtivo      = false

local function selecionarEquipamentoProp(chave)
    local info = CONFIG_PROPS_AVANCADO[chave] or CONFIG_PROPS_AVANCADO.Bancada
    local RE = ReplicatedStorage:FindFirstChild("RE")
    local clearRemote = RE and RE:FindFirstChild("1Clea1rTool1s")
    if not clearRemote then return end
    pcall(function() clearRemote:FireServer("OpenPropMenu") end)
    task.wait(0.2)
    pcall(function() clearRemote:FireServer("RequestingPropName", info.nome, info.categoria) end)
    task.wait(0.25)
end

local function obterChaoParaSpawn(posicaoBase)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    local ignorar = {}
    if LocalPlayer.Character then table.insert(ignorar, LocalPlayer.Character) end
    params.FilterDescendantsInstances = ignorar

    local resultado = Workspace:Raycast(posicaoBase + Vector3.new(0, 10, 0), Vector3.new(0, -50, 0), params)
    if resultado and resultado.Instance then
        return resultado.Instance, resultado.Position
    end

    local fallback = (Workspace:FindFirstChild("POI_Hospital") and Workspace.POI_Hospital:FindFirstChild("Parking_Lot"))
        or Workspace:FindFirstChildWhichIsA("BasePart", true)
    return fallback, posicaoBase
end

local function coletarPropsDisponiveis(limite)
    local encontrados = encontrarMeusProps() --[span_1](start_span)[span_1](end_span)
    local validos = {}
    local vistos = {}

    for _, p in ipairs(encontrados) do
        if p and p.Parent and not vistos[p] then
            vistos[p] = true
            table.insert(validos, p)
            if limite and #validos >= limite then
                return validos
            end
        end
    end

    -- Fallback: se ainda não bateu o limite, busca outros props com SetCurrentCFrame no WorkspaceCom
    local WorkspaceCom = Workspace:FindFirstChild("WorkspaceCom")
    if WorkspaceCom then
        for _, container in ipairs(WorkspaceCom:GetChildren()) do
            for _, prop in ipairs(container:GetChildren()) do
                if prop and prop.Parent and not vistos[prop] then
                    if prop:FindFirstChild("SetCurrentCFrame") then
                        vistos[prop] = true
                        table.insert(validos, prop)
                        if limite and #validos >= limite then
                            return validos
                        end
                    end
                end
            end
        end
    end

    return validos
end

local function spawnarLoteCompleto(modoEfetivo, posBase)
    local quantidadeDesejada = (modoEfetivo == "all") and TOTAL_PROPS_ALL or 1
    local propsAtuais = coletarPropsDisponiveis(quantidadeDesejada)

    if #propsAtuais >= quantidadeDesejada then
        return propsAtuais
    end

    local faltam = quantidadeDesejada - #propsAtuais
    local maxCiclos = faltam + 8 -- Margem caso algum disparo falhe ou demore
    local ciclos = 0

    while #propsAtuais < quantidadeDesejada and ciclos < maxCiclos and propAvancadoAtivo do
        ciclos = ciclos + 1

        -- Garante que o PropMaker está equipado antes de disparar
        local propMaker = pegarPropMaker() --[span_2](start_span)[span_2](end_span)
        local toolProp = propMaker and (propMaker:FindFirstChild("Tool_PropMake") or propMaker:FindFirstChildOfClass("RemoteEvent"))

        if propMaker and toolProp then
            local angulo = (ciclos / quantidadeDesejada) * math.pi * 2
            local offset = Vector3.new(math.cos(angulo) * 4, 0, math.sin(angulo) * 4)
            local chaoPart, posChao = obterChaoParaSpawn(posBase + offset)

            pcall(function()
                toolProp:FireServer(chaoPart, posChao)
            end)
            pcall(function()
                propMaker:Activate()
            end)
        end

        task.wait(0.22)
        propsAtuais = coletarPropsDisponiveis(quantidadeDesejada)
    end

    return coletarPropsDisponiveis(quantidadeDesejada)
end

-- FASE 2: Todos os props ativos vão atrás de 1 alvo cada, executam Kill/Bring ao sentar e trocam rápido
local function rodarEnxameProps(propsLote, acao)
    local indiceAlvoGlobal = 1
    local estadoPorProp = {}

    local function proximoAlvo(listaAlvos)
        if #listaAlvos == 0 then return nil end
        if indiceAlvoGlobal > #listaAlvos then
            indiceAlvoGlobal = 1
        end
        local escolhido = listaAlvos[indiceAlvoGlobal]
        indiceAlvoGlobal = indiceAlvoGlobal + 1
        return escolhido
    end

    while propAvancadoAtivo do
        local alvos = obterAlvosSemVoce()
        if #alvos == 0 then
            task.wait(0.25)
            continue
        end

        for _, prop in ipairs(propsLote) do
            if not propAvancadoAtivo then break end
            if prop and prop.Parent then
                local st = estadoPorProp[prop]
                if not st then
                    st = { alvo = proximoAlvo(alvos), inicioAlvo = tick(), concluido = false }
                    estadoPorProp[prop] = st
                end

                local alvo = st.alvo
                local char = alvo and alvo.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")

                if not alvo or alvo == LocalPlayer or not alvo.Parent or not char or not hrp or not hum or hum.Health <= 0 or (tick() - st.inicioAlvo > 1.8) then
                    st.alvo = proximoAlvo(alvos)
                    st.inicioAlvo = tick()
                    st.concluido = false
                    alvo = st.alvo
                    char = alvo and alvo.Character
                    hrp = char and char:FindFirstChild("HumanoidRootPart")
                    hum = char and char:FindFirstChildOfClass("Humanoid")
                end

                if alvo and alvo ~= LocalPlayer and hrp and hum and hum.Health > 0 then
                    if not st.concluido then
                        local cfMira = CFrame.new(hrp.Position.X, hrp.Position.Y - 1.0, hrp.Position.Z)
                        moverProp(prop, cfMira) --[span_12](start_span)[span_12](end_span)

                        if hum.Sit then
                            st.concluido = true
                            if acao == "KILL" then
                                moverProp(prop, CFrame.new(hrp.Position.X, PROP_KILL_Y, hrp.Position.Z)) --[span_13](start_span)[span_13](end_span)
                            elseif acao == "BRING" then
                                local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if meuHrp then
                                    moverProp(prop, meuHrp.CFrame * CFrame.new(0, -1, -3))
                                end
                            end
                            st.alvo = proximoAlvo(alvos)
                            st.inicioAlvo = tick()
                            st.concluido = false
                        end
                    end
                end
            end
        end

        task.wait(0.06)
    end
end

-- ============================================================================
-- LISTAS DE CONFIGURAÇÃO DO PROP (3 LISTAS) + INTERRUPTOR
-- ============================================================================
UI.Dropdown(Tabs.Troll, {
    Name = "Equipamento (Prop)",
    Options = { "Privada", "Bancada" },
    CurrentOption = { "Privada" },
    Callback = function(opt)
        if opt and opt[1] then
            equipamentoSelecionado = opt[1]
        end
    end
})

UI.Dropdown(Tabs.Troll, {
    Name = "Função do Prop",
    Options = { "Kill All", "Kill (Player)", "Bring All", "Bring (Player)" },
    CurrentOption = { "Kill All" },
    Callback = function(opt)
        if opt and opt[1] then
            funcaoPropSelecionada = opt[1]
            if opt[1]:find("All") then
                modoAlvoProp = "all"
            else
                modoAlvoProp = "player"
            end
        end
    end
})

UI.Dropdown(Tabs.Troll, {
    Name = "Alvo (all / player)",
    Options = { "all", "player" },
    CurrentOption = { "all" },
    Callback = function(opt)
        if opt and opt[1] then
            modoAlvoProp = opt[1]
        end
    end
})

UI.Toggle(Tabs.Troll, {
    Name = "Executar Prop Selecionado",
    Description = "Spawna os 20 primeiro no all; todos vão depois; só apaga ao desligar",
    CurrentValue = false,
    Callback = function(ativo)
        propAvancadoAtivo = ativo
        if not ativo then
            deletarTodosProps() --[span_14](start_span)[span_14](end_span)
            Notify("Props", "Desligado e props removidos.", 2)
            return
        end

        if not pegarPropMaker() then --[span_15](start_span)[span_15](end_span)
            propAvancadoAtivo = false
            Notify("Props", "Falha ao equipar 'caixa de props'.", 2)
            return
        end

        selecionarEquipamentoProp(equipamentoSelecionado)
        local acao = funcaoPropSelecionada:find("Kill") and "KILL" or "BRING"
        local modoEfetivo = modoAlvoProp
        if funcaoPropSelecionada:find("All") then
            modoEfetivo = "all"
        elseif funcaoPropSelecionada:find("(Player)", 1, true) then
            modoEfetivo = "player"
        end

        task.spawn(function()
            local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local posBase = meuHrp and meuHrp.Position or Vector3.new(-428.6, 0.4, 64.9)

            local propsLote = spawnarLoteCompleto(modoEfetivo, posBase)
            if #propsLote == 0 then
                propAvancadoAtivo = false
                Notify("Props", "Não foi possível gerar os props.", 3)
                return
            end

            rodarEnxameProps(propsLote, acao)
        end)
    end
})
 --]]
