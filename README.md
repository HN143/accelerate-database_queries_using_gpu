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
sudo chmod +x gen_data.sh gen_queries.sh

# Generate TPC-DS data
# Examples: ./gen_data.sh 1
./gen_data.sh <GB>

./gen_queries.sh # Generate benchmarking queries

python3 ./gen_schema.py # Generate database schemas
```

The generated data will be stored in `/tmp/heavy_data`

## HeavyDB

### Setup

Add HeavyDB to executable path:

```sh
sudo ln -s $HEAVYAI_PATH/bin/heavysql /usr/local/bin/heavysql
```

### Import TPC-DS Data

1. Create schema in HeavyDB from the generated SQL file:

```sh
heavysql -u admin -p HyperInteractive heavyai < /tmp/heavy_data/tpcds.sql
```

2. Access to HeavyDB (username: `admin`, password: `HyperInteractive`):

```sh
heavysql -u admin -p HyperInteractive heavyai
```

3. Use the following SQL commands to import generated test data of TPC-DS:

```sh
heavysql -u admin -p HyperInteractive heavyai < src/tpcds/load_data.sql
```
