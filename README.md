# Accelerate Database Queries Using GPU

A project to accelerate database query performance using GPU capabilities, featuring TPC-DS benchmark dataset support.

## Description

This repository contains tools and methods to optimize database queries by leveraging GPU processing power. It includes support for the TPC-DS benchmark dataset, which is widely used for testing and benchmarking database performance.

## Prerequisites

- **uv** (Python package manager)
  - Windows: `winget install --id=astral-sh.uv -e`
  - Ubuntu: `curl -LsSf https://astral.sh/uv/install.sh | sh`
- **Taskfile** (Task runner)
  - Windows: `winget install Task.Task`
  - Ubuntu: `sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/.local/bin`
- **Python 3.12.7**

```sh
uv python install 3.12.7
uv python pin 3.12.7
```

- HeavyDB
- DuckDB

## Installation

1. Install dependencies:

```sh
task i
```

## HeavyDB

### Setup

For Ubuntu:

```sh
# Install required packages
sudo apt install gcc make gcc-9 yacc bison flex

# Build tools
cd src/tpcds/tools
make CC=gcc-9
```

For Mac OS:

```sh
xcode-select --install # Install Xcode Command Line Tools

cd src/tpcds/tools
make OS=MACOS # Build tools
```

### Configuration

Add the `allowed-import-paths = ["/"]` line to `/var/lib/heavyai/heavy.conf` and then reload the service:

```sh
vi /var/lib/heavyai/heavy.conf
sudo systemctl restart heavydb
```

### Generate benchmarking data

```sh
cd src/tpcds
sudo chmod +x gen_data.sh gen_schema.sh gen_queries.sh

# Generate TPC-DS data
# Examples: ./gen_data.sh 1
./gen_data.sh <GB>

./gen_queries.sh # Generate benchmarking queries

python ./gen_schema.py # Generate database schemas
```

The generated data will be stored in `/tmp/heavy_data`

## HeavyDB

### Setup

Add HeavyDB to executable path:

```sh
sudo ln -s $HEAVYAI_PATH/bin/heavysql /usr/local/bin/heavysql
```

### Import TPC-DS Data

1. Access to HeavyDB (username: `admin`, password: `HyperInteractive`):

```sh
heavysql -u admin -p HyperInteractive heavyai
```

2. Create schema in HeavyDB from the generated SQL file:

```sh
heavysql -u admin -p HyperInteractive heavyai < /tmp/heavy_data/tpcds.sql
```

3. Use the following SQL commands to import generated test data of TPC-DS:

```sql
COPY call_center FROM '/tmp/heavy_data/data/call_center.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_page FROM '/tmp/heavy_data/data/catalog_page.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_returns FROM '/tmp/heavy_data/data/catalog_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_sales FROM '/tmp/heavy_data/data/catalog_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer_address FROM '/tmp/heavy_data/data/customer_address.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer FROM '/tmp/heavy_data/data/customer.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer_demographics FROM '/tmp/heavy_data/data/customer_demographics.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY date_dim FROM '/tmp/heavy_data/data/date_dim.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY dbgen_version FROM '/tmp/heavy_data/data/dbgen_version.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY household_demographics FROM '/tmp/heavy_data/data/household_demographics.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY income_band FROM '/tmp/heavy_data/data/income_band.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY inventory FROM '/tmp/heavy_data/data/inventory.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY item FROM '/tmp/heavy_data/data/item.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY promotion FROM '/tmp/heavy_data/data/promotion.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY reason FROM '/tmp/heavy_data/data/reason.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY ship_mode FROM '/tmp/heavy_data/data/ship_mode.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store FROM '/tmp/heavy_data/data/store.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store_returns FROM '/tmp/heavy_data/data/store_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store_sales FROM '/tmp/heavy_data/data/store_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY time_dim FROM '/tmp/heavy_data/data/time_dim.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY warehouse FROM '/tmp/heavy_data/data/warehouse.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_page FROM '/tmp/heavy_data/data/web_page.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_returns FROM '/tmp/heavy_data/data/web_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_sales FROM '/tmp/heavy_data/data/web_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_site FROM '/tmp/heavy_data/data/web_site.dat' WITH (delimiter = '|', line_delimiter = '\n');
```
