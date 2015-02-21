# Coursera rprog-011
#   Mark Pratley
#     Assignment #1
#       Part #1
#        17-Feb-2015
 
pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  
  # Read In the files
  files = list.files(directory, full.names=TRUE)
  
  # Read the (selected) files into a list first
  data_list = lapply(files[id], read.csv)
     
  # Then Put list into dataframe
  df <- do.call(rbind, data_list)
  
  # Get the mean and remove the na's
  mean(df[, pollutant], na.rm = TRUE)
}