#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @import shinydashboard
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    dashboardPage(
      dashboardHeader(title = "Staff survey"),
      dashboardSidebar(
        sidebarMenu(
          menuItem("Themes", tabName = "themes", icon = icon("dashboard")),
          menuItem("Criticality", tabName = "criticality", icon = icon("th"))
        ),
        uiOutput("directorate"),
        selectInput("question", "Thing to improve or best thing", 
                    choices = c("Thing to improve" = "Improve", "Best thing" = "Best"))
      ),
      dashboardBody(
        
        tabItems(
          
          tabItem(tabName = "themes",
                  fluidRow(
                    column(6, 
                           mod_click_tables_ui("click_tables_ui_1"),
                           mod_click_tables_ui("click_tables_ui_2")),
                    column(6,
                           mod_show_text_ui("show_text_ui_1"))
                  )
          ),
          tabItem(tabName = "criticality",
                  fluidRow(
                    column(6, 
                           mod_click_crit_ui("click_crit_ui_1")))
          )
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
  
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'staffSurveyNew'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

