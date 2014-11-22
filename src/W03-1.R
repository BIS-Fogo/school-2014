#  Example solution of W03-1 from the BIS-Fogo school 2014
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
#  The script introduces some basic R commands as a warm up
#
rm(list = ls(all = T))


#### Load required libraries ###################################################
library(car)      # needed for regression lines
library(corrplot) # needed for a correlation plot


#### Define Working directory ##################################################
working_directory <- "D:/bis-fogo/school2014/data/field-campaign_2014/procd/"
setwd(working_directory)


#### Read table ################################################################
data_2014 <- read.table("fieldSurvey2014_Subset01.csv", sep = ",", dec = ".",
                        header = TRUE)


#### Investigate correlation between Animals and Coverage  #####################
plot(data_2014$COVRG,data_2014$ANIMALS)
correlation <- cor.test(data_2014$ANIMAL,data_2014$COVRG)
print (correlation)


#### Check for correlations between all variables ##############################
correlations <- cor(data_2014,use="complete.obs")
corrplot(correlations,type="lower")

