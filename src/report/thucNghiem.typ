#import "template.typ": *
#import "util.typ": *
#import "state.typ": bib_state
#context bib_state.get()

#h1("Thực nghiệm")

#h2("Cấu hình máy chủ thực nghiệm")
#h3("Lựa chọn Cấu hình Máy chủ AWS EC2")

Để đảm bảo việc đánh giá hiệu năng giữa HeavyDB (tối ưu cho GPU) và DuckDB (tối ưu cho CPU) được thực hiện một cách chính xác và phản ánh đúng tiềm năng của từng hệ thống trong các kịch bản thực tế, hai cấu hình máy chủ AWS EC2 riêng biệt đã được lựa chọn. Mỗi cấu hình được chọn lựa cẩn thận nhằm tối ưu hóa cho loại workload và hệ quản trị cơ sở dữ liệu tương ứng.

#h4("Cấu hình cho HeavyDB (Nền tảng GPU)")
Instance `g5.2xlarge` được lựa chọn để triển khai HeavyDB, nhằm khai thác tối đa khả năng xử lý song song mạnh mẽ của kiến trúc GPU hiện đại:

- *Loại Instance:* `g5.2xlarge`
- *Bộ xử lý (CPU):* 8 vCPU (thường là AMD EPYC 7R32 trên thế hệ G5)
- *Bộ xử lý đồ họa (GPU):* 1 x NVIDIA A10G Tensor Core
- *Bộ nhớ GPU (VRAM):* 24 GiB GDDR6 - Dung lượng đủ lớn để chứa các bảng dữ liệu quan trọng của TPC-H/DS ở các Scale Factor mục tiêu (lên đến 50GB), giảm thiểu việc truy cập bộ nhớ hệ thống.
- *Bộ nhớ hệ thống (RAM):* 32 GiB - Đóng vai trò bộ đệm khi dữ liệu vượt quá VRAM.
- *Mục đích:* Cung cấp nền tảng GPU kiến trúc Ampere mạnh mẽ, phù hợp cho các tác vụ tính toán, phân tích dữ liệu phức tạp và xử lý song song quy mô lớn mà HeavyDB được thiết kế để tận dụng.

#h4("Cấu hình cho DuckDB (Nền tảng CPU)")
Instance `c7a.8xlarge` được lựa chọn để triển khai DuckDB, đảm bảo hệ thống này được vận hành trên một nền tảng CPU hiệu năng cao, đại diện cho sức mạnh tính toán của các bộ xử lý hiện đại:

- *Loại Instance:* `c7a.8xlarge`
- *Bộ xử lý (CPU):* 32 vCPU (AMD EPYC 9R14 - Thế hệ 4 "Genoa") - Số lượng nhân lớn và kiến trúc mới nhất đảm bảo khả năng xử lý song song và hiệu suất đơn luồng cao.
- *Tần số Turbo tối đa:* Lên đến 3.7 GHz.
- *Bộ nhớ hệ thống (RAM):* 64 GiB - Dung lượng lớn, đủ để DuckDB (vốn là hệ thống in-memory hiệu quả) xử lý các bộ dữ liệu TPC-H/DS mục tiêu mà không bị giới hạn bởi bộ nhớ (ít nhất ở các SF nhỏ và vừa).
- *Mục đích:* Tạo ra một môi trường CPU mạnh mẽ nhất có thể để DuckDB, với các kỹ thuật tối ưu hóa vector hóa tiên tiến, thể hiện được tiềm năng tối đa của mình. Đây là cơ sở để có một phép so sánh công bằng và ý nghĩa về hiệu năng khi đối đầu với giải pháp GPU.

#h4("Lý do lựa chọn hai cấu hình riêng biệt và khác nhau")
Việc lựa chọn hai cấu hình riêng biệt và không hoàn toàn tương đương về tài nguyên CPU/RAM là một quyết định có chủ đích và chiến lược, dựa trên phân tích, kinh nghiệm thực nghiệm ban đầu và mục tiêu nghiên cứu:

- *Đảm bảo Môi trường Tối ưu cho Từng Công nghệ:* Mục tiêu cốt lõi là so sánh hiệu quả của hai hướng tiếp cận công nghệ khác nhau (GPU-native vs CPU-optimized) khi mỗi hướng được phát huy tối đa. HeavyDB cần một GPU mạnh (A10G) để thể hiện giá trị, trong khi DuckDB cần một CPU đa nhân, hiện đại (EPYC Gen 4) để không bị giới hạn. Việc ép cả hai vào một cấu hình "tương đương" hoặc chạy trên CPU yếu của máy G5 sẽ làm sai lệch kết quả và không phản ánh đúng tiềm năng của ít nhất một trong hai hệ thống.
- *Phản ánh Bài toán Lựa chọn Thực tế:* Thay vì một so sánh hàn lâm trên phần cứng giả định, phương pháp này mô phỏng kịch bản thực tế nơi người dùng phải lựa chọn giữa việc đầu tư vào một hệ thống trang bị GPU chuyên dụng (như G5) hoặc một hệ thống CPU mạnh mẽ (như C7a) cho nhu cầu phân tích dữ liệu của họ.
- *Tạo ra Phép so sánh Cạnh tranh và Ý nghĩa:* Bằng cách đặt HeavyDB/G5 đối đầu với DuckDB/C7a, nghiên cứu đảm bảo rằng giải pháp GPU đang được so sánh với một đối thủ CPU thực sự mạnh mẽ và được tối ưu hóa cao độ. Điều này làm cho bất kỳ lợi thế nào mà GPU thể hiện được trở nên thuyết phục hơn, và ngược lại, cũng cho thấy rõ những lĩnh vực mà CPU hiện đại vẫn chiếm ưu thế.
- *Tập trung vào Giải pháp Tổng thể:* Nghiên cứu này đánh giá hiệu năng của hệ thống CSDL cụ thể (HeavyDB, DuckDB) được triển khai trên nền tảng phần cứng phù hợp nhất với kiến trúc của chúng, thay vì chỉ so sánh "GPU vs CPU" một cách trừu tượng trên phần cứng không tối ưu cho cả hai.

Mặc dù có sự khác biệt về cấu hình hỗ trợ (CPU/RAM), lựa chọn này cho phép tiến hành một cuộc đối đầu công bằng hơn về mặt tiềm năng công nghệ và rút ra những kết luận sâu sắc, thực tế hơn về vai trò và hiệu quả của GPU trong việc tăng tốc cơ sở dữ liệu phân tích hiện đại.


