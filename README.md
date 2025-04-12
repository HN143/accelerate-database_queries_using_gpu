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

1. Install the necessary dependencies:

```sh
task i
```

2. Install platform-specific dependencies:

```sh
task i-ubuntu
```

```sh
task i-macos
```

## TPC-DS

### Build TPC-DS by platform

```sh
task build-tpcds-ubuntu
```

```sh
task build-tpcds-macos
```

### Generate benchmarking data

Generate schema

```sh
task gen-tpcds-schema
```

Generate queries

```sh
task gen-tpcds-queries
```

Generate data

```sh
task gen-tpcds-data -- <GB>
```

Example: `task gen-tpcds-data -- 1`

The generated data will be stored in `~/heavyai/tpcds`

## HeavyDB

### Setup

Add HeavyDB to executable path:

```sh
echo "alias heavysql='heavysql -u admin -p HyperInteractive heavyai --allowed-import-paths [\"/\"]'" >> ~/.bashrc
source ~/.bashrc
```

### Import TPC-DS Data

1. Create schema in HeavyDB from the generated SQL file:

```sh
heavysql < ~/heavyai/tpcds/tpcds.sql
```

2. Use the following SQL commands to import generated test data of TPC-DS:

```sh
heavysql < ~/heavyai/tpcds/load_data.sql
```
