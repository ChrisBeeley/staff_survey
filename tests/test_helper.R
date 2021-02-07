
# test helper file

library(magrittr)

root <- rprojroot::is_r_package

staff_data <- readr::read_csv(root$find_file("staff_data.csv"))

names(staff_data) <- c("Directorate", "Best", "Best1", "Best2", "BestCrit", 
                       "Improve", "Imp1", "Imp2", "ImpCrit")

staff_data <- staff_data %>% 
  dplyr::na_if(99) %>% 
  dplyr::na_if("99") %>% 
  tidyr::unite(BestCode, c(Best1, Best2), sep = ",", na.rm = TRUE)

staff_data <- staff_data %>% 
  dplyr::mutate(BestCode = gsub(" ", "", BestCode))

staff_data <- staff_data %>% 
  dplyr::mutate(BestCode = stringr::str_split(staff_data$BestCode, ","))

pins::board_register_rsconnect(name = "SPACED",
                               server = "https://involve.nottshc.nhs.uk:8443",
                               key = Sys.getenv("CLOUD_API_KEY"))

categories <- pins::pin_get("staffCategories", "SPACED")