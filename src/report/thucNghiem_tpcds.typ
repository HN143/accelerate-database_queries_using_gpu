#import "template.typ": *
#import "util.typ": *
#import "state.typ": bib_state
#context bib_state.get()

#h3("Kết quả từ bộ benchmark TPC-DS")

#h4("Đối với bộ dữ liệu 1GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_1gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 1GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 1GB, kết quả benchmark cho thấy một sự cạnh tranh khá sát sao giữa DuckDB (CPU) và HeavyDB (GPU). TPC-DS với mô hình dữ liệu phức tạp hơn và các truy vấn đa dạng hơn TPC-H đã tạo ra một bức tranh khác về hiệu suất của hai hệ thống.

- *Phân tích Chi Tiết*:
  - *Các truy vấn DuckDB chiếm ưu thế*: DuckDB thể hiện hiệu suất vượt trội ở nhiều truy vấn phức tạp bao gồm các phép JOIN nhiều bảng và tính toán phân tích. Đặc biệt ở các truy vấn q03, q07, q19, và q27, DuckDB nhanh hơn HeavyDB từ 1.5 đến 3 lần.
  
  - *Các truy vấn HeavyDB chiếm ưu thế*: HeavyDB thể hiện hiệu suất tốt hơn ở các truy vấn có thể tận dụng tốt khả năng song song hóa của GPU như q01, q04, q10, và q32. Đặc biệt ở q32, HeavyDB nhanh hơn DuckDB gần 2 lần.
  
  - *Truy vấn có hiệu suất tương đương*: Một số truy vấn như q08, q15, q22 cho thấy hiệu suất gần như tương đương giữa hai hệ thống, với sự chênh lệch không đáng kể (dưới 10%).

- *Đánh giá*:
  - Ở quy mô dữ liệu 1GB, cả DuckDB và HeavyDB đều thể hiện được thế mạnh của mình trong các loại truy vấn khác nhau. DuckDB tận dụng tốt khả năng xử lý dữ liệu của CPU, đặc biệt là các kỹ thuật vector hóa, trong khi HeavyDB tận dụng song song hóa của GPU cho một số loại truy vấn cụ thể.
  
  - Overhead của GPU vẫn là một yếu tố đáng kể ở quy mô dữ liệu nhỏ, khiến HeavyDB không thể khai thác tối đa tiềm năng của mình.
  
  - Các truy vấn TPC-DS thường phức tạp và đa dạng hơn TPC-H, với nhiều phép JOIN, điều kiện lọc, và tính toán tổng hợp, tạo ra thách thức lớn hơn cho cả hai hệ thống.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 1GB cho thấy một sự cạnh tranh cân bằng hơn giữa DuckDB và HeavyDB so với TPC-H, với mỗi hệ thống có thế mạnh riêng trong các loại truy vấn khác nhau. Điều này nhấn mạnh tầm quan trọng của việc lựa chọn công nghệ phù hợp dựa trên đặc điểm workload cụ thể.

#h4("Đối với bộ dữ liệu 5GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_5gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 5GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 5GB, xu hướng hiệu suất đã bắt đầu thay đổi đáng kể. HeavyDB (GPU) bắt đầu thể hiện lợi thế rõ rệt hơn ở nhiều truy vấn, trong khi DuckDB (CPU) vẫn duy trì ưu thế ở một số truy vấn nhất định.

- *Phân tích Chi Tiết*:
  - *Sự cải thiện của HeavyDB*: Ở quy mô 5GB, HeavyDB đã cải thiện đáng kể hiệu suất ở nhiều truy vấn, đặc biệt là q01, q04, q10, và q32, với thời gian thực thi nhanh hơn DuckDB từ 1.5 đến 3 lần. Điều này cho thấy khả năng song song hóa của GPU bắt đầu phát huy hiệu quả khi kích thước dữ liệu tăng lên.
  
  - *DuckDB vẫn giữ lợi thế*: DuckDB vẫn duy trì hiệu suất tốt hơn ở các truy vấn phức tạp như q07, q19, và q27, nhưng khoảng cách hiệu suất đã giảm so với bộ dữ liệu 1GB.
  
  - *Sự thay đổi ở các truy vấn cân bằng*: Một số truy vấn như q08 và q15, vốn có hiệu suất gần tương đương ở 1GB, giờ đây HeavyDB đã bắt đầu thể hiện lợi thế nhẹ.

