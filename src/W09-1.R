#  Example solution of W09-1 from the BIS-Fogo school 2014
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
#  The script shows some basic functions to modify the default plots.
#
rm(list = ls(all = T))

#### Define Working directory ##################################################
working_directory <- "D:/active/bis-fogo/school2014/"
in_path <- paste0(working_directory,"data/field-campaign_2014/procd/")
out_path <- paste0(working_directory,"analysis/")
setwd(working_directory)


#### Read table ################################################################
data_2014 <- read.table(paste0(in_path, "fieldSurvey2014_Subset01.csv"), 
                        sep = ",", dec = ".", header = TRUE)


#### Run linear model and prediction from W06-1 again ##########################
source("/home/hanna/Documents/Projects/KapVerde/winterSchool/bis-fogo/analysis/W06-1.R")


#### Modify plots ##############################################################
### scatter plot:
plot(animals_predicted_loocv,data_2014$ANIMALS)
### change axis names
plot(animals_predicted_loocv,data_2014$ANIMALS,xlab="predicted",ylab="observed")

### add a title
plot(animals_predicted_loocv,data_2014$ANIMALS,xlab="predicted",ylab="observed",
     main="Validation")

### change the symbols according to http://www.statmethods.net/advgraphs/parameters.html
plot(animals_predicted_loocv,data_2014$ANIMALS,xlab="predicted",ylab="observed",
     main="Validation",pch=16)

### change the color
plot(animals_predicted_loocv,data_2014$ANIMALS,xlab="predicted",ylab="observed",
     main="Validation",pch=16,col="blue")

### add a legend
legend("topleft",pch=16,col="blue",legend="data points")

### add a diagonal line where oberved is equal predicted
lines(c(0,200),c(0,200))

