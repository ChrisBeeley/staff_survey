
library(magrittr)

root <- rprojroot::is_r_package

test_that("Staff data loads", {
  
  staff_data <- load_staff_data(root$find_file("staff_data.csv"))
  
  testthat::expect_gt(nrow(staff_data), 0)
})

test_that("Category table loads", {
  
  categories <- load_categories()
  
  testthat::expect_gt(nrow(categories), 0)
})

