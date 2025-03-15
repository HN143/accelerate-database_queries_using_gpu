-- Mô tả:
-- Truy vấn này phân tích chi tiết về số lượng sản phẩm trong:
-- 1. Bán hàng tại cửa hàng (store_sales)
-- 2. Trả hàng tại cửa hàng (store_returns)
-- 3. Bán hàng qua catalog (catalog_sales)
-- Cho từng sản phẩm và từng tiểu bang, tính các chỉ số:
-- - Số lượng giao dịch (count)
-- - Số lượng trung bình (average)
-- - Độ lệch chuẩn (standard deviation)
-- - Hệ số biến thiên (coefficient of variation)
-- Dữ liệu được lấy trong quý 1/1998 và có liên kết giữa việc mua hàng, trả hàng và mua qua catalog của cùng một khách hàng
select
	i_item_id,
	i_item_desc,
	s_state,
	count(ss_quantity) as store_sales_quantitycount,
	avg(ss_quantity) as store_sales_quantityave,
	stddev_samp(ss_quantity) as store_sales_quantitystdev,
	stddev_samp(ss_quantity) / avg(ss_quantity) as store_sales_quantitycov,
	count(sr_return_quantity) as store_returns_quantitycount,
	avg(sr_return_quantity) as store_returns_quantityave,
	stddev_samp(sr_return_quantity) as store_returns_quantitystdev,
	stddev_samp(sr_return_quantity) / avg(sr_return_quantity) as store_returns_quantitycov,
	count(cs_quantity) as catalog_sales_quantitycount,
	avg(cs_quantity) as catalog_sales_quantityave,
	stddev_samp(cs_quantity) as catalog_sales_quantitystdev,
	stddev_samp(cs_quantity) / avg(cs_quantity) as catalog_sales_quantitycov
from
	store_sales,
	store_returns,
	catalog_sales,
	date_dim d1,
	date_dim d2,
	date_dim d3,
	store,
	item
where
	d1.d_quarter_name = '1998Q1'
	and d1.d_date_sk = ss_sold_date_sk
	and i_item_sk = ss_item_sk
	and s_store_sk = ss_store_sk
	and ss_customer_sk = sr_customer_sk
	and ss_item_sk = sr_item_sk
	and ss_ticket_number = sr_ticket_number
	and sr_returned_date_sk = d2.d_date_sk
	and d2.d_quarter_name in ('1998Q1', '1998Q2', '1998Q3')
	and sr_customer_sk = cs_bill_customer_sk
	and sr_item_sk = cs_item_sk
	and cs_sold_date_sk = d3.d_date_sk
	and d3.d_quarter_name in ('1998Q1', '1998Q2', '1998Q3')
group by
	i_item_id,
	i_item_desc,
	s_state
order by
	i_item_id,
	i_item_desc,
	s_state
limit
	100;