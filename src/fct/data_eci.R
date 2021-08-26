data_eci <- function(df = "df_exports", grouped_by = "uf"){
  
  # Getting ECI for each year
  ll <- list()
  for(i in unique(df$year)){
    ll[[i]] <- fct_iterate_eci(
      df = df, 
      reg = paste0("cd_", grouped_by), 
      ano=i
    )
  }
  
  # Bind them all
  df_eci <- dplyr::bind_rows(ll) %>% 
    dplyr::ungroup() #%>% 
    # dplyr::select(-country)
  
  return(df_eci)
  
}

# dfuf <- data_eci(grouped_by = "uf")
