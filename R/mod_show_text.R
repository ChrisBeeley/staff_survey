#' show_text UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_show_text_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    htmlOutput(ns("text"))
  )
}

#' show_text Server Functions
#'
#' @noRd 
mod_show_text_server <- function(id, data, filter_data, super, sub_category){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    output$text <- renderText({
      
      if(is.null(sub_category)){
        
        req(super())
        
        calc_table <- calculate_table(table_data = filter_data(),
                                      code_column = "Crit",
                                      category_table = data()$criticality,
                                      join_lookup = c("Crit" = "Number"),
                                      count_column = "Criticality")
        
        row_selected <- calc_table$Category[super()]
        
        return(
          show_text(data = filter_data(), question_type = "Crit",
                    super_category = row_selected,
                    sub_category = NULL,
                    category_table = data()$criticality,
                    join_lookup = c("Crit" = "Number")
          )
        )
      }
      
      req(sub_category())
      
      first_table <- calculate_table(table_data = filter_data(),
                                     code_column = "Code",
                                     category_table = data()$categories,
                                     join_lookup = c("Code" = "Number"),
                                     count_column = "Super", 
                                     click_column = NULL)
      
      first_row_selected <- first_table$Category[super()]
      
      second_table <- calculate_table(table_data = filter_data(),
                                      code_column = "Code",
                                      category_table = data()$categories,
                                      join_lookup = c("Code" = "Number"),
                                      count_column = "Category", 
                                      click_column = first_row_selected)
      
      second_row_selected <- second_table$Category[sub_category()]
      
      show_text(data = filter_data(), question_type = "Code", 
                super_category = first_row_selected, 
                sub_category = second_row_selected,
                category_table = data()$categories,
                join_lookup = c("Code" = "Number")
      )
    })
  })
}
