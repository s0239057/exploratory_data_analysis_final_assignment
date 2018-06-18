# PLOT_5 - Plot emissions from motor vehicles across 1999 - 2008

NEI <- readRDS("./assignment/summarySCC_PM25.rds")
SCC <- readRDS("./assignment/Source_Classification_Code.rds")

# subset for motor vehicle and then for Baltimore

SCCMotVeh <- SCC[(grepl("Motor|Vehicle", SCC$Short.Name, ignore.case=TRUE)),]
NEI_MotVeh = merge(NEI, SCCMotVeh, by = "SCC")

NEI_MotVeh_Baltmore <- subset(NEI_MotVeh, fips == 24510)

sumEmissionsMV <- as.numeric(with(NEI_MotVeh_Baltmore, tapply(Emissions, year, sum, simplify = FALSE)))
sumEmissionsMV.df <- data.frame(Emissions = sumEmissionsMV, Year = unique(NEI$year))

png('plot5.png')
barplot(height=sumEmissionsMV.df$Emissions, names.arg=sumEmissionsMV.df$Year, xlab="Year", ylab=expression('Total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions by motor vehicle, by Year, in Baltimore'))
dev.off()