# Load necessary libraries
library(ggplot2)

# Function to calculate queue length
queue_length <- function(arrival_rate, service_rate) {
    if (arrival_rate >= service_rate) {
        stop("Arrival rate must be less than service rate for a stable system.")
    }
    return(arrival_rate / (service_rate - arrival_rate))
}

# Function to calculate average waiting time in the queue
waiting_time <- function(arrival_rate, service_rate) {
    if (arrival_rate >= service_rate) {
        stop("Arrival rate must be less than service rate for a stable system.")
    }
    return(1 / (service_rate - arrival_rate))
}

# Function to calculate average number of customers in the system
customers_in_system <- function(arrival_rate, service_rate) {
    if (arrival_rate >= service_rate) {
        stop("Arrival rate must be less than service rate for a stable system.")
    }
    return(queue_length(arrival_rate, service_rate) + (arrival_rate / service_rate))
}

# Function to simulate the queueing process
simulate_queue <- function(arrival_rate, service_rate, num_customers) {
    inter_arrival_times <- rexp(num_customers, rate = arrival_rate)
    service_times <- rexp(num_customers, rate = service_rate)
    
    arrival_times <- cumsum(inter_arrival_times)
    start_service_times <- numeric(num_customers)
    finish_service_times <- numeric(num_customers)
    
    for (i in 1:num_customers) {
        if (i == 1) {
            start_service_times[i] <- arrival_times[i]
        } else {
            start_service_times[i] <- max(arrival_times[i], finish_service_times[i - 1])
        }
        finish_service_times[i] <- start_service_times[i] + service_times[i]
    }
    
    # Create a data frame to hold the results
    queue_data <- data.frame(
        Customer = 1:num_customers,
        ArrivalTime = arrival_times,
        StartServiceTime = start_service_times,
        FinishServiceTime = finish_service_times,
        WaitingTime = start_service_times - arrival_times
    )
    
    return(queue_data)
}

# Function to visualize the queue simulation results
plot_queue_simulation <- function(queue_data) {
    ggplot(queue_data, aes(x = Customer)) +
        geom_line(aes(y = ArrivalTime, color = "Arrival Time"), size = 1) +
        geom_line(aes(y = StartServiceTime, color = "Start Service Time"), size = 1) +
        geom_line(aes(y = FinishServiceTime, color = "Finish Service Time"), size = 1) +
        labs(title = "Queue Simulation",
             x = "Customer",
             y = "Time") +
        scale_color_manual(values = c("Arrival Time" = "blue", 
                                        "Start Service Time" = "orange", 
                                        "Finish Service Time" = "green")) +
        theme_minimal() +
        theme(legend.title = element_blank())
}

# Main function to run the queueing model
main <- function() {
    # Parameters for the queueing model
    arrival_rate <- 5   # Average arrival rate (customers per time unit)
    service_rate <- 8   # Average service rate (customers per time unit)
    num_customers <- 100 # Number of customers to simulate

    # Calculate metrics
    cat("Queue Length:", queue_length(arrival_rate, service_rate), "\n")
    cat("Average Waiting Time:", waiting_time(arrival_rate, service_rate), "\n")
    cat("Average Number of Customers in System:", customers_in_system(arrival_rate, service_rate), "\n")

    # Simulate the queue
    queue_data <- simulate_queue(arrival_rate, service_rate, num_customers)

    # Print first few rows of the simulation data
    print(head(queue_data))

    # Visualize the results
    plot_queue_simulation(queue_data)
}

# Run the main function when the script is executed
main()
