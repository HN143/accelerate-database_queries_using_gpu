-- Query Description:
-- Truy vấn này tìm kiếm các khách hàng có tổng phí trả lại hàng cao bất thường trong năm 2000.
-- Chi tiết:
-- 1. Chỉ xem xét các cửa hàng ở bang Tennessee (TN)
-- 2. Tính tổng phí trả lại hàng cho mỗi khách hàng tại mỗi cửa hàng
-- 3. So sánh với mức trung bình của cùng cửa hàng đó
-- 4. Chọn ra những khách hàng có tổng phí trả > 120% mức trung bình
-- 5. Kết quả được sắp xếp theo ID khách hàng
-- 6. Giới hạn 100 kết quả
-- Bảng sử dụng: store_returns, date_dim, store, customer
with
	customer_total_return as (
		select
			sr_customer_sk as ctr_customer_sk,
			sr_store_sk as ctr_store_sk,
			sum(SR_FEE) as ctr_total_return
		from
			store_returns,
			date_dim
		where
			sr_returned_date_sk = d_date_sk
			and d_year = 2000
		group by
			sr_customer_sk,
			sr_store_sk
	)
select
	c_customer_id
from
	customer_total_return ctr1,
	store,
	customer
where
	ctr1.ctr_total_return > (
		select
			avg(ctr_total_return) * 1.2
		from
			customer_total_return ctr2
		where
			ctr1.ctr_store_sk = ctr2.ctr_store_sk
	)
	and s_store_sk = ctr1.ctr_store_sk
	and s_state = 'TN'
	and ctr1.ctr_customer_sk = c_customer_sk
order by
	c_customer_id
limit
	100;