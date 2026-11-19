if not _G.RD4X_UI then error("[RD4X] Execute a Parte 1/4 primeiro!") end --[span_0](start_span)[span_0](end_span)

local Players = game:GetService("Players") --[span_1](start_span)[span_1](end_span)
local Workspace = game:GetService("Workspace") --[span_2](start_span)[span_2](end_span)
local ReplicatedStorage = game:GetService("ReplicatedStorage") --[span_3](start_span)[span_3](end_span)
local RunService = game:GetService("RunService") --[span_4](start_span)[span_4](end_span)
local LocalPlayer = Players.LocalPlayer --[span_5](start_span)[span_5](end_span)

local UI        = _G.RD4X_UI --[span_6](start_span)[span_6](end_span)
local Notify    = _G.RD4X_Notify --[span_7](start_span)[span_7](end_span)
local Tabs      = _G.RD4X_Tabs --[span_8](start_span)[span_8](end_span)

-- MÚSICAS --[span_9](start_span)[span_9](end_span)
local PlayerToolEvent = nil --[span_10](start_span)[span_10](end_span)
local function atualizarToolRemote() --[span_11](start_span)[span_11](end_span)
    local RE = ReplicatedStorage:FindFirstChild("RE") --[span_12](start_span)[span_12](end_span)
    PlayerToolEvent = RE and RE:FindFirstChild("PlayerToolEvent") --[span_13](start_span)[span_13](end_span)
end
atualizarToolRemote() --[span_14](start_span)[span_14](end_span)
UI.InfoBlock(Tabs.Musicas, { --[span_15](start_span)[span_15](end_span)
Title = "Ids Músicas", --[span_16](start_span)[span_16](end_span)
Description = "Ids d músicas", --[span_17](start_span)[span_17](end_span)
Icon = "105472378838470" --[span_18](start_span)[span_18](end_span)
})
local idMusicaCustom = "" --[span_19](start_span)[span_19](end_span)
UI.Input(Tabs.Musicas, { Name = "Ids De Áudios", CurrentValue = "", PlaceholderText = "Ex: 9048375035", Callback = function(t) idMusicaCustom = t end }) --[span_20](start_span)[span_20](end_span)
UI.Button(Tabs.Musicas, { --[span_21](start_span)[span_21](end_span)
    Name = "Tocar Audio ID Personalizado", --[span_22](start_span)[span_22](end_span)
    Description = "Toca a música pelo ID inserido acima", --[span_23](start_span)[span_23](end_span)
    Callback = function() --[span_24](start_span)[span_24](end_span)
        atualizarToolRemote() --[span_25](start_span)[span_25](end_span)
        if PlayerToolEvent and idMusicaCustom ~= "" then --[span_26](start_span)[span_26](end_span)
            PlayerToolEvent:FireServer("ToolMusicText", idMusicaCustom) --[span_27](start_span)[span_27](end_span)
        end
    end
})

local LISTA_FUNK = { --[span_28](start_span)[span_28](end_span)
    ["piranha"]               = "103811087853875", --[span_29](start_span)[span_29](end_span)
    ["os menor"]              = "126719632721905", --[span_30](start_span)[span_30](end_span)
    ["vai caindo com a bct"]  = "74967642581893", --[span_31](start_span)[span_31](end_span)
    ["facada"]                = "81730477878065", --[span_32](start_span)[span_32](end_span)
    ["Tipo nino"]             = "140336018782383", --[span_33](start_span)[span_33](end_span)
    ["lacs"]                  = "121544291272731", --[span_34](start_span)[span_34](end_span)
    ["Funk"]                  = "74206017407052", --[span_35](start_span)[span_35](end_span)
    ["onda do birimbau"]      = "90728144562197", --[span_36](start_span)[span_36](end_span)
    ["piseiro bahiano"]       = "111425053457342", --[span_37](start_span)[span_37](end_span)
    ["cheiro"]                = "102430799050444", --[span_38](start_span)[span_38](end_span)
    ["afrozada"]              = "116257708415048", --[span_39](start_span)[span_39](end_span)
    ["sequência de papapey"]  = "127060465281063", --[span_40](start_span)[span_40](end_span)
    ["lampada da sorte"]  = "71393805905055", --[span_41](start_span)[span_41](end_span)
    ["bem louca"]  = "94365050554101", --[span_42](start_span)[span_42](end_span)
    ["jantar em familia"]  = "103043727188319", --[span_43](start_span)[span_43](end_span)
    ["místico 2"]  = "112182302553336", --[span_44](start_span)[span_44](end_span)
    ["koala"]  = "136574160308808", --[span_45](start_span)[span_45](end_span)
    ["tufitufi"]  = "132901244600312", --[span_46](start_span)[span_46](end_span)
    ["madley"]  = "81928219376467", --[span_47](start_span)[span_47](end_span)
    ["mágica 2"]  = "81733205826673", --[span_48](start_span)[span_48](end_span)
    ["desestressabb"]  = "131777662810651", --[span_49](start_span)[span_49](end_span)
    ["mtg jogador raro BH"]  = "94678954269340", --[span_50](start_span)[span_50](end_span)
    ["joga joga"]  = "109330943148950", --[span_51](start_span)[span_51](end_span)
    ["tak"]  = "128417229744862", --[span_52](start_span)[span_52](end_span)
    ["ta nervoso d+"]  = "92999059792601", --[span_53](start_span)[span_53](end_span)
    ["m4"]  = "76707483030355", --[span_54](start_span)[span_54](end_span)
    ["antares"]  = "73461924431293", --[span_55](start_span)[span_55](end_span)
    ["azul piscina"]  = "80512054525157", --[span_56](start_span)[span_56](end_span)
    ["jssr"]  = "99857365723549", --[span_57](start_span)[span_57](end_span)
}
local LISTA_FORRO = { --[span_58](start_span)[span_58](end_span)
    ["uma botadinha"]         = "84624301411909", --[span_59](start_span)[span_59](end_span)
    ["eu me apaixonei"]       = "139414982330352", --[span_60](start_span)[span_60](end_span)
    ["Pisada xl"]             = "70508008395270", --[span_61](start_span)[span_61](end_span)
    ["notificação preferida"] = "90137280531474", --[span_62](start_span)[span_62](end_span)
    ["só fé"]                 = "139128878060651", --[span_63](start_span)[span_63](end_span)
    ["desça daí seu corno"]   = "1197388789221996", --[span_64](start_span)[span_64](end_span)
    ["até o fim"]  = "139777248910220", --[span_65](start_span)[span_65](end_span)
    ["apaixonei na sua botada"]  = "132901244600372", --[span_66](start_span)[span_66](end_span)
}
local LISTA_PHONK = { --[span_67](start_span)[span_67](end_span)
    ["Phonk"]              = "COLE_O_ID_AQUI", --[span_68](start_span)[span_68](end_span)
    ["Phonk"]              = "COLE_O_ID_AQUI", --[span_69](start_span)[span_69](end_span)
}

local function tocarMusicaPorNome(lista, nome) --[span_70](start_span)[span_70](end_span)
    atualizarToolRemote() --[span_71](start_span)[span_71](end_span)
    local id = lista[nome] --[span_72](start_span)[span_72](end_span)
    if PlayerToolEvent and id and id ~= "COLE_O_ID_AQUI" then --[span_73](start_span)[span_73](end_span)
        PlayerToolEvent:FireServer("ToolMusicText", id) --[span_74](start_span)[span_74](end_span)
    end
end
local function obterNomes(lista) --[span_75](start_span)[span_75](end_span)
    local nomes = {} --[span_76](start_span)[span_76](end_span)
    for nome, _ in pairs(lista) do table.insert(nomes, nome) end --[span_77](start_span)[span_77](end_span)
    table.sort(nomes) --[span_78](start_span)[span_78](end_span)
    return nomes --[span_79](start_span)[span_79](end_span)
end

UI.Dropdown(Tabs.Musicas, { --[span_80](start_span)[span_80](end_span)
    Name = "Funk", Options = obterNomes(LISTA_FUNK), --[span_81](start_span)[span_81](end_span)
    CurrentOption = {"Selecione um Funk..."}, --[span_82](start_span)[span_82](end_span)
    Callback = function(opt) if opt and opt[1] then tocarMusicaPorNome(LISTA_FUNK, opt[1]) end end --[span_83](start_span)[span_83](end_span)
})
UI.Dropdown(Tabs.Musicas, { --[span_84](start_span)[span_84](end_span)
    Name = "Forró", Options = obterNomes(LISTA_FORRO), --[span_85](start_span)[span_85](end_span)
    CurrentOption = {"Selecione um Forró..."}, --[span_86](start_span)[span_86](end_span)
    Callback = function(opt) if opt and opt[1] then tocarMusicaPorNome(LISTA_FORRO, opt[1]) end end --[span_87](start_span)[span_87](end_span)
})
UI.Dropdown(Tabs.Musicas, { --[span_88](start_span)[span_88](end_span)
    Name = "Phonk", Options = obterNomes(LISTA_PHONK), --[span_89](start_span)[span_89](end_span)
    CurrentOption = {"Selecione um Phonk..."}, --[span_90](start_span)[span_90](end_span)
    Callback = function(opt) if opt and opt[1] then tocarMusicaPorNome(LISTA_PHONK, opt[1]) end end --[span_91](start_span)[span_91](end_span)
})

--------------------------------------------------------------------------------
-- TROLL --[span_92](start_span)[span_92](end_span)
--------------------------------------------------------------------------------
local alvoTrollSelecionado = LocalPlayer.Name --[span_93](start_span)[span_93](end_span)
local function obterListaJogadoresTroll() --[span_94](start_span)[span_94](end_span)
    local lista = {} --[span_95](start_span)[span_95](end_span)
    for _, p in ipairs(Players:GetPlayers()) do --[span_96](start_span)[span_96](end_span)
        if p ~= LocalPlayer then table.insert(lista, p.Name) end --[span_97](start_span)[span_97](end_span)
    end
    if #lista == 0 then table.insert(lista, LocalPlayer.Name) end --[span_98](start_span)[span_98](end_span)
    return lista --[span_99](start_span)[span_99](end_span)
