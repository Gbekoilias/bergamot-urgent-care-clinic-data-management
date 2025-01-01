import numpy as np
import matplotlib.pyplot as plt

# Function to run Monte Carlo simulation
def monte_carlo_simulation(num_simulations, mean, std_dev):
    results = []
    for _ in range(num_simulations):
        # Simulate a random variable based on a normal distribution
        result = np.random.normal(loc=mean, scale=std_dev)
        results.append(result)
    return results

# Function to analyze the results of the simulation
def analyze_results(results):
    mean_result = np.mean(results)
    std_dev_result = np.std(results)
    return mean_result, std_dev_result

# Function to visualize the simulation results
def plot_results(results):
    plt.figure(figsize=(10, 6))
    
    # Create a histogram of the results
    plt.hist(results, bins=30, color='skyblue', alpha=0.7, edgecolor='black')
    
    # Add lines for mean and standard deviation
    mean_result = np.mean(results)
    std_dev_result = np.std(results)
    
    plt.axvline(mean_result, color='red', linestyle='dashed', linewidth=1, label=f'Mean: {mean_result:.2f}')
    plt.axvline(mean_result + std_dev_result, color='green', linestyle='dashed', linewidth=1, label=f'Standard Deviation: {std_dev_result:.2f}')
    plt.axvline(mean_result - std_dev_result, color='green', linestyle='dashed', linewidth=1)
    
    plt.title('Monte Carlo Simulation Results')
    plt.xlabel('Value')
    plt.ylabel('Frequency')
    plt.legend()
    plt.grid(True)
    
    # Show the plot
    plt.show()

# Main function to run the Monte Carlo simulation
def main():
    # Parameters for the simulation
    num_simulations = 10000  # Number of simulations
    mean = 100                # Mean of the normal distribution
    std_dev = 15              # Standard deviation of the normal distribution

    # Run the Monte Carlo simulation
    results = monte_carlo_simulation(num_simulations, mean, std_dev)

    # Analyze the results
    mean_result, std_dev_result = analyze_results(results)

    # Print summary statistics
    print(f"Mean of Simulation Results: {mean_result:.2f}")
    print(f"Standard Deviation of Simulation Results: {std_dev_result:.2f}")

    # Visualize the results
    plot_results(results)

if __name__ == "__main__":
    main()
