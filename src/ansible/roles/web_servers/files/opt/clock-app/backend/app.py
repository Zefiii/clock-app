from flask import Flask
import time


app = Flask(__name__)

@app.route('/clock', methods=['GET'])
def clock_time():
    return str(time.time())

