-- Query Description:
-- Truy vấn này phân tích doanh số bán hàng của các mặt hàng theo danh mục cụ thể.
-- Chi tiết:
-- 1. Chỉ xem xét các mặt hàng thuộc 3 danh mục:
--    - Trang sức (Jewelry)
--    - Thể thao (Sports)
--    - Sách (Books)
-- 2. Thời gian: 30 ngày kể từ 12/01/2001
-- 3. Tính cho mỗi mặt hàng:
--    - Tổng doanh số bán hàng
--    - Tỷ lệ doanh số trong cùng nhóm class (tính theo %)
-- 4. Sắp xếp theo:
--    - Danh mục
--    - Class
--    - ID sản phẩm
--    - Mô tả sản phẩm
--    - Tỷ lệ doanh số
-- 5. Giới hạn 100 kết quả
-- Bảng sử dụng: web_sales, item, date_dim
select
	i_item_id,
	i_item_desc,
	i_category,
	i_class,
	i_current_price,
	sum(ws_ext_sales_price) as itemrevenue,
	sum(ws_ext_sales_price) * 100 / sum(sum(ws_ext_sales_price)) over (
		partition by
			i_class
	) as revenueratio
from
	web_sales,
	item,
	date_dim
where
	ws_item_sk = i_item_sk
	and i_category in ('Jewelry', 'Sports', 'Books')
	and ws_sold_date_sk = d_date_sk
	and d_date between cast('2001-01-12' as date) and (cast('2001-01-12' as date) + 30 days)
group by
	i_item_id,
	i_item_desc,
	i_category,
	i_class,
	i_current_price
order by
	i_category,
	i_class,
	i_item_id,
	i_item_desc,
	revenueratio
limit
	100;