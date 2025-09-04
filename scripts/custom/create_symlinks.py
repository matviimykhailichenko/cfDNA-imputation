import pandas as pd
from pathlib import Path
import subprocess



df = pd.read_csv("../../doc/sample_manifest.csv")
data_path = Path('/home/gpfs/o_mykhaili/galushka/data')

for idx, row in df.iterrows():
    bam_path = row['bam_path']
    symlink_path = data_path/ f'{row['sample_id']}_30x.bam'

    cmd = f'ln -s {bam_path} {str(symlink_path)}'
    subprocess.run(cmd,
                   check=True,
                   shell=True)

