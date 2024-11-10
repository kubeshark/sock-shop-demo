# Step 1: Use the Python 3.8 slim base image
FROM python:3.8-slim-buster

# Step 2: Set the working directory inside the container
WORKDIR /app

# Step 3: Copy the requirements file and install Python dependencies
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

# Step 4: Install curl, procps, Node.js (for wscat), and iputils-ping
RUN apt-get update && apt-get install -y \
    curl \
    procps \
    nodejs \
    npm \
    iputils-ping \
    && npm install -g wscat

# Step 5: Copy the application code and scripts
COPY example.py .
COPY run.sh .

# Step 6: Make sure run.sh is executable
RUN chmod +x ./run.sh

# Step 7: Set the entry point
CMD ["./run.sh"]
