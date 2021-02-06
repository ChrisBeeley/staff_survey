#' click_tables UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_click_tables_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    fluidRow(
      shinydashboard::box(DT::DTOutput(ns("themes")),
          DT::DTOutput(ns("subThemes")))
      
      # box(
      #   title = "Comments",
      #   downloadButton(ns("downloadComments"), "Download all comments"),
      #   downloadButton(ns("downloadCategoryComments"), 
      #                  "Download all comments from category"),
      #   htmlOutput(ns("showComments"))
      # )
    )
  )
}

#' click_tables Server Functions
#'
#' @noRd 
mod_click_tables_server <- function(id, data, count_column, click = NULL){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    output$themes <- DT::renderDT({
      
      calculated_table <- calculate_table(table_data = data()$staff_data,
                                          code_column = "BestCode",
                                          category_table = data()$categories,
                                          join_lookup = c("BestCode" = "Number"),
                                          count_column = count_column)
      
      
      DT::datatable(calculated_table,
                    selection = 'single', rownames = FALSE, extensions = 'Buttons', 
                    options = list(pageLength = 5, lengthMenu = c(5, 10),
                                   dom = 'Blfrtip',
                                   buttons = c('copy', 'csv', 'excel', 'pdf', 'print')))
    })
    
    reactive(
      input$themes_rows_selected
    )
  })
}

## To be copied in the UI
# 

## To be copied in the server
# 
