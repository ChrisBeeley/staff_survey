
calculate_table <- function(table_data, code_column, category_table, join_lookup, count_column) {
  table_data %>%  
    tidyr::unnest(.data[[code_column]]) %>% 
    dplyr::mutate(dplyr::across(all_of(code_column), as.numeric)) %>% 
    dplyr::left_join(category_table, join_lookup) %>% 
    dplyr::count(.data[[count_column]]) %>%
    dplyr::filter(!is.na(.data[[count_column]])) %>%
    dplyr::mutate(percent = round(n / sum(n) * 100, 1)) %>%
    dplyr::arrange(dplyr::desc(percent))
}

