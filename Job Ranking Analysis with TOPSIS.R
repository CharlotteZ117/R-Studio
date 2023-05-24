
data<-read.csv("Best_Worst_Jobs_Ranking_2014.csv");data

nrow(data)

library(dplyr)
library(ggplot2)

data1<-data %>%
  select(Ranking,Median.Salary....);data1

model<-lm(Ranking~Median.Salary....,data=data1)
summary(model)

ggplot(data1,aes(x=Median.Salary....,y=Ranking))+
  geom_point(size=3,col="red")+
  geom_smooth(method=lm,col="blue",se=FALSE)

original<-read.csv("Best_Worst_Jobs_Ranking_2014.csv")

salaryRanking<-original%>%
  arrange(desc(Median.Salary....))

salaryRanking$Salary.Ranking<-c(1:199)
head(salaryRanking)
salaryRanking<-salaryRanking%>%
  select(Job,Salary.Ranking)

total1<-left_join(original,salaryRanking,by=c("Job"="Job"))
head(total1,n=10)

total<-total1[-c(1:4)]
colnames(total)<-NULL
total<-as.matrix(total)

#TOPSIS
dr_sum<- matrix(apply(total,2,sum),nrow=1,ncol=4)
p_ij<-total/dr_sum[col(total)]
e_j<- (-1/log(65))*apply((p_ij*log(p_ij)),2,sum)
d_j<-1-e_j

w_j<-d_j/sum(d_j)
w<-w_j
i <-c("+","+","+","+")
topsisRank<-topsis(total,w,i)
head(topsisRank,10)
#We alternate the Topsis ranking into the ranking by using 200 minus the TOPSIS ranking.
topsisRank<-as.data.frame(topsisRank)
topsisRank$rank<-(200-topsisRank$rank)
head(topsisRank)

final<-cbind(total1,topsisRank$rank)
colnames(final)<-c("Careercast.Ranking","Job","Overall.Rating", "Median.Salary", "Stress.Ranking", "Job.Growth.Ranking", "WorkEnvironment.Ranking","MedianSalary.Ranking","Topsis.Ranking")

#Compare two the provided overall ranking and the ranking of our TOPSIS method.
displayRanking<-final%>%
  select(Job,Careercast.Ranking,Topsis.Ranking)
head(displayRanking,15)
tail(displayRanking,15)

diff<-(displayRanking$Careercast.Ranking-displayRanking$Topsis.Ranking)
mean(diff)
sum(diff)
sd(diff)



