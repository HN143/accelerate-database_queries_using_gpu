#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <log_directory>"
  exit 1
fi

LOG_DIR=$1
BASE_PATH="$HOME/accelerate-database_queries_using_gpu/src/benchmark_result/${LOG_DIR}/heavydb/tpc-h"

for size in 1 5 10 20 50; do
  ./main.sh $size $size "${BASE_PATH}/${size}gb"
done
