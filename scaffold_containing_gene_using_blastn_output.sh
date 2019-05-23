#!/bin/bash

# Author: Debojyoti Das
# Date: 21st May, 2019
# Usage:

start_time=$(date +%s)

if [ $# != 3 ]; then
     echo -e "Usage: "$0" <scaffold_fasta_file> <processed_blastn_output_file> <extracted_scaffold_output_fasta_file>";
   else

IFS=$'\n';

for info in `cat $2`;
# processed BLASTn tabular output format 6
# Column headers:
# gene_name scaffold/contig sstrand_info start_position stop_position
    do
        gene=$(echo $info | awk '{print $1}');
        scaffold=$(echo $info | awk '{print $2}');
        sstrand_info=$(echo $info | awk '{print $3}');
        scaffold_start=$(echo $info | awk '{print $4}');
        scaffold_stop=$(echo $info | awk '{print $5}');
        start_position=$((scaffold_start - 10000));

        if [ $sstrand_info == "plus" ]; then
          stop_position=$((scaffold_stop + 10000));
        else
          start_position=1;
          stop_position=$((scaffold_start + 10000));
        fi;

        awk -v g="${gene}" -v seq="${scaffold}"'$' -v a=$start_position   \
        -v b=$stop_position                                            \
        '{if(match($0,seq))
             {switch_value=1; sequenceID=$0;
         } else {
               if(/>/) {
                   switch_value=0;
                 } else {
                       if(switch_value == 1) sequence=sequence$0;
                     }
                   }
                 }
        END{
          print sequenceID"\t"g;
          if(a<0){
            a=1;
          }
          if(b>length(sequence)){
            b=length(sequence);
          }
          seq_of_interest=substr(sequence,a,b);
          for(i=1; i<length(seq_of_interest); i=i+60) {
            print substr(seq_of_interest,i,60);
          }
        }' $1 >> $3;  \
    done;
unset IFS;

stop_time=$(date +%s)
echo -e "execution time\t" $((stop_time - start_time))

fi;
