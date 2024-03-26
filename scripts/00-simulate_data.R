#### Preamble ####
# Purpose: Simulate and prepare datasets for analyzing game results from 2018 to 2021
# Author: Vanshika Vanshika
# Date: 27 march 2024
# Contact: vanshika.vanshika@mail.utoronto.ca
# License: MIT



# Load the tidyverse package for data manipulation
library(tidyverse)
library(MASS)

# Set seed for reproducibility
set.seed(2024)

#### Simulate game results data ####

# Parameters
number_of_matches <- 200  # Total number of matches
teams <- c("TeamA", "TeamB", "TeamC", "TeamD")  # Teams

# Simulate match data
game_results <- tibble(
  date = seq.Date(from = as.Date("2018-01-01"), by = "week", length.out = number_of_matches),
  home_team = sample(teams, number_of_matches, replace = TRUE),
  away_team = sample(teams, number_of_matches, replace = TRUE),
  home_goals = rpois(number_of_matches, lambda = 1.5),  # Average goals scored by home teams
  away_goals = rpois(number_of_matches, lambda = 1)    # Average goals scored by away teams
) %>% 
  filter(home_team != away_team)  # Ensure that a team does not play against itself

#### Simulate attendance data ####

# Assuming that the attendance can vary depending on multiple factors
attendance_data <- tibble(
  date = game_results$date,
  attendance = rnbinom(n = nrow(game_results), size = 1000, prob = 0.8)  # Simulating attendance numbers
)

#### Combine game results with attendance data ####

# Combine datasets by 'date'
combined_data <- left_join(game_results, attendance_data, by = "date")

# Preview the combined dataset
head(combined_data)
