library(shiny)

# Load data (Data downloaded and processed in "data-processing.R")
enrollments <- read.csv("data/enrollments.csv")   

#Define UI
shinyUI(fluidPage(
        titlePanel("Language Course Enrollments in US (1965--2016)"),
        sidebarLayout(
                sidebarPanel(
                        p("This App tracks course enrollments in Languages other than English in US degree-granting 
                        postsecondary institutions from 1965 to 2016. You can select a year to check the language course 
                           enrollments in that year from 'Enrollments in the Year' tab, or select a language to check the 
                           enrollment trends of that language in 'Enrollments Trend' tab."),
                        tags$a(href="https://nces.ed.gov/programs/digest/d19/tables/dt19_311.70.asp", 
                               "Data Source: National Center for Education Statistics", target="_blank"),
                        br(),
                        br(),
                        br(),
                        
                        selectInput(inputId="year", label=strong("Year"),
                                    choices=unique(enrollments$year), selected="1965"),
                        h6("* Select a year to check the language courses enrollments in that year."), 
                        br(),
                        
                        selectInput(inputId="language", label=strong("Language Course"), 
                                    choices=unique(enrollments$language), selected="Chinese"),
                        h6("* Select a language to check the enrollment trends of that language."),
                        h6("* Greek means Ancient Greek."),
                        h6("* Chinese includes Cantonese and Mandarin.")
                ),
                mainPanel(
                        tabsetPanel(type="tabs",
                                    tabPanel("Enrollments in the Year", br(), textOutput("year"),
                                             plotOutput("barplot")),
                                    
                                    tabPanel("Enrollments Trend", br(), textOutput("language"), 
                                             plotOutput("trendplot")),
                        )
                )
        )
))


