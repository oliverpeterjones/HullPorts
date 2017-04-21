# load in data
load("./Data/demandData.RData")

# load packages
library(dplyr)
library(ggplot2)

# grouping data by year and category - and summing
CategoryYearData <- demandData %>%
  group_by(Year, `Cargo Category Description`) %>%
  summarise(Total = sum(`Total (thousand tonnes)`))

# load in oil prices
load("./Data/OP.RData")

# join the two data frames together
Data <- full_join(CategoryYearData, OP, by="Year")

# grouping data by year and summarising to find total total per year and the oil price
SumData <- Data %>%
  group_by(Year) %>%
  summarise(Total2 = sum(Total), OilPrice2 = mean(OilPrice))

# plotting data with line
ggplot(data=SumData, aes(y=Total2, x=OilPrice2)) +
  geom_point() +
  geom_smooth(method="lm") +
  labs(y="Sea Feight Demand through the Port of Hull (Thousands of Tonnes)", x="Crude Oil Price ($)")

# finding the regression line
lm(Total2 ~ OilPrice2, data=SumData)
