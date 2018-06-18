# PLOT_2 - Total pm2.5 emissions from 1999-2008 for Baltimore

NEI <- readRDS("./assignment/summarySCC_PM25.rds")
SCC <- readRDS("./assignment/Source_Classification_Code.rds")

# Baltimore subset

BaltimoreNEI <- subset(NEI, fips == 24510)

# Group the emissions by year and sum. convert to data.frame

sumEmissionsYear <- as.numeric(with(BaltimoreNEI, tapply(Emissions, year, sum, simplify = FALSE)))
sumEmissionsYear.df <- data.frame(Emissions = sumEmissionsYear, Year = unique(NEI$year))

png('plot2.png')
barplot(height=sumEmissionsYear.df$Emissions, names.arg=sumEmissionsYear.df$Year, xlab="Year", ylab=expression('Total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions for Baltimore by Year'))
dev.off()