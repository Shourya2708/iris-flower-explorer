library(shiny)

fluidPage(
  titlePanel("Iris Flower Explorer"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput(
        "species", "Choose a flower species:",
        choices = c("All species", levels(iris$Species))
      ),
      sliderInput(
        "minimum", "Minimum sepal length (cm):",
        min = 4, max = 8, value = 4, step = 0.1
      ),
      
      h4("How to use this app"),
      p("Choose a species and move the slider. The chart and summary
        update to show only flowers matching your choices."),
      p("Each point on the chart represents one flower. Sepal length
        is on the horizontal axis; petal length is on the vertical axis.")
    ),
    
    mainPanel(
      h3("Flowers matching your choices"),
      textOutput("summary"),
      plotOutput("flowerPlot", height = "400px")
    )
  )
)