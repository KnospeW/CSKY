# CSKY
CSKY is a tool to identify genetic sex (presence of the Y chromosome sequences) in high-throughput sequencing data. It does so by counting k-mers (25mers) in sequence files (fastq, fasta) that overlap with unique k-mers that are specific to the human Y-chromosome.

[DSK](https://github.com/GATB/dsk) is first used for identifying all unique k-mers for autosomes, chrX and chrY. A set of chrY specific k-mers are then identified by subtraction of k-mers shared with autosomes or chrX.

# Requirements
* CMake 3.1+ and C++/11 capable compiler for DSK use
* [Seqtk](https://github.com/lh3/seqtk)

# Methods

1. [Step1_get_y_unique_kmers.sh](https://github.com/KnospeW/CSKY/blob/master/Step1_get_y_unique_kmers.sh):  Get unique human kmers that exists only in the chrY from [human reference genome](ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.38_GRCh38.p12/GCF_000001405.38_GRCh38.p12_genomic.fna.gz) (currently GRCh38.p12 version of the assembly)

```
nohup ./Step1_get_y_unique_kmers.sh &
```

2. [Step2_count_shared_kmers_with_y_unique.sh](https://github.com/KnospeW/CSKY/blob/master/Step2_count_shared_kmers_with_y_unique.sh): Get the number of kmers in sequence data that overlap with a set of chrY unique k-mers at 10%, 1%, 0.1%, 0.01%, 0.001% depth of coverage for a human genome. The genome reads dataset is from European Nucleotide Archive (ENA).
```
nohup ./Step2_count_shared_kmers_with_y_unique.sh &
```


