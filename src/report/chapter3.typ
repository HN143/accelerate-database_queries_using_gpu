#import "template.typ": *
#import "util.typ": *
#import "state.typ": bib_state
#context bib_state.get()

#h1("PHƯƠNG PHÁP NGHIÊN CỨU")

#h2("Phương pháp nghiên cứu")
Trong nghiên cứu này, phương pháp thực nghiệm được sử dụng để so sánh hiệu suất giữa CPU và GPU trong việc xử lý các truy vấn cơ sở dữ liệu. Cụ thể, các truy vấn được thực hiện trên hai hệ quản trị cơ sở dữ liệu:
- *DuckDB*: Chạy trên CPU, được thiết kế để xử lý các truy vấn phân tích dữ liệu (OLAP) trên tập dữ liệu vừa và nhỏ.
- *HeavyDB*: Chạy trên GPU, được tối ưu hóa để xử lý các truy vấn phân tích dữ liệu lớn với tốc độ cao.

Phương pháp nghiên cứu bao gồm các bước sau: \
- *Bước 1: Chuẩn bị dữ liệu*: Sử dụng các bộ tiêu chuẩn benchmark TPC-H và TPC-DS để tạo dữ liệu thử nghiệm với các kích thước khác nhau (1GB, 2GB, 5GB, 10GB, 20GB). Dữ liệu được tổ chức theo mô hình quan hệ (TPC-H) và mô hình  bông tuyết (snowflake schema) (TPC-DS). \
- *Bước 2: Thiết kế truy vấn thử nghiệm*: Sử dụng các truy vấn chuẩn của TPC-H và TPC-DS để kiểm tra khả năng xử lý của DuckDB và HeavyDB. Các truy vấn bao gồm các phép nối (joins), tổng hợp (aggregations), và lọc dữ liệu (filters). \
- *Bước 3: Chạy truy vấn*: Thực hiện các truy vấn trên DuckDB (CPU) và HeavyDB (GPU), đồng thời đo thời gian thực thi và thu thập thông tin tài nguyên (CPU, GPU, RAM). \
- *Bước 4: Phân tích kết quả*: So sánh thời gian thực thi, mức tiêu thụ tài nguyên, và khả năng mở rộng giữa CPU và GPU.

Phương pháp này giúp đánh giá hiệu suất của DuckDB và HeavyDB trong các tác vụ phân tích dữ liệu, từ đó đưa ra kết luận về hiệu quả của việc sử dụng GPU để tăng tốc truy vấn.

#h2("Công cụ và phần cứng")

Phần này trình bày các công cụ và phần cứng được sử dụng trong nghiên cứu để thực hiện các truy vấn và đo lường hiệu suất giữa CPU và GPU.

#h3("Công cụ")
Các công cụ được sử dụng trong nghiên cứu bao gồm:
- *DuckDB*: Một hệ quản trị cơ sở dữ liệu nhúng, chạy trên CPU, được thiết kế để xử lý các truy vấn phân tích dữ liệu (OLAP) trên tập dữ liệu vừa và nhỏ.
- *HeavyDB*: Một hệ quản trị cơ sở dữ liệu tối ưu hóa cho GPU, hỗ trợ xử lý các truy vấn phân tích dữ liệu lớn với tốc độ cao.
- *TPC-H và TPC-DS*: Hai bộ tiêu chuẩn benchmark được sử dụng để tạo dữ liệu thử nghiệm và thiết kế các truy vấn phân tích dữ liệu.
- *Python*: Được sử dụng để tự động hóa việc chạy truy vấn, thu thập dữ liệu và phân tích kết quả.
- *nvidia-smi*: Công cụ theo dõi hiệu suất GPU, bao gồm mức sử dụng GPU và bộ nhớ GPU (VRAM).

#h3("Phần cứng")
Sử dụng máy ảo AWS EC2 g4dn.xlarge để thực hiện các thử nghiệm. Cấu hình chi tiết của máy ảo như sau:

