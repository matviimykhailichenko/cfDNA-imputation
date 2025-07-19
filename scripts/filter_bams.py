from pathlib import Path
from subprocess import run as subp_run


data_dir = Path('/home/isilon/HumGenTempData/WGS/')
coverages = {}


bam_files = data_dir.rglob('*.bam')
for file in bam_files:
    cmd = f"samtools depth -a {file}" + " | awk '{sum += $3} END {if (NR > 0) print sum / NR}'"
    converage = subp_run(cmd, shell=True, check=True, capture_output=True, text=True).stdout()
    coverages[file] = converage

print(len(coverages))