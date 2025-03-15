-- Query 82: Tìm các mặt hàng có giá hiện tại từ 30-60 đồng và còn trong kho.
-- Input:
--   - item: thông tin sản phẩm
--   - inventory: thông tin tồn kho
--   - date_dim: thời gian
--   - store_sales: thông tin bán hàng tại cửa hàng
-- Output: Mã sản phẩm, mô tả và giá hiện tại
-- Điều kiện:
--   - Giá hiện tại từ 30-60
--   - Thời gian từ 2002-05-30 đến 2002-07-29
--   - Mã nhà sản xuất: 437, 129, 727, 663
--   - Số lượng tồn kho từ 100-500
select
	i_item_id,
	i_item_desc,
	i_current_price
from
	item,
	inventory,
	date_dim,
	store_sales
where
	i_current_price between 30 and 30  + 30
	and inv_item_sk = i_item_sk
	and d_date_sk = inv_date_sk
	and d_date between cast('2002-05-30' as date) and (cast('2002-05-30' as date) + 60 days)
	and i_manufact_id in (437, 129, 727, 663)
	and inv_quantity_on_hand between 100 and 500
	and ss_item_sk = i_item_sk
group by
	i_item_id,
	i_item_desc,
	i_current_price
order by
	i_item_id
limit
	100;