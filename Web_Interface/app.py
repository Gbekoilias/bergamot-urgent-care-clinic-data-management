from flask import Flask, render_template, request, redirect, url_for, flash
import pandas as pd
import numpy as np
from scipy import stats

app = Flask(__name__)
app.secret_key = 'your_secret_key'  # Required for session management

# Example data analysis function (e.g., performing a t-test)
def perform_ttest(data1, data2):
    t_stat, p_value = stats.ttest_ind(data1, data2)
    return t_stat, p_value

# Route for the home page
@app.route('/')
def index():
    return render_template('index.html')

# Route for uploading data
@app.route('/upload', methods=['POST'])
def upload():
    if 'file' not in request.files:
        flash('No file part')
        return redirect(request.url)
    
    file = request.files['file']
    
    if file.filename == '':
        flash('No selected file')
        return redirect(request.url)
    
    # Process the uploaded file (assuming it's a CSV)
    try:
        data = pd.read_csv(file)
        # Perform some analysis (this is just an example)
        group1 = data[data['group'] == 'A']['value']  # Replace with actual column names
        group2 = data[data['group'] == 'B']['value']
        
        t_stat, p_value = perform_ttest(group1, group2)

        return render_template('results.html', t_stat=t_stat, p_value=p_value)

    except Exception as e:
        flash(f'Error processing file: {str(e)}')
        return redirect(request.url)

# Route for displaying results
@app.route('/results')
def results():
    return render_template('results.html')

if __name__ == '__main__':
    app.run(debug=True)
