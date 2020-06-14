library(shiny)
library(ggplot2)

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
		width = "50%",
    tags$head(tags$style(type="text/css", ".container-fluid { max-width: 800px; }"))
			
	),
	
	plotOutput("plot", width = "100%", height = "350px")
)