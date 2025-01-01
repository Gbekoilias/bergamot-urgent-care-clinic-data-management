// Load necessary libraries for optimization
import Math.Optimization;

// Define the optimization model for resource allocation
optimize_resources() {
    // Define parameters
    int num_resources = 3; // Number of resources
    int num_products = 2;   // Number of products

    // Define profit coefficients for each product
    float profit_coefficients[] = {20.0, 30.0}; // Profit per unit for Product 1 and Product 2

    // Define resource usage per product
    float resource_usage[][num_resources] = {
        {2.0, 1.0, 0.5}, // Resource usage for Product 1
        {1.0, 2.0, 1.5}  // Resource usage for Product 2
    };

    // Define available resources
    float available_resources[] = {100.0, 80.0, 60.0}; // Total available units of each resource

    // Define decision variables (amount of each product to produce)
    float production[num_products];

    // Create the optimization problem
    Optimization.Problem problem;

    // Objective: Maximize total profit
    problem.objective = Optimization.Maximize;
    
    // Set the objective function: total profit = sum(profit_coefficients[i] * production[i])
    problem.objective_function = (production) => {
        float total_profit = 0;
        for (int i = 0; i < num_products; i++) {
            total_profit += profit_coefficients[i] * production[i];
        }
        return total_profit;
    };

    // Constraints: Resource usage must not exceed available resources
    for (int j = 0; j < num_resources; j++) {
        problem.add_constraint((production) => {
            float total_usage = 0;
            for (int i = 0; i < num_products; i++) {
                total_usage += resource_usage[i][j] * production[i];
            }
            return total_usage <= available_resources[j];
        });
    }

    // Non-negativity constraints: production[i] >= 0
    for (int i = 0; i < num_products; i++) {
        problem.add_constraint((production) => production[i] >= 0);
    }

    // Solve the optimization problem
    Optimization.Solution solution = Optimization.solve(problem);

    // Output results
    if (solution.status == Optimization.SolutionStatus.Optimal) {
        write("Optimal production levels:\n");
        for (int i = 0; i < num_products; i++) {
            write("Product ", i + 1, ": ", solution.variables[i], "\n");
        }
        write("Maximum Profit: ", solution.objective_value, "\n");
    } else {
        write("No optimal solution found.\n");
    }
}

// Run the optimization model when the script is executed
optimize_resources();
