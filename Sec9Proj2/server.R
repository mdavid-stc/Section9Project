#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$distPlot <- renderPlot({
      data(Nile)
      sepYr <- input$year
      half1 <- window(Nile, 1871, sepYr)
      half2 <- window(Nile, sepYr, 1970)
      plot(Nile, col = "gray", xlab = "Year", ylab = "Annual Flow (10^8 cubic meters)")
      abline(v = sepYr, lty = 2)

      fit1 <- StructTS(half1, type = "level")
      fit2 <- StructTS(half2, type = "level")

      if (input$fn == "Contemporaneous") {   # contemporaneous smoothing
          lines(fitted(fit1))
          lines(fitted(fit2), col = "blue")
      }
      else if (input$fn == "Fixed Interval") {   # fixed-interval smoothing
          lines(tsSmooth(fit1))
          lines(tsSmooth(fit2), col = "blue")
      }
  },
  height = 600)

})
