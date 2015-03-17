

# Files
rfile1999 <- "https://www.epa.gov/ttn/airs/airsaqs/detaildata/501files/Rd_501_88101_1999.zip"
rfile2012 <- "http://www.epa.gov/ttn/airs/airsaqs/detaildata/501files/Rd_501_88101_2012.zip"

zip1999 <- "./temp/RD_501_88101_1999.zip"
zip2012 <- "./temp/RD_501_88101_2012.zip"

file1999 <- "./temp/RD_501_88101_1999-0.txt"
file2012 <- "./temp/RD_501_88101_2012-0.txt"

if (!file.exists(file1999)){
    
    if (!file.exists(zip1999))
        download.file(rfile1999, zip1999)
    unzip(zip1999, exdir="./temp")
}

if (!file.exists(file2012)) {
 
    if (!file.exists(zip2012))
        download.file(rfile2012, zip2012)
    unzip(zip2012, exdir="./temp")
}

pm0 <- read.table(file1999, comment.char="#", sep = "|", na.strings="", header = FALSE)
names0 <- readLines(file1999, n = 1)
names0 <- strsplit(names0, "|", fixed = TRUE)
names(pm0) <- make.names(names0[[1]])


pm1 <- read.table(file2012, comment.char="#", sep = "|", na.strings="", header = FALSE)
names1 <- readLines(file2012, n = 1)
names1 <- strsplit(names1, "|", fixed = TRUE)
names(pm1) <- make.names(names1[[1]])

dates <- pm1$Date
dates <- strptime(dates, format = "%Y%m%d")


site0 <- unique(subset(pm0, State.Code==36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code==36, c(County.Code, Site.ID)))

site0 <- paste(site0[,1], site0[,2], sep=".")
site1 <- paste(site1[,1], site1[,2], sep=".")
both <- intersect(site0, site1)

pm0$County.Site <- paste(pm0$County.Code, pm0$Site.ID, sep=".")
pm1$County.Site <- paste(pm1$County.Code, pm1$Site.ID, sep=".")

cnt0 <- subset(pm0, State.Code==36 & County.Site %in% both)
cnt1 <- subset(pm1, State.Code==36 & County.Site %in% both)

sapply(split(cnt0, cnt0$County.Site), nrow)
sapply(split(cnt1, cnt1$County.Site), nrow)

pm0sub <- subset(pm0, County.Site=="63.2008")
pm1sub <- subset(pm1, County.Site=="63.2008")

dates0 <- strptime(pm0sub$Date, format = "%Y%m%d")
dates1 <- strptime(pm1sub$Date, format = "%Y%m%d")

x0sub <- pm0sub$Sample.Value
x1sub <- pm1sub$Sample.Value

plot(dates0, x0sub)
plot(dates1, x1sub)




