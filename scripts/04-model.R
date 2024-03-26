#### Preamble ####
# Purpose: Models a Poisson Regression
# Author: Vanshika Vanshika
# Date: 18 March 2024
# Contact: vanshika.vanshika@mail.utoronto.ca
# License: MIT


#### Workspace setup ####
library(tidyverse)
library(rstanarm)

#### Read data ####
england <- read_csv("data/raw_data/england.csv")

# Identify the top 5 teams based on some criterion (e.g., total goals scored)
top_teams <- head(sort(table(c(england$HomeTeam, england$AwayTeam)), decreasing = TRUE), 5)

# Filter dataset to include matches involving only the top 5 teams
filtered_data <- england[england$HomeTeam %in% names(top_teams) | england$AwayTeam %in% names(top_teams), ]

# Fit Poisson regression model
model <- glm(FTHG ~ HomeTeam + AwayTeam + HTHG + HTAG + HS + AS + HST + AST,
             data = filtered_data, family = poisson)

# Print model summary
summary(model)
#### Save model ####
saveRDS(
  model,
  file = "models/first_model.rds"
)


