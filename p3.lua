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
-- PAINEL DE PROPS RÁPIDO (ATÉ 20 NO ALL / 1 NO PLAYER / SEM AUTO-DELETE)
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Troll, {
    Title = "🚽🪑 Props Avançados (Rápido)",
    Description = "Até 20 props no all, perseguição rápida e troca imediata de alvo.",
    Icon = "14436167217"
})

local MAX_PROPS_ALL_RAPIDO = 20
local CONFIG_PROPS_AVANCADO = {
    Bancada = { nome = "FurnitureBleachers", categoria = "Furniture" }, --[span_0](start_span)[span_0](end_span)
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
    task.wait(0.15)
    pcall(function() clearRemote:FireServer("RequestingPropName", info.nome, info.categoria) end)
    task.wait(0.15)
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

local function dispararCriacaoProp(posicaoDesejada)
    local propMaker = pegarPropMaker() --[span_1](start_span)[span_1](end_span)
    if not propMaker then return false end

    local toolProp = propMaker:FindFirstChild("Tool_PropMake") or propMaker:FindFirstChildOfClass("RemoteEvent")
    if not toolProp then return false end

    local chaoPart, posChao = obterChaoParaSpawn(posicaoDesejada)
    pcall(function()
        toolProp:FireServer(chaoPart, posChao)
    end)
    pcall(function()
        propMaker:Activate()
    end)
    return true
end

local function prepararPropsRapido(alvos, modoEfetivo, posBase)
    local alvoLimite = (modoEfetivo == "all") and MAX_PROPS_ALL_RAPIDO or 1
    local atuais = encontrarMeusProps() --[span_2](start_span)[span_2](end_span)

    if #atuais < alvoLimite and #alvos > 0 then
        local faltam = alvoLimite - #atuais
        local tentativas = 0
        local maxTentativas = faltam * 2

        while #atuais < alvoLimite and tentativas < maxTentativas and propAvancadoAtivo do
            tentativas = tentativas + 1
            local idxAlvo = ((tentativas - 1) % #alvos) + 1
            local pAlvo = alvos[idxAlvo]
            local hrpAlvo = pAlvo and pAlvo.Character and pAlvo.Character:FindFirstChild("HumanoidRootPart")
            local posSpawn = hrpAlvo and (hrpAlvo.Position + Vector3.new(math.random(-2, 2), 0, math.random(-2, 2))) or posBase

            dispararCriacaoProp(posSpawn)
            task.wait(0.12)
            atuais = encontrarMeusProps() --[span_3](start_span)[span_3](end_span)
        end
    end

    return encontrarMeusProps() --[span_4](start_span)[span_4](end_span)
end

local function obterAlvosValidos()
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
        local alvo = alvoPropSelecionado and Players:FindFirstChild(alvoPropSelecionado) --[span_5](start_span)[span_5](end_span)
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

local function perseguirEMatarOuTrazerRapido(alvo, propsDisponiveis, acao)
    if not alvo or not alvo.Character or #propsDisponiveis == 0 then return false end

    local concluido = false
    local tInicio = tick()
    local limiteRapido = 2.5 -- Tempo curto por alvo para não travar em quem foge; passa logo pro próximo

    local conexao
    conexao = RunService.Heartbeat:Connect(function()
        if concluido or not propAvancadoAtivo or (tick() - tInicio > limiteRapido) then
            if conexao then conexao:Disconnect() end
            return
        end

        local char = alvo.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then
            concluido = true
            if conexao then conexao:Disconnect() end
            return
        end

        -- Move os props em alta velocidade colados no alvo para forçar o assento rápido
        for i, prop in ipairs(propsDisponiveis) do
            if prop and prop.Parent then
                local angulo = tick() * 35 + (i * 1.1)
                local raio = math.min(#propsDisponiveis - 1, 2) * 0.65
                local offset = Vector3.new(
                    math.cos(angulo) * raio,
                    math.sin(tick() * 28 + i) * 0.9,
                    math.sin(angulo) * raio
                )
                moverProp(prop, CFrame.new(hrp.Position + offset)) --[span_6](start_span)[span_6](end_span)
            end
        end

        if hum.Sit then
            concluido = true
            if conexao then conexao:Disconnect() end

            task.spawn(function()
                task.wait(0.05)
                if acao == "KILL" then
                    for _, prop in ipairs(propsDisponiveis) do
                        if prop and prop.Parent then
                            moverProp(prop, CFrame.new(hrp.Position.X, PROP_KILL_Y, hrp.Position.Z)) --[span_7](start_span)[span_7](end_span)
                        end
                    end
                elseif acao == "BRING" then
                    local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if meuHrp then
                        for i, prop in ipairs(propsDisponiveis) do
                            if prop and prop.Parent then
                                moverProp(prop, meuHrp.CFrame * CFrame.new(2 + (i * 0.4), 0, 0))
                            end
                        end
                    end
                end
            end)
        end
    end)

    while not concluido and propAvancadoAtivo and (tick() - tInicio <= limiteRapido) do
        task.wait(0.03)
    end
    concluido = true
    if conexao then conexao:Disconnect() end

    return true
end

-- 1. Lista de equipamentos disponíveis
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

-- 2. Lista de funções
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

-- 3. Lista de seleção de escopo (all ou player)
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

-- Interruptor principal
UI.Toggle(Tabs.Troll, {
    Name = "Executar Prop Selecionado",
    Description = "Até 20 props no all, foco rápido por player e troca imediata",
    CurrentValue = false,
    Callback = function(ativo)
        propAvancadoAtivo = ativo
        if not ativo then
            deletarTodosProps() --[span_8](start_span)[span_8](end_span)
            Notify("Props", "Desligado e props removidos.", 2)
            return
        end

        if not pegarPropMaker() then --[span_9](start_span)[span_9](end_span)
            propAvancadoAtivo = false
            Notify("Props", "Falha ao equipar 'caixa de props'.", 2)
            return
        end

        selecionarEquipamentoProp(equipamentoSelecionado)
        local acao = funcaoPropSelecionada:find("Kill") and "KILL" or "BRING"

        task.spawn(function()
            local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local posBase = meuHrp and meuHrp.Position or Vector3.new(-428.6, 0.4, 64.9)

            while propAvancadoAtivo do
                local modoEfetivo = modoAlvoProp
                if funcaoPropSelecionada:find("All") then
                    modoEfetivo = "all"
                elseif funcaoPropSelecionada:find("(Player)", 1, true) then
                    modoEfetivo = "player"
                end

                local alvos = obterAlvosValidos()
                if #alvos == 0 then
                    task.wait(0.25)
                    continue
                end

                local propsAtivos = prepararPropsRapido(alvos, modoEfetivo, posBase)
                if #propsAtivos == 0 then
                    task.wait(0.3)
                    continue
                end

                for _, alvo in ipairs(alvos) do
                    if not propAvancadoAtivo then break end
                    perseguirEMatarOuTrazerRapido(alvo, propsAtivos, acao)
                    task.wait(0.05)
                end

                task.wait(0.1)
            end
        end)
    end
})

--[[
--------------------------------------------------------------------------------
-- PAINEL DE PROPS (1 PROP REUTILIZADO / FOCO 1 POR VEZ / SEM AUTO-DELETE)
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Troll, {
    Title = "🚽🪑 Props Avançados (Foco 1 por Vez)",
    Description = "Spawna o prop sozinho, foca 1 alvo até concluir e só apaga ao desligar.",
    Icon = "14436167217"
})

local CONFIG_PROPS_AVANCADO = {
    Bancada = { nome = "FurnitureBleachers", categoria = "Furniture" }, --[span_7](start_span)[span_7](end_span)
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
    task.wait(0.2)
    pcall(function() clearRemote:FireServer("OpenPropMenu") end)
    task.wait(0.3)
    pcall(function() clearRemote:FireServer("RequestingPropName", info.nome, info.categoria) end)
    task.wait(0.3)
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

local function spawnarPropAutomatico(posicaoDesejada)
    local propMaker = pegarPropMaker() --[span_8](start_span)[span_8](end_span)
    if not propMaker then return nil end

    local toolProp = propMaker:FindFirstChild("Tool_PropMake") or propMaker:FindFirstChildOfClass("RemoteEvent")
    if not toolProp then return nil end

    local antes = #encontrarMeusProps() --[span_9](start_span)[span_9](end_span)
    local chaoPart, posChao = obterChaoParaSpawn(posicaoDesejada)

    pcall(function()
        toolProp:FireServer(chaoPart, posChao)
    end)
    pcall(function()
        propMaker:Activate()
    end)

    local t0 = tick()
    while tick() - t0 < 3 and propAvancadoAtivo do
        task.wait(0.2)
        local agora = encontrarMeusProps() --[span_10](start_span)[span_10](end_span)
        if #agora > antes then
            return agora[#agora]
        end
    end

    local existentes = encontrarMeusProps() --[span_11](start_span)[span_11](end_span)
    return existentes[#existentes]
end

local function obterAlvosValidos()
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
        local alvo = alvoPropSelecionado and Players:FindFirstChild(alvoPropSelecionado) --[span_12](start_span)[span_12](end_span)
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

local function concluirMissaoNoAlvo(alvo, prop, acao)
    if not alvo or not alvo.Character or not prop or not prop.Parent then return false end
    local hum = alvo.Character:FindFirstChildOfClass("Humanoid")
    local hrp = alvo.Character:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp or hum.Health <= 0 then return false end

    local tInicio = tick()
    while propAvancadoAtivo and prop.Parent and alvo.Parent and (tick() - tInicio < TEMPO_MAX_SIT) do --[span_13](start_span)[span_13](end_span)
        local charAtual = alvo.Character
        local hrpAtual = charAtual and charAtual:FindFirstChild("HumanoidRootPart")
        local humAtual = charAtual and charAtual:FindFirstChildOfClass("Humanoid")
        if not hrpAtual or not humAtual or humAtual.Health <= 0 then
            return false
        end

        local t = tick() * PROP_MOVE_SPEED --[span_14](start_span)[span_14](end_span)
        local offsetY = math.sin(t) * PROP_MOVE_RANGE --[span_15](start_span)[span_15](end_span)
        moverProp(prop, CFrame.new(hrpAtual.Position + Vector3.new(0, offsetY, 0))) --[span_16](start_span)[span_16](end_span)

        if humAtual.Sit then
            task.wait(0.1)
            if acao == "KILL" then
                moverProp(prop, CFrame.new(hrpAtual.Position.X, PROP_KILL_Y, hrpAtual.Position.Z)) --[span_17](start_span)[span_17](end_span)
            elseif acao == "BRING" then
                local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if meuHrp then
                    moverProp(prop, meuHrp.CFrame * CFrame.new(2, 0, 0))
                end
            end
            task.wait(0.6)
            return true
        end

        task.wait(0.05)
    end

    return false
end

-- 1. Lista de equipamentos disponíveis
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

-- 2. Lista de funções
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

-- 3. Lista de seleção de escopo (all ou player)
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

-- Interruptor principal
UI.Toggle(Tabs.Troll, {
    Name = "Executar Prop Selecionado",
    Description = "Foca 1 alvo por vez até concluir; só apaga os props ao desligar",
    CurrentValue = false,
    Callback = function(ativo)
        propAvancadoAtivo = ativo
        if not ativo then
            deletarTodosProps() --[span_18](start_span)[span_18](end_span)
            Notify("Props", "Desligado e props removidos.", 2)
            return
        end

        if not pegarPropMaker() then --[span_19](start_span)[span_19](end_span)
            propAvancadoAtivo = false
            Notify("Props", "Falha ao equipar 'caixa de props'.", 2)
            return
        end

        selecionarEquipamentoProp(equipamentoSelecionado)
        local acao = funcaoPropSelecionada:find("Kill") and "KILL" or "BRING"

        task.spawn(function()
            local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local posInicial = meuHrp and meuHrp.Position or Vector3.new(-428.6, 0.4, 64.9)

            local propAtivo = spawnarPropAutomatico(posInicial)
            if not propAtivo then
                propAvancadoAtivo = false
                Notify("Props", "Não foi possível gerar o prop.", 3)
                return
            end

            while propAvancadoAtivo do
                if not propAtivo or not propAtivo.Parent then
                    propAtivo = spawnarPropAutomatico(posInicial)
                    if not propAtivo then
                        task.wait(0.5)
                        continue
                    end
                end

                local alvos = obterAlvosValidos()
                if #alvos == 0 then
                    task.wait(0.5)
                    continue
                end

                for _, alvo in ipairs(alvos) do
                    if not propAvancadoAtivo then break end
                    if not propAtivo or not propAtivo.Parent then
                        propAtivo = spawnarPropAutomatico(posInicial)
                    end
                    if propAtivo then
                        concluirMissaoNoAlvo(alvo, propAtivo, acao)
                    end
                    task.wait(0.15)
                end

                task.wait(0.3)
            end
        end)
    end
})

--------------------------------------------------------------------------------
-- PAINEL DE PROPS (BANCADA / PRIVADA + KILL / BRING + ALL / PLAYER)
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Troll, {
    Title = "🚽🪑 Props Avançados (1 Player / 20 All)",
    Description = "1 prop no modo player e até 20 props no modo all.",
    Icon = "14436167217"
})

local MAX_PROPS_ALL = 20
local CONFIG_PROPS_AVANCADO = {
    Bancada = { nome = "FurnitureBleachers", categoria = "Furniture" }, --[span_1](start_span)[span_1](end_span)
    Privada = { nome = "Toilet", categoria = "Furniture" }
}

local equipamentoSelecionado = "Privada"
local funcaoPropSelecionada    = "Bring All"
local modoAlvoProp           = "all" -- "all" ou "player"
local propAvancadoAtivo      = false

local function selecionarEquipamentoProp(chave)
    local info = CONFIG_PROPS_AVANCADO[chave] or CONFIG_PROPS_AVANCADO.Bancada
    local RE = ReplicatedStorage:FindFirstChild("RE")
    local clearRemote = RE and RE:FindFirstChild("1Clea1rTool1s")
    if not clearRemote then return end
    task.wait(0.2)
    pcall(function() clearRemote:FireServer("OpenPropMenu") end)
    task.wait(0.3)
    pcall(function() clearRemote:FireServer("RequestingPropName", info.nome, info.categoria) end)
    task.wait(0.3)
end

local function obterModoEfetivo()
    if funcaoPropSelecionada == "Kill All" or funcaoPropSelecionada == "Bring All" then
        return "all"
    elseif funcaoPropSelecionada == "Kill (Player)" or funcaoPropSelecionada == "Bring (Player)" then
        return "player"
    end
    return modoAlvoProp
end

local function obterListaAlvosAvancado()
    local lista = {}
    local modoEfetivo = obterModoEfetivo()

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
        local alvo = alvoPropSelecionado and Players:FindFirstChild(alvoPropSelecionado) --[span_2](start_span)[span_2](end_span)
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

local function criarPropEmPosicao(posicao, limiteMaximo)
    local antes = #encontrarMeusProps() --[span_3](start_span)[span_3](end_span)
    if antes >= limiteMaximo then
        return nil
    end

    spawnarProp(posicao) --[span_4](start_span)[span_4](end_span)
    task.wait(0.25)

    local agora = encontrarMeusProps() --[span_5](start_span)[span_5](end_span)
    if #agora > antes then
        return agora[#agora]
    end

    local t0 = tick()
    while tick() - t0 < 2.5 and propAvancadoAtivo do
        task.wait(0.15)
        agora = encontrarMeusProps() --[span_6](start_span)[span_6](end_span)
        if #agora > antes then
            return agora[#agora]
        end
    end

    return nil
end

local function gerarLoteProps(alvos, modoEfetivo)
    local propsCriados = {}
    if #alvos == 0 then return propsCriados end

    -- No modo 'player', cria apenas 1 prop no alvo
    if modoEfetivo == "player" then
        local alvo = alvos[1]
        local hrp = alvo and alvo.Character and alvo.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local prop = criarPropEmPosicao(hrp.Position, #encontrarMeusProps() + 1) --[span_7](start_span)[span_7](end_span)
            if prop then
                table.insert(propsCriados, { prop = prop, alvo = alvo })
            end
        end
        return propsCriados
    end

    -- No modo 'all', cria no máximo 20 props no total
    local totalAtual = #encontrarMeusProps() --[span_8](start_span)[span_8](end_span)
    local espacoLivre = math.max(0, MAX_PROPS_ALL - totalAtual)
    if espacoLivre <= 0 then
        return propsCriados
    end

    local porAlvo = math.max(1, math.floor(espacoLivre / #alvos))
    local criadosNestaChamada = 0

    for _, alvo in ipairs(alvos) do
        if not propAvancadoAtivo or criadosNestaChamada >= espacoLivre then break end

        for i = 1, porAlvo do
            if not propAvancadoAtivo or criadosNestaChamada >= espacoLivre then break end
            if not alvo or not alvo.Character then break end
            local hrp = alvo.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then break end

            local offset = Vector3.new(
                math.random(-3, 3),
                0,
                math.random(-3, 3)
            )
            local prop = criarPropEmPosicao(hrp.Position + offset, MAX_PROPS_ALL)
            if prop then
                criadosNestaChamada = criadosNestaChamada + 1
                table.insert(propsCriados, { prop = prop, alvo = alvo })
            end
        end
    end

    return propsCriados
end

local function acompanharEExecutarProps(paresPropAlvo, acao)
    if #paresPropAlvo == 0 then return end

    local tInicio = tick()
    local concluidos = {}

    while propAvancadoAtivo and (tick() - tInicio < TEMPO_MAX_SIT) do --[span_9](start_span)[span_9](end_span)
        local todosConcluidos = true

        for idx, item in ipairs(paresPropAlvo) do
            if not concluidos[idx] then
                local alvo = item.alvo
                local prop = item.prop

                if not alvo or not alvo.Parent or not prop or not prop.Parent then
                    concluidos[idx] = true
                else
                    local charAtual = alvo.Character
                    local hrpAtual = charAtual and charAtual:FindFirstChild("HumanoidRootPart")
                    local humAtual = charAtual and charAtual:FindFirstChildOfClass("Humanoid")

                    if not hrpAtual or not humAtual or humAtual.Health <= 0 then
                        concluidos[idx] = true
                    else
                        todosConcluidos = false
                        local t = tick() * PROP_MOVE_SPEED + idx --[span_10](start_span)[span_10](end_span)
                        local offsetY = math.sin(t) * PROP_MOVE_RANGE --[span_11](start_span)[span_11](end_span)
                        local offsetX = #paresPropAlvo > 1 and (math.cos(t) * 1.5) or 0
                        local offsetZ = #paresPropAlvo > 1 and (math.sin(t) * 1.5) or 0
                        moverProp(prop, CFrame.new(hrpAtual.Position + Vector3.new(offsetX, offsetY, offsetZ))) --[span_12](start_span)[span_12](end_span)

                        if humAtual.Sit then
                            concluidos[idx] = true
                            task.wait(0.08)
                            if acao == "KILL" then
                                moverProp(prop, CFrame.new(hrpAtual.Position.X, PROP_KILL_Y, hrpAtual.Position.Z)) --[span_13](start_span)[span_13](end_span)
                            elseif acao == "BRING" then
                                local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                if meuHrp then
                                    moverProp(prop, meuHrp.CFrame * CFrame.new(2, 0, 0))
                                end
                            end
                        end
                    end
                end
            end
        end

        if todosConcluidos then break end
        task.wait(0.05)
    end
end

-- 1. Lista de equipamentos disponíveis
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

-- 2. Lista de funções
UI.Dropdown(Tabs.Troll, {
    Name = "Função do Prop",
    Options = { "Kill All", "Kill (Player)", "Bring All", "Bring (Player)" },
    CurrentOption = { "Bring All" },
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

-- 3. Lista de seleção de escopo (all ou player)
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

-- Interruptor para executar a configuração escolhida
UI.Toggle(Tabs.Troll, {
    Name = "Executar Prop Selecionado",
    Description = "1 prop no player selecionado; até 20 props no modo all",
    CurrentValue = false,
    Callback = function(ativo)
        propAvancadoAtivo = ativo
        if not ativo then
            deletarTodosProps() --[span_14](start_span)[span_14](end_span)
            Notify("Props", "Execução desligada.", 2)
            return
        end

        if not pegarPropMaker() then --[span_15](start_span)[span_15](end_span)
            propAvancadoAtivo = false
            Notify("Props", "Falha ao equipar 'caixa de props'.", 2)
            return
        end

        selecionarEquipamentoProp(equipamentoSelecionado)
        local acao = funcaoPropSelecionada:find("Kill") and "KILL" or "BRING"
        local modoEfetivo = obterModoEfetivo()

        task.spawn(function()
            while propAvancadoAtivo do
                local alvos = obterListaAlvosAvancado()
                if #alvos == 0 then
                    if modoEfetivo == "player" then
                        Notify("Props", "Selecione um alvo válido na lista de players!", 3)
                        propAvancadoAtivo = false
                        break
                    end
                    task.wait(0.8)
                    continue
                end

                local lote = gerarLoteProps(alvos, modoEfetivo)
                if #lote > 0 then
                    acompanharEExecutarProps(lote, acao)
                end

                deletarTodosProps() --[span_16](start_span)[span_16](end_span)
                if modoEfetivo == "player" then
                    propAvancadoAtivo = false
                    break
                end
                task.wait(0.5)
            end

            deletarTodosProps() --[span_17](start_span)[span_17](end_span)
        end)
    end
})

--------------------------------------------------------------------------------
-- TROLL AÉREO (CHINOOK MILITARY)
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Troll, {
    Title = "🚁 Veículos | Prisão Aérea",
    Description = "Spawna o helicóptero e prende o alvo no alto.",
    Icon = "5197571759"
})

local prisaoHelicopteroAtiva = false
local alvoPrisao = nil

local function encontrarMeuChinook()
    local pastaVeiculos = Workspace:FindFirstChild("Vehicles") or Workspace
    for _, obj in ipairs(pastaVeiculos:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:find("Chinook") or obj.Name:find("Helicopter")) then
            local owner = obj:FindFirstChild("Owner") or obj:FindFirstChild("Player")
            if (owner and tostring(owner.Value) == LocalPlayer.Name) or obj.Name:find(LocalPlayer.Name) then
                return obj
            end
        end
    end
    return nil
end

local function iniciarPrisaoAerea(playerAlvo)
    prisaoHelicopteroAtiva = true
    alvoPrisao = playerAlvo

    task.spawn(function()
        local charLocal = LocalPlayer.Character
        local hrpLocal = charLocal and charLocal:FindFirstChild("HumanoidRootPart")
        local humLocal = charLocal and charLocal:FindFirstChildOfClass("Humanoid")
        if not hrpLocal or not humLocal then
            prisaoHelicopteroAtiva = false
            return
        end

        -- 1. Teleporta para X: -311 | Y: 62 | Z: 74
        hrpLocal.CFrame = CFrame.new(-311, 62, 74)
        task.wait(0.35)

        -- 2. Chama o SpawnVehicle com ChinookMilitary
        local spawnRemote = Workspace:FindFirstChild("AirVehicleSpawner")
            and Workspace.AirVehicleSpawner:FindFirstChild("SpawnVehicle")

        if spawnRemote and spawnRemote:IsA("RemoteFunction") then
            task.spawn(function()
                pcall(function()
                    spawnRemote:InvokeServer("ChinookMilitary")
                end)
            end)
        end

        -- 3. Aguarda o veículo aparecer; se o tempo passar sem gerar, avisa
        local heli = nil
        local tempoLimite = 2.5
        local decorrido = 0
        while decorrido < tempoLimite and prisaoHelicopteroAtiva do
            heli = encontrarMeuChinook()
            if heli then break end
            task.wait(0.2)
            decorrido = decorrido + 0.2
        end

        if not heli then
            prisaoHelicopteroAtiva = false
            Notify("Prisão Aérea", "Não foi possível gerar", 3)
            return
        end

        -- 4. Senta no piloto para ter controle de física do helicóptero
        local assentoPiloto = heli:FindFirstChildWhichIsA("VehicleSeat", true)
        local assentosPassageiros = {}
        for _, d in ipairs(heli:GetDescendants()) do
            if d:IsA("Seat") and not d:IsA("VehicleSeat") then
                table.insert(assentosPassageiros, d)
            end
        end

        if assentoPiloto and #assentosPassageiros > 0 then
            assentoPiloto:Sit(humLocal)
            task.wait(0.3)
        else
            prisaoHelicopteroAtiva = false
            Notify("Prisão Aérea", "Não foi possível gerar", 3)
            return
        end

        local alturaPrisao = 180
        local pontoBaseCFrame = nil

        -- 5. Loop de captura e prisão na altura segura
        while prisaoHelicopteroAtiva and heli and heli.Parent and alvoPrisao and alvoPrisao.Parent do
            local charAlvo = alvoPrisao.Character
            local hrpAlvo = charAlvo and charAlvo:FindFirstChild("HumanoidRootPart")
            local humAlvo = charAlvo and charAlvo:FindFirstChildOfClass("Humanoid")

            if not hrpAlvo or not humAlvo or humAlvo.Health <= 0 then
                task.wait(0.5)
                continue
            end

            local alvoSentado = false
            for _, seat in ipairs(assentosPassageiros) do
                if seat.Occupant == humAlvo then
                    alvoSentado = true
                    break
                end
            end

            for _, part in ipairs(heli:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.AssemblyLinearVelocity = Vector3.zero
                    part.AssemblyAngularVelocity = Vector3.zero
                end
            end

            if alvoSentado then
                if not pontoBaseCFrame then
                    pontoBaseCFrame = CFrame.new(hrpAlvo.Position + Vector3.new(0, alturaPrisao, 0))
                end
                heli:PivotTo(pontoBaseCFrame)
            else
                local assentoLivre = nil
                for _, seat in ipairs(assentosPassageiros) do
                    if seat.Occupant == nil then
                        assentoLivre = seat
                        break
                    end
                end

                if assentoLivre then
                    local offsetAssento = heli:GetPivot():ToObjectSpace(assentoLivre.CFrame)
                    local alvoCFrame = hrpAlvo.CFrame * offsetAssento:Inverse()
                    heli:PivotTo(alvoCFrame)
                end
            end

            task.wait(0.05)
        end

        pontoBaseCFrame = nil
    end)
end

UI.Toggle(Tabs.Troll, {
    Name = "🚁 Prisão Aérea (Chinook Military)",
    Description = "Teleporta, tenta gerar o helicóptero e prende o alvo no alto.",
    CurrentValue = false,
    Callback = function(ativo)
        if ativo then
            local nomeAlvo = AlvoSelecionado
            local alvo = nomeAlvo and Players:FindFirstChild(nomeAlvo)
            if not alvo then
                prisaoHelicopteroAtiva = false
                Notify("Prisão Aérea", "Selecione um alvo válido!", 3)
                return
            end
            iniciarPrisaoAerea(alvo)
        else
            prisaoHelicopteroAtiva = false
            alvoPrisao = nil
            Notify("Prisão Aérea", "Desligado.", 2)
        end
    end
})
--]]
