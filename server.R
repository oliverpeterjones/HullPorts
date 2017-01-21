# load in packages needed on server side
library(shiny)
# used for reading in the data
library(readxl)
# used for plotting the graph
library(ggplot2)
# used for tidying the data
library(dplyr)


shinyServer(function(input, output) {
  # importing the data from file, creating a data.frame object
  data <- read_excel("./Data/Hull Port - 2000-2015 - types data.xlsx")
  
  # making each column the correct data type
  # removing the Major Port Column - they're all Hull
  data <- data[-2]
  # Keeeping the Years as integer numbers, and making them into factors for each year
  data$Year <- as.factor(as.integer(data$Year))
  # making sure that total is kept to 3dp (i.e 4 digits)
  data$`Total (thousand tonnes)` <- round(data$`Total (thousand tonnes)`, 4)
  # remove (general) cargo category - this is because we can use the description 
  # column as factors so don't need this
  data <- data[-c(3, 6)]
  # create factor groups for (general) cargo category decription columns
  data$`Cargo Category Description` <- as.factor(data$`Cargo Category Description`)
  data$`General Cargo Category Description` <- as.factor(data$`General Cargo Category Description`)
  
  
    
  # for the table tab
  ## TODO -  download the datatable package and make this nicer
  output$Table <- renderTable(
    data
  )
  
  
  
  # for the graph by categpry tab
  # creating the plot with x-axis year and y-axis total, per Category
  output$YearTotalPlot <- renderPlot({
    
    # looking at the categorical input
    # if all is chosen then the whole data frame is used
    # if a specific category is selected then data is filtered by that input
    if (input$CategoriesInput == "All"){
      newData <- data
    } else {
      newData <- data %>% 
        filter(`Cargo Category Description` == input$CategoriesInput)
    }
    
   
    # creating the bar graph
    g <- ggplot(data=newData) +
      geom_bar(aes(x=Year, y=`Total (thousand tonnes)`), stat="identity") +
      ggtitle(paste0("Total cargo per year for ", input$CategoriesInput,
                     " Category.")) +
      theme_classic() 
    
    # plotting the graph - the final output
    g
  })
  
  
  
  # for the graph by year tab
  # creating the plot with x-axis Category and y-axis total, per year
  output$CategoryTotalPlot <- renderPlot({
    
    # looking at the year input
    # if all is chosen then the whole data frame is used
    # if a specific year is selected then data is filtered by that input
    if (input$YearInput == "All Years"){
      newData <- data
    } else {
      newData <- data %>% 
        filter(Year == input$YearInput)
    }

    # creating the graphical object
    g <- ggplot(data=newData) +
      geom_bar(aes(x=`Cargo Category Description`, y=`Total (thousand tonnes)`), 
               stat="identity") +
      ggtitle(paste0("Total cargo per Category for ", input$YearInput)) +
      theme_light() 
    
    # plotting graph - final output
    g
  })
  
  
  # for the another graph tab
  output$ColourGraph <- renderPlot({
    
    # sortin the data so it stacks nicely in barchart
    sortedData <- data %>%
      arrange(`General Cargo Category Description`)
    
    # creating bar chart where data is split by color due to category
    g <- ggplot(sortedData) +
      geom_bar(aes(x=Year, y=`Total (thousand tonnes)`, 
                   col = `General Cargo Category Description`), 
               stat="identity")
    
    # the output graph
    g
    
  })
  
  
  # what is in the another graph 2 tab
  output$ColourGraph2 <- renderPlot({
    
    # summarising the data to only have year, category and sum of totals
    summarisedData <- data %>%
      group_by(Year, `Cargo Category Description`) %>%
      summarise(Total = sum(`Total (thousand tonnes)`))
    
  
    # plotting graph
    g <- ggplot(summarisedData)+
      geom_bar(aes(x = Year, y = Total, fill=`Cargo Category Description`),
               stat = "identity") 
     
    # return the graph as the output
    g 
    
  })
  
  
})
