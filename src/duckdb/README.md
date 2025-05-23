# Tự động hóa Benchmark DuckDB

Thư mục này cung cấp các script để tự động hóa việc benchmark DuckDB với bộ dữ liệu TPC-H và TPC-DS.

## Các bước thực hiện

### 1. Cài đặt DuckDB

Chạy script cài đặt để thiết lập DuckDB trên hệ thống:

```bash
./install_duckdb.sh
```

### 2. Sinh dữ liệu và chạy benchmark

Sử dụng script chính để lấy dữ liệu đã tạo ra sẵn và chạy benchmark.  
Cú pháp:

```bash
./main.sh <type> <scale_factor> <num_runs> <aws_instance>
```

-   `type`: `1` cho TPC-H, `2` cho TPC-DS
-   `scale_factor`: Kích thước bộ dữ liệu (ví dụ: 1, 5, 10, 20, 30, 50, 100)
-   `num_runs`: Số lần lặp lại benchmark
-   `aws_instance`: Loại instance AWS (ví dụ: on_c7a_8xlarge, on_g4dn_xlarge)

Ví dụ:

```bash
./main.sh 1 10 3 on_g4dn_xlarge
```

Lệnh trên sẽ chạy benchmark TPC-H với scale factor 10, lặp lại 3 lần trên instance g4dn.xlarge.

**Đường dẫn file DuckDB:**

-   TPC-H: `/mnt/data/storage/tpch/<scale_factor>GB.duckdb`
-   TPC-DS: `/mnt/data/storage/tpcds/<scale_factor>GB.duckdb`

**Đường dẫn các file truy vấn SQL sử dụng để benchmark:**

-   TPC-H: `tpc-h/sql/queries_<scale_factor>/`
-   TPC-DS: `tpc-ds/sql/query<scale_factor>/splited/`

### 3. Chi tiết script benchmark

Script benchmark sẽ được gọi tự động bởi `main.sh` cho mỗi lần chạy.  
Bạn cũng có thể chạy trực tiếp:

```bash
./process/benchmark.sh <type> <scale_factor> <run_number> <aws_instance>
```

Kết quả sẽ được lưu tại thư mục `../benchmark_result/<aws_instance>/duckdb/`.

---

**Lưu ý:**

-   Đảm bảo bạn có quyền đọc/ghi các file dữ liệu cần thiết.
-   Việc sinh dữ liệu được quản lý bởi script chính.
-   Tham số `aws_instance` cho phép bạn phân loại kết quả theo loại instance AWS đang sử dụng.
