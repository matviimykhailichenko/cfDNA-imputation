wget https://hgdownload.soe.ucsc.edu/goldenPath/hg38/database/genomicSuperDups.txt.gz

zcat genomicSuperDups.txt.gz | cut -f2-4 | bgzip > dups.bed.gz
