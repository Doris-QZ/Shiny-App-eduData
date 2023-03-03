---
title: "Language Course Enrollments App"
author: "Doris"
date: "2023-03-02"
output: 
  ioslides_presentation: 
    widescreen: yes
    keep_md: yes
always_allow_html: true
---

## Synopsis

<font size="3">This App tracks course enrollments in Languages other than English in US degree-granting postsecondary institutions from 1965 to 2016. 

Two functions in the App:

- Year: Select a year to check the language course enrollments in that year.
- Language: Select a language to check the enrollment trends of that language.

Try the **[App](https://pvxjz6-chen-doris.shinyapps.io/eduData-App/)** now.</font>

## Data

<font size="3">Data Source: [National Center for Education Statistics](https://nces.ed.gov/programs/digest/d19/tables/dt19_311.70.asp)  
  
Data was pre-processed before working on this App.   
  
Here is the first 10 rows of the final data:  </font>    
  
<center>

```
   language year enrollment
1       All 1965    1034651
2    Arabic 1965        911
3   Chinese 1965       3359
4    French 1965     371747
5    German 1965     213909
6     Greek 1965      19495
7    Hebrew 1965       8093
8   Italian 1965      22950
9  Japanese 1965       3505
10   Korean 1965         82
```
</center>

## Code of ui.R


```r
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
                                selectInput(inputId="year", label=strong("Year"),
                                            choices=unique(enrollments$year), selected="1965"),
                                h6("* Select a year to check the language courses enrollments in that year."), 
                                selectInput(inputId="language", label=strong("Language Course"), 
                                            choices=unique(enrollments$language), selected="Chinese"),
                                h6("* Select a language to check the enrollment trends of that language."),
                                h6("* Greek means Ancient Greek."),
                                h6("* Chinese includes Cantonese and Mandarin.")),
                        mainPanel(
                                tabsetPanel(type="tabs",
                                            tabPanel("Enrollments in the Year", br(), textOutput("year"),
                                                     plotOutput("barplot")),
                                            tabPanel("Enrollments Trend", br(), textOutput("language"), 
                                                     plotOutput("trendplot")))))))
```

```{=html}
<div class="container-fluid">
<h2>Language Course Enrollments in US (1965--2016)</h2>
<div class="row">
<div class="col-sm-4">
<form class="well" role="complementary">
<p>This App tracks course enrollments in Languages other than English in US degree-granting 
                                postsecondary institutions from 1965 to 2016. You can select a year to check the language course 
                                   enrollments in that year from 'Enrollments in the Year' tab, or select a language to check the 
                                   enrollment trends of that language in 'Enrollments Trend' tab.</p>
<a href="https://nces.ed.gov/programs/digest/d19/tables/dt19_311.70.asp" target="_blank">Data Source: National Center for Education Statistics</a>
<br/>
<div class="form-group shiny-input-container">
<label class="control-label" id="year-label" for="year">
<strong>Year</strong>
</label>
<div>
<select id="year"><option value="1965" selected>1965</option>
<option value="1970">1970</option>
<option value="1974">1974</option>
<option value="1980">1980</option>
<option value="1986">1986</option>
<option value="1990">1990</option>
<option value="1995">1995</option>
<option value="2002">2002</option>
<option value="2006">2006</option>
<option value="2009">2009</option>
<option value="2013">2013</option>
<option value="2016">2016</option></select>
<script type="application/json" data-for="year" data-nonempty="">{"plugins":["selectize-plugin-a11y"]}</script>
</div>
</div>
<h6>* Select a year to check the language courses enrollments in that year.</h6>
<div class="form-group shiny-input-container">
<label class="control-label" id="language-label" for="language">
<strong>Language Course</strong>
</label>
<div>
<select id="language"><option value="All">All</option>
<option value="Arabic">Arabic</option>
<option value="Chinese" selected>Chinese</option>
<option value="French">French</option>
<option value="German">German</option>
<option value="Greek">Greek</option>
<option value="Hebrew">Hebrew</option>
<option value="Italian">Italian</option>
<option value="Japanese">Japanese</option>
<option value="Korean">Korean</option>
<option value="Latin">Latin</option>
<option value="Portuguese">Portuguese</option>
<option value="Russian">Russian</option>
<option value="Spanish">Spanish</option>
<option value="Other languages">Other languages</option>
<option value="American Sign Language">American Sign Language</option></select>
<script type="application/json" data-for="language" data-nonempty="">{"plugins":["selectize-plugin-a11y"]}</script>
</div>
</div>
<h6>* Select a language to check the enrollment trends of that language.</h6>
<h6>* Greek means Ancient Greek.</h6>
<h6>* Chinese includes Cantonese and Mandarin.</h6>
</form>
</div>
<div class="col-sm-8" role="main">
<div class="tabbable">
<ul class="nav nav-tabs" data-tabsetid="4629">
<li class="active">
<a href="#tab-4629-1" data-toggle="tab" data-bs-toggle="tab" data-value="Enrollments in the Year">Enrollments in the Year</a>
</li>
<li>
<a href="#tab-4629-2" data-toggle="tab" data-bs-toggle="tab" data-value="Enrollments Trend">Enrollments Trend</a>
</li>
</ul>
<div class="tab-content" data-tabsetid="4629">
<div class="tab-pane active" data-value="Enrollments in the Year" id="tab-4629-1">
<br/>
<div id="year" class="shiny-text-output"></div>
<div class="shiny-plot-output html-fill-item" id="barplot" style="width:100%;height:400px;"></div>
</div>
<div class="tab-pane" data-value="Enrollments Trend" id="tab-4629-2">
<br/>
<div id="language" class="shiny-text-output"></div>
<div class="shiny-plot-output html-fill-item" id="trendplot" style="width:100%;height:400px;"></div>
</div>
</div>
</div>
</div>
</div>
</div>
```

## Code of server.R

```r
        shinyServer(
                function(input, output, session){
                        output$year <- renderText({paste("Enrollments in the year", input$year)})
                        output$barplot <- renderPlot({
                           year_data <- reactive({
                               enrollments %>% 
                                     filter(year == input$year & language != "All" & language != "Other languages") %>% 
                                     mutate(language=ifelse(language=="American Sign Language", "ASL", language)) })
                           percents <- reactive({percent(year_data()$enrollment/sum(year_data()$enrollment), accuracy=0.01)})
                           ggplot(data=year_data(), aes(x=reorder(language, -enrollment), y=enrollment))+
                                        geom_bar(stat="identity", fill="salmon", col="white")+
                                        labs(x="Language", y="Enrollments", caption="* ASL: American Sign Language")+
                                        coord_cartesian(ylim=c(0,880000))+
                                        scale_y_continuous(labels = comma)+
                                        geom_label(aes(label=enrollment), vjust=-0.3)+
                                        geom_text(aes(label=percents()), vjust=1.2, size=4, col="white")+
                                        theme(plot.caption = element_text(hjust = 0, size=12))})
                        output$language <- renderText({paste("Enrollments Trend of", input$language)})
                        output$trendplot <- renderPlot({
                                lang_data <- reactive({enrollments[enrollments$language == input$language,]})
                                ggplot(data = lang_data(), aes(x=factor(year), y=enrollment))+
                                        geom_bar(stat="identity", fill="lightgreen")+
                                        labs(x="Year", y="Enrollments")+
                                        geom_label(aes(label=enrollment), vjust=1.5)})})
```
<font size="3">* Code is simplified a bit for fitting in this slide.<font>
