#!/home/muy/miniconda3/bin/python
import subprocess
from tabulate import tabulate

out = subprocess.Popen(['docker','ps', '--format', '"table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.RunningFor}}\t{{.Ports}}"'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)

stdout, _ = out.communicate()
stdout = stdout.decode('utf-8')
lines = stdout.split('\n')
table = []
for line in lines[:-1]:
    parts = line.split('\t')
    parts[0] = parts[0].split(' ')[1]
    project, container, _ = parts[0].split('_')
    image = parts[1]
    status = parts[2]
    uptime = parts[3]
    ports = parts[4]
    table.append([project, container, image, status, uptime, ports])
print(tabulate(table, headers=["PROJECT", "CONTAINER", "IMAGE", "STATUS", "UPTIME", "PORTS"]))