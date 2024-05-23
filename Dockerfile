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
COPY . .

# Expose the container port on which the server will be listening
EXPOSE 5000

# Launch the server app
ENTRYPOINT ["python", "./dockerprediction.py"]
