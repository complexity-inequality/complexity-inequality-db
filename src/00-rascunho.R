# R-script 07-plots.R


# References --------------------------------------------------------------

# https://grapher.network/blog/
# https://pacha.dev/blog/
# https://pacha.dev/
# https://cran.r-project.org/web/packages/economiccomplexity/economiccomplexity.pdf

# Setup -------------------------------------------------------------------

# rm(list = ls())
gc()
options(stringsAsFactors = F)
ggplot2::theme_set(ggplot2::theme_minimal())
options(scipen = 666)


# Packages ----------------------------------------------------------------

if(!require(readr)){install.packages("readr")}
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


# Code --------------------------------------------------------------------

# Set the url path
mongo_credentials <- config::get(file = "conf/globalresources.yml")

# Set db
# mongo_set <- mongo(db = "db1", collection = "colec_meso_exp_eci", url = mongo_credentials$mongoURL, verbose = TRUE)
# mongo_set <- mongo(db = "db1", collection = "colec_uf", url = mongo_credentials$mongoURL, verbose = TRUE)
# Check all collections
# mongo(url = mongo_credentials$mongoURL)$run('{"listCollections":1}')$cursor$firstBatch %>% as_tibble()

# Find df
# mongo_data <- mongo_set$find()

# df1 <- mongo_data %>% filter(product=="eci")
df1 <- ll_db[["db_uf"]] %>% 
  filter(product)

# shp
shp_ufs <- sf::st_read("data/shp/shp_uf/")

# Join
dff_shp <- dplyr::left_join(df1, shp_ufs) %>% sf::st_sf()
class(dff_shp)


ggplot2::ggplot(dff_shp, ggplot2::aes(fill=value))+
  ggplot2::geom_sf(color="black", size=.2)+
  ggplot2::scale_fill_gradient(low="white", high="blue")+
  ggplot2::labs(title = "", caption = "", y = "Latitude", x = "Longitude")+
  ggplot2::theme_void()




ggplot2::ggplot(df1)+
  ggplot2::geom_boxplot(ggplot2::aes(x=sg_rg, y=value))
ggplot2::labs(title = "", caption = "", y = "", x = "")+
  ggplot2::theme_void()



sidrar::get_sidra("https://apisidra.ibge.gov.br/values/t/6450/n6/all/v/allxp/p/all/c12762/116830,116831,116866,116873,116880,116881,116887,116897,116905,116910,116911,116952,116960,116965,116985,116994,117007,117015,117029,117039,117048,117082,117089,117099,117136,117159,117179,117196,117229,117245,117261,117267,117296,117297,117307,117308,117311,117315,117326,117329,117330,117335,117348,117363,117364,117376,117438,117484,117485,117501,117513,117521,117538,117543,117544,117549,117555,117556,117567,117575,117581,117594,117601,117608,117609,117641,117654,117666,117667,117673,117674,117680,117685,117692,117697,117704,117711,117714,117715,117731,117744,117752,117762,117774,117775,117788,117789,117810,117811,117827,117835,117838,117839,117844,117849,117852,117862,117875,117882,117889,117893,117897/d/v662%200")
sidrar::