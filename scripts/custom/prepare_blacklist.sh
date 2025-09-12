zcat dups.bed.gz gap.bed.gz ENCFF356LFX.bed.gz \
  | sort -k1,1 -k2,2n \
  | bedtools merge -i - > blacklist_raw.bed

bedtools subtract -a blacklist_raw.bed -b whitelist.bed \
  | bgzip > blacklist_final.bed.gz

tabix -p bed blacklist_final.bed.gz