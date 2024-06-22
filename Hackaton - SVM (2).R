library("tm")              # For Text Mining of Data
library("ggplot2")         # Excellent package for data visualization
library("RTextTools")      # For predictive Text Classification using Supervised LEarning
library("lda")             # For Topic Modeling using lda 
library("LDAvis")          # For Topic Modeling Visualization
library("servr") 
setwd("D:/RWorkspace/")
test= read.csv("Incident_Data_Final.csv", header = TRUE,stringsAsFactors = FALSE)
str(test)

svmInputData <- data.frame(cbind(test$inc_description,test$inc_u_item))
dtMatrix <- create_matrix(svmInputData["X1"],language="english",removeStopwords =TRUE , removeNumbers=FALSE, stemWords=FALSE, removePunctuation=TRUE)

container <- create_container(dtMatrix, svmInputData$X2, trainSize=1:14771, virgin=FALSE)
# train a SVM Model
model <- train_model(container, "SVM", kernel="linear", cost=1)
trace("create_matrix",edit=T)
predictionData <- list( " Enterprise unit not defined for work center WS 3194")
predictionData <- list( "Need to perform a cycle counting in 794005 but some items are located without SKID and they cannot perform the job.")
predMatrix <- create_matrix(predictionData, originalMatrix=dtMatrix)
predSize = length(predictionData);
predictionContainer <- create_container(predMatrix, labels=rep(0,predSize), testSize=1:predSize, virgin=FALSE)
results <- classify_model(predictionContainer, model)
results