- *CPU (Bộ xử lý)*:
  - Tên CPU: Intel Xeon Platinum 8259CL.
  - Số lõi / luồng: 2 lõi vật lý, 4 luồng.
  - Tốc độ xung nhịp: 2.5 GHz.
  - Kiến trúc: x86_64 (64-bit).
  - Bộ nhớ cache:
    - L1: 32 KB x 2.
    - L2: 1 MB x 2.
    - L3: 35.8 MB.
  - Mã CPU: Cascade Lake.

- *GPU (Card đồ họa)*:
  - Model: NVIDIA Tesla T4.
  - Số lượng: 1 GPU.
  - Bộ nhớ GPU: 16 GB GDDR6.
  - Compute Capability: 7.5.
  - Tốc độ tối đa: 1590 MHz.
  - Số đơn vị tính toán (CUDA Cores): 40.
  - Hiệu suất GPU (theo Geekbench OpenCL):
    - Điểm OpenCL tổng: 82,101.
    - Gaussian Blur: 106,180 điểm (~4.63 Gpixels/sec).
    - Edge Detection: 104,564 điểm (~3.88 Gpixels/sec).
    - Stereo Matching: 298,588 điểm (~283.8 Gpixels/sec).

- *RAM (Bộ nhớ)*:
  - Dung lượng: 16 GiB.
  - Loại RAM: FPM_RAM.
- *Lưu trữ*:
  - Loại ổ cứng: SSD NVMe.
  - Dung lượng: 125 GB.
- *Hiệu suất mạng*:
  - Băng thông mạng: Lên đến 25 Gigabit.
  - Băng thông EBS: 3.5 Gbps.
- *Hệ điều hành*:
  - Ubuntu 22.04 LTS, một hệ điều hành mã nguồn mở, tối ưu cho các tác vụ liên quan đến cơ sở dữ liệu và GPU.
- *Giá thuê máy ảo*:
  - \$0.526/giờ (giá thuê tại khu vực phía Tây nước Mỹ).

Phần cứng này được lựa chọn để đảm bảo khả năng xử lý dữ liệu lớn và hỗ trợ đầy đủ cho các công cụ benchmark, đặc biệt là HeavyDB với yêu cầu GPU mạnh mẽ.
#h2("Dữ liệu thử nghiệm")
#h2("Dữ liệu thử nghiệm")

Dữ liệu thử nghiệm được tạo ra bằng cách sử dụng API tích hợp của DuckDB. Bộ dữ liệu này được thiết kế để mô phỏng các tập dữ liệu thực tế, phục vụ cho việc kiểm tra hiệu suất của hệ thống cơ sở dữ liệu trên CPU và GPU.

#h3("Nguồn dữ liệu")
- *DuckDB API*: DuckDB cung cấp các công cụ tích hợp để tạo dữ liệu thử nghiệm trực tiếp từ các truy vấn SQL. Điều này cho phép tạo ra các tập dữ liệu tùy chỉnh với kích thước và cấu trúc phù hợp với mục tiêu nghiên cứu.
- *TPC-H và TPC-DS*: Các bộ dữ liệu được tạo ra dựa trên các tiêu chuẩn của TPC-H và TPC-DS, bao gồm các bảng sự kiện (Fact Tables) và bảng chiều (Dimension Tables).

#h3("Kích thước dữ liệu")
Dữ liệu thử nghiệm được tạo với các kích thước khác nhau để kiểm tra khả năng xử lý và hiệu suất của hệ thống:
- *1GB*: Dữ liệu nhỏ, phù hợp để kiểm tra hiệu suất cơ bản.
- *2GB*: Dữ liệu trung bình, kiểm tra khả năng xử lý của hệ thống.
- *5GB*: Dữ liệu lớn hơn, kiểm tra khả năng mở rộng.
- *10GB*: Dữ liệu lớn, kiểm tra hiệu suất tối ưu.
- *20GB*: Dữ liệu rất lớn, kiểm tra khả năng xử lý dữ liệu lớn của CPU và GPU.

#h3("Cách tạo dữ liệu")

