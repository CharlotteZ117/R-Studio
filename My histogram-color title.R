#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30),
            selectInput("fillcolor",
                        label="Choose a fill color",
                        choices=c("salmon","palegoldenrod","palegreen","grey")),
            selectInput("linecolor",
                        label="Choose a line color",
                        choices = c("black","plum","red","lightpink")),
            textInput("title",
                      label="Enter a title for your graph")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)
        
        class(faithful)

        # draw the histogram with the specified number of bins
        # Using ggplot
        library(ggplot2)
        ggplot(faithful,aes(x))+
          geom_histogram(breaks=bins,color=input$linecolor,fill=input$fillcolor)+
          theme(axis.title.y=element_text(angle=0))+
          ggtitle(input$title)
        #break=bins 
        
        #hist(x, breaks = bins, col = 'darkgray', border = 'white',
             #xlab = 'Waiting time to next eruption (in mins)',
             #main = 'Histogram of waiting times')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
