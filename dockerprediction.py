from flask import Flask, request
import pandas as pd
from joblib import load
import os
from tabulate import tabulate

app = Flask(__name__)

# Determine the path where the models and CSV files will be located inside the Docker container
DATA_DIR = "/aathi/predictionresult"

# Load the saved models and datasets
models = {
    'ca': load(os.path.join(DATA_DIR, 'RandomForest_ModelCa.joblib')),
    'hb': load(os.path.join(DATA_DIR, 'RandomForest_ModelHb.joblib')),
    'gl': load(os.path.join(DATA_DIR, 'RandomForest_ModelGl.joblib')),
    'albuminserum': load(os.path.join(DATA_DIR,'RandomForest_Modelalb.joblib')),
    'calciumserum': load(os.path.join(DATA_DIR,'RandomForest_Modelcalserum.joblib')),
    'totalproteinserum': load(os.path.join(DATA_DIR, 'RandomForest_Modeltpserum.joblib')),
    'glucoseserum': load(os.path.join(DATA_DIR, 'RandomForest_ModelGlucserum.joblib')),
    'albuminurine': load(os.path.join(DATA_DIR, 'RandomForest_Modelalburine.joblib')),
    'glucoseurine': load(os.path.join(DATA_DIR,'RandomForest_ModelGlucurine.joblib')),
    'microproteinurine': load(os.path.join(DATA_DIR,'RandomForest_Modelmpurine.joblib')),
    'hbblood': load(os.path.join(DATA_DIR, 'RandomForest_Modelhbblood.joblib'))  # Load the new hbblood model
}

datasets = {
    'ca': pd.read_csv(os.path.join(DATA_DIR,'interpolatedca.csv')),
    'hb': pd.read_csv(os.path.join(DATA_DIR,'interpolatedHb.csv')),
    'gl': pd.read_csv(os.path.join(DATA_DIR,'interpolatedgl.csv')),
    'albuminserum': pd.read_csv(os.path.join(DATA_DIR, 'interpolatedalb.csv')),
    'calciumserum': pd.read_csv(os.path.join(DATA_DIR, 'interpolatedcals.csv')),
    'totalproteinserum': pd.read_csv(os.path.join(DATA_DIR,'interpolatedtpser.csv')),
    'glucoseserum': pd.read_csv(os.path.join(DATA_DIR,'interpolatedGlucser.csv')),
    'albuminurine': pd.read_csv(os.path.join(DATA_DIR,'interpolatedalbu.csv')),
    'glucoseurine': pd.read_csv(os.path.join(DATA_DIR,'interpolatedGlucu.csv')),
    'microproteinurine': pd.read_csv(os.path.join(DATA_DIR, 'interpolatedmpu.csv')),
    'hbblood': pd.read_csv(os.path.join(DATA_DIR,'interpolatedhbblood.csv'))  # Load the new hbblood dataset
}

# Functions to predict concentration for different parameters
def predict_concentration_four_values(model, df, row_values):
    if len(row_values) == 1:
        row_values = row_values * 4
    user_input = pd.DataFrame({
        df.columns[1]: [row_values[0]], 
        df.columns[2]: [row_values[1]], 
        df.columns[3]: [row_values[2]], 
        df.columns[4]: [row_values[3]]
    })
    concentration_prediction = model.predict(user_input)
    return round(concentration_prediction[0], 2)

def predict_concentration_ca_hb_gl(model, df, row_values):
    if len(row_values) == 1:
        row_values = row_values * 3
    user_input = pd.DataFrame({
        df.columns[1]: [row_values[0]], 
        df.columns[2]: [row_values[1]], 
        df.columns[3]: [row_values[2]]
    })
    concentration_prediction = model.predict(user_input)
    return round(concentration_prediction[0], 2)

def predict_concentration_two_values(model, df, row_values):
    if len(row_values) == 1:
        row_values = row_values * 2
    user_input = pd.DataFrame({
        df.columns[1]: [row_values[0]], 
        df.columns[2]: [row_values[1]]
    })
    concentration_prediction = model.predict(user_input)
    return round(concentration_prediction[0], 2)

def predict_concentration_one_value(model, df, row_values):
    user_input = pd.DataFrame({df.columns[1]: [row_values[0]]})
    concentration_prediction = model.predict(user_input)
    return round(concentration_prediction[0], 2)

@app.route("/")
def root():
    with open(os.path.join(DATA_DIR, "predictionhtml.html")) as file:
        return file.read()

@app.route('/predict', methods=['POST'])
def predict():
    sample_types = {
        'blood': ['ca', 'hb', 'gl', 'hbblood'],
        'serum': ['totalproteinserum', 'glucoseserum', 'albuminserum', 'calciumserum'],
        'urine': ['glucoseurine', 'albuminurine', 'microproteinurine']
    }

    sample_type = request.form['sample_type'].strip().lower()
    parameter = request.form['parameter'].strip().lower()
    input_values = request.form['input_values'].strip().split(',')
    input_values = [float(value) for value in input_values]

    if sample_type not in sample_types or parameter not in sample_types[sample_type]:
        return "Invalid sample type or parameter selected."

    model = models[parameter]
    df = datasets[parameter]

    results = []
    
    for input_value in input_values:
        if parameter in ['ca', 'hb', 'gl']:
            predicted_concentration = predict_concentration_ca_hb_gl(model, df, [input_value])
        elif parameter == 'hbblood':
            predicted_concentration = predict_concentration_four_values(model, df, [input_value])
        elif parameter in ['albuminserum', 'calciumserum', 'totalproteinserum', 'glucoseserum', 'glucoseurine', 'microproteinurine']:
            predicted_concentration = predict_concentration_two_values(model, df, [input_value])
        elif parameter == 'albuminurine':
            predicted_concentration = predict_concentration_one_value(model, df, [input_value])
        
        results.append([input_value, predicted_concentration])
    
    result_table = tabulate(results, headers=["Input Value", "Predicted Concentration"], tablefmt="html")
    return f"<table border='1'>{result_table}</table>"

if __name__ == '__main__':
    app.run(port=5000, host='0.0.0.0', debug=False) 