-- Truy vấn này tìm kiếm các mặt hàng trong kho với các điều kiện:
-- 1. Giá hiện tại từ 22 đến 52 đơn vị tiền tệ
-- 2. Số lượng tồn kho từ 100 đến 500
-- 3. Thuộc về một trong các nhà sản xuất: 678, 964, 918, 849
-- 4. Có trong kho trong khoảng thời gian 60 ngày kể từ 2001-06-02
-- 5. Đã từng được bán qua kênh catalog
-- Kết quả trả về thông tin sản phẩm và giá hiện tại
select
	i_item_id,
	i_item_desc,
	i_current_price
from
	item,
	inventory,
	date_dim,
	catalog_sales
where
	i_current_price between 22 and 22  + 30
	and inv_item_sk = i_item_sk
	and d_date_sk = inv_date_sk
	and d_date between cast('2001-06-02' as date) and (cast('2001-06-02' as date) + 60 days)
	and i_manufact_id in (678, 964, 918, 849)
	and inv_quantity_on_hand between 100 and 500
	and cs_item_sk = i_item_sk
group by
	i_item_id,
	i_item_desc,
	i_current_price
order by
	i_item_id
limit
	100;