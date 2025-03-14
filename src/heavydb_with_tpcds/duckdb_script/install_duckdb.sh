#!/bin/bash

# Định nghĩa phiên bản mới nhất của DuckDB
DUCKDB_URL="https://github.com/duckdb/duckdb/releases/download/v1.2.1/duckdb_cli-linux-amd64.zip"
INSTALL_DIR="$(pwd)"  # Cài đặt vào thư mục hiện tại
DUCKDB_ZIP="duckdb.zip"
DUCKDB_BIN="duckdb"

# Tải DuckDB
echo "Downloading DuckDB..."
curl -L "$DUCKDB_URL" -o "$DUCKDB_ZIP"

# Giải nén DuckDB
echo "Extracting DuckDB..."
unzip -o "$DUCKDB_ZIP" -d "$INSTALL_DIR"

# Cấp quyền thực thi cho DuckDB
chmod +x "$INSTALL_DIR/$DUCKDB_BIN"

# Xóa file zip sau khi giải nén
rm "$DUCKDB_ZIP"

# Hiển thị thông báo thành công
echo "DuckDB has been installed successfully in $INSTALL_DIR."
echo "To run DuckDB, use: ./$DUCKDB_BIN"