- *Đánh giá*:
  - Ở quy mô dữ liệu 5GB, HeavyDB đã bắt đầu thể hiện tiềm năng của GPU trong việc xử lý dữ liệu lớn. Overhead của GPU trở nên ít đáng kể hơn so với thời gian tính toán, cho phép HeavyDB tận dụng tốt hơn khả năng song song hóa.
  
  - DuckDB vẫn là một lựa chọn mạnh mẽ cho các truy vấn phức tạp với nhiều phép JOIN và tính toán tổng hợp, nhưng lợi thế này đang dần giảm đi khi kích thước dữ liệu tăng lên.
  
  - Mô hình dữ liệu phức tạp của TPC-DS tiếp tục tạo ra những thách thức khác nhau cho cả hai hệ thống, với HeavyDB dần thể hiện khả năng thích ứng tốt hơn khi quy mô dữ liệu tăng lên.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 5GB cho thấy HeavyDB (GPU) đang dần có lợi thế hơn so với DuckDB (CPU) khi kích thước dữ liệu tăng lên. Tuy nhiên, sự cân bằng vẫn còn khá rõ ràng, với mỗi hệ thống có thế mạnh riêng trong các loại truy vấn khác nhau.

#h4("Đối với bộ dữ liệu 10GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_10gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 10GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 10GB, xu hướng hiệu suất tiếp tục phát triển theo hướng có lợi cho HeavyDB (GPU). GPU đã bắt đầu thể hiện rõ ràng lợi thế xử lý song song ở quy mô dữ liệu lớn hơn, trong khi DuckDB (CPU) vẫn duy trì hiệu suất tốt ở một số truy vấn nhất định.

- *Phân tích Chi Tiết*:
  - *HeavyDB vượt trội*: Ở quy mô 10GB, HeavyDB đã thể hiện hiệu suất vượt trội ở hầu hết các truy vấn, với nhiều truy vấn nhanh hơn DuckDB từ 2 đến 4 lần. Đặc biệt ở các truy vấn q01, q04, q10, q32, HeavyDB thể hiện lợi thế rõ rệt.
  
  - *DuckDB vẫn có lợi thế ở một số truy vấn*: DuckDB vẫn duy trì hiệu suất tốt hơn ở một số truy vấn như q07 và q27, nhưng khoảng cách hiệu suất tiếp tục giảm so với các bộ dữ liệu nhỏ hơn.
  
  - *Sự chuyển đổi ở một số truy vấn*: Một số truy vấn mà DuckDB từng có lợi thế ở quy mô nhỏ hơn, như q19, giờ đây HeavyDB đã bắt kịp hoặc thậm chí vượt qua về hiệu suất.

- *Đánh giá*:
  - Ở quy mô dữ liệu 10GB, HeavyDB đã thể hiện rõ ràng tiềm năng của GPU trong việc xử lý dữ liệu lớn. Overhead của GPU trở nên không đáng kể so với lợi ích từ xử lý song song, cho phép HeavyDB tận dụng tối đa sức mạnh của GPU.
  
  - DuckDB vẫn là một lựa chọn có giá trị cho một số loại truy vấn cụ thể, nhưng lợi thế này đang ngày càng giảm khi kích thước dữ liệu tăng lên.
  
  - Mô hình dữ liệu phức tạp của TPC-DS với nhiều bảng sự kiện và bảng chiều tiếp tục tạo ra những thách thức khác nhau cho cả hai hệ thống, nhưng HeavyDB (GPU) dường như đang thích nghi tốt hơn với sự gia tăng về kích thước dữ liệu.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 10GB cho thấy HeavyDB (GPU) đã bắt đầu thể hiện rõ ràng lợi thế hiệu suất so với DuckDB (CPU) ở hầu hết các truy vấn. Xu hướng này khẳng định giá trị của GPU trong việc xử lý các workload phân tích dữ liệu lớn, đặc biệt là những workload có thể tận dụng tốt khả năng song song hóa.

#h4("Đối với bộ dữ liệu 20GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_20gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 20GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 20GB, xu hướng hiệu suất tiếp tục phát triển mạnh mẽ theo hướng có lợi cho HeavyDB (GPU). Ở quy mô dữ liệu này, GPU đã thể hiện lợi thế vượt trội ở hầu hết các truy vấn, cho thấy khả năng xử lý hiệu quả khối lượng dữ liệu lớn.

- *Phân tích Chi Tiết*:
  - *HeavyDB chiếm ưu thế áp đảo*: Ở quy mô 20GB, HeavyDB đã thể hiện hiệu suất vượt trội ở đại đa số các truy vấn, với nhiều truy vấn nhanh hơn DuckDB từ 3 đến 5 lần. Đặc biệt ở các truy vấn q01, q04, q10, q22, và q32, HeavyDB thể hiện lợi thế cực kỳ rõ rệt.
  
  - *DuckDB giảm lợi thế*: Số lượng truy vấn mà DuckDB vẫn duy trì hiệu suất tốt hơn đã giảm đáng kể, chỉ còn một vài truy vấn như q27 có hiệu suất gần tương đương hoặc nhỉnh hơn một chút so với HeavyDB.
  
  - *Sự chuyển đổi hoàn toàn*: Nhiều truy vấn mà DuckDB từng có lợi thế ở quy mô nhỏ hơn, như q07 và q19, giờ đây HeavyDB đã vượt qua về hiệu suất một cách rõ rệt.

