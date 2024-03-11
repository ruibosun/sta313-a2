# Install and load required libraries
if (!require(shiny)) {
  install.packages("shiny")
}
library(shiny)
library(ggplot2)

# Sample data
# Replace this with your actual data
df <- data.frame(OCC_HOUR = sample(0:23, 500, replace = TRUE),
                 OCC_DOW = sample(c("Mon", "Tue", "Wed", "Thu", "Fri"), 500, replace = TRUE))

# Define the UI
ui <- fluidPage(
  titlePanel("Interactive Occurrences Plot"),
  sidebarLayout(
    sidebarPanel(
      selectInput("dow", "Select Day of the Week:",
                  choices = c("Mon", "Tue", "Wed", "Thu", "Fri"),
                  selected = "Mon")
    ),
    mainPanel(
      plotOutput("occurrence_plot")
    )
  )
)

# Define the server
server <- function(input, output) {
  filtered_data <- reactive({
    subset(df, OCC_DOW == input$dow)
  })
  
  output$occurrence_plot <- renderPlot({
    ggplot(filtered_data(), aes(x = OCC_HOUR)) +
      geom_bar(fill = "blue", color = "black") +
      labs(title = paste("Occurrences Based on", input$dow, "and Hours"),
           x = "Hour of Occurrence", y = "Number of Occurrences") +
      theme_minimal()
  })
}

# Run the Shiny app
shinyApp(ui = ui, server = server)


