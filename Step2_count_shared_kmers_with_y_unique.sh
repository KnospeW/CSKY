#!/bin/bash

#install seqtk
git clone https://github.com/lh3/seqtk.git
cd seqtk
make
cd ..

mkdir genoRead
mv downloadlist.txt Compare.py ./genoRead
cd genoRead

while read line; do
	echo $line
	fastqname=$(echo $line | cut -d/ -f9 | cut -d. -f1)
	echo $fastqname
	filename=$(echo "${fastqname}.fastq")
	echo $filename
	gzname=$(echo "${filename}.gz")
	echo $gzname
	wget $line

	#randomly sample reads with % coverage of human genome
	#reads_1coverage=$(echo "${fastqname}_1.0coverage.fq")
	reads_1di10coverage=$(echo "${fastqname}_0.1coverage.fq")
	reads_1di100coverage=$(echo "${fastqname}_0.01coverage.fq")
	reads_1di1000coverage=$(echo "${fastqname}_0.001coverage.fq")
	reads_1di10000coverage=$(echo "${fastqname}_0.0001coverage.fq")
	reads_1di100000coverage=$(echo "${fastqname}_0.00001coverage.fq")
	#./../seqtk/seqtk sample -s10 $gzname 39500000 > $reads_1coverage
	./../seqtk/seqtk sample -s10 $gzname 3950000 > $reads_1di10coverage
	./../seqtk/seqtk sample -s10 $gzname 395000 > $reads_1di100coverage
	./../seqtk/seqtk sample -s10 $gzname 39500 > $reads_1di1000coverage
	./../seqtk/seqtk sample -s10 $gzname 3950 > $reads_1di10000coverage
	./../seqtk/seqtk sample -s10 $gzname 395 > $reads_1di100000coverage
	rm $gzname
	echo "sampling process done"
	#dsk process
	for x in *coverage.fq; do ./../dsk/build/bin/dsk -file $x -kmer-size 25 -abundance-min 1; done
	rm *.fq
	echo "dsk step 1 done"
	for y in *.h5; do ./../dsk/build/bin/dsk2ascii -file $y -out $(echo $y | cut -d. -f1-2)_withValue.txt; done
	rm *.h5
	for z in *_withValue.txt; do cut -f1 -d ' ' $z > $(echo $z | cut -d_ -f1-3).txt; done
	rm *_withValue.txt
	for a in *0.*coverage.txt; do sort $a > sorted_$(echo $a | cut -d. -f1-2).txt; done
	#for b in *1.0coverage.txt
	#do
	#	split -l 200000000 $b chunk-
	#	for x in chunk-*; do sort $x > sorted_$x; done
	#	rm chunk-*
	#	sort -m sorted_chunk-* > sorted_$(echo $b | cut -d. -f1-2).txt
	#	rm sorted_chunk-*
	#done
	rm ERR*

	#compare
	python Compare.py
        rm sorted*
done < downloadlist.txt
