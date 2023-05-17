# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

from flask import Flask
import psycopg2
from psycopg2.extras import DictCursor

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    connection = psycopg2.connect("dbname=forms user=admin host=localhost password=password", cursor_factory=DictCursor)

    cursor = connection.cursor()

    cursor.execute(open("db_schema.sql", "r").read())

    app = Flask(__name__)


    @app.route("/")
    def hello_world():
        return "<p>Hello, World!</p>"


    app.run()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
