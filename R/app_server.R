#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here
  ship_type <- callModule(
    mod_ship_type_selector_server,
    "ship_type_selector_ui"
  )
  
  ship_selector <- callModule(
    mod_ship_selector_server,
    "ship_selector_ui",
    ship_type
  )
  callModule(ship_type, ship_selector)
}
