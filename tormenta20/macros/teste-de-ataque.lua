-- =================== DECLARAÇÕES INICIAIS ===================
local resultado
local adicional
local observacao
local bonus
local tipoAtaque
local ataqueEspecialBonus = 0
local danoEspecialBonus = 0
local foiCritico = false
local pmGasto = 0

-- Modificadores e bônus fixos
local Heredrimm = 2
local luta = 18
local poderoso = -2 -- Para ataques
local poderosoDano = 5 -- Para danos
local investida = 2
local flanquado = 2
local duasMaos = 5
local machado = 2
local machadoBonusDano = 2 -- Bônus específico do machado
local modificador = 8
local temporario = 0
local focoEmArma = 2
local limiteCritico = 19 -- Limite para determinar crítico no resultado final
local penalidadeDefesaInvestida = -2 -- Penalidade de Defesa ao usar Investida

-- =================== MACRO DE ATAQUE ===================

-- Declaração no chat
chat:escrever("[§K4]Kaizen prepara um Ataque Poderoso![§K1]", true, true)

-- Primeiro menu: Escolha do tipo de ataque
local indice, texto = choose("!!!!!!     TIPO DE ATAQUE     !!!!!!", {
  "Normal",
  "Investida",
  "Flanqueado",
  "Especial"
}, 1)

chat:escrever("Opção escolhida: " .. texto, true, true)
tipoAtaque = indice

-- Entrada para bônus temporário
bonus = tonumber(inputQuery("Valor Temporário?", "0"))
bonus = tonumber(bonus) or 0

-- Processa o tipo de ataque
if tipoAtaque == 1 then
  adicional = Heredrimm + luta + poderoso + bonus + focoEmArma
  observacao = "[ATAQUE] Normal | 0 PM"
elseif tipoAtaque == 2 then
  adicional = Heredrimm + luta + investida + poderoso + bonus + focoEmArma
  observacao = "[ATAQUE] Investida | 0 PM"
  -- Aviso no chat sobre a penalidade de defesa
  chat:escrever("[§K4]Kaizen sofreu uma penalidade de Defesa de " .. penalidadeDefesaInvestida .. " até o final do turno![§K1]", true, true)
elseif tipoAtaque == 3 then
  adicional = Heredrimm + luta + flanquado + poderoso + bonus + focoEmArma
  observacao = "[ATAQUE] Flanqueado | 0 PM"
elseif tipoAtaque == 4 then
  -- Segundo menu: Seleção de bônus do Ataque Especial
  local escolhaBonus, textoBonus = choose("Quanto de bônus deseja adicionar?", {
    "+4 (-1 PM)",
    "+8 (-2 PM)",
    "+12 (-3 PM)",
    "+16 (-4 PM)"
  }, 1)
  
  pmGasto = escolhaBonus
  ataqueEspecialBonus = escolhaBonus * 4
  chat:escrever("[§K4]Kaizen decidiu adicionar +" .. ataqueEspecialBonus .. " no especial (-" .. pmGasto .. " PM)[§K1]", true, true)

  -- Terceiro menu: Divisão do bônus
  local escolhaDivisao, textoDivisao = choose("Como deseja aplicar o bônus?", {
    "Dividido entre ataque e dano",
    "Somente ataque",
    "Somente dano"
  }, 1)
  
  if escolhaDivisao == 1 then
    ataqueEspecialBonus = math.floor(ataqueEspecialBonus / 2)
    danoEspecialBonus = ataqueEspecialBonus
    observacao = "[ATAQUE] Especial Dividido (+" .. ataqueEspecialBonus .. " Ataque / +" .. danoEspecialBonus .. " Dano) | -" .. pmGasto .. " PM"
    chat:escrever("[§K4]Kaizen decidiu dividir o bônus entre ataque e dano[§K1]", true, true)
  elseif escolhaDivisao == 2 then
    danoEspecialBonus = 0
    observacao = "[ATAQUE] Especial no Ataque (+" .. ataqueEspecialBonus .. ") | -" .. pmGasto .. " PM"
    chat:escrever("[§K4]Kaizen decidiu aplicar o bônus somente no ataque[§K1]", true, true)
  elseif escolhaDivisao == 3 then
    ataqueEspecialBonus = 0
    danoEspecialBonus = escolhaBonus * 4
    observacao = "[ATAQUE] Especial no Dano (+" .. danoEspecialBonus .. ") | -" .. pmGasto .. " PM"
    chat:escrever("[§K4]Kaizen decidiu aplicar o bônus somente no dano[§K1]", true, true)
  end

  adicional = Heredrimm + luta + poderoso + bonus + focoEmArma + ataqueEspecialBonus
