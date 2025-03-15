-- Query Description:
-- Truy vấn này phân tích phân bố địa lý của khách hàng mua các sản phẩm có giá cao.
-- Chi tiết:
-- 1. Xét các giao dịch trong tháng 2 năm 2000
-- 2. Chỉ xem xét các sản phẩm có giá bán cao hơn 120% giá trung bình trong cùng danh mục
-- 3. Đếm số lượng khách hàng theo từng bang
-- 4. Chỉ hiển thị các bang có từ 10 khách hàng trở lên
-- 5. Sắp xếp theo số lượng khách hàng và tên bang
-- 6. Giới hạn 100 kết quả
-- Bảng sử dụng: customer_address, customer, store_sales, date_dim, item
select
	a.ca_state state,
	count(*) cnt
from
	customer_address a,
	customer c,
	store_sales s,
	date_dim d,
	item i
where
	a.ca_address_sk = c.c_current_addr_sk
	and c.c_customer_sk = s.ss_customer_sk
	and s.ss_sold_date_sk = d.d_date_sk
	and s.ss_item_sk = i.i_item_sk
	and d.d_month_seq = (
		select distinct
			(d_month_seq)
		from
			date_dim
		where
			d_year = 2000
			and d_moy = 2
	)
	and i.i_current_price > 1.2 * (
		select
			avg(j.i_current_price)
		from
			item j
		where
			j.i_category = i.i_category
	)
group by
	a.ca_state
having
	count(*) >= 10
order by
	cnt,
	a.ca_state
limit
	100;