#h3("Setup môi trường thực nghiệm")
#img("setup/setup.png", cap: "Sơ đồ luồng cài đặt môi trường thực nghiệm",width: 70%)<imgxxx1>
Trong quá trình thiết lập môi trường thực nghiệm, chúng tôi đã sử dụng các máy ảo AWS và thực hiện các bước như sau:

- *Hệ điều hành*: Các máy ảo (HeavyDB machine và DuckDB machine) được cài đặt hệ điều hành *Ubuntu 22.04*. Phiên bản này được lựa chọn vì tính ổn định, hiệu suất cao và khả năng tương thích tốt với các công cụ cần thiết như HeavyDB và DuckDB.

- *Tạo AMI cho HeavyDB*: Một AMI (Amazon Machine Image) chứa sẵn HeavyDB và các cấu hình cần thiết được tạo trên nền tảng Ubuntu 22.04 để tiết kiệm thời gian và tránh việc phải cài đặt lại HeavyDB nhiều lần trong quá trình thử nghiệm.

- *Cài đặt DuckDB*: DuckDB được cài đặt trực tiếp trên máy ảo DuckDB mỗi khi cần, không sử dụng AMI riêng do việc cài đặt DuckDB khá nhanh chóng và đơn giản. Điều này giúp tiết kiệm dung lượng lưu trữ và thời gian tạo AMI.

- *Tạo Data Storage Volume*:
   - Một *Data Storage Volume* được tạo để lưu trữ các bộ dữ liệu lớn (>= 50GB). Đây là nơi dữ liệu được sinh ra chung cho cả HeavyDB và DuckDB sử dụng trong các bài thử nghiệm benchmark.
   - Đối với các bộ dữ liệu nhỏ hơn (1GB, 5GB, 10GB, 20GB), dữ liệu được tạo trực tiếp trên máy ảo HeavyDB hoặc DuckDB mà không cần sử dụng Data Storage Volume.

- *Quy trình xử lý dữ liệu lớn*:
   - Đối với các bộ dữ liệu lớn (>= 50GB), thời gian sinh dữ liệu khá lâu (khoảng >= 20 phút). Vì vậy, Data Storage Volume được sử dụng để lưu trữ các bộ dữ liệu này.
   - Khi cần sử dụng, máy ảo HeavyDB hoặc DuckDB chỉ cần *mount* Data Storage Volume vào và thực hiện các tác vụ cần thiết.

- *Luồng hoạt động*:
   - Máy ảo HeavyDB được sử dụng để chạy các tác vụ liên quan đến GPU.
   - Máy ảo DuckDB được sử dụng để chạy các tác vụ liên quan đến CPU.
   - Cả hai máy ảo có thể truy cập chung vào Data Storage Volume để sử dụng các bộ dữ liệu lớn khi cần thiết. Khi cần dùng thì HeavyDB machine hoặc DuckDB machine sẽ mount Data Storage Volume vào và thực hiện các tác vụ cần thiết. Việc này giúp tiết kiệm thời gian và dung lượng lưu trữ, đồng thời đảm bảo tính nhất quán của dữ liệu giữa hai hệ thống.                                                                                            
Cách thiết lập này đảm bảo tính linh hoạt, tiết kiệm thời gian và tối ưu hóa hiệu suất trong quá trình thực nghiệm.

#h2("Dữ liệu thử nghiệm")

Dữ liệu thử nghiệm trong nghiên cứu được sinh ra từ hai bộ công cụ chuẩn hóa là TPC-H và TPC-DS, thông qua tính năng tích hợp sẵn của hệ quản trị cơ sở dữ liệu DuckDB. Việc sử dụng dữ liệu từ các chuẩn này nhằm đảm bảo tính khách quan, tính mô phỏng thực tế và khả năng so sánh kết quả giữa các hệ thống.

#h3("Nguồn dữ liệu")
*TPC-H* là một bộ benchmark phổ biến trong việc đánh giá hiệu suất của các hệ quản trị cơ sở dữ liệu hướng phân tích (OLAP). Bộ dữ liệu này mô phỏng các nghiệp vụ phân tích truyền thống của doanh nghiệp như quản lý đơn hàng, khách hàng, và sản phẩm. Mô hình dữ liệu được xây dựng theo dạng quan hệ chuẩn hóa, giúp phản ánh đúng các phép toán JOIN phức tạp trong truy vấn phân tích.

*TPC-DS* được thiết kế để phản ánh các truy vấn phân tích phức tạp hơn, đặc biệt trong môi trường kho dữ liệu doanh nghiệp. Mô hình dữ liệu trong TPC-DS có cấu trúc dạng ngôi sao (star schema) và bông tuyết (snowflake schema), phù hợp để kiểm tra khả năng xử lý dữ liệu lớn, đa chiều và sự tối ưu hóa của hệ thống trong các bài toán truy vấn thực tế.

*DuckDB* được sử dụng như công cụ tạo dữ liệu, với khả năng hỗ trợ sinh dữ liệu TPC-H và TPC-DS thông qua câu lệnh tích hợp. Việc sử dụng DuckDB giúp rút ngắn quy trình chuẩn bị dữ liệu và đảm bảo tính tương thích với hệ thống thử nghiệm.

#h3("Kích thước dữ liệu")
Dữ liệu thử nghiệm được tạo với các kích thước khác nhau để kiểm tra khả năng xử lý và hiệu suất của hệ thống:
- *1GB*: Dữ liệu nhỏ, phù hợp để kiểm tra hiệu suất cơ bản.
- *5GB*: Dữ liệu trung bình, kiểm tra khả năng xử lý của hệ thống.
- *10GB*: Dữ liệu lớn, kiểm tra hiệu suất tối ưu.
- *20GB*: Dữ liệu rất lớn, kiểm tra khả năng xử lý dữ liệu lớn của CPU và GPU.
- *50GB*: Dữ liệu cực lớn, kiểm tra khả năng mở rộng tối đa của hệ thống.
- *100GB*: Dữ liệu khổng lồ, kiểm tra giới hạn hiệu suất của hệ thống trong các bài toán phân tích dữ liệu lớn.

