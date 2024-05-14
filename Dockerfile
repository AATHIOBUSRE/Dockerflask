FROM python:3.10.4

# Set the working directory inside the container
WORKDIR /aathi/

# Copy the requirements file and install dependencies
COPY requirements.txt /aathi/
RUN pip install -r ./requirements.txt

# Copy the server code
COPY dockercomma.py /aathi/

# Copy the CSV files
COPY interpolatedca.csv /aathi/
COPY interpolatedHb.csv /aathi/
COPY interpolatedgl.csv /aathi/

# Copy the model files
COPY RandomForest_ModelCa.joblib /aathi/
COPY RandomForest_ModelHb.joblib /aathi/
COPY RandomForest_ModelGl.joblib /aathi/

COPY comma.html /aathi/
# Expose the container port on which the server will be listening
EXPOSE 5000

# Launch the server app
ENTRYPOINT ["python", "./dockercomma.py"]
