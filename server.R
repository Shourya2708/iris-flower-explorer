library(shiny)

function(input, output, session) {
  
  matching_flowers <- reactive({
    flowers <- iris
    
    if (input$species != "All species") {
      flowers <- flowers[flowers$Species == input$species, ]
    }
    
    flowers[flowers$Sepal.Length >= input$minimum, ]
  })
  
  output$summary <- renderText({
    flowers <- matching_flowers()
    
    if (nrow(flowers) == 0) {
      return("No flowers match these choices. Lower the minimum sepal length.")
    }
    
    paste(
      nrow(flowers), "flowers match.",
      "Their average petal length is",
      round(mean(flowers$Petal.Length), 2), "cm."
    )
  })
  
  output$flowerPlot <- renderPlot({
    flowers <- matching_flowers()
    
    if (nrow(flowers) == 0) {
      plot.new()
      text(0.5, 0.5, "No flowers match these choices")
      return()
    }
    
    plot(
      flowers$Sepal.Length, flowers$Petal.Length,
      col = as.integer(flowers$Species),
      pch = 19,
      xlab = "Sepal length (cm)",
      ylab = "Petal length (cm)",
      main = "Matching iris flowers",
      xlim = range(iris$Sepal.Length),
      ylim = range(iris$Petal.Length)
    )
    
    legend(
      "topleft",
      legend = levels(iris$Species),
      col = seq_along(levels(iris$Species)),
      pch = 19,
      bty = "n"
    )
  })
}