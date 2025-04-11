#!/usr/bin/env python

import os
import sys
import time
import shutil
import atexit
import subprocess
from pathlib import Path
from typing import Tuple

import psutil
import typer

app = typer.Typer()


class IdleShutdownMonitor:
    def __init__(
        self,
        idle_set: int = 1200,
        shutdown: int = 600,
        net_idle_threshold: int = 200,
        sys_idle_threshold: float = 0.4,
        users_threshold: int = 1,
        interval: int = 10,
        iface: str = "eth0",
        rundir: str = "/var/run/checkidle",
        runfile: str = "status"
    ):
        if shutdown >= idle_set:
            shutdown = idle_set - 60
        self.idle_set = idle_set
        self.shutdown_delay = max(shutdown // 60, 5)  # in minutes

        self.net_idle_threshold = net_idle_threshold
        self.sys_idle_threshold = sys_idle_threshold
        self.users_threshold = users_threshold
        self.interval = interval
        self.iface = iface

        self.net_idle_time = 0
        self.sys_idle_time = 0

        self.rundir = Path(rundir)
        self.runfile_path = self.rundir / runfile

        atexit.register(self.cleanup)
        self.create_runfile()

    def create_runfile(self):
        self.rundir.mkdir(parents=True, exist_ok=True)
        if self.runfile_path.exists():
            self.runfile_path.unlink()
        self.runfile_path.touch()

    def cleanup(self):
        if self.runfile_path.exists():
            self.runfile_path.unlink()
        if self.rundir.exists():
            shutil.rmtree(self.rundir, ignore_errors=True)

    def get_packets(self) -> Tuple[int, int]:
        try:
            rx_path = f"/sys/class/net/{self.iface}/statistics/rx_packets"
            tx_path = f"/sys/class/net/{self.iface}/statistics/tx_packets"
            with open(rx_path, 'r') as f:
                rx = int(f.readline().strip())
            with open(tx_path, 'r') as f:
                tx = int(f.readline().strip())
            return rx, tx
        except IOError:
            typer.echo("Could not open network statistics file.", err=True)
            raise typer.Exit(code=1)

    def get_load1m(self) -> float:
        return os.getloadavg()[0]

    def get_nusers(self) -> int:
        return len([u for u in psutil.users() if not ("tmux" in u.host or "screen" in u.host)])

    def get_metrics(self) -> Tuple[int, int, float, int]:
        r, t = self.get_packets()
        l = self.get_load1m()
        u = self.get_nusers()
        return r, t, l, u

    def write_runfile(self, interval: int, rx_delta: int, tx_delta: int, la: float):
        content = f"{interval} {self.net_idle_time} {self.sys_idle_time} {self.idle_set} {rx_delta} {tx_delta} {self.net_idle_threshold} {la} {self.sys_idle_threshold}"
        self.runfile_path.write_text(content)

    def evaluate_network(self, rx_delta: int, tx_delta: int) -> None:
        if rx_delta < self.net_idle_threshold and tx_delta < self.net_idle_threshold:
            self.net_idle_time += self.interval
        else:
            self.net_idle_time = 0

    def evaluate_system(self, load_avg: float) -> None:
        if load_avg < self.sys_idle_threshold:
            self.sys_idle_time += self.interval
        else:
            self.sys_idle_time = 0

    def start_shutdown(self):
        typer.echo("System is idle. Sending shutdown command.", err=True)
        subprocess.Popen(["shutdown", "-h", f"+{self.shutdown_delay}"])

    def run(self):
        rx0, tx0, la0, us0 = self.get_metrics()

        typer.echo(f"Monitoring started. Interval: {self.interval}s, Idle Limit: {self.idle_set}s, Shutdown in: {self.shutdown_delay}m", err=True)

        while True:
            time.sleep(self.interval)
            rx1, tx1, la1, us1 = self.get_metrics()

            rx_delta = rx1 - rx0
            tx_delta = tx1 - tx0

            self.evaluate_network(rx_delta, tx_delta)
            self.evaluate_system(la1)

            self.write_runfile(self.interval, rx_delta, tx_delta, la1)

            typer.echo(f"nt:{self.net_idle_time:5d} st:{self.sys_idle_time:5d} rx:{rx_delta:5d} tx:{tx_delta:5d} la:{la1:.2f}", err=True)

            if self.net_idle_time > self.idle_set and self.sys_idle_time > self.idle_set:
                self.start_shutdown()
                self.net_idle_time = self.sys_idle_time = -(self.shutdown_delay * 60)  # prevent repeat triggers

            rx0, tx0, la0, us0 = rx1, tx1, la1, us1


@app.command()
def main(
    idle_set: int = 1200,
    shutdown: int = 600,
    net_idle_threshold: int = 200,
    sys_idle_threshold: float = 0.4,
    users_threshold: int = 1,
    interval: int = 10,
    iface: str = "eth0"
):
    monitor = IdleShutdownMonitor(
        idle_set=idle_set,
        shutdown=shutdown,
        net_idle_threshold=net_idle_threshold,
        sys_idle_threshold=sys_idle_threshold,
        users_threshold=users_threshold,
        interval=interval,
        iface=iface
    )
    monitor.run()


if __name__ == "__main__":
    app()
