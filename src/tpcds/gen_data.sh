#!/bin/bash

TPCDS_DATA_DIR="$HOME/heavyai/tpcds/data"

rm -rf "$TPCDS_DATA_DIR"
mkdir -p "$TPCDS_DATA_DIR"

cd tools && ./dsdgen -sc $1 -dir "$TPCDS_DATA_DIR" -TERMINATE N && cd ..

cp ./load_data.sql "$HOME/heavyai/tpcds/load_data.sql"
