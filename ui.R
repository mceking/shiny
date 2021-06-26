library(shiny)
library(ggplot2)
library(ggthemes)
library(shinythemes)
fluidPage(
  titlePanel("各省稻谷成交看板"),
  fluidRow(
    column(4,
           selectInput("sorb", "方向:", 
                       choices=c("全部",as.character(cjsj2021$sorb))),
    ),
    column(4,
           selectInput("spe", "品种:", 
                       choices=c("全部",as.character(cjsj2021$spe))),
    ),
    column(4,
           selectInput("rigion", "地区:", 
                       choices=c("全部",as.character(cjsj2021$rigion))),
    ),
  ),
  plotOutput("pplot"),
  DT::dataTableOutput("table")
  
)