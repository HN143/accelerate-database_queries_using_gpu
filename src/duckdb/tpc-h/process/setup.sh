#!/bin/bash

set -e  # Stop script if any command fails

# Check if scale factor argument is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <scale_factor>"
    echo "Allowed scale factors: 1, 10, 50, 100"
    exit 1
fi

SCALE_FACTOR=$1

# Validate scale factor
if [[ ! "$SCALE_FACTOR" =~ ^(1|10|50|100)$ ]]; then
    echo "Error: Scale factor must be 1, 10, 50, or 100"
    echo "Usage: $0 <scale_factor>"
    exit 1
fi

# Sinh dữ liệu cho các bảng để truy vấn
DUCKDB_DB="../tpc-h_nckh.duckdb"

# Kiểm tra nếu tệp cơ sở dữ liệu tồn tại, thì xóa nó
if [ -f "$DUCKDB_DB" ]; then
    echo "Database file '$DUCKDB_DB' exists. Removing it..."
    rm "$DUCKDB_DB"
fi

echo "Generating TPC-H data with scale factor $SCALE_FACTOR..."

# Chạy DuckDB và thực thi các lệnh SQL
duckdb "$DUCKDB_DB" <<EOF
INSTALL tpch;
LOAD tpch;
SELECT * FROM dbgen(sf=$SCALE_FACTOR);
EOF

echo "Running DuckDB with database '$DUCKDB_DB'..."
echo "Process completed successfully."