#FROM python:3.10.4

# Set the working directory inside the container
#WORKDIR /aathi/

# Copy the requirements file and install dependencies
#COPY requirements.txt ./
#RUN pip install -r requirements.txt

# Create a directory for the results
#RUN mkdir -p /aathi/results/

# Copy the server code
#COPY results/dockercomma.py ./results/

# Copy the CSV files from the results directory
#COPY results/interpolatedca.csv ./results/
#COPY results/interpolatedHb.csv ./results/
#COPY results/interpolatedgl.csv ./results/

# Copy the model files from the results directory
#COPY results/RandomForest_ModelCa.joblib ./results/
#COPY results/RandomForest_ModelHb.joblib ./results/
#COPY results/RandomForest_ModelGl.joblib ./results/

# Copy the HTML file
#COPY results/comma.html ./results/

# Expose the container port on which the server will be listening
#EXPOSE 5000

# Launch the server app
#ENTRYPOINT ["python", "./results/dockercomma.py"]

FROM python:3.10.4

# Set the working directory inside the container
WORKDIR /aathi/predictionresult/

# Copy the requirements file and install dependencies
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Create a directory for the results
RUN mkdir -p /aathi/predictionresult/

# Copy the server code
COPY /dockerprediction.py ./predictionresult/

# Copy the CSV files from the results directory
COPY /interpolatedca.csv ./predictionresult/
COPY /interpolatedHb.csv ./predictionresult/
COPY /interpolatedgl.csv ./predictionresult/
COPY /interpolatedalb.csv ./predictionresult/
COPY /interpolatedalbu.csv ./predictionresult/
COPY /interpolatedcals.csv ./predictionresult/
COPY /interpolatedGlucser.csv ./predictionresult/
COPY /interpolatedGlucu.csv ./predictionresult/
COPY /interpolatedtpser.csv ./predictionresult/
COPY /interpolatedhbblood.csv ./predictionresult/
COPY /interpolatedmpu.csv ./predictionresult/

# Copy the model files from the results directory
COPY predictionresult/RandomForest_ModelCa.joblib ./predictionresult/
COPY predictionresult/RandomForest_ModelHb.joblib ./predictionresult/
COPY predictionresult/RandomForest_ModelGl.joblib ./predictionresult/
COPY predictionresult/RandomForest_Modelalb.joblib ./predictionresult/
COPY predictionresult/RandomForest_Modelalburine.joblib ./predictionresult/
COPY predictionresult/RandomForest_Modeltpserum.joblib ./predictionresult/
COPY predictionresult/RandomForest_Modelcalserum.joblib ./predictionresult/
COPY predictionresult/RandomForest_ModelGlucserum.joblib ./predictionresult/
COPY predictionresult/RandomForest_ModelGlucurine.joblib ./predictionresult/
COPY predictionresult/RandomForest_Modelhbblood.joblib ./predictionresult/
COPY predictionresult/RandomForest_Modelmpurine.joblib ./predictionresult/

# Copy the HTML file
COPY predictionresult/predictionhtml.html ./predictionresult/

# Expose the container port on which the server will be listening
EXPOSE 5000

# Launch the server app
ENTRYPOINT ["python", "./predictionresult/dockerprediction.py"]
