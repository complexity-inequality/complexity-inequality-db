

# Tabela 3604 - Pessoas de 10 anos ou mais de idade, ocupadas na semana de referência, que, no trabalho principal, trabalhavam fora do domicílio e retornavam diariamente do trabalho para o domicílio, exclusive as pessoas que, no trabalho principal, trabalhavam em mais de um município ou país, por tempo habitual de deslocamento do domicílio para o trabalho principal, segundo a situação do domicílio e os grupos de horas habitualmente trabalhadas por semana no trabalho principal
# Link do resultado: https://sidra.ibge.gov.br/tabela/3604#/n6/all/v/allxp/p/all/c537/all/c1/0/c12045/0/d/v2019%200/l/v,p+c537+c1,t+c12045/resultado
tabela3604 <- readr::read_csv("data/sidra_raw/tabela3604.csv", skip = 5) %>% 
  slice(., 1:(nrow(.)-12)) %>% 
# tabela3604 <- readr::read_csv("data/sidra_raw/tabela3604.csv", skip = 5) %>% 
  janitor::clean_names() %>% 
  dplyr::slice(1:(nrow(tabela3604)-12)) %>% 
  dplyr::mutate(
    total_1 = as.numeric(total_1), 
    total_2 = as.numeric(total_2), 
    total_3 = as.numeric(total_3), 
    total_4 = as.numeric(total_4), 
    total_5 = as.numeric(total_5)
  ) %>% 
  suppressWarnings() %>% 
  suppressMessages() %>% 
  dplyr::select(
    cd_mun                   = cod, 
    deslocamentoTotalPessoas = total, 
    deslocamentoAte5min      = total_1, 
    deslocamentoDe6a30min    = total_2, 
    deslocamentoDe30a60min   = total_3, 
    deslocamentoDe60a120min  = total_4, 
    deslocamentoMais120min   = total_5
  ) %>%
  dplyr::mutate(
    txDeslocamentoAte5min=deslocamentoAte5min/deslocamentoTotalPessoas,
    txDeslocamentoDe6a30min=deslocamentoDe6a30min/deslocamentoTotalPessoas,
    txDeslocamentoDe30a60min=deslocamentoDe30a60min/deslocamentoTotalPessoas,
    txDeslocamentoDe60a120min=deslocamentoDe60a120min/deslocamentoTotalPessoas,
    txDeslocamentoMais120min=deslocamentoMais120min/deslocamentoTotalPessoas
  ) %>% 
  dplyr::select(-deslocamentoTotalPessoas) %>% 
  tidyr::gather("var", "value", 2:length(.))

tabela3604
unique(tabela3604$var)







