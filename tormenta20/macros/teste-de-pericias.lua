local pericias = {
  acrobacia = 3,
  adestramento = 9,
  atletismo = 8,
  atuacao = 5,
  cavalgar = 7,
  conhecimento = 5,
  cura = 6, 
  diplomacia = 5,
  enganacao = 5,
  fortitude = 14,
  furtividade = 3,
  guerra = 5,
  iniciativa = 7,
  intimidacao = 9,
  intuicao = 6,
  investigacao = 5,
  jogatina = 5,
  ladinagem = 3,
  luta = 12,
  misticismo = 5, 
  nobreza = 5,
  minerador = 9,
  percepcao = 6,
  pilotagem = 7,
  pontaria = 11,
  reflexos = 7,
  religiao = 6,
  sobrevivencia = 6,
  vontade = 6
}

local opcoes_pericias = {
  "acrobacia", "adestramento", "atletismo", "atuacao", "cavalgar", "conhecimento",
  "cura", "diplomacia", "enganacao", "fortitude", "furtividade", "guerra",
  "iniciativa", "intimidacao", "intuicao", "investigacao", "jogatina", "ladinagem",
  "luta", "misticismo", "nobreza", "minerador", "percepcao", "pilotagem", "pontaria",
  "reflexos", "religiao", "sobrevivencia", "vontade"
}

local indice, texto = choose("Escolha a perícia: ", opcoes_pericias, 1)

bonus = inputQuery("Digite o valor bonus")
bonus = tonumber(bonus) or 0

local observacao = '';

if indice then
  local valor = pericias[texto]
  local total  = tonumber(valor) + tonumber(bonus)

  observacao =  "PERÍCIA: " .. texto .. "\n(Valor Base: " .. valor .. ")" .. "\nbonus: " .. bonus
  local resultado = rolar("1d20+" .. total, observacao)
else
  enviar("Nenhuma perícia selecionada!")
end
