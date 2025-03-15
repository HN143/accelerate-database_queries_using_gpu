-- Query Description:
-- Truy vấn này phân tích doanh số bán hàng của các sản phẩm từ một nhà sản xuất cụ thể.
-- Chi tiết:
-- 1. Chỉ xem xét các mặt hàng từ nhà sản xuất có ID là 436
-- 2. Giới hạn trong tháng 12 của các năm
-- 3. Tính tổng doanh số theo năm, ID thương hiệu và tên thương hiệu
-- 4. Sắp xếp kết quả theo:
--    - Năm
--    - Tổng doanh số (giảm dần)
--    - ID thương hiệu
-- 5. Giới hạn 100 kết quả
-- Bảng sử dụng: date_dim, store_sales, item
select
	dt.d_year,
	item.i_brand_id brand_id,
	item.i_brand brand,
	sum(ss_ext_sales_price) sum_agg
from
	date_dim dt,
	store_sales,
	item
where
	dt.d_date_sk = store_sales.ss_sold_date_sk
	and store_sales.ss_item_sk = item.i_item_sk
	and item.i_manufact_id = 436
	and dt.d_moy = 12
group by
	dt.d_year,
	item.i_brand,
	item.i_brand_id
order by
	dt.d_year,
	sum_agg desc,
	brand_id
limit
	100;