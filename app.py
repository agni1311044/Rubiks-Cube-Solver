from flask import Flask, request
import subprocess

app = Flask(__name__)

@app.route('/')
def home():
    return "My Rubik's Cube Solver Web App is working!"

@app.route('/solve')
def solve():
    # This grabs the 'scramble' text from the web URL
    scramble = request.args.get('scramble', '')
    
    if not scramble:
        return "Please provide a scramble. (Example: /solve?scramble=R U R')"

    try:
        # This tells Python to run your compiled C++ program in the terminal!
        # Note: The executable is inside the 'build' folder based on your Dockerfile
        process = subprocess.run(
            ['./build/RubiksCubeSolver', scramble], 
            capture_output=True, 
            text=True, 
            timeout=30 # Gives the C++ code up to 30 seconds to find a solution
        )
        
        # Return whatever the C++ program printed to the terminal
        return f"<pre>Scramble: {scramble}\n\nOutput from C++:\n{process.stdout}\n{process.stderr}</pre>"
        
    except Exception as e:
        return f"An error occurred: {str(e)}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)