#  Example solution of W01-1 from the BIS-Fogo school 2014
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


#### Hello R ###################################################################
print("Hello R")




#### Use R as a calculator #####################################################
1+5
1*5
1/5

#write numbers into a variable:
x <- 1
y <- 5
z <- x+y
print(z)


#### Code snipet for vector creation (put on ws) ###############################
x <- c(1:5)
y <- c(10,20,30,40,50)
print(x)
print(y)


#### Some more calculations ####################################################
# Tip on ws: functions mean, median, sd
x+y
(x+y)*2
mean(x) # mean value from vector x 
median(x) # median value from vector x
sd(x) # standard deviation from vector x