#UI
library(extrafont)
library(shiny)
if(!require(bslib)){
  install.packages("bslib")
  library(bslib)
}  #ui 가져오기


#사용자가 입력한 데이터 -> input
#결과 -> output



# Define UI for application that draws a histogram
# 입력, 출력 표시

ui <- fluidPage(
  theme = bs_theme(version = 4, bootswatch = "minty"),
  
  # Application title
  headerPanel("2016666 공아영"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      sliderInput("obs",
                  "Number of observation:",
                  min = 1,
                  max = 1000,
                  value = 500),
      hr(), #줄 삽입
      tags$img(src="turtle.png", width = "200", height = "200")
    ), #img넣는 태그
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("d")
    )
  )
)
