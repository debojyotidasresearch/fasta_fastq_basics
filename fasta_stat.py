import sys

file_in = sys.argv[1]
file_parts = file_in.split("/")
file_out = "out_" + str(file_parts[len(file_parts) - 1])

f_in = open(file_in,"rt")
f_out = open(file_out,"wt")

lineCount = 0
seqCount = 0
baseCount = 0
nCount = 0

for line in f_in:
    lineCount = lineCount + 1
    if (line.count(">") != 0):
        seqCount = seqCount + 1
        if (lineCount == 1):
#            print(line[:len(line) - 1])
            f_out.write(line[:len(line) - 1] + "\n")
        else:
#            print("\n",line, end = '')
            f_out.write("\n" + line)
    else :
        baseCount = baseCount + (len(line) - 1)
        nCount = nCount + (line.upper()).count("N")
#        print(line[:len(line) - 1], end = '')
        f_out.write(line[:len(line) - 1])

#print("\n", end = '')
f_out.write("\n")

print("Number of sequences = ", seqCount)
print("Number of bases     = ", baseCount)
print("Number of N's       = ", nCount)
print("Percentage N        = ", str(100 * (nCount/baseCount)))

#print("Finished writing to screen!")
f_in.close()
f_out.close()
