-- Truy vấn này phân tích tổng doanh số bán hàng theo danh mục:
-- 1. Chỉ xét các mặt hàng do quản lý có mã số 1 phụ trách
-- 2. Thời gian: tháng 12 năm 1998
-- 3. Nhóm theo năm, mã danh mục và tên danh mục
-- 4. Tính tổng giá trị bán hàng mở rộng (ss_ext_sales_price)
-- Kết quả được sắp xếp theo tổng doanh số giảm dần
select
	dt.d_year,
	item.i_category_id,
	item.i_category,
	sum(ss_ext_sales_price)
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
	item.i_category_id,
	item.i_category
order by
	sum(ss_ext_sales_price) desc,
	dt.d_year,
	item.i_category_id,
	item.i_category
limit
	100;