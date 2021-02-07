# Module UI

#' @title   mod_ship_type_selector_ui and mod_ship_type_selector_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_ship_type_selector
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 
mod_ship_type_selector_ui <- function(id){
  ns <- NS(id)
  tagList(
    segment(
      shiny.semantic::selectInput(
        ns("selected_ship_type"),
        label = "Select a ship type",
        choices = !duplicated(ShipsApp::ships$ship_type)
      )
    )
  )
}

# Module Server

#' @rdname mod_ship_type_selector
#' @export
#' @keywords internal

mod_ship_type_selector_server <- function(input, output, session){
  ns <- session$ns
  
  reactive({
    input$selected_ship_type
  })
}
