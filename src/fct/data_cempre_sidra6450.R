

data_cempre <- function(grouped_by="mun"){}
  # Cada séries na tabela 6450 foi baixada separadamente para respeitar os limites de download do SIDRA e facilitar ETL
  # https://sidra.ibge.gov.br/tabela/6450#/n6/all/v/706/p/last%201/c12762/116831,116866,116873,116881,116887,116897,116905,116911,116952,116960,116965,116985,116994,117007,117015,117029,117039,117048,117082,117089,117099,117136,117159,117179,117196,117229,117245,117261,117267,117297,117308,117311,117315,117326,117330,117335,117348,117364,117376,117438,117485,117501,117513,117521,117538,117544,117549,117556,117567,117575,117581,117594,117601,117609,117641,117654,117667,117674,117680,117685,117692,117697,117704,117711,117715,117731,117744,117752,117762,117775,117789,117811,117827,117835,117839,117844,117849,117852,117862,117875,117882,117889,117893,117897/l/v,p+c12762,t/cfg/nter,cod,/resultado
  
  
  ll_unidades_locais <- list(
    sidra6450_unidadesLocais_y2006 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2006.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2007 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2007.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2008 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2008.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2009 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2009.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2010 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2010.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2011 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2011.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2012 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2012.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2013 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2013.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2014 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2014.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2015 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2015.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2016 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2016.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2017 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2017.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2018 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2018.csv", skip = 4)[1:5570, ],
    sidra6450_unidadesLocais_y2019 = readr::read_csv("data/sidra_raw/sidra6450_unidadesLocais_y2019.csv", skip = 4)[1:5570, ]
  ) %>% suppressWarnings() %>% suppressMessages()
  
  for(i in names(ll_unidades_locais)) {
    print(i)
    ll_unidades_locais[[i]] <- ll_unidades_locais[[i]] %>% 
      janitor::clean_names() %>% 
      gather("var", "value", 2:length(.)) %>% 
      mutate(
        value=ifelse(value=="-", "0", value),
        value=ifelse(value=="X", "0", value),
        year=substr(i, nchar(i)-3, nchar(i)),
        var=paste0("unidadesLocais_", var)
      )
  }
  
  
  
  
  
  
  ll_pessoalOcupadoAssalariado <- list(
    tabela6450_pessoalOcupadoAssalariado_y2006 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2006.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2007 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2007.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2008 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2008.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2009 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2009.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2010 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2010.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2011 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2011.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2012 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2012.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2013 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2013.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2014 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2014.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2015 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2015.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2016 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2016.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2017 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2017.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2018 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2018.csv", skip = 4)[1:5570, ],
    tabela6450_pessoalOcupadoAssalariado_y2019 = readr::read_csv("data/sidra_raw/tabela6450_pessoalOcupadoAssalariado_y2019.csv", skip = 4)[1:5570, ]
  ) %>% suppressWarnings() %>% suppressMessages()
  
  for(i in names(ll_pessoalOcupadoAssalariado)) {
    print(i)
    ll_pessoalOcupadoAssalariado[[i]] <- ll_pessoalOcupadoAssalariado[[i]] %>% 
      janitor::clean_names() %>% 
      gather("var", "value", 2:length(.)) %>% 
      mutate(
        value=ifelse(value=="-", "0", value),
        value=ifelse(value=="X", "0", value),
        year=substr(i, nchar(i)-3, nchar(i)),
        var=paste0("pessoalOcupadoAssalariado_", var)
      )
  }


  
  tabela6450_salariosEmMil_y2006.csv
  
  
  
  
  
  sg_uf_br <- c("AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO")
br_loc <- data_loc(sg_uf_br) %>% 
  dplyr::distinct()





