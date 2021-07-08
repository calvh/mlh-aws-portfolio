#!/bin/bash


root_url="https://calvh.duckdns.org/"

function get_endpoint() {
    
    args=(-I -s -m 30 -o /dev/null -w %{http_code} "${2}")
    status=$(curl "${args[@]}")
    if [[ "${status}" == "${3}" ]]; then
        echo "Test ${1} ${status} succeeded."
    else
        echo "Test ${1} ${status} failed."
        exit 1
    fi
}

# test index page
get_endpoint "GET '/' ..." "${root_url}" 200

# test projects page
get_endpoint "GET '/projects/' ..." "${root_url}projects/" 200

# test contact page
get_endpoint "GET '/contact/' ..." "${root_url}contact/" 200

# test resume page
get_endpoint "GET '/resume/' ..." "${root_url}resume/" 200

# test 404 page
get_endpoint "GET '/oops/' ..." "${root_url}oops/" 404
