FROM python:3.10-slim

# Install C++ tools, git, and git-lfs
RUN apt-get update && apt-get install -y cmake g++ git git-lfs curl

# Copy your project files into the server
WORKDIR /app
COPY . /app

# Initialize a temp git repo so git lfs can pull the 120MB database file
RUN git init && \
    git lfs install && \
    git remote add origin https://github.com/agni1311044/Rubiks-Cube-Solver.git && \
    git config --global --add safe.directory /app && \
    git lfs pull

# Install Flask (our web framework)
RUN pip install -r requirements.txt

# Compile your C++ code using your existing CMakeLists.txt
RUN cmake -B build
RUN cmake --build build

# Start the web server
CMD ["python", "app.py"]