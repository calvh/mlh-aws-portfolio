#!/bin/bash


root_url="https://calvh.duckdns.org/"

function get_endpoint() {
    args=(-I -s -o /dev/null -w %{http_code} "${2}")
    status=$(curl "${args[@]}")
    echo "${1} ${status}" "$(if [[ "${status}" == "${3}" ]]; then exit 0; else exit 1; fi)"
}

# test index page
get_endpoint "GET '/' ..." "${root_url}" 200
