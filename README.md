# sleep-wake-time-diff
These are a couple of bash scripts to log sleep/wake times then do a diff to hours on

## Note - This is for Linux

## Three Files:
* sleep-wake-log-time.sh
* math-bash.sh
* sleep.sh - this one is new, also logs time when you put computer into suspend

## /lib/systemd/system-sleep
This is where the `sleep-wake-log-time.sh` file goes.

When you close/open your laptop lid, the `sleep-wake-log-time.sh` detects which one happened and writes a sleep/wake label just before a timestamp.

Then `math-bash.sh parses` the 1`timelogs.txt` text file that was written to.

Note: this code is pretty ugly I can barely write bash, mostly found this code online.

`timelogs.txt` is written to `~/scripts/bash`

## time diff

`math-bash.sh` parses the lines and then is able to work backwards from a sleep to wake event and does a subtraction to find the difference in seconds from the timestamps. Then this s converted to hours by dividing the difference by 3600.

I wrote this because I wanted to find out how long this Chromebook that I loaded GalliumOs would last for with `tlp` and `cpufrequtils` enabled though I had to set the latter to performance as I could barely use Chrome. I also have a couple of Debian VM's on this Chromebook(Toshiba Chromebook 2 2014, with a Celeron cpu).

Powerstat says it averages 4 watts on use and the battery has a design capacity of ```44Wh``` or so... mine's at ```37.37Wh```

Anyway so `timelogs.txt` will have entries like this:

`sleep`

`1529495388`

`wake`

`1529542905`

`sleep`

`1529543952`

`wake`

`1529544587`

`sleep`

`1529548326`

`wake`

`1529548330`

`sleep`

`1529552631`

`wake`

`1529552684`

`sleep`

`1529552760`

`wake`

`1529552784`

And `math-bash.sh` will go through that and add it up so you get an output of something like:

`1047`

`1047`

`3739`

`4786`

`4301`

`9087`

`2.52 hrs`

When running

`$bash math-bash.sh`

## Update 07/06/2018

Added `sleep.sh` which is a bash script that you run to put your linux computer runnning `i3-wm` into suspend with i3lock.

You need to add your username to sudoers using visudo, check out this [link](https://askubuntu.com/questions/136356/allow-root-program-to-run-without-privileges)

The reason for that is you normally have to run `pm-suspend` as sudo. If you run `sudo i3lock` you won't be able to log back in(from what I've experienced)

I put this file in my home directory which you get to by `cd ~` so if you're in that directory you just call:

`$bash sleep.sh`

And your computer will lock the screen and go into suspend using `pm-suspend`


## Update 07/07/2018

So it turns out my sleep/wake logs were not working correctly after that `$sudo pm-suspend` approach.

I looked up some threads, [this one](https://askubuntu.com/questions/250690/how-to-run-a-script-when-suspending-resuming-sony-vaio-ubuntu-12-04) is what worked out for me. I put the `suspend-wake` bash script inside `/etc/pm/sleep.d/` and it works.

The `pm-suspend` route definitely seems to save battery over time. Currently running this on Toshiba Chromebook 2, 2014 Celeron model on GalliumOS with i3-wm.
