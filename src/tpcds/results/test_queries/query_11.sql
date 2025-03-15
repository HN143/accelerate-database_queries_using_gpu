-- Query Description:
-- Truy vấn này phân tích tăng trưởng doanh số của khách hàng qua kênh web và cửa hàng.
-- Chi tiết:
-- 1. Tính tổng doanh số (giá niêm yết - chiết khấu) cho mỗi khách hàng:
--    - Doanh số qua cửa hàng (store)
--    - Doanh số qua web
-- 2. So sánh tỷ lệ tăng trưởng giữa năm 2001 và 2002
-- 3. Chọn ra những khách hàng có:
--    - Tỷ lệ tăng trưởng web > tỷ lệ tăng trưởng cửa hàng
-- 4. Kết quả bao gồm:
--    - ID khách hàng
--    - Tên
--    - Họ
--    - Email
-- 5. Giới hạn 100 kết quả
-- Bảng sử dụng: customer, store_sales, web_sales, date_dim
with
	year_total as (
		select
			c_customer_id customer_id,
			c_first_name customer_first_name,
			c_last_name customer_last_name,
			c_preferred_cust_flag customer_preferred_cust_flag,
			c_birth_country customer_birth_country,
			c_login customer_login,
			c_email_address customer_email_address,
			d_year dyear,
			sum(ss_ext_list_price - ss_ext_discount_amt) year_total,
			's' sale_type
		from
			customer,
			store_sales,
			date_dim
		where
			c_customer_sk = ss_customer_sk
			and ss_sold_date_sk = d_date_sk
		group by
			c_customer_id,
			c_first_name,
			c_last_name,
			c_preferred_cust_flag,
			c_birth_country,
			c_login,
			c_email_address,
			d_year
		union all
		select
			c_customer_id customer_id,
			c_first_name customer_first_name,
			c_last_name customer_last_name,
			c_preferred_cust_flag customer_preferred_cust_flag,
			c_birth_country customer_birth_country,
			c_login customer_login,
			c_email_address customer_email_address,
			d_year dyear,
			sum(ws_ext_list_price - ws_ext_discount_amt) year_total,
			'w' sale_type
		from
			customer,
			web_sales,
			date_dim
		where
			c_customer_sk = ws_bill_customer_sk
			and ws_sold_date_sk = d_date_sk
		group by
			c_customer_id,
			c_first_name,
			c_last_name,
			c_preferred_cust_flag,
			c_birth_country,
			c_login,
			c_email_address,
			d_year
	)
select
	t_s_secyear.customer_id,
	t_s_secyear.customer_first_name,
	t_s_secyear.customer_last_name,
	t_s_secyear.customer_email_address
from
	year_total t_s_firstyear,
	year_total t_s_secyear,
	year_total t_w_firstyear,
	year_total t_w_secyear
where
	t_s_secyear.customer_id = t_s_firstyear.customer_id
	and t_s_firstyear.customer_id = t_w_secyear.customer_id
	and t_s_firstyear.customer_id = t_w_firstyear.customer_id
	and t_s_firstyear.sale_type = 's'
	and t_w_firstyear.sale_type = 'w'
	and t_s_secyear.sale_type = 's'
	and t_w_secyear.sale_type = 'w'
	and t_s_firstyear.dyear = 2001
	and t_s_secyear.dyear = 2001 + 1
	and t_w_firstyear.dyear = 2001
	and t_w_secyear.dyear = 2001 + 1
	and t_s_firstyear.year_total > 0
	and t_w_firstyear.year_total > 0
	and case
		when t_w_firstyear.year_total > 0 then t_w_secyear.year_total / t_w_firstyear.year_total
		else 0.0
	end > case
		when t_s_firstyear.year_total > 0 then t_s_secyear.year_total / t_s_firstyear.year_total
		else 0.0
	end
order by
	t_s_secyear.customer_id,
	t_s_secyear.customer_first_name,
	t_s_secyear.customer_last_name,
	t_s_secyear.customer_email_address
limit
	100;