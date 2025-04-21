#import "template.typ": *
#import "util.typ": *
#import "state.typ": bib_state
#context bib_state.get()

#h3("Kết quả từ bộ benchmark TPC-DS")

#h4("Đối với bộ dữ liệu 1GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_1gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 1GB")

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 1GB, HeavyDB (GPU) hầu như chậm hơn đáng kể so với DuckDB (CPU) ở tất cả các truy vấn được kiểm tra. Biểu đồ cho thấy sự chênh lệch lớn về thời gian thực thi, với HeavyDB thường mất thời gian gấp nhiều lần so với DuckDB. Điều này cho thấy HeavyDB không tận dụng được lợi thế song song hóa của GPU ở quy mô dữ liệu này, và hiệu suất của nó đang bị hạn chế nghiêm trọng.

- *Nhận xét Chi Tiết*:
  - *Truy vấn Q53*: Là điểm yếu lớn nhất của HeavyDB, với thời gian thực thi lên đến 346 ms, trong khi DuckDB chỉ mất 19.5 ms—chậm hơn gần 18 lần.
  - *Các truy vấn khác*: Q03 (HeavyDB: 172 ms, DuckDB: 14.5 ms), Q55 (HeavyDB: 234.5 ms, DuckDB: 16.5 ms), và Q99 (HeavyDB: 119.5 ms, DuckDB: 17.5 ms) cũng cho thấy HeavyDB chậm hơn đáng kể, lần lượt khoảng 12 lần, 14 lần và 7 lần so với DuckDB.
  - *Truy vấn có mức chênh lệch thấp hơn*: Q12 (HeavyDB: 69 ms, DuckDB: 15 ms) và Q62 (HeavyDB: 59.5 ms, DuckDB: 14 ms) vẫn cho thấy HeavyDB chậm hơn khoảng 4-5 lần.
  - *Truy vấn thời gian thấp*: Ngay cả ở các truy vấn như Q46 (HeavyDB: 71 ms, DuckDB: 19 ms), HeavyDB vẫn chậm hơn gần 4 lần, khẳng định sự vượt trội của DuckDB trên toàn bộ tập hợp truy vấn.

- *Đánh giá*:
  - *Giới hạn của phiên bản HeavyDB open-source*: HeavyDB đang sử dụng phiên bản open-source từ 2 năm trước (khoảng năm 2023), có thể chưa được vá các lỗi quan trọng liên quan đến hiệu suất, đặc biệt khi xử lý các truy vấn phức tạp của TPC-DS. Các lỗi này bao gồm quản lý bộ nhớ GPU không hiệu quả, tối ưu hóa truy vấn kém, hoặc xung đột trong lập lịch tác vụ GPU.
  - *Đặc điểm của TPC-DS và quy mô dữ liệu nhỏ*: TPC-DS bao gồm các truy vấn phức tạp với nhiều phép JOIN và GROUP BY. Ở quy mô 1GB, overhead của GPU (như việc chuyển dữ liệu giữa CPU và GPU) có thể vượt quá lợi ích của song song hóa, đặc biệt với phiên bản HeavyDB cũ không được tối ưu hóa.
  - *Overhead của GPU ở quy mô nhỏ*: Với dữ liệu chỉ 1GB, khối lượng công việc không đủ lớn để GPU phát huy lợi thế song song hóa. Các chi phí như khởi tạo GPU, chuyển dữ liệu, và lập lịch tác vụ trên GPU trở thành nút thắt cổ chai, khiến HeavyDB không cạnh tranh được với DuckDB.
  - *Ưu thế của DuckDB trên CPU*: DuckDB, với kiến trúc CPU được tối ưu hóa liên tục và cập nhật thường xuyên, tận dụng tốt RAM và xử lý dữ liệu theo cột, giúp giảm thời gian thực thi, đặc biệt ở các truy vấn phức tạp của TPC-DS.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 1GB cho thấy HeavyDB (GPU) chậm hơn đáng kể so với DuckDB (CPU) ở tất cả các truy vấn, khẳng định rằng phiên bản open-source từ 2 năm trước của HeavyDB đang gặp giới hạn nghiêm trọng về hiệu suất. Các lỗi chưa vá và thiếu tối ưu hóa trong phiên bản này cản trở khả năng xử lý các truy vấn phức tạp, đặc biệt ở quy mô dữ liệu nhỏ. Để cải thiện hiệu suất, cần nâng cấp lên phiên bản HeavyDB mới hơn với các bản vá lỗi và tối ưu hóa GPU tốt hơn.

