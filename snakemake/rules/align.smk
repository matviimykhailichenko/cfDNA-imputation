rule align:
    input:
        # TODO change data folder to construction from manifest
        reads = '../data/{sample}.fastq.gz',
        ref = config["reference"]
    output:
        # TODO where is graph 38 genome?
        bam = '../tmp/{sample}.bam'
    threads: 20
    log:
        '../logs/{sample}.align.log'
    shell:
        '''
        bwa-mem2 mem -t {threads} {input.ref} {input.reads} \
        | samtools view -bS - \
        | samtools sort -@ {threads} -o {output.bam}
        samtools index {output.bam}
        '''