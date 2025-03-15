-- Truy vấn này phân tích doanh thu của các mặt hàng thuộc 3 danh mục: Jewelry, Sports và Books.
-- Tính tỷ lệ doanh thu của từng mặt hàng so với tổng doanh thu trong cùng một nhóm class.
-- Input: Bảng store_sales, item, date_dim
-- Output: Chi tiết các mặt hàng kèm theo doanh thu và tỷ lệ doanh thu trong nhóm
-- Điều kiện: Chỉ xét các giao dịch trong khoảng 30 ngày kể từ 2001-01-12
select
	i_item_id,
	i_item_desc,
	i_category,
	i_class,
	i_current_price,
	sum(ss_ext_sales_price) as itemrevenue,
	sum(ss_ext_sales_price) * 100 / sum(sum(ss_ext_sales_price)) over (
		partition by
			i_class
	) as revenueratio
from
	store_sales,
	item,
	date_dim
where
	ss_item_sk = i_item_sk
	and i_category in ('Jewelry', 'Sports', 'Books')
	and ss_sold_date_sk = d_date_sk
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
	revenueratio;