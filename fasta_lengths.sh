#!/bin/bash

# Author: Debojyoti Das
# Date: 21st May, 2019

IFS=$'\n';

awk '{
if(NR==1){
    printf $0"\t\t";
  } else {
        if(/>/) {
            printf sum"\n"$0"\t\t";
            sum=0;
        } else {
             sum=sum+length($0);
        }
    }
  }
  END{print sum}' $1;
unset IFS;
