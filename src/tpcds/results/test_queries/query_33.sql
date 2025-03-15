/*
Mô tả: Query này phân tích tổng doanh số bán hàng của các nhà sản xuất trong danh mục Sách.

Bảng sử dụng:
- store_sales: Doanh số bán hàng tại cửa hàng
- catalog_sales: Doanh số bán hàng qua catalog
- web_sales: Doanh số bán hàng trực tuyến
- date_dim: Thông tin thời gian
- customer_address: Thông tin địa chỉ khách hàng
- item: Thông tin sản phẩm

Điều kiện:
- Danh mục sản phẩm: Sách
- Thời gian: Tháng 3 năm 1999
- Múi giờ khách hàng: GMT-5
- Tổng hợp theo nhà sản xuất
*/
with
	ss as (
		select
			i_manufact_id,
			sum(ss_ext_sales_price) total_sales
		from
			store_sales,
			date_dim,
			customer_address,
			item
		where
			i_manufact_id in (
				select
					i_manufact_id
				from
					item
				where
					i_category in ('Books')
			)
			and ss_item_sk = i_item_sk
			and ss_sold_date_sk = d_date_sk
			and d_year = 1999
			and d_moy = 3
			and ss_addr_sk = ca_address_sk
			and ca_gmt_offset = -5
		group by
			i_manufact_id
	),
	cs as (
		select
			i_manufact_id,
			sum(cs_ext_sales_price) total_sales
		from
			catalog_sales,
			date_dim,
			customer_address,
			item
		where
			i_manufact_id in (
				select
					i_manufact_id
				from
					item
				where
					i_category in ('Books')
			)
			and cs_item_sk = i_item_sk
			and cs_sold_date_sk = d_date_sk
			and d_year = 1999
			and d_moy = 3
			and cs_bill_addr_sk = ca_address_sk
			and ca_gmt_offset = -5
		group by
			i_manufact_id
	),
	ws as (
		select
			i_manufact_id,
			sum(ws_ext_sales_price) total_sales
		from
			web_sales,
			date_dim,
			customer_address,
			item
		where
			i_manufact_id in (
				select
					i_manufact_id
				from
					item
				where
					i_category in ('Books')
			)
			and ws_item_sk = i_item_sk
			and ws_sold_date_sk = d_date_sk
			and d_year = 1999
			and d_moy = 3
			and ws_bill_addr_sk = ca_address_sk
			and ca_gmt_offset = -5
		group by
			i_manufact_id
	)
select
	i_manufact_id,
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
	i_manufact_id
order by
	total_sales
limit
	100;