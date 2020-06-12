library(shiny)
library(ggplot2)

darktheme <- theme(
	axis.text = element_text(colour = "#000000"),
	axis.title.x = element_text(colour = "#000000"),
	axis.title.y = element_text(colour = "#000000"),
	axis.ticks = element_line(color = "#000000"),
	panel.background = element_rect(fill = "#ffffff"),
	plot.background = element_rect(fill = "#ffffff", colour = "#ffffff", linetype = 1),
	panel.grid.major = element_blank(),
	panel.grid.minor = element_blank(),
	legend.background = element_rect(fill = "#ffffff"),
	legend.text = element_text(colour = "#000000"), 
	legend.key = element_rect(fill = "transparent", colour = "transparent"), 
	axis.line.x = element_line(color = "#000000"), 
	axis.line.y = element_line(color = "#000000"),
	text = element_text(size = 20)
)

datdl = data.frame(id = NA, lpos = NA, d13c = NA, d15n = NA)
function(input, output) {
datasetInput <- reactive({
    animals <- which(dat$whaleid %in% input$animal_id)
	data.frame(whaleid = dat$whaleid[animals], lpos = dat$lpos[animals], d13c = dat$d13c[animals], d15n = dat$d15n[animals])
})
  
  output$plot <- renderPlot({
	ddat <- datasetInput()
	
	if(input$timeiso == "c-n-isospace") {
    		p <- ggplot(ddat, aes(x=d13c, y=d15n, col = whaleid)) + geom_point() + xlab(expression(paste(delta^13, "C (\u2030)"))) + ylab(expression(paste(delta^15, "N (\u2030)"))) + labs(col="") + darktheme
    } else if(input$timeiso == "time-d13c"){
		p <- ggplot(ddat, aes(x = lpos, y = d13c, col = whaleid)) + geom_line() + geom_point() + ylab(expression(paste(delta^13, "C (\u2030)"))) + xlab("growth axis position (cm)") + labs(col="") + darktheme
    } else if(input$timeiso == "time-d15n") {
		p <- ggplot(ddat, aes(x = lpos, y = d15n, col = whaleid)) + geom_line() + geom_point() + ylab(expression(paste(delta^15, "N (\u2030)"))) + xlab("growth axis position (cm)") + labs(col="") + darktheme
    }
    print(p)

  })

output$downloadData <- downloadHandler(
  filename = function() {
    paste("dataset-", format(Sys.time(), "%Y%m%d%H%M%OS"), ".csv", sep="")
  },
  content = function(fname) {
    write.csv(datasetInput(), fname, row.names = FALSE)
  })

}
