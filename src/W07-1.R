#  Example solution of W07-1 from the BIS-Fogo school 2014
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
#  The script does some descripte statistics and related plots.
#
rm(list = ls(all = T))

#### Define Working directory ##################################################
working_directory <- "D:/bis-fogo/school2014/data/field-campaign_2014/"
in_path <- paste0(working_directory,"data/procd/")
out_path <- paste0(working_directory,"analysis/")
script_path <- "D:/bis-fogo/school2014/scripts/"
setwd(working_directory)


#### Read table ################################################################
data_2014 <- read.table(paste0(in_path, "fieldSurvey2014_Subset01.csv"), 
                        sep = ",", dec = ".", header = TRUE)


#### Run linear model and prediction from W05-1 again ##########################
source(paste0(script_path,"/W05-1.R"))


#### Descriptive statistics ####################################################
mean(animals_predicted)
mean(data_2014$ANIMALS,na.rm = TRUE)

median(animals_predicted)
median(data_2014$ANIMALS,na.rm = TRUE)

sd(animals_predicted)
sd(data_2014$ANIMALS,na.rm = TRUE)

max(animals_predicted)
max(data_2014$ANIMALS,na.rm = TRUE)

min(animals_predicted)
min(data_2014$ANIMALS,na.rm = TRUE)


#### Plots for descriptive statistics #########################################
### scatter plot:
plot(animals_predicted,data_2014$ANIMALS)
#identify outliers:
identify(animals_predicted,data_2014$ANIMALS,labels=data_2014$ID)
### boxplot:
boxplot(animals_predicted,data_2014$ANIMALS)

