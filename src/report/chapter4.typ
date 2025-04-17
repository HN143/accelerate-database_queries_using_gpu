#import "template.typ": *
#import "util.typ": *
#import "state.typ": bib_state
#context bib_state.get()

#h1("KẾT QUẢ DỰ KIẾN")

#h2("Kết quả thực nghiệm")
Sau khi thực hiện benchmark trên máy ảo AWS EC2 g4dn.xlarge, các kết quả đã được thu thập từ hai hệ quản trị cơ sở dữ liệu DuckDB (CPU) và HeavyDB (GPU). Các kết quả này bao gồm thời gian thực thi, mức sử dụng tài nguyên (CPU, GPU, RAM, VRAM), và mức tiêu thụ năng lượng. Dưới đây là các bảng kết quả và biểu đồ minh họa:
#h3("Kết quả từ bộ benchmark TPC-H")
#h4("Thời gian thực thi (Execution Time)")
- *Đối với bộ dữ liệu 1GB:* \
- *Đối với bộ dữ liệu 2GB:* \
- *Đối với bộ dữ liệu 5GB:* \
- *Đối với bộ dữ liệu 10GB:* \
- *Đối với bộ dữ liệu 20GB:* \

#h4("Biểu đồ thể hiện sự so sánh giữa DuckDB và HeavyDB về thời gian thực thi truy vấn")
*_a) Đối với bộ dữ liệu 1GB:_* \
#img("benchmark/average_case_tpc_h/average_case_tpc_h_1gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 1GB")<imgxxx1>

*Nhận xét:*
Dựa trên biểu đồ, DuckDB cho thấy hiệu năng vượt trội trong phần lớn các truy vấn TPC-H 1GB so với HeavyDB. Các truy vấn như Q01, Q02, Q04, Q16, Q17, Q18, Q20 và Q22 có thời gian thực thi của HeavyDB cao hơn từ 2 đến 10 lần so với DuckDB. Đáng chú ý, truy vấn Q16 là một ngoại lệ tiêu biểu khi thời gian thực thi của HeavyDB vượt quá DuckDB hơn 10 lần, phản ánh sự không hiệu quả rõ rệt trong việc xử lý loại truy vấn này trên GPU. Trong khi đó, chỉ có một số ít truy vấn như Q05, Q07 và Q19 cho thấy thời gian thực thi giữa hai hệ thống là tương đương, hoặc HeavyDB nhỉnh hơn đôi chút đối với Q09 (khoảng 10–20%). Nhìn chung, DuckDB không chỉ có hiệu suất tốt hơn trên phần lớn các truy vấn mà còn cho thấy sự ổn định cao hơn trong toàn bộ tập thử nghiệm.



*_b) Đối với bộ dữ liệu 2GB:_* \
#img("benchmark/average_case_tpc_h/average_case_tpc_h_2gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 2GB")<imgxxx1>

*Nhận xét:*
Trên bộ dữ liệu 2GB, DuckDB tiếp tục cho thấy hiệu năng vượt trội so với HeavyDB trong phần lớn các truy vấn thuộc bộ TPC-H. Các truy vấn như Q04, Q16, Q18 và Q20 có thời gian thực thi trên HeavyDB cao hơn DuckDB đáng kể — truy vấn Q16 mất hơn 5000ms trong khi DuckDB chỉ mất khoảng 500ms, tức là chênh lệch gấp 10 lần. Với các truy vấn như Q02, Q03, Q17 và Q22, HeavyDB cũng mất từ 2 đến 4 lần thời gian so với DuckDB. Ở chiều ngược lại, một số truy vấn như Q08, Q12 có thời gian chênh lệch nhỏ, hoặc HeavyDB nhỉnh hơn nhẹ đối với Q01, Q05, Q07, Q19, nhưng số lượng truy vấn như vậy khá ít, đặc biệt ở Q09 HeavyDB có thời gian truy vấn nhanh hơn DuckDB gấp khoảng 3 lần. Tổng thể, DuckDB cho thấy khả năng mở rộng tốt hơn và hiệu năng ổn định hơn khi kích thước dữ liệu tăng lên, trong khi thời gian truy vấn của HeavyDB có xu hướng tăng mạnh với những truy vấn phức tạp.

*_c) Đối với bộ dữ liệu 5GB:_* \
#img("benchmark/average_case_tpc_h/average_case_tpc_h_5gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 5GB")<imgxxx1>
*Nhận xét:*
DuckDB vượt trội hơn rõ rệt ở các truy vấn như Q02, Q04, Q16, Q18 và Q20, với thời gian thực thi ngắn hơn đáng kể. Đặc biệt, tại Q16 và Q18, DuckDB nhanh hơn HeavyDB gấp nhiều lần, cho thấy khả năng tối ưu vượt trội trong các truy vấn phức tạp này. Ngoài ra, DuckDB cũng nhanh hơn ở Q17 và Q22, mặc dù mức độ chênh lệch không quá lớn so với các truy vấn trước.

Ngược lại, HeavyDB có hiệu năng tốt hơn ở các truy vấn như Q01, Q05, Q06, Q07, Q08, Q12, Q13 và Q19, nhưng sự chênh lệch không quá lớn, chỉ ở mức vừa phải. Đặc biệt, tại Q09, HeavyDB nhanh hơn DuckDB đến 7 lần, điều này cho thấy một điểm mạnh nổi bật của HeavyDB trong loại truy vấn cụ thể này.

