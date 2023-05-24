#setwd("/Users/zhaoxinqiao/Documents/MATH261/week11")
views30<-read.csv("My views 30 days.csv")
views90<-read.csv("My views 90 days.csv")
fans30<-read.csv("My fans 30 days.csv")
fans90<-read.csv("My fans 90 days.csv")

views30 <- na.omit(views30)
views90 <- na.omit(views90)
fans30 <- na.omit(fans30)
fans90 <- na.omit(fans90)


views30$var <- rep("views30",nrow(views30))
views90$var <- rep("views90",nrow(views90))
fans30$var <- rep("fans30",nrow(fans30))
fans90$var <- rep("fans90",nrow(fans90))

colnames(views30)[2] <- "freq"
colnames(views90)[2] <- "freq"
colnames(fans30)[2] <- "freq"
colnames(fans90)[2] <- "freq"


data <- rbind(views30,views90,fans30,fans90)
colnames(data)<-c("Date","freq","var")

viewsfans<-unique(data$var)


#colnames(views90)<-c("Date","View")
#colnames(views30)<-c("Date","View")
#colnames(fans90)<-c("Date","Fans")
#colnames(fans30)<-c("Date","Fans")


library(ggplot2)
library(dplyr)
library(shiny)


# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Charlotte's tiktok data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectInput("viewsfansInput",
                        "Select the date interval and the type of data",
                        choices = viewsfans),
            radioButtons("colorInput", 
                         label="Choose a color",
                         choices = c("salmon","plum","lightskyblue",
                                     "limegreen"),
                         selected = "salmon")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("myPlot")
        )
    )
)

# Define server logic required to draw a histogram
  
server<-function(input, output){
  dataInput <- reactive({
    data%>%
      filter(
        var==input$viewsfansInput
      )
  })
  
  output$myPlot<-renderPlot({
    ggplot(dataInput(), aes(x=Date,y=freq))+
      geom_bar(stat="identity", col="black",fill=input$colorInput)+
      xlab("Barplot")+
      ylab("Views or Fans")
  })
}

shinyApp(ui = ui, server = server)