#h4("Đối với bộ dữ liệu 5GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_5gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 5GB")

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 5GB, HeavyDB (GPU) vẫn chậm hơn đáng kể so với DuckDB (CPU) ở hầu hết các truy vấn. Tuy nhiên, so với quy mô 1GB, HeavyDB có sự cải thiện nhẹ về hiệu suất ở một số truy vấn, dù vẫn không cạnh tranh được với DuckDB.

- *Nhận xét Chi Tiết*:
  - *Truy vấn Q53*: Vẫn là điểm yếu lớn của HeavyDB, với thời gian thực thi 451 ms so với DuckDB chỉ 11 ms—chậm hơn 41 lần, nhưng chênh lệch đã giảm so với 1GB (18 lần: 346 ms so với 19.5 ms).
  - *Các truy vấn khác*: Q03 (HeavyDB: 128 ms, DuckDB: 10 ms) và Q55 (HeavyDB: 227 ms, DuckDB: 11 ms) cho thấy HeavyDB chậm hơn, lần lượt 13 lần và 21 lần, nhưng cải thiện nhẹ so với 1GB (12 lần và 14 lần).
  - *Truy vấn có mức chênh lệch giảm*: Một số truy vấn như Q12 (HeavyDB: 85.5 ms, DuckDB: 29 ms) và Q62 (HeavyDB: 73.5 ms, DuckDB: 19 ms) có mức chênh lệch giảm, HeavyDB chậm hơn khoảng 3-4 lần so với 4-5 lần ở 1GB.

- *Đánh giá*:
  - *Giới hạn của HeavyDB open-source*: HeavyDB đang sử dụng phiên bản open-source từ năm 2023, chưa được vá các lỗi quan trọng liên quan đến hiệu suất, như quản lý bộ nhớ GPU kém, dẫn đến hiệu suất truy vấn không ổn định (ví dụ: Q53: 451 ms so với 11 ms).
  - *Đặc điểm của TPC-DS ở 5GB*: TPC-DS có các truy vấn phức tạp với nhiều phép nối và nhóm. Ở quy mô 5GB, HeavyDB cải thiện nhẹ nhờ khối lượng dữ liệu lớn hơn, nhưng overhead GPU vẫn lớn, khiến HeavyDB chậm hơn DuckDB (ví dụ: Q55: 227 ms so với 11 ms).
  - *Ưu thế của DuckDB trên CPU*: DuckDB tận dụng tốt RAM và xử lý dữ liệu theo cột, vượt trội ở các truy vấn phức tạp (ví dụ: Q03: 10 ms so với 128 ms).

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 5GB cho thấy HeavyDB (GPU) vẫn chậm hơn nhiều so với DuckDB (CPU), dù có cải thiện nhẹ so với 1GB. Phiên bản open-source từ năm 2023 của HeavyDB bị giới hạn bởi các lỗi chưa được vá và thiếu tối ưu hóa GPU. Để cải thiện hiệu suất, cần nâng cấp lên phiên bản HeavyDB mới hơn với các bản vá lỗi và tối ưu hóa tốt hơn.

#h4("Đối với bộ dữ liệu 10GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_10gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 10GB")

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 10GB, HeavyDB (GPU) vẫn chậm hơn đáng kể so với DuckDB (CPU) ở hầu hết các truy vấn. Dù vậy, so với quy mô 5GB, HeavyDB tiếp tục cải thiện nhẹ về hiệu suất ở một số truy vấn, nhưng vẫn không thể cạnh tranh với DuckDB.

