#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
 #사용자가 입력한 데이터 -> input
 #결과 -> output



# Define UI for application that draws a histogram
# 입력, 출력 표시

ui <- fluidPage(
  
  # Application title
  headerPanel("2016666 공아영"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs",
                  "Number of observation:",
                  min = 1,
                  max = 1000,
                  value = 500)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("d")
    )
  )
)

# Define server logic required to draw a histogram
# 변경되면 안됨. 

server <- function(input, output) {
  
  output$d <- renderPlot({
    # generate bins based on input$bins from ui.R
    x    <- rnorm(input$obs)
    
    # draw the histogram with the specified number of bins
    hist(x, main = "정규분포 히스토그램", col = 'blue', border = 'white', xlab = "x", ylab = "빈도")
  })
}

# Run the application 
shinyApp(ui = ui, server = server)


