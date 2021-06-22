import os

from flask import Flask, Response
from flask import render_template

from app import db
from app.portfolio import portfolio

app = Flask(__name__)
app.config["DATABASE"] = os.path.join(os.getcwd(), "flask.sqlite")
db.init_app(app)
app.register_blueprint(portfolio)


@app.route("/health")
def health():
    return Response(status=200)


@app.errorhandler(404)
def not_found(error_message):
    return render_template("404.html"), 404