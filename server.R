require(rCharts)
source('source.R')
#options(RCHART_WIDTH = 800)
shinyServer(function(input, output) {
        output$chart1 <- renderChart2({
                ENV = input$Environment
                env = subset(statsFinal, Environment == ENV)
                p2 <- rPlot(Absorbance ~ Time, color = 'Strain', type = 'line', data = env)
                p2$guides(y = list(min = 0, title = ""))
                p2$layer(x = "Time", y = "Absorbance", color = 'Strain', 
                         data = env, type = 'point', size = list(const = 1.5))
                p2$guides(y = list(title = "Absorbance (at 600 nm)"))
                p2$guides(x = list(title = "Time (in hours)"))
                p2$addParams(height = 300, dom = 'chart1')
                return(p2)
        })
        
        # Output for growth rate
        output$value <- renderText({ 
        ENV <- input$Environment
        env <- subset(statsFinal, Environment == ENV)
        STR <- input$Strain
        fiveten <- subset(env, Strain == STR)
        fiveten <- subset(fiveten, Time >= 5)
        fiveten <- subset(fiveten, Time <= 10)
        fit <- lm(log(fiveten[,"Absorbance"]) ~ fiveten[,"Time"])
        paste("Growth Rate (doubling time in hours):", signif(log(2)/fit$coef[2], digits = 3) ) 
        
        })
})
