from flask import Flask, jsonify, request
import mysql.connector
import os

app = Flask(__name__)

def get_db_connection():
    return mysql.connector.connect(
        host=os.getenv('PROXYSQL_HOST', 'localhost'),
        user=os.getenv('PROXYSQL_USER', 'app'),
        password=os.getenv('PROXYSQL_PASSWORD'),
        port=os.getenv('PROXYSQL_PORT', 6033),
        database=os.getenv('MYSQL_DATABASE')
    )

@app.route('/')
def index():
    return "ProxySQL Sample App"

@app.route('/users', methods=['GET'])
def get_users():
    try:
        connection = get_db_connection()
        cursor = connection.cursor(dictionary=True)
        cursor.execute("SELECT * FROM users")
        users = cursor.fetchall()
        cursor.close()
        connection.close()
        return jsonify(users)
    except mysql.connector.Error as err:
        return str(err), 500

@app.route('/users', methods=['POST'])
def add_user():
    try:
        data = request.json
        connection = get_db_connection()
        cursor = connection.cursor()
        cursor.execute("INSERT INTO users (name, email) VALUES (%s, %s)", (data['name'], data['email']))
        connection.commit()
        cursor.close()
        connection.close()
        return jsonify({"message": "User added successfully"}), 201
    except mysql.connector.Error as err:
        return str(err), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)