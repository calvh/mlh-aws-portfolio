#!/bin/bash
#
# script for load testing using Apache Bench

root_url=https://calvh.duckdns.org/
num_requests=1000
concurrent=10

# test "/"
ab -n ${num_requests} -c ${concurrent} "${root_url}"

# test "/auth/health/"
ab -n ${num_requests} -c ${concurrent} "${root_url}auth/health/"
