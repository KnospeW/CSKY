import sys
input = open("GCF_000001405.38_GRCh38.p12_genomic.fna")
outputFiles = []

for line in input:
    if line.startswith(">"):
        if (outputFiles != []): outputFiles.close()
        genename = line.strip().split(',')[0].split('>')[1]
        filename = genename + ".fa"
        outputFiles = open(filename, 'w')
        outputFiles.write(line)
    else:
        outputFiles.write(line)
outputFiles.close()
