import pandas as pd
from pathlib import Path
import subprocess



df = pd.read_csv("../../doc/sample_manifest.csv")
data_path = Path('/home/gpfs/o_mykhaili/galushka/data/fragmentomics')
coverage_set = [15]

for idx, row in df.iterrows():
    bam_path = row['bam_path']
    sample_id = row['sample_id']
    for coverage in coverage_set:
        tentative_bam_path = Path(f'/home/isilon/HumGenTempData/LBFee/gcparagon/{sample_id}/BLACKLFIL1000TFBS1048TF_'
                                  f'{sample_id}.sorted.markdup_cov_{coverage}.0/BLACKLFIL1000TFBS1048TF_{sample_id}.'
                                  f'sorted.markdup_cov_{coverage}.0.GCtagged.bam')
        symlink_path = data_path / f'{sample_id}_{coverage}x.bam'

        if not tentative_bam_path.exists():
            continue

        if symlink_path.exists():
            break

        cmd = f'ln -s {tentative_bam_path} {str(symlink_path)}'
        subprocess.run(cmd,
                       check=True,
                       shell=True)

        cmd = f'ln -s {tentative_bam_path}.bai {str(symlink_path)}.bai'
        subprocess.run(cmd,
                       check=True,
                       shell=True)


        break

    if symlink_path.exists():
        print(f'Created symlink for sample "{sample_id}" or it had already existed')
    else:
        print(f"Couldn't create a symlink for sample {sample_id}")
