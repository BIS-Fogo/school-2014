#  Example solution of W05-1 from the BIS-Fogo school 2014
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
#  The script revisites the computation of a regression and focuses on normal
#  distribution and interpretability of R2.
#
rm(list = ls(all = T))


#### Load required libraries ###################################################
library(car)      # needed for regression lines


#### Define Working directory ##################################################
working_directory <- "D:/bis-fogo/school2014/data/field-campaign_2014/procd/"
setwd(working_directory)


#### Read table ################################################################
data_2014 <- read.csv("fieldSurvey2014_Subset01.csv")

#look at distribution of the regression variables
hist(data_2014$COVRG)
#try sqrt transformation
hist(sqrt(data_2014$COVRG))
hist(data_2014$ANIMALS)
hist(sqrt(data_2014$ANIMALS))


#### Do the regression again with sqrt transformation ##########################
data_2014$COVRG_SQRT <- sqrt(data_2014$COVRG)
data_2014$ANIMALS_SQRT <- sqrt(data_2014$ANIMALS)
head(data_2014)

plot(data_2014$COVRG_SQRT,data_2014$ANIMALS_SQRT)
linear_model <- lm(data_2014$ANIMALS_SQRT~ data_2014$COVRG_SQRT)
summary(linear_model)
regLine(linear_model)

qqPlot(linear_model)


#### Predict Animals for each plot #############################################
animales_predicted <- predict(linear_model,data.frame(data_2014$COVRG_SQRT))


#### Transform result back  ####################################################
animales_predicted = animales_predicted ^2


#### Plot results  #############################################################
plot(data_2014$COVRG,animales_predicted)