end

-- Exibe log dos valores usados no ataque
local logAtaque = "Heredrimm: " .. Heredrimm .. "\nluta: " .. luta .. "\npoderoso: " .. poderoso .. "\nbonus: " .. bonus .. "\nfocoEmArma: " .. focoEmArma .. "\nataqueEspecialBonus: " .. ataqueEspecialBonus
chat:escrever("[DEBUG] Valores do Ataque:\n" .. logAtaque, true, true)

-- Rolagem do ataque
resultado = rolar("1d20+" .. adicional, observacao)

-- Verifica o valor do dado para determinar falha, crítico ou acerto
local valorSemModificador = resultado - adicional
if valorSemModificador == 1 then
  enviar("❌ [§K1] FALHA AUTOMÁTICA! [§K7] [KAIZEN] [§K1] ERROU.")
  return -- Interrompe a macro
elseif valorSemModificador >= limiteCritico then
  foiCritico = true
  enviar("💥 [§K7] [KAIZEN] [§K4] ACERTOU UM CRÍTICO!")
else
  -- Pergunta se o ataque acertou
  enviar("🪓 [§K7] [KAIZEN] [§K1]" .. resultado .. "[§K1] te acerta?")
  local acertou = choose("Kaizen acertou o ataque?", { "Sim", "Não" }, 1)
  if acertou ~= 1 then
    enviar("❌ Ataque não acertou.")
    return -- Interrompe a macro se não acertar
  end
end

-- =================== MACRO DE DANO INTEGRADA ===================
-- Entrada para valor temporário no dano
temporario = tonumber(inputQuery("Valor Temporário no Dano?", "0"))
temporario = tonumber(temporario) or 0

-- Cálculo do dano com base no tipo de ataque e crítico
local valor
if tipoAtaque == 4 then
  -- Especial: Considera somente o danoEspecialBonus
  adicional = machado + machadoBonusDano + modificador + duasMaos + poderosoDano + temporario + danoEspecialBonus
  valor = "1d12+"
  observacao = "[DANO] Especial | -" .. pmGasto .. " PM"
else
  -- Ataque Normal, Investida, ou Flanqueado
  adicional = machado + machadoBonusDano + modificador + duasMaos + poderosoDano + temporario
  valor = "1d12+"
  observacao = "[DANO] Normal"
end

-- Exibe log dos valores usados no dano
local logDano = "machado: " .. machado .. "\nmachadoBonusDano: " .. machadoBonusDano .. "\nmodificador: " .. modificador .. "\nduasMaos: " .. duasMaos .. "\npoderosoDano: " .. poderosoDano .. "\ntemporario: " .. temporario .. "\ndanoEspecialBonus: " .. danoEspecialBonus
chat:escrever("[DEBUG] Valores do Dano:\n" .. logDano, true, true)

-- Ajuste para crítico
if foiCritico then
  valor = "3d12+"
  observacao = observacao .. " CRÍTICO"
end

-- Rolagem do dano
local resultadoDano = rolar(valor .. adicional, observacao)
enviar("🪓 [§K7] [Kaizen] [§K1] " .. resultadoDano .. " DE DANO")
