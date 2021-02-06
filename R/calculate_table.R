
calculate_table <- function(table_data, code_column, category_table, 
                            join_lookup, count_column, click_column = NULL) {
  
  df <- table_data %>%  
    tidyr::unnest(.data[[code_column]]) %>% 
    dplyr::mutate(dplyr::across(all_of(code_column), as.numeric)) %>% 
    dplyr::left_join(category_table, join_lookup)
  
  if(!is.null(click_column)){
    df <- df %>% dplyr::filter(Super == click_column)
  }
  
  df %>% 
    dplyr::count(.data[[count_column]]) %>%
    purrr::set_names(c("Category", "n")) %>% 
    dplyr::filter(!is.na(Category)) %>%
    dplyr::mutate(percent = round(n / sum(n) * 100, 1)) %>%
    dplyr::arrange(dplyr::desc(percent))
}
