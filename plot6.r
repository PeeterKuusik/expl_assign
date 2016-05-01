"Compare emissions from motor vehicle sources in Baltimore City with emissions from
motor vehicle sources in Los Angeles County, California (fips == 06037).
Which city has seen greater changes over time in motor vehicle emissions?"
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
xy=nei
xx= subset(xy,xy[,1] =="24510")
yy=subset(xy,xy[,1] =="06037")
# display groups 
table(scc[,4])
# 4 groups are corresponding to coal combustion
x= subset(scc,scc[,4]==" Mobile - On-Road Diesel Heavy Duty Vehicles")
y= subset(scc,scc[,4]=="Mobile - On-Road Diesel Light Duty Vehicles")
z= subset(scc,scc[,4]=="Mobile - On-Road Gasoline Heavy Duty Vehicles")
w= subset(scc,scc[,4]=="Mobile - On-Road Gasoline Light Duty Vehicles")
# make a df with corresponding scc
x= rbind(x,y,z,w)
# make a search vector and select all corresponding rows from nei
v= as.vector(x$SCC)
xx= xx[xx$SCC %in% v, ]
yy= yy[yy$SCC %in% v, ]
#collapse factors
aggdatax= aggregate(xx$Emissions, by=list(xx$year),FUN=sum)
aggdatay= aggregate(yy$Emissions, by=list(yy$year),FUN=sum)
#add names
names(aggdatax)=c("year","total")
names(aggdatay)=c("year","total")
#merge to 1 df
m=merge(aggdatax,aggdatay,by="year")
#give names to new df
names(m)=c("year","Baltimore","LA")
#plot
library(ggplot2)

ggplot(data=m,aes(x=year))+
  geom_line(aes( y=LA), col="red") +
  geom_line(aes( y=Baltimore), col = "blue") +
  labs(y="Emission from vehicle", title = "Compare emission of Baltimore city and Los angeles county") +
  geom_text(aes(label = "LA",x=year[2],y=LA[2]), col="red")+
  geom_text(aes(label = "Baltimore",x=year[2],y=Baltimore[2]), col = "blue") 
  
dev.copy(png, "plot6.png")
dev.off()
