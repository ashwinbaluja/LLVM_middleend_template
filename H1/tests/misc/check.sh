#!/bin/bash

if ! test -f compiler_output ; then
  echo "Test failed" ; 
  echo "File \"compiler_output\" is missing" ;
  exit 1;
fi
if ! test -f output/oracle_output.txt ; then
  echo "Test failed" ; 
  echo "File \"output/oracle_output.txt\" is missing" ;
  exit 1;
fi

outputs=`ls output`;
for i in $outputs ; do
  sed 's/[ ]*//g' compiler_output | sed 's/*//g' | sed '/^$/d' | sort &> compiler_output_sorted ;
  sed 's/[ ]*//g' output/$i | sed 's/*//g' | sed '/^$/d' | sort &> oracle_sorted ;
  diffOut=`diff compiler_output_sorted oracle_sorted` ;
  if test "$diffOut" == "" ; then 
    echo "Test passed!" ; 
    exit 0;
  fi
  mkdir -p diff ;
  echo "$diffOut" > diff/${i}_diff_output ;
done

echo "Test failed" ; 
echo "Output differences can be found in \"diff\"" ;
