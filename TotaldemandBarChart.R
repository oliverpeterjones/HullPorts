load("./Data/demandData.RData")

library(ggplot2)
library(dplyr)

# removing ores and liqufied gas
sData2 <- demandData %>%
  filter(`Cargo Category Description` != "Ores" & `Cargo Category Description` != "Liquefied gas")

# tidying data into useful format
sData <- sData2 %>%
  group_by(Year, `Cargo Category Description`) %>%
  summarise(Total = sum(`Total (thousand tonnes)`))

# Plotting graph - bar chart
ggplot()+
  geom_bar(aes(x = Year, y = Total, fill=`Cargo Category Description`),
           data = sData, stat = "identity") +
  labs(y= "Total (Thousands of Tonnes)") +
  scale_fill_brewer(palette = "Set1")
