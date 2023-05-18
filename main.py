# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

from flask import Flask, request
import psycopg2
from psycopg2.extras import DictCursor

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    connection = psycopg2.connect("dbname=forms user=admin host=localhost password=password", cursor_factory=DictCursor)
    connection.autocommit = True

    cursor = connection.cursor()

    cursor.execute(open("db_schema.sql", "r").read())

    app = Flask(__name__)


    @app.route("/get_forms_list")
    def get_forms_list():
        cursor.execute("execute get_forms_list")
        return cursor.fetchall()


    @app.route("/get_form_qa")
    def get_form_qa():
        cursor.execute(f"execute get_form_qa({request.args.get('forms_id')})")
        return cursor.fetchone()


    @app.route("/get_form_poll")
    def get_form_poll():
        cursor.execute(f"execute get_form_qa({request.args.get('forms_id')})")
        return cursor.fetchone()


    @app.route("/get_searches")
    def get_searches():
        cursor.execute(f"execute get_searches")
        return cursor.fetchone()


    @app.route("/create_new_form")
    def create_new_form():
        cursor.execute(f"execute create_new_form ({request.args.get('formtemplates_id')})")
        return cursor.fetchone()


    @app.route("/post_form_qa")
    def post_form_qa():
        cursor.execute(f"execute post_form_qa ({request.get_json()})")
        return cursor.fetchone()


    @app.route("/post_form_poll")
    def post_form_poll():
        cursor.execute(f"execute post_form_poll ({request.get_json()})")
        return cursor.fetchone()

app.run()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
