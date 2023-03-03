library(shiny)
library(scales)
library(tidyverse)

# Load data (Data downloaded and processed in "data-processing.R")
enrollments <- read.csv("data/enrollments.csv")   

# Define server 
shinyServer(
        function(input, output, session){
                output$year <- renderText({paste("Enrollments in the year", input$year)})
                
                output$barplot <- renderPlot({
                        year_data <- reactive({
                                enrollments %>% 
                                        filter(year == input$year & language != "All" & language != "Other languages") %>% 
                                        mutate(language=ifelse(language=="American Sign Language", "ASL", language))
                        })
                        
                        percents <- reactive({percent(year_data()$enrollment/sum(year_data()$enrollment), accuracy=0.01)})
                        
                        ggplot(data=year_data(), aes(x=reorder(language, -enrollment), y=enrollment))+
                                geom_bar(stat="identity", fill="salmon", col="white")+
                                labs(x="Language", y="Enrollments", caption="* ASL: American Sign Language")+
                                coord_cartesian(ylim=c(0,880000))+
                                scale_y_continuous(labels = comma)+
                                geom_label(aes(label=enrollment), vjust=-0.3)+
                                geom_text(aes(label=percents()), vjust=1.2, size=4, col="white")+
                                theme_classic()+
                                theme(axis.text=element_text(size=12))+
                                theme(axis.title=element_text(size=18))+
                                theme(axis.text.x=element_text(angle=45))+
                                theme(plot.caption = element_text(hjust = 0, size=12))
                })
                
                output$language <- renderText({paste("Enrollments Trend of", input$language)})
                output$trendplot <- renderPlot({
                        lang_data <- reactive({enrollments[enrollments$language == input$language,]})
                        ggplot(data = lang_data(), aes(x=factor(year), y=enrollment))+
                                geom_bar(stat="identity", fill="lightgreen")+
                                labs(x="Year", y="Enrollments")+
                                geom_label(aes(label=enrollment), vjust=1.5)+
                                theme_classic()+
                                theme(axis.text=element_text(size=12))+
                                theme(axis.title=element_text(size=18))
                })
                
        })
