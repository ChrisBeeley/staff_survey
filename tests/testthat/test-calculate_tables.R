
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

# make a criticality table

criticality_lookup <- data.frame(Number = -3 : 3, 
                                 Criticality = c("Highly critical", "Fairly critical", 
                                                 "Somewhat critical", "Not critical",
                                                 "Slightly positive", "Somewhat positive",
                                                 "Very positive"))

test_that("Super category table works", {

  calculated_table <- calculate_table(table_data = staff_data,
                                      code_column = "BestCode",
                                      category_table = categories,
                                      join_lookup = c("BestCode" = "Number"),
                                      count_column = "Super")

  testthat::expect_true(sum(is.na(calculated_table[["Super"]])) == 0) # no missing elements
  
  testthat::expect_equal(sum(calculated_table$percent), 100, tolerance = 1e-1)
})
  
test_that("Sub category table works", {
    
  calculated_table <- calculate_table(table_data = staff_data,
                                      code_column = "BestCode",
                                      category_table = categories,
                                      join_lookup = c("BestCode" = "Number"),
                                      count_column = "Category",
                                      click_column = "Communication")

  testthat::expect_true(sum(is.na(calculated_table[["Category"]])) == 0) # no missing elements
  
  testthat::expect_equal(sum(calculated_table$percent), 100, tolerance = 1e-1)
})

test_that("Criticality table works", {
  
  calculated_table <- calculate_table(table_data = staff_data,
                                      code_column = "BestCrit",
                                      category_table = criticality_lookup,
                                      join_lookup = c("BestCrit" = "Number"),
                                      count_column = "Criticality")
  
  testthat::expect_true(sum(is.na(calculated_table[["Criticality"]])) == 0) # no missing elements
  
  testthat::expect_equal(sum(calculated_table$percent), 100, tolerance = 1e-1)

})