#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  
  output$directorate <- renderUI({
    
    selectInput("directorate", "Directorate (defaults to all)", 
                choices = unique(load_data()$staff_data$Directorate),
                multiple = TRUE)
  })
  
  filter_data <- reactive({
    
    df <- load_data()$staff_data
    
    if(!is.null(input$directorate)){
      
      df <- df %>% 
        dplyr::filter(Directorate == input$directorate)
    }
    
    df <- df %>% 
      dplyr::filter(type == input$question)
    
    return(df)
  })
  
  load_data <- mod_data_load_server("data_load_ui_1")
  
  clicked <- mod_click_tables_server("click_tables_ui_1", 
                                     data = load_data, count_column = "Super", 
                                     click = NULL, filter_data = filter_data)
  
  show_text <- mod_click_tables_server("click_tables_ui_2", 
                                       data = load_data, count_column = "Category", 
                                       click = clicked, filter_data = filter_data)
  
  # mod_show_text_server("show_text_ui_1", data = load_data, 
  #                      count_column = "Category", 
  #                      super = clicked,
  #                      sub_category = show_text)
}
