
"Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
Which have seen increases in emissions from 1999–2008?
Use the ggplot2 plotting system to make a plot answer this question."

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
#look data structure
str(nei)
# make spare (just in case)
x=nei
x= subset(x,x[,1] =="24510")


#make year,type a factor
x[,6]=as.factor(x[,6])
x[,5]=as.factor(x[,5])
#collapse factors
aggdata= aggregate(x$Emissions, by=list(x$year,x$type),sum)
#add names
names(aggdata)= c("year","type","emission.total")

#make plot
library(ggplot2)
qplot(aggdata$year, aggdata$emission,data = aggdata, group = type ,geom = "line", facets = . ~ type, col = type, xlab = "Year", ylab="Emission")
dev.copy(png, "plot3.png")
dev.off()