# TPC-DS dataset

## Prerequisites

- OS: Ubuntu

## Generate data and benchmarking queries

Open Terminal inside the TPC-DS folder:

```sh
# Install packages
sudo apt install gcc make gcc-9 yacc bison flex

# Build tools
cd tools
make CC=gcc-9

# Generate dataset and schemas
./dsdgen -sc 1 -dir ../results/data -TERMINATE N

# Navigate to parent folder
cd ..

# Reformat data
sudo chmod +x reformat_data.sh
./reformat_data.sh

# Copy schemas (only when unable to import the current schemas.sql)
# Remove primary key definition lines after copying
cp tpcds.sql results/schemas.sql

# Generate test queries
./convert_to_lf.sh query_templates
./convert_to_lf.sh query_variants
./generate_queries.sh
```

Use the generated data in the `./results` folder for benchmarking.
