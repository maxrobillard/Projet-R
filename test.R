library(tidyverse)
library(ggplot2)
library(gapminder)
library(ggmap)
library(dplyr)
library(rworldmap)
library(viridis)

youth <- read.csv("data/youth_cont.csv" , header = TRUE , sep = ',')
jeunes_morts <- read.table("data/jeunes_morts_cont.csv" , header = TRUE , sep = ',')

valeur_max <- aggregate(jeunes_morts,by=list(jeunes_morts$Country,jeunes_morts$Year),FUN=max)
data_clear <- valeur_max
data_clear <- select(data_clear,-c(X,Unnamed..0_x,Data.type,Unnamed..0_y))
data_clear2 <- data_clear[!(data_clear$Country=="Iceland"),]
data_clear3 <- select(data_clear2,-c(Group.1,Group.2))
mapped_data <- joinCountryData2Map(data_clear3[1:32,],joinCode="ISO3",nameJoinColumn = "COUNTRY")
mapCountryData(mapped_data,nameColumnToPlot = "Value",numCats=100,mapRegion="europe",catMethod = "categorical",colourPalette = viridis(31))
europe <- data_clear3[(data_clear3$Continent=="EU"),]
mapped_data_europe <- joinCountryData2Map(europe[(europe$Year==2000),],joinCode="ISO3",nameJoinColumn = "COUNTRY")
mapCountryData(mapped_data_europe,nameColumnToPlot = "Value",numCats=100,mapRegion="europe",catMethod = "categorical",colourPalette = viridis(31),oceanCol = "white")
data <- switch("2000","2000"=mapped_data_europe,"2001"=mapped_data_europe1)
df <- reactive({europe[(europe$Year==2000)]})
year <- unique(europe$Year)
Continent <- unique(data_clear3$Continent)
tolerance <- read.table("data/tolerance_compl.csv",header = TRUE, sep=',')
names(tolerance)[names(tolerance)=="Legal.blood.alcohol.concentration..BAC..limits.for.young.novice.drivers"] <- "tolerance"
toleranceMap <- joinCountryData2Map(tolerance,joinCode="ISO3",nameJoinColumn="code")
tolerance2<-read.csv("data/tolerance_compl.csv")
names(youth)[names(youth)=="X15.19.years.old..current.drinkers.both.sexes...."]<-"BothSexes"
names(youth)[names(youth)=="X15.19.years.old..current.males.drinkers...."]<-"Male"
names(youth)[names(youth)=="X15.19.years.old..current.females.drinkers...."]<-"Female"
names(youth)[names(youth)=="Alpha.3.code"]<-"code"
YouthClear <- select(youth,-c(X,Unnamed..0))
AlcoolMap <- joinCountryData2Map(YouthClear,joincode="ISO3",namedJoinColumn="code")

youthMeanContinent <- aggregate(YouthClear,by=list(YouthClear$Continent),FUN=mean)
youthMeanContinent <- select(youthMeanContinent,-c(Country,code,Continent,Year))
names(youthMeanContinent)[names(youthMeanContinent)=="Group.1"]<-"Continent"
