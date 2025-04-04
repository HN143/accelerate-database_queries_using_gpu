set -e  # Stop script if any command fails

echo "Updating the system..."
sudo apt update -y

# Install DuckDB
echo "### Installing DuckDB..."
sudo apt install -y curl
curl https://install.duckdb.org | sh
chmod +x $HOME/.duckdb/cli/latest/duckdb
sudo ln -sf $HOME/.duckdb/cli/latest/duckdb /usr/local/bin/duckdb

# Sinh dữ liệu cho các bảng để truy vấn
#!/bin/bash

DUCKDB_BIN="nckh.duckdb"  
TARGET_DIR="exported_data"  # Thư mục lưu dữ liệu xuất ra

# Tạo thư mục lưu trữ nếu chưa có
mkdir -p "$TARGET_DIR"

# Chạy DuckDB và thực thi các lệnh SQL
duckdb "$DUCKDB_BIN"<<EOF
INSTALL tpch;
LOAD tpch;
SELECT * FROM dbgen(sf=1);
EXPORT DATABASE '$TARGET_DIR' (FORMAT CSV, DELIMITER '|');
EOF

echo "DuckDB has completed execution. Data exported to: $TARGET_DIR"

