library(shiny)
library(gapminder)
library(dplyr)
library(ggplot2)
library(shinydashboard)


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Alcool", tabName = "Alcool", icon = icon("dashboard")),
    menuItem("Accident et législation", icon = icon("th"), tabName = "Accidentetlégislation")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Alcool",
      h2("Dashboard tab content"),
      fluidRow(
          box(plotOutput("plot1", height = 250)),

          box(
            title = "Controls",
            sliderInput("slider", "Number of observations:", 1, 100, 50)
          )
        )
    ),

    tabItem(tabName = "Accidentetlégislation",
      h2("Widgets tab content")
    )
  )
)

# Put them together into a dashboardPage
dashboardPage(
  dashboardHeader(title = "Visualisation"),
  sidebar,
  body,
  skin = "black"
)