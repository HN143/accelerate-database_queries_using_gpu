#!/bin/bash
set -eu

SCALE="1"
TEMPLATE_DIR="query_templates"
OUTPUT_DIR="results/test_queries"
QUERY_ID=""

function generate_query()
{
    ./dsqgen \
    -DIRECTORY "../$TEMPLATE_DIR" \
    -INPUT "../$TEMPLATE_DIR/templates.lst" \
    -SCALE $SCALE \
    -OUTPUT_DIR ../$OUTPUT_DIR \
    -DIALECT netezza \
    -TEMPLATE "query$QUERY_ID.tpl"
    mv "../$OUTPUT_DIR/query_0.sql" "../$OUTPUT_DIR/query_$QUERY_ID.sql"
}

cd tools
for i in {1..99}; do
    QUERY_ID="$i"
    generate_query
done
cd -