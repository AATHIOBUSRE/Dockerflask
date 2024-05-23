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
WORKDIR /aathi/

# Copy the requirements file and install dependencies
COPY requirements.txt /aathi/
RUN pip install -r ./requirements.txt

# Copy the server code
COPY dockerprediction.py /aathi/

# Copy the CSV files
COPY interpolatedca.csv /aathi/
COPY interpolatedHb.csv /aathi/
COPY interpolatedgl.csv /aathi/
COPY interpolatedGlucser.csv /aathi/
COPY interpolatedGlucu.csv /aathi/
COPY interpolatedalb.csv /aathi/
COPY interpolatedcals.csv /aathi/
COPY interpolatedhbblood.csv /aathi/
COPY interpolatedmpu.csv /aathi/
COPY interpolatedtpser.csv /aathi/
COPY interpolatedalbu.csv /aathi/

# Copy the model files
COPY RandomForest_ModelCa.joblib /aathi/
COPY RandomForest_ModelHb.joblib /aathi/
COPY RandomForest_ModelGl.joblib /aathi/
COPY RandomForest_ModelGlucserum.joblib /aathi/
COPY RandomForest_ModelGlucurine.joblib /aathi/
COPY RandomForest_Modelalb.joblib /aathi/
COPY RandomForest_Modelalburine.joblib /aathi/
COPY RandomForest_Modelcalserum.joblib /aathi/
COPY RandomForest_Modelhbblood.joblib /aathi/
COPY RandomForest_Modelmpurine.joblib /aathi/
COPY RandomForest_Modeltpserum.joblib /aathi/

COPY predictionhtml.html /aathi/

# Launch the server app
ENTRYPOINT ["python", "./dockerprediction.py"]
