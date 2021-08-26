# R-script db_construction.R

# Notes

# Here we are treating exports data

# References --------------------------------------------------------------

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


# Functions ---------------------------------------------------------------

source(file = "src/fct/data_loc.R")

# Code --------------------------------------------------------------------

data_exports <- function(exp_path="data/EXP_COMPLETA_MUN/EXP_COMPLETA_MUN.csv", grouped_by="rgime"){
  
  # Getting BR location info
  sg_uf_br <- c("AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO")
  br_loc <- data_loc(sg_uf_br) %>% 
    dplyr::distinct()
  
  # Loading exp data
  # reference
  exp <- vroom::vroom(file = exp_path) %>% 
    suppressMessages() %>% 
    janitor::clean_names() %>% 
    dplyr::mutate(exp=dplyr::if_else(is.na(vl_fob), 0, vl_fob)) %>% 
    dplyr::mutate("cd_sh2" = substr(sh4, 1, 2)) %>%
    dplyr::rename(
      "sg_uf"="sg_uf_mun",
      "cd_mun"="co_mun",
      "year"="co_ano",
      "cd_sh4"="sh4"
    ) %>% 
    dplyr::select(cd_mun, sg_uf, cd_sh2, cd_sh4, year, exp); gc()
  
  # Fixing code misplacements #make it within dplyr pipe
  exp[which(exp$sg_uf=="SP"), "cd_mun"] = exp[which(exp$sg_uf=="SP"), "cd_mun"] + 100000 # SP
  exp[which(exp$sg_uf=="GO"), "cd_mun"] = exp[which(exp$sg_uf=="GO"), "cd_mun"] - 100000 # GO
  exp[which(exp$sg_uf=="MS"), "cd_mun"] = exp[which(exp$sg_uf=="MS"), "cd_mun"] - 200000 # MS
  exp[which(exp$sg_uf=="DF"), "cd_mun"] = exp[which(exp$sg_uf=="DF"), "cd_mun"] - 100000 # DF
  
  exp1 <- exp %>% 
    dplyr::group_by(cd_mun, sg_uf, year, cd_sh2) %>%
    dplyr::summarise(exp = sum(exp), .gr) %>% 
    dplyr::ungroup(); rm(exp); gc()
  
  exp2 <- exp1 %>% 
    dplyr::mutate(
      cd_mun=as.character(cd_mun),
      year=as.character(year)
    ) %>% 
    dplyr::left_join(., br_loc, by = c("cd_mun", "sg_uf")) %>% 
    stats::na.omit() %>% 
    dplyr::select(cd_mun, nm_mun, cd_meso, nm_meso, cd_rgint, nm_rgint, cd_micro, nm_micro, cd_rgime, nm_rgime, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, cd_sh2, exp)
  
  exp_t <- exp2 %>% 
    dplyr::group_by(cd_mun, sg_uf, cd_sh2) %>% 
    dplyr::summarise(exp=sum(exp)) %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(
      year="1997-2021"
    ) %>%
    dplyr::left_join(., br_loc, by = c("cd_mun", "sg_uf")) %>% 
    dplyr::select(cd_mun, nm_mun, cd_meso, nm_meso, cd_rgint, nm_rgint, cd_micro, nm_micro, cd_rgime, nm_rgime, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, cd_sh2, exp)
  
  exp_t0 <- exp2 %>% 
    dplyr::group_by(cd_mun, sg_uf) %>% 
    dplyr::summarise(exp=sum(exp)) %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(
      cd_sh2="00",
      year="1997-2021"
    ) %>%
    dplyr::left_join(., br_loc, by = c("cd_mun", "sg_uf")) %>% 
    dplyr::select(cd_mun, nm_mun, cd_meso, nm_meso, cd_rgint, nm_rgint, cd_micro, nm_micro, cd_rgime, nm_rgime, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, cd_sh2, exp)
  
  df_exp <- dplyr::bind_rows(exp2, exp_t, exp_t0) %>% 
    dplyr::mutate(cd_sh2=paste0("sh", cd_sh2)) %>% 
    dplyr::mutate(
      cd_mun=as.character(cd_mun),
      cd_meso=as.character(cd_meso),
      cd_rgint=as.character(cd_rgint),
      cd_micro=as.character(cd_micro),
      cd_rgime=as.character(cd_rgime),
      cd_uf=as.character(cd_uf),
      cd_rg=as.character(cd_rg),
      var=cd_sh2,
      value=exp
    ) %>%
    dplyr::select(cd_mun, nm_mun, cd_meso, nm_meso, cd_rgint, nm_rgint, cd_micro, nm_micro, cd_rgime, nm_rgime, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var, value)
  
  if(grouped_by=="mun"){
    df_exp
  } else
  if(grouped_by=="meso"){
      df_exp <- df_exp %>% 
        group_by(cd_meso, nm_meso, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
        summarise(value=sum(value)) %>% 
        ungroup()
  } else
  if(grouped_by=="micro"){
      df_exp <- df_exp %>% 
        group_by(cd_micro, nm_micro, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
        summarise(value=sum(value)) %>% 
        ungroup()
  } else
  if(grouped_by=="rgint"){
      df_exp <- df_exp %>% 
        group_by(cd_rgint, nm_rgint, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
        summarise(value=sum(value)) %>% 
        ungroup()
  } else
  if(grouped_by=="rgime"){
      df_exp <- df_exp %>% 
        group_by(cd_rgime, nm_rgime, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
        summarise(value=sum(value)) %>% 
        ungroup()
  } else
  if(grouped_by=="uf"){
      df_exp <- df_exp %>% 
        group_by(cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
        summarise(value=sum(value)) %>% 
        ungroup()
  }
  
  return(df_exp)
  
}

# df <- data_exports(exp_path="data/EXP_COMPLETA_MUN/EXP_COMPLETA_MUN.csv", grouped_by="uf")
# df <- data_exports(exp_path="data/EXP_COMPLETA_MUN/EXP_COMPLETA_MUN.csv", grouped_by="rgime")
