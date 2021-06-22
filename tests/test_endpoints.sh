#!/bin/bash

root_url="http://localhost:5000/"
auth_url="${root_url}""auth/"
echo "${auth_url}"
username1=john
username2=jane
password1=john
password2=jane

function get_endpoint() {
    local command="curl -I -s -o /dev/null -w %{http_code} "${2}""
    echo "${1}" "$(${command})"
}

function auth_endpoint() {
    local command="curl -s -L -X POST '"${2}"'"
    command+="-F 'username=\""${3}"\"'" 
    command+="-F 'password=\""${4}"\"'"
    echo "${command}"
    echo "${1}""$(${command})"
}

# test index page
get_endpoint "Testing '/' ..." "${root_url}"

# test projects page
get_endpoint "Testing '/projects/' ..." "${root_url}""projects/"

# test contact page
get_endpoint "Testing '/contact/' ..." "${root_url}""contact/"

# test resume page
get_endpoint "Testing '/resume/' ..." "${root_url}""resume/"

# test 404 page
get_endpoint "Testing '/oops/' ..." "${root_url}""oops/"

# test register no username no password
# test register no username with password
# test register username with no password
# test register new user

# test register existing user
# auth_endpoint "Testing register with empty credentials..." "john" "john"

# test login no username no password
# test login no username with password
# test login username with no password
# test login user
# test login non-existing user
# test login wrong password


# test http redirects to https
