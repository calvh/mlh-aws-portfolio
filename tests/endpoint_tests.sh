#!/bin/bash

url="http://localhost:5000/"
username1=John
username2=Jane
password1=john
password2=jane

# test register no username no password
# test register no username with password
# test register username with no password
# test register new user
# test register existing user

# test login no username no password
# test login no username with password
# test login username with no password
# test login user
# test login non-existing user
# test login wrong password

# test index page
# test projects page
# test contact page
# test resume page
# test 404 page

# test http redirects to https
echo $(curl "${url}")
