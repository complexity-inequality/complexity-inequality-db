# R-script data_txalfab.R

# Notes

# DEPRECATED DUE TO IMPOSSIBILITY OF GETTING THIS INFO TO RGINT AND RGIME

# Tabela 1383 - Taxa de alfabetização das pessoas de 10 anos ou mais de idade por sexo
# https://sidra.ibge.gov.br/Tabela/1383
# https://apisidra.ibge.gov.br/values/t/1383/n6/all/v/all/p/all/c2/all/d/v1646%201

# Setup -------------------------------------------------------------------

# rm(list = ls())
gc()
options(stringsAsFactors = F)
ggplot2::theme_set(ggplot2::theme_minimal())
options(scipen = 666)

# Packages ----------------------------------------------------------------

if(!require(readr)){install.packages("readr")}
if(!require(config)){install.packages("config")}
if(!require(plyr)){install.packages("plyr")}
if(!require(dplyr)){install.packages("dplyr")}
if(!require(tidyr)){install.packages("tidyr")}
if(!require(ggplot2)){install.packages("ggplot2")}
if(!require(janitor)){install.packages("janitor")}
if(!require(mongolite)){install.packages("mongolite")}
if(!require(readxl)){install.packages("readxl")}
if(!require(reticulate)){install.packages("reticulate")}
if(!require(vroom)){install.packages("vroom")}
if(!require(economiccomplexity)){install.packages("economiccomplexity")}
if(!require(sidrar)){install.packages("sidrar")}
library(inspectdf)

source(file = "src/fct/data_loc.R")

# Code --------------------------------------------------------------------


data_txalfab <- function(){
  
  # Getting BR location info
  sg_uf_br <- c("AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO")
  br_loc <- data_loc(sg_uf_br) %>% 
    dplyr::distinct()
  
  t1383_alfab <- get_sidra(api='/t/1383/n6/all/v/all/p/all/c2/all/d/v1646%201') %>% 
    janitor::clean_names() %>% 
    dplyr::select(cd_mun = municipio_codigo, product = sexo, value = valor) %>% 
    mutate(
      cd_year="2010",
      product = paste0("txalfab_", tolower(product), "_censo2010")
    )
  
  df <- left_join(br_loc, t1383_alfab, by = "cd_mun")
  # tt[!tt$cd_mun%in%t1383_alfab$cd_mun, ]
  df_txalfab <- df %>% na.omit()
  
  return(df_txalfab)
}


# df <- data_txalfab()
# df %>% inspect_na()
# unique(df$product)
