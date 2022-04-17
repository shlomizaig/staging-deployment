#!/bin/bash
# Usage: Hello World Bash Shell Script Using Variables
# -------------------------------------------------
 
# Define bash shell variable called var 
# Avoid spaces around the assignment operator (=)
var="staging script55"
 
# Another way of printing it
printf "%s\n" "$var"

# create a file
mkdir -p target_files
touch target_files/script_file55.txt

############################################
## cleanup

# limit journam 200m
journalctl --vacuum-size=200M

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        snap remove "$snapname" --revision="$revision"
    done

# apt-get cleanup - sudo ommited as boyar is already sudo
apt-get clean
# clean apt cache 
apt-get autoclean
# unnecessary packages
apt-get autoremove
# old kernel versions
dpkg --get-selections | grep linux-image
# snapd
apt purge snapd