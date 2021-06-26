function(input, output ,session) {
  
  # choose columns to display
  cjsj <- as.data.frame(read.csv("C:\\Users\\mceking\\Documents\\R\\外省成交数据\\周边省份数据.csv"
                                 ,stringsAsFactors = F ,row.names =  ))
  cjsj2021 <- subset(cjsj , year == "2021")
  cjsj2021$money <- cjsj2021$mean * cjsj2021$deal
  output$table <- DT::renderDataTable(DT::datatable({
    data <- cjsj2021[,c(1,5,6:11)]
    colnames(data) <- c("成交日期","地区","品种","投放数量","成交数量",
                        "最高出价","最低出价","成交均价")
    if (input$rigion != "全部") {
      data <- data[cjsj2021$sorb == input$sorb,]
    }
    if (input$rigion != "全部") {
      data <- data[cjsj2021$rigion == input$rigion,]
    }
    if (input$rigion != "全部") {
      data <- data[cjsj2021$spe == input$spe,]
    }
    
    data
  }))
  output$pplot <- renderPlot({
    data1 <- cjsj2021[,c(1,5,6:11)]
    if (input$rigion != "全部") {
      data1 <- data1[cjsj2021$rigion == input$rigion,]
    }
    data
    ggplot(data = data1, mapping = aes(y = mean, x = date ,color = spe ,group = spe ,fill = spe)) +
      geom_line(size = 1.5) +
      labs(x = "\n 日  期", y = "价  格") +
      labs(title = paste(input$rigion,"拍卖成交情况",sep = ""),
           subtitle = paste("数据来源: ",input$rigion,"粮食交易中心",sep = "")) +
      theme_economist() + scale_colour_economist() +
      theme(axis.line.x = element_line(size = .5, colour = "black"),
            legend.position = "bottom",
            legend.direction = "horizontal",
            legend.title = element_blank(),
            plot.title = element_text(family = "wqy-microhei"),
            text = element_text(family = "wqy-microhei"))
      
  })
}
