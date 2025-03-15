-- Mô tả:
-- Truy vấn này tính toán thống kê về đơn hàng từ catalog_sales, bao gồm:
-- 1. Số lượng đơn hàng khác nhau
-- 2. Tổng chi phí vận chuyển
-- 3. Tổng lợi nhuận ròng
-- Với các điều kiện:
-- - Thời gian đặt hàng trong khoảng 60 ngày từ 1999-02-01
-- - Địa chỉ giao hàng ở bang IL
-- - Trung tâm cuộc gọi ở quận Williamson
-- - Đơn hàng phải được giao từ nhiều kho khác nhau
-- - Không có đơn hàng bị trả lại
select
	count(distinct cs_order_number) as "order count",
	sum(cs_ext_ship_cost) as "total shipping cost",
	sum(cs_net_profit) as "total net profit"
from
	catalog_sales cs1,
	date_dim,
	customer_address,
	call_center
where
	d_date between '1999-2-01' and (cast('1999-2-01' as date) + 60 days)
	and cs1.cs_ship_date_sk = d_date_sk
	and cs1.cs_ship_addr_sk = ca_address_sk
	and ca_state = 'IL'
	and cs1.cs_call_center_sk = cc_call_center_sk
	and cc_county in (
		'Williamson County',
		'Williamson County',
		'Williamson County',
		'Williamson County',
		'Williamson County'
	)
	and exists (
		select
			*
		from
			catalog_sales cs2
		where
			cs1.cs_order_number = cs2.cs_order_number
			and cs1.cs_warehouse_sk <> cs2.cs_warehouse_sk
	)
	and not exists (
		select
			*
		from
			catalog_returns cr1
		where
			cs1.cs_order_number = cr1.cr_order_number
	)
order by
	count(distinct cs_order_number)
limit
	100;