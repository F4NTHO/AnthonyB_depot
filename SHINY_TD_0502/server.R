#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(ggplot2)
library(dplyr)

serveur2 <- function(input, output) {
  
  output$graphique <- renderPlot({
    
    msleep %>%
      filter(vore %in% input$groupes) %>%
      ggplot(aes(x = sleep_rem, y = sleep_total)) +
      geom_point(size = input$taille_points, aes(color = vore)) +
      xlim(input$limites_x) +
      ylim(input$limites_y) +
      geom_smooth(method = input$type_lissage) +
      labs(title = input$titre)
  })
}







###### BASE 


# Define server logic required to draw a histogram
#function(input, output, session) {

    #output$distPlot <- renderPlot({

        # generate bins based on input$bins from ui.R
      #  x    <- faithful[, 2]
       # bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
      #  hist(x, breaks = bins, col = 'darkgray', border = 'white',
       #      xlab = 'Waiting time to next eruption (in mins)',
        #     main = 'Histogram of waiting times')

   # })

#}
