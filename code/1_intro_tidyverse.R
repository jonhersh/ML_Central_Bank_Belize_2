# ------------------------------------------------
# Load packages 
# ------------------------------------------------
library('tidyverse')


# ------------------------------------------------
# Load Dataset
# ------------------------------------------------
# let's summarize the IDB poverty data using the glimpse function
# Raw file from 
# https://www.kaggle.com/c/costa-rican-household-poverty-prediction/data?select=codebook.csv

# load dataset 
CR_dat <- read_csv("https://raw.githubusercontent.com/jonhersh/ML_Central_Bank_Belize_2/main/datasets/CR_dat.csv")

# data contains household survey data
# variables include:

# household_ID: unique household identifier
# poor_stat: = 1 if poor, 0 otherwise
# num_rooms: number of rooms of main dwelling
# bathroom: number of bathrooms 
# refrig: refrigerator present (1) or not (0)
# no_elect: household has electricity (1) or not (0)
# comp: household has computer (1) or not (0)
# dep_rate: dependency rate of household ((children + elderly) / total)
# tv: television present (1) or not (0)
# mobile: household has mobile phone (1) or not (0)
# num_hh: number of people in household
# mean_educ: average years of education of adults in household
# num_children: number of children in household
# num_elderly: number of elderly in household
# disabled: = 1 if head disable, = 0 otherwise
# mar_stat: marriage status of head: married, widowed, single, or other

# ------------------------------------------------
# GLIMPSE to summarize data
# ------------------------------------------------


glimpse(CR_dat)

summary(CR_dat)


# ------------------------------------------------
# Pipe Operator!  
# ------------------------------------------------
# The pipe operator "%>%" is super useful!
# It allows us to execute a series of functions on an object in stages
# The general recipe is Data_Frame %>% function1() %>% function2() etc
# Functions are applied right to left

CR_dat %>% glimpse()
glimpse(CR_dat)

# cmd shift 
CR_dat %>% glimpse() 
glimpse(CR_dat)


# ------------------------------------------------
# Slice function: to select ROWS 
# ------------------------------------------------
# SLICE: slice to view only the first 10 rows
CR_dat %>% slice(1:10)

CR_dat %>% slice(101)

# tidy way!
CR_dat101 <- CR_dat %>% slice(101)
# base R
CR_dat101 <- CR_dat[101,]

# SLICE to view only rows 300 to 310 
CR_dat %>% slice(300:310)



# ------------------------------------------------
# Arrange function: to ORDER dataset
# ------------------------------------------------

CR_dat %>% arrange(desc(mean_educ, dep_rate)) %>% head()

CR_dat %>% arrange(-num_children) %>% head()

# arrange the dataframe in descending order by mean_educ
CR_dat %>% 
    arrange(desc(mean_educ)) %>% 
    head()

# arrange the dataframe in ascending order by mean_educ
CR_dat %>%
    arrange(mean_educ) %>% 
    head()
    

# arrange via multiple columns, by budget and title year, then output rows 1 to 10
CR_dat %>% 
    arrange(desc(mean_educ), dep_rate) %>% 
    slice(1:10)


# ------------------------------------------------
# SELECT columns of the dataset using the 'select' function
# ------------------------------------------------
# select then pass to table function 

CR_dat %>% select(-poor_stat) %>% head()

CR_dat_y <- 
    CR_dat %>% 
    select(poor_stat)

CR_dat %>% select(poor_stat) %>% table() 

# select only columns starting with particular characters 
CR_dat %>% 
    select(starts_with("num")) %>% 
    head()

CR_dat %>% 
    select(ends_with("stat")) %>% 
    head()

# remove variables using - operator
CR_dat %>% 
    select(-num_rooms) %>% 
    head()

# ------------------------------------------------
# RENAME variables using the RENAME function
# ------------------------------------------------
# note we must pass the DF back to the original data
CR_temp <- 
    CR_dat %>% 
    rename(hh_id = household_ID,
           tele = tv,
           var1 = oldvar1) %>% 
    slice(1:10) %>% 
    print()
    

CR_dat <- CR_dat %>% 
    rename(HH_ID = household_ID) 

CR_dat %>% names()

# change it back!
CR_dat <- CR_dat %>% 
    rename(household_ID = HH_ID) 


# ------------------------------------------------
# FILTER and ONLY allow certain rows using the FILTER function
# ------------------------------------------------
# only select households with poverty status
# and see # of rows
CR_dat %>% 
    filter(poor_stat == 0) %>% 
    count()

CR_dat %>% 
    filter(poor_stat ==  1) %>% 
    head()

CR_dat %>% 
    filter(mar_stat == "divorced" & poor_stat == 1) %>% 
    count()

CR_dat %>% 
    filter(comp == 1 & num_hh > 3) %>% 
    count()



# ------------------------------------------------
# MUTATE to Transform variables in your dataset
# ------------------------------------------------
# adding new variables using mutate()

# feature transformation
# Max Kuhn featuretransform.
CR_dat <- CR_dat %>% 
    mutate(mean_educ_log = log(mean_educ + 1),
           mean_educ_sq = mean_educ * mean_educ,
           divorced = if_else(mar_stat == "divorced",1,0))

# inverse hyperbolic sin transformation
    

CR_dat <- CR_dat %>% 
    mutate(mean_educ_sq = mean_educ * mean_educ,
           mean_educ_log = log(mean_educ + 1))

# see average education and educ squared 
CR_dat %>% select(matches("educ")) %>% colMeans()

# Same thing, but using the package purrr to "map"
# the function mean to all the columns of the data frame
# library('purrr')
CR_dat %>% select(matches("educ")) %>% map_df(mean)


# ------------------------------------------------
# Create summary statistics by GROUP using group_by()
# ------------------------------------------------
CR_dat <- CR_dat %>% 
        # group by urban rural status
    group_by(urban) 

glimpse(CR_dat)


# calculate average and sd of poverty by group 
CR_urb <- CR_dat %>% 
    summarize(pov_avg = mean(poor_stat),
              pov_sd = sd(poor_stat)) %>% 
    print()

CR_urb <- CR_dat %>% 
    # calculate average poor status
    summarize(pov_avg = mean(poor_stat),
              pov_sd = sd(poor_stat)) %>% 
    print()

CR_dat %>% 
    group_by(poor_stat) %>% 
    select_if(is.numeric) %>%
    summarize(across(everything(), mean)) %>% 
    View()

# ------------------------------------------------
# Exercises
# ------------------------------------------------
# 1. Use mutate to create a new variable num_children_sq
#    which is equal to num_children * num_children.

# 2. Use filter to determine the number of households 
#    in the dataset that have children 

# 3. Use group_by and summarize to calculate fraction of 
#    households without electricity in urban vs rural areas

CR_dat %>% 
    group_by(urban) %>% 
    summarize(elec = mean(no_elect))

# 4. (Time permitting) Use ggplot2 to explore some interesting
#    data visualizations with the data. 
#    Don't feel obligated to do so if you aren't a ggplot2 expert! 
