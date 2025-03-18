# Generate sample data for demonstration
library(tidyverse)

# Set seed for reproducibility
set.seed(123)

# Generate sample data
generate_sample_data <- function() {
    # Create a dataset with 100 observations and 3 variables
    data <- tibble(
        id = 1:100,
        group = sample(c("A", "B", "C"), 100, replace = TRUE),
        value1 = rnorm(100, mean = 50, sd = 10),
        value2 = rnorm(100, mean = 75, sd = 15)
    )

    # Save the data
    write_csv(data, "r_analysis/input/sample_data.csv")

    return(data)
}


# Run the function
sample_data <- generate_sample_data()
print("Sample data generated successfully")
