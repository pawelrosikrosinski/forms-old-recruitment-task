You are looking at a simple web app for management of semi-structured form data.

Oddly enough, I like to work with SQL, so whole solution appear to be db-centric.

Postgres takes care of all backend json processing (both synthesis and analysis), and also database schema is defined at idempotent script "db_schema.sql". It is almost free of PL/SQL - only one element required it.

All queries are SQL-injection resistant.

It would be easier for me to create front-end in pure JS, since frameworks have steep learning curve and I've never touched TypeScript.
That being noted, I've chosen Angular.

IDE's were: PyCharm form backend and VS Code for frontend.

Both ends communicate with URL parameters and JSON's. I know, JSON communication is supposed to be stateless, however in this app in some cases little URL context is required. Different approach would introduce heavy JSON processing redundancy.
I'm sure that JSON + URL communication is already stateless.

---

Now, more about assigment compatibility.

1. Every form have to sets of possible answers: questions and pollquestions.
2. Questions are rendered staticlly, while pollquestions are renderred dynamically. Also, "questions" are always of type String, while "pollquestions" can be either String or Boolean.
3. "Pollquestions" are rendered in non-trivial order - depending on previous pollanswers. For now, only "equals to" condition is implemented, but implementing any other would only require adding new switch case.
4. Order of "pollquestions" is unsured by a recurent function, what I consider cute addon.
