# Coursera exdata-012
#   Mark Pratley
#     Assignment #2
#       Plot#6
#        11-Mar-2015

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
NEI$year.fac <- factor(NEI$year)

# Select relevant SCC rows & Coal only
SCC_MV <- select(SCC, one_of(c("SCC", "Data.Category")))
SCC_MV <- filter(SCC_MV, Data.Category=="Onroad")
SCC_MV$SCC <- as.character(SCC_MV$SCC)

# Filter for Baltimore or Los Angeles County, California
NEI_B_LA <- filter(NEI, fips == "24510" | fips == "06037")

# Join NEI to SCC_MV
NEI_B_LA <- inner_join(NEI_B_LA, SCC_MV, by = "SCC")

# Create Summary
NEI_B_LA <- NEI_B_LA %>% group_by(fips, year.fac) %>%
    summarise(Sum = sum(Emissions))

# Get Nice Names for Graph
NEI_B_LA[NEI_B_LA$fips=="06037",]$fips <- "LA County"
NEI_B_LA[NEI_B_LA$fips=="24510",]$fips <- "Baltimore"

# Check if dir exists, if not create
if (! file.exists("./myplots")) {
    dir.create("./myplots")
}
#Create PNG device
png("myplots/plot6.png", width = 480, height = 480,  bg = "transparent")

# Create a plot
p <- ggplot(data=NEI_B_LA,
            aes(x = year.fac, y=log(Sum), fill=year.fac)) +
    facet_wrap(~ fips) +
    geom_bar( stat="identity") +
    theme(legend.position = 'none') +
    xlab("Year") +
    ylab("Motor Vehicle Emissions (log)") +
    ggtitle("Motor Vehicle Emission Trend Comparison: Baltimore vs LA County") +
    geom_text(aes(label = round(Sum, 0), size = 1, hjust = 0.5, vjust = -1)) +
    stat_smooth(method = "lm",
                formula = y ~ x,
                se=FALSE,
                color="red",
                size=1.2,
                aes(group=1))

print(p)

#Close PNG device
dev.off()
