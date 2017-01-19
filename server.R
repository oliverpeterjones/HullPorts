library(shiny)
library(readxl)
library(ggplot2)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  data <- read_excel("./Data/Hull Port - 2000-2015 - types data.xlsx")
  output$YearTotalPlot <- renderPlot({
    
    if (input$CategoriesInput == "All"){
      newData <- data
    } else {
      newData <- data %>% 
        filter(`Cargo Category Description` == input$CategoriesInput)
    }
    
   
    
    g <- ggplot(data=newData) +
      geom_bar(aes(x=Year, y=`Total (thousand tonnes)`), stat="identity") +
      ggtitle(paste0("Total cargo pre year for ", input$CategoriesInput, " Category."))
    
    g
  })
  
})
