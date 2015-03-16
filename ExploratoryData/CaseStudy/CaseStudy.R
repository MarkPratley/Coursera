

# Files
# http://www.epa.gov/ttn/airs/airsaqs/detaildata/501files/Rd_501_88101_1999.Zip
# http://www.epa.gov/ttn/airs/airsaqs/detaildata/501files/Rd_501_88101_2012.Zip

zip1999 <- "./temp/RD_501_88101_1999.zip"
zip2012 <- "./temp/RD_501_88101_2012.zip"

file1999 <- "./temp/RD_501_88101_1999-0.txt"
file2012 <- "./temp/RD_501_88101_2012-0.txt"

if (!file.exists(file1999))
    unzip(zip1999, exdir="./temp")

if (!file.exists(file2012))
    unzip(zip2012, exdir="./temp")

# pm1999 <- read.csv(file1999)
# pm2012 <- read.csv(file2012)