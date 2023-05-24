setwd("/Users/zhaoxinqiao/Documents/MATH261/w13 regression")
fan30<-read.csv("My fans 30 days.csv")
fan90<-read.csv("My fans 90 days.csv")
view30<-read.csv("My views 30 days.csv")
view90<-read.csv("My views 90 days.csv")
view30$var <- rep("My views 30 days.csv",nrow(view30))
view90$var <- rep("My views 90 days.csv",nrow(view90))
fan30$var <- rep("My fans 30 days.csv",nrow(fan30))
fan90$var <- rep("My fans 90 days.csv",nrow(fan90))

view30 <- na.omit(view30)
view90 <- na.omit(view90)
fan30 <- na.omit(fan30)
fan90 <- na.omit(fan90)

colnames(view30)[2] <- "freq"
colnames(view90)[2] <- "freq"
colnames(fan30)[2] <- "freq"
colnames(fan90)[2] <- "freq"

data<-rbind(view30,view90,fan30,fan90)
data<-data%>%
  filter(freq!=0)
data$month<-substr(data$Date,1,1)
data$day<-substr(data$Date,3,4)
data$day<-gsub("/","",data$day)
data$year<-rep("2023",nrow(data))
data$Date<-paste(data$year,data$month,data$day,sep="-")
data$Date<-as.Date(data$Date)

datasetchoice<-c("My views 30 days.csv","My views 90 days.csv","My fans 30 days.csv","My fans 90 days.csv")
color<-c("salmon","plum","pink","red","lightskyblue")


library(ggplot2)
library(dplyr)
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Charlotte's Tiktok Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
          selectInput("viewsfansInput",
                      "Select a data set",
                      choices = datasetchoice),
          radioButtons("colorInput", 
                       label="Choose a color",
                       choices = color,
                       selected = "salmon"),
          dateRangeInput("dateInput",
                    label="Choose a date interval",
                    start="2023-1-23",
                    end="2023-4-22",
                    min="2023-1-23",
                    max="2023-4-22")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("tiktokPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  dataInput <- reactive({
    data%>%
      filter(
        var==input$viewsfansInput,
        Date>input$dateInput[1]&Date<input$dateInput[2]
      )
  })
  
    output$tiktokPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
      ggplot(dataInput(), aes(x=Date,y=freq))+
        geom_bar(stat="identity", col="black",fill=input$colorInput)+
        xlab("Barplot")+
        ylab("Views or Fans")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
