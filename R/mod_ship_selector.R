# Module UI

#' @title   mod_ship_selector_ui and mod_ship_selector_server
#' @description  A shiny Module.
#'
#' @param id shiny id
#' @param input internal
#' @param output internal
#' @param session internal
#'
#' @rdname mod_ship_selector
#'
#' @keywords internal
#' @export 
#' @importFrom shiny NS tagList 

mod_ship_selector_ui <- function(id){
  ns <- NS(id)
  tagList(
    segment(
      shiny.semantic::selectInput(
        ns("selected_ship"),
        label = "Select a ship",
        choices = c("Neptinus", "Lexus", "Scorpius")
      )
    )
  )
}

# Module Server

#' @rdname mod_ship_selector
#' @export
#' @keywords internal

mod_ship_selector_server <- function(input, output, session, ship_type){
  ns <- session$ns
  
  ships <- ShipsApp::ships
  #vessel_choices <- ships[ships$ship_type == vessel_type(), "ship_name"]
  ship_choices <- reactive({
    unique(
      ships[ships$ship_type == ship_type(), "ship_name", drop = TRUE]
    )
  })
  
  observe({
    updateSelectInput(
      session,
      "selected_ship",
      choices = ship_choices()
    )
  })
  
  reactive({
    input$selected_ship
  })
  
}