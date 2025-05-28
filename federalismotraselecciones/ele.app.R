

library(shiny)

source("controlesmapas.R")


ui <- fluidPage(
  
  h1("Evolución del mapa político de gubernaturas en México, 1995-2022"),
  
  fluidRow(
    wellPanel(
      leafletOutput("mapa", height = "80vh"),
    sliderInput("sel_anio",
               label = "Año",
               min = 1995, max = 2022, value = 2016, step = 3)
  ))
  
)

server <- function(input, output, session) {
  
  output$mapa <- renderLeaflet({
    gen_map(input$sel_anio)
  })
  
}

shinyApp(ui, server)
