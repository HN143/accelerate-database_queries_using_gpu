-- Query 87: Tìm khách hàng chỉ mua sắm qua kênh cửa hàng truyền thống
--
-- Mô tả: Truy vấn này đếm số lượng khách hàng chỉ mua sắm tại cửa hàng truyền thống (store_sales)
-- mà không mua sắm qua:
-- - Kênh catalog (catalog_sales)
-- - Kênh web (web_sales)
-- trong khoảng thời gian 12 tháng (từ tháng 1212 đến 1212+11).
-- Kết quả được xác định bằng cách loại trừ các khách hàng có giao dịch trên các kênh khác.
select
	count(*)
from
	(
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
		)
		except
		(
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
		)
		except
		(
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
		)
	) cool_cust;