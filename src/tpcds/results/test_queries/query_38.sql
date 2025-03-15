-- Truy vấn này đếm số lượng khách hàng đã mua hàng qua cả 3 kênh trong cùng một khoảng thời gian:
-- 1. Kênh cửa hàng truyền thống (store_sales)
-- 2. Kênh bán hàng qua danh mục (catalog_sales)
-- 3. Kênh bán hàng trực tuyến (web_sales)
-- Thời gian xét trong 12 tháng liên tiếp (tính từ tháng 1212)
-- Kết quả là số lượng khách hàng thỏa mãn điều kiện trên
select
	count(*)
from
	(
		select distinct
			c_last_name,
			c_first_name,
			d_date
		from
			store_sales,
			date_dim,
			customer
		where
			store_sales.ss_sold_date_sk = date_dim.d_date_sk
			and store_sales.ss_customer_sk = customer.c_customer_sk
			and d_month_seq between 1212 and 1212  + 11
		intersect
		select distinct
			c_last_name,
			c_first_name,
			d_date
		from
			catalog_sales,
			date_dim,
			customer
		where
			catalog_sales.cs_sold_date_sk = date_dim.d_date_sk
			and catalog_sales.cs_bill_customer_sk = customer.c_customer_sk
			and d_month_seq between 1212 and 1212  + 11
		intersect
		select distinct
			c_last_name,
			c_first_name,
			d_date
		from
			web_sales,
			date_dim,
			customer
		where
			web_sales.ws_sold_date_sk = date_dim.d_date_sk
			and web_sales.ws_bill_customer_sk = customer.c_customer_sk
			and d_month_seq between 1212 and 1212  + 11
	) hot_cust
limit
	100;