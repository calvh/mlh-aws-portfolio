#!/bin/bash

# run "flask init-db" before doing tests

root_url="http://localhost:5000/"
auth_url="${root_url}auth/"
register_url="${auth_url}register/"
login_url="${auth_url}login/"
username1=user1
username2=user2
password1=passwd1
password2=passwd2

function get_endpoint() {
    args=(-I -s -o /dev/null -w %{http_code} "${2}")
    echo "${1}" $(curl "${args[@]}")
}

function auth_endpoint() {
    args=(-s -o /dev/null -w %{http_code} -X POST "${2}" -F username=${3} -F password=${4})
    echo "${1}" $(curl "${args[@]}")
}

# test index page
get_endpoint "GET '/' ..." "${root_url}"

# test projects page
get_endpoint "GET '/projects/' ..." "${root_url}projects/"

# test contact page
get_endpoint "GET '/contact/' ..." "${root_url}contact/"

# test resume page
get_endpoint "GET '/resume/' ..." "${root_url}resume/"

# test 404 page
get_endpoint "GET '/oops/' ..." "${root_url}oops/"

# test register no username no password
auth_endpoint "POST /auth/register/' username='' password='' ..." "${register_url}" "" ""

# test register no username with password
auth_endpoint "POST '/auth/register/' username='' password='${password1}' ..." "${register_url}" "" "${password1}"

# test register username with no password
auth_endpoint "POST '/auth/register/' username='${username1}' password='' ..." "${register_url}" "${username1}" ""

# test register new user
auth_endpoint "POST '/auth/register/' username='${username1}' password='${password1}' ..." "${register_url}" "${username1}" "${password1}"

# test register existing user
auth_endpoint "POST '/auth/register/' username='${username1}' password='${password1}' ..." "${register_url}" "${username1}" "${password1}"

# test login no username no password
auth_endpoint "POST '/auth/login/' username='' password='' ..." "${login_url}" "" ""

# test login no username with password
auth_endpoint "POST '/auth/login/' username='' password='${password1}' ..." "${login_url}" "" "${password1}"

# test login username with no password
auth_endpoint "POST '/auth/login/' username='${username1}' password='' ..." "${login_url}" "${username1}" ""

# test login user
auth_endpoint "POST '/auth/login/' username='${username1}' password='${password1}' ..." "${login_url}" "${username1}" "${password1}"

# test login non-existing user
auth_endpoint "POST '/auth/login/' username='${username2}' password='${password2}' ..." "${login_url}" "${username2}" "${password2}"

# test login wrong password
auth_endpoint "POST '/auth/login/' username='${username1}' password='${password2}' ..." "${login_url}" "${username1}" "${password2}"
