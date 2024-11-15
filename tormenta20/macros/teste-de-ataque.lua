local resultado
local adicional
local observacao
local bonus
local tipoAtaque
local pmRestantes = 62 -- PM total do personagem

-- Modificadores e bônus fixos
local Heredrimm = 2
local luta = 12
local poderoso = -2
local investida = 2
local flanquado = 2
local especialBaseMetade = 8 -- Metade do bônus progressivo para Ataque Especial
local especialBaseTotal = 16 -- Bônus total para Ataque Especial
local foco = 4 -- Ajustado com Foco em Arma (+2)
local temporario = 0

-- Escolha do tipo de ataque
local indice, texto = choose("Escolha o tipo de ataque:", {
  "Ataque: 0 PM",
  "Investida: 0 PM",
  "Flanqueado: 0 PM",
  "Especial: 50% s/bônus -1 PM",
  "Especial: 100% s/bônus -1 PM",
  "Especial 50% c/bônus: -3 PM",
  "Especial 100% c/bônus: -3 PM"
}, 1)

chat:escrever("Opção escolhida: " .. texto, true, true)
tipoAtaque = indice

-- Entrada para bônus adicional
bonus = tonumber(inputQuery("Digite o valor bônus", "0"))
bonus = tonumber(bonus) or 0

-- Ataque Especial com progressão de PM gasto
local pmEspecial = tonumber(inputQuery("PM a gastar no Ataque Especial (0 a 4)", "0"))
pmEspecial = math.min(pmEspecial, 4)
especialBaseTotal = 4 * pmEspecial
especialBaseMetade = 2 * pmEspecial

-- Condição de Valentão
local valentao = tonumber(inputQuery("O alvo está caído, desprevenido ou flanqueado? (Sim = 2, Não = 0)", "0"))

-- Lógica para definir bônus de ataque com base no tipo de ataque selecionado
if tipoAtaque == 1 then
  adicional = Heredrimm + luta + poderoso + bonus + temporario + foco + valentao
  observacao = "Ataque poderoso: 0 PM"

elseif tipoAtaque == 2 then
  adicional = Heredrimm + luta + investida + poderoso + bonus + temporario + foco + valentao
  observacao = "Investida poderosa: 0 PM"

elseif tipoAtaque == 3 then
  adicional = Heredrimm + luta + flanquado + poderoso + bonus + temporario + foco + valentao
  observacao = "Flanqueamento poderoso: 0 PM"

elseif tipoAtaque == 4 then
  adicional = Heredrimm + luta + poderoso + bonus + temporario + especialBaseMetade + foco + valentao
  observacao = "Especial poderoso 50% s/bônus: -1 PM"

elseif tipoAtaque == 5 then
  adicional = Heredrimm + luta + poderoso + bonus + temporario + especialBaseTotal + foco + valentao
  observacao = "Especial poderoso 100% s/bônus: -1 PM"

elseif tipoAtaque == 6 then
  adicional = Heredrimm + luta + especialBaseMetade + especialParcial + poderoso + bonus + temporario + foco + valentao
  observacao = "Especial poderoso 50% c/bônus: -3 PM"

elseif tipoAtaque == 7 then
  adicional = Heredrimm + luta + especialBaseTotal + especialTotal + poderoso + bonus + temporario + foco + valentao
  observacao = "Especial poderoso 100% c/bônus: -3 PM"
end

-- Cálculo do ataque e rolagem
local resultado = rolar("1d20+" .. adicional, observacao)
local valorSemModificador = tonumber(resultado) - tonumber(adicional)

-- Check de crítico
if valorSemModificador >= 19 then
  enviar("💥 [§K7] [KAIZEN] [§K4] ACERTOU UM CRÍTICO!")
elseif valorSemModificador > 1 then
  enviar("🪓 [§K7] [KAIZEN] [§K1]" .. resultado .. "[§K1] te acerta? ")
else
  enviar("❌ [§K1] FALHA =/ [§K7] [KAIZEN]  [§K1] ERROU ")
end

-- Opção para usar Mestre em Arma para rerolar
local reroll = choose("Usar Mestre em Arma para rerolar o ataque? (-2 PM)", {"Sim", "Não"}, 2)
if reroll == 1 then
  if pmRestantes >= 2 then
    pmRestantes = pmRestantes - 2
    resultado = rolar("1d20+" .. adicional, " - Rerol após Mestre em Arma (-2 PM)")
  else
    enviar("⚠️ [§K4] PM insuficientes para usar Mestre em Arma! (Necessário 2 PM)")
  end
end
