#  Example solution of W06-1 from the BIS-Fogo school 2014
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
#  The script predicts the animal abundance for all field survey sites of the
#  2014 survey.
#
rm(list = ls(all = T))


#### Define Working directory ##################################################
working_directory <- "D:/bis-fogo/school2014/data/field-campaign_2014/procd/"
setwd(working_directory)


#### Read table ################################################################
data_2014 <- read.table("fieldSurvey2014_Subset01.csv", sep = ",", dec = ".",
                        header = TRUE)


#### Transform data ############################################################
data_2014$COVRG_SQRT <- sqrt(data_2014$COVRG)
data_2014$ANIMALS_SQRT <- sqrt(data_2014$ANIMALS)

#### Leave one out cross validation ############################################
prediction_error=c()
for (i in 1:length(data_2014$ANIMALS)){
  linear_model <- lm(data_2014$ANIMALS_SQRT[-i] ~ data_2014$COVRG_SQRT[-i])
  intercept <- linear_model$coefficients[1]
  slope <- linear_model$coefficients[2]
  animals_predicted <- slope*data_2014$COVRG_SQRT[i] + intercept #y=ax+b
  animals_predicted <- animals_predicted^2
  prediction_error[i] <- data_2014$ANIMALS[i] - animals_predicted
  
}


#### Calculate Mean prediction Error ###########################################
mean(abs(prediction_error),na.rm=T)
