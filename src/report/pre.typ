#import "template.typ": *
#import "util.typ": *
#import "state.typ": bib_state
#context bib_state.get()

#h1("Lời cảm ơn", numbering: false)

Trước tiên, nhóm nghiên cứu xin gửi lời cảm ơn chân thành và sâu sắc nhất đến Ban Giám hiệu Học viện Kỹ thuật mật mã, các thầy cô trong khoa Công nghệ Thông tin đã tạo điều kiện thuận lợi và hỗ trợ nhóm trong suốt quá trình thực hiện đề tài nghiên cứu khoa học này.

Nhóm nghiên cứu xin đặc biệt cảm ơn *Ths.Cao Thanh Vinh*, giảng viên hướng dẫn, đã tận tình hướng dẫn, đóng góp ý kiến quý báu và định hướng nghiên cứu, giúp nhóm hoàn thành tốt đề tài *“Tăng tốc truy vấn cơ sở dữ liệu sử dụng GPU”*. Sự hỗ trợ và chỉ dẫn của cô là nguồn động lực lớn để nhóm vượt qua những khó khăn trong quá trình thực hiện.

Nhóm cũng xin gửi lời cảm ơn đến các bạn bè, anh chị đã chia sẻ kinh nghiệm, góp ý và hỗ trợ nhóm trong việc thu thập tài liệu, xây dựng hệ thống thử nghiệm và phân tích kết quả.

Cuối cùng, nhóm nghiên cứu xin cảm ơn gia đình đã luôn động viên, khích lệ và tạo điều kiện tốt nhất để nhóm tập trung hoàn thành đề tài này.

Nhóm nghiên cứu xin chân thành cảm ơn!

\

#[
  #set align(right)
  Hà Nội, ngày 12 tháng 04 năm 2025 \
  *Nhóm nghiên cứu* #h(50pt) \ \ \
  
]

#h1("Lời cam đoan", numbering: false)

Nhóm nghiên cứu xin cam đoan bài nghiên cứu khoa học với đề tài “Tăng tốc truy vấn cơ sở dữ liệu sử dụng GPU” là sản phẩm của riêng nhóm nghiên cứu; sản phẩm không sao chép từ bất kỳ nguồn nào. Nhóm nghiên cứu hoàn toàn chịu trách nhiệm về tính chính xác trong đề tài.
 \ \

#[
  #set align(right)
  Hà Nội, ngày 12 tháng 04 năm 2025 \
  *Nhóm nghiên cứu* #h(50pt) \ \ \
  
]

#h1("Mục lục", numbering: false)
#outline(
  title: none,
  depth: 3,
  indent: 0em,
)

#h1("Danh mục các ký hiệu, chữ viết tắt", numbering: false)

#tabl(
  columns: (auto, 1fr),
  [*Từ viết tắt*],
  [*Định nghĩa*],
  // [TMĐT],
  // [Thương mại điện tử],
  // [SSL],
  // [Secure Socket Layer],
  // [CSS],
  // [Cascading Style Sheets],
  // [HTML],
  // [HyperText Markup Language - Ngôn ngữ Đánh dấu Siêu văn bản],
  // [RWD],
  // [Responsive web design - Thiết kế responsive],
  // [URL],
  // [Uniform Resource Locator],
  // [PCI DSS],
  // [Payment Card Industry Data Security Standard],
  // [API],
  // [Application Programming Interface],
  // [DBMS],
  // [Database Management System - Hệ quản trị cơ sở dữ liệu],
  // [COD],
  // [Cash on delivery - Thanh toán khi nhận hàng],
  // [SQL],
  // [Structured Query Language],
  // [CSDL],
  // [Cơ sở dữ liệu],
  // [AES],
  // [Advanced Encryption Standard],
  // [JWT],
  // [JSON Web Token],
)

#h1("Danh mục bảng", numbering: false)
#par(
  first-line-indent: 0pt,
  outline(
    title: none,
    target: figure.where(kind: table),
  ),
)

#h1("Danh mục hình vẽ, đồ thị", numbering: false)

#par(
  first-line-indent: 0pt,
  outline(
    title: none,
    target: figure.where(kind: image),
  ),
)

#h1("Mở đầu", numbering: false)
Trong bối cảnh dữ liệu phát triển với tốc độ nhanh chóng và có xu hướng ngày càng lớn về quy mô và độ phức tạp, nhu cầu xử lý truy vấn cơ sở dữ liệu một cách hiệu quả và nhanh chóng trở nên cấp thiết hơn bao giờ hết. Các hệ thống truyền thống dựa trên CPU, mặc dù đã được tối ưu qua nhiều thế hệ, vẫn gặp khó khăn khi phải xử lý khối lượng lớn dữ liệu trong thời gian ngắn, đặc biệt đối với các tác vụ phân tích dữ liệu theo mô hình OLAP (Online Analytical Processing).

GPU (Graphics Processing Unit), với khả năng tính toán song song mạnh mẽ, đã chứng minh tiềm năng vượt trội trong việc tăng tốc các tác vụ tính toán chuyên sâu, không chỉ trong lĩnh vực đồ họa mà còn trong xử lý dữ liệu lớn. Việc ứng dụng GPU vào hệ quản trị cơ sở dữ liệu đã mở ra một hướng tiếp cận mới, cho phép tăng tốc đáng kể quá trình xử lý truy vấn, đặc biệt trong các bài toán phân tích dữ liệu phức tạp và có tính lặp cao.

Đề tài *“Tăng tốc truy vấn cơ sở dữ liệu sử dụng GPU”* được thực hiện nhằm mục tiêu khảo sát, thử nghiệm và đánh giá hiệu năng giữa hệ thống xử lý truy vấn dựa trên CPU và hệ thống tối ưu hóa cho GPU, từ đó đưa ra cái nhìn toàn diện về lợi ích và hạn chế của từng giải pháp. Các công cụ được lựa chọn cho nghiên cứu bao gồm DuckDB – đại diện tiêu biểu cho hệ quản trị cơ sở dữ liệu nhúng chạy trên CPU, và HeavyDB (trước đây là OmniSciDB) – một hệ quản trị tối ưu hóa cho GPU. Dữ liệu thử nghiệm được xây dựng dựa trên các chuẩn benchmark TPC-H và TPC-DS, đảm bảo tính khách quan và phổ quát trong quá trình đánh giá.

Kết quả nghiên cứu dự kiến sẽ cung cấp thông tin thực tiễn hữu ích cho việc lựa chọn nền tảng xử lý truy vấn phù hợp trong các hệ thống cơ sở dữ liệu hiện đại, đặc biệt trong bối cảnh gia tăng nhu cầu phân tích dữ liệu lớn và thời gian thực.