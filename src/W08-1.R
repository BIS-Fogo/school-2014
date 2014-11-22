#  Example solution of W8-1 from the BIS-Fogo school 2014
#
#  Copyright (C) 2014 Hanna Meyer, Alice Ziegler, Vanessa Wilzek, Thomas Nauss
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#  Please send any comments, suggestions, criticism, or (for our sake) bug
#  reports to admin@environmentalinformatics-marburg.de
# 
#  Details:
#  The script fits and predicts the animal abundance for all field survey sites of the
#  2014 survey using a loess model.
#
rm(list = ls(all = T))

#### Load required packages ####################################################

library(rgdal)
library(raster)

#### Define Working directory ##################################################

working_directory <- "D:/bis-fogo/school2014/data/field-campaign_2014/procd/"
script_directory <- "D:/bis-fogo/school2014/scripts/"
setwd(working_directory)

#### Read data ########################################################

data_2014 <- read.csv("fieldSurvey2014_Subset01.csv")

#### Plot Animals ~ coverage ###################################################

plot(data_2014$COVRG,data_2014$ANIMALS)

#### Do a loess model ##########################################################

loess_model <- loess(data_2014$ANIMALS ~ data_2014$COVRG)

#### Show prediction results ###################################################

x<-data_2014$COVRG
predict.x<-min(x):max(x)
lines(predict.x,predict(loess_model,newdata=predict.x),lwd=2,col="red")

#### Do leave one out cross validation #########################################

prediction_error_loess=c()
for (i in 1:length(data_2014$ANIMALS)){
  loess_model <- loess(data_2014$ANIMALS[-i] ~ data_2014$COVRG[-i])
  predict.x <- data_2014$COVRG[i]
  animals_predicted <- predict(loess_model,newdata=predict.x)
  prediction_error_loess[i] <- data_2014$ANIMALS[i] - animals_predicted 
}

#### Calculate Mean prediction Error ###########################################
mean(abs(prediction_error_loess),na.rm=T)

#### Compare to prediction error from linear model #############################
source(paste0(script_directory,"/W06-1.R"))

print (mean(abs(prediction_error),na.rm=T))
