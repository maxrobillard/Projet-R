library(shiny)
library(gapminder)
library(dplyr)
library(ggplot2)
library(shinydashboard)
library(tidyverse)
library(ggmap)
library(rworldmap)
library(viridis)

library(riskyr)
library(leaflet)
source("global.R")

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Alcool", tabName = "Alcool", icon = icon("dashboard")),
    menuItem("Accident et législation", icon = icon("th"), tabName = "Accidentetlégislation")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Alcool",
      h2("Visualisation sur la consommation d'alcool"),
      fluidRow(
          box(status="warning",plotOutput("plot1", height = 250)),

          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          ),
        ),
        fluidRow(
            box(plotOutput(outputId = "mymap")),
        ),
      ),
    tabItem(tabName = "Accidentetlégislation",
      h2("Widgets tab content"),
      fluidRow(
          box(leafletOutput("mymap1")),
      ),
    )
  )

)

# Put them together into a dashboardPage
dashboardPage(
  dashboardHeader(title = "Visualisation"),
  sidebar,
  body,
  skin = "red"
)
