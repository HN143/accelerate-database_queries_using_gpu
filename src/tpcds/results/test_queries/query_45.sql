-- Truy vấn này phân tích doanh số bán hàng trực tuyến theo địa điểm:
-- 1. Tính tổng giá trị bán hàng theo mã bưu điện và quận
-- 2. Chỉ xét các đơn hàng trong quý 2 năm 2000
-- 3. Lọc theo một trong hai điều kiện:
--    - Khách hàng ở các mã bưu điện cụ thể (85669, 86197,...)
--    - Hoặc mua các mặt hàng có mã cụ thể (2, 3, 5, 7,...)
-- Kết quả được sắp xếp theo mã bưu điện và quận
select
	ca_zip,
	ca_county,
	sum(ws_sales_price)
from
	web_sales,
	customer,
	customer_address,
	date_dim,
	item
where
	ws_bill_customer_sk = c_customer_sk
	and c_current_addr_sk = ca_address_sk
	and ws_item_sk = i_item_sk
	and (
		substr (ca_zip, 1, 5) in (
			'85669',
			'86197',
			'88274',
			'83405',
			'86475',
			'85392',
			'85460',
			'80348',
			'81792'
		)
		or i_item_id in (
			select
				i_item_id
			from
				item
			where
				i_item_sk in (2, 3, 5, 7, 11, 13, 17, 19, 23, 29)
		)
	)
	and ws_sold_date_sk = d_date_sk
	and d_qoy = 2
	and d_year = 2000
group by
	ca_zip,
	ca_county
order by
	ca_zip,
	ca_county
limit
	100;