# PLOT_4 - Plot coal combustibles across USA 1999 - 2008

NEI <- readRDS("./assignment/summarySCC_PM25.rds")
SCC <- readRDS("./assignment/Source_Classification_Code.rds")

# retain only SCC with coal & combustion in the short name, merge by coal & comb codes

SCCcombCoal <- SCC[(grepl("Comb /|Coal", SCC$Short.Name, ignore.case=TRUE)),]
NEI_CoalComb = merge(NEI, SCCcombCoal, by = "SCC")

# now sum over each year for the coal & comb emissions

sumEmissions_CoalComb <- as.numeric(with(NEI_CoalComb, tapply(Emissions, year, sum, simplify = FALSE)))
sumEmissions_CoalComb.df <- data.frame(Emissions = sumEmissions_CoalComb, Year = unique(NEI$year))
sumEmissions_CoalComb.df$Emissions <- sumEmissions_CoalComb.df$Emissions/1000

png('plot4.png')
barplot(height=sumEmissions_CoalComb.df$Emissions, names.arg=sumEmissions_CoalComb.df$Year, xlab="Year", ylab=expression('Total PM'[2.5]*' emission (tonnes)'),main=expression('Total PM'[2.5]*' emissions by Year for Coal'))
dev.off()