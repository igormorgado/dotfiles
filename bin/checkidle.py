#!/usr/bin/env python3

# set idle time below (seconds)
idle_set = 1200

# shutdown time in seconds.(must be smaller than idle_set)
shutdown = 600

# Everything below this is idle (in packets)
net_idle_threshold = 200

# Everything below this is idle (in 1min load average)
sys_idle_threshold = 0.4

# Users Threshold
users_threshold = 1

# check interval
interval=10

# Run dir
rundir="/var/run/checkidle"
runfile="status"

######################################################################
### DO NOT TOUCH DOWN BELOW
######################################################################
# TODO:
# - Add conf file at /etc
# - Add control files on /var/run/service  to be accessed by externalapps
#   similar to a /proc/sys  standard
# - Add logged users monitoring (users idle time is possible?)
# How to get this IDLE counter?:
#  USER     TTY      FROM             LOGIN@   IDLE   JCPU   PCPU WHAT
#  igormorg pts/1    186.205.163.49   21:02    8.00s  0.08s  0.08s -bash
# - Make thresholds be based on a unit as (packets/s loadavg/m, etc.
#   that way no matter if the interval is 10 or 2000 it will scale for it.
#   Change reset to -shutdown time since it will count the same tiem again...



import sys
import time
import subprocess
import os
import psutil
import errno
import atexit



def create_runfile():
    FIFO=os.path.join(rundir,runfile)

    if not os.path.exists(rundir):
        os.makedirs(rundir)

    if os.path.isdir(FIFO):
        os.rmdir(FIFO)
    elif os.path.isfile(FIFO):
        os.remove(FIFO)

    with open(FIFO, 'w'):
        pass


def cleanup():
    FIFO=os.path.join(rundir,runfile)

    os.remove(FIFO)
    os.rmdir(rundir)


def write_runfile(rx1, rx0, tx1, tx0, la0, us0):
    FIFO=os.path.join(rundir,runfile)

    runfilefmt="{} {} {} {} {} {} {} {} {}"
    runfilestr=runfilefmt.format(interval, net_idle_time, sys_idle_time, idle_set, rx1-rx0, tx1-tx0, net_idle_threshold, la0, sys_idle_threshold)

    with open(FIFO, "w") as f:
        f.write(runfilestr)
        

def get_packets(iface="eth0"):

    sysdir="/sys/class/net/{}/statistics/".format(iface)

    rxfile=os.path.join(sysdir,"rx_packets")
    txfile=os.path.join(sysdir,"tx_packets")

    try:
        rx = int(open(rxfile, "r").readline().strip())
        tx = int(open(txfile, "r").readline().strip())
    except IOError as e:
        print("Could not open statistics file")
        sys.exit(1)

    return rx,tx


def get_load1m():
    return os.getloadavg()[0]


def get_nusers():
    localusers=[ x for x in psutil.users() if ( "tmux" or "screen" ) not in x.host]

    return len(localusers)


def get_metrics():
    r,t = get_packets()
    l = get_load1m()
    u = get_nusers()
    return r, t, l, u


def show_debug(rx0, tx0, la0, us0):
    debugline_fmt="nt:{:5d}  st:{:5d}  rx:{:5d}  tx:{:5d}  laD:{:5.2f}\n"
    debugline=debugline_fmt.format(net_idle_time,sys_idle_time, rx1-rx0, tx1-tx0, la0)
    sys.stderr.write(debugline)
    sys.stderr.flush()


def show_startline(interval, idle_set, shutdown, net_idle_threshold, sys_idle_threshold):
    startline_fmt="Check Interval: {}, Max Idle Time: {}, Shutdown Timer: {}, Net Threshold: {}, Sys Threshold: {}\n"
    startline=startline_fmt.format(interval, idle_set, int(shutdown)*60, net_idle_threshold, sys_idle_threshold)
    sys.stderr.write(startline)
    sys.stderr.flush()


def start_shutdown(shutdown):
    sys.stderr.write("SHUTDOWN sent")
    sys.stderr.flush()
    shutdown="+"+str(shutdown)
    subprocess.Popen(["shutdown", "-h", shutdown])


def evaluate_network(net_idle_time):
    if all([rx1 - rx0 < net_idle_threshold, tx1 - tx0 < net_idle_threshold ]):
        net_idle_time += interval
    else:
        net_idle_time = 0

    return net_idle_time

def evaluate_system(sys_idle_time):
    if (la1 < sys_idle_threshold):
        sys_idle_time += interval
    else:
        sys_idle_time = 0

    return sys_idle_time


if __name__ == "__main__":
    # Sanitize shutdown
    if shutdown >= idle_set: shutdown = idleset - 60

    # Shutdown must be in minutes
    shutdown=int(shutdown/60)

    # Shutdown cannot be lower than 5 (to avoid unrecoverable situations)
    shutdown=max(shutdown,5)

    # Initialize the counters
    net_idle_time=0
    sys_idle_time=0

    rx0, tx0, la0, us0 = get_metrics()
    rx1, tx1, la1, us1 = get_metrics()

    atexit.register(cleanup)

    create_runfile()
    write_runfile(rx1, rx0, tx1, tx0, la0, us0)

    show_startline(interval, idle_set, shutdown, net_idle_threshold, sys_idle_threshold)


    while True:
        time.sleep(interval)

        rx1, tx1, la1, us1 = get_metrics()

        net_idle_time = evaluate_network(net_idle_time)
        sys_idle_time = evaluate_system(sys_idle_time)

        if all([net_idle_time > idle_set, sys_idle_time > idle_set]):
            net_idle_time = sys_idle_time = -(shutdown*60)
            start_shutdown(shutdown) 

        show_debug(rx0, tx0, la0, us0)
        write_runfile(rx1, rx0, tx1, tx0, la0, us0)

        rx0, tx0, la0, us0 = rx1, tx1, la1, us1