Dưới đây là bảng tổng hợp kích thước dữ liệu và thời gian sinh dữ liệu cho TPC-H và TPC-DS (Chạy trên máy c7a.8xlarge):
#tabl(
  columns: (auto, auto, auto, auto, auto),
  align: (x, y) => if y == 0 { center } else { center }, // Tiêu đề căn giữa, nội dung căn trái
  stroke: 0.5pt,
  fill: (x, y) => if y == 0 { gray.lighten(50%) } else { white },
  
  [*Kích thước (GB)*], [*Tổng số bản ghi TPC-H*], [*Tổng số bản ghi TPC-DS*],[*Thời gian sinh dữ liệu TPC-H (s)* ], [*Thời gian sinh dữ liệu TPC-DS (s)*],
  [1],	[8.661.245],	[19.557.579],	[9],	[19],
  [5], [43.299.825], [79.615.123], [41], [75],
  [10], [86.586.082], [191.500.208], [86], [155],
  [20], [173.194.638], [131.673.124], [164], [239],
  [30], [259.798.402], [200.436.595], [241], [369],
  [50], [433.005.841], [337.148.059], [406], [597],
  [100], [866.037.932], [959.031.513], [800], [1268],
  cap: "Tổng số bản ghi và thời gian sinh dữ liệu cho TPC-H và TPC-DS",
)
#h3("Cách tạo bộ dữ liệu")

Dữ liệu thử nghiệm được tạo tự động bằng cách sử dụng API của DuckDB thông qua script `generate_data.sh`. Script này hỗ trợ sinh dữ liệu từ hai bộ benchmark chuẩn là TPC-H và TPC-DS với các kích thước khác nhau. Quy trình cụ thể như sau:

- *Công cụ sử dụng*:
   - DuckDB được sử dụng làm công cụ chính để sinh dữ liệu. DuckDB hỗ trợ tích hợp các plugin TPC-H và TPC-DS, cho phép tạo dữ liệu trực tiếp thông qua các hàm SQL.
   - Script `generate_data.sh` được viết để tự động hóa quá trình tạo dữ liệu, đảm bảo tính nhất quán và dễ dàng mở rộng.

- *Tham số đầu vào*:
   - Script nhận hai tham số:
    - `TYPE`: Loại benchmark (1 cho TPC-H, 2 cho TPC-DS).
    - `SCALE_FACTOR`: Kích thước dữ liệu cần tạo (ví dụ: 1, 5, 10, 20, 50, 100).

- *Quy trình tạo dữ liệu*:
   - Dựa trên tham số `TYPE`, script xác định loại benchmark:
     - Với `TYPE=1`, script sử dụng plugin TPC-H (`tpch`) và hàm `dbgen` để tạo dữ liệu.
     - Với `TYPE=2`, script sử dụng plugin TPC-DS (`tpcds`) và hàm `dsdgen` để tạo dữ liệu.
   - Script kiểm tra xem file cơ sở dữ liệu DuckDB đã tồn tại hay chưa. Nếu có, file sẽ bị xóa để đảm bảo dữ liệu được tạo mới hoàn toàn.
   - DuckDB được chạy với các lệnh SQL sau:
     ```sql
     INSTALL <plugin>;
     LOAD <plugin>;
     SELECT * FROM <gen_function>(sf=<SCALE_FACTOR>);
     ```
     Trong đó:
     - `<plugin>` là `tpch` hoặc `tpcds` tùy thuộc vào loại benchmark.
     - `<gen_function>` là `dbgen` hoặc `dsdgen`.
     - `<SCALE_FACTOR>` là kích thước dữ liệu cần tạo.

- *Ví dụ sử dụng*:
   - Để tạo dữ liệu TPC-H với kích thước 10GB:
     ```bash
     ./generate_data.sh 1 10
     ```
   - Để tạo dữ liệu TPC-DS với kích thước 50GB:
     ```bash
     ./generate_data.sh 2 50
     ```

- *Lưu trữ dữ liệu*:
   - Dữ liệu được lưu trữ trong các file DuckDB với cấu trúc thư mục như sau:
     ```
     tpc-h/tpc-h_nckh.duckdb
     tpc-ds/tpc-ds_nckh.duckdb
     ```
   - Các file này chứa toàn bộ dữ liệu được sinh ra, sẵn sàng để sử dụng trong các bài thử nghiệm benchmark.

- *Ưu điểm của quy trình*:
   - Tự động hóa hoàn toàn việc tạo dữ liệu, giảm thiểu sai sót thủ công.
   - Hỗ trợ linh hoạt cho cả hai bộ benchmark TPC-H và TPC-DS.
   - Dễ dàng mở rộng với các kích thước dữ liệu khác nhau thông qua tham số `SCALE_FACTOR`.

Phương pháp này đảm bảo dữ liệu thử nghiệm được tạo ra một cách nhất quán, nhanh chóng và phù hợp với các yêu cầu của bài toán phân tích dữ liệu lớn.

#h3("Danh sách các bảng dữ liệu thuộc bộ TPC-DS")

Khi tạo bộ dữ liệu bằng cách sử dụng plugin TPC-DS trong DuckDB với lệnh *`SELECT * FROM dsdgen(sf=1);`* có 24 bảng được sinh ra, các bảng này sẽ tuân theo tiêu chuẩn của TPC-DS. Dữ liệu bao gồm các *bảng sự kiện (Fact Tables)** và **bảng chiều (Dimension Tables)* như sau:

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

#h3("Danh sách các bảng dữ liệu thuộc bộ TPC-H")

Khi tạo bộ dữ liệu bằng cách sử dụng plugin TPC-H trong DuckDB với lệnh *`SELECT * FROM dbgen(sf=1);`* có 8 bảng được sinh ra. Các bảng này tuân theo tiêu chuẩn của TPC-H và được chia thành hai loại chính:* bảng sự kiện (Fact Tables)* và *bảng chiều (Dimension Tables)*.

#h4("Bảng sự kiện (Fact Tables)")
Bảng sự kiện chứa dữ liệu giao dịch hoặc sự kiện chính, gồm 2 bảng:
- *lineitem*: Chi tiết các mục trong đơn hàng, bao gồm thông tin về sản phẩm, số lượng, giá cả, chiết khấu, và trạng thái giao hàng.
- *orders*: Thông tin về đơn hàng, bao gồm khách hàng, ngày đặt hàng, trạng thái đơn hàng, và tổng giá trị.

#h4("Bảng chiều (Dimension Tables)")
Bảng chiều chứa thông tin mô tả liên quan đến các bảng sự kiện, gồm 6 bảng:
- *customer*: Thông tin khách hàng, bao gồm tên, địa chỉ, phân khúc thị trường, và quốc gia.
- *nation*: Thông tin về các quốc gia, bao gồm tên quốc gia và khu vực liên kết.
- *region*: Thông tin về các khu vực, bao gồm tên khu vực và mô tả.
- *part*: Thông tin về sản phẩm, bao gồm tên, loại, kích thước, và nhà cung cấp.
- *supplier*: Thông tin về nhà cung cấp, bao gồm tên, địa chỉ, quốc gia, và tài khoản.
- *partsupp*: Thông tin về mối quan hệ giữa sản phẩm và nhà cung cấp, bao gồm giá cả và số lượng hàng tồn kho.

