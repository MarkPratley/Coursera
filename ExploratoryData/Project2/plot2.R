# Coursera exdata-012
#   Mark Pratley
#     Assignment #2
#       Plot#2
#        09-Mar-2015

library(dplyr)
library(ggplot2)

# magic url & files names
NEIfile <- "summarySCC_PM25.rds"
SCCfile <- "Source_Classification_Code.rds"
url     <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "data.zip"

# Reads & Cleans Files - (Downloads if required)
#  Returns the file
getFile <- function(file) {
    
    if (!file.exists(file)) {
        print("File not found - downloading zips...")
        getFiles()
    }
    
    if (!file.exists(file))
        stop("Can't find or get files")
    
    print(paste(file, "found - loading data into R..."))    
    ret = readRDS(file)
}

# Downloads & Unzips data to working directory  - called if not already there
getFiles <- function() {
    
    download.file(url, zipFile)
    unzip(zipFile, overwrite = TRUE)
}

## -----------------------------------------

# Get Files. If not already in memory then...
#  Load if available or downloaded and load if not
if (!exists("NEI"))
    NEI <- getFile( NEIfile )

if (!exists("SCC"))
    SCC <- getFile( SCCfile )

# Create year category
NEI$year.cat <- factor(NEI$year)

# Check Folder
# Check if dir exists, if not create
if (! file.exists("./myplots")) {
    dir.create("./myplots")
}
#Create PNG device
png("myplots/plot2.png", width = 480, height = 480,  bg = "transparent")

#Draw the histogram to the PNG device
Baltimore <- filter(NEI, fips == "24510")
years <- tapply(Baltimore$E, Baltimore$year.cat, sum)
barplot(years,
        main = expression('Total Emissions in Baltimore of PM'[2.5]),
        xlab = "Year",
        ylab = "Total Emissions",
        col = "brown")

#Close PNG device
dev.off()
