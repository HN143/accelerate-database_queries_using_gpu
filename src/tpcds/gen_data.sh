#!/bin/bash

rm -rf "$HOME/heavyai/tpcds/data"
mkdir -p "$HOME/heavyai/tpcds/data"

cd tools && ./dsdgen -sc $1 -dir "$HOME/heavyai/tpcds/data" -TERMINATE N && cd ..

cp ./load_data.sql "$HOME/heavyai/tpcds/load_data.sql"
