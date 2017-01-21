library(readxl)
demandData <- read_excel("./Data/Hull Port - 2000-2015 - types data.xlsx")

# making each column the correct data type

# removing the Major Port, country of origin, (general) cargo category column removed
demandData <- demandData[-c(2, 3, 4, 7)]
# Keeeping the Years as integer numbers, and making them into factors for each year
demandData$Year <- as.factor(as.integer(demandData$Year))
# making sure that total is kept to 3dp (i.e 4 digits)
demandData$`Total (thousand tonnes)` <- round(demandData$`Total (thousand tonnes)`, 4)
# create factor groups for (general) cargo category decription columns
demandData$`Cargo Category Description` <- as.factor(demandData$`Cargo Category Description`)
demandData$`General Cargo Category Description` <- as.factor(demandData$`General Cargo Category Description`)


library(ggplot2)
library(dplyr)

# tidying data into useful format
summarisedData <- demandData %>%
  group_by(Year, `Cargo Category Description`) %>%
  summarise(Total = sum(`Total (thousand tonnes)`))

# TODO - title, y-axis title, possible colour change
g <- ggplot()+
  geom_bar(aes(x = Year, y = Total, fill=`Cargo Category Description`),
           data = summarisedData, stat = "identity")

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

