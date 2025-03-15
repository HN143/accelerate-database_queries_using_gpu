-- Truy vấn này phân tích hành vi mua sắm của khách hàng trên 2 kênh: cửa hàng (store) và catalog.
-- Thống kê số lượng khách hàng theo 3 nhóm:
-- 1. Chỉ mua tại cửa hàng (store_only)
-- 2. Chỉ mua qua catalog (catalog_only)
-- 3. Mua cả hai kênh (store_and_catalog)
-- Input: Bảng store_sales, catalog_sales, date_dim
-- Output: Số lượng khách hàng cho mỗi nhóm
with
	ssci as (
		select
			ss_customer_sk customer_sk,
			ss_item_sk item_sk
		from
			store_sales,
			date_dim
		where
			ss_sold_date_sk = d_date_sk
			and d_month_seq between 1212 and 1212  + 11
		group by
			ss_customer_sk,
			ss_item_sk
	),
	csci as (
		select
			cs_bill_customer_sk customer_sk,
			cs_item_sk item_sk
		from
			catalog_sales,
			date_dim
		where
			cs_sold_date_sk = d_date_sk
			and d_month_seq between 1212 and 1212  + 11
		group by
			cs_bill_customer_sk,
			cs_item_sk
	)
select
	sum(
		case
			when ssci.customer_sk is not null
			and csci.customer_sk is null then 1
			else 0
		end
	) store_only,
	sum(
		case
			when ssci.customer_sk is null
			and csci.customer_sk is not null then 1
			else 0
		end
	) catalog_only,
	sum(
		case
			when ssci.customer_sk is not null
			and csci.customer_sk is not null then 1
			else 0
		end
	) store_and_catalog
from
	ssci
	full outer join csci on (
		ssci.customer_sk = csci.customer_sk
		and ssci.item_sk = csci.item_sk
	)
limit
	100;