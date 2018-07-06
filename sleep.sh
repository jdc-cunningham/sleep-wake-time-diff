#!/bin/bash
# current time stamp
timestamp () {
  echo $(date "+%s")
}

# system event
sleep () {
  echo "sleep"
}

# write to timelogs.txt
sleep >> '/home/your_username/scripts/bash/timelogs.txt'
timestamp >> '/home/your_ursername/scripts/bash/timelogs.txt'

# run i3lock sleep
eval "$(echo "i3lock -i ~/a.png; sudo pm-suspend")"
