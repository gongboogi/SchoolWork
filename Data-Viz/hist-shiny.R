# 난수생성, hist그리기

library(shiny)

# Define UI for application that draws a histogram

#입력, 출력 표시
ui <- fluidPage(
    
    # Application title
    headerPanel ("2016666 공아영"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("obs", # <- input에 들어가는 값
                        "Number of observations:",
                        min = 1,
                        max = 1000,
                        value = 500)
        ),
        
        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("d") # output에 들어감(d)
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$d <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- rnorm(input$obs)

        # draw the histogram with the specified number of bins
        hist(x, main = "정규분포 히스토그램", col = 'blue', border = 'white', xlab = "x", ylab="빈도")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
