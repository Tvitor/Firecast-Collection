local rolagem
local final;
local adicional, observacao
local log;
local tipoDano;

local temporario = 0
local duasMaos = 5
local machado = 2
local modificador = 3
local poderoso = 5
local especialBaseMetade = 6
local especialBaseTotal = 12
local meioBonus = 4
local bonusTotal = 8
local valor = "";

local indice, texto = choose("Escolha o tipo de dano",{
    "Dano",
    "Especial 50% s/bônus",
    "Especial 100% s/bônus",
    "Golpe de raspão",
    "Especial 50% c/bônus",
    "Especial 100% c/bônus",
    "Crítico",
    "Crítico especial 50% s/bônus",
    "Crítico especial 100% s/bônus",
    "Crítico especial 50% c/bônus",
    "Crítico especial 100% c/bônus"}, 1);

chat:escrever("Opção escolhida: " .. texto, true, true)

tipoDano = indice;

  extra = inputQuery("Digite o valor extra")
  extra = tonumber(extra) or 0


if tipoDano == 1 then
  adicional = machado + modificador + duasMaos + poderoso + temporario + extra -- Adicional para o dano padrão
  log = "duasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
  observacao = " de dano "
  valor = "1d12";
elseif tipoDano == 2 then
  adicional = especialBaseMetade + machado + modificador + duasMaos  + poderoso + temporario + extra-- Adicional para o dano metade especial sem bônus
  observacao = " de dano especial."
  valor = "1d12";
  log = "especial: " .. especialBaseMetade .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
elseif tipoDano == 3 then
  adicional = especialBaseTotal + machado + modificador + duasMaos  + poderoso + temporario + extra-- Adicional para o dano especial sem bônus
  observacao = " de dano especial."
  valor = "1d12";
  log = "especial: " .. especialBaseTotal .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
elseif tipoDano == 4 then
  observacao = " de raspão"
 valor = "1d8";
 log = "1d8"
elseif tipoDano == 5 then
  adicional = machado + modificador + duasMaos  + poderoso  + especialBaseMetade + meioBonus + temporario + extra-- Adicional para o dano especial com meio bônus
  observacao = " de dano especial."
  valor = "1d12";
  log = "especial: " .. especialBaseMetade .. "\nespecialBonus: " .. meioBonus .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra 
elseif tipoDano == 6 then
  adicional = machado + modificador + duasMaos  + poderoso + especialBaseTotal + bonusTotal + temporario + extra-- Adicional para o dano especial com bônus total 
  observacao = " de dano especial." 
  valor = "1d12";
  log = "especial: " .. especialBaseTotal .. "\nespecialBonus: " .. bonusTotal .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra 
elseif tipoDano == 7 then
  adicional = machado + modificador + duasMaos + poderoso + temporario + extra-- Adicional para o dano crítico padrão
  observacao = " de dano crítico."
  valor = "3d12";
  log = "duasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
elseif tipoDano == 8 then
  adicional = especialBaseMetade + machado + modificador + duasMaos  + poderoso + temporario + extra-- Adicional para o dano crítico sem bônus
  observacao = " de dano crítico."
  valor = "3d12";
  log = "especial: " .. especialBaseMetade .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
elseif tipoDano == 9 then
  adicional = especialBaseTotal + machado + modificador + duasMaos  + poderoso + temporario + extra-- Adicional para o dano crítico sem bônus
  observacao = " de dano crítico."
  valor = "3d12";
  log = "especial: " .. especialBaseTotal .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
elseif tipoDano == 10 then
  adicional = especialBaseMetade + machado + modificador + duasMaos  + poderoso + meioBonus + temporario + extra-- Adicional para o dano crítico crítico com meio bônus
  observacao = " de dano crítico."
  valor = "3d12";
  log = "especial: " .. especialBaseMetade .. " \nespecialBonus: " .. meioBonus .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
elseif tipoDano == 11 then
  adicional = especialBaseTotal + machado +  modificador + duasMaos  + poderoso + bonusTotal + temporario + extra -- Adicional para o dano crítico crítico com bônus total
  observacao = " de dano crítico."
  valor = "3d12";
  log = "especial: " .. especialBaseTotal .. "\nespecialBonus: " .. bonusTotal .. "\nduasMaos: " .. duasMaos .. "\nmodificador: " .. modificador .. "\nmachado: " .. machado .. "\npoderoso: " .. poderoso .. "\ntemporario: " .. temporario .. "\nextra: " .. extra
end

rolagem = rolar(valor)

if valor == "1d8" then
 final = rolagem
else
  final = math.floor(adicional) + rolagem
end

enviar(myCharacter.nome .. ": "  .. "\n"  .. final .. observacao .. "\n" .. log)
