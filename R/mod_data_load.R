#' data_load UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_data_load_ui <- function(id){
  ns <- NS(id)
  tagList(
    
    # no UI
  )
}

#' data_load Server Functions
#'
#' @noRd 
mod_data_load_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    
    staff_data <- load_staff_data("staff_data.csv")
    
    categories <- load_categories()
    
    reactive({
      
      list(staff_data = staff_data,
           categories = categories)
    })
    
  })
}

## To be copied in the UI
# mod_data_load_ui("data_load_ui_1")

## To be copied in the server
# 
