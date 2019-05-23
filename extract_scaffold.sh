#!/bin/bash

# Author: Debojyoti Das
# Date: 21st May, 2019

if [ $# != 2 ]; then
     echo -e "Usage: "$0" <fasta_file> <search_term>";
   else
     IFS=$'\n';
     search_term=$2;

awk -v seq="${search_term}"'$' \
'{
  if(match($0,seq)) {
    switch_value=1;
    sequenceID=$0;
  } else {
    if(/>/) {
      switch_value=0;
    } else {
      if(switch_value == 1) {
        sequence=sequence$0;
      }
    }
  }
}END{
  print sequenceID;
  for(i=1; i<length(sequence); i=i+60) {
  print substr(sequence,i,60);}
}' $1;
unset IFS;
fi;
