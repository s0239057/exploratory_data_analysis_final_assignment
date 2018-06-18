# PLOT_3 - Plot showing the source type variation over the years 1999 - 2008, in Baltimore

library(plyr)
library(ggplot2)

NEI <- readRDS("./assignment/summarySCC_PM25.rds")
SCC <- readRDS("./assignment/Source_Classification_Code.rds")

# use ddply to factor the data by Year and Type

BaltimoreNEI <- subset(NEI, fips == 24510)
sumEmissions_TY <- ddply(BaltimoreNEI, .(year, type), summarize, sumAll = sum(Emissions))

# plot the sum of emissions for each type for each year

png('plot3.png')
TY_plot <- ggplot(sumEmissions_TY, aes(as.factor(year), sumAll)) + geom_point(shape=16, color = 'black', alpha = 0.5)
TY_plot <- TY_plot + facet_grid(~type) 
TY_plot <- TY_plot + labs(x = "Year", y = expression('Total PM'[2.5]*' emission'), title = expression('Total PM'[2.5]*' emissions for Baltimore by type, by Year'))
TY_plot + theme(axis.text=element_text(size=8))
dev.off()