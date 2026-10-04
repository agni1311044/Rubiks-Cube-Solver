FROM python:3.10-slim

# Install C++ tools
RUN apt-get update && apt-get install -y cmake g++

# Copy your project files into the server
WORKDIR /app
COPY . /app

# Install Flask (our web framework)
RUN pip install -r requirements.txt

# Compile your C++ code using your existing CMakeLists.txt
RUN cmake -B build
RUN cmake --build build

# Start the web server
CMD ["python", "app.py"]