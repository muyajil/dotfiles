#!/usr/bin/python3
import subprocess
from tabulate import tabulate

out = subprocess.Popen(
    [
        'docker',
        'ps',
        '--format',
        '"table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.RunningFor}}\t{{.Ports}}"'
    ],
    stdout=subprocess.PIPE,
    stderr=subprocess.STDOUT)

stdout, _ = out.communicate()
stdout = stdout.decode('utf-8')
lines = stdout.split('\n')
table = []
for line in lines[:-1]:
    parts = line.split('\t')
    parts[0] = parts[0].split(' ')[1]
    try:
        project, container = parts[0].split('_', 1)
        container = container[:-2]
    except ValueError:
        project = ""
        container = parts[0]
    image = parts[1]
    status = parts[2]
    uptime = parts[3]
    ports = parts[4].strip('"')
    table.append([project, container, image, status, ports])
table.sort(key=lambda x: x[0]+x[1])
print(tabulate(table, headers=["PROJECT", "CONTAINER", "IMAGE", "STATUS", "PORTS"]))
