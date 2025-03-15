/*
Query này thực hiện:
- Phân tích doanh số bán hàng tại cửa hàng (store_sales) theo thương hiệu
- Chỉ xét các sản phẩm:
+ Thuộc về người quản lý có mã 36
+ Bán trong tháng 12 năm 2001
- Kết quả được nhóm theo:
+ Mã thương hiệu
+ Tên thương hiệu
- Sắp xếp theo:
+ Doanh số (giảm dần)
+ Mã thương hiệu
*/
select
	i_brand_id brand_id,
	i_brand brand,
	sum(ss_ext_sales_price) ext_price
from
	date_dim,
	store_sales,
	item
where
	d_date_sk = ss_sold_date_sk
	and ss_item_sk = i_item_sk
	and i_manager_id = 36
	and d_moy = 12
	and d_year = 2001
group by
	i_brand,
	i_brand_id
order by
	ext_price desc,
	i_brand_id
limit
	100;