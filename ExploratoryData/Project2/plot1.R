# Coursera exdata-012
#   Mark Pratley
#     Assignment #2
#       Plot#1
#        09-Mar-2015

# magic url & files names
files   <- c("summarySCC_PM25.rds", "Source_Classification_Code.rds")
url     <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
zipFile <- "data.zip"

# Reads & Cleans Files - (Downloads if required)
#  Returns a list containing the 2 files
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

## File reading and plotting begins here ##

# Get Files  will be downloaded if required
NEI <- getFile("summarySCC_PM25.rds")
SCC <- getFile("Source_Classification_Code.rds")

# Create year category
NEI$year.cat <- factor(NEI$year)



#Create PNG device
png("myplots/plot1.png", width = 480, height = 480,  bg = "transparent")

#Draw the histogram to the PNG device


#Close PNG device
dev.off()
