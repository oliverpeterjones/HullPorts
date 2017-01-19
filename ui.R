library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Hull Ports"),
  
  # Sidebar 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "CategoriesInput", label="Choose a Category to split the data.",
                  choices = c("All",
                  "Other general cargo & containers <20'", 
                  "Iron and steel products",                        
                  "Liquefied gas",                                  
                  "Oil products",                                   
                  "Other liquid bulk products",                     
                  "Ores",                                           
                  "Other dry bulk",                                 
                  "Forestry products",                              
                  "Agricultural products (eg grain, soya, tapioca)",
                  "Coal"))
    ),
    
    # Show a plot
    mainPanel(
       plotOutput("YearTotalPlot")
    )
  )
))
