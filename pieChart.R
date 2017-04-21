load("./Data/demandData.RData")

library(ggplot2)
library(dplyr)
library(scales)
library(RColorBrewer)

# removing ores and liqufied gas
sData2 <- demandData %>%
  filter(`Cargo Category Description` != "Ores" & `Cargo Category Description` != "Liquefied gas")

# tidying data into useful format
sData <- sData2 %>%
  group_by(`Cargo Category Description`) %>%
  summarise(Total = sum(`Total (thousand tonnes)`))

# creating a blank theme
blank_theme <- theme_minimal()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank(),
    panel.border = element_blank(),
    panel.grid=element_blank(),
    axis.ticks = element_blank(),
    plot.title=element_text(size=14, face="bold")
  )

# Plotting graph - pie chart
ggplot(sData, aes(x="", y=Total, fill=`Cargo Category Description`))+
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start=0) +
  blank_theme +
  theme(axis.text.x=element_blank()) +
  scale_fill_brewer(palette = "Set1")
