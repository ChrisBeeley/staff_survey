
load_staff_data <- function(filepath){
  
  staff_data <- readr::read_csv(filepath)
  
  names(staff_data) <- c("Directorate", "Best", "Best1", "Best2", "BestCrit", 
                         "Improve", "Imp1", "Imp2", "ImpCrit")
  
  staff_data <- staff_data %>% 
    dplyr::na_if(99) %>% 
    dplyr::na_if("99") %>% 
    tidyr::unite(BestCode, c(Best1, Best2), sep = ",", na.rm = TRUE) %>% 
    tidyr::unite(ImpCode, c(Imp1, Imp2), sep = ",", na.rm = TRUE)
  
  staff_data <- staff_data %>% 
    dplyr::mutate(BestCode = gsub(" ", "", BestCode)) %>% 
    dplyr::mutate(ImpCode = gsub(" ", "", ImpCode))
  
  staff_data <- staff_data %>% 
    dplyr::mutate(BestCode = stringr::str_split(staff_data$BestCode, ",")) %>% 
    dplyr::mutate(ImpCode = stringr::str_split(staff_data$ImpCode, ","))
  
  staff_data <- dplyr::bind_rows(staff_data %>% 
                     dplyr::select(Directorate, comment = Best, 
                                   Code = BestCode, Crit = BestCrit) %>% 
                     dplyr::mutate(type = "Best"),
                   staff_data %>% 
                     dplyr::select(Directorate, comment = Improve, 
                                   Code = ImpCode, Crit = ImpCrit) %>% 
                     dplyr::mutate(type = "Improve"))
  
  return(staff_data)
}

load_categories <- function(){
  
  pins::board_register_rsconnect(name = "SPACED",
                                 server = "https://involve.nottshc.nhs.uk:8443",
                                 key = Sys.getenv("CLOUD_API_KEY"))
  
  categories <- pins::pin_get("staffCategories", "SPACED")
  
  return(categories)
}