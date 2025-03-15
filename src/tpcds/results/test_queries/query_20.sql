-- Mô tả:
-- Truy vấn này phân tích doanh thu bán hàng qua catalog theo danh mục sản phẩm:
-- Tính toán cho từng sản phẩm:
-- 1. Tổng doanh thu bán hàng
-- 2. Tỷ lệ phần trăm doanh thu của sản phẩm trong cùng nhóm class
-- Với các điều kiện:
-- - Sản phẩm thuộc một trong các danh mục: Trang sức, Thể thao, Sách
-- - Thời gian: 30 ngày kể từ 2001-01-12
-- Kết quả sắp xếp theo danh mục, nhóm class và mã sản phẩm
select
	i_item_id,
	i_item_desc,
	i_category,
	i_class,
	i_current_price,
	sum(cs_ext_sales_price) as itemrevenue,
	sum(cs_ext_sales_price) * 100 / sum(sum(cs_ext_sales_price)) over (
		partition by
			i_class
	) as revenueratio
from
	catalog_sales,
	item,
	date_dim
where
	cs_item_sk = i_item_sk
	and i_category in ('Jewelry', 'Sports', 'Books')
	and cs_sold_date_sk = d_date_sk
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