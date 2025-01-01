# Load necessary libraries
library(dplyr)
library(tidyr)

# Function to clean data
clean_data <- function(data) {
    # Step 1: Handle missing values
    data <- data %>%
        filter(complete.cases(.))  # Remove rows with any missing values

    # Step 2: Convert specified columns to numeric
    numeric_columns <- c("column_name1", "column_name2")  # Specify your numeric columns here
    for (col in numeric_columns) {
        data[[col]] <- as.numeric(data[[col]])
        if (any(is.na(data[[col]]))) {
            warning(paste("NAs introduced by coercion in column:", col))
        }
    }

    # Step 3: Handle outliers using IQR method
    data <- remove_outliers(data, "column_name1")  # Specify the column to check for outliers

    return(data)
}

# Function to remove outliers based on IQR
remove_outliers <- function(data, column) {
    Q1 <- quantile(data[[column]], 0.25, na.rm = TRUE)
    Q3 <- quantile(data[[column]], 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    
    lower_bound <- Q1 - 1.5 * IQR
    upper_bound <- Q3 + 1.5 * IQR
    
    data <- data %>%
        filter(data[[column]] >= lower_bound & data[[column]] <= upper_bound)
    
    return(data)
}

# Function to convert categorical variables to factors
convert_categorical_to_factors <- function(data) {
    categorical_columns <- c("category_column1", "category_column2")  # Specify your categorical columns here
    for (col in categorical_columns) {
        data[[col]] <- as.factor(data[[col]])
    }
    
    return(data)
}

# Main function to clean and preprocess the dataset
preprocess_data <- function(file_path) {
    # Load the dataset
    data <- read.csv(file_path)

    # Clean the data
    cleaned_data <- clean_data(data)

    # Convert categorical variables to factors
    cleaned_data <- convert_categorical_to_factors(cleaned_data)

    return(cleaned_data)
}

# Example usage of the preprocess_data function
# Specify the path to your dataset here
file_path <- "path/to/your/dataset.csv"  # Update with your actual file path

# Run the preprocessing
cleaned_data <- preprocess_data(file_path)

# Print the cleaned dataset summary
print(summary(cleaned_data))
