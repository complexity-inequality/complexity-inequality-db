data_residuf <- function(grouped_by="mun"){
  # Function to get the origin of the residents from the UFs in the tabela631.csv at SIDRA
  # Link para o resultado: https://sidra.ibge.gov.br/tabela/631#/n6/all/v/allxp/p/last%202/c2/all/c183/0,3256,3257,3258,3259,3260,3261,3262,3263,3264,3265,3266,3267,3268,3269,3270,3271,3272,3273,3274,3275,3276,3277,3278,3279,3280,3281,3282,3284,6920/d/v93%200/l/v,p+c2,t+c183/resultado
  # Link para download: https://sidra.ibge.gov.br/geratabela?format=xlsx&name=tabela631.xlsx&terr=N&rank=-&query=t/631/n6/all/v/allxp/p/last%202/c2/all/c183/0,3256,3257,3258,3259,3260,3261,3262,3263,3264,3265,3266,3267,3268,3269,3270,3271,3272,3273,3274,3275,3276,3277,3278,3279,3280,3281,3282,3284,6920/d/v93%200/l/v,p%2Bc2,t%2Bc183
  sg_uf_br <- c("AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO")
  br_loc <- data_loc(sg_uf_br) %>% 
    dplyr::distinct()
  dic_uf <- br_loc[, c("sg_uf", "nm_uf")][!duplicated(br_loc[, c("sg_uf", "nm_uf")]),]
  names(dic_uf) <- c("sg_uf", "place_born")
  
  tabela631 <- readr::read_csv("data/sidra_raw/tabela631.csv", skip = 4)[-c(166951:166963), ] %>% 
    suppressWarnings() %>% 
    suppressMessages()
  names(tabela631) <- c("cd_mun", "place_born", "resid_total_1991", "resid_man_1991", "resid_fem_1991", "resid_total_2000", "resid_man_2000", "resid_fem_2000", "resid_total_2010", "resid_man_2010", "resid_fem_2010")
  
  tabela631 <- tabela631 %>% 
    dplyr::select(-c("resid_total_1991", "resid_man_1991", "resid_fem_1991")) %>% 
    dplyr::left_join(., dic_uf, by = "place_born") %>% 
    dplyr::mutate(sg_uf = replace_na(sg_uf, "BR")) %>% 
    dplyr::mutate_at(
      .vars = dplyr::vars(-c(cd_mun, place_born)),
      .funs=list(~ifelse(.%in%c("-", "..."), 0, .))
    ) %>%
    dplyr::mutate_at(
      .vars = dplyr::vars(-c(cd_mun, place_born, sg_uf)),
      .funs=as.numeric
    ) %>% 
    tidyr::gather("resid", "value", 3:8) %>% 
    dplyr::mutate(
      cd_mun = as.character(cd_mun),
      var=paste0(substr(resid, 1, nchar(resid)-4), "from", sg_uf),
      year=substr(resid, nchar(resid)-3, nchar(resid))
    ) %>% 
    dplyr::select(cd_mun, year, var, value) %>% 
    suppressWarnings() %>% 
    dplyr::left_join(., br_loc, by="cd_mun") %>% 
    dplyr::select(cd_mun, nm_mun, cd_meso, nm_meso, cd_rgint, nm_rgint, cd_micro, nm_micro, cd_rgime, nm_rgime, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var, value)
  
  if(grouped_by=="mun"){
    tabela631
  } else
    if(grouped_by=="meso"){
      tabela631 <- tabela631 %>% 
        group_by(cd_meso, nm_meso, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
        summarise(value=sum(value)) %>% 
        ungroup()
    } else
      if(grouped_by=="micro"){
        tabela631 <- tabela631 %>% 
          group_by(cd_micro, nm_micro, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
          summarise(value=sum(value)) %>% 
          ungroup()
      } else
        if(grouped_by=="rgint"){
          tabela631 <- tabela631 %>% 
            group_by(cd_rgint, nm_rgint, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
            summarise(value=sum(value)) %>% 
            ungroup()
        } else
          if(grouped_by=="rgime"){
            tabela631 <- tabela631 %>% 
              group_by(cd_rgime, nm_rgime, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
              summarise(value=sum(value)) %>% 
              ungroup()
          } else
            if(grouped_by=="uf"){
              tabela631 <- tabela631 %>% 
                group_by(cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
                summarise(value=sum(value)) %>% 
                ungroup()
            }
  
  return(tabela631)
}

# df <- data_residuf()
