FROM python:3.10-slim

# CHANGED: Added git and git-lfs so Docker can download the massive database
RUN apt-get update && apt-get install -y cmake g++ git git-lfs

# Copy your project files into the server
WORKDIR /app
COPY . /app

# CHANGED: Explicitly pull the real 120MB file to replace the Git LFS pointer
RUN git config --global --add safe.directory /app
RUN git lfs install && git lfs pull

# Install Flask (our web framework)
RUN pip install -r requirements.txt

# Compile your C++ code using your existing CMakeLists.txt
RUN cmake -B build
RUN cmake --build build

# Start the web server
CMD ["python", "app.py"]