Đối với các truy vấn Q03 và Q10, thời gian thực thi giữa hai hệ thống gần như tương đương, không có sự khác biệt đáng kể.

Nhìn chung, DuckDB thể hiện ưu thế vượt trội trong nhiều truy vấn phức tạp và có độ trễ cao, trong khi HeavyDB vẫn có lợi thế trong một số truy vấn cụ thể, đặc biệt là Q09. Cả hai hệ thống đều thể hiện những điểm mạnh riêng, phụ thuộc vào loại truy vấn và mức độ tối ưu hóa cho từng trường hợp.

*_d) Đối với bộ dữ liệu 10GB:_* \
#img("benchmark/average_case_tpc_h/average_case_tpc_h_10gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 10GB")<imgxxx1>
*Nhận xét:*
Khi so sánh thời gian thực thi truy vấn giữa DuckDB và HeavyDB trên bộ benchmark TPC-H với kích thước dữ liệu 10GB, có thể thấy rằng hiệu năng tổng thể vẫn nghiêng về phía DuckDB, tuy nhiên sự chênh lệch đã thu hẹp đáng kể so với khi dữ liệu còn ở mức 2GB. Cụ thể, HeavyDB vẫn cho thời gian thực thi chậm hơn rất nhiều ở một số truy vấn nặng như Q01, Q04, Q16, Q18 và Q20. Những truy vấn này đòi hỏi xử lý dữ liệu lớn, logic truy vấn phức tạp, và có thể chưa được tối ưu hoá tốt trong HeavyDB dù sử dụng GPU.

Tuy nhiên, điểm đáng chú ý là số lượng truy vấn mà HeavyDB thực thi nhanh hơn DuckDB đã tăng lên. Có thể kể đến các truy vấn như Q06, Q08, Q12 và Q19, nơi thời gian thực thi của HeavyDB thấp hơn rõ rệt. Đặc biệt, với một số truy vấn như Q07, Q09 và Q13, HeavyDB vượt trội hơn hẳn, lần lượt nhanh hơn DuckDB gấp khoảng 7 lần, 6 lần và 3 lần. Điều này cho thấy khi dữ liệu tăng lên, GPU bắt đầu phát huy được thế mạnh của mình trong những truy vấn nhất định – đặc biệt là những truy vấn có thể song song hóa tốt hoặc có cấu trúc phù hợp với pipeline GPU của HeavyDB.

Ngoài ra, một số truy vấn như Q05 và Q10 cho thấy thời gian thực thi giữa hai hệ thống gần như tương đương, phản ánh rằng không phải lúc nào GPU cũng đem lại lợi thế rõ rệt, và hiệu năng có thể còn phụ thuộc nhiều vào chiến lược tối ưu hóa truy vấn nội tại của từng hệ quản trị cơ sở dữ liệu.

Từ các kết quả quan sát được, có thể kết luận rằng DuckDB vẫn giữ được hiệu năng ổn định và chiếm ưu thế ở phần lớn các truy vấn khi xử lý dữ liệu ở quy mô lớn. Tuy nhiên, HeavyDB đã cho thấy sự cải thiện rõ rệt so với khi dữ liệu còn nhỏ, đặc biệt là ở một số truy vấn cụ thể. Điều này mở ra khả năng khai thác GPU hiệu quả hơn trong tương lai nếu hệ thống được tối ưu sâu hơn cho các dạng truy vấn đa dạng.

*_e) Đối với bộ dữ liệu 20GB:_* \
#img("benchmark/average_case_tpc_h/average_case_tpc_h_20gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 20GB")<imgxxx1>

*Nhận xét:*
Khi thực hiện chạy truy vấn trên tập dữ liệu TPC-H với kích thước 20GB, có thể thấy rằng sự khác biệt về hiệu năng giữa DuckDB (nền tảng sử dụng CPU) và HeavyDB (nền tảng sử dụng GPU) đã có sự thay đổi rõ rệt so với khi chạy trên bộ dữ liệu 10GB.

Cụ thể, số lượng truy vấn mà HeavyDB thực thi nhanh hơn DuckDB đã tăng lên đáng kể. Ở bộ dữ liệu 20GB, chỉ còn truy vấn Q17 là HeavyDB thực hiện chậm hơn so với DuckDB. Điều này cho thấy khi khối lượng dữ liệu tăng lên, lợi thế xử lý song song của GPU bắt đầu phát huy hiệu quả rõ rệt hơn.

Một số truy vấn cho kết quả gần như tương đương giữa hai hệ thống như Q04, Q18 và Q20. Đây thường là các truy vấn có độ phức tạp trung bình hoặc ít thao tác xử lý, nên cả hai hệ thống đều không thể hiện sự khác biệt quá lớn về thời gian thực thi.

Ngược lại, có nhiều truy vấn mà HeavyDB đã thực thi nhanh hơn so với DuckDB, cụ thể là Q06, Q08, Q12 và Q19. Những truy vấn này có đặc điểm phù hợp với khả năng xử lý song song của GPU, nên hiệu năng cải thiện rõ rệt.

Đặc biệt, ở một số truy vấn phức tạp như Q09 và Q13, HeavyDB cho thấy hiệu năng vượt trội hoàn toàn khi lần lượt nhanh hơn gấp khoảng 22 lần và 53 lần so với DuckDB. Điều này cho thấy khả năng mở rộng hiệu quả của GPU trong việc xử lý các phép toán phức tạp và các truy vấn yêu cầu nhiều phép nối, sắp xếp hoặc tính toán.

