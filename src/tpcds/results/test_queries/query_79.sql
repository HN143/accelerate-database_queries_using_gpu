--
-- Câu query lấy thông tin khách hàng và giao dịch mua hàng tại cửa hàng
-- Với các điều kiện:
-- - Thời gian trong các ngày thứ 2 của năm 1998-2000
-- - Cửa hàng có số lượng nhân viên từ 200 đến 295
-- - Hộ gia đình có 8 người phụ thuộc hoặc có ít nhất 1 phương tiện giao thông
-- Kết quả được sắp xếp theo họ, tên khách hàng, tên thành phố và lợi nhuận
-- Giới hạn 100 bản ghi
--
select
	c_last_name,
	c_first_name,
	substr (s_city, 1, 30),
	ss_ticket_number,
	amt,
	profit
from
	(
		select
			ss_ticket_number,
			ss_customer_sk,
			store.s_city,
			sum(ss_coupon_amt) amt,
			sum(ss_net_profit) profit
		from
			store_sales,
			date_dim,
			store,
			household_demographics
		where
			store_sales.ss_sold_date_sk = date_dim.d_date_sk
			and store_sales.ss_store_sk = store.s_store_sk
			and store_sales.ss_hdemo_sk = household_demographics.hd_demo_sk
			and (
				household_demographics.hd_dep_count = 8
				or household_demographics.hd_vehicle_count > 0
			)
			and date_dim.d_dow = 1
			and date_dim.d_year in (1998, 1998 + 1, 1998 + 2)
			and store.s_number_employees between 200 and 295
		group by
			ss_ticket_number,
			ss_customer_sk,
			ss_addr_sk,
			store.s_city
	) ms,
	customer
where
	ss_customer_sk = c_customer_sk
order by
	c_last_name,
	c_first_name,
	substr (s_city, 1, 30),
	profit
limit
	100;