rsync -avzP rsync://hgdownload.soe.ucsc.edu/goldenPath/hg38/database/gap.txt.gz .

zcat gap.txt.gz | cut -f2-4 | bgzip > gap.bed.gz