*Kết luận:*
Từ kết quả thực nghiệm với bộ dữ liệu TPC-H 20GB, có thể thấy rằng HeavyDB đã thể hiện hiệu năng tốt hơn rất nhiều so với DuckDB trong hầu hết các truy vấn. So với dữ liệu 10GB, hiệu suất của HeavyDB được cải thiện rõ rệt khi kích thước dữ liệu tăng lên, trong khi DuckDB bắt đầu gặp khó khăn hơn.

Kết quả này cho thấy GPU-based DBMS như HeavyDB là một lựa chọn rất tiềm năng khi xử lý dữ liệu lớn, đặc biệt phù hợp trong các hệ thống cần truy vấn hiệu năng cao. Điều này cũng đặt ra một hướng nghiên cứu quan trọng về việc tối ưu hóa truy vấn để tận dụng hiệu quả sức mạnh tính toán song song của GPU.

#h3("Kết quả từ bộ benchmark TPC-DS")
#h4("Thời gian thực thi (Execution Time)")
- *Đối với bộ dữ liệu 1GB:* \
- *Đối với bộ dữ liệu 2GB:* \
- *Đối với bộ dữ liệu 5GB:* \
- *Đối với bộ dữ liệu 10GB:* \
- *Đối với bộ dữ liệu 20GB:* \

#h4("Biểu đồ thể hiện sự so sánh giữa DuckDB và HeavyDB về thời gian thực thi truy vấn")
*_a) Đối với bộ dữ liệu 1GB:_* \
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_1gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 1GB")<imgxxx1>

*Nhận xét:*
- *Hiệu năng tổng thể*:

  - DuckDB cho thấy hiệu năng ổn định và tốt hơn rõ rệt trong phần lớn các truy vấn. Thời gian thực thi trung bình thường dao động từ 10ms đến 150ms, rất đều giữa các câu.

  - Ngược lại, HeavyDB có thời gian thực thi dao động mạnh, nhiều truy vấn có thời gian thấp, nhưng cũng có nhiều outlier với thời gian rất cao, vượt ngưỡng hàng nghìn mili giây.

- *Các truy vấn nổi bật gây chênh lệch lớn*:

  - Query 2: HeavyDB mất hơn 4100ms, trong khi DuckDB chỉ khoảng 70ms → chênh lệch gấp ~58 lần.

  - Query 24: HeavyDB mất gần 970ms, DuckDB khoảng 60ms → chênh lệch ~16 lần.

  - Query 54: HeavyDB mất 2700ms, DuckDB chỉ 50ms → chênh lệch ~54 lần.

  - Query 78: HeavyDB mất gần 5900ms, DuckDB chỉ 120ms → chênh lệch ~49 lần.

- *Nhận định*:

  - Các truy vấn kể trên cho thấy GPU không mang lại lợi thế xử lý ở mức dữ liệu nhỏ (1GB) và thậm chí có thể gây ra tình trạng chậm hơn đáng kể nếu không tối ưu.

  - DuckDB – dù chỉ sử dụng CPU – vẫn xử lý nhanh, nhất quán, và không có truy vấn nào vượt quá 200ms, cho thấy tính phù hợp cao với tập dữ liệu nhỏ.

- *Kết luận tạm thời cho bộ 1GB*:

  - GPU (HeavyDB) chưa thực sự phát huy hiệu quả ở quy mô nhỏ, có thể do chi phí khởi tạo pipeline xử lý trên GPU lớn hơn lợi ích thu được.

  - CPU (DuckDB) lại phù hợp hơn nhờ cơ chế xử lý gọn nhẹ, nhanh chóng cho khối lượng dữ liệu vừa phải.


*_b) Đối với bộ dữ liệu 2GB:_* \
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_2gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 2GB")<imgxxx1>

- *Hiệu năng tổng thể*:

  - DuckDB duy trì hiệu năng ổn định, thời gian thực thi trung bình thấp hơn HeavyDB trong hầu hết các truy vấn, dao động từ vài chục đến vài trăm mili giây.
  - HeavyDB có thời gian thực thi dao động mạnh, với một số truy vấn có thời gian rất cao (ví dụ: Query 2 ~8400ms, Query 54 ~5618ms, Query 78 ~11310ms).
- *Các truy vấn nổi bật*:

  - Query 2: HeavyDB mất hơn 8400ms, trong khi DuckDB chỉ mất 161ms → chênh lệch lớn.
  - Query 54: HeavyDB mất 5618ms, DuckDB chỉ mất 70ms.
  - Query 78: HeavyDB mất 11310ms, DuckDB chỉ mất 493ms.
- *Nhận định*:
  - HeavyDB gặp khó khăn với các truy vấn đơn giản hoặc yêu cầu xử lý tuần tự, do chi phí khởi tạo pipeline trên GPU cao.
  - DuckDB phù hợp hơn với bộ dữ liệu 2GB nhờ cơ chế xử lý gọn nhẹ và ổn định.
- *Kết luận tạm thời:*
  - HeavyDB: Chưa phát huy hiệu quả tối ưu ở quy mô dữ liệu 2GB, cần tối ưu hóa thêm để giảm độ trễ.
  - DuckDB: Là lựa chọn tốt hơn cho bộ dữ liệu vừa phải, với thời gian thực thi thấp và hiệu năng ổn định.

