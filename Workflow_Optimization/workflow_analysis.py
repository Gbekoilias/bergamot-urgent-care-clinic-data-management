import pandas as pd

def analyze_workflow(data):
    """
    Analyze workflow data to evaluate efficiency and suggest improvements.
    
    Parameters:
    data (DataFrame): A pandas DataFrame containing workflow data with relevant columns.
    
    Returns:
    dict: A dictionary containing insights and recommendations.
    """
    insights = {}
    
    # Calculate key performance indicators (KPIs)
    insights['total_tasks'] = len(data)
    insights['completed_tasks'] = data[data['status'] == 'completed'].shape[0]
    insights['in_progress_tasks'] = data[data['status'] == 'in_progress'].shape[0]
    
    # Calculate completion rate
    if insights['total_tasks'] > 0:
        insights['completion_rate'] = (insights['completed_tasks'] / insights['total_tasks']) * 100
    else:
        insights['completion_rate'] = 0

    # Calculate average time taken for completed tasks
    if insights['completed_tasks'] > 0:
        insights['average_time'] = data[data['status'] == 'completed']['time_taken'].mean()
    else:
        insights['average_time'] = 0

    # Identify bottlenecks
    bottlenecks = data.groupby('task_type')['time_taken'].sum().sort_values(ascending=False)
    insights['bottlenecks'] = bottlenecks[bottlenecks > bottlenecks.mean()].index.tolist()

    # Suggest improvements based on analysis
    recommendations = []
    
    if insights['completion_rate'] < 80:
        recommendations.append("Consider reviewing the workflow process to identify obstacles.")
    
    if 'bottlenecks' in insights and insights['bottlenecks']:
        recommendations.append(f"Focus on improving the following task types to reduce delays: {', '.join(insights['bottlenecks'])}")

    if insights['average_time'] > 5:  # Assuming average time is in hours, adjust as necessary
        recommendations.append("Evaluate resource allocation to speed up task completion.")

    insights['recommendations'] = recommendations
    
    return insights

# Example usage of the analyze_workflow function
if __name__ == "__main__":
    # Sample workflow data creation for demonstration purposes
    sample_data = {
        'task_id': [1, 2, 3, 4, 5],
        'task_type': ['A', 'B', 'A', 'C', 'B'],
        'status': ['completed', 'completed', 'in_progress', 'completed', 'in_progress'],
        'time_taken': [3, 2, 4, 5, 6]  # Time taken in hours
    }
    
    # Create a DataFrame from sample data
    df = pd.DataFrame(sample_data)

    # Analyze the workflow
    analysis_results = analyze_workflow(df)

    # Print the analysis results
    print("Workflow Analysis Results:")
    print("---------------------------")
    for key, value in analysis_results.items():
        print(f"{key}: {value}")
