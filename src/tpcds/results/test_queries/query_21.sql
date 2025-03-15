/*
Mô tả:
- Phân tích sự thay đổi tồn kho trước và sau ngày 08/04/1998
- Thông tin hiển thị:
+ Tên kho
+ ID sản phẩm
+ Số lượng tồn trước ngày 08/04/1998
+ Số lượng tồn sau ngày 08/04/1998
- Điều kiện:
+ Chỉ xét sản phẩm có giá hiện tại từ 0.99 đến 1.49
+ Thời gian xét là 30 ngày trước và sau 08/04/1998
+ Tỷ lệ tồn kho sau/trước phải nằm trong khoảng 2/3 đến 3/2
- Kết quả được sắp xếp theo tên kho và ID sản phẩm
- Giới hạn 100 bản ghi
*/
select
	*
from
	(
		select
			w_warehouse_name,
			i_item_id,
			sum(
				case
					when (cast(d_date as date) < cast('1998-04-08' as date)) then inv_quantity_on_hand
					else 0
				end
			) as inv_before,
			sum(
				case
					when (
						cast(d_date as date) >= cast('1998-04-08' as date)
					) then inv_quantity_on_hand
					else 0
				end
			) as inv_after
		from
			inventory,
			warehouse,
			item,
			date_dim
		where
			i_current_price between 0.99 and 1.49
			and i_item_sk = inv_item_sk
			and inv_warehouse_sk = w_warehouse_sk
			and inv_date_sk = d_date_sk
			and d_date between (cast('1998-04-08' as date) - 30 days) and (cast('1998-04-08' as date) + 30 days)
		group by
			w_warehouse_name,
			i_item_id
	) x
where
	(
		case
			when inv_before > 0 then inv_after / inv_before
			else null
		end
	) between 2.0 / 3.0 and 3.0  / 2.0
order by
	w_warehouse_name,
	i_item_id
limit
	100;