*_c) Đối với bộ dữ liệu 5GB:_* \
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_5gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 5GB")<imgxxx1>

*Nhận xét:*
- *Hiệu năng tổng thể:*
  - DuckDB tiếp tục duy trì hiệu năng ổn định, thời gian thực thi trung bình thấp hơn HeavyDB trong phần lớn các truy vấn.Thời gian thực thi của DuckDB dao động từ vài trăm đến vài nghìn mili giây, phù hợp với bộ dữ liệu 5GB.
  - HeavyDB có thời gian thực thi dao động mạnh, với một số truy vấn có thời gian rất cao (ví dụ: Query 2 ~20294ms, Query 54 ~12923ms, Query 78 ~28051ms). GPU bắt đầu thể hiện ưu thế trong các truy vấn phức tạp, nhưng vẫn gặp khó khăn với các truy vấn đơn giản.
- *Các truy vấn nổi bật gây chênh lệch lớn:*
  - Query 2: HeavyDB mất hơn 20294ms, trong khi DuckDB chỉ mất 380ms → chênh lệch gấp ~53 lần.
  - Query 54: HeavyDB mất 12923ms, trong khi DuckDB chỉ mất 146ms → chênh lệch gấp ~88 lần.
  - Query 78: HeavyDB mất 28051ms, trong khi DuckDB chỉ mất 1291ms → chênh lệch gấp ~22 lần.
- *Nhận định:*
  - HeavyDB bắt đầu phát huy hiệu quả hơn với các truy vấn phức tạp, nhưng chi phí khởi tạo pipeline trên GPU vẫn gây ra độ trễ lớn ở một số truy vấn.
  - DuckDB tiếp tục cho thấy hiệu năng ổn định, phù hợp với bộ dữ liệu vừa phải như 5GB.
- *Kết luận tạm thời:*
  - HeavyDB: GPU bắt đầu thể hiện ưu thế trong các truy vấn phức tạp, nhưng vẫn cần tối ưu hóa để giảm độ trễ ở các truy vấn đơn giản.
  - DuckDB: Là lựa chọn tốt hơn cho bộ dữ liệu 5GB, với thời gian thực thi thấp và hiệu năng ổn định.

*_d) Đối với bộ dữ liệu 10GB:_* \
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_10gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 10GB")<imgxxx1>

*Nhận xét:*
- *Hiệu năng tổng thể:*
  - DuckDB bắt đầu gặp khó khăn với bộ dữ liệu 10GB, thời gian thực thi tăng đáng kể so với các bộ dữ liệu nhỏ hơn.Tuy nhiên, DuckDB vẫn duy trì hiệu năng ổn định trong phần lớn các truy vấn, với thời gian thực thi dao động từ vài trăm đến vài nghìn mili giây.
  - HeavyDB thể hiện ưu thế rõ rệt trong các truy vấn phức tạp, đặc biệt là các truy vấn yêu cầu xử lý song song. Tuy nhiên, một số truy vấn đơn giản hoặc yêu cầu xử lý tuần tự vẫn khiến HeavyDB mất nhiều thời gian hơn DuckDB, do chi phí khởi tạo pipeline trên GPU.
- *Các truy vấn nổi bật gây chênh lệch lớn:*
  - Query 2: HeavyDB mất 41963ms, trong khi DuckDB chỉ mất 746ms → chênh lệch gấp ~56 lần.
  - Query 24: HeavyDB mất 14003ms, trong khi DuckDB chỉ mất 419ms → chênh lệch gấp ~33 lần.
  - Query 54: HeavyDB mất 26764ms, trong khi DuckDB chỉ mất 284ms → chênh lệch gấp ~94 lần.
  - Query 78: HeavyDB mất 56489ms, trong khi DuckDB chỉ mất 2707ms → chênh lệch gấp ~21 lần.
- *Phân tích các truy vấn còn lại:*
  - HeavyDB: Trong các truy vấn phức tạp với nhiều phép nối (joins) và tổng hợp (aggregations), HeavyDB cho thấy hiệu năng vượt trội nhờ khả năng xử lý song song mạnh mẽ của GPU. Tuy nhiên, với các truy vấn đơn giản hoặc yêu cầu xử lý tuần tự (ví dụ: Query 42, Query 48), thời gian thực thi của HeavyDB vẫn cao hơn DuckDB, do chi phí khởi tạo pipeline trên GPU.
  - DuckDB: DuckDB duy trì hiệu năng ổn định trong các truy vấn đơn giản (ví dụ: Query 42, Query 48), với thời gian thực thi thấp hơn HeavyDB. Trong các truy vấn phức tạp, DuckDB bắt đầu gặp khó khăn, thời gian thực thi tăng đáng kể (ví dụ: Query 22 mất 16658ms, Query 67 mất 11118ms).
- *Nhận định:*
  - HeavyDB: GPU phát huy hiệu quả rõ rệt với các truy vấn phức tạp và dữ liệu lớn, nhưng vẫn cần tối ưu hóa để giảm độ trễ trong các truy vấn đơn giản.
  - DuckDB: CPU phù hợp hơn với các truy vấn đơn giản, nhưng hiệu năng giảm đáng kể khi kích thước dữ liệu và độ phức tạp của truy vấn tăng lên.