Dữ liệu được tạo bằng cách sử dụng DuckDB với plugin TPC-DS. Plugin này cung cấp công cụ tích hợp để sinh dữ liệu thử nghiệm theo tiêu chuẩn TPC-DS với các scale factor khác nhau. Các bước thực hiện như sau:

1. **Cài đặt DuckDB**:
   - DuckDB cần được cài đặt trên hệ thống. Nếu chưa cài đặt, có thể sử dụng lệnh sau để cài đặt DuckDB qua `pip`:
     ```bash
     pip install duckdb
     ```

2. **Cài đặt và tải plugin TPC-DS**:
   - Sau khi cài đặt DuckDB, mở DuckDB và chạy các lệnh sau:
     ```sql
     INSTALL tpcds;
     LOAD tpcds;
     ```
   - `INSTALL tpcds`: Cài đặt plugin TPC-DS.
   - `LOAD tpcds`: Tải plugin TPC-DS vào phiên làm việc hiện tại.

3. **Sinh dữ liệu TPC-DS**:
   - Sử dụng lệnh `dsdgen` để tạo dữ liệu với scale factor mong muốn. Ví dụ:
     ```sql
     SELECT * FROM dsdgen(sf=1);
     ```
   - `sf=1`: Sinh dữ liệu với scale factor 1 (tương ứng với 1GB dữ liệu). Có thể thay đổi giá trị `sf` để tạo dữ liệu lớn hơn, ví dụ `sf=10` cho 10GB.

4. **Kiểm tra các bảng dữ liệu**:
   - Sau khi sinh dữ liệu, có thể kiểm tra danh sách các bảng được tạo bằng lệnh:
     ```sql
     SHOW TABLES;
     ```

5. **Truy vấn dữ liệu**:
   - Sau khi dữ liệu được tạo, bạn có thể thực hiện các truy vấn SQL để kiểm tra dữ liệu. Ví dụ:
     ```sql
     SELECT * FROM store_sales LIMIT 10;
     ```

6. **Xuất dữ liệu ra file CSV (nếu cần)**:
   - Nếu cần xuất dữ liệu ra file CSV để sử dụng trong các hệ thống khác, bạn có thể sử dụng lệnh:
     ```sql
     COPY store_sales TO 'store_sales.csv' (HEADER, DELIMITER ',');
     ```

#h3("Ví dụ tạo dữ liệu")
Dưới đây là một ví dụ cụ thể để tạo dữ liệu TPC-DS với scale factor 1GB:
```sql
INSTALL tpcds;
LOAD tpcds;
SELECT * FROM dsdgen(sf=1);
SHOW TABLES;
```
#h3("Danh sách các bảng dữ liệu")

Khi tạo bộ dữ liệu bằng cách sử dụng plugin TPC-DS trong DuckDB với lệnh `SELECT * FROM dsdgen(sf=1);`, có 24 bảng được sinh ra, các bảng này sẽ tuân theo tiêu chuẩn của TPC-DS. Dữ liệu bao gồm các *bảng sự kiện (Fact Tables)** và **bảng chiều (Dimension Tables)* như sau:

#h4("Bảng sự kiện (Fact Tables)")
Các bảng sự kiện chứa dữ liệu giao dịch hoặc sự kiện chính, gồm 7 bảng:
- *store_sales*: Doanh số bán hàng tại cửa hàng.
- *store_returns*: Hàng hóa trả lại tại cửa hàng.
- *web_sales*: Doanh số bán hàng trực tuyến.
- *web_returns*: Hàng hóa trả lại từ bán hàng trực tuyến.
- *catalog_sales*: Doanh số bán hàng qua danh mục.
- *catalog_returns*: Hàng hóa trả lại từ bán hàng qua danh mục.
- *inventory*: Thông tin tồn kho sản phẩm.