end

UI.InfoBlock(Tabs.Troll, { --[span_100](start_span)[span_100](end_span)
    Title = "Bus Kill (void)", --[span_101](start_span)[span_101](end_span)
    Description = "Mata o alvo jogando ele no void", --[span_102](start_span)[span_102](end_span)
    Icon = "14436167217" --[span_103](start_span)[span_103](end_span)
})

local dropdownAlvoTroll = UI.Dropdown(Tabs.Troll, { --[span_104](start_span)[span_104](end_span)
    Name = "Selecionar alvo", --[span_105](start_span)[span_105](end_span)
    Options = obterListaJogadoresTroll(), --[span_106](start_span)[span_106](end_span)
    CurrentOption = {obterListaJogadoresTroll()[1]}, --[span_107](start_span)[span_107](end_span)
    Callback = function(opt) --[span_108](start_span)[span_108](end_span)
        if opt and opt[1] then --[span_109](start_span)[span_109](end_span)
            alvoTrollSelecionado = opt[1] --[span_110](start_span)[span_110](end_span)
            Notify("Troll", "Alvo selecionado: " .. alvoTrollSelecionado, 2) --[span_111](start_span)[span_111](end_span)
        end
    end,
})

UI.Button(Tabs.Troll, { --[span_112](start_span)[span_112](end_span)
    Name = "Atualizar Lista", --[span_113](start_span)[span_113](end_span)
    Description = "Atualiza a lista de jogadores", --[span_114](start_span)[span_114](end_span)
    Callback = function() --[span_115](start_span)[span_115](end_span)
        dropdownAlvoTroll:Refresh(obterListaJogadoresTroll()) --[span_116](start_span)[span_116](end_span)
        Notify("Troll", "Lista de jogadores atualizada.", 2) --[span_117](start_span)[span_117](end_span)
    end,
})

-- BUS KILL --[span_118](start_span)[span_118](end_span)
local busAtivo = false --[span_119](start_span)[span_119](end_span)

UI.Button(Tabs.Troll, { --[span_120](start_span)[span_120](end_span)
    Name = "Iniciar Bus Kill (Void)", --[span_121](start_span)[span_121](end_span)
    Description = "Joga o player selecionado para o void", --[span_122](start_span)[span_122](end_span)
    Callback = function() --[span_123](start_span)[span_123](end_span)
        if busAtivo then Notify("Troll", "Já possui um ônibus em perseguição", 2); return end --[span_124](start_span)[span_124](end_span)

        local RE = ReplicatedStorage:FindFirstChild("RE") --[span_125](start_span)[span_125](end_span)
        local CarRemote = RE and RE:FindFirstChild("1Ca1r") --[span_126](start_span)[span_126](end_span)
        if not CarRemote then Notify("Erro", "Tente Novamente", 3); return end --[span_127](start_span)[span_127](end_span)

        local alvo = Players:FindFirstChild(alvoTrollSelecionado) --[span_128](start_span)[span_128](end_span)
        if not alvo or not alvo.Character then Notify("Troll", "Selecione um player na lista", 3); return end --[span_129](start_span)[span_129](end_span)

        local rootAlvo = alvo.Character:FindFirstChild("HumanoidRootPart") --[span_130](start_span)[span_130](end_span)
        local humanoidAlvo = alvo.Character:FindFirstChildOfClass("Humanoid") --[span_131](start_span)[span_131](end_span)
        if not rootAlvo or not humanoidAlvo then Notify("Troll", "...!", 3); return end --[span_132](start_span)[span_132](end_span)

        busAtivo = true --[span_133](start_span)[span_133](end_span)
        CarRemote:FireServer("PickingCar", "SchoolBus") --[span_134](start_span)[span_134](end_span)
        Notify("Bus Kill", "Gerando ônibus, aguarde...", 3) --[span_135](start_span)[span_135](end_span)

        task.spawn(function() --[span_136](start_span)[span_136](end_span)
            local function encontrarNovoOnibus() --[span_137](start_span)[span_137](end_span)
                local tInicio = tick() --[span_138](start_span)[span_138](end_span)
                local ultimoOnibus = nil --[span_139](start_span)[span_139](end_span)
                local ultimoSeat = nil --[span_140](start_span)[span_140](end_span)
                while tick() - tInicio < 4 do --[span_141](start_span)[span_141](end_span)
                    for _, obj in ipairs(workspace:GetDescendants()) do --[span_142](start_span)[span_142](end_span)
                        if obj:IsA("Model") then --[span_143](start_span)[span_143](end_span)
                            local nomeUpper = obj.Name:upper() --[span_144](start_span)[span_144](end_span)
                            local playerUpper = LocalPlayer.Name:upper() --[span_145](start_span)[span_145](end_span)
                            if (nomeUpper:find("BUS") or nomeUpper:find("SCHOOL") or nomeUpper:find(playerUpper)) then --[span_146](start_span)[span_146](end_span)
                                local seat = obj:FindFirstChildOfClass("VehicleSeat") or obj:FindFirstChild("VehicleSeat", true) --[span_147](start_span)[span_147](end_span)
                                if seat and seat.Position.Y > -50 then --[span_148](start_span)[span_148](end_span)
                                    ultimoOnibus = obj --[span_149](start_span)[span_149](end_span)
                                    ultimoSeat = seat --[span_150](start_span)[span_150](end_span)
                                end
                            end
                        end
                    end
                    if ultimoOnibus and ultimoSeat then return ultimoOnibus, ultimoSeat end --[span_151](start_span)[span_151](end_span)
                    task.wait(0.2) --[span_152](start_span)[span_152](end_span)
                end
                return nil, nil --[span_153](start_span)[span_153](end_span)
            end

            local onibus, seatMotorista = encontrarNovoOnibus() --[span_154](start_span)[span_154](end_span)
            local myChar = LocalPlayer.Character --[span_155](start_span)[span_155](end_span)
            local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid") --[span_156](start_span)[span_156](end_span)
            local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart") --[span_157](start_span)[span_157](end_span)

            if onibus and seatMotorista and myHum then --[span_158](start_span)[span_158](end_span)
                pcall(function() seatMotorista:Sit(myHum) end) --[span_159](start_span)[span_159](end_span)
                task.wait(0.1) --[span_160](start_span)[span_160](end_span)

                local girando = true --[span_161](start_span)[span_161](end_span)
                local conexaoRender --[span_162](start_span)[span_162](end_span)
                conexaoRender = RunService.RenderStepped:Connect(function() --[span_163](start_span)[span_163](end_span)
                    if girando and rootAlvo and rootAlvo.Parent and onibus and onibus.Parent then --[span_164](start_span)[span_164](end_span)
                        local tempo = tick() * 25 --[span_165](start_span)[span_165](end_span)
                        local rotX = math.rad(tempo * 50 % 360) --[span_166](start_span)[span_166](end_span)
                        local rotY = math.rad(tempo * 80 % 360) --[span_167](start_span)[span_167](end_span)
                        local rotZ = math.rad(tempo * 30 % 360) --[span_168](start_span)[span_168](end_span)
                        local posicaoAlvo = rootAlvo.CFrame --[span_169](start_span)[span_169](end_span)
                        onibus:PivotTo(posicaoAlvo * CFrame.Angles(rotX, rotY, rotZ)) --[span_170](start_span)[span_170](end_span)
                    else
                        if conexaoRender then conexaoRender:Disconnect() end --[span_171](start_span)[span_171](end_span)
                    end
                end)

                local conexaoSentouBus --[span_172](start_span)[span_172](end_span)
                conexaoSentouBus = humanoidAlvo.Seated:Connect(function(isSeated, seat) --[span_173](start_span)[span_173](end_span)
                    if isSeated and seat and seat:IsDescendantOf(onibus) then --[span_174](start_span)[span_174](end_span)
                        girando = false --[span_175](start_span)[span_175](end_span)
                        if conexaoRender then conexaoRender:Disconnect() end --[span_176](start_span)[span_176](end_span)
                        onibus:PivotTo(CFrame.new(rootAlvo.Position.X, -300, rootAlvo.Position.Z)) --[span_177](start_span)[span_177](end_span)
                        task.wait(0.2) --[span_178](start_span)[span_178](end_span)
                        pcall(function() --[span_179](start_span)[span_179](end_span)
                            if myHum then myHum.Sit = false end --[span_180](start_span)[span_180](end_span)
                            if myHrp then myHrp.CFrame = CFrame.new(-26, 7, 1) end --[span_181](start_span)[span_181](end_span)
                        end)
                        Notify("Bus Kill", "return: 'praça'", 3) --[span_182](start_span)[span_182](end_span)
                        if conexaoSentouBus then conexaoSentouBus:Disconnect() end --[span_183](start_span)[span_183](end_span)
                        busAtivo = false --[span_184](start_span)[span_184](end_span)
                    end
                end)

                task.delay(30, function() --[span_185](start_span)[span_185](end_span)
                    girando = false --[span_186](start_span)[span_186](end_span)
                    busAtivo = false --[span_187](start_span)[span_187](end_span)
                    if conexaoRender then conexaoRender:Disconnect() end --[span_188](start_span)[span_188](end_span)
                    if conexaoSentouBus then conexaoSentouBus:Disconnect() end --[span_189](start_span)[span_189](end_span)
                end)
            else
                Notify("Erro", "Falha ao gerar novo ônibus. Tente novamente.", 3) --[span_190](start_span)[span_190](end_span)
                busAtivo = false --[span_191](start_span)[span_191](end_span)
            end
        end)
    end,
})