- *Kết luận tạm thời:*
  - HeavyDB: Là lựa chọn tốt hơn cho bộ dữ liệu lớn (10GB), đặc biệt với các truy vấn phức tạp. Cần cải thiện hiệu năng với các truy vấn đơn giản để giảm độ trễ không cần thiết.
  - DuckDB: Phù hợp với các truy vấn đơn giản và dữ liệu vừa phải, nhưng không còn hiệu quả khi kích thước dữ liệu và độ phức tạp tăng cao.
*_e) Đối với bộ dữ liệu 20GB:_* \
#img("benchmark/average_case_tpc_ds/average_case_tpc_ds_20gb.png", cap: "Biểu đồ so sánh thời gian truy vấn trung bình giữa HeavyDB và DuckDB đối với bộ dữ liệu 20GB")<imgxxx1>
*Nhận xét:*

*Hiệu năng tổng thể:*
  - DuckDB gặp khó khăn rõ rệt với bộ dữ liệu 20GB, thời gian thực thi tăng mạnh ở các truy vấn phức tạp. Tuy nhiên, DuckDB vẫn duy trì hiệu năng ổn định hơn HeavyDB ở một số truy vấn đơn giản.
  - HeavyDB thể hiện ưu thế vượt trội trong các truy vấn phức tạp, nhờ khả năng xử lý song song mạnh mẽ của GPU. Một số truy vấn đơn giản vẫn khiến HeavyDB mất nhiều thời gian hơn DuckDB, do chi phí khởi tạo pipeline trên GPU.
* Các truy vấn nổi bật gây chênh lệch lớn:*
  - Query 2: HeavyDB mất 84844ms, DuckDB chỉ mất 1465ms → chênh lệch ~58 lần.
  - Query 24: HeavyDB mất 28871ms, DuckDB chỉ mất 666ms → chênh lệch ~43 lần.
  - Query 54: HeavyDB mất 64333ms, DuckDB chỉ mất 524ms → chênh lệch ~123 lần.

*Phân tích các truy vấn còn lại:*
  - HeavyDB: Trong các truy vấn phức tạp (ví dụ: Query 17, Query 67), HeavyDB vượt trội nhờ khả năng xử lý song song, thời gian thực thi thấp hơn DuckDB. Tuy nhiên, với các truy vấn đơn giản (ví dụ: Query 42, Query 48), thời gian thực thi của HeavyDB vẫn cao hơn DuckDB.
  - DuckDB: duy trì hiệu năng ổn định ở các truy vấn đơn giản, nhưng thời gian thực thi tăng đáng kể ở các truy vấn phức tạp, không còn phù hợp với dữ liệu lớn.
*Sự thay đổi khi kích thước dữ liệu tăng:*
  - Khi kích thước dữ liệu tăng lên từ 10GB đến 20GB:
    - HeavyDB: Hiệu năng cải thiện rõ rệt ở các truy vấn phức tạp, số lượng truy vấn mà HeavyDB vượt trội so với DuckDB tăng lên đáng kể.
    - DuckDB: Hiệu năng giảm mạnh, đặc biệt ở các truy vấn phức tạp, thời gian thực thi tăng không tuyến tính với kích thước dữ liệu.
*Kết luận:*
  - HeavyDB: Là lựa chọn tối ưu cho bộ dữ liệu lớn (20GB), đặc biệt với các truy vấn phức tạp. Tuy nhiên, cần cải thiện hiệu năng ở các truy vấn đơn giản để giảm độ trễ không cần thiết.
  - DuckDB: Phù hợp với các truy vấn đơn giản, nhưng không còn hiệu quả khi kích thước dữ liệu và độ phức tạp tăng cao.

#h2("Phân tích")
#h3("Đối với bộ benchmark TPC-H")
Phân tích chung về sự khác biệt giữa HeavyDB (GPU) và DuckDB (CPU) khi chạy truy vấn trên bộ benchmark TPC-H
#h4("Hiệu năng theo loại truy vấn")
*DuckDB (CPU):*
- DuckDB hoạt động tốt hơn trong các truy vấn đơn giản hoặc yêu cầu xử lý tuần tự, nhờ cơ chế xử lý gọn nhẹ và không có chi phí khởi tạo pipeline như GPU.
- Các truy vấn như Q01, Q05, Q07, Q19 thường có thời gian thực thi thấp hơn HeavyDB, đặc biệt ở các bộ dữ liệu nhỏ (1GB, 2GB).
- Khi truy vấn trở nên phức tạp hơn (nhiều phép nối, tổng hợp), DuckDB bắt đầu gặp khó khăn, đặc biệt khi kích thước dữ liệu tăng lên (10GB, 20GB).

*HeavyDB (GPU):*
- HeavyDB thể hiện ưu thế vượt trội trong các truy vấn phức tạp, đặc biệt là các truy vấn yêu cầu nhiều phép nối (joins), tổng hợp (aggregations), hoặc có thể song song hóa tốt.
- Các truy vấn như Q16, Q18, Q20, Q22 cho thấy GPU phát huy hiệu quả rõ rệt khi xử lý dữ liệu lớn.
- Tuy nhiên, HeavyDB gặp khó khăn với các truy vấn đơn giản hoặc yêu cầu xử lý tuần tự, do chi phí khởi tạo pipeline trên GPU cao, dẫn đến thời gian thực thi lớn hơn DuckDB ở một số trường hợp.

