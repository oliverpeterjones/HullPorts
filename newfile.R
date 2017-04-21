load("./Data/demandData.RData")

library(ggplot2)
library(dplyr)

# tidying data into useful format
summarisedData <- demandData %>%
  group_by(Year, `Cargo Category Description`) %>%
  summarise(Total = sum(`Total (thousand tonnes)`))

# TODO - title, y-axis title, possible colour change USEFUL GRAPH *******
g <- ggplot()+
  geom_bar(aes(x = Year, y = Total, fill=`Cargo Category Description`),
           data = summarisedData, stat = "identity")
# scale_colour_manual( ... "Agricultura...." = "Blue")
# choose colours http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf

# useful data frame of total demand per year
TotalDemandPerYear <- demandData %>% 
  group_by(Year) %>%
  summarise(Demand = sum(`Total (thousand tonnes)`))

# total demand per year for coal
newData <- demandData %>% 
  filter(`Cargo Category Description` == "Coal") %>%
  group_by(Year) %>%
  summarise(Total = sum(`Total (thousand tonnes)`))

#plotting the graph
ggplot() +
  geom_point(aes(x = Year, y = Total), data = newData) 

