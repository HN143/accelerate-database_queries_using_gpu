-- Mô tả:
-- Truy vấn này phân tích doanh số bán hàng tại cửa hàng theo thương hiệu và nhà sản xuất:
-- Tính tổng doanh thu (ext_price) cho từng:
-- 1. ID thương hiệu
-- 2. Tên thương hiệu
-- 3. ID nhà sản xuất
-- 4. Tên nhà sản xuất
-- Với các điều kiện:
-- - Người quản lý sản phẩm có ID = 7
-- - Thời gian: tháng 11/1999
-- - Khách hàng mua ở cửa hàng có mã ZIP khác với mã ZIP nơi họ ở
-- Kết quả sắp xếp theo doanh thu giảm dần
select
	i_brand_id brand_id,
	i_brand brand,
	i_manufact_id,
	i_manufact,
	sum(ss_ext_sales_price) ext_price
from
	date_dim,
	store_sales,
	item,
	customer,
	customer_address,
	store
where
	d_date_sk = ss_sold_date_sk
	and ss_item_sk = i_item_sk
	and i_manager_id = 7
	and d_moy = 11
	and d_year = 1999
	and ss_customer_sk = c_customer_sk
	and c_current_addr_sk = ca_address_sk
	and substr (ca_zip, 1, 5) <> substr (s_zip, 1, 5)
	and ss_store_sk = s_store_sk
group by
	i_brand,
	i_brand_id,
	i_manufact_id,
	i_manufact
order by
	ext_price desc,
	i_brand,
	i_brand_id,
	i_manufact_id,
	i_manufact
limit
	100;