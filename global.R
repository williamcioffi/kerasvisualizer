# globally available data

# prep data
# run only once
# dat <- read.table("data/isodata.csv", header = TRUE, sep = ',', stringsAsFactors = FALSE)
# dese <- which(!is.na(dat$replicate))
# dat <- dat[-dese[duplicated(dat$replicate[dese])], ]
# write.table(dat, file = "data/isodata_noreps.csv", sep = ',', row.names = FALSE)

dat <- read.table("data/isodata_noreps.csv", header = TRUE, sep = ',', stringsAsFactors = FALSE)
u_id <- sort(unique(dat$whaleid))

oo <- order(dat$lpos)
dat <- dat[oo, ]
oo <- order(dat $whaleid)
dat <- dat[oo, ]