# Accelerate Database Queries Using GPU

A project to accelerate database query performance using GPU capabilities, featuring TPC-DS benchmark dataset support.

## Description

This repository contains tools and methods to optimize database queries by leveraging GPU processing power. It includes support for the TPC-DS benchmark dataset, which is widely used for testing and benchmarking database performance.

## Prerequisites

- **uv** (Python package manager)
  - Windows: `winget install --id=astral-sh.uv -e`
- **Taskfile** (Task runner)
  - Windows: `winget install Task.Task`
- **Python 3.12.7**

```sh
uv python install 3.12.7
uv python pin 3.12.7
```

- **OS Requirements**
  - Ubuntu / Mac OS (for TPC-DS dataset generation)
  - For Ubuntu: gcc, make, gcc-9, yacc, bison, flex
  - For Mac OS: Xcode Command Line Tools

## Installation

1. Install dependencies:

```sh
task i
```

2. Set up TPC-DS dataset:

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
# Install Xcode Command Line Tools
xcode-select --install

# Build tools
cd src/tpcds/tools
make OS=MACOS
```

# Using

```sh
cd src/tpcds
mkdir -p results

# Generate TPC-DS data
rm -rf results/data
mkdir -p results/data
cd tools && ./dsdgen -sc 1 -dir ../results/data -TERMINATE N && cd ..
# sudo chmod +x reformat_data.sh
# ./reformat_data.sh

# Set up database schemas
cp tools/tpcds.sql results/tpcds.sql
sudo chmod +x remove_primary_keys.sh
./remove_primary_keys.sh # Remove primary key definition lines after copying

# Generate benchmarking queries
mkdir -p results/test_queries
sudo chmod +x convert_to_lf.sh generate_queries.sh
./generate_queries.sh
```

## Usage

The generated data and schemas can be found in the `./results` folder. Use these files to benchmark and optimize your database queries using GPU acceleration.

_More detailed usage instructions coming soon_