#h4("Tổ chức dữ liệu")
- *Bảng sự kiện* thường chứa các giao dịch lớn và liên kết với các bảng chiều thông qua khóa ngoại (foreign key).
- *Bảng chiều* cung cấp thông tin chi tiết để phân tích dữ liệu từ các bảng sự kiện.

#h4("Mối quan hệ giữa các bảng")
- Bảng *orders* liên kết với bảng *customer* thông qua khóa ngoại `custkey`.
- Bảng *lineitem* liên kết với bảng *orders* thông qua khóa ngoại `orderkey`.
- Bảng *customer* liên kết với bảng *nation* thông qua khóa ngoại `nationkey`.
- Bảng *nation* liên kết với bảng *region* thông qua khóa ngoại `regionkey`.
- Bảng *partsupp* liên kết với bảng *part* và *supplier* thông qua các khóa ngoại `partkey` và `suppkey`.
- Bảng *supplier* liên kết với bảng *nation* thông qua khóa ngoại `nationkey`.

Cấu trúc dữ liệu này được thiết kế để hỗ trợ các truy vấn phân tích phức tạp, đặc biệt là các phép toán JOIN giữa các bảng sự kiện và bảng chiều.

#h2("Tạo các bộ truy vấn thử nghiệm")

Trong quá trình thực nghiệm, các bộ truy vấn thử nghiệm được tạo ra dựa trên hai bộ kit chuẩn là *TPC-H* và *TPC-DS*. Các bộ kit này cung cấp các truy vấn chuẩn hóa, được thiết kế để đánh giá hiệu suất của các hệ quản trị cơ sở dữ liệu trong các bài toán phân tích dữ liệu lớn. Dưới đây là chi tiết cách tạo các bộ truy vấn thử nghiệm:

#h3("Bộ truy vấn TPC-H")

