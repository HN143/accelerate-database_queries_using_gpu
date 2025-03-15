-- Query 88: Phân tích lượng mua sắm theo khung giờ tại cửa hàng "ese"
--
-- Mô tả: Truy vấn thống kê số lượng giao dịch bán hàng theo từng khung giờ từ 8:30 sáng đến 12:30 trưa,
-- với các điều kiện về nhân khẩu học hộ gia đình:
-- - Số người phụ thuộc: 0, 1 hoặc 3 người
-- - Số lượng phương tiện: không vượt quá số người phụ thuộc + 2
-- Kết quả được chia thành 8 khoảng thời gian, mỗi khoảng 30 phút
--
select
	*
from
	(
		select
			count(*) h8_30_to_9
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
			and (
				(
					household_demographics.hd_dep_count = 3
					and household_demographics.hd_vehicle_count <= 3 + 2
				)
				or (
					household_demographics.hd_dep_count = 0
					and household_demographics.hd_vehicle_count <= 0 + 2
				)
				or (
					household_demographics.hd_dep_count = 1
					and household_demographics.hd_vehicle_count <= 1 + 2
				)
			)
			and store.s_store_name = 'ese'
	) s1,
	(
		select
			count(*) h9_to_9_30
		from
			store_sales,
			household_demographics,
			time_dim,
			store
		where
			ss_sold_time_sk = time_dim.t_time_sk
			and ss_hdemo_sk = household_demographics.hd_demo_sk
			and ss_store_sk = s_store_sk
			and time_dim.t_hour = 9
			and time_dim.t_minute < 30
			and (
				(
					household_demographics.hd_dep_count = 3
					and household_demographics.hd_vehicle_count <= 3 + 2
				)
				or (
					household_demographics.hd_dep_count = 0
					and household_demographics.hd_vehicle_count <= 0 + 2
				)
				or (
					household_demographics.hd_dep_count = 1
					and household_demographics.hd_vehicle_count <= 1 + 2
				)
			)
			and store.s_store_name = 'ese'
	) s2,
	(
		select
			count(*) h9_30_to_10
		from
			store_sales,
			household_demographics,
			time_dim,
			store
		where
			ss_sold_time_sk = time_dim.t_time_sk
			and ss_hdemo_sk = household_demographics.hd_demo_sk
			and ss_store_sk = s_store_sk
			and time_dim.t_hour = 9
			and time_dim.t_minute >= 30
			and (
				(
					household_demographics.hd_dep_count = 3
					and household_demographics.hd_vehicle_count <= 3 + 2
				)
				or (
					household_demographics.hd_dep_count = 0
					and household_demographics.hd_vehicle_count <= 0 + 2
				)
				or (
					household_demographics.hd_dep_count = 1
					and household_demographics.hd_vehicle_count <= 1 + 2
				)
			)
			and store.s_store_name = 'ese'
	) s3,
	(
		select
			count(*) h10_to_10_30
		from
			store_sales,
			household_demographics,
			time_dim,
			store
		where
			ss_sold_time_sk = time_dim.t_time_sk
			and ss_hdemo_sk = household_demographics.hd_demo_sk
			and ss_store_sk = s_store_sk
			and time_dim.t_hour = 10
			and time_dim.t_minute < 30
			and (
				(
					household_demographics.hd_dep_count = 3
					and household_demographics.hd_vehicle_count <= 3 + 2
				)
				or (
					household_demographics.hd_dep_count = 0
					and household_demographics.hd_vehicle_count <= 0 + 2
				)
				or (
					household_demographics.hd_dep_count = 1
					and household_demographics.hd_vehicle_count <= 1 + 2
				)
			)
			and store.s_store_name = 'ese'
	) s4,
	(
		select
			count(*) h10_30_to_11
		from
			store_sales,
			household_demographics,
			time_dim,
			store
		where
			ss_sold_time_sk = time_dim.t_time_sk
			and ss_hdemo_sk = household_demographics.hd_demo_sk
			and ss_store_sk = s_store_sk
			and time_dim.t_hour = 10
			and time_dim.t_minute >= 30
			and (
				(
					household_demographics.hd_dep_count = 3
					and household_demographics.hd_vehicle_count <= 3 + 2
				)
				or (
					household_demographics.hd_dep_count = 0
					and household_demographics.hd_vehicle_count <= 0 + 2
				)
				or (
					household_demographics.hd_dep_count = 1
					and household_demographics.hd_vehicle_count <= 1 + 2
				)
			)
			and store.s_store_name = 'ese'
	) s5,
	(
		select
			count(*) h11_to_11_30
		from
			store_sales,
			household_demographics,
			time_dim,
			store
		where
			ss_sold_time_sk = time_dim.t_time_sk
			and ss_hdemo_sk = household_demographics.hd_demo_sk
			and ss_store_sk = s_store_sk
			and time_dim.t_hour = 11
			and time_dim.t_minute < 30
			and (
				(
					household_demographics.hd_dep_count = 3
					and household_demographics.hd_vehicle_count <= 3 + 2
				)
				or (
					household_demographics.hd_dep_count = 0
					and household_demographics.hd_vehicle_count <= 0 + 2
				)
				or (
					household_demographics.hd_dep_count = 1
					and household_demographics.hd_vehicle_count <= 1 + 2
				)
			)
			and store.s_store_name = 'ese'
	) s6,
	(
		select
			count(*) h11_30_to_12
		from
			store_sales,
			household_demographics,
			time_dim,
			store
		where
			ss_sold_time_sk = time_dim.t_time_sk
			and ss_hdemo_sk = household_demographics.hd_demo_sk
			and ss_store_sk = s_store_sk
			and time_dim.t_hour = 11
			and time_dim.t_minute >= 30
			and (
				(
					household_demographics.hd_dep_count = 3
					and household_demographics.hd_vehicle_count <= 3 + 2
				)
				or (
					household_demographics.hd_dep_count = 0
					and household_demographics.hd_vehicle_count <= 0 + 2
				)
				or (
					household_demographics.hd_dep_count = 1
					and household_demographics.hd_vehicle_count <= 1 + 2
				)
			)
			and store.s_store_name = 'ese'
	) s7,
	(
		select
			count(*) h12_to_12_30
		from
			store_sales,
			household_demographics,
			time_dim,
			store
		where
			ss_sold_time_sk = time_dim.t_time_sk
			and ss_hdemo_sk = household_demographics.hd_demo_sk
			and ss_store_sk = s_store_sk
			and time_dim.t_hour = 12
			and time_dim.t_minute < 30
			and (
				(
					household_demographics.hd_dep_count = 3
					and household_demographics.hd_vehicle_count <= 3 + 2
				)
				or (
					household_demographics.hd_dep_count = 0
					and household_demographics.hd_vehicle_count <= 0 + 2
				)
				or (
					household_demographics.hd_dep_count = 1
					and household_demographics.hd_vehicle_count <= 1 + 2
				)
			)
			and store.s_store_name = 'ese'
	) s8;