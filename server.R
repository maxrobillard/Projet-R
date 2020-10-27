library(shiny)
library(tidyverse)
library(ggplot2)
library(gapminder)
library(ggmap)
library(dplyr)
library(rworldmap)
library(viridis)

library(leaflet)

source("global.R")

bins <- c(20, 100, 500,1000,1500, 2000,2500,4000,5000,6000,7000,8000,9000,10000)
pal <- colorBin("Reds", domain = mapped_data_europe, bins = bins)

labels <- sprintf(
  "<strong>%s</strong><br/>Nbr de mort: %g ",
  mapped_data_europe$Country, mapped_data_europe$Value
) %>% lapply(htmltools::HTML)

function(input, output) {


    set.seed(122)
  histdata <- rnorm(500)

  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
  #Create the mymap
  output$mymap <- renderPlot({mapCountryData(mapped_data_europe,
                                nameColumnToPlot = "Value",
                                numCats=100,
                                mapRegion="europe",
                                catMethod = "categorical",
                                colourPalette = viridis(31),
                                oceanCol = "white",
                                addLegend = FALSE,

                                )
                              })

  output$mymap1 <- renderLeaflet({
                                    leaflet()%>%
                                    addTiles()%>%
                                    setView(17.23,56.31, zoom = 3)%>%
                                    addPolygons(data=mapped_data_europe,fillColor= ~pal(Value),
                                    weight = 2,
                                    opacity = 1,
                                    color = "white",
                                    dashArray = "3",
                                    fillOpacity = 0.7,
                                    highlight = highlightOptions(
                                      weight = 5,
                                      color = "#666",
                                      dashArray = "",
                                      fillOpacity = 0.7,
                                      bringToFront = TRUE),
                                    label = labels,
                                      labelOptions = labelOptions(
                                        style = list("font-weight" = "normal", padding = "3px 8px"),
                                        textsize = "15px",
                                        direction = "auto")
                                  )%>%
                                  addLegend("bottomright",pal=pal,values=mapped_data_europe$Value,title="Nombre de mort",opacity=1)
                                  })


}
