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
    
    where_am_i <- get_golem_config("where")
    
    if(where_am_i == "github"){
      
      staff_data <- readRDS(
        system.file("extdata", "staff_data.rds", package = "staffSurveyNew"))
      
      categories <- readRDS(
        system.file("extdata", "categories.rds", package = "staffSurveyNew"))
      
      criticality <- readRDS(
        system.file("extdata", "criticality.rds", package = "staffSurveyNew"))
    } else {
      
      staff_data <- load_staff_data("staff_data.csv")
      
      categories <- load_categories()
      
      criticality <- data.frame(
        Number = -3 : 3, 
        Criticality = c("Highly critical", "Fairly critical", 
                        "Somewhat critical", "Not critical",
                        "Slightly positive", "Somewhat positive",
                        "Very positive")
      )
    }
    
    reactive({
      
      list(staff_data = staff_data,
           categories = categories,
           criticality = criticality)
    })
    
  })
}

## To be copied in the UI
# mod_data_load_ui("data_load_ui_1")
