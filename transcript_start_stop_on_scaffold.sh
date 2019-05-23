#!/bin/bash

# Author: Debojyoti Das
# Date: 21st May, 2019
# Usage:
if [ $# != 1 ]; then
     echo -e "Usage: "$0" <blastn_output_file>";
   else
     IFS=$'\n';
     for gene in `awk '{print $1}' $1 | sort | uniq`;
     do
       grep "$gene" $1 | \
      awk -v g="$gene" \
      'BEGIN{
        min_start=2500000000;
        max_stop=0;
      }
      {
        if(min_start >= $7) {
          min_start=$7;
          min_start_scaffold=$2;
          a=$9;
          min_sstrand=$NF;
        }
        if(max_stop <= $8){
          max_stop=$8;
          max_stop_scaffold=$2;
          b=$10;
          max_sstrand=$NF;
        }
      }
      END{
        if(max_stop_scaffold == min_start_scaffold){
          scaffold=max_stop_scaffold;
          sstrand=max_sstrand;
          print g"\t"scaffold"\t"sstrand"\t"a"\t"b;
        } else {
          scaffold=min_start_scaffold;
          sstrand=min_sstrand;
          print g"\t"scaffold"\t"sstrand"\t"a"\t";
        }
      }';
    done;
    unset IFS;
  fi;
