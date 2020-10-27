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
                                    df <- DataYear(data_clear3,input$var)
                                    bins <- c(100, 500,1000,1500, 2000,2500,4000,5000,6000,7000,7500,8000,9000,10000,11000,20000,40000,45000)
                                    views <- ContinentFrancais(input$Continent)
                                    pal <- colorBin("Reds", domain = df, bins = bins)
                                    labels <- sprintf(
                                      "<strong>%s</strong><br/>Nbr de mort: %g ",
                                      df$Country, df$Value
                                    ) %>%
                                    lapply(htmltools::HTML)

                                    leaflet()%>%
                                    addTiles()%>%
                                    setView(as.numeric(views[3]),as.numeric(views[2]), zoom = 3)%>%
                                    addPolygons(data=df,fillColor= ~pal(Value),
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
                                  addLegend("bottomright",pal=pal,values=df$Value,title=paste("Nombre de mort en <br>",views[1],"en ",input$var),opacity = 1)
                                  })


}
