#!/bin/bash
# Usage: Hello World Bash Shell Script Using Variables
# -------------------------------------------------
 
# Define bash shell variable called var 
# Avoid spaces around the assignment operator (=)
var="staging script"
 
# Another way of printing it
printf "%s\n" "$var"

# create a file
mkdir -p target_files
touch target_files/script_file4.txt
