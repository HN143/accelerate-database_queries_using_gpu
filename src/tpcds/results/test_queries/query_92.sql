-- Query 92: Tính tổng số tiền giảm giá vượt mức bình thường với các điều kiện sau:
-- - Chỉ xét các đơn hàng từ web_sales
-- - Chỉ xét sản phẩm có mã nhà sản xuất là 269
-- - Thời gian từ 1998-03-18 đến 90 ngày sau
-- - Số tiền giảm giá phải lớn hơn 1.3 lần mức trung bình của cùng sản phẩm trong cùng khoảng thời gian
-- - Kết quả được sắp xếp theo tổng số tiền giảm giá
-- - Giới hạn 100 kết quả
select
	sum(ws_ext_discount_amt) as "Excess Discount Amount"
from
	web_sales,
	item,
	date_dim
where
	i_manufact_id = 269
	and i_item_sk = ws_item_sk
	and d_date between '1998-03-18' and (cast('1998-03-18' as date) + 90 days)
	and d_date_sk = ws_sold_date_sk
	and ws_ext_discount_amt > (
		SELECT
			1.3 * avg(ws_ext_discount_amt)
		FROM
			web_sales,
			date_dim
		WHERE
			ws_item_sk = i_item_sk
			and d_date between '1998-03-18' and (cast('1998-03-18' as date) + 90 days)
			and d_date_sk = ws_sold_date_sk
	)
order by
	sum(ws_ext_discount_amt)
limit
	100;