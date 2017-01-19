# loading in packages needed for ui side
library(shiny)

# Define UI for application
shinyUI(fluidPage(
  # title for all tabs
  titlePanel("Hull Ports"),
  
  # creating the tabs
  tabsetPanel(
    
    # first tab
    tabPanel(
      # tab name
      title="Table",
      # what is in the tab
      tableOutput("Table")),
    
    #second tab
    tabPanel(
      # tab name
      title="Graph by Category",
      # Creating a particular layout for the tab - sidebar 
      sidebarLayout(
        # creating the side bar panel with a dropdown box
        sidebarPanel(
           selectInput(
             inputId = "CategoriesInput", 
             label="Choose a Category to split the data.",
             choices = c("All", "Other general cargo & containers <20'",
                         "Iron and steel products", "Liquefied gas",                                  
                         "Oil products", "Other liquid bulk products",                     
                         "Ores", "Other dry bulk", "Forestry products",                              
                         "Agricultural products (eg grain, soya, tapioca)",
                         "Coal")
             )
        ),
        # Show the plot for year against total, which changes due to dropdown box
        mainPanel(
          plotOutput("YearTotalPlot")
          )
        )
      ),
    
    # third tab
     tabPanel(
       title="Graph by Year",
       # initialising the layout for this tab - sidebar
       sidebarLayout(
          # putting a dropdown box for the choice of year, on the side panel
         sidebarPanel(
           selectInput(
             inputId = "YearInput", 
             label="Choose a Year to split the data.",
             choices = c("All Years", "2000", "2001", "2002", "2003",
                         "2004", "2005", "2006", "2007", "2008",
                         "2009", "2010", "2011", "2012", "2013",
                         "2014", "2015"))
         ),
         # Show the plot of categories againt total, dependent on dropdown input
         mainPanel(
           plotOutput("CategoryTotalPlot")
           )
         )
       ),
    # the fourth tab 
      tabPanel(
        title="Another Graph",
        plotOutput("ColourGraph")
      ),
    # the fifth tab
      tabPanel(
        title="Another Graph 2",
        plotOutput("ColourGraph2")
      )
    )
  ))
