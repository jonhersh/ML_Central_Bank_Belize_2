# ------------------------------------------------
# Load packages and data prep
# ------------------------------------------------
library('tidyverse')

# load data if not already loaded

CR_dat <- read_csv("https://raw.githubusercontent.com/jonhersh/ML_Central_Bank_Belize_2/main/datasets/CR_dat.csv")


# ------------------------------------------------
# Create Simple Scatter plot
# ------------------------------------------------

# aes specifies the x and y axes
# geom_point creates the points
ggplot(CR_dat, aes(x = num_rooms, y = mean_educ)) +
  geom_point()

# change the transparency of the points with alpha = [number less than 1]
ggplot(CR_dat, aes(x = num_rooms, y = mean_educ)) +
  geom_point(alpha = 1/20)

# we can change the color of the points
ggplot(CR_dat, aes(x = num_rooms, y = mean_educ)) +
  geom_point(aes(color = mar_stat), alpha = 1/20)