#h4("Hiệu năng theo kích thước dữ liệu")
*1GB:*
- DuckDB vượt trội hơn HeavyDB trong hầu hết các truy vấn, với thời gian thực thi thấp và ổn định.
- HeavyDB không phát huy được hiệu quả của GPU, chi phí khởi tạo pipeline lớn hơn lợi ích thu được, dẫn đến thời gian thực thi cao hơn DuckDB ở nhiều truy vấn.

*2GB:*
- DuckDB vẫn duy trì hiệu năng ổn định và vượt trội hơn HeavyDB trong phần lớn các truy vấn.
- HeavyDB bắt đầu thể hiện tiềm năng ở các truy vấn phức tạp, nhưng vẫn gặp khó khăn với các truy vấn đơn giản.

*5GB:*
- HeavyDB bắt đầu phát huy ưu thế rõ rệt trong các truy vấn phức tạp, nhờ khả năng xử lý song song của GPU.
- DuckDB vẫn ổn định ở các truy vấn đơn giản, nhưng thời gian thực thi tăng đáng kể ở các truy vấn phức tạp.

*10GB:*
- HeavyDB vượt trội hơn DuckDB trong hầu hết các truy vấn phức tạp, với thời gian thực thi thấp hơn đáng kể.
- DuckDB bắt đầu gặp khó khăn rõ rệt, thời gian thực thi tăng mạnh ở các truy vấn phức tạp, nhưng vẫn duy trì hiệu năng tốt hơn HeavyDB ở một số truy vấn đơn giản.

*20GB:*
- HeavyDB hoàn toàn vượt trội so với DuckDB trong hầu hết các truy vấn, đặc biệt là các truy vấn phức tạp như Q16, Q18, Q20.
- DuckDB không còn phù hợp với dữ liệu lớn, thời gian thực thi tăng mạnh và không ổn định.

#h4("Sự thay đổi khi kích thước dữ liệu tăng")
*DuckDB (CPU):*
- Hiệu năng giảm dần khi kích thước dữ liệu tăng lên, đặc biệt ở các truy vấn phức tạp.
- Với dữ liệu lớn (10GB, 20GB), DuckDB không còn duy trì được hiệu năng ổn định, thời gian thực thi tăng mạnh.

*HeavyDB (GPU):*
- Hiệu năng cải thiện rõ rệt khi kích thước dữ liệu tăng lên, đặc biệt ở các truy vấn phức tạp.
- GPU phát huy tối đa khả năng xử lý song song với dữ liệu lớn, giúp HeavyDB vượt trội hơn DuckDB ở hầu hết các truy vấn.

#h4("Kết luận")
*DuckDB (CPU):*
- Phù hợp với dữ liệu nhỏ và vừa (1GB, 2GB, 5GB), đặc biệt với các truy vấn đơn giản.
- Không còn hiệu quả khi kích thước dữ liệu và độ phức tạp của truy vấn tăng lên (10GB, 20GB).

*HeavyDB (GPU):*
- Lựa chọn tối ưu cho dữ liệu lớn (10GB, 20GB), đặc biệt với các truy vấn phức tạp.
- Cần tối ưu hóa thêm để giảm độ trễ ở các truy vấn đơn giản hoặc dữ liệu nhỏ.

Sự khác biệt giữa GPU và CPU trong xử lý truy vấn phụ thuộc lớn vào loại truy vấn và kích thước dữ liệu. GPU phát huy hiệu quả với dữ liệu lớn và truy vấn phức tạp, trong khi CPU phù hợp hơn với dữ liệu nhỏ và truy vấn đơn giản.
#h3("Đối với bộ benchmark TPC-DS")
Phân tích chung về sự khác biệt giữa HeavyDB (GPU) và DuckDB (CPU) khi chạy truy vấn trên bộ benchmark TPC-DS
#h4("Hiệu năng theo loại truy vấn")
*DuckDB (CPU):*

- DuckDB hoạt động tốt hơn trong các truy vấn đơn giản hoặc yêu cầu xử lý tuần tự, nhờ cơ chế xử lý gọn nhẹ và không có chi phí khởi tạo pipeline như GPU.
- Các truy vấn như _Query 1_, _Query 42_, _Query 48_ thường có thời gian thực thi thấp hơn HeavyDB, đặc biệt ở các bộ dữ liệu nhỏ (1GB, 2GB).
- Khi truy vấn trở nên phức tạp hơn (nhiều phép nối, tổng hợp), DuckDB bắt đầu gặp khó khăn, đặc biệt khi kích thước dữ liệu tăng lên (10GB, 20GB).

*HeavyDB (GPU):*

- HeavyDB thể hiện ưu thế vượt trội trong các truy vấn phức tạp, đặc biệt là các truy vấn yêu cầu nhiều phép nối (_joins_), tổng hợp (_aggregations_), hoặc có thể song song hóa tốt.
- Các truy vấn như _Query 2_, _Query 24_, _Query 54_, _Query 78_ cho thấy GPU phát huy hiệu quả rõ rệt khi xử lý dữ liệu lớn.
- Tuy nhiên, HeavyDB gặp khó khăn với các truy vấn đơn giản hoặc yêu cầu xử lý tuần tự, do chi phí khởi tạo pipeline trên GPU cao, dẫn đến thời gian thực thi lớn hơn DuckDB ở một số trường hợp.

#h4("Hiệu năng theo kích thước dữ liệu")

*1GB:*

