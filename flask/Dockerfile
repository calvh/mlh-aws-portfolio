FROM python:3.8-slim-buster
WORKDIR /flask
COPY requirements.txt . 
RUN pip3 install -r requirements.txt
COPY . ./ 
ENTRYPOINT ["/bin/sh", "-c", "flask db upgrade && gunicorn wsgi:app -w 1 -b 0.0.0.0:5000 --capture-output --log-level debug"]
