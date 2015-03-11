# Coursera exdata-012
#   Mark Pratley
#     Assignment #2
#       Plot#3
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

# Create useful factors
NEI$year.cat <- factor(NEI$year)
NEI$type <- factor(NEI$type)

# Check Folder
# Check if dir exists, if not create
if (! file.exists("./myplots")) {
    dir.create("./myplots")
}
#Create PNG device
png("myplots/plot3.png", width = 480, height = 480,  bg = "transparent")

# Filter for Baltimore
NEI_Baltimore <- filter(NEI, fips == "24510")

# Group by type and year. Sum Emissions
NEI_B_by_type_year <- NEI_Baltimore %>%
    group_by(type, year.cat) %>%    
    summarise(
        Sum = sum(Emissions)
    )

# Create a plot
p <- ggplot(data=NEI_B_by_type_year,
       aes(x = year.cat, y=log(Sum), fill=year.cat)) +
        geom_bar( stat="identity") +
        theme(legend.position = 'none') +
        facet_wrap(~ type) +
        geom_smooth(method = "lm",
                      se=FALSE,
                      color="red",
                      size=1.2,
                      aes(group=1)) +
        xlab("Year") +
        ylab("log(Emissions)") +
        ggtitle("Emission Trend by Type over Time in Baltimore")

print(p)

#Close PNG device
dev.off()
