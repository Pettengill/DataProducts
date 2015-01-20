require(rCharts)
source('source.R')
options(RCHART_LIB = 'polycharts')
shinyUI(pageWithSidebar(
        headerPanel("Bacterial Growth Curves of 3 Strains in 3 Environments"),

        sidebarPanel(
                p("Purpose: To compare bacterial growth rates at different points in
                        in time for 3 strains in 3 different growth environments. 
                        Scroll over data points to view values for Absorbance and Time."),
                br(),
                selectInput(inputId = "Environment",
                            label = "Select an environment from the menu",
                            choices = sort(unique(statsFinal$Environment)),
                            selected = 1),
                br(),
                selectInput("Strain", 
                            label = "Select a strain in this environment to calculate growth rate. 
                            Growth rate calculated is based on hours 5-10 with a simple linear model.", 
                            choices = list("Strain A" = "A", "Strain B" = "B", "Strain C" = "C"), 
                            selected = "A"),
                fluidRow(column(12, verbatimTextOutput("value"))),
                br(),
                p("Growth Data from Brian Connelly:",
                  a('Data can be found here', href = "http://bconnelly.net/2014/04/analyzing-microbial-growth-with-r/"))
        ),
        
        mainPanel(
                showOutput("chart1", "polycharts")
        )
))
 