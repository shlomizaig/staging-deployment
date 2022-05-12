#!/bin/bash
echo "stage 1"
set -u # trigger errors for unset vars
echo "stage 2"
if command -v curl &> /dev/null; then
    curl -XPOST -H "Content-Type: application/json" "http://logs.orbs.network:3001/putes/boyar-recovery" -d '{ "node": "$NODE_NAME", "script":"disk cleanup1", "stage":"start" }'
fi
echo "stage 3"

if command -v journalctl &> /dev/null; then
    journalctl --vacuum-size=200M
else
    echo "journalctl could not be found"    
fi    
echo "stage 4"    
# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS
if command -v snap &> /dev/null; then    
    LANG=C snap list --all | awk '/disabled/{print $1, $3}' |
        while read snapname revision; do
            snap remove "$snapname" --revision="$revision"
        done
else
    echo "snap could not be found"    
fi    
echo "stage 5"    
# apt-get cleanup
if command -v apt-get &> /dev/null; then
    # apt-get cleanup - sudo ommited as boyar is already sudo
    apt-get clean
    # clean apt cache 
    apt-get autoclean
    # unnecessary packages
    apt-get autoremove
    # snapd
    apt purge snapd
else
    echo "apt-get could not be found"
fi
echo "stage 6"    
# old kernel versions
if command -v dpkg &> /dev/null; then
    dpkg --get-selections | grep linux-image
else
    echo "apt-get could not be found"
fi
echo "stage 7"    
if command -v curl &> /dev/null; then
    curl -XPOST -H "Content-Type: application/json" "http://logs.orbs.network:3001/putes/boyar-recovery" -d '{ "node": "$NODE_NAME", "script":"disk cleanup1", "stage":"end" }'
fi
echo "stage 8"    