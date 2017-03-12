#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Annual Flow of the Nile River"),

  # Sidebar with a slider input for choosing the discontinuity year
  sidebarLayout(
    sidebarPanel(
        h3("Did the flow of the Nile change drastically and permanently?"),
        "A smoothing function is applied in two parts, before and after the chosen year.
        Try to find the discontinuity by adjusting the possible year of the change.",
        sliderInput("year", "Split year:", sep = "",
                    min = 1872, max = 1968, value = 1920),
        "Choosing a different smoothing function may help make the discontinuity more clear.",
        selectInput("fn", "Smoothing Function:",
                    c("Contemporaneous", "Fixed Interval")),
        "Original measurements are in gray.",
        "Smoothed values before the split are in black.",
        "Smoothed values after the split are in blue."
    ),

    # Show a plot of the generated distribution
    mainPanel(
        plotOutput("distPlot")
    )
  )
))
