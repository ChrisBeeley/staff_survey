
# test helper file

library(magrittr)

root <- rprojroot::is_r_package

staff_data <- load_staff_data(root$find_file("staff_data.csv"))

categories <- load_categories()
