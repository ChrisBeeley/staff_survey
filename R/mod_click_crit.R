#' click_crit UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_click_crit_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    DT::DTOutput(ns("criticality"))
  )
}

#' click_crit Server Functions
#'
#' @noRd 
mod_click_crit_server <- function(id, data, filter_data){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    output$criticality <- DT::renderDT({
      
      calculated_table <- calculate_table(table_data = filter_data(),
                                          code_column = "Crit",
                                          category_table = data()$criticality,
                                          join_lookup = c("Crit" = "Number"),
                                          count_column = "Criticality")
      
      DT::datatable(calculated_table,
                    selection = 'single', rownames = FALSE, extensions = 'Buttons', 
                    options = list(pageLength = 10, lengthMenu = c(5, 10),
                                   dom = 'Blfrtip',
                                   buttons = c('copy', 'csv', 'excel', 'pdf', 'print')))
    })
    
    reactive(
      input$criticality_rows_selected
    )
    
  })
}
