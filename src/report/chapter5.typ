#import "template.typ": *
#import "util.typ": *
#import "state.typ": bib_state
#context bib_state.get()

#h1("KẾT LUẬN VÀ KIẾN NGHỊ")

#h2("Kết luận")
Nghiên cứu đã thực hiện so sánh hiệu năng giữa HeavyDB (GPU) và DuckDB (CPU) trên hai bộ benchmark phổ biến là TPC-H và TPC-DS với các kích thước dữ liệu từ 1GB, 2GB, 5GB, 10GB đến 20GB. Kết quả cho thấy GPU (HeavyDB) vượt trội trong các truy vấn phức tạp và dữ liệu lớn nhờ khả năng xử lý song song, trong khi CPU (DuckDB) phù hợp hơn với các truy vấn đơn giản và dữ liệu nhỏ nhờ tính ổn định và chi phí thấp. Tuy nhiên, GPU gặp hạn chế ở các truy vấn đơn giản do chi phí khởi tạo pipeline cao, còn CPU không hiệu quả khi kích thước dữ liệu và độ phức tạp tăng.

Nghiên cứu đã làm rõ sự khác biệt giữa GPU và CPU trong xử lý truy vấn cơ sở dữ liệu, đồng thời cung cấp cái nhìn sâu sắc về cách lựa chọn hệ quản trị cơ sở dữ liệu phù hợp với loại truy vấn và quy mô dữ liệu. Những kết quả này là cơ sở để tối ưu hóa hiệu năng của các hệ thống cơ sở dữ liệu trong tương lai.

#h2("Hạn chế của nghiên cứu")
*Phạm vi dữ liệu và hệ quản trị cơ sở dữ liệu:*

Nghiên cứu chỉ tập trung vào hai hệ quản trị cơ sở dữ liệu là HeavyDB và DuckDB, chưa bao quát các hệ thống khác như PostgreSQL, MySQL, hay các hệ thống GPU-based khác.
Dữ liệu thử nghiệm chỉ giới hạn trong các bộ benchmark TPC-H và TPC-DS, chưa kiểm tra trên các tập dữ liệu thực tế hoặc các loại dữ liệu phi cấu trúc. \

*Tối ưu hóa hệ thống:*

HeavyDB chưa được tối ưu hóa hoàn toàn cho các truy vấn đơn giản, dẫn đến hiệu năng chưa ổn định ở một số trường hợp.
DuckDB chưa được thử nghiệm với các chiến lược tối ưu hóa nâng cao để cải thiện hiệu năng trên dữ liệu lớn. \

*Hạn chế về phần cứng:*

Kết quả phụ thuộc vào cấu hình phần cứng cụ thể, đặc biệt là GPU. Các hệ thống khác nhau có thể cho ra kết quả khác biệt.
#h2("Kiến nghị")
*Mở rộng nghiên cứu:*

Thực hiện benchmark trên nhiều hệ quản trị cơ sở dữ liệu khác như PostgreSQL, MySQL, hoặc các hệ thống GPU-based khác để có cái nhìn toàn diện hơn.
Kiểm tra hiệu năng trên các tập dữ liệu thực tế hoặc các loại dữ liệu phi cấu trúc để đánh giá khả năng ứng dụng trong thực tế. \

*Tối ưu hóa hệ thống:*

Tối ưu hóa HeavyDB để giảm chi phí khởi tạo pipeline trên GPU, giúp cải thiện hiệu năng ở các truy vấn đơn giản.
Nghiên cứu các chiến lược tối ưu hóa truy vấn cho DuckDB để cải thiện hiệu năng khi xử lý dữ liệu lớn. \

*Đánh giá thêm về phần cứng:*

Thử nghiệm trên các cấu hình phần cứng khác nhau, bao gồm các GPU thế hệ mới, để đánh giá khả năng mở rộng và hiệu năng của HeavyDB.
So sánh hiệu năng trên các hệ thống đa GPU hoặc các hệ thống CPU đa lõi để đánh giá khả năng xử lý song song. \

*Ứng dụng thực tế:*

Đề xuất sử dụng GPU (HeavyDB) cho các hệ thống phân tích dữ liệu lớn, yêu cầu xử lý truy vấn phức tạp.
Sử dụng CPU (DuckDB) cho các hệ thống nhỏ gọn, chi phí thấp, hoặc các ứng dụng yêu cầu xử lý truy vấn đơn giản.