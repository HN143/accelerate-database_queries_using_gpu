# Accelerate Database Queries with GPU - HeavyDB Documentation

## Prerequisites

- HeavyDB

## Setup

### Update configuration

Add the `allowed-import-paths = ["/"]` line to `/var/lib/heavyai/heavy.conf` and then reload the service:

```sh
vi /var/lib/heavyai/heavy.conf
sudo systemctl daemon-reload
```

### Import test data

Use the following SQL commands to import generated test data of TPC-DS. Replace `<absolute-path-to>` with your absolute path to the folder contain TPC-DS test data:

```sql
COPY call_center FROM '<absolute-path-to>/call_center.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_page FROM '<absolute-path-to>/catalog_page.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_returns FROM '<absolute-path-to>/catalog_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY catalog_sales FROM '<absolute-path-to>/catalog_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer_address FROM '<absolute-path-to>/customer_address.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer FROM '<absolute-path-to>/customer.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY customer_demographics FROM '<absolute-path-to>/customer_demographics.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY date_dim FROM '<absolute-path-to>/date_dim.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY dbgen_version FROM '<absolute-path-to>/dbgen_version.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY household_demographics FROM '<absolute-path-to>/household_demographics.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY income_band FROM '<absolute-path-to>/income_band.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY inventory FROM '<absolute-path-to>/inventory.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY item FROM '<absolute-path-to>/item.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY promotion FROM '<absolute-path-to>/promotion.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY reason FROM '<absolute-path-to>/reason.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY ship_mode FROM '<absolute-path-to>/ship_mode.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store FROM '<absolute-path-to>/store.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store_returns FROM '<absolute-path-to>/store_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY store_sales FROM '<absolute-path-to>/store_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY time_dim FROM '<absolute-path-to>/time_dim.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY warehouse FROM '<absolute-path-to>/warehouse.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_page FROM '<absolute-path-to>/web_page.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_returns FROM '<absolute-path-to>/web_returns.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_sales FROM '<absolute-path-to>/web_sales.dat' WITH (delimiter = '|', line_delimiter = '\n');
COPY web_site FROM '<absolute-path-to>/web_site.dat' WITH (delimiter = '|', line_delimiter = '\n');
```
