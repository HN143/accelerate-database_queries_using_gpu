-- Truy vấn này phân tích thời gian trả hàng tại cửa hàng:
-- 1. Thống kê số lượng đơn trả hàng theo các khoảng thời gian:
--    - Trong vòng 30 ngày
--    - 31-60 ngày
--    - 61-90 ngày
--    - 91-120 ngày
--    - Trên 120 ngày
-- 2. Tính từ ngày mua hàng đến ngày trả
-- 3. Chỉ xét các đơn trả hàng trong tháng 9 năm 2000
-- 4. Nhóm theo thông tin chi tiết của cửa hàng
-- Kết quả hiển thị phân bố thời gian trả hàng cho từng cửa hàng
select
	s_store_name,
	s_company_id,
	s_street_number,
	s_street_name,
	s_street_type,
	s_suite_number,
	s_city,
	s_county,
	s_state,
	s_zip,
	sum(
		case
			when (sr_returned_date_sk - ss_sold_date_sk <= 30) then 1
			else 0
		end
	) as "30 days",
	sum(
		case
			when (sr_returned_date_sk - ss_sold_date_sk > 30)
			and (sr_returned_date_sk - ss_sold_date_sk <= 60) then 1
			else 0
		end
	) as "31-60 days",
	sum(
		case
			when (sr_returned_date_sk - ss_sold_date_sk > 60)
			and (sr_returned_date_sk - ss_sold_date_sk <= 90) then 1
			else 0
		end
	) as "61-90 days",
	sum(
		case
			when (sr_returned_date_sk - ss_sold_date_sk > 90)
			and (sr_returned_date_sk - ss_sold_date_sk <= 120) then 1
			else 0
		end
	) as "91-120 days",
	sum(
		case
			when (sr_returned_date_sk - ss_sold_date_sk > 120) then 1
			else 0
		end
	) as ">120 days"
from
	store_sales,
	store_returns,
	store,
	date_dim d1,
	date_dim d2
where
	d2.d_year = 2000
	and d2.d_moy = 9
	and ss_ticket_number = sr_ticket_number
	and ss_item_sk = sr_item_sk
	and ss_sold_date_sk = d1.d_date_sk
	and sr_returned_date_sk = d2.d_date_sk
	and ss_customer_sk = sr_customer_sk
	and ss_store_sk = s_store_sk
group by
	s_store_name,
	s_company_id,
	s_street_number,
	s_street_name,
	s_street_type,
	s_suite_number,
	s_city,
	s_county,
	s_state,
	s_zip
order by
	s_store_name,
	s_company_id,
	s_street_number,
	s_street_name,
	s_street_type,
	s_suite_number,
	s_city,
	s_county,
	s_state,
	s_zip
limit
	100;