#h4("Bảng chiều (Dimension Tables)")
Các bảng chiều chứa thông tin mô tả liên quan đến các bảng sự kiện, gồm 17 bảng:
- *customer*: Thông tin khách hàng.
- *customer_address*: Địa chỉ khách hàng.
- *customer_demographics*: Thông tin nhân khẩu học của khách hàng.
- *date_dim*: Thông tin về ngày tháng.
- *time_dim*: Thông tin về thời gian.
- *item*: Thông tin sản phẩm.
- *promotion*: Thông tin về các chương trình khuyến mãi.
- *store*: Thông tin về cửa hàng.
- *web_site*: Thông tin về trang web bán hàng.
- *web_page*: Thông tin về các trang web cụ thể.
- *warehouse*: Thông tin về kho hàng.
- *ship_mode*: Thông tin về phương thức vận chuyển.
- *call_center*: Thông tin về trung tâm chăm sóc khách hàng.
- *income_band*: Phân loại thu nhập của khách hàng.
- *reason*: Lý do trả lại hàng.
- *household_demographics*: Thông tin nhân khẩu học của hộ gia đình.
- *catalog_page*:  Thông tin về các trang danh mục sản phẩm

#h4("Tổ chức dữ liệu")
- *Bảng sự kiện* thường chứa các giao dịch lớn và liên kết với các bảng chiều thông qua khóa ngoại (foreign key).
- *Bảng chiều* cung cấp thông tin chi tiết để phân tích dữ liệu từ các bảng sự kiện.


#h2("Các bước thực hiện")
#h2("Các truy vấn thử nghiệm")

Các truy vấn thử nghiệm được thiết kế dựa trên hai bộ tiêu chuẩn benchmark phổ biến là *TPC-H* và *TPC-DS*. Các truy vấn này được sử dụng để kiểm tra hiệu suất xử lý dữ liệu của DuckDB (CPU) và HeavyDB (GPU) trong các tác vụ phân tích dữ liệu. Dưới đây là mô tả chi tiết về cách các truy vấn được tạo ra, mục đích và đặc điểm của từng bộ truy vấn.

#h3("Bộ truy vấn TPC-H")

*Cách tạo truy vấn*
- Bộ truy vấn TPC-H được lấy từ phiên bản *TPC-H v2.4.0*, một tiêu chuẩn benchmark phổ biến cho các hệ thống xử lý dữ liệu phân tích (OLAP).
- Các truy vấn được sinh ra từ bộ công cụ chính thức của TPC-H, bao gồm 22 truy vấn chuẩn.
- Các truy vấn này được thiết kế để hoạt động trên tập dữ liệu được tổ chức theo mô hình quan hệ (Relational Model), với các bảng như `CUSTOMER`, `ORDERS`, `LINEITEM`, `PART`, v.v.

*Mục đích*
- Đánh giá hiệu suất của hệ thống cơ sở dữ liệu trong các tác vụ phân tích dữ liệu truyền thống.
- Kiểm tra khả năng xử lý các phép nối phức tạp, tổng hợp dữ liệu, và lọc dữ liệu trên các bảng lớn.
- Đánh giá khả năng tối ưu hóa truy vấn của hệ thống.

*Đặc điểm*
- Số lượng truy vấn: 22 truy vấn chuẩn.
- Loại tác vụ:
  - Phép nối (joins) giữa các bảng lớn.
  - Tổng hợp dữ liệu (aggregations) như tính tổng, trung bình, tối đa, tối thiểu.
  - Lọc dữ liệu (filters) dựa trên các điều kiện cụ thể.
- Tính phức tạp:
  - Các truy vấn có độ phức tạp trung bình đến cao, với nhiều phép nối và điều kiện lọc.
*Ví dụ truy vấn*: Dưới đây là câu truy vấn 1 được tạo ra từ bộ dữ liệu 1GB
```sql
select
	l_returnflag,
	l_linestatus,
	sum(l_quantity) as sum_qty,
	sum(l_extendedprice) as sum_base_price,
	sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
	sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
	avg(l_quantity) as avg_qty,
	avg(l_extendedprice) as avg_price,
	avg(l_discount) as avg_disc,
	count(*) as count_order
from
	lineitem
where
	l_shipdate <= date '1998-12-01' - interval '90' day (3)
group by
	l_returnflag,
	l_linestatus
order by
	l_returnflag,
	l_linestatus;


```
#h3("Bộ truy vấn TPC-DS")

