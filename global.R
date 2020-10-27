library(gapminder)
library(dplyr)

youth <- read.table("data/youth_cont.csv" , header = TRUE , sep = ',')
jeunes_morts <- read.table("data/jeunes_morts_cont.csv" , header = TRUE , sep = ',')

valeur_max <- aggregate(jeunes_morts,by=list(jeunes_morts$Country,jeunes_morts$Year),FUN=max)
data_clear <- valeur_max
data_clear <- select(data_clear,-c(X,Unnamed..0_x,Data.type,Unnamed..0_y))
data_clear2 <- data_clear[!(data_clear$Country=="Iceland"),]
data_clear3 <- select(data_clear2,-c(Group.1,Group.2))

mapped_data <- joinCountryData2Map(data_clear3[1:32,],joinCode="ISO3",nameJoinColumn = "COUNTRY")

europe <- data_clear3[(data_clear3$Continent=="EU"),]

EuropeYear<-function(df,YearSelect){ return(joinCountryData2Map(df[(df$Year==YearSelect),],joinCode="ISO3",nameJoinColumn = "COUNTRY"))}

year <- unique(europe$Year)