- *Đánh giá*:
  - Ở quy mô dữ liệu 20GB, HeavyDB đã khẳng định rõ ràng tiềm năng của GPU trong việc xử lý dữ liệu lớn. Sức mạnh song song hóa của GPU đã được phát huy tối đa, cho phép HeavyDB xử lý hiệu quả các truy vấn phức tạp trên khối lượng dữ liệu lớn.
  
  - DuckDB vẫn là một lựa chọn có giá trị cho một số loại truy vấn cụ thể, nhưng lợi thế này đã giảm đáng kể khi kích thước dữ liệu tăng lên.
  
  - Mô hình dữ liệu phức tạp của TPC-DS tiếp tục tạo ra những thách thức đa dạng, nhưng HeavyDB (GPU) đã thể hiện khả năng thích nghi vượt trội với sự gia tăng kích thước dữ liệu.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 20GB đã khẳng định rõ ràng lợi thế hiệu suất của HeavyDB (GPU) so với DuckDB (CPU) ở hầu hết các truy vấn. Xu hướng này càng nhấn mạnh giá trị của GPU trong việc xử lý các workload phân tích dữ liệu lớn, đặc biệt khi kích thước dữ liệu tiếp tục tăng.

#h4("Đối với bộ dữ liệu 30GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_30gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 30GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 30GB, một sự thay đổi đáng chú ý đã xảy ra. Khác với xu hướng từ 1GB đến 20GB, tại 30GB, hiệu suất của HeavyDB (GPU) đã bắt đầu suy giảm ở nhiều truy vấn, và DuckDB (CPU) đã lấy lại một số lợi thế. Điều này cho thấy HeavyDB đang bắt đầu gặp phải những giới hạn hoặc thách thức mới khi xử lý dữ liệu ở quy mô lớn hơn.

- *Phân tích Chi Tiết*:
  - *Sự suy giảm hiệu suất của HeavyDB*: Ở quy mô 30GB, hiệu suất của HeavyDB đã suy giảm đáng kể ở nhiều truy vấn so với mức 20GB. Đặc biệt ở các truy vấn q04, q10, và q32, thời gian thực thi đã tăng lên đáng kể.
  
  - *DuckDB lấy lại lợi thế*: DuckDB đã thể hiện hiệu suất tốt hơn ở nhiều truy vấn hơn so với mức 20GB, đặc biệt là các truy vấn q07, q19, và q27, với thời gian thực thi nhanh hơn HeavyDB đáng kể.
  
  - *Truy vấn vẫn có lợi cho HeavyDB*: Mặc dù có sự suy giảm, HeavyDB vẫn duy trì hiệu suất tốt hơn ở một số truy vấn như q01 và q22, nhưng khoảng cách hiệu suất đã giảm đáng kể so với mức 20GB.

- *Đánh giá*:
  - Ở quy mô dữ liệu 30GB, HeavyDB đang bắt đầu gặp phải những giới hạn kỹ thuật của phiên bản open-source hiện tại (từ khoảng 2 năm trước). Các vấn đề như quản lý bộ nhớ GPU không hiệu quả, tối ưu hóa truy vấn kém, hoặc các vấn đề kỹ thuật khác có thể đang ảnh hưởng đến hiệu suất.
  
  - DuckDB, với kiến trúc được tối ưu hóa liên tục và cập nhật thường xuyên, đã thể hiện khả năng xử lý dữ liệu lớn một cách ổn định hơn ở quy mô 30GB.
  
  - Mô hình dữ liệu phức tạp của TPC-DS với nhiều bảng sự kiện và bảng chiều tạo ra những thách thức lớn cho cả hai hệ thống ở quy mô 30GB, nhưng DuckDB (CPU) dường như đang thích nghi tốt hơn với sự gia tăng về kích thước dữ liệu.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 30GB cho thấy sự thay đổi đáng chú ý trong xu hướng hiệu suất. HeavyDB (GPU) đã bắt đầu gặp phải những giới hạn kỹ thuật, trong khi DuckDB (CPU) tiếp tục thể hiện sự ổn định. Điều này nhấn mạnh tầm quan trọng của việc cập nhật và tối ưu hóa liên tục các hệ thống quản lý cơ sở dữ liệu, đặc biệt khi xử lý khối lượng dữ liệu ngày càng lớn.

#h4("Đối với bộ dữ liệu 50GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_50gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 50GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 50GB, xu hướng suy giảm hiệu suất của HeavyDB (GPU) tiếp tục rõ rệt. DuckDB (CPU) đã thể hiện hiệu suất vượt trội ở hầu hết các truy vấn, cho thấy phiên bản HeavyDB open-source hiện tại đang gặp khó khăn nghiêm trọng khi xử lý dữ liệu ở quy mô này.

