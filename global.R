library(gapminder)
library(dplyr)
library(rworldmap)


# Traitement de la donnée sur la consommation d'alcool
youth <- read.csv("data/youth_cont.csv" , header = TRUE , sep = ',')
names(youth)[names(youth)=="X15.19.years.old..current.drinkers.both.sexes...."]<-"BothSexes"
names(youth)[names(youth)=="X15.19.years.old..current.males.drinkers...."]<-"Male"
names(youth)[names(youth)=="X15.19.years.old..current.females.drinkers...."]<-"Female"
names(youth)[names(youth)=="Alpha.3.code"]<-"code"
YouthClear <- select(youth,-c(X,Unnamed..0))
AlcoolMap <- joinCountryData2Map(YouthClear,joinCode="ISO3",nameJoinColumn="code")
youthMeanContinent <- aggregate(YouthClear,by=list(YouthClear$Continent),FUN=mean)
youthMeanContinent <- select(youthMeanContinent,-c(Country,code,Continent,Year))
names(youthMeanContinent)[names(youthMeanContinent)=="Group.1"]<-"Continent"
youthMeanContinent[1,1]<-"Amerique du nord"
youthMeanContinent[2,1]<-"Afrique"
youthMeanContinent[3,1]<-"Asie"
youthMeanContinent[4,1]<-"Europe"
youthMeanContinent[5,1]<-"Oceanie"
youthMeanContinent[6,1]<-"Amerique du sud"

# Traitement de la donnée sur le nombres de jeunes morts
jeunes_morts <- read.table("data/jeunes_morts_cont.csv" , header = TRUE , sep = ',')
valeur_max <- aggregate(jeunes_morts,by=list(jeunes_morts$Country,jeunes_morts$Year),FUN=max)
data_clear <- valeur_max
data_clear <- select(data_clear,-c(X,Unnamed..0_x,Data.type,Unnamed..0_y))
data_clear2 <- data_clear[!(data_clear$Country=="Iceland"),]
data_clear3 <- select(data_clear2,-c(Group.1,Group.2))
mapped_data <- joinCountryData2Map(data_clear3[1:32,],joinCode="ISO3",nameJoinColumn = "COUNTRY")
europe <- data_clear3[(data_clear3$Continent=="EU"),]

#traitement des données sur la tolérance en consommation d'alcool pour les jeunes conducteurs
tolerance <- read.csv("data/tolerance_compl.csv")
names(tolerance)[names(tolerance)=="Legal.blood.alcohol.concentration..BAC..limits.for.young.novice.drivers"] <- "tolerance"
names(tolerance)[names(tolerance)=="Alpha.3.code"]<-"code"
toleranceMap <- joinCountryData2Map(tolerance,joinCode="ISO3",nameJoinColumn="code")



#  Création des données géographiques en fonction d'une année choisie
DataYear<-function(df,YearSelect){ return(joinCountryData2Map(df[(df$Year==YearSelect),],joinCode="ISO3",nameJoinColumn = "COUNTRY"))}

# Liste des pays disponibles
pays <- unique(jeunes_morts$Country)
# liste des années disponibles
year <- unique(europe$Year)
# Listes des continents disponibles sans amérique du nord
Continent1 <- unique(data_clear3$Continent)
# Liste des continents disponibles avec l'amérique du nord
Continent <- c(unique(data_clear3$Continent),"NA")
# Fonction qui associe les continents à leur données géographiques, prend en parametre une string et renvoi un nom en francais ainsi que des coordonnées
ContinentFrancais<- function(list){
                        if(list=="NA"){
                          name <- "Amerique du nord"
                          CoorX <- 54.526
                          CoorY <- -105.2551
                          return (c(name=name,X=CoorX,Y=CoorY))
                        }
                        else if(list=="SA"){
                          name <- "Amerique du sud"
                          CoorX <- -8.7832
                          CoorY <- -55.4915
                          return (c(name=name,X=CoorX,Y=CoorY))
                        }
                        else if(list=="OC"){
                        name <- "Oceanie"
                        CoorX <- -22.7359
                        CoorY <- 140.0187
                        return (c(name=name,X=CoorX,Y=CoorY))
                        }
                        else if(list=="AS"){
                        name <- "Asie"
                        CoorX <- 34.0479
                        CoorY <- 100.6197
                        return (c(name=name,X=CoorX,Y=CoorY))
                        }
                        else{
                         name <- "Europe"
                         CoorY <- 17.23
                         CoorX <- 56.31
                         return (c(name=name,X=CoorX,Y=CoorY))
                        }
                  }
