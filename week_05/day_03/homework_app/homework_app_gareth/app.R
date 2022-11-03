library(shiny)
library(tidyverse)
library(bslib)
library(scales)
library(jpeg)
library(ggpubr)


salary_data <- CodeClanData::salary
job_types <- unique(salary_data$job_area)
job_location <- unique(salary_data$location)
img <- readJPEG("www/stonks.jpg")

ui <- fluidPage(
  theme = bs_theme(bootswatch = "vapor"),
  titlePanel("Choosing what career and where to do it."),
  "Based on everyones real reason,", tags$strong("money."),
  tags$br(),
  tabsetPanel(
    tabPanel(
      "Choose your future",
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "joblocation",
            label = "Where would you like to work?",
            choices = job_location
          ),
          selectInput(
            inputId = "jobtypes",
            label = "What would you like to do",
            choices = job_types
          ),
          actionButton("honk", "HONK")
        ),
        mainPanel(
          plotOutput("tab1_plot"),
          theme = bs_theme(bootswatch = "slate"))
      )
    ),
    tabPanel(
      "The Easy Way",
      "Below you will find the best paying jobs on average in each region",
      mainPanel(
        plotOutput("tab2_plot"),
        theme = bs_theme(bootswatch = "slate")
      )
    ),
    tabPanel(
      tags$a("Free Money",
             href = "https://www.youtube.com/watch?v=oHg5SJYRHA0")
    ),
    tabPanel(
      "Time for something completely different",
      tags$video(src = "hey.mp4", 
                 type = "video/mp4",
                 autoplay = 1,
                 controls = NA,
                 height = 600,
                 width = 800)
    )
  )
)

server <- function(input, output) {
  output$tab1_plot <- renderPlot(
    salary_data %>% 
      filter(job_area == input$jobtypes) %>% 
      filter(location == input$joblocation) %>% 
      ggplot()+
      aes(x = location, 
          y= salary, 
          fill = job_area)+
      geom_boxplot()+
      labs(
        x = "Where you want to live",
        y = "How much you could make"
      )+
      scale_y_continuous(labels = scales::label_dollar(prefix = "£"))+
      scale_fill_manual(values = "springgreen4")+
      theme(
        legend.position = "none"
      )
    
  )
  
  output$tab2_plot <- renderPlot(
    salary_data %>% 
      group_by(location) %>% 
      arrange(desc(salary)) %>% 
      slice_head() %>% 
      ggplot(aes(x = reorder(location, -salary), y = salary, fill = job_area, alpha = 0.5))+
      background_image(img)+
      geom_col()+
      labs(
        x = "Places to live",
        y = "Potential Salary"
      )+
      scale_y_continuous(labels=scales::label_dollar(prefix = "£"))+
      guides(fill = guide_legend(title = "Job Choice"))+
      coord_flip()
  )
  
  observeEvent(input$honk, {
    insertUI(selector = "#honk",
             where = "afterEnd", 
             ui = tags$audio(src = "honkhonk.wav", 
                             type = "audio/wav", 
                             autoplay = NA,
                             controls = NA)
    )
  }
  )
  
  
  
  
  
}

shinyApp(ui, server)