- *Phân tích Chi Tiết*:
  - *Sự suy giảm mạnh của HeavyDB*: Ở quy mô 50GB, hiệu suất của HeavyDB đã suy giảm mạnh ở hầu hết các truy vấn. Nhiều truy vấn có thời gian thực thi tăng gấp 2-3 lần so với mức 30GB, đặc biệt là các truy vấn q04, q10, và q32.
  
  - *DuckDB chiếm ưu thế áp đảo*: DuckDB đã thể hiện hiệu suất vượt trội ở đại đa số các truy vấn, với thời gian thực thi nhanh hơn HeavyDB từ 2 đến 5 lần ở nhiều truy vấn.
  
  - *Một số truy vấn HeavyDB vẫn cạnh tranh*: Mặc dù có sự suy giảm chung, HeavyDB vẫn duy trì hiệu suất cạnh tranh ở một số ít truy vấn như q01 và q22, nhưng khoảng cách hiệu suất đã giảm đáng kể so với các mức dữ liệu nhỏ hơn.

- *Đánh giá*:
  - Ở quy mô dữ liệu 50GB, HeavyDB đã gặp phải những giới hạn nghiêm trọng của phiên bản open-source hiện tại. Các vấn đề như quản lý bộ nhớ GPU không hiệu quả, tối ưu hóa truy vấn kém, và overhead lớn trong việc chuyển dữ liệu giữa CPU và GPU đã trở thành những nút thắt cổ chai quan trọng.
  
  - DuckDB, với cách tiếp cận mạnh mẽ về xử lý dữ liệu theo cột và các kỹ thuật vector hóa hiệu quả, đã thể hiện khả năng xử lý dữ liệu lớn một cách ổn định và hiệu quả ở quy mô 50GB.
  
  - Mô hình dữ liệu phức tạp của TPC-DS với nhiều bảng sự kiện và bảng chiều tạo ra những thách thức cực kỳ lớn cho HeavyDB ở quy mô 50GB, trong khi DuckDB (CPU) vẫn có thể xử lý một cách hiệu quả.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 50GB cho thấy sự suy giảm mạnh mẽ về hiệu suất của HeavyDB (GPU) so với DuckDB (CPU). Điều này nhấn mạnh sự cần thiết phải cập nhật và tối ưu hóa HeavyDB để có thể xử lý hiệu quả các workload phân tích dữ liệu lớn hơn. Trong khi đó, DuckDB tiếp tục chứng minh giá trị của mình như một giải pháp CPU hiệu quả cho phân tích dữ liệu lớn.

#h3("So sánh xu hướng hiệu suất giữa TPC-H và TPC-DS")

- *Điểm tương đồng*:
  - Cả hai bộ benchmark đều cho thấy xu hướng tương tự về hiệu suất từ 1GB đến 20GB, với HeavyDB (GPU) dần cải thiện và vượt qua DuckDB (CPU) khi kích thước dữ liệu tăng lên.
  
  - Cả hai bộ benchmark đều thể hiện sự suy giảm hiệu suất của HeavyDB ở quy mô 30GB trở lên, cho thấy giới hạn của phiên bản open-source hiện tại.

- *Điểm khác biệt*:
  - TPC-DS, với mô hình dữ liệu phức tạp hơn và các truy vấn đa dạng hơn, tạo ra một bức tranh hiệu suất cân bằng hơn giữa hai hệ thống ở các quy mô dữ liệu nhỏ hơn (1GB, 5GB).
  
  - TPC-H có xu hướng phân hóa hiệu suất rõ rệt hơn giữa hai hệ thống, với một số truy vấn rõ ràng có lợi cho HeavyDB và một số khác có lợi cho DuckDB, ngay cả ở quy mô dữ liệu nhỏ.
  
  - Sự suy giảm hiệu suất của HeavyDB ở quy mô lớn (30GB trở lên) dường như nghiêm trọng hơn trong TPC-H so với TPC-DS, cho thấy sự khác biệt trong cách HeavyDB xử lý các loại workload khác nhau.

- *Đánh giá chung*:
  Cả hai bộ benchmark đều cho thấy tiềm năng lớn của GPU trong việc tăng tốc các truy vấn phân tích dữ liệu, đặc biệt khi kích thước dữ liệu đủ lớn để bù đắp overhead của GPU. Tuy nhiên, cả hai cũng chỉ ra giới hạn của phiên bản HeavyDB open-source hiện tại khi xử lý dữ liệu ở quy mô lớn hơn, nhấn mạnh sự cần thiết phải cập nhật và tối ưu hóa liên tục.
