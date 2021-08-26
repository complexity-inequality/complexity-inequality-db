#!

# R-script db_construction.R

# Notes

# It's intended to add the varibles and measures in an orderly sequantial manner, each step well commented and referenced.
# Finally, after collecting every value to the municipal dataset, the regions (uf, meso, micro, rgint, rgime) are grouped and summarized.
# Some methods are only applied when the polygons are already grouped (uf, meso, micro, rgint, rgime)

# Perhaps it might be better to have scripts that Extract, Treat and Load our data directly to the DB, without having huge datasets in memory.

# References --------------------------------------------------------------

# https://grapher.network/blog/
# https://pacha.dev/blog/
# https://pacha.dev/
# https://cran.r-project.org/web/packages/economiccomplexity/economiccomplexity.pdf

# Method of Reflections is the one used by Hidalgo and Hausmann

# Setup -------------------------------------------------------------------

# rm(list = ls())
gc()
options(stringsAsFactors = F)
ggplot2::theme_set(ggplot2::theme_minimal())
options(scipen = 666)
mongo_credentials <- config::get(file = "conf/credentials.yml")

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
if(!require(inspectdf)){install.packages("inspectdf")}
if(!require(logr)){install.packages("logr")}


# Functions ---------------------------------------------------------------


source(file = "src/fct/data_loc.R")
source(file = "src/fct/fct_mongo_insert.R")
source(file = "src/fct/fct_normalize.R")

source(file = "src/fct/data_rnorm.R")
source(file = "src/fct/data_exports.R")
source(file = "src/fct/data_residuf_sidra631.R")

source(file = "src/fct/fct_iterate_eci.R")
source(file = "src/fct/data_eci.R")

lf <- log_open("db.log")



# To Do -------------------------------------------------------------------

# transformar data_fun para get_data
# transformar em executável
# Habilitar inserção na DB durante cada trexo do construction pra não encher a memória

# Code --------------------------------------------------------------------


log_print("Running db script")

# init db construction

log_print("Running data_rnorm()")
db_mun <- data_rnorm()
# glimpse(db_mun)

# Add exports to it
log_print("Running data_exports()")
db_mun <- bind_rows(db_mun, data_exports(grouped_by="mun"))

# Add residuf to db (The number of residents by uf in each municipality)
log_print("Running data_residuf()")
db_mun <- bind_rows(db_mun, data_residuf(grouped_by = "mun"))

# List of dbs
ll_db <- list()
ll_db[["db_mun"]] <- db_mun
log_print("db_mun stored at ll_db")


# db_uf -------------------------------------------------------------------

