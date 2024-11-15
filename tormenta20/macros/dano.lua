local rolagem
local final
local adicional, observacao
local log
local tipoDano

-- Modificadores e bônus fixos
local temporario = 0
local duasMaos = 5 -- Bônus de Estilo de Duas Mãos
local machado = 2 -- Bônus de Foco em Arma para o machado
local modificador = 4 -- Modificador de Força do personagem
local poderoso = 5 -- Ataque Poderoso
local especialBaseMetade = 8 -- Bônus metade especial
local especialBaseTotal = 16 -- Bônus total especial
local meioBonus = 4 -- Meio bônus adicional para golpes especiais
local bonusTotal = 8 -- Bônus total adicional para golpes especiais
local valor = ""
local adicional = 0

-- Escolha do tipo de dano
local indice, texto = choose("Escolha o tipo de dano", {
    "Dano",
    "Especial 50% s/bônus",
    "Especial 100% s/bônus",
    "Especial 50% c/bônus",
    "Especial 100% c/bônus",
    "Crítico",
    "Crítico especial 50% s/bônus",
    "Crítico especial 100% s/bônus",
    "Crítico especial 50% c/bônus",
    "Crítico especial 100% c/bônus"
}, 1)

chat:escrever("Opção escolhida: " .. texto, true, true)
tipoDano = indice

-- Entrada para bônus adicional
extra = tonumber(inputQuery("Digite o valor extra", "0"))
extra = tonumber(extra) or 0

-- Lógica para definir o dano com base no tipo de ataque selecionado
if tipoDano == 1 then
  adicional = machado + modificador + duasMaos + poderoso + temporario + extra -- Adicional para o dano padrão
  log = "duasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = "DANO\n" .. log
  valor = "1d12+"

elseif tipoDano == 2 then
  adicional = especialBaseMetade + machado + modificador + duasMaos + poderoso + temporario + extra -- Adicional para o dano metade especial sem bônus
  log = "especial: " .. especialBaseMetade .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = "DANO ESPECIAL 50% S/BÔNUS\n" .. log
  valor = "1d12+"

elseif tipoDano == 3 then
  adicional = especialBaseTotal + machado + modificador + duasMaos + poderoso + temporario + extra -- Adicional para o dano especial sem bônus
  log = "especial: " .. especialBaseTotal .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = "DANO ESPECIAL 100% S/BÔNUS\n" .. log
  valor = "1d12+"

elseif tipoDano == 4 then
  adicional = machado + modificador + duasMaos + poderoso + especialBaseMetade + meioBonus + temporario + extra -- Adicional para o dano especial com meio bônus
  log = "especial: " .. especialBaseMetade .. "\nespecialBonus: " .. meioBonus .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = "DANO ESPECIAL 50% C/BÔNUS\n" .. log
  valor = "1d12+"

elseif tipoDano == 5 then
  adicional = machado + modificador + duasMaos + poderoso + especialBaseTotal + bonusTotal + temporario + extra -- Adicional para o dano especial com bônus total
  log = "especial: " .. especialBaseTotal .. "\nespecialBonus: " .. bonusTotal .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = "DANO ESPECIAL 100% C/BÔNUS\n" .. log
  valor = "1d12+"

elseif tipoDano == 6 then
  adicional = machado + modificador + duasMaos + poderoso + temporario + extra -- Adicional para o dano crítico padrão
  log = "duasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = "DANO CRÍTICO\n" .. log
  valor = "3d12+"

elseif tipoDano == 7 then
  adicional = especialBaseMetade + machado + modificador + duasMaos + poderoso + temporario + extra -- Adicional para o dano crítico sem bônus
  log = "especial: " .. especialBaseMetade .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = "DANO CRÍTICO ESPECIAL 50% S/BÔNUS\n" .. log
  valor = "3d12+"

elseif tipoDano == 8 then
  adicional = especialBaseTotal + machado + modificador + duasMaos + poderoso + temporario + extra -- Adicional para o dano crítico sem bônus
  log = "especial: " .. especialBaseTotal .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = "DANO CRÍTICO ESPECIAL 100% S/BÔNUS\n" .. log
  valor = "3d12+"

elseif tipoDano == 9 then
  adicional = especialBaseMetade + machado + modificador + duasMaos + poderoso + meioBonus + temporario + extra -- Adicional para o dano crítico com meio bônus
  log = "especial: " .. especialBaseMetade .. " \nespecialBonus: " .. meioBonus .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = "DANO CRÍTICO ESPECIAL 50% C/BÔNUS\n" .. log
  valor = "3d12+"

elseif tipoDano == 10 then
  adicional = especialBaseTotal + machado + modificador + duasMaos + poderoso + bonusTotal + temporario + extra -- Adicional para o dano crítico com bônus total
  log = "especial: " .. especialBaseTotal .. "\nespecialBonus: " .. bonusTotal .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = "DANO CRÍTICO ESPECIAL 100% C/BÔNUS\n" .. log
  valor = "3d12+"
end

local resultado = rolar(valor .. adicional, observacao)
enviar("🪓 [§K7] [Kaizen] [§K1] " .. resultado .." DE DANO")
