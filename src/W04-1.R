#  Example solution of W04-1 from the BIS-Fogo school 2014
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
#  The script computes a regression between animal abundance and selected
#  environmental variables.
#
rm(list = ls(all = T))

#### Define Working directory ##################################################
working_directory <- "D:/active/bis-fogo/school2014/"
in_path <- paste0(working_directory,"data/field-campaign_2014/procd/")
out_path <- paste0(working_directory,"analysis/")
setwd(working_directory)


#### Load required libraries ###################################################
library(car)      # needed for regression lines


#### read table ################################################################
data_2014 <- read.table(paste0(in_path, "fieldSurvey2014_Subset01.csv"), 
                        sep = ",", dec = ".", header = TRUE)


#### Linear model Animals ~ Coverage  ##########################################
# plot the data
plot(data_2014$COVRG,data_2014$ANIMALS)

# Fit a linear model
linear_model <- lm(data_2014$ANIMAL~ data_2014$COVRG)

# look for p value and R squared
summary(linear_model)

# add a regression line
regLine(linear_model)


#### Linear model Animals ~ AGR  ##########################################
plot(data_2014$AGR,data_2014$ANIMALS)
linear_model <- lm(data_2014$ANIMALS~ data_2014$AGR)
summary(linear_model)
regLine(linear_model)


#### Linear model Animals ~ NAT  ##########################################
plot(data_2014$NAT,data_2014$ANIMALS)
linear_model <- lm(data_2014$ANIMALS~ data_2014$NAT)
summary(linear_model)
regLine(linear_model)


#### Check for normal distribution #############################################
qqPlot(linear_model)
