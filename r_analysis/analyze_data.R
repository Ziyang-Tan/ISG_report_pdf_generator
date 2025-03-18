# Analyze the generated data
library(tidyverse)
library(ggplot2)
library(jsonlite)
# Load data
sample_data <- read_csv("r_analysis/input/sample_data.csv")

# Basic analysis
analyze_data <- function(data) {
    # Summary statistics by group
    summary_stats <- data %>%
        group_by(group) %>%
        summarize(
            count = n(),
            mean_value1 = mean(value1),
            sd_value1 = sd(value1),
            mean_value2 = mean(value2),
            sd_value2 = sd(value2)
        )

    # Create a histogram plot
    hist_plot <- ggplot(data, aes(x = value1, fill = group)) +
        geom_histogram(alpha = 0.7, bins = 20) +
        theme_minimal() +
        labs(
            title = "Distribution of Value 1 by Group",
            x = "Value 1",
            y = "Count"
        )

    # Save the plot
    ggsave("r_analysis/output/histogram.png", hist_plot, width = 8, height = 6)

    # Create a scatter plot
    scatter_plot <- ggplot(data, aes(x = value1, y = value2, color = group)) +
        geom_point(alpha = 0.7) +
        theme_minimal() +
        labs(
            title = "Relationship between Value 1 and Value 2",
            x = "Value 1",
            y = "Value 2"
        )

    # Save the plot
    ggsave("r_analysis/output/scatter.png", scatter_plot, width = 8, height = 6)

    # Return results
    return(list(
        summary = summary_stats,
        data = data
    ))
}

export_results <- function(results) {
    # Convert summary statistics to JSON
    summary_json <- toJSON(results$summary, pretty = TRUE)

    # Create a list with all the information we want to export
    export_data <- list(
        metadata = list(
            title = "Sample Data Analysis Report",
            date = Sys.Date(),
            author = "R Analysis Pipeline"
        ),
        summary_statistics = results$summary,
        plots = list(
            histogram = "histogram.png",
            scatter = "scatter.png"
        ),
        raw_data = head(results$data, 20) # Just include first 20 rows for demo
    )

    # Convert to JSON
    export_json <- toJSON(export_data, pretty = TRUE, auto_unbox = TRUE)

    # Save to file
    write(export_json, "r_analysis/output/analysis_results.json")

    # Copy plot files to Flutter assets
    file.copy("r_analysis/histogram.png", "r_analysis/output/histogram.png", overwrite = TRUE)
    file.copy("r_analysis/scatter.png", "r_analysis/output/scatter.png", overwrite = TRUE)

    return(export_json)
}

# Run 
analysis_results <- analyze_data(sample_data)
export_results(analysis_results)
print("Results exported successfully")
