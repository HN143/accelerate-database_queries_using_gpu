/*
Mô tả: Query này phân tích các khoản chiết khấu bất thường trong bán hàng qua catalog.

Bảng sử dụng:
- catalog_sales: Doanh số bán hàng qua catalog
- item: Thông tin sản phẩm
- date_dim: Thông tin thời gian

Điều kiện:
- Nhà sản xuất có ID = 269
- Thời gian từ 1998-03-18 đến 90 ngày sau
- Chiết khấu vượt quá 30% so với mức trung bình
*/
select
	sum(cs_ext_discount_amt) as "excess discount amount"
from
	catalog_sales,
	item,
	date_dim
where
	i_manufact_id = 269
	and i_item_sk = cs_item_sk
	and d_date between '1998-03-18' and (cast('1998-03-18' as date) + 90 days)
	and d_date_sk = cs_sold_date_sk
	and cs_ext_discount_amt > (
		select
			1.3 * avg(cs_ext_discount_amt)
		from
			catalog_sales,
			date_dim
		where
			cs_item_sk = i_item_sk
			and d_date between '1998-03-18' and (cast('1998-03-18' as date) + 90 days)
			and d_date_sk = cs_sold_date_sk
	)
limit
	100;