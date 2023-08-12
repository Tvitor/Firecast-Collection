local resultado;
local adicional;
local observacao;
local bonus;
local tipoAtaque;

local Heredrimm = 2
local luta = 12
local poderoso = -2
local investida = 2
local flanquado = 2
local especialBaseMetade = 6
local especialBaseTotal = 12
local especialParcial = 4
local especialTotal = 8 
local temporario = 0
local foco = 2

alert('!!!!!!        COMUNIQUE ATAQUE PODEROSO       !!!!!!')
local indice, texto = choose("!!!!!!        COMUNIQUE ATAQUE PODEROSO       !!!!!!", {
  "Ataque: 0 PM",
  "Investida: 0 PM",
  "Flanqueado: 0 PM",
  "Especial: 50% s/bônus -1 PM",
  "Especial: 100% s/bônus -1 PM",
  "Especial 50% c/bônus: -3 PM",
  "Especial 100% c/bônus: -3 PM"
}, 1);

chat:escrever("Opção escolhida: " .. texto, true, true)

tipoAtaque = indice;

bonus = tonumber(inputQuery("Digite o valor bonus","0"))
bonus = tonumber(bonus) or 0

if tipoAtaque == 1 then
  adicional = Heredrimm + luta + poderoso + bonus + temporario + foco
  log = "\nHeredrimm: " .. Heredrimm .. "\nluta: " .. luta .. "\npoderoso: " .. poderoso .. "\nbonus: " .. bonus .. "\ntemporario: " .. temporario .. "\nfoco: " .. foco
  observacao = " Ataque poderoso: 0 PM" .. log
elseif tipoAtaque == 2 then
  adicional = Heredrimm + luta + investida + poderoso + bonus + temporario + foco
  observacao = " - Investida poderosa: 0 PM"
  log = " Heredrimm: " .. Heredrimm .. "\nluta: " .. luta .. "\npoderoso: " .. poderoso .. "\nbonus: " .. bonus .. "\ntemporario: " .. temporario .. "\ninvestida: " .. investida .. "\nfoco: " .. foco
elseif tipoAtaque == 3 then
  adicional = Heredrimm + luta + flanquado + poderoso + bonus + temporario + foco
  observacao = " - Flanqueamento poderoso: 0 PM"
  log = " Heredrimm: " .. Heredrimm .. "\nluta: " .. luta .. "\npoderoso: " .. poderoso .. "\nbonus: " .. bonus .. "\ntemporario: " .. temporario .. "\nflanquado: " .. flanquado .. "\nfoco: " .. foco
elseif tipoAtaque == 4 then
  adicional = Heredrimm + luta + poderoso + bonus + temporario + especialBaseMetade + foco
  observacao = " - Especial poderoso 50% s/bônus: -1PM"
  log = " Heredrimm: " .. Heredrimm .. "\nluta: " .. luta .. "\npoderoso: " .. poderoso .. "\nbonus: " .. bonus .. "\ntemporario: " .. temporario .. "\nespecial: " .. especialBaseMetade .. "\nfoco: " .. foco
elseif tipoAtaque == 5 then
  adicional = Heredrimm + luta + poderoso + bonus + temporario + especialBaseTotal + foco
  observacao = " - Especial poderoso 100% s/bônus: -1PM"
  log = " Heredrimm: " .. Heredrimm .. "\nluta: " .. luta .. "\npoderoso: " .. poderoso .. "\nbonus: " .. bonus .. "\ntemporario: " .. temporario .. "\nespecial: " .. especialBaseTotal .. "\nfoco: " .. foco
elseif tipoAtaque == 6 then
  adicional = Heredrimm + luta + especialBaseMetade + especialParcial + poderoso + bonus + temporario + foco
  observacao = " - Especial poderoso + 50% bônus: -3PM"
  log = " Heredrimm: " .. Heredrimm .. "\nluta: " .. luta .. "\npoderoso: " .. poderoso .. "\nbonus: " .. bonus .. "\ntemporario: " .. temporario .. "\nespecial: " .. especialBaseMetade .. "\nbonusEspecial: " .. especialParcial .. "\nfoco: " .. foco
elseif tipoAtaque == 7 then
  adicional = Heredrimm + luta + especialBaseTotal + especialTotal + poderoso + bonus + temporario + foco
  observacao = " Especial poderoso + 100% bônus: -3PM"
  log = " Heredrimm: " .. Heredrimm .. "\nluta: " .. luta .. "\npoderoso: " .. poderoso .. "\nbonus: " .. bonus .. "\ntemporario: " .. temporario .. "\nespecial: " .. especialBaseTotal .. "\nespecialBonus: " .. especialTotal .. "\nfoco: " .. foco
end

local resultado = rolar("1d20+" .. adicional, observacao)

local valorSemModificador = tonumber(resultado) - tonumber(adicional)

if valorSemModificador == 20 then
  enviar("💥 KAIZEN ACERTOU UM CRÍTICO!")
elseif valorSemModificador > 1 then
  enviar("🪓 KAIZEN TIROU " .. resultado)
else
  enviar("❌ FALHA =/ KAIZEN ERROU ")
end

