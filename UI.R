library(shiny)
library(ggplot2)

dat <- read.table("masteriso.csv", header = TRUE, sep = ',')
allowedids <- c("bp01", "bp02", "bp03", "bp04", "bp05", "bp06", "bp07", "bp14", "bp15", "eg01")
dese <- which(dat$whaleid %in% allowedids)
dat <- dat[dese, ]
dat$whaleid <- as.character(dat$whaleid)
u_id <- sort(unique(dat$whaleid))

xchoices <- c("growth position", "d13c", "d15n")
ychoices <- c("growth position", "d13c", "d15n")

fluidPage(
  tags$head(
	tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),
	
  sidebarLayout(
	  sidebarPanel(
		tags$style(".well {background-color: #ffffff; border: 0;}"), width = 3,
		div(style = "color: #000000; background: #ffffff", selectInput('animal_id', "animal_id", u_id, multiple = TRUE)),
		div(style = "color: #000000; background: #ffffff", selectInput('timeiso', 'plot_type', c("c-n-isospace", "time-d13c", "time-d15n")))),
		# div(style = "color: #000000; background: #ffffff", downloadLink('downloadData', 'download_dataset'))),

	  mainPanel(
		plotOutput("plot"))
	)
)
