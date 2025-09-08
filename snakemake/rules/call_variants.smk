from scripts.custom.helpers import get_highest_cov_bam, get_highest_cov_bai


rule call_variants:
    input:
        bam=lambda wc: get_highest_cov_bam(wc,data_dir=config["data_dir"]),
        bai=lambda wc: get_highest_cov_bai(wc,data_dir=config["data_dir"]),
        ref=config["reference"]
    output:
        intermediate_vcf=f"{config['tmp_dir']}" + "/{sample}_tmp.vcf",
        vcf=f"{config['results_dir']}" + "/{sample}.vcf.gz",
        tbi=f"{config['results_dir']}" + "/{sample}.vcf.gz.tbi"
    threads: 12
    params:
        min_baseq=20,
        min_mapq=20,
        min_cov=12,
        min_qual=30
    conda:
        '../../envs/lofreq.yaml'
    log:
        'config["results_dir"]/{sample}_variant_calling.log'
    shell:
        r"""
        set -euo pipefail

        tmpvcf=$(mktemp --tmpdir $(basename {output.intermediate_vcf}).XXXXXX)

        lofreq call-parallel \
          --pp-threads {threads} \
          -f {input.ref} \
          --call-indels \
          -m {params.min_qual} \
          -q {params.min_baseq} \
          -Q {params.min_mapq} \
          -C {params.min_cov} \
          -o "$tmpvcf" \
          {input.bam} 2> {log}

        # compress + index
        bgzip -f -c "${tmpvcf}" > {output.vcf}
        tabix -f -p vcf {output.vcf} 2>> {log}
        """