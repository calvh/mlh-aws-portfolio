#!/bin/bash


root_url="https://calvh.duckdns.org/"

function get_endpoint() {
    args=(-I -s -m 30 -o /dev/null -w %{http_code} "${2}")
    status=$(curl "${args[@]}")
    if [[ "${status}" == "${3}" ]]; then
        echo "All systems go."
        exit 0 
    else
        echo "Something went wrong."
        exit 1
    fi
}

# test index page
get_endpoint "GET '/' ..." "${root_url}" 200
