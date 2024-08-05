#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(datasets)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Toursim Data Explore"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("Country",
                        "select country:",
                        choices = unique(data$country)),
             actionButton("plot_hist","Plot Histogram"),
             actionButton("plot_scatter","Plot Scatterplot")
        ),

        # Show a plot of the country
        mainPanel(
           plotOutput("Plot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  observeEvent(input$plot_hist,{
    subset_data<-subset(data,country==input$Country)
    output$Plot <- renderPlot({
        hist(subset_data$International.tourist.arrivals.by.region)
    })
  })
      
  
    output$plot<-renderPlot({
    # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white',
             xlab = 'Waiting time to next eruption (in mins)',
             main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
