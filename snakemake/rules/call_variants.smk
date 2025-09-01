rule call_variants:
    input:
        bam="../tmp/{sample}.bam",
        bai="../tmp/{sample}.bam.bai",
        ref=config["reference"]
    output:
        vcf = "../tmp/{sample}.lofreq.vcf.gz",
        tbi="../tmp/{sample}.lofreq.vcf.gz.tbi"
    threads: 12
    resources:
        mem_mb=24000,
        runtime="06:00:00"
    params:
        min_baseq=20,
        min_mapq=20,
        min_cov=12,
        min_qual=30
    log:
        '../logs/{sample}_variant_calling.log'
    shell:
        r"""
        set -euo pipefail

        tmpvcf=$(mktemp {output.vcf}.XXXXXX.vcf)

        lofreq call-parallel \
          --pp-threads {threads} \
          -f {input.ref} \
          --call-indels \
          -m {params.min_qual} \
          -q {params.min_baseq} \
          -Q {params.min_mapq} \
          -C {params.min_cov} \
          -o "${tmpvcf}" \
          {input.bam} 2> {log}

        # compress + index
        bgzip -f -c "${tmpvcf}" > {output.vcf}
        tabix -f -p vcf {output.vcf} 2>> {log}
        """