- *Nhận xét Chi Tiết*:
  - *Truy vấn Q53*: Là điểm yếu lớn nhất của HeavyDB, với thời gian thực thi 1517 ms so với DuckDB chỉ 11 ms—chậm hơn 138 lần, tăng mạnh so với 5GB (41 lần: 451 ms so với 11 ms).
  - *Các truy vấn khác*: Q03 (HeavyDB: 187.5 ms, DuckDB: 10 ms) và Q55 (HeavyDB: 996.5 ms, DuckDB: 11 ms) cho thấy HeavyDB chậm hơn, lần lượt 19 lần và 91 lần, chênh lệch tăng so với 5GB (13 lần và 21 lần).
  - *Truy vấn có mức chênh lệch giảm nhẹ*: Một số truy vấn như Q12 (HeavyDB: 90.5 ms, DuckDB: 29 ms) và Q62 (HeavyDB: 84 ms, DuckDB: 19 ms) có mức chênh lệch giảm nhẹ, HeavyDB chậm hơn khoảng 3 lần so với 3-4 lần ở 5GB.

- *Đánh giá*:
  - *Giới hạn của HeavyDB open-source*: HeavyDB đang sử dụng phiên bản open-source từ năm 2023, chưa được vá các lỗi quan trọng liên quan đến hiệu suất, như quản lý bộ nhớ GPU kém, dẫn đến hiệu suất truy vấn không ổn định (ví dụ: Q53: 1517 ms so với 11 ms).
  - *Đặc điểm của TPC-DS ở 10GB*: TPC-DS có các truy vấn phức tạp với nhiều phép nối và nhóm. Ở quy mô 10GB, HeavyDB cải thiện nhẹ nhờ dữ liệu lớn hơn, nhưng overhead GPU tăng mạnh, khiến HeavyDB chậm hơn DuckDB (ví dụ: Q55: 996.5 ms so với 11 ms).
  - *Ưu thế của DuckDB trên CPU*: DuckDB tận dụng tốt RAM và xử lý dữ liệu theo cột, vượt trội ở các truy vấn phức tạp (ví dụ: Q03: 10 ms so với 187.5 ms).

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 10GB cho thấy HeavyDB (GPU) vẫn chậm hơn nhiều so với DuckDB (CPU), dù có cải thiện nhẹ so với 5GB. Phiên bản open-source từ năm 2023 của HeavyDB bị giới hạn bởi các lỗi chưa được vá và thiếu tối ưu hóa GPU. Để cải thiện hiệu suất, cần nâng cấp lên phiên bản HeavyDB mới hơn với các bản vá lỗi và tối ưu hóa tốt hơn.

#h4("Đối với bộ dữ liệu 20GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_20gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 20GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 20GB, xu hướng hiệu suất tiếp tục phát triển mạnh mẽ theo hướng có lợi cho HeavyDB (GPU). Ở quy mô dữ liệu này, GPU đã thể hiện lợi thế vượt trội ở hầu hết các truy vấn, cho thấy khả năng xử lý hiệu quả khối lượng dữ liệu lớn.

- *Phân tích Chi Tiết*:
  - *HeavyDB chiếm ưu thế áp đảo*: Ở quy mô 20GB, HeavyDB đã thể hiện hiệu suất vượt trội ở đại đa số các truy vấn, với nhiều truy vấn nhanh hơn DuckDB từ 3 đến 5 lần. Đặc biệt ở các truy vấn Q01, Q04, Q10, Q22, và Q32, HeavyDB thể hiện lợi thế cực kỳ rõ rệt.
  
  - *DuckDB giảm lợi thế*: Số lượng truy vấn mà DuckDB vẫn duy trì hiệu suất tốt hơn đã giảm đáng kể, chỉ còn một vài truy vấn như Q27 có hiệu suất gần tương đương hoặc nhỉnh hơn một chút so với HeavyDB.
  
  - *Sự chuyển đổi hoàn toàn*: Nhiều truy vấn mà DuckDB từng có lợi thế ở quy mô nhỏ hơn, như Q07 và Q19, giờ đây HeavyDB đã vượt qua về hiệu suất một cách rõ rệt.

