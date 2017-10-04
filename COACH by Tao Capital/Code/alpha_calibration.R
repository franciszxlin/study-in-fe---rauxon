library(forecast)
setwd("C:/Users/adelyn.yeoh/Google Drive/0 CMU/Class/Mini 5/FE/Case2")
data = read.csv("data_r.csv")

df = data.frame(data[1], data[2], data[3])
fit1=lm(df$y~df$x_1)
summary(fit1)

deltt=1/52
alpha1 = -fit1$coefficients[2]/deltt
theta1 = fit1$coefficients[1]/(alpha1*deltt)


fit2=lm(df$y2~df$x_1)
summary(fit2)
alpha2 = (1-fit2$coefficients[2])/deltt
theta2 = (fit2$coefficients[1])/(alpha2*deltt)

par(mfrow=c(1,2))
plot(as.numeric(fit2$fitted.values),as.numeric(fit2$resid),
     pch=16,xlab="Fitted Values", 
     ylab="Residuals",cex.axis=1.3,cex.lab=1.3)

qqnorm(as.numeric(fit2$resid),cex.axis=1.3,cex.lab=1.3,pch=16,main="")
qqline(as.numeric(fit2$resid))
