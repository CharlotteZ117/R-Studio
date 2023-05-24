library(shiny)
library(ggplot2)

ui<- fluidPage(
  
  sliderInput(inputId = "num",
              label = h3("Choose your random sample"),
              value = 30,    #The default value
              min = 20,
              max = 100),
  plotOutput("hist")
)


server<- function(input,output)
{
  output$hist<-renderPlot({
    x=rnorm(input$num)
    df <- data.frame(x)
    ggplot(df, aes(x=x)) + 
      geom_histogram(color="black", fill="white")
  })
}
shinyApp(ui=ui, server=server)
