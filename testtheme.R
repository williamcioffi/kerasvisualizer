library(ggplot2)

dat <- read.table("masteriso.csv", header = TRUE, sep = ',')
allowedids <- c("bp01", "bp02", "bp03", "bp04", "bp05", "bp06", "bp07", "bp14", "bp15", "ega")
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



darktheme <- theme(axis.text = element_text(colour = "#9d9a92"), axis.title.x = element_text(colour = "#9d9a92"), axis.title.y = element_text(colour = "#9d9a92"), panel.background = element_rect(fill="black"), plot.background = element_rect(fill="black"),
panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
legend.background = element_rect(fill = "black"), legend.text = element_text(colour = "#9d9a92"), legend.key = element_rect(fill = "transparent", colour = "transparent"), axis.line.x = element_line(color="#9d9a92"), axis.line.y = element_line(color="#9d9a92")
)


p <- p <- ggplot(mer, aes(x=d13c, y=d15n, col = whaleid)) + geom_point() + xlab(expression(paste(delta^13, C))) + ylab(expression(paste(delta^15, N))) + darktheme
p