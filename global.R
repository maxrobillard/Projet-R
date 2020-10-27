library(gapminder)
library(dplyr)

youth <- read.table("data/youth_cont.csv" , header = TRUE , sep = ',')
jeunes_morts <- read.table("data/jeunes_morts_cont.csv" , header = TRUE , sep = ',')
tolerance <- read.table("data/tolerance_compl.csv",header = TRUE, sep=',')

valeur_max <- aggregate(jeunes_morts,by=list(jeunes_morts$Country,jeunes_morts$Year),FUN=max)
data_clear <- valeur_max
data_clear <- select(data_clear,-c(X,Unnamed..0_x,Data.type,Unnamed..0_y))
data_clear2 <- data_clear[!(data_clear$Country=="Iceland"),]
data_clear3 <- select(data_clear2,-c(Group.1,Group.2))

mapped_data <- joinCountryData2Map(data_clear3[1:32,],joinCode="ISO3",nameJoinColumn = "COUNTRY")

europe <- data_clear3[(data_clear3$Continent=="EU"),]


DataYear<-function(df,YearSelect){ return(joinCountryData2Map(df[(df$Year==YearSelect),],joinCode="ISO3",nameJoinColumn = "COUNTRY"))}

year <- unique(europe$Year)
Continent <- c(unique(data_clear3$Continent),"NA")
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
