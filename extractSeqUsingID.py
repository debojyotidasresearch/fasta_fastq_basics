#!/Library/Frameworks/Python.framework/Versions/3.6/bin/python3

import sys
import Bio
import time
from Bio import SeqIO

# Usage: python3 extractSeqUsingID.py <fastq_file> <id_file>

start = time.time()


fasta_file = str(sys.argv[1])
id_file = str(sys.argv[2])

#seq_file = open(fasta_file, 'rt')
seq_id_file = open(id_file, 'rt')

seq_file = fasta_file

file_parts = fasta_file.split("/")
file_out = "extracted_subset_" + str(file_parts[len(file_parts) - 1])
f_out = open(file_out, 'wt')

list = seq_id_file.read().splitlines()

for l in list:
    for s in SeqIO.parse(seq_file, "fasta"):
        if ( str(l) == str(s.id) ):
            print(">" + s.id, file = f_out)
            print(s.seq, file = f_out)


end = time.time()
print("Execution time ",str(end - start))
