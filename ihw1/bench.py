from subprocess import run, PIPE, STDOUT
from statistics import median

binaries = ["ref", "ref_regopt"]

res = {x: [] for x in binaries}

N = 10
L = 3000

for i in range(N):
    for bin in binaries:
        p = run(f"./{bin} s {L}", stdout=PIPE, shell=True)

        res[bin].append(float(p.stdout.decode().splitlines()[1].split()[2]))

print("Binary\tAverage\tMedian")

for bin in binaries:
    print(f"{bin}\t{sum(res[bin])/len(res[bin])}\t{median(res[bin])}")