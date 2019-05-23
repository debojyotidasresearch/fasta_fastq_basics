import sys
import gzip
import time

# Usage: python3 readgzipfastq.py <fastq_file>

start = time.time()

print("Running this code",sys.argv[0])

file_in = sys.argv[1]
file_parts = file_in.split("/")
file_out = "out_" + str(file_parts[len(file_parts) - 1])
print(file_out)

print(file_in," is being read!")

if (file_in.count(".gz") != 0):
    f1 = gzip.open(file_in, "rt")
    f2 = gzip.open(file_out,"wt")
else :
    f1 = open(file_in, "rt")
    f2 = open(file_out, "wt")

baseCount = 0
nCount = 0
readCount = 0
lineCount = 0

for line in f1:
    lineCount = lineCount + 1
    f2.write(line)
    if (lineCount % 4 == 2):
        readCount = readCount + 1
        baseCount = baseCount + (len(line) - 1)
        nCount = nCount + (line.upper()).count("N")

print("Number of reads     = ", readCount)
print("Number of bases     = ", baseCount)
print("Number of N's       = ", nCount)

print("Processing ", str(file_parts[len(file_parts) - 1]), " complete!")
end = time.time()
print("Execution time ",str(end - start))
