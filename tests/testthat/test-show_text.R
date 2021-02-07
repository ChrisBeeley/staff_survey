
root <- rprojroot::is_r_package

source(root$find_file("tests/test_helper.R"))

source(root$find_file("R/calculate_table.R"))

test_that("Text displays", {
  
  test <- show_text(data = staff_data, question_type = "BestCode", 
            super_category = "Management ", sub_category = "General",
            category_table = categories,
            join_lookup = c("BestCode" = "Number"),
            pull_question = "Best")
  
  expect_gt(length(test), 0)
  
})
