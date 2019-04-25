#!/bin/bash

#download dsk
apt-get update
apt-get install cmake
git clone --recursive https://github.com/GATB/dsk.git
cd dsk
sh INSTALL

cd ..
mkdir humanGeno
mv SplitFasta.py Distance.py Compare_get_onlyY.py ./humanGeno
cd humanGeno
wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/001/405/GCF_000001405.38_GRCh38.p12/GCF_000001405.38_GRCh38.p12_genomic.fna.gz
gunzip *.gz
python SplitFasta.py

#dsk process
cd ./../dsk/build/bin
./dsk -file ../../../humanGeno/NC_000001.11\ Homo\ sapiens\ chromosome\ 1.fa,../../../humanGeno/NC_000002.12\ Homo\ sapiens\ chromosome\ 2.fa,../../../humanGeno/NC_000003.12\ Homo\ sapiens\ chromosome\ 3.fa,../../../humanGeno/NC_000004.12\ Homo\ sapiens\ chromosome\ 4.fa,../../../humanGeno/NC_000005.10\ Homo\ sapiens\ chromosome\ 5.fa,../../../humanGeno/NC_000006.12\ Homo\ sapiens\ chromosome\ 6.fa,../../../humanGeno/NC_000007.14\ Homo\ sapiens\ chromosome\ 7.fa,../../../humanGeno/NC_000008.11\ Homo\ sapiens\ chromosome\ 8.fa,../../../humanGeno/NC_000009.12\ Homo\ sapiens\ chromosome\ 9.fa,../../../humanGeno/NC_000010.11\ Homo\ sapiens\ chromosome\ 10.fa,../../../humanGeno/NC_000011.10\ Homo\ sapiens\ chromosome\ 11.fa,../../../humanGeno/NC_000012.12\ Homo\ sapiens\ chromosome\ 12.fa,../../../humanGeno/NC_000013.11\ Homo\ sapiens\ chromosome\ 13.fa,../../../humanGeno/NC_000014.9\ Homo\ sapiens\ chromosome\ 14.fa,../../../humanGeno/NC_000015.10\ Homo\ sapiens\ chromosome\ 15.fa,../../../humanGeno/NC_000016.10\ Homo\ sapiens\ chromosome\ 16.fa,../../../humanGeno/NC_000017.11\ Homo\ sapiens\ chromosome\ 17.fa,../../../humanGeno/NC_000018.10\ Homo\ sapiens\ chromosome\ 18.fa,../../../humanGeno/NC_000019.10\ Homo\ sapiens\ chromosome\ 19.fa,../../../humanGeno/NC_000020.11\ Homo\ sapiens\ chromosome\ 20.fa,../../../humanGeno/NC_000021.9\ Homo\ sapiens\ chromosome\ 21.fa,../../../humanGeno/NC_000022.11\ Homo\ sapiens\ chromosome\ 22.fa,../../../humanGeno/NC_000023.11\ Homo\ sapiens\ chromosome\ X.fa -kmer-size 25 -abundance-min 1
./dsk2ascii -file *.h5 -out ../../../humanGeno/otherChroKmers_withValue.txt
rm *.h5

./dsk -file ../../../humanGeno/NC_000024.10\ Homo\ sapiens\ chromosome\ Y.fa -kmer-size 25 -abundance-min 1
./dsk2ascii -file *.h5 -out ../../../humanGeno/YChroKmers_withValue.txt
rm *.h5

cd ../../../humanGeno
rm *.fa
rm *.fna

#remove the numbers of kmers
cut -f1 -d  ' ' otherChroKmers_withValue.txt > otherChroKmers.txt
cut -f1 -d  ' ' YChroKmers_withValue.txt > YChroKmers.txt
rm *_withValue.txt

#sorting
split -l 200000000 otherChroKmers.txt chunk-
for x in chunk-*; do sort $x > sorted_$x; done
rm chunk-*
sort -m sorted_chunk-* > otherChroKmers_sorted.txt
rm sorted_chunk-*
rm otherChroKmers.txt

sort YChroKmers.txt > YChroKmers_sorted.txt
rm YChroKmers.txt

#distance=1
python Distance.py
rm YChroKmers_marked.txt

#sorting kmers on chrom Y (distance=1)
split -l 200000000 YChroKmers_distance_1.txt chunk-
for x in chunk-*; do sort $x > sorted_$x; done
rm chunk-*
sort -m sorted_chunk-* > YChroKmers_distance_1_sorted.txt
rm sorted_chunk-*
rm YChroKmers_distance_1.txt

#get kmers only in chrom Y with distance of 1
python Compare_get_onlyY.py

#remove empty lines
sed '/^[[:space:]]*$/d' onlyY_with_empty.txt > onlyY.txt
rm YChroKmers_sorted.txt onlyY_with_empty.txt YChroKmers_distance_1_sorted.txt otherChroKmers_sorted.txt
