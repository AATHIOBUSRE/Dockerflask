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
COPY requirements.txt ./
RUN pip install -r requirements.txt

# Copy the server code
COPY /dockerprediction.py ./

# Copy the CSV files from the results directory
COPY /interpolatedca.csv ./
COPY /interpolatedHb.csv ./
COPY /interpolatedgl.csv ./
COPY /interpolatedalb.csv ./
COPY /interpolatedalbu.csv ./
COPY /interpolatedcals.csv ./
COPY /interpolatedGlucser.csv ./ 
COPY /interpolatedGlucu.csv ./
COPY /interpolatedtpser.csv ./
COPY /interpolatedhbblood.csv ./
COPY /interpolatedmpu.csv 
# Copy the model files from the results directory
COPY /RandomForest_ModelCa.joblib  ./
COPY /RandomForest_ModelHb.joblib ./
COPY /RandomForest_ModelGl.joblib  ./
COPY /RandomForest_Modelalb.joblib ./
COPY /RandomForest_Modelalburine.joblib ./
COPY /RandomForest_Modeltpserum.joblib ./
COPY /RandomForest_Modelcalserum.joblib ./
COPY /RandomForest_ModelGlucserum.joblib ./
COPY /RandomForest_ModelGlucurine.joblib ./
COPY /RandomForest_Modelhbblood.joblib ./
COPY /RandomForest_Modelmpurine.joblib ./

# Copy the HTML file
COPY /predictionhtml.html ./

# Expose the container port on which the server will be listening
EXPOSE 5000

# Launch the server app
ENTRYPOINT ["python", "./dockerprediction.py"]
