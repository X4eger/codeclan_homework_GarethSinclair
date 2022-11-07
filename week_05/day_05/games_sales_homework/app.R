library(shiny)
library(tidyverse)
library(bslib)
library(shinyWidgets)

game_sales <- CodeClanData::game_sales

# Create unique variables for each future filter

# Genre
genretypes <- unique(game_sales$genre)
# Year
years <- unique(game_sales$year_of_release)
# Publisher
publishers <- unique(game_sales$publisher)
# Developer
developers <- unique(game_sales$developer)
# Platform
platforms <- unique(game_sales$platform)
# Ratings
ratings <- unique(game_sales$rating)


ui <- fluidPage(
  theme = bs_theme(bootswatch = "slate"),
  titlePanel(
    "Game Sales Data"),
  tabsetPanel(
    tabPanel( "Top 10's",
              sidebarLayout(
                sidebarPanel(
                  
                  pickerInput(
                    inputId = "genreinput",
                    label = "Select a Genre",
                    choices = genretypes,
                    options = list(`actions-box` = TRUE),
                    multiple = TRUE,
                    selected = "Sports"
                  ),
                  pickerInput(
                    inputId = "yearinput",
                    label = "Select a Year",
                    choices = years,
                    options = list(`actions-box` = TRUE),
                    multiple = TRUE,
                    selected = 2006
                  ),
                  
                  selectInput(
                    inputId = "publisherinput",
                    label = "Select a Publisher",
                    choices = publishers
                    
                  ),
                  selectInput(
                    inputId = "developerinput",
                    label = "Select a Developer",
                    choices = developers
                  ),
                  selectInput(
                    inputId = "platforminput",
                    label = "Select a Platform",
                    choices = platforms,
                    selected = "PS3"
                  )#,
                  # selectInput(
                  #   inputId = "scoresinput",
                  #   label = "What metric to arrange by?",
                  #   choices = c("Sales Figures" = "sales", "Critic Score" = "critic_score", "User Score" = "user_score")
                  # )
                  # selectInput(
                  #   inputId = "ratingsinput",
                  #   label = "Select a content rating",
                  #   choices = ratings
                  #   
                  # )
                ),
                mainPanel(
                  plotOutput("top_tens_plot")
                )
              )
    ),
    tabPanel(
      title = "Yearly Sales",
      fluidRow(
        
        column(3,
               offset = 5,
               selectInput(
                 inputId = "publisherinput",
                 label = "Select a Publisher",
                 choices = publishers
               )),
      ),
      fluidRow(
        column(4,
               offset = 0.5,
               plotOutput("publisher_sales_plot")
        ),
        column(3,
               "In this graph you can see the total units sold by the specified
               publisher, while the graphs below allow a closer inspection of
               the years and what items had the most sales during that time 
               period.")
      ),
      
      
      fluidRow(
        column(3,
               plotOutput("publisher_sales_pre2k_plot")
        ),
        column(3,
               plotOutput("publisher_sales_0105_plot")
        )
      ),
      fluidRow(
        column(3,
               plotOutput("publisher_sales_0610_plot")
        ),
        column(3,
               plotOutput("publisher_sales_1115_plot")
        ),
        column(3,
               plotOutput("publisher_Sales_post15_plot")
        )
      )
    )
  )
)


server <- function(input, output, session) {
  
  observe({
    print(input$genreinput)
  })
  
  # Ideally i wanted to be able to have an "all option for every category for 
  # easier filtering however was unable to achieve this.
  
  output$top_tens_plot <- renderPlot({
    
    CodeClanData::game_sales %>% 
      filter(genre == input$genreinput) %>% 
      # filter(year_of_release == input$yearinput) %>% 
      # filter(publisher == input$publisherinput) %>% 
      # filter(developer == input$developerinput) %>% 
      filter(platform == input$platforminput) %>%
      #filter(rating == input$ratingsinput) %>% 
      # arrange(desc(input$scoresinput)) %>% 
      head(10) %>% 
      ggplot(aes(x = name, y = reorder(input$scoresinput, input$scoresinput))) +
      ggtitle(
        paste0(
          "Top 10 ", input$genreinput," Games, based on ", input$scoresinput, "."))+
      geom_col()+
      labs(x = "Game Name",
           y = "Units sold, in millions")+
      coord_flip()
    
  })
  # This plot was created with the idea of users being able to see the top 10
  # games sold by as many or as few categories as they want, being able to 
  # customize their filters as much as they want. 
  
  output$publisher_sales_plot <- renderPlot({
    
    CodeClanData::game_sales %>% 
      filter(publisher == input$publisherinput) %>% 
      ggplot(aes(x = year_of_release,
                 y = sales, fill = name))+
      geom_col()+
      labs(
        x = "Release Years",
        y = "Units sold(millions)"
      )+
      guides(fill = FALSE)
  })
  
  # The above plot is a summary of the sales information over the years, with 
  # the below breakdowns you can go into more detail regarding the information. 
  # The below 5 plots are for a deeper breakdown of what games created the most
  # sales for the chosen publisher in smaller chunk breakdowns, this can be 
  # hopefully displayed in a way that will make it easier to get useful 
  # information at a glance
  
  output$publisher_sales_pre2k_plot <- renderPlot({
    
    CodeClanData::game_sales %>% 
      filter(publisher == input$publisherinput,
             year_of_release  <= 2000) %>% 
      ggplot(aes(x = name, y = sales, fill = developer))+
      geom_col()+
      labs(title = "Sales up to 2000",
           x = "Game Name",
           y = "Units sold (millions)")+
      coord_flip()
  })
  
  output$publisher_sales_0105_plot <- renderPlot({
    
    CodeClanData::game_sales %>% 
      filter(publisher == input$publisherinput,
             year_of_release == 2001:2005) %>% 
      ggplot(aes(x = name, y = sales, fill = developer))+
      geom_col()+
      labs(title = "Sales 2001 to 2005",
           x = "Game Name",
           y = "Units sold (millions)")+
      coord_flip()
  })
  
  output$publisher_sales_0610_plot <- renderPlot({
    
    CodeClanData::game_sales %>% 
      filter(publisher == input$publisherinput,
             year_of_release == 2006:2010) %>% 
      ggplot(aes(x = name, y = sales, fill = developer))+
      geom_col()+
      labs(title = "Sales 2006 to 2010",
           x = "Game Name",
           y = "Units sold (millions)")+
      coord_flip()
  })
  
  output$publisher_sales_1115_plot <- renderPlot({
    
    CodeClanData::game_sales %>% 
      filter(publisher == input$publisherinput,
             year_of_release == 2011:2015) %>% 
      ggplot(aes(x = name, y = sales, fill = developer))+
      geom_col()+
      labs(title = "Sales 2011 to 2015",
           x = "Game Name",
           y = "Units sold (millions)")+
      coord_flip()
  })
  
  output$publisher_sales_post15_plot <- renderPlot({
    
    CodeClanData::game_sales %>% 
      filter(publisher == input$publisherinput,
             year_of_release >= 2015) %>% 
      ggplot(aes(x = name, y = sales, fill = developer))+
      geom_col()+
      labs(title = "Sales after 2015",
           x = "Game Name",
           y = "Units sold (millions)")+
      coord_flip()
  })
  
  
}

shinyApp(ui, server)