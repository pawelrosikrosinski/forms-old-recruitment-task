FROM python
WORKDIR /app
COPY ./ .
ENV FLASK_APP main.py
RUN python -m pip install -r requirements.txt
