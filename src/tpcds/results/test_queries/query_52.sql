-- Mô tả: Truy vấn này tính tổng doanh thu (ext_price) của từng thương hiệu (brand)
-- do người quản lý có id=1 phụ trách trong tháng 12 năm 1998.
-- Kết quả được sắp xếp theo doanh thu giảm dần.
select
	dt.d_year,
	item.i_brand_id brand_id,
	item.i_brand brand,
	sum(ss_ext_sales_price) ext_price
from
	date_dim dt,
	store_sales,
	item
where
	dt.d_date_sk = store_sales.ss_sold_date_sk
	and store_sales.ss_item_sk = item.i_item_sk
	and item.i_manager_id = 1
	and dt.d_moy = 12
	and dt.d_year = 1998
group by
	dt.d_year,
	item.i_brand,
	item.i_brand_id
order by
	dt.d_year,
	ext_price desc,
	brand_id
limit
	100;