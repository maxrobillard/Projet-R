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

heightBoxes <- 300
heightBoxesMap <- 600

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Alcool", tabName = "Alcool", icon = icon("cocktail")),
    menuItem("Accident et législation", icon = icon("car-crash"), tabName = "Accidentetlégislation")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Alcool",
      h2("Visualisation sur la consommation d'alcool"),
        fluidRow(
          box(height = heightBoxesMap,
            title = "Visualisation du pourcentage d'habitant consommant de l'alcool ",
            status = "warning",
            solidHeader = TRUE,
            leafletOutput("AlcoolTotalMap"),
            selectInput("Continent1",
                    label = "Choix d'un continent",
                    choices = Continent,
                    selected = "NA"),
            selectInput("Data",
                    label = "Choix des données",
                    choices = c("Tout le monde" = "BothSexes","Hommes" = "Male","Femmes"="Female"),
                    selected = "Tout le monde")
          ),
          box(height = heightBoxesMap,
            title = "Visualisation du pourcentage d'habitant consommant de l'alcool vue mondiale",
            status = "warning",
            solidHeader = TRUE,
            leafletOutput("AlcoolTotalMap1"),
            selectInput("Data1",
                    label = "Choix des données",
                    choices = c("Tout le monde" = "BothSexes","Hommes" = "Male","Femmes"="Female"),
                    selected = "Tout le monde")
          )
        ),
        fluidRow(
                box(width=12,
                  status = "warning",
                  selectInput("DataAlcool",
                          label = "Choix des données",
                          choices = c("Tout le monde" = "BothSexes","Hommes" = "Male","Femmes"="Female"),
                          selected = "Tout le monde"),
                  plotOutput("HistAlcool")
                )
        ),
      ),
  #-------------- Deuxième   page ------------#

    tabItem(tabName = "Accidentetlégislation",
      h2("Visualisation sur le nombre d'accident et la législation sur le taux d'alcoolémie"),
      fluidRow(
        column(width=6,
            box(width=12,
                height =heightBoxes,
                status = "warning",
              sliderInput("var",
                    label = "Choix d'une année",
                    min = year[1],
                    max = year[length(year)],
                    value = year[1],
                    step=1,
                    animate = TRUE,
                    sep=" "

                    ),
                selectInput("Continent",
                        label = "Choix d'un continent",
                        choices = Continent,
                        selected = "NA"),),
            box(width=12,
              title = "Visualisation du nombre de morts par accident de voiture",
              status = "warning",
              solidHeader = TRUE,
              leafletOutput("mymap1")
            ),

        ),

        column(width=6,
          box(width =12,
              status = "warning",
              height =heightBoxes,
              selectInput("continent2",
                          label = "Choix d'un continent",
                          choices = Continent1,
                          selected = 'EU'
              ),
            uiOutput("pays_hist")

          ),
          box(
              width = 12,
              title = "Visualisation du nombre de morts par accident de voiture",
              status = "warning",
              solidHeader = TRUE,
              plotOutput("hist_pays"))
        )

      ),
      fluidRow(
        column(width=12,
          box(width=12,
            title = "Visualisation du taux d'alcoolémie autorisé pour un jeune conducteur en 2016",
            status = "warning",
            solidHeader = TRUE,
          leafletOutput("tolerancemap")
      ))
    )
    )
  )

)

# CRéation du dashboard 
dashboardPage(
  dashboardHeader(title = "Visualisation"),
  sidebar,
  body,
  skin = "yellow"
)
