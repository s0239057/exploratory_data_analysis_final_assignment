# load the data

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
if(!dir.exists("NEI_data")) { dir.create("NEI_data") }

download.file(file_url, destfile = "NEI_data/NEI_data.zip")
unzip("NEI_data/NEI_data.zip", exdir = "NEI_data")
file.remove("NEI_data/NEI_data.zip")