# TPC-DS dataset

## Prerequisites

- OS: Ubuntu
- HeavyDB

## Installation

1. Open Terminal inside the TPC-DS folder:

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

# Add `allowed-import-paths = ["/"]` to /var/lib/heavyai/heavy.conf
vi /var/lib/heavyai/heavy.conf
sudo systemctl daemon-reload
```

2. Import test data

```sql
COPY call_center FROM 'results/data/call_center.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_page FROM 'results/data/catalog_page.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_returns FROM 'results/data/catalog_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_sales FROM 'results/data/catalog_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer_address FROM 'results/data/customer_address.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer FROM 'results/data/customer.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer_demographics FROM 'results/data/customer_demographics.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY date_dim FROM 'results/data/date_dim.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY dbgen_version FROM 'results/data/dbgen_version.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY household_demographics FROM 'results/data/household_demographics.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY income_band FROM 'results/data/income_band.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY inventory FROM 'results/data/inventory.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY item FROM 'results/data/item.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY promotion FROM 'results/data/promotion.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY reason FROM 'results/data/reason.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY ship_mode FROM 'results/data/ship_mode.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store FROM 'results/data/store.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store_returns FROM 'results/data/store_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store_sales FROM 'results/data/store_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY time_dim FROM 'results/data/time_dim.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY warehouse FROM 'results/data/warehouse.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_page FROM 'results/data/web_page.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_returns FROM 'results/data/web_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_sales FROM 'results/data/web_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_site FROM 'results/data/web_site.dat' WITH (delimiter = '|', line_delimiter = '\n');
```
