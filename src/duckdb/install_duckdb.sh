set -e  # Stop script if any command fails

echo "Updating the system..."
sudo apt update -y

# Install DuckDB
echo "### Installing DuckDB..."
sudo apt install -y curl
curl https://install.duckdb.org | sh
chmod +x $HOME/.duckdb/cli/latest/duckdb
sudo ln -sf $HOME/.duckdb/cli/latest/duckdb /usr/local/bin/duckdb


echo "DuckDB has completed execution. Data exported to: $TARGET_DIR"

