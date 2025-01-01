# Load necessary libraries
library(knitr)
library(rmarkdown)

# Function to generate a CSV report
generate_csv_report <- function(data, filename = "report.csv") {
    write.csv(data, filename, row.names = FALSE)
    cat("CSV report generated:", filename, "\n")
}

# Function to generate a PDF report using R Markdown
generate_pdf_report <- function(data, summary_statistics, filename = "report.Rmd") {
    # Create an R Markdown file for the report
    rmd_content <- paste0(
        "---\n",
        "title: 'Analysis and Simulation Report'\n",
        "author: 'Your Name'\n",
        "date: '`r Sys.Date()`'\n",
        "output: pdf_document\n",
        "---\n\n",
        
        "# Summary Statistics\n\n",
        "Here are the summary statistics from the analysis:\n\n",
        knitr::kable(summary_statistics), "\n\n",

        "# Detailed Results\n\n",
        "The detailed results of the analysis are as follows:\n\n",
        "```
        "print(head(data))\n",
        "```\n"
    )
    
    # Write the R Markdown content to a file
    writeLines(rmd_content, con = filename)
    
    # Render the R Markdown file to PDF
    rmarkdown::render(filename, output_file = "report.pdf")
    cat("PDF report generated: report.pdf\n")
}

# Example usage of the report generation functions
if (interactive()) {
    # Sample data for demonstration purposes
    sample_data <- data.frame(
        Task = c("Task A", "Task B", "Task C"),
        Status = c("Completed", "In Progress", "Not Started"),
        Duration = c(5, 3, 2),
        Resources_Assigned = c(2, 3, 1)
    )
    
    # Sample summary statistics
    summary_statistics <- data.frame(
        Metric = c("Total Tasks", "Completed Tasks", "Average Duration"),
        Value = c(nrow(sample_data), sum(sample_data$Status == "Completed"), mean(sample_data$Duration))
    )
    
    # Generate reports
    generate_csv_report(sample_data)
    generate_pdf_report(sample_data, summary_statistics)
}
