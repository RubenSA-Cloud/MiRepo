from flask import Flask
import os
import psycopg2

app = Flask(__name__)

@app.route('/')
def index():
    try:
        conn = psycopg2.connect(
            dbname="postgres",
            user="postgres",
            password=os.getenv("POSTGRES_PASSWORD"),
            host="db"
        )
        return "✅ Conectado a PostgreSQL"
    except Exception as e:
        return f"❌ Error: {e}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)

