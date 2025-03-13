# Installation

1. Open Terminal inside the TPC-DS folder:

```sh
# Install packages
sudo apt install gcc make gcc-9 yacc bison flex

# Build tools
cd tools
make CC=gcc-9

# Generate dataset and schemas
mkdir ../data1gb
./dsdgen -sc 1 -dir ../data1gb -TERMINATE N

# Copy schemas
cp tpcds.sql ../

# Reformat data
cp ../reformat.sh ../data1gb/
cd ../data1gb
sudo chmod +x reformat.sh
./reformat.sh

# Start a HeavyDB Docker container
docker run -d --name hea -v /var/lib/heavyai:/var/lib/heavyai -p 6273-6278:6273-6278 heavyai/core-os-cpu:latest
# or
docker start hea

# Inside the HeavyDB Docker container, add `allowed-import-paths = ["/"]` to /var/lib/heavyai/heavy.conf
docker exec -it hea bash
vi /var/lib/heavyai/heavy.conf

# Restart the Docker container
docker restart hea

# Copy data to the Docker container
cp ../cp.sh ./
./cp.sh

# Generate test queries
cd ..
./gq.sh
```

2. Import test data

```sh
docker exec -it hea bin/heavysql
```

```sql
COPY call_center FROM '/data/call_center.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_page FROM '/data/catalog_page.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_returns FROM '/data/catalog_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_sales FROM '/data/catalog_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer_address FROM '/data/customer_address.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer FROM '/data/customer.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer_demographics FROM '/data/customer_demographics.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY date_dim FROM '/data/date_dim.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY dbgen_version FROM '/data/dbgen_version.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY household_demographics FROM '/data/household_demographics.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY income_band FROM '/data/income_band.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY inventory FROM '/data/inventory.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY item FROM '/data/item.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY promotion FROM '/data/promotion.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY reason FROM '/data/reason.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY ship_mode FROM '/data/ship_mode.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store FROM '/data/store.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store_returns FROM '/data/store_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store_sales FROM '/data/store_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY time_dim FROM '/data/time_dim.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY warehouse FROM '/data/warehouse.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_page FROM '/data/web_page.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_returns FROM '/data/web_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_sales FROM '/data/web_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_site FROM '/data/web_site.dat' WITH (delimiter = '|', line_delimiter = '\n');
```
