
test_that("Super category table works", {
  
  root <- rprojroot::is_r_package
  
  source(root$find_file("tests/test_helper.R"))
  
  calculated_table <- calculate_table(table_data = staff_data,
                                      code_column = "Code",
                                      category_table = categories,
                                      join_lookup = c("Code" = "Number"),
                                      count_column = "Super")

  testthat::expect_true(sum(is.na(calculated_table[["Super"]])) == 0) # no missing elements
  
  testthat::expect_equal(sum(calculated_table$percent), 100, tolerance = 1e-1)
})
  
testthat::test_that("Sub category table works", {
  
  root <- rprojroot::is_r_package
  
  source(root$find_file("tests/test_helper.R"))
  
  calculated_table <- calculate_table(table_data = staff_data,
                                      code_column = "Code",
                                      category_table = categories,
                                      join_lookup = c("Code" = "Number"),
                                      count_column = "Category",
                                      click_column = "Management ")

  testthat::expect_true(sum(is.na(calculated_table[["Category"]])) == 0) # no missing elements
  
  testthat::expect_equal(sum(calculated_table$percent), 100, tolerance = 1e-1)
})

test_that("Criticality table works", {

  root <- rprojroot::is_r_package
  
  source(root$find_file("tests/test_helper.R"))

  # make a criticality table
  
  criticality_lookup <- data.frame(Number = -3 : 3, 
                                   Criticality = c("Highly critical", "Fairly critical", 
                                                   "Somewhat critical", "Not critical",
                                                   "Slightly positive", "Somewhat positive",
                                                   "Very positive"))

  calculated_table <- calculate_table(table_data = staff_data,
                                      code_column = "Crit",
                                      category_table = criticality_lookup,
                                      join_lookup = c("Crit" = "Number"),
                                      count_column = "Criticality")
  
  testthat::expect_true(sum(is.na(calculated_table[["Criticality"]])) == 0) # no missing elements
  
  testthat::expect_equal(sum(calculated_table$percent), 100, tolerance = 1e-1)

})
