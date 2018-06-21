#!/bin/bash

# sorry this is pretty ugly but it works I think

# this file is in the same directory as where `timelogs.txt` is created by sleep-wake-log-time.sh

# read lines from file
filename="timelogs.txt"
re="^[0-9]+$"
curline=""
prevts=0 #prev time stamp
sum=0

while read -r line
do
  number="$line"
  # echo "Name read from file - $name"
  if ! [[ $number =~ $re ]] ; then
    # echo "not a number $number"; exit 1
    # check for sleep or wake
    if [ "$number" = "sleep" ] ; then
      curline="sleep"
    else
      curline="wake"
    fi
  else
    # compute values
    if [ $curline = "sleep" ] ; then
      # expecting low number, no math
      # do previous check, first one is sleep or none, need wake to sleep
      if [ $prevts != 0 ]; then
        tsdiff=$(($number-$prevts))
        echo $tsdiff
        sum=$(($sum+$tsdiff))
        echo $sum
        # sum=$(((($sum+$tsdiff)/60)/60))
        secs=" seconds"
        # echo $sum$secs
        # printf "%.3f\n" "$sum"
      fi
      # prevts=$number
    else 
      # expecting high number, do subtraction
      # echo $(($number-$prevts))
      prevts=$number
    fi
  fi
done < "$filename"

# battlife=$(($sum/3600))
# printf "%.3f\n" "$battlife"
# echo "batt life in hours:"
battlife=$(bc -q <<< scale=2\;$sum/3600)
hrs="hrs"
battlifehrs="$battlife hrs"
# echo "%0.2f\n"$battlifehrs
echo $battlifehrs
