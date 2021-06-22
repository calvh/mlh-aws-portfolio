#!/bin/bash

# run "flask init-db" before doing tests

root_url="http://localhost:5000/"
auth_url="${root_url}auth/"
username1=john
username2=jane
password1=john
password2=jane

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
auth_endpoint "POST '/auth/register' username='' password='' ..." "${auth_url}register" "" ""

# test register no username with password
auth_endpoint "POST '/auth/register' username='' password='john' ..." "${auth_url}register" "" "john"

# test register username with no password
auth_endpoint "POST '/auth/register' username='john' password='' ..." "${auth_url}register" "john" ""

# test register new user
auth_endpoint "POST '/auth/register' username='john' password='john' ..." "${auth_url}register" "john" "john"

# test register existing user
auth_endpoint "POST '/auth/register' username='john' password='john' ..." "${auth_url}register" "john" "john"


# test login no username no password
auth_endpoint "POST '/auth/login' username='' password='' ..." "${auth_url}login" "" ""

# test login no username with password
auth_endpoint "POST '/auth/login' username='' password='john' ..." "${auth_url}login" "" "john"

# test login username with no password
auth_endpoint "POST '/auth/login' username='john' password='' ..." "${auth_url}login" "john" ""

# test login user
auth_endpoint "POST '/auth/login' username='john' password='john' ..." "${auth_url}login" "john" "john"

# test login non-existing user
auth_endpoint "POST '/auth/login' username='jane' password='jane' ..." "${auth_url}login" "jane" "jane"

# test login wrong password
auth_endpoint "POST '/auth/login' username='john' password='jane' ..." "${auth_url}login" "john" "jane"
