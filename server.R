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


  #Creation d'une carte avec des données
output$AlcoolTotalMap <- renderLeaflet({
                                    df <- AlcoolMap
                                    bins <- c(0,10,20,30,40,50,60,70,80,90,100)
                                    views <- ContinentFrancais(input$Continent1)
                                    Data <- switch(input$Data,"BothSexes"=df$BothSexes,"Male"=df$Male,"Female"=df$Female)
                                    palData <- switch(input$Data,"BothSexes"=~pal(BothSexes),"Male"=~pal(Male),"Female"=~pal(Female))
                                    print(Data)
                                    pal <- colorBin("Reds", domain = df, bins = bins)
                                    labels <- sprintf(
                                      "<strong>%s</strong><br/>Taux de personnes buvant de l'alcool: %g",
                                      df$Country, Data
                                    ) %>%
                                    lapply(htmltools::HTML)

                                    leaflet()%>%
                                    addTiles()%>%
                                    setView(as.numeric(views[3]),as.numeric(views[2]), zoom = 3)%>%
                                    addPolygons(data=df,fillColor= palData,
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
                                  addLegend("topleft",pal=pal,values=Data,title=paste("Taux de personnes buvant de <br>l'alcool en <br>",views[1]),opacity = 0.5)

                                 })

#Creation d'une carte avec des données
 output$AlcoolTotalMap1 <- renderLeaflet({
                                     df <- AlcoolMap
                                     bins <- c(0,10,20,30,40,50,60,70,80,90,100)
                                     Data <- switch(input$Data1,"BothSexes"=df$BothSexes,"Male"=df$Male,"Female"=df$Female)
                                     palData <- switch(input$Data1,"BothSexes"=~pal(BothSexes),"Male"=~pal(Male),"Female"=~pal(Female))
                                     print(Data)
                                     pal <- colorBin("Reds", domain = df, bins = bins)
                                     labels <- sprintf(
                                       "<strong>%s</strong><br/>Taux de personnes buvant de l'alcool: %g",
                                       df$Country, Data
                                     ) %>%
                                     lapply(htmltools::HTML)

                                     leaflet()%>%
                                     addTiles()%>%
                                     setView(0,0,zoom=1.2)%>%
                                     addPolygons(data=df,fillColor= palData,
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
                                   addLegend("topleft",pal=pal,values=Data,title="Taux de personnes buvant de <br>l'alcool",opacity = 0.5)

                                  })



 #Creation d'une carte avec des données
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
  #Creation d'une carte avec des données
  output$tolerancemap <- renderLeaflet({
                                    df <- toleranceMap
                                    bins <- c(0,0.01, 0.02,0.03,0.04,0.05,0.06,0.07,0.08,0.09,0.1)
                                    views <- ContinentFrancais(input$Continent)
                                    pal <- colorBin("Reds", domain = df, bins = bins)
                                    labels <- sprintf(
                                      "<strong>%s</strong><br/>Taux d'alcool: %g ",
                                      df$Country, df$tolerance
                                    ) %>%
                                    lapply(htmltools::HTML)

                                    leaflet()%>%
                                    addTiles()%>%
                                    setView(as.numeric(views[3]),as.numeric(views[2]), zoom = 3)%>%
                                    addPolygons(data=df,fillColor= ~pal(tolerance),
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
                                  addLegend("bottomright",pal=pal,values=df$tolerance,title=paste("Tolerance d'Alcool en <br>",views[1]),opacity = 1)
                                  })

    #Création d'un histogramme pour afficher les jeunes morts
    output$hist_pays <- renderPlot({
                                 df <- data_clear3[(data_clear3$Country == input$pays_hist),]
                                 ggplot(df) + geom_histogram(aes(x = Year , y = Value) , stat = 'identity')
                                 })

   # Création d'un menu déroulant qui prend en choix les pays disponibles
    output$pays_hist <- renderUI({
                                df <- data_clear3[(data_clear3$Continent==input$continent2),]
                                choix <- unique(df$Country)
                                selectInput("pays_hist",
                                            label = "Choix du pays",
                                            choices = choix
                                            )
                                })

   # création d'un histogramme qui affiche selon le choix d'un menu déroulant la consommation moyenne d'alcool par continents 
   output$HistAlcool <- renderPlot({
                                df <- youthMeanContinent
                                t <- switch(input$DataAlcool,
                                            "BothSexes" = geom_bar(aes(x = Continent , y = BothSexes, fill = BothSexes),position="dodge",stat = 'identity'),
                                            "Male" = geom_bar(aes(x = Continent , y = Male, fill = Male),position="dodge",stat = 'identity'),
                                            "Female" = geom_bar(aes(x = Continent , y = Female, fill = Female),position="dodge",stat = 'identity')
                                            )
                                ggplot(df) + t
                                })

}
