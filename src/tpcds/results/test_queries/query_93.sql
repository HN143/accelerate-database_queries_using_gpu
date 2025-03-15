-- Query 93: Tính tổng doanh số bán hàng cho từng khách hàng với các điều kiện sau:
-- - Tính dựa trên store_sales và store_returns
-- - Chỉ xét các đơn hàng bị trả lại với lý do "Did not like the warranty"
-- - Doanh số = (số lượng - số lượng trả lại) * giá bán nếu có trả hàng
--             hoặc số lượng * giá bán nếu không trả hàng
-- - Kết quả được sắp xếp theo tổng doanh số và mã khách hàng
-- - Giới hạn 100 kết quả
select
	ss_customer_sk,
	sum(act_sales) sumsales
from
	(
		select
			ss_item_sk,
			ss_ticket_number,
			ss_customer_sk,
			case
				when sr_return_quantity is not null then (ss_quantity - sr_return_quantity) * ss_sales_price
				else (ss_quantity * ss_sales_price)
			end act_sales
		from
			store_sales
			left outer join store_returns on (
				sr_item_sk = ss_item_sk
				and sr_ticket_number = ss_ticket_number
			),
			reason
		where
			sr_reason_sk = r_reason_sk
			and r_reason_desc = 'Did not like the warranty'
	) t
group by
	ss_customer_sk
order by
	sumsales,
	ss_customer_sk
limit
	100;