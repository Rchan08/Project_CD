library(dplyr)

download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile = "Base.zip")

actlab<-read.table("activity_labels.txt",header = FALSE,stringsAsFactors = FALSE)
feat<-read.table("features.txt",stringsAsFactors = FALSE,header = FALSE)

train<-"./train/"
test<-"./test/"

##### Datos para estimacion #####

Xtrain<-read.table(paste(train,"X_train.txt",sep=""),stringsAsFactors = FALSE,header = FALSE)
ytrain<-read.table(paste(train,"y_train.txt",sep=""),stringsAsFactors = FALSE,header = FALSE)
subjtrain<-read.table(paste(train,"subject_train.txt",sep = ""),stringsAsFactors = FALSE,header = FALSE)

names(Xtrain)<-feat$V2

names(actlab)<-c("V1","Actividad")

etiqacti<-merge(ytrain,actlab,by.y = "V1",by.x = "V1",sort=FALSE)

train<-data.frame(Actividad=etiqacti[,"Actividad"],sujeto=subjtrain$V1,datos=Xtrain)

##### Datos para comparacion ####

sujetoprueba<-read.table("./test/subject_test.txt",stringsAsFactors = FALSE,header = FALSE)
Ytest<-read.table("./test/y_test.txt",stringsAsFactors = FALSE,header = FALSE)
Xtest<-read.table("./test/X_test.txt",stringsAsFactors = FALSE,header = FALSE)
names(Xtest)<-feat$V2
actividadtest<-merge(Ytest,actlab,by.x = "V1",by.y = "V1",sort = FALSE)
test<-data.frame(Actividad=actividadtest$Actividad,sujeto=sujetoprueba$V1,datos=Xtest)

###### Base Unica #########

baseunica<-rbind(test,train)

##### Sustrayendo unicamente desviaciones y medias #####
obs<-grep("tGravityAcc.mean|tGravityAcc.std|tBodyGyro.mean|tBodyGyro.std|tBodyAcc.mean|tBodyAcc.std",names(baseunica),value = TRUE)
baseUmedesv<-baseunica[,c("sujeto","Actividad",obs)]

####### Limpiando nombres de variables #####
#Retirar el nombre 'datos', los guiones y puntos
auxnom<-gsub("datos.","",names(baseUmedesv))
auxnom<-gsub("-","",auxnom)
auxnom<-gsub("\\.","",auxnom)
names(baseUmedesv)<-auxnom

##Generar los promedios de cada actividad de cada sujeto
baseUmedesv$sujeto<-factor(baseUmedesv$sujeto)
baseUmedesv$Actividad<-factor(baseUmedesv$Actividad)
agrupa<-group_by(baseUmedesv,sujeto,Actividad)
summarize(agrupa,baseUmedesv[3:ncol(baseUmedesv)]=colMeans(baseUmedesv[3:ncol(baseUmedesv)]))

resumen<-baseUmedesv%>%group_by(sujeto,Actividad)%>%summarize(tBodyAccmeanX=mean(tBodyAccmeanX,na.rm=TRUE),
                                                              tBodyAccmeanY=mean(tBodyAccmeanY,na.rm=TRUE),
                                                              tBodyAccmeanZ=mean(tBodyAccmeanZ,na.rm=TRUE),
                                                              tBodyAccstdX=mean(tBodyAccstdX,na.rm=TRUE),
                                                              tBodyAccstdY=mean(tBodyAccstdY,na.rm=TRUE),
                                                              tBodyAccstdZ=mean(tBodyAccstdZ,na.rm=TRUE),
                                                              tGravityAccmeanX=mean(tGravityAccmeanX,na.rm=TRUE),
                                                              tGravityAccmeanY=mean(tGravityAccmeanY,na.rm=TRUE),
                                                              tGravityAccmeanZ=mean(tGravityAccmeanZ,na.rm=TRUE),
                                                              tGravityAccstdX=mean(tGravityAccstdX,na.rm=TRUE),
                                                              tGravityAccstdY=mean(tGravityAccstdY,na.rm=TRUE),
                                                              tGravityAccstdZ=mean(tGravityAccstdZ,na.rm=TRUE),
                                                              tBodyGyrostdX=mean(tBodyGyrostdX,na.rm=TRUE),
                                                              tBodyGyrostdY=mean(tBodyGyrostdY,na.rm=TRUE),
                                                              tBodyGyrostdZ=mean(tBodyGyrostdZ,na.rm=TRUE),
                                                              tBodyGyromeanX=mean(tBodyGyromeanX,na.rm=TRUE),
                                                              tBodyGyromeanY=mean(tBodyGyromeanY,na.rm=TRUE),
                                                              tBodyGyromeanZ=mean(tBodyGyromeanZ,na.rm=TRUE))

write.table(resumen,file = "DataBase.txt",sep="",row.names = FALSE)
