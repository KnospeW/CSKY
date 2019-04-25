# About CSKY
CSKY is a tool to count shared kmers with Y-unique kmers to detect the absence or presence of human Y chromosome, with the help of DSK (https://github.com/GATB/dsk) and Seqtk (https://github.com/lh3/seqtk).

# Requirements
CMake 3.1+ and C++/11 capable compiler for DSK use

# Instructions
run Step1_get_y_unique_kmers.sh to get unique human kmers that only exists in Chromosome Y from a human reference genome ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.38_GRCh38.p12/GCF_000001405.38_GRCh38.p12_genomic.fna.gz.
```
nohup ./Step1_get_y_unique_kmers.sh &
```
run Step2_count_shared_kmers_with_y_unique.sh to get the number of shared kmers with Y-unique kmers with 5 levels of percenatge (10%, 1%, 0.1%, 0.01%, 0.001%) of a human genome. The genome reads dataset is from European Nucleotide Archive (ENA).
```
nohup ./Step2_count_shared_kmers_with_y_unique.sh &
```


