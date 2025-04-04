/*
Query này thực hiện:
- Phân tích tổng doanh số bán hàng của các sản phẩm có màu: orchid, chiffon, lace
- Tổng hợp doanh số từ 3 kênh bán hàng:
+ Cửa hàng (store_sales)
+ Catalog (catalog_sales)
+ Website (web_sales)
- Chỉ xét các giao dịch:
+ Thời gian: tháng 1 năm 2000
+ Múi giờ của khách hàng: GMT-8
- Kết quả được sắp xếp theo:
+ Tổng doanh số
+ Mã sản phẩm
*/
with
	ss as (
		select
			i_item_id,
			sum(ss_ext_sales_price) total_sales
		from
			store_sales,
			date_dim,
			customer_address,
			item
		where
			i_item_id in (
				select
					i_item_id
				from
					item
				where
					i_color in ('orchid', 'chiffon', 'lace')
			)
			and ss_item_sk = i_item_sk
			and ss_sold_date_sk = d_date_sk
			and d_year = 2000
			and d_moy = 1
			and ss_addr_sk = ca_address_sk
			and ca_gmt_offset = -8
		group by
			i_item_id
	),
	cs as (
		select
			i_item_id,
			sum(cs_ext_sales_price) total_sales
		from
			catalog_sales,
			date_dim,
			customer_address,
			item
		where
			i_item_id in (
				select
					i_item_id
				from
					item
				where
					i_color in ('orchid', 'chiffon', 'lace')
			)
			and cs_item_sk = i_item_sk
			and cs_sold_date_sk = d_date_sk
			and d_year = 2000
			and d_moy = 1
			and cs_bill_addr_sk = ca_address_sk
			and ca_gmt_offset = -8
		group by
			i_item_id
	),
	ws as (
		select
			i_item_id,
			sum(ws_ext_sales_price) total_sales
		from
			web_sales,
			date_dim,
			customer_address,
			item
		where
			i_item_id in (
				select
					i_item_id
				from
					item
				where
					i_color in ('orchid', 'chiffon', 'lace')
			)
			and ws_item_sk = i_item_sk
			and ws_sold_date_sk = d_date_sk
			and d_year = 2000
			and d_moy = 1
			and ws_bill_addr_sk = ca_address_sk
			and ca_gmt_offset = -8
		group by
			i_item_id
	)
select
	i_item_id,
	sum(total_sales) total_sales
from
	(
		select
			*
		from
			ss
		union all
		select
			*
		from
			cs
		union all
		select
			*
		from
			ws
	) tmp1
group by
	i_item_id
order by
	total_sales,
	i_item_id
limit
	100;