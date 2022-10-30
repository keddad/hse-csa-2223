from subprocess import run, PIPE, STDOUT
from statistics import median
from pathlib import Path

binaries = ["ref", "ref_regopt", "ref_size", "ref_speed"]
sizes = {}
asm_sizes = {}

res = {x: [] for x in binaries}

N = 200
L = 150

for bin in binaries:
    sizes[bin] = Path(bin).stat().st_size

    p = run(f"objdump -d {bin}", stdout=PIPE, shell=True)
    asm_sizes[bin] = len(p.stdout.decode().splitlines())

for i in range(N):
    for bin in binaries:
        p = run(f"./{bin} s {L}", stdout=PIPE, shell=True)

        res[bin].append(float(p.stdout.decode().splitlines()[-1].split()[2]))

print("Binary\tAverage\tMedian\tFile size\tASM Size")

for bin in binaries:
    print(f"{bin}\t{sum(res[bin])/len(res[bin])}\t{median(res[bin])}\t{sizes[bin]}\t{asm_sizes[bin]}")