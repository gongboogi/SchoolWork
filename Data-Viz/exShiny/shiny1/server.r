library(shiny)
library(extrafont)
#library(showtext)

#font_add_google("Nanum Gothic","nanumgothic")
#showtext_auto()
server <- function(input, output) {
  
  output$d <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- rnorm(input$obs)
    
    # draw the histogram with the specified number of bins
    #hist(x, main = "", xlab="", ylab = "", col = 'darkgreen', border = 'white')
    #title("정규분포 히스토그램", family = "nanumgothic", cex.main = 2)
    #title(ylab = "빈도", cex.lab = 1.5)
    #title(xlab = "x", cex.lab = 1.5)
    hist(x, main = "정규분포 히스토그램", family = "nanumgothic", cex.main = 2,  cex.lab=1.5, col = 'darkgreen', border = 'white', xlab = "x", ylab = "빈도")
  })
}

