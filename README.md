You are looking at a simple web app for management of semi-structured form data.

Oddly enough, I like to work with SQL, so entire solution appear to be db-centric.

Postgres takes care of all backend json processing (both synthesis and analysis), and also database schema is defined at idempotent script "db_schema.sql". It is almost free of PL/SQL - only one element required it.

All queries are SQL-injection resistant.

Frameworks, Libraries and Solutions were: Angular, Flask, Psycopg2, Postgres 15.2

Languages: Python, PSQL, TS, HTML, CSS

Both ends communicate with URL parameters and JSON's.

---

1. Every form has two sets of possible answers: questions and pollquestions.
2. Questions are rendered statically, while pollquestions are rendered dynamically. Also, "questions" are always of type String, while "pollquestions" can be either String or Boolean.
3. "Pollquestions" are rendered in non-trivial order - depending on previous pollanswers. The database defines relation tree. For now, only "equals to" condition is implemented, but implementing any other would only require adding new switch case.
4. Order of "pollquestions" is ensured by a recurent function
5. Part of the assigment was to create OS-agnostic solution, like Docker containers. Here they are!

---

Build instructions (pro forma):

1. `git clone https://github.com/pawelrosikrosinski/forms`
2. kindly `cd` into it
3. `/bin/sh -c '[sudo] docker compose build'`
4. `/bin/sh -c '[sudo] docker compose up'`
5. App is now available at `http://127.0.0.1:80`

[ ] - optional argument
