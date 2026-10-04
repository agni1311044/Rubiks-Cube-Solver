FROM python:3.10-slim

# Install C++ tools and curl
RUN apt-get update && apt-get install -y cmake g++ curl

# Copy your project files into the server
WORKDIR /app
COPY . /app

# Create the Database directory and download the real 120MB binary directly
RUN mkdir -p Database
RUN curl -L -o Database/cornerDepth5V1.bin "https://github.com/agni1311044/Rubiks-Cube-Solver/releases/download/v1.0/cornerDepth5V1.bin"

# Install Flask (our web framework)
RUN pip install -r requirements.txt

# Compile your C++ code using your existing CMakeLists.txt
RUN cmake -B build
RUN cmake --build build

# Start the web server
CMD ["python", "app.py"]