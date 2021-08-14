library(shiny)
library(shinyWidgets)
library(tidyverse)


##########################################################################
default_code <- '# Template code. Try this out first, and then write your own!
ggplot(iris) + 
  aes(x = Sepal.Length) + 
  geom_histogram(color = "#FFCC00", 
                 fill = "#57150B") + 
  theme_classic() + 
  xlab("Sepal Length") + 
  ylab("Count")'


template <- '---
title: "Title not shown: Line-by-line template"
output:
  xaringan::moon_reader:
    seal: false
    lib_dir: libs
    css: [default, hygge, ninjutsu, custom.css]
    nature:
      ratio: 16:9
      highlightStyle: github
      highlightLines: true
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(fig.width = 8, comment = "", 
                      cache = F)
library(tidyverse)
library(flipbookr)
```

`r chunk_reveal("input_plot")`


```{r input_plot, include = FALSE}'
###########################################################################





ui <- fluidPage(

  tags$head(
    tags$style(HTML("
      @import url('https://fonts.googleapis.com/css2?family=Ubuntu+Mono&display=swap');
      #input_code {
        font-family: Ubuntu Mono;
        font-size: 1.1em;
      }
      .shiny-output-error-validation {
        color: orange;
        font-weight: 600;
        font-size: 1.25em;
      }
    "))
  ),
  
  titlePanel("See what your code is doing line-by-line."),
  p("Written by Stephanie Spielman, with much thanks to the",  a(href = "https://github.com/EvaMaeRey/flipbookr", "{flipbookr}"), "package!"),
  br(),
  p("This app can be used to examine what your code is doing line-by-line, which is very useful for understanding ggplots and tidyverse pipelines."),
  p("This app will", tags$b("not work"), "in the following circumstances:"),
  tags$li("Code that is all on 1 line. Multiple lines of code are needed."),
  tags$li("Code that attempts to use libraries or dependencies beyond the core", a(href = "https://www.tidyverse.org", tags$code("tidyverse")), "libraries. Other libraries and/or datasets cannot be loaded."),
  br(),
  
  shiny::textAreaInput("input_code", 
                       tagList(
                         h4("Input code here to see its ", tags$i("line-by-line"), " output:", ), 
                         helpText("Use the spacebar to tab in code lines if you want, this the tab key won't work in this app.", style = "font-size:0.75em; font-weight:400;")
                       ),
                       default_code, 
                       width = "600px", 
                       rows = 12),

  shinyWidgets::actionBttn("go", 
                           "Click to see code output line-by-line.", 
                           style = "jelly", 
                           color = "primary", 
                           size = "xs"),
  br(),br(),
  
  uiOutput("linebyline")
  
  

)
server <- function(input, output) {
  
  observeEvent(input$go,{
    
    updated_template <- c(template,
                          stringr::str_split(input$input_code, "\n")[[1]],
                          "```\n")
    name <- "back_end"
    rmd_file <- file.path("www", glue::glue("{name}.Rmd"))
    html_file <-  glue::glue("{name}.html")
    if (file.exists(file.path("www", html_file))) file.remove(file.path("www", html_file))
    
    readr::write_lines(updated_template, rmd_file)
    
    tryCatch(
      expr = 
        {
          rmarkdown::render(rmd_file,
                            quiet = TRUE)
        },
      error = function(e)
      {}
    )
    
    #rmarkdown::render(rmd_file,
    #                  quiet = TRUE)
    output$linebyline <- renderUI({
      shiny::validate(
        need(
          file.exists(file.path("www", html_file)), 
          "Your code appears to have a bug, or it is only one line of code, so it cannot be run line-by-line. Back up and try again!")
      )
      tags$iframe(src = html_file, width="1200", height="675") # ratio should be 16x9
    })

  })
  

}
shinyApp(ui, server)
