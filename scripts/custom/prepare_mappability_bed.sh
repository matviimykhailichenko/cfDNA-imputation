conda activate bigtobed && bigBedToBed k50.Unique.Mappability.bb mappability.bed && conda deactivate
conda activate htstools && bgzip mappability.bed && conda deactivate