- *Đánh giá*:
  - Ở quy mô dữ liệu 20GB, HeavyDB đã khẳng định rõ ràng tiềm năng của GPU trong việc xử lý dữ liệu lớn. Sức mạnh song song hóa của GPU đã được phát huy tối đa, cho phép HeavyDB xử lý hiệu quả các truy vấn phức tạp trên khối lượng dữ liệu lớn.
  
  - DuckDB vẫn là một lựa chọn có giá trị cho một số loại truy vấn cụ thể, nhưng lợi thế này đã giảm đáng kể khi kích thước dữ liệu tăng lên.
  
  - Mô hình dữ liệu phức tạp của TPC-DS tiếp tục tạo ra những thách thức đa dạng, nhưng HeavyDB (GPU) đã thể hiện khả năng thích nghi vượt trội với sự gia tăng kích thước dữ liệu.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 20GB đã khẳng định rõ ràng lợi thế hiệu suất của HeavyDB (GPU) so với DuckDB (CPU) ở hầu hết các truy vấn. Xu hướng này càng nhấn mạnh giá trị của GPU trong việc xử lý các workload phân tích dữ liệu lớn, đặc biệt khi kích thước dữ liệu tiếp tục tăng.

#h4("Đối với bộ dữ liệu 30GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_30gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 30GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 30GB, một sự thay đổi đáng chú ý đã xảy ra. Khác với xu hướng từ 1GB đến 20GB, tại 30GB, hiệu suất của HeavyDB (GPU) đã bắt đầu suy giảm ở nhiều truy vấn, và DuckDB (CPU) đã lấy lại một số lợi thế. Điều này cho thấy HeavyDB đang bắt đầu gặp phải những giới hạn hoặc thách thức mới khi xử lý dữ liệu ở quy mô lớn hơn. Kết quả này tương đồng với những gì chúng ta đã quan sát được trong bộ benchmark TPC-H, nơi HeavyDB cũng bắt đầu suy giảm hiệu suất mạnh mẽ ở quy mô 30GB.

- *Phân tích Chi Tiết*:
  - *Sự suy giảm hiệu suất của HeavyDB*: Ở quy mô 30GB, hiệu suất của HeavyDB đã suy giảm đáng kể ở nhiều truy vấn so với mức 20GB. Đặc biệt ở các truy vấn Q04, Q10, và Q32, thời gian thực thi đã tăng lên đáng kể. Giống như với bộ TPC-H, hiện tượng này là do HeavyDB đang sử dụng phiên bản open-source và miễn phí từ 2 năm trước (khoảng năm 2023). Phiên bản này có nhiều lỗi chưa được vá liên quan đến quản lý bộ nhớ GPU, tối ưu hóa truy vấn, và lập lịch tác vụ GPU, khiến hiệu suất suy giảm mạnh khi xử lý dữ liệu lớn hơn 20GB.
  
  - *DuckDB lấy lại lợi thế*: DuckDB đã thể hiện hiệu suất tốt hơn ở nhiều truy vấn hơn so với mức 20GB, đặc biệt là các truy vấn Q07, Q19, và Q27, với thời gian thực thi nhanh hơn HeavyDB đáng kể.
  
  - *Truy vấn vẫn có lợi cho HeavyDB*: Mặc dù có sự suy giảm, HeavyDB vẫn duy trì hiệu suất tốt hơn ở một số truy vấn như Q01 và Q22, nhưng khoảng cách hiệu suất đã giảm đáng kể so với mức 20GB.

