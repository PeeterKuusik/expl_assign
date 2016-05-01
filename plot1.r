"Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
Using the base plotting system, make a plot showing the total PM2.5 emission
from all sources for each of the years 1999, 2002, 2005, and 2008."
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
#look data structure
str(nei)
# make spare (just in case)
x=nei
#make year a factor
x[,6]=as.factor(x[,6])
# group
x=data.frame(tapply(x$Emissions, x$year, sum), unique(x$year))
names(x)= c("emission.total","year")
x[,2]=as.Date(x[,2],"%Y")
#make plot
plot(x[,2],x[,1],type="p",pch=18,xlab= "Year", ylab = "PM2.5 emission", main = "Total PM2.5 emission in years 1999-2008")
lines(x$year,x$emission.total, col = "red")
dev.copy(png, "plot1.png")
dev.off()
