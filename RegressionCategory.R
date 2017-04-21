# removing e notation
options(scipen=999)

# load packages
library(dplyr)
library(ggplot2)

# load catagory
load("Data/Agriculturalv2.RData")
load("Data/Coal.RData")
load("Data/Iron.RData")
load("Data/Forestry.RData")
load("Data/Oil.RData")
load("Data/Otherdb.RData")
load("Data/Othergc.RData")
load("Data/Otherlb.RData")

# load in OP
load("./Data/OP.RData")
# load in GDP
load("./Data/GDP.RData")
# load in inflation
load("Data/inflation.RData")
# load in fxrate
load("Data/fxrate.RData")
# load in GVA
load("Data/GVA.RData")
# load in WTrade
load("Data/WTrade.RData")
# load in Interest Rates
load("Data/Interest.RData")


# merge data
AllData <- join_all(list(Agricultural, OP, GDP, Inflation, FXRate, GVA, WTrade, Interest), by = "Year", type = "full")

# Regressiom analysis 
x8 <- lm(data=AllData, Agricultural ~ OilPrice + `FX Rate` + `Inflation ` + `GVA(£Millions)` + `World Trade -  Imports (Trillion of $)` + `Interest Rates`)
summary(x8)

x9 <- lm(data=AllData, Agricultural ~ OilPrice + `FX Rate` + `Inflation ` + `World Trade -  Imports (Trillion of $)` + `Interest Rates`)
summary(x9)