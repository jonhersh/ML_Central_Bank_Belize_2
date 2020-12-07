# ------------------------------------------------
# Load packages and data prep
# ------------------------------------------------
library('tidyverse')

# load data if not already loaded

CR_dat <- read_csv("https://raw.githubusercontent.com/jonhersh/ML_Central_Bank_Belize_2/main/datasets/CR_dat.csv")



# ------------------------------------------------
# Create Simple bar charts
# ------------------------------------------------
ggplot(CR_dat, aes(x = poor_stat)) + 
  geom_bar()

ggplot(CR_dat, aes(x = num_hh)) + 
  geom_bar() 

# change color of bar based on some other characteristic of
# the data
ggplot(CR_dat, aes(x = num_hh)) + 
  geom_bar(aes(fill = poor_stat)) 

ggplot(CR_dat, aes(x = age)) + 
  geom_bar(aes(fill = poor_stat)) 


 
# ------------------------------------------------
# Create Simple Scatter plot
# ------------------------------------------------

# aes specifies the x and y axes
# geom_point creates the points
ggplot(CR_dat, aes(x = age, y = mean_educ)) +
  geom_point()

# change the transparency of the points with alpha = [number less than 1]
ggplot(CR_dat, aes(x = age, y = mean_educ)) +
  geom_point(alpha = 1/10)




# ------------------------------------------------
# Add a smoothing trend line with geom_smooth()
# ------------------------------------------------
# we can change the color of the points
ggplot(CR_dat, aes(x = age, y = mean_educ)) +
  geom_point(aes(color = mar_stat), alpha = 1/10) +
  geom_smooth()

# change to a linear line
# we can change the color of the points
ggplot(CR_dat, aes(x = age, y = mean_educ)) +
  geom_point(aes(color = mar_stat), alpha = 1/10) + 
  geom_smooth(method = "lm")


# ------------------------------------------------
# Create multiple plots based on a factor level
# ------------------------------------------------
ggplot(CR_dat, aes(x = age, y = mean_educ)) +
  geom_point(aes(color = mar_stat), alpha = 1/10) + 
  facet_wrap(~ mar_stat)


ggplot(CR_dat, aes(x = age, y = mean_educ)) +
  geom_point(alpha = 1/10) + 
  geom_smooth(method = "lm") +
  facet_wrap(~ urban)


# ------------------------------------------------
# Exercises
# ------------------------------------------------

# 1. Use the geom_bar function to create a histogram 
# plot of poor_stat, where the fill is set to the urban variable

ggplot(CR_dat, aes(y = poor_stat)) + 
  geom_bar(aes(fill = urban))

# 2. Create a scatter plot of dependency rate on the X axis
#    and mean_education on the y axis, where the color is set to 
#    marriage status (mar_stat)

ggplot(CR_dat, aes(x = dep_rate, y = mean_educ)) +
  geom_point(aes(color = mar_stat), alpha = 1/10)

# 3. Create a scatter plot of age against mean education
#    faceted by urban. Include a linear smoothing line 

ggplot(CR_dat, aes(x = age, y = mean_educ)) +
  geom_point(alpha = 1/10) + 
  geom_smooth(method = "lm") +
  facet_wrap(~ urban)


