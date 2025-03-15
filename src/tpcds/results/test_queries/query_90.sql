-- Query 90: Tính tỷ lệ số lượng đơn hàng giữa buổi sáng và chiều với các điều kiện sau:
-- - Chỉ xét các đơn hàng từ web_sales
-- - Khách hàng có 8 người phụ thuộc
-- - Trang web có số ký tự từ 5000 đến 5200
-- - So sánh số đơn hàng trong giờ thứ 6-7 (sáng) và 14-15 (chiều)
-- - Kết quả được sắp xếp theo tỷ lệ
-- - Giới hạn 100 kết quả
select
	cast(amc as decimal(15, 4)) / cast(pmc as decimal(15, 4)) am_pm_ratio
from
	(
		select
			count(*) amc
		from
			web_sales,
			household_demographics,
			time_dim,
			web_page
		where
			ws_sold_time_sk = time_dim.t_time_sk
			and ws_ship_hdemo_sk = household_demographics.hd_demo_sk
			and ws_web_page_sk = web_page.wp_web_page_sk
			and time_dim.t_hour between 6 and 6  + 1
			and household_demographics.hd_dep_count = 8
			and web_page.wp_char_count between 5000 and 5200
	) at,
	(
		select
			count(*) pmc
		from
			web_sales,
			household_demographics,
			time_dim,
			web_page
		where
			ws_sold_time_sk = time_dim.t_time_sk
			and ws_ship_hdemo_sk = household_demographics.hd_demo_sk
			and ws_web_page_sk = web_page.wp_web_page_sk
			and time_dim.t_hour between 14 and 14  + 1
			and household_demographics.hd_dep_count = 8
			and web_page.wp_char_count between 5000 and 5200
	) pt
order by
	am_pm_ratio
limit
	100;