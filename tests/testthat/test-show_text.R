
test_that("Theme text displays", {
  
  root <- rprojroot::is_r_package
  
  source(root$find_file("tests/test_helper.R"))
  
  source(root$find_file("R/calculate_table.R"))
  
  test <- show_text(data = staff_data, question_type = "Code",
                    super_category = "Management ", sub_category = "General",
                    category_table = categories,
                    join_lookup = c("Code" = "Number"))
  
  expect_gt(length(test), 0)
  
})

test_that("Criticality text displays", {
  
  root <- rprojroot::is_r_package
  
  source(root$find_file("tests/test_helper.R"))
  
  source(root$find_file("R/calculate_table.R"))
  
  test <- show_text(data = staff_data, question_type = "Crit",
                    super_category = "Very positive", sub_category = NULL,
                    category_table = criticality,
                    join_lookup = c("Crit" = "Number"))
  
  cat(str(test))
  
  expect_gt(length(test), 0)
  
})
