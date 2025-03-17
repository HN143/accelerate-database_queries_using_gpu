# Hướng Dẫn Cài Đặt Git Trên Ubuntu

### Bước 1: Cài git

`sudo apt install git -y`
`git clone https://github.com/Tuienn/DuckDB_TPCH_script.git`

> Nếu bị lỗi
>
> ```
> E: Could not get lock /var/lib/dpkg/lock-frontend - open (11: Resource temporarily unavailable)
> E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?
> ```
>
> thì dùng cặp câu lệnh
>
> ```
> sudo rm -f /var/lib/dpkg/lock
> sudo rm -f /var/lib/dpkg/lock-frontend
> ```

### Bước 2: Cấp quyền cho các file

> ```
> chmod a+x DuckDB_TPCH_script/setup.sh
> chmod a+x DuckDB_TPCH_script/benchmark.sh
> ```

### Bước 3: Chạy script

> ```
> ./DuckDB_TPCH_script/setup.sh
> ./DuckDB_TPCH_script/benchmark.sh
> ```

## **Sau khi chạy xong benchmark.sh**

> Xem chi tiết log của benchmark dùng lệnh `nano duckdb_output.log`
> Xem kết quả runtime của benchmark dùng lệnh `nano runtime_results.txt`