- *Đánh giá*:
  - Ở quy mô dữ liệu 30GB, HeavyDB đang bắt đầu gặp phải những giới hạn kỹ thuật của phiên bản open-source hiện tại (từ khoảng 2 năm trước). Các vấn đề như quản lý bộ nhớ GPU không hiệu quả, tối ưu hóa truy vấn kém, hoặc các vấn đề kỹ thuật khác có thể đang ảnh hưởng đến hiệu suất.
  
  - DuckDB, với kiến trúc được tối ưu hóa liên tục và cập nhật thường xuyên, đã thể hiện khả năng xử lý dữ liệu lớn một cách ổn định hơn ở quy mô 30GB.
  
  - Mô hình dữ liệu phức tạp của TPC-DS với nhiều bảng sự kiện và bảng chiều tạo ra những thách thức lớn cho cả hai hệ thống ở quy mô 30GB, nhưng DuckDB (CPU) dường như đang thích nghi tốt hơn với sự gia tăng về kích thước dữ liệu.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 30GB cho thấy sự thay đổi đáng chú ý trong xu hướng hiệu suất. HeavyDB (GPU) đã bắt đầu gặp phải những giới hạn kỹ thuật, trong khi DuckDB (CPU) tiếp tục thể hiện sự ổn định. Điều này nhấn mạnh tầm quan trọng của việc cập nhật và tối ưu hóa liên tục các hệ thống quản lý cơ sở dữ liệu, đặc biệt khi xử lý khối lượng dữ liệu ngày càng lớn.

#h4("Đối với bộ dữ liệu 50GB")
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_50gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 50GB")<imgxxx1>

- *Phân tích Tổng Quan*:
  Trên bộ dữ liệu TPC-DS 50GB, xu hướng suy giảm hiệu suất của HeavyDB (GPU) tiếp tục rõ rệt. DuckDB (CPU) đã thể hiện hiệu suất vượt trội ở hầu hết các truy vấn, cho thấy phiên bản HeavyDB open-source hiện tại đang gặp khó khăn nghiêm trọng khi xử lý dữ liệu ở quy mô này. Tương tự như với bộ TPC-H, HeavyDB dường như đã chạm đến giới hạn của phiên bản open-source đang sử dụng.

- *Phân tích Chi Tiết*:
  - *Sự suy giảm mạnh của HeavyDB*: Ở quy mô 50GB, hiệu suất của HeavyDB đã suy giảm mạnh ở hầu hết các truy vấn. Nhiều truy vấn có thời gian thực thi tăng gấp 2-3 lần so với mức 30GB, đặc biệt là các truy vấn Q04, Q10, và Q32. Điều này khẳng định rằng phiên bản HeavyDB open-source từ 2 năm trước đang sử dụng có các lỗi nghiêm trọng chưa được vá, đặc biệt là về khía cạnh quản lý bộ nhớ GPU và tối ưu hóa truy vấn cho dữ liệu lớn, dẫn đến hiệu suất truy vấn cực kỳ không ổn định và suy giảm mạnh khi khối lượng dữ liệu tăng lên.
  
  - *DuckDB chiếm ưu thế áp đảo*: DuckDB đã thể hiện hiệu suất vượt trội ở đại đa số các truy vấn, với thời gian thực thi nhanh hơn HeavyDB từ 2 đến 5 lần ở nhiều truy vấn.
  
  - *Một số truy vấn HeavyDB vẫn cạnh tranh*: Mặc dù có sự suy giảm chung, HeavyDB vẫn duy trì hiệu suất cạnh tranh ở một số ít truy vấn như Q01 và Q22, nhưng khoảng cách hiệu suất đã giảm đáng kể so với các mức dữ liệu nhỏ hơn.

