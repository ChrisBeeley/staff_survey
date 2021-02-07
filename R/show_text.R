
show_text <- function(data, question_type, 
                      super_category , sub_category = NULL, 
                      category_table, join_lookup){
  
  df <- data %>%  
    tidyr::unnest(question_type) %>% 
    dplyr::mutate(dplyr::across(all_of(question_type), as.numeric)) %>% 
    dplyr::left_join(category_table, join_lookup)
  
  if(!is.null(sub_category)){

    return(
      df %>%
        dplyr::filter(Super == super_category, Category == sub_category) %>%
        dplyr::pull(comment) %>%
        paste0("<p>", ., "</p>")
    )

  } else {

    return(
      df %>%
        dplyr::filter(Criticality == super_category) %>% 
        dplyr::pull(comment) %>%
        paste0("<p>", ., "</p>")
    )
  }
}
