# Load necessary libraries
library(ggplot2)

# Function to create a histogram
plot_histogram <- function(data, column_name) {
    ggplot(data, aes_string(x = column_name)) +
        geom_histogram(binwidth = 1, fill = "blue", color = "white", alpha = 0.7) +
        labs(title = paste("Histogram of", column_name),
             x = column_name,
             y = "Frequency") +
        theme_minimal()
}

# Function to create a scatter plot
plot_scatter <- function(data, x_column, y_column) {
    ggplot(data, aes_string(x = x_column, y = y_column)) +
        geom_point(color = "red", alpha = 0.6) +
        labs(title = paste("Scatter Plot of", y_column, "vs", x_column),
             x = x_column,
             y = y_column) +
        theme_minimal() +
        geom_smooth(method = "lm", color = "blue", se = FALSE)  # Add a linear regression line
}

# Function to create a box plot
plot_box <- function(data, x_column, y_column) {
    ggplot(data, aes_string(x = x_column, y = y_column)) +
        geom_boxplot(fill = "lightgreen", outlier.color = "red") +
        labs(title = paste("Box Plot of", y_column, "by", x_column),
             x = x_column,
             y = y_column) +
        theme_minimal()
}

# Function to visualize all plots
visualize_data <- function(data) {
    # Create a histogram for a specified column
    histogram_plot <- plot_histogram(data, "column_name1")  # Change to your column name
    print(histogram_plot)

    # Create a scatter plot for two specified columns
    scatter_plot <- plot_scatter(data, "column_name1", "column_name2")  # Change to your column names
    print(scatter_plot)

    # Create a box plot for two specified columns
    box_plot <- plot_box(data, "category_column", "numeric_column")  # Change to your columns
    print(box_plot)
}

# Example usage of the visualization functions
# Load the cleaned dataset (assuming it's already cleaned and preprocessed)
file_path <- "path/to/your/cleaned_dataset.csv"  # Update with your actual file path
data <- read.csv(file_path)

# Run the visualization process
visualize_data(data)
