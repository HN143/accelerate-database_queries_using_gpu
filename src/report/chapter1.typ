#import "template.typ": *
#import "util.typ": *
#import "state.typ": bib_state
#context bib_state.get()

#h1("Mở đầu")

#h2("Lý do lựa chọn đề tài")
Trong thời đại công nghệ 4.0, dữ liệu lớn (Big Data) đóng vai trò quan trọng trong nhiều lĩnh vực như thương mại điện tử, tài chính, khoa học dữ liệu và trí tuệ nhân tạo. Việc xử lý và phân tích dữ liệu lớn một cách hiệu quả trở thành yếu tố quyết định đến khả năng khai thác thông tin và đưa ra quyết định kinh doanh.

Công nghệ xử lý dữ liệu truyền thống dựa trên CPU (Central Processing Unit) đã đạt đến giới hạn về hiệu suất khi đối mặt với khối lượng dữ liệu khổng lồ. Trong khi đó, GPU (Graphics Processing Unit) đã phát triển mạnh mẽ không chỉ trong lĩnh vực đồ họa mà còn được ứng dụng rộng rãi trong các tác vụ tính toán song song, bao gồm xử lý truy vấn cơ sở dữ liệu.

Việc so sánh hiệu suất giữa CPU và GPU trong xử lý truy vấn cơ sở dữ liệu là một vấn đề quan trọng, giúp tìm ra giải pháp tối ưu cho các hệ thống phân tích dữ liệu. DuckDB là một hệ quản trị cơ sở dữ liệu hiện đại chạy trên CPU, trong khi HeavyDB (trước đây là OmniSciDB) tận dụng sức mạnh của GPU để tăng tốc truy vấn. Do đó, nghiên cứu này sẽ đánh giá chi tiết sự khác biệt về hiệu suất giữa hai hệ thống này, từ đó đưa ra nhận định về lợi ích của GPU trong việc tối ưu hóa truy vấn dữ liệu.

#h2("Mục tiêu nghiên cứu")
- Chứng minh rằng việc sử dụng GPU có thể cải thiện hiệu suất truy vấn cơ sở dữ liệu so với CPU.

- So sánh hiệu suất giữa DuckDB (hệ quản trị cơ sở dữ liệu sử dụng CPU) và HeavyDB (hệ quản trị cơ sở dữ liệu hỗ trợ GPU), từ đó đánh giá sự khác biệt về tốc độ xử lý và khả năng tối ưu hóa.

- Xác định các trường hợp mà GPU có lợi thế hơn so với CPU trong quá trình thực thi truy vấn dữ liệu.

#h2("Câu hỏi nghiên cứu")
- GPU có thực sự giúp tăng tốc độ truy vấn cơ sở dữ liệu nhanh hơn so với CPU không?

- Trong những trường hợp nào HeavyDB (GPU) vượt trội hơn so với DuckDB (CPU)?

- Những yếu tố nào ảnh hưởng đến hiệu suất truy vấn khi sử dụng GPU thay vì CPU?

- Khi nào việc sử dụng GPU trở nên không hiệu quả hoặc kém tối ưu so với CPU?

#h2("Phạm vi nghiên cứu")
- Công cụ được nghiên cứu: DuckDB (chủ yếu hoạt động trên CPU) và HeavyDB (hỗ trợ GPU).

- Loại truy vấn: Các truy vấn phân tích phổ biến, bao gồm:

  - Truy vấn lọc dữ liệu (SELECT ... WHERE ...)

  - Truy vấn tổng hợp (GROUP BY, AGGREGATE FUNCTIONS)

  - Truy vấn kết nối (JOIN)

- Dữ liệu thử nghiệm: Bộ dữ liệu mẫu với kích thước từ vừa đến lớn (từ vài triệu đến hàng trăm triệu bản ghi).

- Hệ thống thử nghiệm: Thực hiện các thử nghiệm trên phần cứng có CPU và GPU mạnh mẽ để đảm bảo đánh giá công bằng.

- Chỉ số đánh giá: Thời gian thực thi truy vấn, mức sử dụng tài nguyên (CPU/GPU), và mức tiêu thụ bộ nhớ.

#h2("Ý nghĩa của nghiên cứu")
Đóng góp khoa học: Nghiên cứu cung cấp một phân tích chi tiết về lợi ích của GPU trong xử lý truy vấn cơ sở dữ liệu, giúp các nhà nghiên cứu hiểu rõ hơn về khả năng tăng tốc của GPU so với CPU trong các ứng dụng thực tế.

Ứng dụng thực tiễn: Kết quả của nghiên cứu có thể được áp dụng trong các hệ thống phân tích dữ liệu lớn, hỗ trợ doanh nghiệp và tổ chức lựa chọn công cụ phù hợp để tối ưu hóa hiệu suất và tiết kiệm chi phí.

Hỗ trợ ra quyết định: Các nhà phát triển phần mềm, kỹ sư dữ liệu và chuyên gia khoa học dữ liệu có thể sử dụng kết quả nghiên cứu này để lựa chọn nền tảng phù hợp khi xây dựng hệ thống phân tích dữ liệu.

Thúc đẩy cải tiến công nghệ: Nghiên cứu giúp các nhà phát triển hệ quản trị cơ sở dữ liệu có cái nhìn sâu sắc hơn về cách tối ưu hóa hiệu suất sử dụng GPU trong các hệ thống hiện đại.

#h2("Kết luận chương")

Chương 1 đã trình bày lý do lựa chọn đề tài, mục tiêu, câu hỏi, phạm vi và ý nghĩa của nghiên cứu. Nghiên cứu tập trung vào so sánh hiệu suất giữa DuckDB (CPU) và HeavyDB (GPU) nhằm đánh giá sự khác biệt trong xử lý truy vấn cơ sở dữ liệu. Các câu hỏi nghiên cứu được đặt ra sẽ làm rõ lợi ích, hạn chế của GPU và cung cấp cơ sở khoa học cho việc lựa chọn nền tảng phù hợp. Nội dung chương này là nền tảng để triển khai các phương pháp nghiên cứu và thực nghiệm trong các chương tiếp theo.