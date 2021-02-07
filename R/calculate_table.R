#' calculate percentage tables for comment themes
#' 
#' @param table_data A dataframe
#' @param code_column String with name of column to summarise.
#' @param category_table The table to join with.
#' @param join_lookup A named vector giving the names to join on
#' @param count_column String with the name of the column to count in the joined table
#' @param click_column A string with the name of the category that has been clicked, if any
#' @return a dataframe with category name, n, and %
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
