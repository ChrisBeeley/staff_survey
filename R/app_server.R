#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  
  load_data <- mod_data_load_server("data_load_ui_1")
  
  clicked <- mod_click_tables_server("click_tables_ui_1", 
                          data = load_data, count_column = "Super", click = NULL)
  
  mod_click_tables_server("click_tables_ui_2", 
                          data = load_data, count_column = "Category", click = clicked)
}