# Grouping by uf
log_print("Summarizing df_uf")
df_uf <- ll_db[["db_mun"]] %>% 
  dplyr::group_by(cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
  dplyr::summarise(value=sum(value)) %>% 
  dplyr::ungroup()

# Add eci to it
log_print("Binding df_eci to df_uf")
df_uf <- bind_rows(
  df_uf, 
  data_eci(df = data_exports(grouped_by = "uf"), grouped_by = "uf")
)

ll_db[["db_uf"]] <- df_uf
log_print("db_uf stored at ll_db")


# db_meso -----------------------------------------------------------------

# Grouping by meso
log_print("Summarizing db_meso")
df_meso <- ll_db[["db_mun"]] %>% 
  dplyr::group_by(cd_meso, nm_meso, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
  dplyr::summarise(value=sum(value)) %>% 
  dplyr::ungroup()

# Add eci to it
log_print("Binding df_eci to db_meso")
df_meso <- bind_rows(
  df_meso, 
  data_eci(df = data_exports(grouped_by = "meso"), grouped_by = "meso")
)

ll_db[["db_meso"]] <- df_meso
log_print("db_meso stored at ll_db")

# db_micro ----------------------------------------------------------------

# Grouping by micro
log_print("Summarizing db_micro")
df_micro <- ll_db[["db_mun"]] %>% 
  dplyr::group_by(cd_micro, nm_micro, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
  dplyr::summarise(value=sum(value)) %>% 
  dplyr::ungroup()

# Add eci to it
log_print("Binding df_eci to db_micro")
df_micro <- bind_rows(
  df_micro, 
  data_eci(df = data_exports(grouped_by = "micro"), grouped_by = "micro")
)

ll_db[["db_micro"]] <- df_micro
log_print("db_micro stored at ll_db")

# db_rgint ----------------------------------------------------------------

# Grouping by rgint
log_print("Summarizing db_rgint")
df_rgint <- ll_db[["db_mun"]] %>% 
  dplyr::group_by(cd_rgint, nm_rgint, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
  dplyr::summarise(value=sum(value)) %>% 
  dplyr::ungroup()

# Add eci to it
log_print("Binding df_eci to db_rgint")
df_rgint <- bind_rows(
  df_rgint, 
  data_eci(df = data_exports(grouped_by = "rgint"), grouped_by = "rgint")
)

ll_db[["db_rgint"]] <- df_rgint
log_print("db_rgint stored at ll_db")

# db_rgime ----------------------------------------------------------------

# Grouping by rgime
log_print("Summarizing db_rgime")
df_rgime <- ll_db[["db_mun"]] %>% 
  dplyr::group_by(cd_rgime, nm_rgime, cd_uf, nm_uf, sg_uf, cd_rg, nm_rg, sg_rg, year, var) %>% 
  dplyr::summarise(value=sum(value)) %>% 
  dplyr::ungroup()

# Add eci to it
log_print("Binding df_eci to db_rgime")
df_rgime <- bind_rows(
  df_rgime, 
  data_eci(df = data_exports(grouped_by = "rgime"), grouped_by = "rgime")
)

ll_db[["db_rgime"]] <- df_rgime
log_print("db_rgime stored at ll_db")


log_print("Saving ll_db")

readr::write_rds(x = ll_db, file = "data/ll_db.rds")
readr::write_rds(x = ll_db, file = "../complexity-inequality-app/data/ll_db.rds")
readr::write_rds(x = ll_db, file = "../complexity-inequality-api/data/ll_db.rds")
rio::export(ll_db[["db_mun"]], "../complexity-inequality-api/data/db_mun.csv")
rio::export(ll_db[["db_uf"]], "../complexity-inequality-api/data/db_uf.csv")
rio::export(ll_db[["db_meso"]], "../complexity-inequality-api/data/db_meso.csv")
rio::export(ll_db[["db_micro"]], "../complexity-inequality-api/data/db_micro.csv")
rio::export(ll_db[["db_rgint"]], "../complexity-inequality-api/data/db_rgint.csv")
rio::export(ll_db[["db_rgime"]], "../complexity-inequality-api/data/db_rgime.csv")



# More --------------------------------------------------------------------


# options -----------------------------------------------------------------



# Check plot --------------------------------------------------------------

# reac_query
colec = paste0("colec_", "meso")
mongo_set <- mongolite::mongo(db = "db1", collection = colec, url = mongo_credentials$mongoURL, verbose = TRUE)
df <- mongo_set$find()
df <- mongo_set$find(paste0('{"product" : ', paste0('"', "eci_ref_norm", '"'), '}'))
df <- mongo_set$find(paste0('{"product" : ', paste0('"', "eci_ref_norm", '"'), ', "cd_year" : ', paste0('"', "2013", '"'), '}'))

# react_df
shp_df <- sf::st_read("data/shp/shp_uf/")
df_shp <- dplyr::full_join(
  df,
  shp_df
) %>% sf::st_sf()

# output$plot1
ggplot2::ggplot(df_shp)+
  # ggplot2::geom_sf(ggplot2::aes(0), color="black", size=.13)+
  ggplot2::geom_sf(ggplot2::aes(fill=value), color="black", size=.2)+
  ggplot2::scale_fill_gradient(low="white", high="blue")+
  ggplot2::labs(title = "", caption = "", y = "Latitude", x = "Longitude")+
  ggplot2::theme_void()

# draft -------------------------------------------------------------------


sapply(ll_db, colnames)
