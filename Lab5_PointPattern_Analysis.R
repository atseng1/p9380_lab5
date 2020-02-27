require(RPostgres)

conn <- dbConnect(RPostgres::Postgres(), dbname = 'advanced_gis', 
                  host = 'localhost', # i.e. 'your computer'
                  port = 5432, # or any other port specified by your DBA
                  user = 'postgres',
                  password = 'jeremy')


options(digits = 10)

oc_prop_SLOSH <- dbFetch(dbSendQuery(conn, "SELECT c1_high, c2_high, c3_high, c4_high  
                                     FROM lab5.oc_prop_slosh_samp"))

oc_sale_data <- dbFetch(dbSendQuery(conn, "SELECT * FROM lab4.oc_prop"))

head(oc_prop_SLOSH)
head(oc_sale_data)


data <- cbind(oc_sale_data,oc_prop_SLOSH)

head(data, n=10)
summary(data)
data$x <- as.numeric(data$x)
data$y <- as.numeric(data$y)

head(data, n=10)
summary(data)

plot(data, axes=T)

require(rgdal)
require(maptools)
require(spatstat)
 

border <- owin()
w <- owin(c(-75.8,-75.0), c(38.0,38.5))


head(data)

data_c1 <- subset(data, c1_high > 0) 
data_c2 <- subset(data, c2_high > 0 & c1_high ==0) 
data_c3 <- subset(data, c3_high > 0 & c2_high ==0) 
data_c4 <- subset(data, c4_high > 0 & c3_high ==0) 

plot(data_c1)
plot(data_c2)
plot(data_c3)
plot(data_c4)


MD_border1<-ppp(data_c1$x,data_c1$y,window=w)
plot(MD_border1)
L_c1<-envelope(MD_border1, Lest, nsim=10, rank=2, global=T)

MD_border2<-ppp(data_c2$x,data_c2$y,window=w)
L_c2<-envelope(MD_border2, Lest, nsim=10, rank=2, global=T)

MD_border3<-ppp(data_c3$x,data_c3$y,window=w)
L_c3<-envelope(MD_border3, Lest, nsim=10, rank=2, global=T)

MD_border4<-ppp(data_c4$x,data_c4$y,window=w)
L_c4<-envelope(MD_border4, Lest, nsim=10, rank=2, global=T)


################



dev.off()
par(mfrow=c(2,2))

plot(L_c1, cex=0.03, main=NULL, ylab="Density Function", 
     xlab="Distance: C1", legend=F)
plot(L_c2, cex=0.03, main=NULL, ylab="Density Function", 
     xlab="Distance: C2", legend=F)
plot(L_c3, cex=0.03, main=NULL, ylab="Density Function", 
     xlab="Distance: C3", legend=F)
plot(L_c4, cex=0.03, main=NULL, ylab="Density Function", 
     xlab="Distance: C4", legend=F)
mtext("Global Cluster of Unique Homes at Risk of Storm Surge by Hurricane Class", side =3,
      line = -2, outer = TRUE, cex = 1.0)



