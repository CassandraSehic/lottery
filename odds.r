# Load the ggplot2 library
library(ggplot2)

# Define the odds
odds_lottery <- 1 / 292200000 # Example for Powerball
odds_lightning <- 1 / 500000 # Rough estimate per year in the U.S.
odds_president <- 1 / 330000000 # Assuming 1 president out of the current US population
odds_royal_flush <- 1 / 649740 # Odds in poker
odds_billionaire <- 1 / (7800000000 / 2755) # Rough estimate based on global population

# Create a data frame
events <- c("Becoming a Billionaire", "Becoming President of the USA", "Struck by Lightning", "Getting a Royal Flush", "Winning the Lottery")
odds <- c(odds_billionaire, odds_president, odds_lightning, odds_royal_flush, odds_lottery)
data <- data.frame(events, odds, stringsAsFactors = FALSE)

# Order the data frame by odds for the gradient color (from most likely to least likely)
data <- data[order(data$odds), ]

# Create a gradient color based on the odds
data$color_gradient <- rank(data$odds) / length(data$odds)

# Create the plot with vertical bars and a color gradient
plot <- ggplot(data, aes(x = reorder(events, odds), y = odds, fill = color_gradient)) +
  geom_col() +
  scale_fill_gradient(low = "lightpink", high = "darkred") +
  labs(x = "Event", y = "Odds (one in X)", title = "Comparing Odds of Rare Events") +
  theme_minimal() +
  theme(legend.position = "none") # Hide the legend for the gradient

# Print the plot
print(plot)

# Save the plot
ggsave("odds_comparison_plot.png", plot = plot, width = 10, height = 8, dpi = 300)

# Print out the odds in a human-readable format
data$readable_odds <- sapply(data$odds, function(x) formatC(x, format = "f", big.mark = ",", digits = 0))
print(data)
