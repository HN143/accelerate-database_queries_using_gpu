# TPC-DS dataset

## Prerequisites

- OS: Ubuntu / Mac OS

## Setup

- Ubuntu:

```sh
# Install packages
sudo apt install gcc make gcc-9 yacc bison flex

# Build tools
cd tools
make CC=gcc-9
```

- Mac OS:

```sh
# Install packages
xcode-select --install

# Build tools
cd tools
make OS=MACOS
```

## Generate data

```sh
cd tools
./dsdgen -sc 1 -dir ../results/data -TERMINATE N
cd ..
sudo chmod +x reformat_data.sh
./reformat_data.sh
```

## Copy schemas

```sh
cp ./tools/tpcds.sql ./results/tpcds.sql
```

Note: Remove primary key definition lines after copying

## Generate benchmarking queries

```sh
# Generate test queries (if you want to test with the new test queries)
./convert_to_lf.sh query_templates
./convert_to_lf.sh query_variants
./generate_queries.sh
```

Use the generated data in the `./results` folder.
