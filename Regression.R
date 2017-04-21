# removing e notation
options(scipen=999)

# load in TQD
load("./Data/TQD.RData")
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
# load in Interest
load("Data/Interest.RData")

# load packages
library(plyr)
library(dplyr)

AllData <- join_all(list(TQD, OP, GDP, Inflation, FXRate, GVA, WTrade, Interest), by = "Year", type = "full")

x <- lm(data=AllData, TotalQuantity ~ OilPrice + `GDP(£Millions)`)
summary(x)

lm(data=AllData, TotalQuantity ~ OilPrice + `GDP(£Millions)` + `FX Rate`)

lm(data=AllData, TotalQuantity ~ OilPrice + `GDP(£Millions)` + `FX Rate` + `Inflation `)

x4 <- lm(data=AllData, TotalQuantity ~ OilPrice + `GDP(£Millions)` + `FX Rate` + `Inflation `)
summary(x4)

x5 <- lm(data=AllData, TotalQuantity ~ OilPrice + `GDP(£Millions)` + `FX Rate` + `Inflation ` + `GVA(£Millions)` + `World Trade -  Imports (Trillion of $)` + `Interest Rates`)
summary(x5)

x6 <- lm(data=AllData, TotalQuantity ~ OilPrice + `FX Rate` + `Inflation ` + `GVA(£Millions)`)
summary(x6)

x7 <- lm(data=AllData, TotalQuantity ~ OilPrice + `FX Rate` + `World Trade -  Imports (Trillion of $)` + `GDP(£Millions)`)
summary(x7)

x8 <- lm(data=AllData, TotalQuantity ~ OilPrice + `FX Rate` + `Inflation ` + `World Trade -  Imports (Trillion of $)` + `Interest Rates`)
summary(x8)

x9 <- lm(data=AllData, TotalQuantity ~ OilPrice + `FX Rate` + `Inflation ` + `World Trade -  Imports (Trillion of $)` + `Interest Rates`)
summary(x9)

anova(x9)
coefficients(x9)

# using lm if your formula is y = x + z + m then formula = y ~ x + z + m


