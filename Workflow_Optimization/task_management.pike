// Load necessary libraries
import Math;

// Define a structure for a Task
class Task {
    string name;
    string status; // e.g., "not started", "in progress", "completed"
    int duration; // Duration in hours
    array(Task) dependencies; // List of dependent tasks
    int resources_assigned; // Number of resources assigned to the task

    // Constructor for Task
    Task(string name, int duration) {
        this.name = name;
        this.status = "not started";
        this.duration = duration;
        this.dependencies = [];
        this.resources_assigned = 0;
    }

    // Method to add a dependency
    void add_dependency(Task dependent_task) {
        dependencies += dependent_task;
    }

    // Method to update the status of the task
    void update_status(string new_status) {
        status = new_status;
    }

    // Method to assign resources to the task
    void assign_resources(int num_resources) {
        resources_assigned = num_resources;
    }
}

// Define a class for managing tasks
class TaskManager {
    array(Task) tasks; // List of all tasks

    // Method to add a new task
    void add_task(Task new_task) {
        tasks += new_task;
    }

    // Method to track progress of tasks
    void track_progress() {
        foreach (Task t in tasks) {
            if (t.status == "in progress") {
                t.duration -= 1; // Decrease duration by 1 hour as an example
                if (t.duration <= 0) {
                    t.update_status("completed");
                }
            }
        }
    }

    // Method to assign resources to tasks based on their dependencies
    void assign_resources() {
        foreach (Task t in tasks) {
            if (t.status == "not started") {
                int required_resources = 1 + sizeof(t.dependencies); // Example: 1 resource + number of dependencies
                t.assign_resources(required_resources);
            }
        }
    }

    // Method to generate a report of task statuses
    void generate_report() {
        write("Task Management Report:\n");
        foreach (Task t in tasks) {
            write("Task: ", t.name, ", Status: ", t.status, ", Duration: ", t.duration, " hours, Resources Assigned: ", t.resources_assigned, "\n");
        }
    }
}

// Define the main function to manage tasks and their dependencies
manage_tasks() {
    TaskManager manager = new TaskManager();

    // Create some sample tasks
    Task task1 = new Task("Design", 5);
    Task task2 = new Task("Development", 10);
    Task task3 = new Task("Testing", 3);
    
    // Set dependencies (e.g., Development depends on Design)
    task2.add_dependency(task1);
    
    // Add tasks to the manager
    manager.add_task(task1);
    manager.add_task(task2);
    manager.add_task(task3);

    // Assign resources and track progress
    manager.assign_resources();
    
    // Simulate progress tracking over time
    for (int i = 0; i < 6; i++) { // Simulate for 6 hours
        manager.track_progress();
        write("Hour: ", i + 1, "\n");
        manager.generate_report();
        write("\n");
    }
}

// Run the task management system when the script is executed
manage_tasks();
