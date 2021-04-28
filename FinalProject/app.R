library(tidyverse)
library(tidyquant)
library(dplyr)
library(lubridate)
getwd()
stocks <- c("MSFT","GOOG","AAPL","AMZN","FB","MTNB","LUV","CSCO","GLMD","RIOT","MRNA","CO")
Today = Sys.Date()
Year_4_date = Today - years(4)

data <- tq_get(stocks, get = "stock.prices", from = Year_4_date)

library(shiny)
ui <- fluidPage(
    titlePanel("Stock Prices"),
    sidebarLayout(
        sidebarPanel(
            selectInput("stock", "Stock Symbol:",
                        choices = unique(data$symbol)),
            hr(),
            helpText("Pick a Stock from the Predetermined List")
        ),
        #create a spot for the plot
        mainPanel(
            plotOutput("StockPlot")
        )
    )
)


server <- function(input, output){
    output$StockPlot <- renderPlot({
        data %>%
            filter(symbol == input$stock)%>%
            ggplot()+
            geom_line(aes(x = date, y = adjusted))
    })
}


# Run the application 
shinyApp(ui = ui, server = server)




