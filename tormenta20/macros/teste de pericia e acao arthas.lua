local extra = 0
local mensagem = ''
local dado = 0

local indice, texto = choose("Defina a ação", {
    "TESTE DE AÇÃO",
    "DANO"
}, 1)

chat:escrever("Opção escolhida: " .. texto, true, true)

-- Função para obter o valor extra
local function obterExtra()
    extra = tonumber(inputQuery("bônus extra: ", "0"))
    return extra or 0
end

local indice2, texto2 = choose("Ataque do ARTHAS?", {
  "Sim",
  "Não"
}, 1)

-- Função para processar Ação com dado nas opções escolhidas
local function processarAcao(dado)
    extra = obterExtra()
    local resultado = dado + extra

    if(indice2 == 1) then
      if dado == 3 then
          mensagem = "💥" .. " " .. "[§K1]" .. texto .. ': ' .."[§K5] [ARTHAS] [§K8] ACERTOU UM CRÍTICO! " .."[§K3]" .. dado
      elseif dado == 18 then
        mensagem = "❌ " .. " " .. "[§K1]" .. texto .. ': ' .."[§K5] [ARTHAS] [§K4] ERROU" .. dado
      else
        mensagem = "🎯  " .. " " .. "[§K1]" .. texto .. ': ' .."[§K5] [ARTHAS] [§K3] " .."[§K3]" .. resultado
      end
    else
      if dado == 3 and indice ~= 2 then
        mensagem = "💥" .. " " .. "[§K1]" .. texto .. ': ' .."[§K7] [Soldado da Infantaria ARTHAS] [§K8] ACERTOU UM CRÍTICO! " .."[§K3]" .. dado
      elseif dado == 18 and indice ~= 2 then
      mensagem = "❌ " .. " " .. "[§K1]" .. texto .. ': ' .."[§K7] [Soldado da Infantaria ARTHAS] [§K4] ERROU" .. dado
      else
      mensagem = "🎯  " .. " " .. "[§K1]" .. texto .. ': ' .."[§K7] [Soldado da Infantaria ARTHAS] [§K3] " .."[§K3]" .. resultado
     end
    end
      enviar(mensagem)
    
end

if indice == 1 then
  local dado = rolar("3d6");
    processarAcao(dado) -- teste
elseif indice == 2 then
  local dado = rolar("1d6+2");
    processarAcao(dado) -- Dano
-- elseif indice == 3 then
--   local dado = rolar("3d6");
--     processarAcao(dado) -- Bloquear
-- elseif indice == 4 then
--   local dado = rolar("3d6");
--     processarAcao(dado) -- Aparar
-- elseif indice == 5 then
--   local dado = rolar("3d6");
--     processarAcao(dado) -- Esquivar
--   elseif indice == 6 then
--     local dado = rolar("3d6");
--       processarAcao(dado) -- Primeiros Socorros
end
