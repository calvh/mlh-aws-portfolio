from flask import (
    Blueprint, flash, g, redirect, render_template, request, session, url_for
)
from werkzeug.security import check_password_hash, generate_password_hash

from app.db import get_db

auth = Blueprint("auth", __name__, url_prefix="/auth")

@auth.route("/register/", methods=("GET", "POST"))
def register():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        db = get_db()
        error = None

        if not username:
            error = 'Username is required.'
        elif not password:
            error = 'Password is required.'
        elif db.execute(
            'SELECT id FROM user WHERE username = ?', (username,)
        ).fetchone() is not None:
            error = f"User {username} is already registered."

        if error is None:
            db.execute(
                'INSERT INTO user (username, password) VALUES (?, ?)',
                (username, generate_password_hash(password))
            )
            db.commit()
            flash("Register successful, please login.")
            return redirect(url_for('auth.login'))

        flash(error)

    return render_template('register.html')


@auth.route("/login/", methods=("GET", "POST"))
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        db = get_db()
        error = None
        user = db.execute(
            'SELECT * FROM user WHERE username = ?', (username,)
        ).fetchone()

        if user is None:
            error = 'Incorrect username.'
        elif check_password_hash(user['password'], password) is False:
            error = 'Incorrect password.'

        if error is None:
            session.clear()
            session['username'] = user['username']
            session["id"] = user["id"]
            return redirect(url_for('portfolio.index'))

        flash(error)

    elif "username" in session:
        return redirect(url_for("portfolio.index"))

    return render_template('login.html')


@auth.route("/logout/")
def logout():
    session.clear()
    return redirect(url_for('portfolio.index'))