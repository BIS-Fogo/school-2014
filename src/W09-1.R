#  Example solution of W08-1 from the BIS-Fogo school 2014
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
data_2014 <- read.csv("fieldSurvey2014_Subset01.csv")

#### Run linear model and prediction from W05-1 again ##########################

source("/home/hanna/Documents/Projects/KapVerde/winterSchool/bis-fogo/analysis/W05-1.R")

#### Modify plots ##############################################################
### scatter plot:
plot(animals_predicted,data_2014$ANIMALS)
### change axis names
plot(animals_predicted,data_2014$ANIMALS,xlab="predicted",ylab="observed")

### add a title
plot(animals_predicted,data_2014$ANIMALS,xlab="predicted",ylab="observed",
     main="Validation")

### change the symbols according to http://www.statmethods.net/advgraphs/parameters.html
plot(animals_predicted,data_2014$ANIMALS,xlab="predicted",ylab="observed",
     main="Validation",pch=16)

### change the color
plot(animals_predicted,data_2014$ANIMALS,xlab="predicted",ylab="observed",
     main="Validation",pch=16,col="blue")

### add a legend
legend("topleft",pch=16,col="blue",legend="data points")

### add a diagonal line where oberved is equal predicted
lines(c(0,200),c(0,200))

