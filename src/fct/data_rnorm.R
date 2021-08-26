data_rnorm <- function(){
  # Function to return a normally distributed random value (mu=0, sd=1)
  sg_uf_br <- c("AC", "AL", "AP", "AM", "BA", "CE", "DF", "ES", "GO", "MA", "MT", "MS", "MG", "PA", "PB", "PR", "PE", "PI", "RJ", "RN", "RS", "RO", "RR", "SC", "SP", "SE", "TO")
  br_loc <- data_loc(sg_uf_br) %>% 
    dplyr::distinct()
  
  df_rnorm <- br_loc %>% 
    mutate(year="-", var="rnorm") %>% 
    bind_cols(data.frame(value=rnorm(nrow(br_loc), 0, 1)))
  
  return(df_rnorm)
}

# data_rnorm()
