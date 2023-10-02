#!/bin/bash

# Check the input
if test $# -lt 1 ; then
  echo "USAGE: `basename $0` USE_VALGRIND" ;
  exit 1 ;
fi
useValgrind=$1 ;
if ! test -e optimization.txt ; then
  echo "CAT: The file \"optimization.txt\" doesn't exist in `pwd`" ;
  exit 1;
fi
maxTotalOpt="-1" ;
if test -e optimization.txt ; then
  maxTotalOpt=`cat optimization.txt`;
fi

let successes=0 ;
let tests=0 ;
totalOpt="0" ;
testFailed="";
for i in `ls | grep test` ; do

  # Go to the next test to check
  if ! test -d $i ; then
    continue ;
  fi
  let tests=$tests+1 ;
  pushd ./ &> /dev/null ;
  cd $i ;
  make clean &> /dev/null ;
  make USE_VALGRIND=$useValgrind  check &> tmpOut ;
  if test -e optimization.txt ; then
    currentOpt=`cat optimization.txt` ;
    totalOpt=`echo "$currentOpt + $totalOpt" | bc` ;
  fi
  testSucceeded=`grep "Test passed!" tmpOut` ;
  if test "$testSucceeded" != ""; then
    let successes=$successes+1 ;
  else
    testFailed="  $i\n$testFailed" ;
    echo "CAT: The test $i failed" ;
    exit 1 ;
  fi
  rm tmpOut ;
  popd &> /dev/null ;
done

# Print the summary
echo "CAT:    SUMMARY: $successes tests passed out of $tests" ;

# Check if all tests passed
if test "$testFailed" != "" ; then
  echo "CAT:    Failed tests:" ;
  echo -e "$testFailed" ;
  exit 1;
fi

# All tests passed

# Check the optimization
if test "$maxTotalOpt" != "-1" ; then
  echo "CAT:    SUMMARY: Total execution cost = $totalOpt" ;
  enoughOpt=`echo "$totalOpt <= $maxTotalOpt" | bc` ; 
  if test "$enoughOpt" == "0" ; then
    echo "CAT:      Your solution doesn't optimize the original code enough" ;
    echo "CAT:      The maximum cost that accumulate between tests is $maxTotalOpt" ;
    exit 1;
  fi
fi
echo "CAT:    Your homework both passed all tests and it optimized the code enough, congratulations!"
