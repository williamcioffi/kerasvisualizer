library(shiny)
library(ggplot2)

xchoices <- c("growth position", "d13c", "d15n")
ychoices <- c("growth position", "d13c", "d15n")

fluidPage(
	tags$head(
		tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
	),
	title = "keras visualizer",
	fluidRow(
		column(4,
			div(style = "color: #000000; background: #ffffff", selectInput('animal_id', "animal_id", u_id, multiple = TRUE, width = "100%"))
		),
		column(3,
			div(style = "color: #000000; background: #ffffff", selectInput('timeiso', 'plot_type', c("c-n-isospace", "time-d13c", "time-d15n"), width = "100%"))
		),
		width = "100%"
			
	),
	
	plotOutput("plot")
)