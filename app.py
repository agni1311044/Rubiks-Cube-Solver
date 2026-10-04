from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "My Rubik's Cube Solver Web App is working!"

if __name__ == '__main__':
    # Adding host='0.0.0.0' tells the server to accept outside internet traffic
    app.run(host='0.0.0.0', port=8080)