- DuckDB vượt trội hơn HeavyDB trong hầu hết các truy vấn, với thời gian thực thi thấp và ổn định.
- HeavyDB không phát huy được hiệu quả của GPU, chi phí khởi tạo pipeline lớn hơn lợi ích thu được, dẫn đến thời gian thực thi cao hơn DuckDB ở nhiều truy vấn.

*2GB:*

- DuckDB vẫn duy trì hiệu năng ổn định và vượt trội hơn HeavyDB trong phần lớn các truy vấn.
- HeavyDB bắt đầu thể hiện tiềm năng ở các truy vấn phức tạp, nhưng vẫn gặp khó khăn với các truy vấn đơn giản.

*5GB:*

- HeavyDB bắt đầu phát huy ưu thế rõ rệt trong các truy vấn phức tạp, nhờ khả năng xử lý song song của GPU.
- DuckDB vẫn ổn định ở các truy vấn đơn giản, nhưng thời gian thực thi tăng đáng kể ở các truy vấn phức tạp.

*10GB:*

- HeavyDB vượt trội hơn DuckDB trong hầu hết các truy vấn phức tạp, với thời gian thực thi thấp hơn đáng kể.
- DuckDB bắt đầu gặp khó khăn rõ rệt, thời gian thực thi tăng mạnh ở các truy vấn phức tạp, nhưng vẫn duy trì hiệu năng tốt hơn HeavyDB ở một số truy vấn đơn giản.

*20GB:*

- HeavyDB hoàn toàn vượt trội so với DuckDB trong hầu hết các truy vấn, đặc biệt là các truy vấn phức tạp như _Query 2_, _Query 24_, _Query 54_.
- DuckDB không còn phù hợp với dữ liệu lớn, thời gian thực thi tăng mạnh và không ổn định.

#h4("Sự thay đổi khi kích thước dữ liệu tăng")

*DuckDB (CPU):*

- Hiệu năng giảm dần khi kích thước dữ liệu tăng lên, đặc biệt ở các truy vấn phức tạp.
- Với dữ liệu lớn (10GB, 20GB), DuckDB không còn duy trì được hiệu năng ổn định, thời gian thực thi tăng mạnh.

*HeavyDB (GPU):*

- Hiệu năng cải thiện rõ rệt khi kích thước dữ liệu tăng lên, đặc biệt ở các truy vấn phức tạp.
- GPU phát huy tối đa khả năng xử lý song song với dữ liệu lớn, giúp HeavyDB vượt trội hơn DuckDB ở hầu hết các truy vấn.

#h4("Kết luận")

*DuckDB (CPU):*

- Phù hợp với dữ liệu nhỏ và vừa (1GB, 2GB, 5GB), đặc biệt với các truy vấn đơn giản.
- Không còn hiệu quả khi kích thước dữ liệu và độ phức tạp của truy vấn tăng lên (10GB, 20GB).

*HeavyDB (GPU):*

- Lựa chọn tối ưu cho dữ liệu lớn (10GB, 20GB), đặc biệt với các truy vấn phức tạp.
- Cần tối ưu hóa thêm để giảm độ trễ ở các truy vấn đơn giản hoặc dữ liệu nhỏ.


#h2("Thảo luận")
Trong phần này, chúng tôi sẽ thảo luận về các kết quả thu được từ việc benchmark HeavyDB (GPU) và DuckDB (CPU) trên hai bộ benchmark phổ biến là TPC-H và TPC-DS. Các kết quả này được phân tích để trả lời các câu hỏi đã đề ra ban đầu, nhằm làm rõ sự khác biệt giữa việc sử dụng GPU và CPU trong xử lý truy vấn cơ sở dữ liệu.

#h3("GPU có thực sự giúp tăng tốc độ truy vấn cơ sở dữ liệu nhanh hơn so với CPU không?")
Kết quả cho thấy GPU (HeavyDB) có khả năng tăng tốc độ truy vấn đáng kể so với CPU (DuckDB) trong các trường hợp dữ liệu lớn (10GB, 20GB) và các truy vấn phức tạp. GPU phát huy hiệu quả nhờ khả năng xử lý song song, đặc biệt trong các truy vấn yêu cầu nhiều phép nối (_joins_), tổng hợp (_aggregations_), hoặc tính toán phức tạp.

Tuy nhiên, với dữ liệu nhỏ (1GB, 2GB) hoặc các truy vấn đơn giản, GPU không mang lại lợi thế rõ rệt. Chi phí khởi tạo pipeline trên GPU cao khiến thời gian thực thi của HeavyDB thường lớn hơn DuckDB trong các trường hợp này.

#h3("Trong những trường hợp nào HeavyDB (GPU) vượt trội hơn so với DuckDB (CPU)?")
HeavyDB vượt trội hơn DuckDB trong các truy vấn phức tạp, đặc biệt là:

- Các truy vấn có nhiều phép nối (_joins_) như _Query 2_, _Query 24_ (TPC-DS).
- Các truy vấn yêu cầu tổng hợp dữ liệu lớn như _Query 54_, _Query 78_ (TPC-DS) hoặc _Q16_, _Q18_ (TPC-H).
- Khi kích thước dữ liệu tăng lên (10GB, 20GB), GPU phát huy hiệu quả rõ rệt, giúp HeavyDB xử lý nhanh hơn DuckDB trong hầu hết các truy vấn phức tạp.

