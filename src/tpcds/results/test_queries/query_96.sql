--
-- Câu query đếm số lượng bản ghi thỏa mãn các điều kiện:
-- - Thời gian bán hàng là 8 giờ 30 phút trở đi
-- - Số người phụ thuộc trong hộ gia đình là 5 người
-- - Tên cửa hàng là 'ese'
-- Kết quả được sắp xếp theo số lượng và giới hạn 100 bản ghi
--
select
	count(*)
from
	store_sales,
	household_demographics,
	time_dim,
	store
where
	ss_sold_time_sk = time_dim.t_time_sk
	and ss_hdemo_sk = household_demographics.hd_demo_sk
	and ss_store_sk = s_store_sk
	and time_dim.t_hour = 8
	and time_dim.t_minute >= 30
	and household_demographics.hd_dep_count = 5
	and store.s_store_name = 'ese'
order by
	count(*)
limit
	100;