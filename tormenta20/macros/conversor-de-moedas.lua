local indice1, texto1 = choose("Escolha a moeda de origem:", {
    "Tibar de cobre(TC) - Origem",
    "Tibar de prata(TS) - Origem",
    "Tibar de ouro(TO)  - Origem"
  }, 1)
  
  chat:escrever("Origem escolhida: " .. texto1, true, true)
  
  local indice2, texto2 = choose("Escolha a moeda de destino:", {
    "Tibar de cobre(TC) - Destino",
    "Tibar de prata(TS) - Destino",
    "Tibar de ouro(TO)  - Destino"
  }, 1)
  
  chat:escrever("Destino escolhido: " .. texto2, true, true)
  
  local valorInicial = inputQuery("Digite o valor a ser convertido")
  valorInicial = tonumber(valorInicial) or 0
  
  local moedaOrigem, moedaDestino
  
  if tonumber(indice1) == 1 then
    moedaOrigem = "TC"
  elseif tonumber(indice1) == 2 then
    moedaOrigem = "TS"
  elseif tonumber(indice1) == 3 then
    moedaOrigem = "TO"
  end
  
  if tonumber(indice2) == 1 then
    moedaDestino = "TC"
  elseif tonumber(indice2) == 2 then
    moedaDestino = "TS"
  elseif tonumber(indice2) == 3 then
    moedaDestino = "TO"
  end
  
  local conversao = {
    TC = {TC = 1, TS = 0.1, TO = 0.01},
    TS = {TC = 10, TS = 1, TO = 0.1},
    TO = {TC = 100, TS = 10, TO = 1}
  }
  
  local resultado
  
  if conversao[moedaOrigem] and conversao[moedaOrigem][moedaDestino] then
    resultado = valorInicial * conversao[moedaOrigem][moedaDestino]
  else
    chat:escrever("Moeda de origem ou destino inválida!", true, true)
  end
  
  chat:escrever(valorInicial .. " " .. moedaOrigem .. " equivalem a " .. resultado .. " " .. moedaDestino, true, true)
  