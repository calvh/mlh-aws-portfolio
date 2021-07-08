from flask import Blueprint, render_template

portfolio = Blueprint("portfolio", __name__, template_folder="templates")


@portfolio.route("/")
def index():
    return "Failure test", 404

@portfolio.route("/projects/")
def projects():
    return render_template("projects.html")

@portfolio.route("/contact/")
def contact():
    return render_template("contact.html")

@portfolio.route("/resume/")
def resume():
    return render_template("resume.html")
