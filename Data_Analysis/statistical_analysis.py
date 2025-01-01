import pandas as pd
from scipy import stats

# Function to perform t-test
def perform_ttest(data1, data2):
    t_stat, p_value = stats.ttest_ind(data1, data2)
    return t_stat, p_value

# Function to perform paired t-test
def perform_paired_ttest(data1, data2):
    t_stat, p_value = stats.ttest_rel(data1, data2)
    return t_stat, p_value

# Function to perform one-way ANOVA
def perform_anova(*args):
    f_stat, p_value = stats.f_oneway(*args)
    return f_stat, p_value

# Function to summarize statistical results
def summarize_results(test_name, statistic, p_value):
    print(f"{test_name} Results:")
    print(f"Statistic: {statistic:.4f}, P-value: {p_value:.4f}")
    if p_value < 0.05:
        print("Reject the null hypothesis.")
    else:
        print("Fail to reject the null hypothesis.")
    print("-" * 30)

# Main function to load data and perform statistical analysis
def main():
    # Load the cleaned dataset (update with your actual file path)
    file_path = "path/to/your/cleaned_dataset.csv"  # Change this path accordingly
    data = pd.read_csv(file_path)

    # Example: Assume we have two groups for a t-test
    group1 = data[data['group'] == 'A']['value']  # Replace 'group' and 'value' with your actual column names
    group2 = data[data['group'] == 'B']['value']

    # Perform t-test
    t_stat, p_value = perform_ttest(group1, group2)
    summarize_results("Independent T-Test", t_stat, p_value)

    # Example: Perform paired t-test if applicable
    paired_group1 = data[data['condition'] == 'before']['value']  # Replace with actual column names
    paired_group2 = data[data['condition'] == 'after']['value']

    t_stat_paired, p_value_paired = perform_paired_ttest(paired_group1, paired_group2)
    summarize_results("Paired T-Test", t_stat_paired, p_value_paired)

    # Example: Perform one-way ANOVA
    anova_groups = [data[data['category'] == cat]['value'] for cat in data['category'].unique()]  # Replace with actual column names
    f_stat, p_value_anova = perform_anova(*anova_groups)
    summarize_results("One-Way ANOVA", f_stat, p_value_anova)

if __name__ == "__main__":
    main()
