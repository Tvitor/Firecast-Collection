local resultado;
local adicional;
local observacao;
local bonus;
local tipoAtaque;

local Heredrimm = 2
local luta = 18
local poderoso = -2
local investida = 2
local flanquado = 2
local especialMetade = 8
local especialTotal = 16
local focoEmArma = 2

-- Declaração no chat
chat:escrever("[§K4]Kaizen prepara um Ataque Poderoso![§K1]", true, true)

-- Primeiro menu: Escolha do tipo de ataque
-- alert('!!!!!!        SELECIONE O TIPO DE ATAQUE       !!!!!!')
local indice, texto = choose("!!!!!!     TIPO DE ATAQUE     !!!!!!", {
  "Normal",
  "Investida",
  "Flanqueado",
  "Especial"
}, 1)

chat:escrever("Opção escolhida: " .. texto, true, true)
tipoAtaque = indice;

bonus = tonumber(inputQuery("valor Temporário?", "0"))
bonus = tonumber(bonus) or 0

-- Variável para bônus do Ataque Especial
local ataqueEspecialBonus = 0
local danoEspecialBonus = 0

-- Processa o tipo de ataque
if tipoAtaque == 1 then
  adicional = Heredrimm + luta + poderoso + bonus  + focoEmArma
  observacao = "Ataque Normal: 0 PM"
elseif tipoAtaque == 2 then
  adicional = Heredrimm + luta + investida + poderoso + bonus  + focoEmArma
  observacao = "Investida poderosa: 0 PM"
elseif tipoAtaque == 3 then
  adicional = Heredrimm + luta + flanquado + poderoso + bonus  + focoEmArma
  observacao = "Flanqueamento poderoso: 0 PM"
elseif tipoAtaque == 4 then
  -- Segundo menu: Seleção de bônus do Ataque Especial
  local escolhaBonus, textoBonus = choose("Quanto de bônus deseja adicionar?", {
    "+4 (-1 PM)",
    "+8 (-2 PM)",
    "+12 (-3 PM)",
    "+16 (-4 PM)"
  }, 1)
  
  local pmGasto = escolhaBonus  -- 1 PM para +4, 2 PM para +8, etc.
  ataqueEspecialBonus = escolhaBonus * 4  -- Converte escolha para bônus correspondente
  chat:escrever("[§K4]Kaizen decidiu adicionar +" .. ataqueEspecialBonus .. " no especial (-" .. pmGasto .. " PM)[§K1]", true, true)

  -- Terceiro menu: Divisão do bônus
  local escolhaDivisao, textoDivisao = choose("Como deseja aplicar o bônus?", {
    "Dividido entre ataque e dano",
    "Somente ataque",
    "Somente dano"
  }, 1)
  
  if escolhaDivisao == 1 then
    -- Dividido entre ataque e dano
    ataqueEspecialBonus = math.floor(ataqueEspecialBonus / 2)
    danoEspecialBonus = ataqueEspecialBonus
    observacao = "Especial: Bônus dividido entre ataque e dano (-" .. pmGasto .. " PM)"
    chat:escrever("[§K4]Kaizen decidiu dividir o bônus entre ataque e dano[§K1]", true, true)
  elseif escolhaDivisao == 2 then
    -- Somente ataque
    danoEspecialBonus = 0
    observacao = "Especial: Bônus somente no ataque (-" .. pmGasto .. " PM)"
    chat:escrever("[§K4]Kaizen decidiu aplicar o bônus somente no ataque[§K1]", true, true)
  elseif escolhaDivisao == 3 then
    -- Somente dano
    ataqueEspecialBonus = 0
    danoEspecialBonus = escolhaBonus * 4
    observacao = "Especial: Bônus somente no dano (-" .. pmGasto .. " PM)"
    chat:escrever("[§K4]Kaizen decidiu aplicar o bônus somente no dano[§K1]", true, true)
  end
  
  adicional = Heredrimm + luta + poderoso + bonus  + focoEmArma + ataqueEspecialBonus
end

-- Rolagem do ataque
local resultado = rolar("1d20+" .. adicional, observacao)

-- Análise do resultado
local valorSemModificador = tonumber(resultado) - tonumber(adicional)

if valorSemModificador == 19 then
  enviar("💥 [§K7] [KAIZEN] [§K4] ACERTOU UM CRÍTICO!")
elseif valorSemModificador > 1 then
  enviar("🪓 [§K7] [KAIZEN] [§K1]" .. resultado .. "[§K1] te acerta? ")
else
  enviar("❌ [§K1] FALHA =/ [§K7] [KAIZEN]  [§K1] ERROU ")
end
