sudo rm -rf /opt/heavyai/data/test_queries
sudo mkdir -p /opt/heavyai/data/test_queries

set -eu

SCALE="1"
TEMPLATE_DIR="query_templates"
OUTPUT_DIR="/opt/heavyai/data/test_queries"
QUERY_ID=""

function generate_query()
{
    ./dsqgen \
    -DIRECTORY "../$TEMPLATE_DIR" \
    -INPUT "../$TEMPLATE_DIR/templates.lst" \
    -SCALE $SCALE \
    -OUTPUT_DIR $OUTPUT_DIR \
    -DIALECT netezza \
    -TEMPLATE "query$QUERY_ID.tpl"
    mv "$OUTPUT_DIR/query_0.sql" "$OUTPUT_DIR/query_$QUERY_ID.sql"
}

cd tools
for i in {1..99}; do
    if [ "$i" -ne 47 ] && [ "$i" -ne 57 ]; then
        QUERY_ID="$i"
        generate_query
    fi
done
cd -