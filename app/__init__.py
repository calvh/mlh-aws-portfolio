import os
import datetime

from flask import Flask, Response
from flask import render_template

from app import db
from app.portfolio import portfolio
from app.auth import auth

app = Flask(__name__)

app.config["DATABASE"] = os.path.join(os.getcwd(), "flask.sqlite")
db.init_app(app)

app.register_blueprint(auth)
app.register_blueprint(portfolio)

@app.context_processor
def inject_current_year():
    return {"current_year": datetime.datetime.now().year}

@app.route("/health")
def health():
    return Response(status=200)

@app.errorhandler(404)
def not_found(error_message):
    return render_template("404.html"), 404