UI.Button(Tabs.Troll, { --[span_192](start_span)[span_192](end_span)
    Name = "Stop Bus", --[span_193](start_span)[span_193](end_span)
    Description = "Cancela a perseguição", --[span_194](start_span)[span_194](end_span)
    Callback = function() busAtivo = false; Notify("Troll", "Bus Kill desativado", 2) end, --[span_195](start_span)[span_195](end_span)
})
--[[
--------------------------------------------------------------------------------
-- VEÍCULOS / ÔNIBUS AVANÇADO (DELETA APÓS MATAR / LOOP NO ALL ATÉ DESLIGAR)
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Troll, { --[span_196](start_span)[span_196](end_span)
    Title = "🚌 Veículos / Bus Loop", --[span_197](start_span)[span_197](end_span)
    Description = "Escolhe o veículo, deleta após matar o alvo e faz loop no all até desligar.", --[span_198](start_span)[span_198](end_span)
    Icon = "14436167217" --[span_199](start_span)[span_199](end_span)
})

local VEICULOS_DISPONIVEIS = { --[span_200](start_span)[span_200](end_span)
    "SchoolBus", --[span_201](start_span)[span_201](end_span)
    "PoliceCar", --[span_202](start_span)[span_202](end_span)
    "Ambulance", --[span_203](start_span)[span_203](end_span)
    "FireTruck", --[span_204](start_span)[span_204](end_span)
    "Limousine", --[span_205](start_span)[span_205](end_span)
    "RV" --[span_206](start_span)[span_206](end_span)
}

local veiculoBusSelecionado = "SchoolBus" --[span_207](start_span)[span_207](end_span)
local modoAlvoBus           = "all" -- "all" ou "player" --[span_208](start_span)[span_208](end_span)
local loopBusAvancadoAtivo  = false --[span_209](start_span)[span_209](end_span)
local veiculoLoopAtual       = nil

local function destruirVeiculoLoopAtual()
    if veiculoLoopAtual and veiculoLoopAtual.Parent then
        pcall(function()
            veiculoLoopAtual:Destroy()
        end)
    end
    veiculoLoopAtual = nil
end

-- 1. Lista de veículos disponíveis --[span_210](start_span)[span_210](end_span)
UI.Dropdown(Tabs.Troll, { --[span_211](start_span)[span_211](end_span)
    Name = "🚍 Veículo Disponível", --[span_212](start_span)[span_212](end_span)
    Options = VEICULOS_DISPONIVEIS, --[span_213](start_span)[span_213](end_span)
    CurrentOption = { "SchoolBus" }, --[span_214](start_span)[span_214](end_span)
    Callback = function(opt) --[span_215](start_span)[span_215](end_span)
        if opt and opt[1] then --[span_216](start_span)[span_216](end_span)
            veiculoBusSelecionado = opt[1] --[span_217](start_span)[span_217](end_span)
            Notify("Bus Loop", "Veículo: " .. veiculoBusSelecionado, 2) --[span_218](start_span)[span_218](end_span)
        end
    end
})

-- 2. Lista de all ou player (usa o player escolhido em "Selecionar alvo") --[span_219](start_span)[span_219](end_span)
UI.Dropdown(Tabs.Troll, { --[span_220](start_span)[span_220](end_span)
    Name = "🎯 Alvo do Veículo (all / player)", --[span_221](start_span)[span_221](end_span)
    Options = { "all", "player" }, --[span_222](start_span)[span_222](end_span)
    CurrentOption = { "all" }, --[span_223](start_span)[span_223](end_span)
    Callback = function(opt) --[span_224](start_span)[span_224](end_span)
        if opt and opt[1] then --[span_225](start_span)[span_225](end_span)
            modoAlvoBus = opt[1] --[span_226](start_span)[span_226](end_span)
            Notify("Bus Loop", "Modo: " .. modoAlvoBus, 2) --[span_227](start_span)[span_227](end_span)
        end
    end
})

local function obterAlvosBusSemVoce() --[span_228](start_span)[span_228](end_span)
    local lista = {} --[span_229](start_span)[span_229](end_span)
    if modoAlvoBus == "all" then --[span_230](start_span)[span_230](end_span)
        for _, p in ipairs(Players:GetPlayers()) do --[span_231](start_span)[span_231](end_span)
            if p ~= LocalPlayer and p.Character then --[span_232](start_span)[span_232](end_span)
                local hum = p.Character:FindFirstChildOfClass("Humanoid") --[span_233](start_span)[span_233](end_span)
                local hrp = p.Character:FindFirstChild("HumanoidRootPart") --[span_234](start_span)[span_234](end_span)
                if hum and hrp and hum.Health > 0 then --[span_235](start_span)[span_235](end_span)
                    table.insert(lista, p) --[span_236](start_span)[span_236](end_span)
                end
            end
        end
    else
        local alvo = alvoTrollSelecionado and Players:FindFirstChild(alvoTrollSelecionado) --[span_237](start_span)[span_237](end_span)
        if alvo and alvo ~= LocalPlayer and alvo.Character then --[span_238](start_span)[span_238](end_span)
            local hum = alvo.Character:FindFirstChildOfClass("Humanoid") --[span_239](start_span)[span_239](end_span)
            local hrp = alvo.Character:FindFirstChild("HumanoidRootPart") --[span_240](start_span)[span_240](end_span)
            if hum and hrp and hum.Health > 0 then --[span_241](start_span)[span_241](end_span)
                table.insert(lista, alvo) --[span_242](start_span)[span_242](end_span)
            end
        end
    end
    return lista --[span_243](start_span)[span_243](end_span)
end

local function buscarVeiculoGerado(nomeVeiculo) --[span_244](start_span)[span_244](end_span)
    local tInicio = tick() --[span_245](start_span)[span_245](end_span)
    local ultimoModelo = nil --[span_246](start_span)[span_246](end_span)
    local ultimoSeat = nil --[span_247](start_span)[span_247](end_span)
    local alvoUpper = tostring(nomeVeiculo or "SchoolBus"):upper() --[span_248](start_span)[span_248](end_span)
    local playerUpper = LocalPlayer.Name:upper() --[span_249](start_span)[span_249](end_span)

    while tick() - tInicio < 4 and loopBusAvancadoAtivo do --[span_250](start_span)[span_250](end_span)
        for _, obj in ipairs(workspace:GetDescendants()) do --[span_251](start_span)[span_251](end_span)
            if obj:IsA("Model") then --[span_252](start_span)[span_252](end_span)
                local nomeUpper = obj.Name:upper() --[span_253](start_span)[span_253](end_span)
                if nomeUpper:find(alvoUpper, 1, true)
                    or nomeUpper:find("BUS", 1, true)
                    or nomeUpper:find("SCHOOL", 1, true)
                    or nomeUpper:find(playerUpper, 1, true)
                then
                    local seat = obj:FindFirstChildOfClass("VehicleSeat") or obj:FindFirstChild("VehicleSeat", true) --[span_254](start_span)[span_254](end_span)
                    if seat and seat.Position.Y > -50 then --[span_255](start_span)[span_255](end_span)
                        ultimoModelo = obj --[span_256](start_span)[span_256](end_span)
                        ultimoSeat = seat --[span_257](start_span)[span_257](end_span)
                    end
                end
            end
        end
        if ultimoModelo and ultimoSeat then --[span_258](start_span)[span_258](end_span)
            return ultimoModelo, ultimoSeat --[span_259](start_span)[span_259](end_span)
        end
        task.wait(0.2) --[span_260](start_span)[span_260](end_span)
    end
    return nil, nil --[span_261](start_span)[span_261](end_span)
end

local function executarCicloBusEmAlvo(alvo, nomeVeiculo) --[span_262](start_span)[span_262](end_span)
    if not alvo or alvo == LocalPlayer or not alvo.Character or not loopBusAvancadoAtivo then return end --[span_263](start_span)[span_263](end_span)

    local RE = ReplicatedStorage:FindFirstChild("RE") --[span_264](start_span)[span_264](end_span)
    local CarRemote = RE and RE:FindFirstChild("1Ca1r") --[span_265](start_span)[span_265](end_span)
    if not CarRemote then return end --[span_266](start_span)[span_266](end_span)

    local rootAlvo = alvo.Character:FindFirstChild("HumanoidRootPart") --[span_267](start_span)[span_267](end_span)
    local humanoidAlvo = alvo.Character:FindFirstChildOfClass("Humanoid") --[span_268](start_span)[span_268](end_span)
    if not rootAlvo or not humanoidAlvo or humanoidAlvo.Health <= 0 then return end --[span_269](start_span)[span_269](end_span)

    CarRemote:FireServer("PickingCar", nomeVeiculo) --[span_270](start_span)[span_270](end_span)
    local onibus, seatMotorista = buscarVeiculoGerado(nomeVeiculo) --[span_271](start_span)[span_271](end_span)
    veiculoLoopAtual = onibus

    local myChar = LocalPlayer.Character --[span_272](start_span)[span_272](end_span)
    local myHum = myChar and myChar:FindFirstChildOfClass("Humanoid") --[span_273](start_span)[span_273](end_span)

    if not onibus or not seatMotorista or not myHum then --[span_274](start_span)[span_274](end_span)
        destruirVeiculoLoopAtual()
        return
    end

    pcall(function() seatMotorista:Sit(myHum) end) --[span_275](start_span)[span_275](end_span)
    task.wait(0.1) --[span_276](start_span)[span_276](end_span)

    local concluido = false --[span_277](start_span)[span_277](end_span)
    local conexaoRender --[span_278](start_span)[span_278](end_span)
    conexaoRender = RunService.RenderStepped:Connect(function() --[span_279](start_span)[span_279](end_span)
        if not concluido and loopBusAvancadoAtivo and rootAlvo and rootAlvo.Parent and onibus and onibus.Parent then --[span_280](start_span)[span_280](end_span)
            local tempo = tick() * 25 --[span_281](start_span)[span_281](end_span)
            local rotX = math.rad(tempo * 50 % 360) --[span_282](start_span)[span_282](end_span)
            local rotY = math.rad(tempo * 80 % 360) --[span_283](start_span)[span_283](end_span)
            local rotZ = math.rad(tempo * 30 % 360) --[span_284](start_span)[span_284](end_span)
            onibus:PivotTo(rootAlvo.CFrame * CFrame.Angles(rotX, rotY, rotZ)) --[span_285](start_span)[span_285](end_span)
        else
            if conexaoRender then conexaoRender:Disconnect() end --[span_286](start_span)[span_286](end_span)
        end
    end)

    local conexaoSentouBus --[span_287](start_span)[span_287](end_span)
    conexaoSentouBus = humanoidAlvo.Seated:Connect(function(isSeated, seat) --[span_288](start_span)[span_288](end_span)
        if isSeated and seat and seat:IsDescendantOf(onibus) then --[span_289](start_span)[span_289](end_span)
            concluido = true --[span_290](start_span)[span_290](end_span)
            if conexaoRender then conexaoRender:Disconnect() end --[span_291](start_span)[span_291](end_span)
            if rootAlvo and rootAlvo.Parent and onibus and onibus.Parent then --[span_292](start_span)[span_292](end_span)
                onibus:PivotTo(CFrame.new(rootAlvo.Position.X, -300, rootAlvo.Position.Z)) --[span_293](start_span)[span_293](end_span)
            end
            task.wait(0.15) --[span_294](start_span)[span_294](end_span)
            pcall(function()
                if myHum then myHum.Sit = false end
            end)
            destruirVeiculoLoopAtual()
            if conexaoSentouBus then conexaoSentouBus:Disconnect() end --[span_295](start_span)[span_295](end_span)
        end
    end)

    local tInicio = tick() --[span_296](start_span)[span_296](end_span)
    while not concluido and loopBusAvancadoAtivo and (tick() - tInicio < 12) do --[span_297](start_span)[span_297](end_span)
        if not alvo.Parent or not alvo.Character or not alvo.Character:FindFirstChild("HumanoidRootPart") then --[span_298](start_span)[span_298](end_span)
            break --[span_299](start_span)[span_299](end_span)
        end
        task.wait(0.1) --[span_300](start_span)[span_300](end_span)
    end

    concluido = true --[span_301](start_span)[span_301](end_span)
    if conexaoRender then conexaoRender:Disconnect() end --[span_302](start_span)[span_302](end_span)
    if conexaoSentouBus then conexaoSentouBus:Disconnect() end --[span_303](start_span)[span_303](end_span)
    destruirVeiculoLoopAtual()
end

UI.Toggle(Tabs.Troll, { --[span_304](start_span)[span_304](end_span)
    Name = "Executar Loop Veículo / Bus", --[span_305](start_span)[span_305](end_span)
    Description = "Deleta após matar o alvo; no all faz loop até desligar o toggle", --[span_306](start_span)[span_306](end_span)
    CurrentValue = false, --[span_307](start_span)[span_307](end_span)
    Callback = function(ativo) --[span_308](start_span)[span_308](end_span)
        loopBusAvancadoAtivo = ativo --[span_309](start_span)[span_309](end_span)
        if not ativo then --[span_310](start_span)[span_310](end_span)
            pcall(function() --[span_311](start_span)[span_311](end_span)
                local myHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") --[span_312](start_span)[span_312](end_span)
                if myHum then myHum.Sit = false end --[span_313](start_span)[span_313](end_span)
            end)
            destruirVeiculoLoopAtual()
            Notify("Bus Loop", "Loop desligado e veículo destruído.", 2) --[span_314](start_span)[span_314](end_span)
            return --[span_315](start_span)[span_315](end_span)
        end

        Notify("Bus Loop", "Iniciando loop (" .. veiculoBusSelecionado .. " | " .. modoAlvoBus .. ")...", 2) --[span_316](start_span)[span_316](end_span)

        task.spawn(function() --[span_317](start_span)[span_317](end_span)
            while loopBusAvancadoAtivo do --[span_318](start_span)[span_318](end_span)
                local alvos = obterAlvosBusSemVoce() --[span_319](start_span)[span_319](end_span)
                if #alvos == 0 then --[span_320](start_span)[span_320](end_span)
                    task.wait(0.3) --[span_321](start_span)[span_321](end_span)
                    continue --[span_322](start_span)[span_322](end_span)
                end

                for _, alvo in ipairs(alvos) do --[span_323](start_span)[span_323](end_span)
                    if not loopBusAvancadoAtivo then break end --[span_324](start_span)[span_324](end_span)
                    executarCicloBusEmAlvo(alvo, veiculoBusSelecionado) --[span_325](start_span)[span_325](end_span)
                    task.wait(0.2) --[span_326](start_span)[span_326](end_span)
                end

                if modoAlvoBus ~= "all" then
                    task.wait(0.2)
                end
            end
            destruirVeiculoLoopAtual()
        end)
    end
})
--[[
-- PROPS --[span_327](start_span)[span_327](end_span)
local PROP_KILL_Y      = -300 --[span_328](start_span)[span_328](end_span)
local PROP_MOVE_SPEED  = 6 --[span_329](start_span)[span_329](end_span)
local PROP_MOVE_RANGE  = 3 --[span_330](start_span)[span_330](end_span)
local TEMPO_MAX_SIT    = 10 --[span_331](start_span)[span_331](end_span)
local PROP_TIPO        = "FurnitureBleachers" --[span_332](start_span)[span_332](end_span)
local PROP_CATEGORIA   = "Furniture" --[span_333](start_span)[span_333](end_span)
local alvoPropSelecionado = LocalPlayer.Name --[span_334](start_span)[span_334](end_span)

local function obterListaProp() --[span_335](start_span)[span_335](end_span)
    local lista = {} --[span_336](start_span)[span_336](end_span)
    for _, p in ipairs(Players:GetPlayers()) do table.insert(lista, p.Name) end --[span_337](start_span)[span_337](end_span)
    if #lista == 0 then table.insert(lista, LocalPlayer.Name) end --[span_338](start_span)[span_338](end_span)
    return lista --[span_339](start_span)[span_339](end_span)
end
UI.InfoBlock(Tabs.Troll, { --[span_340](start_span)[span_340](end_span)
Title = "Prop Kill | Bring", --[span_341](start_span)[span_341](end_span)
Description = "Mata ou traz o alvo selecionado até vc.", --[span_342](start_span)[span_342](end_span)
Icon = "14436167217" --[span_343](start_span)[span_343](end_span)
})
local dropdownProp = UI.Dropdown(Tabs.Troll, { --[span_344](start_span)[span_344](end_span)
    Name = "Alvo (Props)", --[span_345](start_span)[span_345](end_span)
    Options = obterListaProp(), --[span_346](start_span)[span_346](end_span)
    CurrentOption = {LocalPlayer.Name}, --[span_347](start_span)[span_347](end_span)
    Callback = function(opt) if opt and opt[1] then alvoPropSelecionado = opt[1] end end --[span_348](start_span)[span_348](end_span)
})

UI.Button(Tabs.Troll, { --[span_349](start_span)[span_349](end_span)
    Name = "Atualizar Lista (Props)", --[span_350](start_span)[span_350](end_span)
    Description = "Atualiza a lista de jogadores", --[span_351](start_span)[span_351](end_span)
    Callback = function() --[span_352](start_span)[span_352](end_span)
        local novaLista = obterListaProp() --[span_353](start_span)[span_353](end_span)
        dropdownProp:Refresh(novaLista) --[span_354](start_span)[span_354](end_span)
        Notify("Props", "Lista atualizada!", 2) --[span_355](start_span)[span_355](end_span)
    end,
})

local function pegarPropMaker() --[span_356](start_span)[span_356](end_span)
    local RE = ReplicatedStorage:FindFirstChild("RE") --[span_357](start_span)[span_357](end_span)
    if not RE then return nil end --[span_358](start_span)[span_358](end_span)
    local char = LocalPlayer.Character --[span_359](start_span)[span_359](end_span)
    local hum = char and char:FindFirstChild("Humanoid") --[span_360](start_span)[span_360](end_span)
    if not char or not hum then return nil end --[span_361](start_span)[span_361](end_span)
    local propMaker = char:FindFirstChild("PropMaker") --[span_362](start_span)[span_362](end_span)
    if propMaker then return propMaker end --[span_363](start_span)[span_363](end_span)
    local backpack = LocalPlayer:FindFirstChild("Backpack") --[span_364](start_span)[span_364](end_span)
    propMaker = backpack and backpack:FindFirstChild("PropMaker") --[span_365](start_span)[span_365](end_span)
    if not propMaker then --[span_366](start_span)[span_366](end_span)
        local toolRemote = RE:FindFirstChild("1Too1l") --[span_367](start_span)[span_367](end_span)
        if toolRemote then pcall(function() toolRemote:InvokeServer("PickingTools", "PropMaker") end) end --[span_368](start_span)[span_368](end_span)
        task.wait(0.4) --[span_369](start_span)[span_369](end_span)
        propMaker = char:FindFirstChild("PropMaker") or (backpack and backpack:FindFirstChild("PropMaker")) --[span_370](start_span)[span_370](end_span)
    end
    if propMaker and propMaker.Parent ~= char then --[span_371](start_span)[span_371](end_span)
        pcall(function() hum:EquipTool(propMaker) end) --[span_372](start_span)[span_372](end_span)
        task.wait(0.3) --[span_373](start_span)[span_373](end_span)
    end
    return char:FindFirstChild("PropMaker") --[span_374](start_span)[span_374](end_span)
end

local function selecionarProp(nome, categoria) --[span_375](start_span)[span_375](end_span)
    local RE = ReplicatedStorage:FindFirstChild("RE") --[span_376](start_span)[span_376](end_span)
    if not RE then return end --[span_377](start_span)[span_377](end_span)
    local clearRemote = RE:FindFirstChild("1Clea1rTool1s") --[span_378](start_span)[span_378](end_span)
    if not clearRemote then return end --[span_379](start_span)[span_379](end_span)
    task.wait(0.2) --[span_380](start_span)[span_380](end_span)
    pcall(function() clearRemote:FireServer("OpenPropMenu") end) --[span_381](start_span)[span_381](end_span)
    task.wait(0.3) --[span_382](start_span)[span_382](end_span)
    pcall(function() clearRemote:FireServer("RequestingPropName", nome or PROP_TIPO, categoria or PROP_CATEGORIA) end) --[span_383](start_span)[span_383](end_span)
    task.wait(0.3) --[span_384](start_span)[span_384](end_span)
end

local function spawnarProp(posicao) --[span_385](start_span)[span_385](end_span)
    local char = LocalPlayer.Character --[span_386](start_span)[span_386](end_span)
    if not char then return false end --[span_387](start_span)[span_387](end_span)
    local propMaker = char:FindFirstChild("PropMaker") --[span_388](start_span)[span_388](end_span)
    if not propMaker then return false end --[span_389](start_span)[span_389](end_span)
    local toolProp = propMaker:FindFirstChild("Tool_PropMake") or propMaker:FindFirstChildOfClass("RemoteEvent") --[span_390](start_span)[span_390](end_span)
    local chao = Workspace:FindFirstChild("Model") --[span_391](start_span)[span_391](end_span)
        and Workspace.Model:FindFirstChild("Street") --[span_392](start_span)[span_392](end_span)
        and Workspace.Model.Street:FindFirstChild("Street") --[span_393](start_span)[span_393](end_span)
        or Workspace --[span_394](start_span)[span_394](end_span)
    if toolProp then pcall(function() toolProp:FireServer(chao, posicao) end) end --[span_395](start_span)[span_395](end_span)
    pcall(function() --[span_396](start_span)[span_396](end_span)
        local camera = Workspace.CurrentCamera --[span_397](start_span)[span_397](end_span)
        local posTela, naTela = camera:WorldToViewportPoint(posicao) --[span_398](start_span)[span_398](end_span)
        if naTela then --[span_399](start_span)[span_399](end_span)
            local vu = game:GetService("VirtualUser") --[span_400](start_span)[span_400](end_span)
            vu:CaptureController() --[span_401](start_span)[span_401](end_span)
            vu:ClickButton1(Vector2.new(posTela.X, posTela.Y)) --[span_402](start_span)[span_402](end_span)
        end
    end)
    return true --[span_403](start_span)[span_403](end_span)
end

local function encontrarMeusProps() --[span_404](start_span)[span_404](end_span)
    local WorkspaceCom = Workspace:FindFirstChild("WorkspaceCom") --[span_405](start_span)[span_405](end_span)
    if not WorkspaceCom then return {} end --[span_406](start_span)[span_406](end_span)
    local props = {} --[span_407](start_span)[span_407](end_span)
    local meuNome = LocalPlayer.Name --[span_408](start_span)[span_408](end_span)
    for _, container in ipairs(WorkspaceCom:GetChildren()) do --[span_409](start_span)[span_409](end_span)
        for _, prop in ipairs(container:GetChildren()) do --[span_410](start_span)[span_410](end_span)
            if prop.Name:find(meuNome, 1, true) then --[span_411](start_span)[span_411](end_span)
                if prop:FindFirstChild("SetCurrentCFrame") or prop:IsA("Model") then --[span_412](start_span)[span_412](end_span)
                    table.insert(props, prop) --[span_413](start_span)[span_413](end_span)
                end
            end
        end
    end
    return props --[span_414](start_span)[span_414](end_span)
end

local function moverProp(prop, cf) --[span_415](start_span)[span_415](end_span)
    if not prop or not prop.Parent then return end --[span_416](start_span)[span_416](end_span)
    local remote = prop:FindFirstChild("SetCurrentCFrame") --[span_417](start_span)[span_417](end_span)
    if remote then pcall(function() remote:InvokeServer(cf) end) --[span_418](start_span)[span_418](end_span)
    elseif prop:IsA("Model") then pcall(function() prop:PivotTo(cf) end) end --[span_419](start_span)[span_419](end_span)
end

local function deletarTodosProps() --[span_420](start_span)[span_420](end_span)
    local RE = ReplicatedStorage:FindFirstChild("RE") --[span_421](start_span)[span_421](end_span)
    if not RE then return end --[span_422](start_span)[span_422](end_span)
    local clearRemote = RE:FindFirstChild("1Clea1rTool1s") --[span_423](start_span)[span_423](end_span)
    if clearRemote then pcall(function() clearRemote:FireServer("ClearAllProps") end) end --[span_424](start_span)[span_424](end_span)
end

local function executarKillProp(nomeAlvo) --[span_425](start_span)[span_425](end_span)
    local alvo = Players:FindFirstChild(nomeAlvo) --[span_426](start_span)[span_426](end_span)
    if not alvo or not alvo.Character then return false end --[span_427](start_span)[span_427](end_span)
    local hum = alvo.Character:FindFirstChildOfClass("Humanoid") --[span_428](start_span)[span_428](end_span)
    local hrp = alvo.Character:FindFirstChild("HumanoidRootPart") --[span_429](start_span)[span_429](end_span)
    if not hum or not hrp then return false end --[span_430](start_span)[span_430](end_span)
    local antes = #encontrarMeusProps() --[span_431](start_span)[span_431](end_span)
    spawnarProp(hrp.Position) --[span_432](start_span)[span_432](end_span)
    task.wait(0.5) --[span_433](start_span)[span_433](end_span)
    local agora = encontrarMeusProps() --[span_434](start_span)[span_434](end_span)
    local prop = agora[#agora] --[span_435](start_span)[span_435](end_span)
    if not prop then --[span_436](start_span)[span_436](end_span)
        Notify("Props", "Clique 1x no chão para liberar o prop", 3) --[span_437](start_span)[span_437](end_span)
        local t0 = tick() --[span_438](start_span)[span_438](end_span)
        while tick() - t0 < 6 do --[span_439](start_span)[span_439](end_span)
            task.wait(0.3) --[span_440](start_span)[span_440](end_span)
            agora = encontrarMeusProps() --[span_441](start_span)[span_441](end_span)
            if #agora > antes then prop = agora[#agora]; break end --[span_442](start_span)[span_442](end_span)
        end
    end
    if not prop then Notify("Props", "Prop não foi criado.", 2); return false end --[span_443](start_span)[span_443](end_span)
    local sentou = false --[span_444](start_span)[span_444](end_span)
    local tInicio = tick() --[span_445](start_span)[span_445](end_span)
    local conexao --[span_446](start_span)[span_446](end_span)
    conexao = RunService.Heartbeat:Connect(function() --[span_447](start_span)[span_447](end_span)
        if sentou or (tick() - tInicio > TEMPO_MAX_SIT) then --[span_448](start_span)[span_448](end_span)
            if conexao then conexao:Disconnect() end --[span_449](start_span)[span_449](end_span)
            return --[span_450](start_span)[span_450](end_span)
        end
        if not alvo.Character or not alvo.Character:FindFirstChild("HumanoidRootPart") then return end --[span_451](start_span)[span_451](end_span)
        local hrpAtual = alvo.Character.HumanoidRootPart --[span_452](start_span)[span_452](end_span)
        local t = tick() * PROP_MOVE_SPEED --[span_453](start_span)[span_453](end_span)
        local offsetY = math.sin(t) * PROP_MOVE_RANGE --[span_454](start_span)[span_454](end_span)
        local posPerseguicao = hrpAtual.Position + Vector3.new(0, offsetY, 0) --[span_455](start_span)[span_455](end_span)
        moverProp(prop, CFrame.new(posPerseguicao)) --[span_456](start_span)[span_456](end_span)
        if hum.Sit then --[span_457](start_span)[span_457](end_span)
            sentou = true --[span_458](start_span)[span_458](end_span)
            if conexao then conexao:Disconnect() end --[span_459](start_span)[span_459](end_span)
            task.wait(0.1) --[span_460](start_span)[span_460](end_span)
            moverProp(prop, CFrame.new(hrpAtual.Position.X, PROP_KILL_Y, hrpAtual.Position.Z)) --[span_461](start_span)[span_461](end_span)
            task.wait(0.8) --[span_462](start_span)[span_462](end_span)
            deletarTodosProps() --[span_463](start_span)[span_463](end_span)
        end
    end)
    return true --[span_464](start_span)[span_464](end_span)
end

local function executarBringProp(nomeAlvo) --[span_465](start_span)[span_465](end_span)
    local alvo = Players:FindFirstChild(nomeAlvo) --[span_466](start_span)[span_466](end_span)
    if not alvo or not alvo.Character then return false end --[span_467](start_span)[span_467](end_span)
    local hum = alvo.Character:FindFirstChildOfClass("Humanoid") --[span_468](start_span)[span_468](end_span)
    local hrp = alvo.Character:FindFirstChild("HumanoidRootPart") --[span_469](start_span)[span_469](end_span)
    local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") --[span_470](start_span)[span_470](end_span)
    if not hum or not hrp or not meuHrp then return false end --[span_471](start_span)[span_471](end_span)
    local antes = #encontrarMeusProps() --[span_472](start_span)[span_472](end_span)
    spawnarProp(meuHrp.Position + (meuHrp.CFrame.LookVector * 4)) --[span_473](start_span)[span_473](end_span)
    task.wait(0.5) --[span_474](start_span)[span_474](end_span)
    local agora = encontrarMeusProps() --[span_475](start_span)[span_475](end_span)
    local prop = agora[#agora] --[span_476](start_span)[span_476](end_span)
    if not prop then --[span_477](start_span)[span_477](end_span)
        Notify("Props", "Clique 1x no chão para liberar o Prop", 3) --[span_478](start_span)[span_478](end_span)
        local t0 = tick() --[span_479](start_span)[span_479](end_span)
        while tick() - t0 < 6 do --[span_480](start_span)[span_480](end_span)
            task.wait(0.3) --[span_481](start_span)[span_481](end_span)
            agora = encontrarMeusProps() --[span_482](start_span)[span_482](end_span)
            if #agora > antes then prop = agora[#agora]; break end --[span_483](start_span)[span_483](end_span)
        end
    end
    if not prop then Notify("Props", "Prop não foi criado.", 2); return false end --[span_484](start_span)[span_484](end_span)
    local sentou = false --[span_485](start_span)[span_485](end_span)
    local tInicio = tick() --[span_486](start_span)[span_486](end_span)
    local conexao --[span_487](start_span)[span_487](end_span)
    conexao = RunService.Heartbeat:Connect(function() --[span_488](start_span)[span_488](end_span)
        if sentou or (tick() - tInicio > TEMPO_MAX_SIT) then --[span_489](start_span)[span_489](end_span)
            if conexao then conexao:Disconnect() end --[span_490](start_span)[span_490](end_span)
            return --[span_491](start_span)[span_491](end_span)
        end
        if not alvo.Character or not alvo.Character:FindFirstChild("HumanoidRootPart") then return end --[span_492](start_span)[span_492](end_span)
        local hrpAtual = alvo.Character.HumanoidRootPart --[span_493](start_span)[span_493](end_span)
        local t = tick() * PROP_MOVE_SPEED --[span_494](start_span)[span_494](end_span)
        local offsetY = math.sin(t) * PROP_MOVE_RANGE --[span_495](start_span)[span_495](end_span)
        moverProp(prop, CFrame.new(hrpAtual.Position + Vector3.new(0, offsetY, 0))) --[span_496](start_span)[span_496](end_span)
        if hum.Sit then --[span_497](start_span)[span_497](end_span)
            sentou = true --[span_498](start_span)[span_498](end_span)
            if conexao then conexao:Disconnect() end --[span_499](start_span)[span_499](end_span)
            task.wait(0.1) --[span_500](start_span)[span_500](end_span)
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then --[span_501](start_span)[span_501](end_span)
                moverProp(prop, LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(2, 0, 0)) --[span_502](start_span)[span_502](end_span)
            end
            task.wait(0.8) --[span_503](start_span)[span_503](end_span)
            deletarTodosProps() --[span_504](start_span)[span_504](end_span)
        end
    end)
    return true --[span_505](start_span)[span_505](end_span)
end

UI.Button(Tabs.Troll, { --[span_506](start_span)[span_506](end_span)
    Name = "Kill Prop", --[span_507](start_span)[span_507](end_span)
    Description = "TP prop: Void", --[span_508](start_span)[span_508](end_span)
    Callback = function() --[span_509](start_span)[span_509](end_span)
        if not alvoPropSelecionado then Notify("Props", "Selecione um alvo", 2); return end --[span_510](start_span)[span_510](end_span)
        if not pegarPropMaker() then Notify("Props", "Falha ao equipar 'caixa de props'.", 2); return end --[span_511](start_span)[span_511](end_span)
        selecionarProp() --[span_512](start_span)[span_512](end_span)
        Notify("Props", "Iniciando Kill Prop...", 2) --[span_513](start_span)[span_513](end_span)
        task.spawn(function() executarKillProp(alvoPropSelecionado) end) --[span_514](start_span)[span_514](end_span)
    end,
})

UI.Button(Tabs.Troll, { --[span_515](start_span)[span_515](end_span)
    Name = "Bring Prop (Trazer Alvo)", --[span_516](start_span)[span_516](end_span)
    Description = "Traz o player selecionado até vc", --[span_517](start_span)[span_517](end_span)
    Callback = function() --[span_518](start_span)[span_518](end_span)
        if not alvoPropSelecionado then Notify("Props", "Selecione um alvo", 2); return end --[span_519](start_span)[span_519](end_span)
        if not pegarPropMaker() then Notify("Props", "Falha ao equipar 'caixa de props'", 2); return end --[span_520](start_span)[span_520](end_span)
        selecionarProp() --[span_521](start_span)[span_521](end_span)
        Notify("Props", "Iniciando Bring Prop...", 2) --[span_522](start_span)[span_522](end_span)
        task.spawn(function() executarBringProp(alvoPropSelecionado) end) --[span_523](start_span)[span_523](end_span)
    end,
})

UI.Button(Tabs.Troll, { --[span_524](start_span)[span_524](end_span)
    Name = "Limpar TODOS os Props", --[span_525](start_span)[span_525](end_span)
    Description = "Apaga todos os props do mapa", --[span_526](start_span)[span_526](end_span)
    Callback = function() deletarTodosProps(); Notify("Props", "Props deletados", 2) end, --[span_527](start_span)[span_527](end_span)
})
--[[
--------------------------------------------------------------------------------
-- PAINEL DE PROPS AVANÇADOS (MOVIMENTO RÁPIDO / VOID RÁPIDO / SEM AUTO-DELETE) --[span_528](start_span)[span_528](end_span)
--------------------------------------------------------------------------------
UI.InfoBlock(Tabs.Troll, { --[span_529](start_span)[span_529](end_span)
    Title = "🚽🪑 Props Avançados (Lote de 20)", --[span_530](start_span)[span_530](end_span)
    Description = "Sobe e desce rápido no alvo até sentar (Kill/Bring), até 20 no all, sem auto-delete.", --[span_531](start_span)[span_531](end_span)
    Icon = "14436167217" --[span_532](start_span)[span_532](end_span)
})

-- ============================================================================
-- SELEÇÃO DE PLAYER (SEPARADA DAS OUTRAS LISTAS) --[span_533](start_span)[span_533](end_span)
-- ============================================================================
local function obterPlayersPropsAvancado() --[span_534](start_span)[span_534](end_span)
    local lista = {} --[span_535](start_span)[span_535](end_span)
    for _, p in ipairs(Players:GetPlayers()) do --[span_536](start_span)[span_536](end_span)
        if p ~= LocalPlayer then --[span_537](start_span)[span_537](end_span)
            table.insert(lista, p.Name) --[span_538](start_span)[span_538](end_span)
        end
    end
    if #lista == 0 then --[span_539](start_span)[span_539](end_span)
        table.insert(lista, "Nenhum player") --[span_540](start_span)[span_540](end_span)
    end
    return lista --[span_541](start_span)[span_541](end_span)
end

local listaInicialAvancado = obterPlayersPropsAvancado() --[span_542](start_span)[span_542](end_span)
if listaInicialAvancado[1] ~= "Nenhum player" then --[span_543](start_span)[span_543](end_span)
    alvoPropSelecionado = listaInicialAvancado[1] --[span_544](start_span)[span_544](end_span)
end

local dropdownPlayerAvancado = UI.Dropdown(Tabs.Troll, { --[span_545](start_span)[span_545](end_span)
    Name = "👤 Player Alvo (Modo player)", --[span_546](start_span)[span_546](end_span)
    Options = listaInicialAvancado, --[span_547](start_span)[span_547](end_span)
    CurrentOption = { listaInicialAvancado[1] }, --[span_548](start_span)[span_548](end_span)
    Callback = function(opt) --[span_549](start_span)[span_549](end_span)
        if opt and opt[1] and opt[1] ~= "Nenhum player" then --[span_550](start_span)[span_550](end_span)
            alvoPropSelecionado = opt[1] --[span_551](start_span)[span_551](end_span)
            Notify("Props", "Alvo definido: " .. alvoPropSelecionado, 2) --[span_552](start_span)[span_552](end_span)
        end
    end
})

UI.Button(Tabs.Troll, { --[span_553](start_span)[span_553](end_span)
    Name = "🔄 Atualizar Lista de Players", --[span_554](start_span)[span_554](end_span)
    Description = "Atualiza os jogadores disponíveis para o modo player", --[span_555](start_span)[span_555](end_span)
    Callback = function() --[span_556](start_span)[span_556](end_span)
        local novaLista = obterPlayersPropsAvancado() --[span_557](start_span)[span_557](end_span)
        dropdownPlayerAvancado:Refresh(novaLista) --[span_558](start_span)[span_558](end_span)
        if novaLista[1] ~= "Nenhum player" then --[span_559](start_span)[span_559](end_span)
            alvoPropSelecionado = novaLista[1] --[span_560](start_span)[span_560](end_span)
        end
        Notify("Props", "Lista de players atualizada!", 2) --[span_561](start_span)[span_561](end_span)
    end
})

-- Separador visual entre a lista de players e as configurações do prop --[span_562](start_span)[span_562](end_span)
if UI.Section then --[span_563](start_span)[span_563](end_span)
    UI.Section(Tabs.Troll, "⚙️ Configurações do Prop") --[span_564](start_span)[span_564](end_span)
else
    UI.InfoBlock(Tabs.Troll, { --[span_565](start_span)[span_565](end_span)
        Title = "⚙️ Configurações do Prop", --[span_566](start_span)[span_566](end_span)
        Description = "Escolha o equipamento, a função e o modo (all ou player).", --[span_567](start_span)[span_567](end_span)
        Icon = "14436167217" --[span_568](start_span)[span_568](end_span)
    })
end

-- ============================================================================
-- LÓGICA E CONFIGURAÇÕES DO PROP --[span_569](start_span)[span_569](end_span)
-- ============================================================================
local TOTAL_PROPS_ALL = 20 --[span_570](start_span)[span_570](end_span)
local VELOCIDADE_SUBIDA_DESCIDA = 26 --[span_571](start_span)[span_571](end_span)
local AMPLITUDE_SUBIDA_DESCIDA = 3.5 --[span_572](start_span)[span_572](end_span)
local TEMPO_MAX_ALVO_RAPIDO = 1.6 --[span_573](start_span)[span_573](end_span)

local CONFIG_PROPS_AVANCADO = { --[span_574](start_span)[span_574](end_span)
    Bancada = { nome = "FurnitureBleachers", categoria = "Furniture" }, --[span_575](start_span)[span_575](end_span)
    Privada = { nome = "Toilet", categoria = "Furniture" } --[span_576](start_span)[span_576](end_span)
}

local equipamentoSelecionado = "Privada" --[span_577](start_span)[span_577](end_span)
local funcaoPropSelecionada    = "Kill All" --[span_578](start_span)[span_578](end_span)
local modoAlvoProp           = "all" -- "all" ou "player" --[span_579](start_span)[span_579](end_span)
local propAvancadoAtivo      = false --[span_580](start_span)[span_580](end_span)

local function selecionarEquipamentoProp(chave) --[span_581](start_span)[span_581](end_span)
    local info = CONFIG_PROPS_AVANCADO[chave] or CONFIG_PROPS_AVANCADO.Bancada --[span_582](start_span)[span_582](end_span)
    local RE = ReplicatedStorage:FindFirstChild("RE") --[span_583](start_span)[span_583](end_span)
    local clearRemote = RE and RE:FindFirstChild("1Clea1rTool1s") --[span_584](start_span)[span_584](end_span)
    if not clearRemote then return end --[span_585](start_span)[span_585](end_span)
    pcall(function() clearRemote:FireServer("OpenPropMenu") end) --[span_586](start_span)[span_586](end_span)
    task.wait(0.15) --[span_587](start_span)[span_587](end_span)
    pcall(function() clearRemote:FireServer("RequestingPropName", info.nome, info.categoria) end) --[span_588](start_span)[span_588](end_span)
    task.wait(0.2) --[span_589](start_span)[span_589](end_span)
end

local function obterChaoParaSpawn(posicaoBase) --[span_590](start_span)[span_590](end_span)
    local params = RaycastParams.new() --[span_591](start_span)[span_591](end_span)
    params.FilterType = Enum.RaycastFilterType.Exclude --[span_592](start_span)[span_592](end_span)
    local ignorar = {} --[span_593](start_span)[span_593](end_span)
    if LocalPlayer.Character then table.insert(ignorar, LocalPlayer.Character) end --[span_594](start_span)[span_594](end_span)
    params.FilterDescendantsInstances = ignorar --[span_595](start_span)[span_595](end_span)

    local resultado = Workspace:Raycast(posicaoBase + Vector3.new(0, 10, 0), Vector3.new(0, -50, 0), params) --[span_596](start_span)[span_596](end_span)
    if resultado and resultado.Instance then --[span_597](start_span)[span_597](end_span)
        return resultado.Instance, resultado.Position --[span_598](start_span)[span_598](end_span)
    end

    local fallback = (Workspace:FindFirstChild("POI_Hospital") and Workspace.POI_Hospital:FindFirstChild("Parking_Lot")) --[span_599](start_span)[span_599](end_span)
        or Workspace:FindFirstChildWhichIsA("BasePart", true) --[span_600](start_span)[span_600](end_span)
    return fallback, posicaoBase --[span_601](start_span)[span_601](end_span)
end

local function coletarPropsDisponiveis(limite) --[span_602](start_span)[span_602](end_span)
    local encontrados = encontrarMeusProps() --[span_603](start_span)[span_603](end_span)
    local validos = {} --[span_604](start_span)[span_604](end_span)
    local vistos = {} --[span_605](start_span)[span_605](end_span)

    for _, p in ipairs(encontrados) do --[span_606](start_span)[span_606](end_span)
        if p and p.Parent and not vistos[p] then --[span_607](start_span)[span_607](end_span)
            vistos[p] = true --[span_608](start_span)[span_608](end_span)
            table.insert(validos, p) --[span_609](start_span)[span_609](end_span)
            if limite and #validos >= limite then --[span_610](start_span)[span_610](end_span)
                return validos --[span_611](start_span)[span_611](end_span)
            end
        end
    end

    local WorkspaceCom = Workspace:FindFirstChild("WorkspaceCom") --[span_612](start_span)[span_612](end_span)
    if WorkspaceCom then --[span_613](start_span)[span_613](end_span)
        for _, container in ipairs(WorkspaceCom:GetChildren()) do --[span_614](start_span)[span_614](end_span)
            for _, prop in ipairs(container:GetChildren()) do --[span_615](start_span)[span_615](end_span)
                if prop and prop.Parent and not vistos[prop] then --[span_616](start_span)[span_616](end_span)
                    if prop:FindFirstChild("SetCurrentCFrame") then --[span_617](start_span)[span_617](end_span)
                        vistos[prop] = true --[span_618](start_span)[span_618](end_span)
                        table.insert(validos, prop) --[span_619](start_span)[span_619](end_span)
                        if limite and #validos >= limite then --[span_620](start_span)[span_620](end_span)
                            return validos --[span_621](start_span)[span_621](end_span)
                        end
                    end
                end
            end
        end
    end

    return validos --[span_622](start_span)[span_622](end_span)
end

local function calcularPosicaoEspacada(posBase, indice, total) --[span_623](start_span)[span_623](end_span)
    local raioBase = 14 + ((indice - 1) % 3) * 5 --[span_624](start_span)[span_624](end_span)
    local angulo = ((indice - 1) / math.max(total, 1)) * math.pi * 2 + (indice * 0.45) --[span_625](start_span)[span_625](end_span)
    local offsetX = math.cos(angulo) * raioBase --[span_626](start_span)[span_626](end_span)
    local offsetZ = math.sin(angulo) * raioBase --[span_627](start_span)[span_627](end_span)
    return posBase + Vector3.new(offsetX, 0, offsetZ) --[span_628](start_span)[span_628](end_span)
end

local function obterAlvosSemVoce() --[span_629](start_span)[span_629](end_span)
    local lista = {} --[span_630](start_span)[span_630](end_span)
    local modoEfetivo = modoAlvoProp --[span_631](start_span)[span_631](end_span)
    if funcaoPropSelecionada:find("All") then --[span_632](start_span)[span_632](end_span)
        modoEfetivo = "all" --[span_633](start_span)[span_633](end_span)
    elseif funcaoPropSelecionada:find("(Player)", 1, true) then --[span_634](start_span)[span_634](end_span)
        modoEfetivo = "player" --[span_635](start_span)[span_635](end_span)
    end

    if modoEfetivo == "all" then --[span_636](start_span)[span_636](end_span)
        for _, p in ipairs(Players:GetPlayers()) do --[span_637](start_span)[span_637](end_span)
            if p ~= LocalPlayer and p.Character then --[span_638](start_span)[span_638](end_span)
                local hum = p.Character:FindFirstChildOfClass("Humanoid") --[span_639](start_span)[span_639](end_span)
                local hrp = p.Character:FindFirstChild("HumanoidRootPart") --[span_640](start_span)[span_640](end_span)
                if hum and hrp and hum.Health > 0 then --[span_641](start_span)[span_641](end_span)
                    table.insert(lista, p) --[span_642](start_span)[span_642](end_span)
                end
            end
        end
    else
        local alvo = alvoPropSelecionado and Players:FindFirstChild(alvoPropSelecionado) --[span_643](start_span)[span_643](end_span)
        if alvo and alvo ~= LocalPlayer and alvo.Character then --[span_644](start_span)[span_644](end_span)
            local hum = alvo.Character:FindFirstChildOfClass("Humanoid") --[span_645](start_span)[span_645](end_span)
            local hrp = alvo.Character:FindFirstChild("HumanoidRootPart") --[span_646](start_span)[span_646](end_span)
            if hum and hrp and hum.Health > 0 then --[span_647](start_span)[span_647](end_span)
                table.insert(lista, alvo) --[span_648](start_span)[span_648](end_span)
            end
        end
    end

    return lista --[span_649](start_span)[span_649](end_span)
end

-- FASE 1: Garante ou spawna até 20 props (no all) ou 1 prop (no player) afastados entre si e de você --[span_650](start_span)[span_650](end_span)
local function spawnarLoteCompleto(modoEfetivo, posBase) --[span_651](start_span)[span_651](end_span)
    local quantidadeDesejada = (modoEfetivo == "all") and TOTAL_PROPS_ALL or 1 --[span_652](start_span)[span_652](end_span)
    local propsAtuais = coletarPropsDisponiveis(quantidadeDesejada) --[span_653](start_span)[span_653](end_span)

    if #propsAtuais >= quantidadeDesejada then --[span_654](start_span)[span_654](end_span)
        return propsAtuais --[span_655](start_span)[span_655](end_span)
    end

    local maxTentativas = (modoEfetivo == "all") and 65 or 8 --[span_656](start_span)[span_656](end_span)
    local tentativas = 0 --[span_657](start_span)[span_657](end_span)

    while #propsAtuais < quantidadeDesejada and tentativas < maxTentativas and propAvancadoAtivo do --[span_658](start_span)[span_658](end_span)
        tentativas = tentativas + 1 --[span_659](start_span)[span_659](end_span)

        local propMaker = pegarPropMaker() --[span_660](start_span)[span_660](end_span)
        local toolProp = propMaker and (propMaker:FindFirstChild("Tool_PropMake") or propMaker:FindFirstChildOfClass("RemoteEvent")) --[span_661](start_span)[span_661](end_span)

        if propMaker and toolProp then --[span_662](start_span)[span_662](end_span)
            local posAlvoSpawn = calcularPosicaoEspacada(posBase, #propsAtuais + 1, quantidadeDesejada) --[span_663](start_span)[span_663](end_span)
            local chaoPart, posChao = obterChaoParaSpawn(posAlvoSpawn) --[span_664](start_span)[span_664](end_span)

            pcall(function() --[span_665](start_span)[span_665](end_span)
                toolProp:FireServer(chaoPart, posChao) --[span_666](start_span)[span_666](end_span)
            end)
            pcall(function() --[span_667](start_span)[span_667](end_span)
                propMaker:Activate() --[span_668](start_span)[span_668](end_span)
            end)
        end

        task.wait(0.22) --[span_669](start_span)[span_669](end_span)
        propsAtuais = coletarPropsDisponiveis(quantidadeDesejada) --[span_670](start_span)[span_670](end_span)

        if #propsAtuais >= quantidadeDesejada then --[span_671](start_span)[span_671](end_span)
            break --[span_672](start_span)[span_672](end_span)
        end
    end

    return coletarPropsDisponiveis(quantidadeDesejada) --[span_673](start_span)[span_673](end_span)
end

-- FASE 2: Subida/descida rápida no alvo + void/bring imediato ao sentar + troca veloz de alvo --[span_674](start_span)[span_674](end_span)
local function controlarPropSubindoDescendo(prop, idxProp, acao, obterAlvosFn, indiceRef) --[span_675](start_span)[span_675](end_span)
    local fase = idxProp * 1.35 --[span_676](start_span)[span_676](end_span)

    while propAvancadoAtivo and prop and prop.Parent do --[span_677](start_span)[span_677](end_span)
        local alvos = obterAlvosFn() --[span_678](start_span)[span_678](end_span)
        if #alvos == 0 then --[span_679](start_span)[span_679](end_span)
            task.wait(0.15) --[span_680](start_span)[span_680](end_span)
            continue --[span_681](start_span)[span_681](end_span)
        end

        if indiceRef.atual > #alvos then --[span_682](start_span)[span_682](end_span)
            indiceRef.atual = 1 --[span_683](start_span)[span_683](end_span)
        end
        local alvo = alvos[indiceRef.atual] --[span_684](start_span)[span_684](end_span)
        indiceRef.atual = indiceRef.atual + 1 --[span_685](start_span)[span_685](end_span)

        if alvo and alvo ~= LocalPlayer and alvo.Character then --[span_686](start_span)[span_686](end_span)
            local tInicioAlvo = tick() --[span_687](start_span)[span_687](end_span)

            while propAvancadoAtivo and prop.Parent and alvo.Parent and (tick() - tInicioAlvo < TEMPO_MAX_ALVO_RAPIDO) do --[span_688](start_span)[span_688](end_span)
                local char = alvo.Character --[span_689](start_span)[span_689](end_span)
                local hrp = char and char:FindFirstChild("HumanoidRootPart") --[span_690](start_span)[span_690](end_span)
                local hum = char and char:FindFirstChildOfClass("Humanoid") --[span_691](start_span)[span_691](end_span)
                if not hrp or not hum or hum.Health <= 0 then --[span_692](start_span)[span_692](end_span)
                    break --[span_693](start_span)[span_693](end_span)
                end

                local ondaY = math.sin((tick() * VELOCIDADE_SUBIDA_DESCIDA) + fase) * AMPLITUDE_SUBIDA_DESCIDA --[span_694](start_span)[span_694](end_span)
                local posOscilando = Vector3.new(hrp.Position.X, hrp.Position.Y + ondaY, hrp.Position.Z) --[span_695](start_span)[span_695](end_span)
                moverProp(prop, CFrame.new(posOscilando)) --[span_696](start_span)[span_696](end_span)

                if hum.Sit then --[span_697](start_span)[span_697](end_span)
                    task.wait(0.02) --[span_698](start_span)[span_698](end_span)
                    if acao == "KILL" then --[span_699](start_span)[span_699](end_span)
                        local cfVoid = CFrame.new(hrp.Position.X, PROP_KILL_Y, hrp.Position.Z) --[span_700](start_span)[span_700](end_span)
                        moverProp(prop, cfVoid) --[span_701](start_span)[span_701](end_span)
                        task.wait(0.02) --[span_702](start_span)[span_702](end_span)
                        moverProp(prop, cfVoid) --[span_703](start_span)[span_703](end_span)
                    elseif acao == "BRING" then --[span_704](start_span)[span_704](end_span)
                        local meuHrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") --[span_705](start_span)[span_705](end_span)
                        if meuHrp then --[span_706](start_span)[span_706](end_span)
                            local cfBring = meuHrp.CFrame * CFrame.new(2, 0, 0) --[span_707](start_span)[span_707](end_span)
                            moverProp(prop, cfBring) --[span_708](start_span)[span_708](end_span)
                            task.wait(0.02) --[span_709](start_span)[span_709](end_span)
                            moverProp(prop, cfBring) --[span_710](start_span)[span_710](end_span)
                        end
                    end
                    task.wait(0.06) --[span_711](start_span)[span_711](end_span)
                    break --[span_712](start_span)[span_712](end_span)
                end

                task.wait(0.02) --[span_713](start_span)[span_713](end_span)
            end
        else
            task.wait(0.06) --[span_714](start_span)[span_714](end_span)
        end
    end
end

local function rodarEnxameProps(propsLote, acao) --[span_715](start_span)[span_715](end_span)
    local indiceRef = { atual = 1 } --[span_716](start_span)[span_716](end_span)

    for idxProp, prop in ipairs(propsLote) do --[span_717](start_span)[span_717](end_span)
        if prop and prop.Parent then --[span_718](start_span)[span_718](end_span)
            task.spawn(function() --[span_719](start_span)[span_719](end_span)
                controlarPropSubindoDescendo(prop, idxProp, acao, obterAlvosSemVoce, indiceRef) --[span_720](start_span)[span_720](end_span)
            end)
        end
        task.wait(0.02) --[span_721](start_span)[span_721](end_span)
    end

    while propAvancadoAtivo do --[span_722](start_span)[span_722](end_span)
        task.wait(0.2) --[span_723](start_span)[span_723](end_span)
    end
end

-- ============================================================================
-- LISTAS DE CONFIGURAÇÃO DO PROP (3 LISTAS) + INTERRUPTOR --[span_724](start_span)[span_724](end_span)
-- ============================================================================
UI.Dropdown(Tabs.Troll, { --[span_725](start_span)[span_725](end_span)
    Name = "Equipamento (Prop)", --[span_726](start_span)[span_726](end_span)
    Options = { "Privada", "Bancada" }, --[span_727](start_span)[span_727](end_span)
    CurrentOption = { "Privada" }, --[span_728](start_span)[span_728](end_span)
    Callback = function(opt) --[span_729](start_span)[span_729](end_span)
        if opt and opt[1] then --[span_730](start_span)[span_730](end_span)
            equipamentoSelecionado = opt[1] --[span_731](start_span)[span_731](end_span)
        end
    end
})

UI.Dropdown(Tabs.Troll, { --[span_732](start_span)[span_732](end_span)
    Name = "Função do Prop", --[span_733](start_span)[span_733](end_span)
    Options = { "Kill All", "Kill (Player)", "Bring All", "Bring (Player)" }, --[span_734](start_span)[span_734](end_span)
    CurrentOption = { "Kill All" }, --[span_735](start_span)[span_735](end_span)
    Callback = function(opt) --[span_736](start_span)[span_736](end_span)
        if opt and opt[1] then --[span_737](start_span)[span_737](end_span)
            funcaoPropSelecionada = opt[1] --[span_738](start_span)[span_738](end_span)
            if opt[1]:find("All") then --[span_739](start_span)[span_739](end_span)
                modoAlvoProp = "all" --[span_740](start_span)[span_740](end_span)
            else
                modoAlvoProp = "player" --[span_741](start_span)[span_741](end_span)
            end
        end
    end
})

UI.Dropdown(Tabs.Troll, { --[span_742](start_span)[span_742](end_span)
    Name = "Alvo (all / player)", --[span_743](start_span)[span_743](end_span)
    Options = { "all", "player" }, --[span_744](start_span)[span_744](end_span)
    CurrentOption = { "all" }, --[span_745](start_span)[span_745](end_span)
    Callback = function(opt) --[span_746](start_span)[span_746](end_span)
        if opt and opt[1] then --[span_747](start_span)[span_747](end_span)
            modoAlvoProp = opt[1] --[span_748](start_span)[span_748](end_span)
        end
    end
})

UI.Toggle(Tabs.Troll, { --[span_749](start_span)[span_749](end_span)
    Name = "Executar Prop Selecionado", --[span_750](start_span)[span_750](end_span)
    Description = "Gera até 20 props no all; sobe e desce nos alvos; só apaga ao desligar", --[span_751](start_span)[span_751](end_span)
    CurrentValue = false, --[span_752](start_span)[span_752](end_span)
    Callback = function(ativo) --[span_753](start_span)[span_753](end_span)
        propAvancadoAtivo = ativo --[span_754](start_span)[span_754](end_span)
        if not ativo then --[span_755](start_span)[span_755](end_span)
            deletarTodosProps() --[span_756](start_span)[span_756](end_span)
            Notify("Props", "Desligado e props removidos.", 2) --[span_757](start_span)[span_757](end_span)
            return --[span_758](start_span)[span_758](end_span)
        end

        if not pegarPropMaker() then --[span_759](start_span)[span_759](end_span)
            propAvancadoAtivo = false --[span_760](start_span)[span_760](end_span)
            Notify("Props", "Falha ao equipar 'caixa de props'.", 2) --[span_761](start_span)[span_761](end_span)
            return --[span_762](start_span)[span_762](end_span)
        end

        selecionarEquipamentoProp(equipamentoSelecionado) --[span_763](start_span)[span_763](end_span)
        local acao = funcaoPropSelecionada:find("Kill") and "KILL" or "BRING" --[span_764](start_span)[span_764](end_span)
        local modoEfetivo = modoAlvoProp --[span_765](start_span)[span_765](end_span)
        if funcaoPropSelecionada:find("All") then --[span_766](start_span)[span_766](end_span)
            modoEfetivo = "all" --[span_767](start_span)[span_767](end_span)
        elseif funcaoPropSelecionada:find("(Player)", 1, true) then --[span_768](start_span)[span_768](end_span)
            modoEfetivo = "player" --[span_769](start_span)[span_769](end_span)
        end

        task.spawn(function() --[span_770](start_span)[span_770](end_span)
            local meuChar = LocalPlayer.Character --[span_771](start_span)[span_771](end_span)
            local meuHrp = meuChar and meuChar:FindFirstChild("HumanoidRootPart") --[span_772](start_span)[span_772](end_span)
            local posBase = meuHrp and meuHrp.Position or Vector3.new(-428.6, 0.4, 64.9) --[span_773](start_span)[span_773](end_span)

            local propsLote = spawnarLoteCompleto(modoEfetivo, posBase) --[span_774](start_span)[span_774](end_span)
            if #propsLote == 0 then --[span_775](start_span)[span_775](end_span)
                propAvancadoAtivo = false --[span_776](start_span)[span_776](end_span)
                Notify("Props", "Não foi possível gerar os props.", 3) --[span_777](start_span)[span_777](end_span)
                return --[span_778](start_span)[span_778](end_span)
            end

            rodarEnxameProps(propsLote, acao) --[span_779](start_span)[span_779](end_span)
        end)
    end
})
--]]
