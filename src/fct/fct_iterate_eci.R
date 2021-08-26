fct_iterate_eci <- function(df, reg, ano){
  
  df1 <- df %>% 
    dplyr::filter(year==ano)
  
  df2 <- df1 %>%
    dplyr::rename(
      "country"=reg,
      "product"="var"
    ) %>%
    stats::na.omit()
  
  eci_est_fit <- economiccomplexity::complexity_measures(
    balassa_index = economiccomplexity::balassa_index(data = df2), 
    method = "fitness"
  )$complexity_index_country
  
  eci_est_ref <- economiccomplexity::complexity_measures(
    balassa_index = economiccomplexity::balassa_index(data = df2), 
    method = "reflections"
  )$complexity_index_country
  
  eci_estdf_fit <- 
    data.frame(
      reg=names(eci_est_fit),
      product="eci_fit",
      value=as.numeric(eci_est_fit)
    ) %>% 
    dplyr::select( # for renaming dynamically
      !!dplyr::quo_name(reg):="reg",
      dplyr::everything()
    ) %>% 
    dplyr::left_join(
      ., 
      df1 %>% dplyr::select(-var, -value) %>% dplyr::distinct(), 
      by=reg
    ) %>% 
    dplyr::arrange(desc(value)) %>% 
    dplyr::select(c(names(df %>% rename("product"="var"))))
  
  eci_estdf_fit_norm <- 
    data.frame(
      reg=names(eci_est_fit),
      product="eci_fit_norm",
      value=normalize(as.numeric(eci_est_fit))
    ) %>%
    dplyr::select( # for renaming dynamically
      !!dplyr::quo_name(reg):="reg",
      dplyr::everything()
    ) %>%
    dplyr::left_join(
      ., 
      df1 %>% dplyr::select(-var, -value) %>% dplyr::distinct(), 
      by=reg
    ) %>% 
    dplyr::arrange(desc(value)) %>% 
    dplyr::select(c(names(df %>% rename("product"="var"))))
  
  eci_estdf_ref <- 
    data.frame(
      reg=names(eci_est_ref),
      product="eci_ref",
      value=as.numeric(eci_est_ref)
    ) %>% 
    dplyr::select( # for renaming dynamically
      !!dplyr::quo_name(reg):="reg",
      dplyr::everything()
    ) %>% 
    dplyr::left_join(
      ., 
      df1 %>% dplyr::select(-var, -value) %>% dplyr::distinct(), 
      by=reg
    ) %>% 
    dplyr::arrange(desc(value)) %>% 
    dplyr::select(c(names(df %>% rename("product"="var"))))
  
  eci_estdf_ref_norm <- 
    data.frame(
      reg=names(eci_est_ref),
      product="eci_ref_norm",
      value=normalize(as.numeric(eci_est_ref))
    ) %>%
    dplyr::select( # for renaming dynamically
      !!dplyr::quo_name(reg):="reg",
      dplyr::everything()
    ) %>%
    dplyr::left_join(
      ., 
      df1 %>% dplyr::select(-var, -value) %>% dplyr::distinct(), 
      by=reg
    ) %>% 
    dplyr::arrange(desc(value)) %>% 
    dplyr::select(c(names(df %>% rename("product"="var"))))
  
  df3 <- df2[0, ] %>% 
    dplyr::bind_rows(., eci_estdf_fit) %>%
    dplyr::bind_rows(., eci_estdf_fit_norm) %>% 
    dplyr::bind_rows(., eci_estdf_ref) %>% 
    dplyr::bind_rows(., eci_estdf_ref_norm) %>% 
    dplyr::select(names(df %>% rename("product"="var"))) %>% 
    dplyr::rename(var=product)
  
  return(df3)
  
}
