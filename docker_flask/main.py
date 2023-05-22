# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

from flask import Flask, request, json, jsonify
from flask_cors import CORS
import psycopg2
from psycopg2.extras import DictCursor

# Press the green button in the gutter to run the script.
if __name__ == '__main__':

    connection = psycopg2.connect("dbname=forms user=admin host=db password=password port=5432",
                                  cursor_factory=DictCursor)
    connection.autocommit = True

    cursor = connection.cursor()

    cursor.execute(open("db_schema.sql", "r").read())

    app = Flask(__name__)
    CORS(app)


    @app.route("/get_formtemplates")
    def get_formtemplates():
        cursor.execute("execute get_formtemplates")

        return cursor.fetchone()[0]


    @app.route("/get_forms_list")
    def get_forms_list():
        cursor.execute("execute get_forms_list")

        return cursor.fetchone()[0]


    @app.route("/get_form_qa")
    def get_form_qa():
        cursor.execute(f"execute get_form_qa({request.args.get('forms_id')})")
        return cursor.fetchone()[0]


    @app.route("/get_form_poll")
    def get_form_poll():
        cursor.execute(f"execute get_form_poll({request.args.get('forms_id')})")
        return cursor.fetchone()[0]


    @app.route("/get_searches")
    def get_searches():
        cursor.execute(f"execute get_searches")
        return cursor.fetchone()[0]


    @app.route("/create_new_form")
    def create_new_form():
        cursor.execute(f"execute create_new_form ({request.args.get('formtemplates_id')})")
        return str(cursor.fetchone()[0])


    @app.route("/post_form_qa", methods=['GET', 'POST'])
    def post_form_qa():
        if request.method == 'POST':
            cursor.execute(f"execute post_form_qa ('{request.data.decode()}', {request.args.get('forms_id')})")
            return "Yes"


    @app.route("/post_form_poll", methods=['GET', 'POST'])
    def post_form_poll():
        if request.method == 'POST':
            cursor.execute(f"execute post_form_poll ('{request.data.decode()}', {request.args.get('forms_id')})")
            return "Yes"

app.run(port=5000, host="0.0.0.0")

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