- *Nguồn bộ kit*: Bộ truy vấn TPC-H được lấy từ [TPC-H Kit trên GitHub](https://github.com/gregrahn/tpch-kit).
- *Đặc điểm*:
  - Bộ truy vấn TPC-H bao gồm 22 truy vấn chuẩn hóa, được thiết kế để kiểm tra hiệu suất của các hệ quản trị cơ sở dữ liệu trong các bài toán phân tích dữ liệu truyền thống.
  - Các truy vấn này tập trung vào các phép toán JOIN phức tạp, tính toán tổng hợp (aggregation), và các phép lọc dữ liệu (filtering).
- *Cách sử dụng*:
  - Bộ truy vấn TPC-H được sử dụng chung cho tất cả các bộ dữ liệu (1GB, 5GB, 10GB, 20GB, 50GB, 100GB).
  - Điều này đảm bảo tính nhất quán trong việc so sánh hiệu suất giữa các kích thước dữ liệu khác nhau.
- *Triển khai*:
   - Bộ truy vấn TPC-H được sinh ra từ công cụ qgen trong tpch-kit, dựa trên file danh sách truy vấn (query.lst) và thư mục chứa các template (queries).
   - Các truy vấn được sinh ra có định dạng SQL chuẩn, và được điều chỉnh (nếu cần) để tương thích với cú pháp của hệ thống truy vấn đang được benchmark (ví dụ: sửa đổi một số cú pháp không tương thích với DuckDB hoặc HeavyDB).
  - Các truy vấn được lưu trong thư mục `sql/queries/` và được thực thi tuần tự trên các bộ dữ liệu khác nhau.

#h3("Bộ truy vấn TPC-DS")

- *Nguồn bộ kit*: Bộ truy vấn TPC-DS được lấy từ [TPC-DS Kit trên GitHub](https://github.com/gregrahn/tpcds-kit).
- *Đặc điểm*:
  - Bộ truy vấn TPC-DS bao gồm 99 truy vấn chuẩn hóa, được thiết kế để kiểm tra hiệu suất của các hệ quản trị cơ sở dữ liệu trong môi trường kho dữ liệu doanh nghiệp.
  - Các truy vấn này tập trung vào các bài toán phân tích phức tạp, bao gồm các phép toán JOIN đa chiều, tính toán tổng hợp, và các phép lọc dữ liệu phức tạp.
- *Cách sử dụng*:
  - Đối với TPC-DS, mỗi bộ dữ liệu (1GB, 5GB, 10GB, 20GB, 50GB, 100GB) sẽ có một bộ truy vấn tương ứng.
  - Điều này đảm bảo rằng các truy vấn được tối ưu hóa cho từng kích thước dữ liệu cụ thể, phản ánh đúng thực tế khi triển khai các bài toán phân tích dữ liệu lớn.
- *Triển khai*:
  - Các truy vấn được sinh tự động bằng cách sử dụng script `dsqgen` trong bộ kit TPC-DS.
  - Ví dụ, để tạo bộ truy vấn cho bộ dữ liệu 10GB, lệnh sau được sử dụng:
    ```bash
    ./dsqgen -DIRECTORY ../query_templates -INPUT ../query_templates/templates.lst -SCALE 10 -OUTPUT_DIR ../queries_10gb
    ```
  - Các truy vấn được lưu trong thư mục tương ứng, ví dụ: `queries_1gb/`, `queries_10gb/`, `queries_100gb/`.

#h3("So sánh cách tạo bộ truy vấn giữa TPC-H và TPC-DS")

- *TPC-H*:
  - Sử dụng chung một bộ truy vấn cho tất cả các kích thước dữ liệu.
  - Phù hợp với các bài toán phân tích truyền thống, nơi các truy vấn không phụ thuộc vào kích thước dữ liệu.
- *TPC-DS*:
  - Tạo bộ truy vấn riêng cho từng kích thước dữ liệu.
  - Phù hợp với các bài toán phân tích phức tạp, nơi các truy vấn cần được tối ưu hóa cho từng kích thước dữ liệu cụ thể.

#h3("Kết luận")

Việc sử dụng hai bộ kit TPC-H và TPC-DS với cách tiếp cận khác nhau trong việc tạo bộ truy vấn giúp đảm bảo tính toàn diện trong quá trình đánh giá hiệu suất của hệ thống. TPC-H cung cấp một cách tiếp cận đơn giản và nhất quán, trong khi TPC-DS phản ánh các bài toán thực tế phức tạp hơn, yêu cầu tối ưu hóa truy vấn theo kích thước dữ liệu.

#h2("Cách triển khai benchmark")

#h3("Benchmark trên DuckDB")

Một hệ thống benchmark tự động đã được xây dựng để đánh giá hiệu năng DuckDB một cách khoa học, khách quan và dễ tái tạo trên các máy ảo AWS, tạo nền tảng so sánh với HeavyDB.

#h4("Quy trình thực hiện benchmark")

- *Cài đặt DuckDB*:
   - Sử dụng script `install_duckdb.sh` để cài đặt DuckDB trên hệ thống.
   - Script này đảm bảo phiên bản DuckDB được cài đặt là phiên bản mới nhất và ổn định.

- *Chuẩn bị dữ liệu và chạy benchmark*:
   - Sử dụng script chính `main.sh` để lấy dữ liệu đã được tạo sẵn và tiến hành benchmark.
   - Cú pháp sử dụng: `./main.sh <type> <scale_factor> <num_runs> <aws_instance>`
     - `type`: `1` cho TPC-H, `2` cho TPC-DS
     - `scale_factor`: Kích thước bộ dữ liệu (ví dụ: 1, 5, 10, 20, 30, 50, 100)
     - `num_runs`: Số lần lặp lại benchmark để đảm bảo kết quả ổn định
     - `aws_instance`: Loại instance AWS đang sử dụng (ví dụ: on_c7a_8xlarge, on_g4dn_xlarge)

  - *Vị trí dữ liệu*:
    - Dữ liệu cho TPC-H được lưu tại: `/mnt/data/storage/tpch/<scale_factor>GB.duckdb`
    - Dữ liệu cho TPC-DS được lưu tại: `/mnt/data/storage/tpcds/<scale_factor>GB.duckdb`

  - *Vị trí file truy vấn (các file tương tự như của HeavyDB)*:
    - Các truy vấn TPC-H: `tpc-h/sql/queries_<scale_factor>/`
    - Các truy vấn TPC-DS: `tpc-ds/sql/query<scale_factor>/splited/`

- *Thực thi benchmark*:
   - Script `benchmark.sh` được gọi tự động bởi `main.sh` cho mỗi lần chạy.
   - Có thể chạy trực tiếp script này với cú pháp: `./process/benchmark.sh <type> <scale_factor> <run_number> <aws_instance>`

- *Lưu trữ kết quả*:
   - Kết quả benchmark được lưu tại thư mục `../benchmark_result/<aws_instance>/duckdb/`.
   - Định dạng kết quả bao gồm thời gian thực thi của từng truy vấn và tổng thời gian chạy.

#h4("Ví dụ thực hiện")

Ví dụ, để thực hiện benchmark TPC-H với scale factor 10, lặp lại 3 lần trên instance c7a.8xlarge, sử dụng lệnh:

```bash
./main.sh 1 10 3 on_c7a_8xlarge
```

Lệnh này sẽ:
- Kiểm tra xem dữ liệu TPC-H với scale factor 10 đã tồn tại chưa
- Nếu chưa, script sẽ tự động tạo dữ liệu
- Thực hiện 3 lần benchmark trên bộ dữ liệu này
- Lưu kết quả vào thư mục `../benchmark_result/on_c7a_8xlarge/duckdb/`

#h4("Ưu điểm của phương pháp benchmark")

- *Tự động hoá cao*: Toàn bộ quy trình từ cài đặt, chuẩn bị dữ liệu đến thực thi benchmark được tự động hóa, giảm thiểu sai sót do con người.
- *Khả năng tái tạo*: Có thể dễ dàng tái tạo kết quả benchmark trên các môi trường khác nhau.
- *Linh hoạt*: Hỗ trợ cả hai bộ benchmark phổ biến (TPC-H và TPC-DS) với nhiều kích thước dữ liệu khác nhau.
- *Phân loại kết quả*: Kết quả được tổ chức theo loại instance AWS, giúp dễ dàng so sánh hiệu năng giữa các cấu hình phần cứng khác nhau.
- *Độ tin cậy*: Việc chạy nhiều lần (thông qua tham số `num_runs`) giúp đảm bảo kết quả ổn định và đáng tin cậy.

#h2("Kết quả thực nghiệm")
#h3("Kết quả từ bộ benchmark TPC-H")
#h4("Đối với bộ dữ liệu 1GB")
#img("benchmark/average_case_tpc_h/average_case_tpc_h_1gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 1GB")<imgxxx1>
- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-H 1GB, kết quả benchmark cho thấy sự phân hóa về hiệu suất giữa DuckDB (CPU) và HeavyDB (GPU) tùy thuộc vào từng truy vấn. Không có một hệ thống nào chiếm ưu thế tuyệt đối ở quy mô dữ liệu này.

- *Phân tích Chi Tiết về Thời Gian Thực Thi Truy Vấn*:
  - *HeavyDB chậm hơn rất nhiều so với DuckDB (từ 4 lần trở lên):* Q04, Q16, Q18, Q20.
  - *HeavyDB chậm hơn đáng kể so với DuckDB (từ 2 đến dưới 4 lần):* Q02, Q17, Q22.
  - *HeavyDB chậm hơn so với DuckDB (từ 1 đến dưới 2 lần)* Q08.
  - *Thời gian thực thi gần như tương đương:* Q10.
  - *HeavyDB nhanh hơn so với DuckDB (từ 1 đến dưới 2 lần):* Q01, Q03, Q05, Q06, Q12, Q19.
  - *HeavyDB nhanh hơn đáng kể so với DuckDB (từ 1.5 lần trở lên):* Q07, Q09, Q13.

- *Nhận xét Chi Tiết*:
  - Các truy vấn Q04, Q16, Q18, Q20 cho thấy kiến trúc CPU của DuckDB và các kỹ thuật tối ưu hóa cho CPU hoạt động hiệu quả hơn nhiều so với HeavyDB (GPU) trên bộ dữ liệu 1GB.
  - Ở các truy vấn Q02, Q17, Q22, DuckDB vẫn nhanh hơn đáng kể, cho thấy có thể có những đặc điểm truy vấn mà CPU xử lý tốt hơn ở quy mô này.
  - HeavyDB chỉ chậm hơn một chút so với DuckDB ở Q08.
  - Hiệu suất của hai hệ thống là gần như tương đương ở Q10.
  - HeavyDB thể hiện lợi thế về tốc độ, dù không quá lớn, ở các truy vấn Q01, Q03, Q05, Q06, Q12, và Q19, gợi ý rằng kiến trúc GPU có thể khai thác được một mức độ song song hóa nhất định.
  - Đáng chú ý, HeavyDB nhanh hơn đáng kể ở các truy vấn Q07, Q09, và Q13. Điều này cho thấy có những loại truy vấn cụ thể mà khả năng song song hóa của GPU mang lại lợi ích rõ rệt, vượt qua được cả overhead ở quy mô dữ liệu 1GB.

- *Đánh giá*:
  - Benchmark trên bộ dữ liệu TPC-H 1GB cho thấy hiệu suất của DuckDB (CPU) và HeavyDB (GPU) phụ thuộc nhiều vào đặc điểm của từng truy vấn. Không có một hệ thống nào chiếm ưu thế chung ở quy mô này.
  - Kiến trúc CPU tỏ ra rất hiệu quả cho một số lượng lớn các truy vấn, đặc biệt là những truy vấn mà HeavyDB chậm hơn đáng kể.
  - Tuy nhiên, GPU cũng chứng minh khả năng tăng tốc đáng kể ở một số truy vấn khác, cho thấy tiềm năng khi xử lý các workload phù hợp.
  - Quy mô dữ liệu 1GB có thể là một yếu tố hạn chế khả năng thể hiện toàn diện sức mạnh của HeavyDB do các chi phí overhead liên quan đến GPU.

- *Kết luận*:
  Kết quả benchmark trên bộ dữ liệu TPC-H 1GB cho thấy sự phức tạp trong việc so sánh hiệu suất giữa kiến trúc CPU và GPU. Hiệu suất tối ưu phụ thuộc vào sự tương thích giữa đặc điểm truy vấn và kiến trúc phần cứng. Việc tiếp tục benchmark trên các bộ dữ liệu lớn hơn sẽ cung cấp cái nhìn rõ ràng hơn về khả năng mở rộng và ưu thế thực sự của HeavyDB (GPU) trong các bài toán phân tích dữ liệu lớn.


#h4("Đối với bộ dữ liệu 5GB")
#img("benchmark/average_case_tpc_h/average_case_tpc_h_5gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 5GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-H 5GB, kết quả benchmark tiếp tục cho thấy sự khác biệt về hiệu suất giữa DuckDB (CPU) và HeavyDB (GPU) tùy thuộc vào từng truy vấn. Tuy nhiên, so với bộ dữ liệu 1GB, có một sự chuyển dịch đáng chú ý, với HeavyDB thể hiện hiệu suất tốt hơn ở nhiều truy vấn hơn.

- *Phân tích Chi Tiết về Thời Gian Thực Thi Truy Vấn*:
  - *HeavyDB chậm hơn rất nhiều so với DuckDB (từ 4 lần trở lên):* Q04, Q16, Q18, Q20.
  - *HeavyDB chậm hơn đáng kể so với DuckDB (từ 2 đến dưới 4 lần):* Q17, Q22.
  - *HeavyDB chậm hơn so với DuckDB (từ 1 đến dưới 2 lần):* Q02, Q10.
  - *Thời gian thực thi gần như tương đương:* Q03.
  - *HeavyDB nhanh hơn so với DuckDB (từ 1 đến dưới 2 lần):* Q01, Q05, Q06, Q08, Q12, Q13.
  - *HeavyDB nhanh hơn đáng kể so với DuckDB (từ 2 lần trở lên):* Q07, Q09, Q19.

- *Nhận xét Chi Tiết*:
  - Các truy vấn Q04, Q16, Q18, Q20 vẫn cho thấy DuckDB (CPU) có hiệu suất vượt trội, với mức độ chênh lệch thậm chí còn lớn hơn so với bộ dữ liệu 1GB. Điều này gợi ý rằng những truy vấn này có thể đặc biệt phù hợp với cách CPU xử lý hoặc gặp phải những hạn chế trong việc tối ưu hóa trên GPU.
  - Ở các truy vấn Q17 và Q22, DuckDB vẫn nhanh hơn đáng kể, nhưng tỷ lệ chậm hơn của HeavyDB đã giảm so với 1GB, cho thấy có sự cải thiện về hiệu suất của GPU khi kích thước dữ liệu tăng lên.
  - HeavyDB chậm hơn DuckDB ở Q02 và Q10, nhưng mức độ chênh lệch đã giảm đáng kể so với benchmark 1GB. Q03 có thời gian thực thi gần như tương đương giữa hai hệ thống.
  - Đáng chú ý, HeavyDB (GPU) đã vượt trội hơn DuckDB (CPU) ở các truy vấn Q01, Q05, Q06, Q08, Q12, và Q13, với mức độ nhanh hơn từ nhẹ đến đáng kể. Điều này cho thấy khả năng song song hóa của GPU bắt đầu phát huy hiệu quả rõ rệt hơn khi kích thước dữ liệu tăng lên.
  - Các truy vấn Q07, Q09, và Q19 tiếp tục cho thấy HeavyDB nhanh hơn đáng kể so với DuckDB, với tỷ lệ tăng tốc cao hơn so với kết quả 1GB, củng cố thêm nhận định về sự phù hợp của GPU với các loại truy vấn này.

- *Đánh giá*:
  - Với bộ dữ liệu TPC-H 5GB, HeavyDB (GPU) bắt đầu thể hiện lợi thế hiệu suất rõ rệt hơn so với DuckDB (CPU) ở nhiều truy vấn. Số lượng truy vấn mà HeavyDB nhanh hơn đã tăng lên đáng kể so với 1GB.
  - Kiến trúc GPU cho thấy khả năng tận dụng tốt hơn khối lượng dữ liệu lớn hơn để tăng tốc độ xử lý ở nhiều loại truy vấn, đặc biệt là những truy vấn có tính song song hóa cao.
  - Tuy nhiên, kiến trúc CPU của DuckDB vẫn giữ vững ưu thế ở một số truy vấn nhất định, cho thấy sự khác biệt trong cách hai kiến trúc này xử lý các loại workload khác nhau.
  - Overhead của GPU dường như đã trở nên ít đáng kể hơn so với thời gian tính toán thực tế ở quy mô 5GB đối với nhiều truy vấn.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-H 5GB cho thấy HeavyDB (GPU) đang dần thể hiện ưu thế về hiệu suất so với DuckDB (CPU) trên nhiều truy vấn khi kích thước dữ liệu tăng lên. Tuy nhiên, DuckDB vẫn là một lựa chọn hiệu quả cho một số loại workload cụ thể. Xu hướng này nhấn mạnh tầm quan trọng của việc đánh giá hiệu suất trên nhiều quy mô dữ liệu để hiểu rõ khả năng của từng hệ thống. Các benchmark tiếp theo trên các bộ dữ liệu lớn hơn sẽ làm rõ hơn về điểm chuyển giao hiệu suất giữa CPU và GPU trong bối cảnh TPC-H.


#h4("Đối với bộ dữ liệu 10GB")
#img("benchmark/average_case_tpc_h/average_case_tpc_h_10gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 10GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Xu hướng hiệu suất đã bắt đầu thay đổi rõ rệt hơn so với các bộ dữ liệu nhỏ hơn. HeavyDB (GPU) tiếp tục cho thấy sự cải thiện hiệu suất đáng kể ở nhiều truy vấn khi kích thước dữ liệu tăng lên.

- *Nhận xét Chi Tiết*:
  - *HeavyDB tiếp tục cải thiện:* Số lượng truy vấn mà HeavyDB (GPU) nhanh hơn DuckDB (CPU) tiếp tục tăng lên. Mức độ tăng tốc ở nhiều truy vấn cũng trở nên rõ rệt hơn.
  - *Ưu thế rõ ràng của HeavyDB:* Các truy vấn Q01, Q03, Q05, Q06, Q07, Q08, Q09, Q12, Q13, và Q19 cho thấy HeavyDB nhanh hơn đáng kể, với tỷ lệ tăng tốc ngày càng cao.
  - *DuckDB vẫn giữ ưu thế ở một số truy vấn:* DuckDB vẫn nhanh hơn ở các truy vấn Q02, Q04, Q10, Q16, Q17, Q18, Q20, và Q22. Tuy nhiên, mức độ chênh lệch có xu hướng tăng lên ở hầu hết các truy vấn này, cho thấy HeavyDB gặp khó khăn hơn với các loại workload này khi dữ liệu lớn hơn.
  - *Sự khác biệt ngày càng lớn ở các truy vấn "khó" cho GPU:* Thời gian thực thi của HeavyDB ở các truy vấn Q04, Q10, Q16, Q18, và Q20 tiếp tục tăng đáng kể so với DuckDB, cho thấy những truy vấn này có thể không tận dụng được kiến trúc GPU hoặc bị ảnh hưởng nặng nề bởi overhead ở quy mô này.

- *Đánh giá*:
  - Với kích thước dữ liệu 10GB, HeavyDB (GPU) đã trở thành lựa chọn hiệu quả hơn về hiệu suất cho đa số các truy vấn so với DuckDB (CPU). Lợi thế của GPU trong việc xử lý song song lượng lớn dữ liệu ngày càng rõ ràng.
  - Tuy nhiên, DuckDB (CPU) vẫn duy trì hiệu suất tốt hơn đáng kể ở một số truy vấn cụ thể, cho thấy sự khác biệt cơ bản trong cách hai hệ thống xử lý các loại workload khác nhau.
  - Sự gia tăng đáng kể về khoảng cách hiệu suất ở các truy vấn mà DuckDB nhanh hơn cho thấy có những giới hạn nhất định trong khả năng xử lý của HeavyDB (hoặc cách nó được tối ưu hóa) cho các loại truy vấn này khi dữ liệu lớn hơn.

- *Kết luận*:
  Ở quy mô dữ liệu 10GB, HeavyDB (GPU) đang dần khẳng định ưu thế về hiệu suất tổng thể so với DuckDB (CPU) trong benchmark TPC-H. Tuy nhiên, sự khác biệt lớn ở một số truy vấn vẫn cho thấy rằng CPU vẫn có vai trò quan trọng tùy thuộc vào đặc điểm của workload. Các benchmark trên các bộ dữ liệu lớn hơn nữa sẽ tiếp tục làm sáng tỏ xu hướng này.

#h4("Đối với bộ dữ liệu 20GB")
#img("benchmark/average_case_tpc_h/average_case_tpc_h_20gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 20GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-H 20GB, HeavyDB (GPU) tiếp tục cho thấy sự cải thiện vượt trội về hiệu suất so với các quy mô dữ liệu nhỏ hơn (1GB, 5GB, 10GB). Xu hướng này ngày càng rõ rệt, với HeavyDB vượt qua DuckDB (CPU) ở nhiều truy vấn hơn, chứng minh khả năng tận dụng song song hóa của GPU khi xử lý dữ liệu lớn.

- *Nhận xét Chi Tiết*:
  - *Truy vấn mà HeavyDB kém hiệu quả*: Truy vấn Q03 vẫn là một điểm yếu lớn của HeavyDB, với thời gian thực thi chậm hơn gần 5 lần so với DuckDB (925 ms so với 196.5 ms). Điều này cho thấy một số loại truy vấn vẫn không phù hợp với kiến trúc GPU hoặc bị ảnh hưởng bởi overhead lớn.
  
  - *Sự cải thiện đáng kể*: Ở Q01, chênh lệch đã giảm đáng kể so với các quy mô nhỏ hơn, với HeavyDB chỉ chậm hơn DuckDB khoảng 2.3 lần (so với 4 lần ở 1GB), cho thấy sự cải thiện rõ rệt của HeavyDB khi dữ liệu lớn hơn.
  
  - *Thu hẹp khoảng cách*: Các truy vấn như Q02 và Q12 cho thấy HeavyDB đang thu hẹp khoảng cách với DuckDB, với thời gian thực thi chỉ chậm hơn nhẹ (dưới 2 lần), một bước tiến lớn so với các bộ dữ liệu trước đó.
  
  - *Truy vấn cân bằng*: Q05 và Q07 có hiệu suất gần tương đương giữa hai hệ thống, cho thấy HeavyDB đã đạt được sự cân bằng ở một số truy vấn mà trước đây DuckDB chiếm ưu thế.
  
  - *Truy vấn HeavyDB vượt trội*: Đáng chú ý, HeavyDB vượt trội ở Q08 (nhanh hơn gần 2 lần), Q09 và Q19 (nhanh hơn hơn 1.5 lần), tiếp tục xu hướng cải thiện tốc độ ở các truy vấn mà GPU có thể khai thác tốt khả năng song song hóa.

- *Đánh giá*:
  - Với bộ dữ liệu TPC-H 20GB, HeavyDB (GPU) đã khẳng định ưu thế vượt trội hơn so với DuckDB (CPU) ở nhiều truy vấn, với số lượng truy vấn mà HeavyDB nhanh hơn tiếp tục tăng và mức độ tăng tốc ngày càng lớn.
  
  - Kiến trúc GPU của HeavyDB cho thấy khả năng xử lý song song hiệu quả hơn khi khối lượng dữ liệu tăng, đặc biệt ở các truy vấn như Q08, Q09, và Q19.
  
  - Overhead của GPU dường như đã được giảm thiểu đáng kể ở quy mô 20GB, giúp HeavyDB tận dụng tốt hơn sức mạnh tính toán song song.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-H 20GB cho thấy HeavyDB (GPU) tiếp tục cải thiện mạnh mẽ, vượt qua DuckDB (CPU) ở nhiều truy vấn hơn và với mức độ tăng tốc lớn hơn so với các quy mô dữ liệu trước đó. Xu hướng này khẳng định tiềm năng của HeavyDB trong việc xử lý dữ liệu lớn, đặc biệt khi khối lượng dữ liệu tăng lên.

#h4("Đối với bộ dữ liệu 30GB")
#img("benchmark/average_case_tpc_h/average_case_tpc_h_30gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 30GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-H 30GB, xu hướng hiệu suất của HeavyDB (GPU) đã đảo ngược hoàn toàn so với các quy mô dữ liệu nhỏ hơn (1GB, 5GB, 10GB, và 20GB). Nếu như HeavyDB từng cho thấy sự cải thiện ở các quy mô trước, thì tại 30GB, HeavyDB có thời gian thực thi truy vấn cao hơn đáng kể so với DuckDB (CPU) ở hầu hết các truy vấn. Điều này cho thấy HeavyDB đang gặp khó khăn nghiêm trọng trong việc xử lý dữ liệu lớn hơn, không tận dụng được lợi thế song song hóa của GPU như kỳ vọng.

- *Nhận xét Chi Tiết*:
  - *Điểm yếu lớn nhất*: Truy vấn Q03 là điểm yếu lớn nhất của HeavyDB, với thời gian thực thi lên đến 2186 ms, trong khi DuckDB chỉ mất 196.5 ms—chậm hơn gần 11 lần. Đây là một bước thụt lùi nghiêm trọng so với hiệu suất ở 20GB (925 ms so với 196.5 ms).
  
  - *Suy giảm hiệu suất rõ rệt*: Các truy vấn như Q08 (HeavyDB: 1457.5 ms, DuckDB: 609 ms) và Q13 (HeavyDB: 1419 ms, DuckDB: 481.5 ms) cũng cho thấy HeavyDB chậm hơn đáng kể, lần lượt khoảng 2.4 lần và 3 lần so với DuckDB, đánh dấu sự suy giảm hiệu suất rõ rệt so với quy mô 20GB (313 ms so với 609 ms ở Q08).
  
  - *Hiệu suất tương đương giảm*: Một số truy vấn như Q02, Q06, và Q07 có thời gian thực thi gần tương đương giữa hai hệ thống, nhưng HeavyDB không còn thể hiện lợi thế như ở các quy mô nhỏ hơn (ví dụ, Q02 tại 20GB: HeavyDB 80 ms, DuckDB 90 ms, nay tại 30GB: HeavyDB 126 ms, DuckDB 96 ms).
  
  - *Lợi thế giảm sút*: Ở các truy vấn mà HeavyDB từng nhanh hơn như Q09 (HeavyDB: 120 ms, DuckDB: 184.5 ms), mức độ cải thiện đã giảm mạnh và không đủ để bù đắp cho sự suy giảm ở các truy vấn khác, so với 20GB (các giá trị này không thay đổi nhưng tổng thể hiệu suất của HeavyDB đã giảm).

- *Đánh giá*:
  - *Giới hạn của phiên bản HeavyDB open-source*: HeavyDB đang sử dụng phiên bản open-source và miễn phí từ 2 năm trước (khoảng năm 2023). Phiên bản này có thể chưa được vá các lỗi quan trọng liên quan đến hiệu suất, đặc biệt khi xử lý khối lượng dữ liệu lớn như 30GB. Các lỗi chưa vá có thể bao gồm quản lý bộ nhớ GPU không hiệu quả, tối ưu hóa truy vấn kém, hoặc xung đột trong lập lịch tác vụ GPU, dẫn đến hiệu suất truy vấn không ổn định và suy giảm nghiêm trọng ở quy mô này.
  
  - *Độ phức tạp tăng cao ở quy mô 30GB*: Với dữ liệu 30GB, các truy vấn TPC-H trở nên phức tạp hơn, đòi hỏi khả năng quản lý tài nguyên vượt trội. Phiên bản HeavyDB cũ dường như không thể xử lý hiệu quả các tác vụ này, dẫn đến thời gian thực thi tăng vọt, đặc biệt ở các truy vấn như Q03 (tăng từ 925 ms ở 20GB lên 2186 ms ở 30GB).
  
  - *Overhead của GPU trở nên rõ rệt*: Ở quy mô dữ liệu lớn hơn, overhead liên quan đến việc chuyển dữ liệu giữa CPU và GPU, cũng như lập lịch tác vụ trên GPU, trở thành nút thắt cổ chai nghiêm trọng. Phiên bản HeavyDB cũ không được tối ưu hóa để giảm thiểu các chi phí này, khiến hiệu suất giảm mạnh so với DuckDB (ví dụ, Q13 tăng từ 247.5 ms ở 20GB lên 1419 ms ở 30GB).
  
  - *Ưu thế của DuckDB trên CPU*: DuckDB, với kiến trúc CPU được tối ưu hóa liên tục và cập nhật thường xuyên, tỏ ra vượt trội ở quy mô 30GB. DuckDB tận dụng tốt RAM và xử lý dữ liệu theo cột, giúp giảm thời gian thực thi, đặc biệt ở các truy vấn phức tạp mà HeavyDB không thể xử lý hiệu quả (như Q03, giữ ổn định ở mức 196.5 ms từ 20GB đến 30GB).

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-H 30GB cho thấy HeavyDB (GPU) đã chạm đến giới hạn hiệu suất của phiên bản open-source từ 2 năm trước. Xu hướng đảo ngược này, với HeavyDB chậm hơn đáng kể so với DuckDB (CPU), khẳng định rằng các lỗi chưa vá và thiếu tối ưu hóa trong phiên bản HeavyDB cũ đang cản trở khả năng xử lý dữ liệu lớn. Để cải thiện hiệu suất, cần nâng cấp lên phiên bản HeavyDB mới hơn với các bản vá lỗi và tối ưu hóa GPU tốt hơn.

#h3("Kết quả từ bộ benchmark TPC-DS")
#import "thucNghiem_tpcds.typ"

#h2("Kết luận")
#h2("Hướng phát triển")