*Cách tạo truy vấn:*
- Bộ truy vấn TPC-DS được lấy từ phiên bản TPC-DS v2.10.0, một tiêu chuẩn benchmark dành cho các hệ thống kho dữ liệu (Data Warehousing).
- Các truy vấn được sinh ra từ bộ công cụ TPC-DS kit, bao gồm 99 truy vấn chuẩn.
- Các truy vấn này được thiết kế để hoạt động trên tập dữ liệu được tổ chức theo mô hình ngôi sao (Star Schema) hoặc bông tuyết (Snowflake Schema), với các bảng sự kiện (Fact Tables) như store_sales, web_sales, và các bảng chiều (Dimension Tables) như customer, item, date_dim.

*Mục đích:*
- Đánh giá hiệu suất của hệ thống cơ sở dữ liệu trong các tác vụ phân tích dữ liệu phức tạp.
- Kiểm tra khả năng xử lý các truy vấn đa chiều, phân tích doanh số bán hàng, và dự báo tồn kho.
- Đánh giá khả năng mở rộng của hệ thống khi kích thước dữ liệu tăng lên.

*Đặc điểm:*
- Số lượng truy vấn: 99 truy vấn chuẩn.
- Loại tác vụ:
  - Phân tích doanh số bán hàng qua các kênh khác nhau (cửa hàng, trực tuyến, danh mục).
  - Phân tích khuyến mãi và hành vi khách hàng.
  - Dự báo và tối ưu hóa tồn kho.
- Tính phức tạp: Các truy vấn có độ phức tạp cao, với nhiều phép nối, tổng hợp, và điều kiện lọc.
*Ví dụ truy vấn*: Dưới đây là câu truy vấn 1 được tạo ra từ bộ dữ liệu 1GB
```sql
WITH customer_total_return AS (
    SELECT 
        sr_customer_sk AS ctr_customer_sk,
        sr_store_sk AS ctr_store_sk,
        SUM(sr_fee) AS ctr_total_return
    FROM 
        store_returns,
        date_dim
    WHERE 
        sr_returned_date_sk = d_date_sk
        AND d_year = 2000
    GROUP BY 
        sr_customer_sk,
        sr_store_sk
)

SELECT 
    c_customer_id
FROM 
    customer_total_return ctr1,
    store,
    customer
WHERE 
    ctr1.ctr_total_return > (
        SELECT 
            AVG(ctr_total_return) * 1.2
        FROM 
            customer_total_return ctr2
        WHERE 
            ctr1.ctr_store_sk = ctr2.ctr_store_sk
    )
    AND s_store_sk = ctr1.ctr_store_sk
    AND s_state = 'TN'
    AND ctr1.ctr_customer_sk = c_customer_sk
ORDER BY 
    c_customer_id
LIMIT 100;


```
#h2("Thang đo đánh giá")

Thang đo đánh giá được sử dụng để so sánh hiệu suất giữa DuckDB (CPU) và HeavyDB (GPU) trong các tác vụ phân tích dữ liệu. Các tiêu chí đánh giá được lựa chọn nhằm đảm bảo tính khách quan và toàn diện, bao gồm:

#h3("1. Thời gian thực thi (Execution Time)")
- *Mục tiêu*: Đánh giá tốc độ xử lý của hệ thống khi thực thi các truy vấn.
- *Phương pháp đo lường*:
  - Đo thời gian thực thi từng truy vấn từ lúc bắt đầu đến khi hoàn thành.
  - Sử dụng công cụ tích hợp trong DuckDB và HeavyDB để ghi nhận thời gian thực thi.
- *Đơn vị đo*: Milliseconds (ms).
- *Ý nghĩa*:
  - Thời gian thực thi càng thấp, hiệu suất xử lý càng cao.

