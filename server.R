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
	text = element_text(size = 20))

dat <- read.table("masteriso.csv", header = TRUE, sep = ',')
allowedids <- c("bp01", "bp02", "bp03", "bp04", "bp05", "bp06", "bp07", "bp14", "bp15", "eg01")
dese <- which(dat$whaleid %in% allowedids)
dat <- dat[dese, ]
dat$whaleid <- as.character(dat$whaleid)
u_id <- sort(unique(dat$whaleid))

master <- read.table("mastersamplesheet.csv", header = TRUE, sep = ',')
mer <- merge(dat, master, by.x = "sampleid", by.y = "full_label")

oo <- order(mer$lpos)
mer <- mer[oo, ]
oo <- order(mer$whaleid)
mer <- mer[oo, ]

datdl = data.frame(id = NA, lpos = NA, d13c = NA, d15n = NA)
function(input, output) {
datasetInput <- reactive({
    animals <- which(dat$whaleid %in% input$animal_id)
	dat2 <- dat[animals, ]
	animals <- which(mer$whaleid %in% input$animal_id)
	mer2 <- mer[animals, ]
	
	data.frame(whaleid = mer2$whaleid, lpos = mer2$lpos, d13c = mer2$d13c, d15n = mer2$d15n)
  })
  
  output$plot <- renderPlot({
	ddat <- datasetInput()
	
	if(input$timeiso == "c-n-isospace") {
    		p <- ggplot(ddat, aes(x=d13c, y=d15n, col = whaleid)) + geom_point() + xlab(expression(paste(delta^13, C))) + ylab(expression(paste(delta^15, N))) + labs(col="") + darktheme
    } else if(input$timeiso == "time-d13c"){
		p <- ggplot(ddat, aes(x = lpos, y = d13c, col = whaleid)) + geom_line() + geom_point() + ylab(expression(paste(delta^13, C))) + xlab("growth axis position (cm)") + labs(col="") + darktheme
    } else if(input$timeiso == "time-d15n") {
		p <- ggplot(ddat, aes(x = lpos, y = d15n, col = whaleid)) + geom_line() + geom_point() + ylab(expression(paste(delta^15, N))) + xlab("growth axis position (cm)") + labs(col="") + darktheme
    }
    print(p)

  }, height = 400, width = 600)

output$downloadData <- downloadHandler(
  filename = function() {
    paste("dataset-", format(Sys.time(), "%Y%m%d%H%M%OS"), ".csv", sep="")
  },
  content = function(fname) {
    write.csv(datasetInput(), fname, row.names = FALSE)
  })

}
