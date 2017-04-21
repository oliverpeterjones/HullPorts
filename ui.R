# loading in packages needed for ui side
library(shiny)
# automatic themes
library(shinythemes)
# for the table
library(DT)

# Define UI for application
shinyUI(fluidPage(
  # theme for app
  theme = shinytheme("cerulean"),
  
  # title for all tabs
  navbarPage(
    "Hull Ports",
    
    # first main tab
    tabPanel(
      # tab name
      title = "About",
      
      # content of tab
      h2("Hull Ports App"),
      h6("(created by Karina Marks)"),
      h4("This is a quick mock up app, that I have created to visualise the change in cargo being moved in and out of the port in Hull, over the years 2000 to 2015."),
      h4("'Table' - a tab containing all the data used to create the graphs, (data from ONS), shown in interactive table."),
      h4("'Graphs' - a tab containing examples of different ways of displaying the data by interactive graphs")
      
      
    ),
    
    # second main tab
    tabPanel(
      # tab name
      title="Table",
      # what is in the tab
      dataTableOutput("Table")),
    
    # last main tab
    tabPanel(
      # tab name
      title = "Graphs",
      tabsetPanel(
        # 1st graph tab
        tabPanel(
          # tab name
          title="Graph Split by Category",
          # Creating a particular layout for the tab - sidebar 
          sidebarLayout(
            # creating the side bar panel with a dropdown box
            sidebarPanel(
              selectInput(
                inputId = "CategoriesInput", 
                label="Choose a Category to split the data.",
                choices = c("All Categories", "Other general cargo & containers <20'",
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
          title="Graph Split by Year",
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
          title="Graph Coloured by General Category",
          plotOutput("ColourGraph")
        ),
        # the fifth tab
        tabPanel(
          title="Graph Coloured by Category",
          plotOutput("ColourGraph2")
        )
        
        
      )
    )
    )
  ))
