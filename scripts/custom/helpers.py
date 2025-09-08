from pathlib import Path



def get_highest_cov_bam(wc, data_dir):
    bams = list(Path(data_dir).glob(f"{wc.sample}_*.bam"))
    covs = [int(bam.stem.split("_")[-1]) for bam in bams]
    best_cov = max(covs)
    return str(Path(data_dir) / f"{wc.sample}_{best_cov}.bam")

def get_highest_cov_bai(wc, data_dir):
    return get_highest_cov_bam(wc, data_dir) + ".bai"