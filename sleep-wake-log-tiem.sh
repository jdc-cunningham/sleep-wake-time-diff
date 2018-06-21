#!/bin/bash

# this file and the other bash file's code is largely not mine, I had to look up
# how to write bash

# current time stamp
timestamp () {
  echo $(date "+%s")
}

# system event
sleep () {
  echo "sleep"
}

wake () {
  echo "wake"
}

if [ "${1}" == "pre" ]; then
sleep >> '/home/your-name/scripts/bash/timelogs.txt'
timestamp >> '/home/your-name/scripts/bash/timelogs.txt'
elif [ "${1}" == "post" ]; then
wake >> '/home/your-name/scripts/bash/timelogs.txt'
timestamp >> '/home/your-name/scripts/bash/timelogs.txt'
fi
