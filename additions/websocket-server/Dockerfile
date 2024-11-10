# Step 1: Use a lightweight Python 3.10 base image
FROM python:3.10-slim

# Step 2: Set a working directory inside the container
WORKDIR /app

# Step 3: Copy the requirements.txt file into the container
COPY requirements.txt .

# Step 4: Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Step 5: Install curl, procps, Node.js (for wscat), iputils-ping, and net-tools (for netstat)
RUN apt-get update && apt-get install -y \
    curl \
    procps \
    nodejs \
    npm \
    iputils-ping \
    net-tools \
    && npm install -g wscat

# Step 6: Copy the application code into the container
COPY . .

# Step 7: Expose the port your application will use (default port, can be overridden)
EXPOSE 80

# Step 8: Use an environment variable for the port, with a default value (80), and pass it to the server.py script
CMD ["sh", "-c", "python server.py --port ${PORT:-80}"]