#h3("Những yếu tố nào ảnh hưởng đến hiệu suất truy vấn khi sử dụng GPU thay vì CPU?")
*Loại truy vấn:*
- GPU hoạt động hiệu quả với các truy vấn phức tạp, có thể song song hóa tốt.
- Các truy vấn đơn giản hoặc yêu cầu xử lý tuần tự không tận dụng được sức mạnh của GPU, dẫn đến hiệu suất kém hơn CPU.

*Kích thước dữ liệu:*
- GPU phát huy hiệu quả khi kích thước dữ liệu lớn (10GB, 20GB), nhờ khả năng xử lý song song.
- Với dữ liệu nhỏ (1GB, 2GB), chi phí khởi tạo pipeline trên GPU lớn hơn lợi ích thu được.

*Cấu trúc truy vấn:*
- Các truy vấn có nhiều phép nối, tổng hợp, hoặc tính toán phức tạp phù hợp hơn với GPU.
- Các truy vấn đơn giản hoặc có ít phép toán phù hợp hơn với CPU.

#h3("Khi nào việc sử dụng GPU trở nên không hiệu quả hoặc kém tối ưu so với CPU?")
GPU trở nên không hiệu quả trong các trường hợp:

- Dữ liệu nhỏ (1GB, 2GB), khi chi phí khởi tạo pipeline trên GPU lớn hơn thời gian xử lý thực tế.
- Các truy vấn đơn giản, yêu cầu xử lý tuần tự, hoặc có ít phép toán (ví dụ: _Query 1_, _Query 42_ trong TPC-DS).
- Khi truy vấn không tận dụng được khả năng song song hóa của GPU.

#h3("Những câu query như thế nào thì chạy trên CPU, những câu nào thì chạy trên GPU?")
*Chạy trên CPU (DuckDB):*
- Các truy vấn đơn giản, ít phép nối hoặc tổng hợp.
- Ví dụ: _Query 1_, _Query 42_, _Query 48_ (TPC-DS); _Q01_, _Q05_, _Q07_ (TPC-H).

*Chạy trên GPU (HeavyDB):*
- Các truy vấn phức tạp, nhiều phép nối, tổng hợp, hoặc tính toán phức tạp.
- Ví dụ: _Query 2_, _Query 24_, _Query 54_ (TPC-DS); _Q16_, _Q18_, _Q20_ (TPC-H).

#h3("Các phép tính nào xử lý trên CPU, GPU?")
*CPU:*
- Các phép toán đơn giản, tuần tự như lọc (_filter_), sắp xếp (_sort_) trên tập dữ liệu nhỏ.
- Các phép nối đơn giản hoặc tổng hợp trên tập dữ liệu nhỏ.

*GPU:*
- Các phép toán phức tạp, có thể song song hóa như tổng hợp (_aggregation_), phép nối (_joins_) trên tập dữ liệu lớn.
- Các phép tính toán phức tạp như tính toán ma trận hoặc xử lý dữ liệu đa chiều.

#h3("Ưu nhược điểm khi chạy query trên HeavyDB và DuckDB")
*HeavyDB (GPU):*

_Ưu điểm:_
- Xử lý nhanh các truy vấn phức tạp trên dữ liệu lớn nhờ khả năng song song hóa.
- Hiệu năng cải thiện rõ rệt khi kích thước dữ liệu tăng lên.

_Nhược điểm:_
- Chi phí khởi tạo pipeline cao, không hiệu quả với dữ liệu nhỏ hoặc truy vấn đơn giản.
- Yêu cầu phần cứng GPU chuyên dụng, dẫn đến chi phí triển khai cao hơn.

*DuckDB (CPU):*

_Ưu điểm:_
- Hiệu năng ổn định trên dữ liệu nhỏ và vừa.
- Không yêu cầu phần cứng đặc biệt, dễ triển khai và chi phí thấp.

_Nhược điểm:_
- Hiệu năng giảm mạnh khi kích thước dữ liệu và độ phức tạp của truy vấn tăng lên.
- Không tận dụng được khả năng song song hóa như GPU.

#h3("Kết luận")
Từ các kết quả benchmark, có thể kết luận rằng GPU (HeavyDB) là lựa chọn tối ưu cho các truy vấn phức tạp và dữ liệu lớn, trong khi CPU (DuckDB) phù hợp hơn với các truy vấn đơn giản và dữ liệu nhỏ.  
Sự khác biệt này phụ thuộc lớn vào loại truy vấn, kích thước dữ liệu, và khả năng tối ưu hóa của từng hệ quản trị cơ sở dữ liệu.

#h2("Kết luận chương")
Chương 4 đã trình bày chi tiết kết quả benchmark và phân tích hiệu năng của hai hệ quản trị cơ sở dữ liệu DuckDB (CPU) và HeavyDB (GPU) trên hai bộ benchmark phổ biến là TPC-H và TPC-DS. Qua các kết quả thực nghiệm, chúng tôi đã làm rõ sự khác biệt giữa việc sử dụng GPU và CPU trong xử lý truy vấn cơ sở dữ liệu, đồng thời trả lời các câu hỏi nghiên cứu đã đề ra. Kết quả từ chương này không chỉ cung cấp cái nhìn sâu sắc về hiệu năng của GPU và CPU trong xử lý truy vấn cơ sở dữ liệu mà còn mở ra các hướng nghiên cứu tiềm năng để tối ưu hóa hiệu năng của các hệ quản trị cơ sở dữ liệu trong tương lai.