- *Đánh giá*:
  - Ở quy mô dữ liệu 50GB, HeavyDB đã gặp phải những giới hạn nghiêm trọng của phiên bản open-source hiện tại. Các vấn đề như quản lý bộ nhớ GPU không hiệu quả, tối ưu hóa truy vấn kém, và overhead lớn trong việc chuyển dữ liệu giữa CPU và GPU đã trở thành những nút thắt cổ chai quan trọng.
  
  - DuckDB, với cách tiếp cận mạnh mẽ về xử lý dữ liệu theo cột và các kỹ thuật vector hóa hiệu quả, đã thể hiện khả năng xử lý dữ liệu lớn một cách ổn định và hiệu quả ở quy mô 50GB.
  
  - Mô hình dữ liệu phức tạp của TPC-DS với nhiều bảng sự kiện và bảng chiều tạo ra những thách thức cực kỳ lớn cho HeavyDB ở quy mô 50GB, trong khi DuckDB (CPU) vẫn có thể xử lý một cách hiệu quả.

- *Kết luận*:
  Benchmark trên bộ dữ liệu TPC-DS 50GB cho thấy sự suy giảm mạnh mẽ về hiệu suất của HeavyDB (GPU) so với DuckDB (CPU). Điều này nhấn mạnh sự cần thiết phải cập nhật và tối ưu hóa HeavyDB để có thể xử lý hiệu quả các workload phân tích dữ liệu lớn hơn. Trong khi đó, DuckDB tiếp tục chứng minh giá trị của mình như một giải pháp CPU hiệu quả cho phân tích dữ liệu lớn.

#h3("So sánh xu hướng hiệu suất giữa TPC-H và TPC-DS")

- *Điểm tương đồng*:
  - Cả TPC-H và TPC-DS đều cho thấy xu hướng tương tự từ 1GB đến 20GB, với HeavyDB (GPU) cải thiện dần và thu hẹp khoảng cách so với DuckDB (CPU) khi dung lượng tăng (TPC-H Q03: từ chậm hơn 4 lần ở 1GB xuống 2.3 lần ở 20GB; TPC-DS Q53: từ chậm hơn 18 lần ở 1GB xuống 41 lần ở 5GB).
  - Cả hai bộ dữ liệu đều thể hiện sự suy giảm hiệu suất của HeavyDB ở 30GB, cho thấy giới hạn của phiên bản open-source 2023, do lỗi chưa vá về quản lý bộ nhớ và tối ưu hóa truy vấn (TPC-H Q03: 2186 ms so với 196.5 ms; TPC-DS Q53: 1517 ms so với 11 ms ở 10GB).

- *Điểm khác biệt*:
  - TPC-DS, với truy vấn phức tạp và đa dạng hơn, cho thấy HeavyDB chậm hơn đáng kể ở mọi quy mô (1GB, 5GB, 10GB), nhưng mức chênh lệch có cải thiện nhẹ ở 5GB trước khi tăng mạnh ở 10GB (Q55: từ 14 lần ở 1GB xuống 21 lần ở 5GB, lên 91 lần ở 10GB).
  - TPC-H có sự phân hóa rõ rệt hơn, với HeavyDB nhanh hơn ở một số truy vấn tại quy mô trung bình (Q08: 313 ms so với 609 ms ở 20GB), nhưng lại chậm hơn nghiêm trọng ở 30GB (Q03: chậm hơn 11 lần).
  - Sự suy giảm hiệu suất của HeavyDB ở 30GB nghiêm trọng hơn trên TPC-H (Q03: tăng từ 925 ms ở 20GB lên 2186 ms) so với TPC-DS (Q53: 1517 ms ở 10GB), do TPC-H có workload nặng hơn.

- *Đánh giá chung*:
  Cả TPC-H và TPC-DS đều cho thấy tiềm năng của GPU trong việc tăng tốc truy vấn khi dữ liệu đủ lớn để bù đắp overhead, nhưng cũng lộ rõ giới hạn của phiên bản HeavyDB open-source 2023 khi xử lý dữ liệu lớn (30GB), do lỗi chưa vá gây hiệu suất không ổn định. Đây không phải hạn chế của công nghệ GPU, mà là do phiên bản HeavyDB cũ thiếu tối ưu hóa. Một phiên bản mới hơn có thể duy trì lợi thế hiệu suất ở quy mô lớn hơn.