#h3("2. Mức tiêu thụ tài nguyên (Resource Utilization)")
- *Mục tiêu*: Đánh giá mức sử dụng tài nguyên hệ thống (CPU, GPU, RAM) trong quá trình thực thi truy vấn.
- *Phương pháp đo lường*:
  - Sử dụng công cụ giám sát như `nvidia-smi` để theo dõi mức sử dụng GPU.
  - Sử dụng công cụ `sar` để theo dõi mức sử dụng CPU và RAM.
- *Đơn vị đo*:
  - CPU: % sử dụng.
  - GPU: % sử dụng và dung lượng bộ nhớ GPU (VRAM) sử dụng (MB).
  - RAM: Dung lượng bộ nhớ sử dụng (MB).
- *Ý nghĩa*:
  - Hệ thống sử dụng tài nguyên hiệu quả hơn sẽ có mức tiêu thụ thấp hơn trong khi vẫn đảm bảo thời gian thực thi tốt.

#h3("3. Khả năng mở rộng (Scalability)")
- *Mục tiêu*: Đánh giá khả năng của hệ thống khi kích thước dữ liệu tăng lên.
- *Phương pháp đo lường*:
  - Tạo dữ liệu thử nghiệm với các scale factor khác nhau (1GB, 2GB, 5GB, 10GB, 20GB).
  - Đo thời gian thực thi và mức tiêu thụ tài nguyên tương ứng với từng kích thước dữ liệu.
- *Ý nghĩa*:
  - Hệ thống có khả năng mở rộng tốt sẽ duy trì hiệu suất ổn định khi kích thước dữ liệu tăng lên.

#h3("4. Độ ổn định (Stability)")
- *Mục tiêu*: Đánh giá khả năng của hệ thống trong việc xử lý các truy vấn liên tục mà không gặp lỗi hoặc giảm hiệu suất.
- *Phương pháp đo lường*:
  - Chạy lặp lại các truy vấn nhiều lần trên cùng một bộ dữ liệu.
  - Ghi nhận các lỗi xảy ra (nếu có) và sự thay đổi về thời gian thực thi giữa các lần chạy.
- *Ý nghĩa*:
  - Hệ thống ổn định sẽ có thời gian thực thi nhất quán và không gặp lỗi trong quá trình thử nghiệm.

#h3("5. Độ phức tạp của truy vấn (Query Complexity)")
- *Mục tiêu*: Đánh giá khả năng xử lý các truy vấn có độ phức tạp khác nhau.
- *Phương pháp đo lường*:
  - Phân loại các truy vấn theo độ phức tạp (thấp, trung bình, cao) dựa trên số lượng phép nối, tổng hợp, và điều kiện lọc.
  - Đo thời gian thực thi và mức tiêu thụ tài nguyên cho từng loại truy vấn.
- *Ý nghĩa*:
  - Hệ thống hiệu quả sẽ xử lý tốt cả các truy vấn phức tạp mà không làm tăng đáng kể thời gian thực thi hoặc mức tiêu thụ tài nguyên.

#h3("6. Hiệu suất tổng thể (Overall Performance)")
- *Mục tiêu*: Đánh giá hiệu suất tổng thể của hệ thống dựa trên các tiêu chí đã nêu.
- *Phương pháp đo lường*:
  - Tổng hợp kết quả từ các tiêu chí trên (thời gian thực thi, mức tiêu thụ tài nguyên, khả năng mở rộng, độ ổn định, độ phức tạp của truy vấn).
  - Sử dụng các biểu đồ và bảng để so sánh hiệu suất giữa DuckDB và HeavyDB.
- *Ý nghĩa*:
  - Hiệu suất tổng thể cao cho thấy hệ thống có khả năng xử lý dữ liệu tốt, ổn định, và hiệu quả.

#h3("Kết luận")
Thang đo đánh giá được thiết kế để đảm bảo tính toàn diện và khách quan trong việc so sánh hiệu suất giữa DuckDB và HeavyDB. Các tiêu chí như thời gian thực thi, mức tiêu thụ tài nguyên, khả năng mở rộng, và độ ổn định cung cấp cái nhìn sâu sắc về hiệu quả của từng hệ thống trong các tác vụ phân tích dữ liệu.
